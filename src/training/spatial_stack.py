"""Trainable spatial stack: one In-Projector/Canvas/Out-Projector bundle per layer.

Mirrors ARCHITECTURE.md section 5: every spatial layer owns an isolated
``ScaleMLP_X -> In-Projector_X -> Canvas_X -> Out-Projector_X`` path plus a
dedicated LoRA adapter on the frozen backbone (adapters live in the
PEFT-wrapped backbone and are therefore not part of this state). Each bundle
owns a private ``ScaleMLP`` encoding ``log(target_bbox)`` so that training one
layer can never perturb another layer's gradient path.

Latent-driven canvases (voxel, wire) consume ``z_in`` directly. Encoder-style
canvases (sketch, brep, assembly) consume structured rasters/features, so the
bundle forwards those raw inputs while the projectors still bound the path.
"""

from __future__ import annotations

from typing import Any

import torch
from torch import nn

from src.model.assembly_canvas import AssemblyCanvas
from src.model.brep_canvas import BRepCanvas
from src.model.device import DeviceAwareModule
from src.model.latent_bridge import InProjector, OutProjector, ScaleMLP
from src.model.sketch_canvas import SketchCanvas
from src.model.voxel_canvas import VoxelCanvas
from src.model.wire_canvas import WireCanvas

CANVAS_REGISTRY: dict[str, type[nn.Module]] = {
    "voxel": VoxelCanvas,
    "wire": WireCanvas,
    "sketch": SketchCanvas,
    "brep": BRepCanvas,
    "assembly": AssemblyCanvas,
}

# Canvases whose forward input is the projected 512-wide latent itself.
LATENT_DRIVEN = frozenset({"voxel", "wire"})


class CanvasBundle(DeviceAwareModule):
    """Isolated trainable path for one spatial layer."""

    def __init__(self, layer: str) -> None:
        super().__init__()
        if layer not in CANVAS_REGISTRY:
            raise ValueError(f"unknown spatial layer {layer!r}; expected one of {sorted(CANVAS_REGISTRY)}")
        self.layer = layer
        self.scale_mlp = ScaleMLP()
        self.in_projector = InProjector()
        self.canvas = CANVAS_REGISTRY[layer]()
        self.out_projector = OutProjector()

    def forward(
        self,
        llm_hidden: torch.Tensor,
        log_bbox: torch.Tensor,
        canvas_args: tuple[torch.Tensor, ...] = (),
        canvas_kwargs: dict[str, Any] | None = None,
    ) -> torch.Tensor:
        scale_embedding = self.scale_mlp.forward_log_bbox(log_bbox)
        z_in = self.in_projector(llm_hidden, scale_embedding)
        if self.layer in LATENT_DRIVEN:
            canvas_out = self.canvas(z_in)
        else:
            if not canvas_args:
                raise ValueError(f"layer {self.layer!r} requires raw canvas inputs (canvas_args)")
            canvas_out = self.canvas(*canvas_args, **(canvas_kwargs or {}))
        return self.out_projector(canvas_out)


class SpatialStack(DeviceAwareModule):
    """All trainable canvas bundles.

    Initialization order is deterministic for a fixed torch seed: bundles are
    created in ``CANVAS_REGISTRY`` order. The zero point therefore reproduces
    bit-identical initial weights on any machine.
    """

    def __init__(self, layers: tuple[str, ...] | None = None) -> None:
        super().__init__()
        requested = layers if layers is not None else tuple(CANVAS_REGISTRY)
        for layer in requested:
            if layer not in CANVAS_REGISTRY:
                raise ValueError(f"unknown spatial layer {layer!r}; expected one of {sorted(CANVAS_REGISTRY)}")
        self.layers = tuple(requested)
        self.bundles = nn.ModuleDict({layer: CanvasBundle(layer) for layer in self.layers})

    def forward_layer(
        self,
        layer: str,
        llm_hidden: torch.Tensor,
        log_bbox: torch.Tensor,
        canvas_args: tuple[torch.Tensor, ...] = (),
        canvas_kwargs: dict[str, Any] | None = None,
    ) -> torch.Tensor:
        """Residual spatial vector h_spatial for one layer (added to h_mid by the hook)."""
        if layer not in self.layers:
            raise ValueError(f"layer {layer!r} is not part of this stack: {self.layers}")
        return self.bundles[layer](
            llm_hidden, log_bbox, canvas_args=canvas_args, canvas_kwargs=canvas_kwargs
        )

    def trainable_parameters(self, layer: str | None = None) -> list[nn.Parameter]:
        """Parameters of one bundle (or the whole stack) for isolated gradient steps."""
        module: nn.Module = self if layer is None else self.bundles[layer]
        return [parameter for parameter in module.parameters() if parameter.requires_grad]
