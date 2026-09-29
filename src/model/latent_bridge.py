"""Fixed-width bridge between the Qwen backbone and spatial canvases."""

from __future__ import annotations

import torch
from torch import nn

from src.model.device import DeviceAwareModule, align_tensor

LLM_DIM = 2048
CANVAS_DIM = 512
SCALE_DIM = 128


class ScaleMLP(DeviceAwareModule):
    """Encode positive target dimensions via ``MLP(log(target_bbox))``."""

    def __init__(self, hidden_dim: int = 64, output_dim: int = SCALE_DIM) -> None:
        super().__init__()
        if hidden_dim != 64 or output_dim != SCALE_DIM:
            raise ValueError("ScaleMLP dimensions are fixed by the architecture: 3 -> 64 -> 128")
        self.network = nn.Sequential(
            nn.Linear(3, hidden_dim),
            nn.SiLU(),
            nn.Linear(hidden_dim, output_dim),
        )

    def forward(self, target_bbox: torch.Tensor) -> torch.Tensor:
        if target_bbox.shape[-1] != 3:
            raise ValueError(f"target_bbox must end in 3 dimensions, got {tuple(target_bbox.shape)}")
        bbox = align_tensor(target_bbox, self.network)
        if torch.any(bbox <= 0):
            raise ValueError("target_bbox dimensions must be positive")
        return self.network(torch.log(bbox))

    def forward_log_bbox(self, log_bbox: torch.Tensor) -> torch.Tensor:
        """Encode precomputed log dimensions, e.g. from a collated dataset batch."""
        if log_bbox.shape[-1] != 3:
            raise ValueError(f"log_bbox must end in 3 dimensions, got {tuple(log_bbox.shape)}")
        return self.network(align_tensor(log_bbox, self.network))


class InProjector(DeviceAwareModule):
    """Fuse a 2048-wide language state and 128-wide scale feature into 512."""

    def __init__(
        self,
        llm_dim: int = LLM_DIM,
        scale_dim: int = SCALE_DIM,
        canvas_dim: int = CANVAS_DIM,
    ) -> None:
        super().__init__()
        if (llm_dim, scale_dim, canvas_dim) != (LLM_DIM, SCALE_DIM, CANVAS_DIM):
            raise ValueError("InProjector dimensions are fixed at (2048 + 128) -> 512")
        self.llm_dim = llm_dim
        self.scale_dim = scale_dim
        self.canvas_dim = canvas_dim
        self.projection = nn.Linear(llm_dim + scale_dim, canvas_dim)

    def forward(self, llm_hidden: torch.Tensor, scale_embedding: torch.Tensor) -> torch.Tensor:
        if llm_hidden.shape[-1] != self.llm_dim:
            raise ValueError(f"expected language width {self.llm_dim}, got {llm_hidden.shape[-1]}")
        if scale_embedding.shape[-1] != self.scale_dim:
            raise ValueError(f"expected scale width {self.scale_dim}, got {scale_embedding.shape[-1]}")
        hidden = align_tensor(llm_hidden, self.projection)
        scale = scale_embedding.to(device=hidden.device, dtype=hidden.dtype)
        if hidden.shape[:-1] != scale.shape[:-1]:
            raise ValueError("language and scale tensors must have matching leading dimensions")
        return self.projection(torch.cat((hidden, scale), dim=-1))


class OutProjector(DeviceAwareModule):
    """Map the fixed 512-wide canvas representation back to Qwen hidden width."""

    def __init__(self, canvas_dim: int = CANVAS_DIM, llm_dim: int = LLM_DIM) -> None:
        super().__init__()
        if (canvas_dim, llm_dim) != (CANVAS_DIM, LLM_DIM):
            raise ValueError("OutProjector dimensions are fixed at 512 -> 2048")
        self.canvas_dim = canvas_dim
        self.llm_dim = llm_dim
        self.projection = nn.Linear(canvas_dim, llm_dim)

    def forward(self, canvas_latent: torch.Tensor) -> torch.Tensor:
        if canvas_latent.shape[-1] != self.canvas_dim:
            raise ValueError(f"expected canvas width {self.canvas_dim}, got {canvas_latent.shape[-1]}")
        return self.projection(align_tensor(canvas_latent, self.projection))
