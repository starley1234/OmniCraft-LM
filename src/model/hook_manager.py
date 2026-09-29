"""Prefill-only hidden-state injection at the configured Qwen layer (layer 12)."""

from __future__ import annotations

from contextlib import contextmanager
from typing import Iterator

import torch
from torch import nn

from src.model.device import align_tensor
from src.model.latent_bridge import LLM_DIM


class SpatialHookManager:
    """Inject a residual spatial vector only at control tokens during prefill.

    ``input_ids`` and the projected ``spatial_vector`` are supplied for each prefill
    via :meth:`set_context`. Decode calls with sequence length one are transparent.
    """

    def __init__(self, control_token_id: int, layer_index: int = 12) -> None:
        self.control_token_id = control_token_id
        self.layer_index = layer_index
        self._input_ids: torch.Tensor | None = None
        self._spatial_vector: torch.Tensor | None = None
        self._handle: torch.utils.hooks.RemovableHandle | None = None

    def attach(self, layer: nn.Module) -> torch.utils.hooks.RemovableHandle:
        if self._handle is not None:
            self.remove()
        self._handle = layer.register_forward_hook(self._forward_hook)
        return self._handle

    def attach_to_backbone(self, backbone: nn.Module) -> torch.utils.hooks.RemovableHandle:
        """Resolve and attach to the configured layer in common HF Qwen layouts."""
        candidates: list[object] = [backbone]
        for attribute in ("model", "transformer"):
            nested = getattr(backbone, attribute, None)
            if nested is not None:
                candidates.append(nested)
        for candidate in candidates:
            layers = getattr(candidate, "layers", None)
            if layers is not None:
                if self.layer_index < 0 or self.layer_index >= len(layers):
                    raise IndexError(f"backbone has {len(layers)} layers; index {self.layer_index} is invalid")
                return self.attach(layers[self.layer_index])
        raise AttributeError("could not locate backbone layers at .layers, .model.layers, or .transformer.layers")

    def remove(self) -> None:
        if self._handle is not None:
            self._handle.remove()
            self._handle = None

    def set_context(self, input_ids: torch.Tensor, spatial_vector: torch.Tensor) -> None:
        self._input_ids = input_ids
        self._spatial_vector = spatial_vector

    @contextmanager
    def context(self, input_ids: torch.Tensor, spatial_vector: torch.Tensor) -> Iterator[None]:
        previous_ids, previous_vector = self._input_ids, self._spatial_vector
        self.set_context(input_ids, spatial_vector)
        try:
            yield
        finally:
            self._input_ids, self._spatial_vector = previous_ids, previous_vector

    def clear_context(self) -> None:
        self._input_ids = None
        self._spatial_vector = None

    def _forward_hook(self, _module: nn.Module, _inputs: tuple[object, ...], output: object) -> object:
        if self._input_ids is None or self._spatial_vector is None:
            return output
        hidden = output[0] if isinstance(output, tuple) else output
        if not isinstance(hidden, torch.Tensor) or hidden.ndim != 3 or hidden.shape[1] <= 1:
            return output
        if hidden.shape[-1] != LLM_DIM:
            raise ValueError(f"spatial hook expects hidden width {LLM_DIM}, got {hidden.shape[-1]}")
        ids = self._input_ids.to(device=hidden.device)
        if ids.shape[:2] != hidden.shape[:2]:
            raise ValueError("input_ids must match hidden-state batch and sequence dimensions")
        mask = ids.eq(self.control_token_id).unsqueeze(-1)
        if not torch.any(mask):
            return output
        vector = self._spatial_vector.to(device=hidden.device, dtype=hidden.dtype)
        if vector.ndim == 2:
            vector = vector.unsqueeze(1)
        if vector.shape[0] != hidden.shape[0] or vector.shape[-1] != hidden.shape[-1]:
            raise ValueError("spatial_vector must have shape (batch, hidden_width) or (batch, 1, hidden_width)")
        injected = hidden + vector
        result = torch.where(mask, injected, hidden)
        return (result, *output[1:]) if isinstance(output, tuple) else result
