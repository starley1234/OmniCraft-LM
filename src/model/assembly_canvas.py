"""SE(3)-transform-tree encoder for component assembly features."""

from __future__ import annotations

import torch
from torch import nn

from src.model.device import DeviceAwareModule, align_tensor
from src.model.latent_bridge import CANVAS_DIM


class AssemblyCanvas(DeviceAwareModule):
    """Encode batches of homogeneous transforms, optionally with node masks."""

    def __init__(self, canvas_dim: int = CANVAS_DIM) -> None:
        super().__init__()
        if canvas_dim != CANVAS_DIM:
            raise ValueError(f"AssemblyCanvas latent width is fixed at {CANVAS_DIM}")
        self.canvas_dim = canvas_dim
        self.encoder = nn.Sequential(nn.Linear(16, 128), nn.SiLU(), nn.Linear(128, canvas_dim))

    def forward(self, transforms: torch.Tensor, node_mask: torch.Tensor | None = None) -> torch.Tensor:
        if transforms.ndim != 4 or transforms.shape[-2:] != (4, 4):
            raise ValueError(f"transforms must have shape (batch, nodes, 4, 4), got {tuple(transforms.shape)}")
        batch = transforms.shape[0]
        flat = transforms.reshape(batch, transforms.shape[1], 16)
        encoded = self.encoder(align_tensor(flat, self.encoder))
        if node_mask is not None:
            mask = node_mask.to(device=encoded.device, dtype=encoded.dtype).unsqueeze(-1)
            encoded = encoded * mask
            return encoded.sum(dim=1) / mask.sum(dim=1).clamp_min(1.0)
        return encoded.mean(dim=1)
