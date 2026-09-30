"""A compact 3D CoordConv residual canvas mapping 512-vectors to 512-vectors."""

from __future__ import annotations

import torch
from torch import nn

from src.model.device import DeviceAwareModule, align_tensor
from src.model.latent_bridge import CANVAS_DIM


class CoordConv3D(nn.Module):
    """Append normalized XYZ coordinate channels before a 3D convolution."""

    def __init__(self, in_channels: int = 32, out_channels: int = 32) -> None:
        super().__init__()
        self.in_channels = in_channels
        self.conv = nn.Conv3d(in_channels + 3, out_channels, kernel_size=3, padding=1)

    def forward(self, features: torch.Tensor) -> torch.Tensor:
        batch, _, depth, height, width = features.shape
        z = torch.linspace(-1.0, 1.0, depth, device=features.device, dtype=features.dtype)
        y = torch.linspace(-1.0, 1.0, height, device=features.device, dtype=features.dtype)
        x = torch.linspace(-1.0, 1.0, width, device=features.device, dtype=features.dtype)
        zz, yy, xx = torch.meshgrid(z, y, x, indexing="ij")
        coords = torch.stack((xx, yy, zz), dim=0).unsqueeze(0).expand(batch, -1, -1, -1, -1)
        return self.conv(torch.cat((features, coords), dim=1))


class ResidualBlock3D(nn.Module):
    def __init__(self, channels: int = 32, groups: int = 4) -> None:
        super().__init__()
        self.layers = nn.Sequential(
            nn.Conv3d(channels, channels, kernel_size=3, padding=1),
            nn.GroupNorm(groups, channels),
            nn.SiLU(),
            nn.Conv3d(channels, channels, kernel_size=3, padding=1),
            nn.GroupNorm(groups, channels),
        )
        self.activation = nn.SiLU()

    def forward(self, x: torch.Tensor) -> torch.Tensor:
        return self.activation(x + self.layers(x))


class VoxelCanvas(DeviceAwareModule):
    """Voxel feature canvas with a 16-cubed grid and three residual stages."""

    def __init__(self, canvas_dim: int = CANVAS_DIM, channels: int = 32, grid_size: int = 16) -> None:
        super().__init__()
        if canvas_dim != CANVAS_DIM:
            raise ValueError(f"VoxelCanvas latent width is fixed at {CANVAS_DIM}")
        if channels != 32 or grid_size != 16:
            raise ValueError("VoxelCanvas architecture is fixed at 32 channels on a 16^3 grid")
        self.canvas_dim = canvas_dim
        self.channels = channels
        self.grid_size = grid_size
        self.expand = nn.Linear(canvas_dim, channels * grid_size**3)
        self.coord_conv = CoordConv3D(channels, channels)
        self.blocks = nn.Sequential(*(ResidualBlock3D(channels) for _ in range(3)))
        self.pool = nn.AdaptiveAvgPool3d(1)
        self.project = nn.Linear(channels, canvas_dim)
        # Occupancy head for the auxiliary loss (ARCHITECTURE.md section 6):
        # BCEWithLogits over the 16^3 grid against a voxelized STL reference.
        # Runs only on the training path, never in plain inference.
        self.occupancy = nn.Conv3d(channels, 1, kernel_size=1)

    def _volume(self, latent: torch.Tensor) -> torch.Tensor:
        if latent.ndim != 2 or latent.shape[-1] != self.canvas_dim:
            raise ValueError(f"VoxelCanvas expects (batch, {self.canvas_dim}), got {tuple(latent.shape)}")
        z = align_tensor(latent, self.expand)
        volume = self.expand(z).reshape(
            z.shape[0], self.channels, self.grid_size, self.grid_size, self.grid_size
        )
        volume = torch.nn.functional.silu(self.coord_conv(volume))
        return self.blocks(volume)

    def forward(self, latent: torch.Tensor) -> torch.Tensor:
        """Pooled 512-wide canvas output (unchanged contract for the bridge)."""
        volume = self._volume(latent)
        pooled = self.pool(volume).flatten(start_dim=1)
        return self.project(pooled)

    def forward_with_grid(self, latent: torch.Tensor) -> tuple[torch.Tensor, torch.Tensor]:
        """Return ``(z_out, occupancy_logits(B,16,16,16))`` for auxiliary supervision."""
        volume = self._volume(latent)
        pooled = self.pool(volume).flatten(start_dim=1)
        return self.project(pooled), self.occupancy(volume).squeeze(1)
