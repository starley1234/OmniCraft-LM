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
        self.pool_projection = nn.Sequential(
            nn.Linear(feature_dim * 2 + 3, canvas_dim),
            nn.SiLU(),
            nn.Linear(canvas_dim, canvas_dim),
        )

    def forward(self, latent: torch.Tensor) -> torch.Tensor:
        if latent.ndim != 2 or latent.shape[-1] != self.canvas_dim:
            raise ValueError(f"WireCanvas expects (batch, {self.canvas_dim}), got {tuple(latent.shape)}")
        z = align_tensor(latent, self.seed_features)
        positions = self.seed_positions(z).reshape(z.shape[0], self.vertex_count, 3)
        features = self.seed_features(z).reshape(z.shape[0], self.vertex_count, self.feature_dim)
        for edge_conv in self.edge_convs:
            features = edge_conv(features)
        pooled = torch.cat((features.max(dim=1).values, features.mean(dim=1), positions.mean(dim=1)), dim=-1)
        return self.pool_projection(pooled)
