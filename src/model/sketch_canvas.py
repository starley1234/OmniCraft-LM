"""2D residual CNN for sketch planes, profiles, and cross-sections."""

from __future__ import annotations

import torch
from torch import nn

from src.model.device import DeviceAwareModule, align_tensor
from src.model.latent_bridge import CANVAS_DIM


class ResidualBlock2D(nn.Module):
    def __init__(self, channels: int = 32, groups: int = 4) -> None:
        super().__init__()
        self.block = nn.Sequential(
            nn.Conv2d(channels, channels, 3, padding=1),
            nn.GroupNorm(groups, channels),
            nn.SiLU(),
            nn.Conv2d(channels, channels, 3, padding=1),
            nn.GroupNorm(groups, channels),
        )
        self.activation = nn.SiLU()

    def forward(self, x: torch.Tensor) -> torch.Tensor:
        return self.activation(x + self.block(x))


class SketchCanvas(DeviceAwareModule):
    """Encode ``(B, planes, H, W)`` sketch rasters into the fixed 512 latent."""

    def __init__(self, input_channels: int = 16, canvas_dim: int = CANVAS_DIM, channels: int = 32) -> None:
        super().__init__()
        if canvas_dim != CANVAS_DIM:
            raise ValueError(f"SketchCanvas latent width is fixed at {CANVAS_DIM}")
        self.input_channels = input_channels
        self.canvas_dim = canvas_dim
        self.stem = nn.Sequential(
            nn.Conv2d(input_channels, channels, kernel_size=3, padding=1),
            nn.GroupNorm(4, channels),
            nn.SiLU(),
        )
        self.blocks = nn.Sequential(*(ResidualBlock2D(channels) for _ in range(3)))
        self.pool = nn.AdaptiveAvgPool2d(1)
        self.project = nn.Linear(channels, canvas_dim)

    def forward(self, profiles: torch.Tensor) -> torch.Tensor:
        if profiles.ndim != 4 or profiles.shape[1] != self.input_channels:
            raise ValueError(
                f"SketchCanvas expects (batch, {self.input_channels}, H, W), got {tuple(profiles.shape)}"
            )
        x = self.stem(align_tensor(profiles, self.stem))
        x = self.blocks(x)
        return self.project(self.pool(x).flatten(start_dim=1))
