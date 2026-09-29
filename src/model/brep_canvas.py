"""Feature encoder seam for future B-Rep/NURBS representations."""

from __future__ import annotations

import torch
from torch import nn

from src.model.device import DeviceAwareModule, align_tensor
from src.model.latent_bridge import CANVAS_DIM


class BRepCanvas(DeviceAwareModule):
    """Pool per-face/edge descriptors into the shared 512-dimensional canvas."""

    def __init__(self, feature_dim: int = 32, canvas_dim: int = CANVAS_DIM) -> None:
        super().__init__()
        if canvas_dim != CANVAS_DIM:
            raise ValueError(f"BRepCanvas latent width is fixed at {CANVAS_DIM}")
        self.feature_dim = feature_dim
        self.canvas_dim = canvas_dim
        self.encoder = nn.Sequential(nn.Linear(feature_dim, 128), nn.SiLU(), nn.Linear(128, canvas_dim))

    def forward(self, entity_features: torch.Tensor, entity_mask: torch.Tensor | None = None) -> torch.Tensor:
        if entity_features.ndim != 3 or entity_features.shape[-1] != self.feature_dim:
            raise ValueError(
                f"BRepCanvas expects (batch, entities, {self.feature_dim}), got {tuple(entity_features.shape)}"
            )
        encoded = self.encoder(align_tensor(entity_features, self.encoder))
        if entity_mask is not None:
            mask = entity_mask.to(device=encoded.device, dtype=encoded.dtype).unsqueeze(-1)
            encoded = encoded * mask
            denominator = mask.sum(dim=1).clamp_min(1.0)
            return encoded.sum(dim=1) / denominator
        return encoded.mean(dim=1)
