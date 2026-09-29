"""Differentiable dynamic-graph canvas for wireframes and trusses."""

from __future__ import annotations

import torch
from torch import nn

from src.model.device import DeviceAwareModule, align_tensor
from src.model.latent_bridge import CANVAS_DIM


class EdgeConv(nn.Module):
    """EdgeConv using a per-sample k-nearest-neighbour graph and max pooling."""

    def __init__(self, feature_dim: int, k: int = 8) -> None:
        super().__init__()
        self.k = k
        self.message = nn.Sequential(
            nn.Linear(feature_dim * 2, feature_dim),
            nn.SiLU(),
            nn.Linear(feature_dim, feature_dim),
            nn.SiLU(),
        )

    def forward(self, features: torch.Tensor) -> torch.Tensor:
        batch, vertices, channels = features.shape
        neighbor_count = min(self.k + 1, vertices)
        # Neighbour selection is non-differentiable; float32 distances keep cdist
        # portable on CUDA where bfloat16 kernels may not be available.
        distances = torch.cdist(features.float(), features.float())
        neighbors = distances.topk(neighbor_count, dim=-1, largest=False).indices[..., 1:]
        batch_indices = torch.arange(batch, device=features.device)[:, None, None]
        neighbor_features = features[batch_indices, neighbors]
        center_features = features.unsqueeze(2).expand_as(neighbor_features)
        edge_features = torch.cat((center_features, neighbor_features - center_features), dim=-1)
        messages = self.message(edge_features)
        return torch.maximum(messages.max(dim=2).values, features)


class WireCanvas(DeviceAwareModule):
    """Generate 32 latent vertices, refine them with EdgeConv, and pool to 512."""

    def __init__(
        self,
        canvas_dim: int = CANVAS_DIM,
        vertex_count: int = 32,
        feature_dim: int = 64,
        neighbors: int = 8,
    ) -> None:
        super().__init__()
        if canvas_dim != CANVAS_DIM:
            raise ValueError(f"WireCanvas latent width is fixed at {CANVAS_DIM}")
        if vertex_count != 32:
            raise ValueError("WireCanvas is architecturally fixed at 32 vertices")
        self.canvas_dim = canvas_dim
        self.vertex_count = vertex_count
        self.feature_dim = feature_dim
        self.seed_features = nn.Linear(canvas_dim, vertex_count * feature_dim)
        self.seed_positions = nn.Linear(canvas_dim, vertex_count * 3)
        self.edge_convs = nn.ModuleList(EdgeConv(feature_dim, neighbors) for _ in range(3))
        # Bilateral edge-adjacency predictor (ARCHITECTURE.md 4.2): scores the
        # probability of a structural member between every vertex pair.
        self.edge_head = nn.Sequential(
            nn.Linear(feature_dim * 4, feature_dim * 2),
            nn.SiLU(),
            nn.Linear(feature_dim * 2, 1),
        )
        self.pool_projection = nn.Sequential(
            nn.Linear(feature_dim * 2 + 3, canvas_dim),
            nn.SiLU(),
            nn.Linear(canvas_dim, canvas_dim),
        )

    def _mesh_features(self, latent: torch.Tensor) -> tuple[torch.Tensor, torch.Tensor]:
        if latent.ndim != 2 or latent.shape[-1] != self.canvas_dim:
            raise ValueError(f"WireCanvas expects (batch, {self.canvas_dim}), got {tuple(latent.shape)}")
        z = align_tensor(latent, self.seed_features)
        positions = self.seed_positions(z).reshape(z.shape[0], self.vertex_count, 3)
        features = self.seed_features(z).reshape(z.shape[0], self.vertex_count, self.feature_dim)
        for edge_conv in self.edge_convs:
            features = edge_conv(features)
        return features, positions

    def forward(self, latent: torch.Tensor) -> torch.Tensor:
        """Pooled 512-wide canvas output (unchanged contract for the bridge)."""
        features, positions = self._mesh_features(latent)
        pooled = torch.cat((features.max(dim=1).values, features.mean(dim=1), positions.mean(dim=1)), dim=-1)
        return self.pool_projection(pooled)

    def forward_graph(
        self, latent: torch.Tensor
    ) -> tuple[torch.Tensor, torch.Tensor, torch.Tensor]:
        """Return ``(z_out, positions, edge_logits)`` for auxiliary supervision.

        ``positions`` are the predicted 3D vertices ``(B, 32, 3)``;
        ``edge_logits`` is the symmetric adjacency score matrix ``(B, 32, 32)``.
        The edge head runs only on this training path, never in plain inference.
        """
        features, positions = self._mesh_features(latent)
        left = features.unsqueeze(2).expand(-1, -1, self.vertex_count, -1)
        right = features.unsqueeze(1).expand(-1, self.vertex_count, -1, -1)
        pair = torch.cat((left, right, left * right, (left - right).abs()), dim=-1)
        edge_logits = self.edge_head(pair).squeeze(-1)
        pooled = torch.cat((features.max(dim=1).values, features.mean(dim=1), positions.mean(dim=1)), dim=-1)
        return self.pool_projection(pooled), positions, edge_logits
