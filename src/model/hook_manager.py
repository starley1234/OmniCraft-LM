"""Prefill-only hidden-state injection at the configured Qwen layer (layer 12)."""

from __future__ import annotations

from contextlib import contextmanager
from typing import Callable, Iterator

import torch
from torch import nn

from src.model.device import align_tensor
from src.model.latent_bridge import LLM_DIM

# Computes the residual spatial vector from the layer's own hidden states.
# Receives (hidden[B, T, D], control_mask[B, T]) and must return (B, D).
SpatialFn = Callable[[torch.Tensor, torch.Tensor], torch.Tensor]


class SpatialHookManager:
    """Inject a residual spatial vector only at control tokens during prefill.

    ``input_ids`` plus either a precomputed ``spatial_vector`` (inference) or a
    ``spatial_fn`` callback (training, gradient flows through the callback into
    the spatial stack) are supplied for each prefill via :meth:`set_context`.
    Decode calls with sequence length one stay transparent in both modes.
    """

    def __init__(self, control_token_id: int, layer_index: int = 12) -> None:
        self.control_token_id = control_token_id
        self.layer_index = layer_index
        self._input_ids: torch.Tensor | None = None
        self._spatial_vector: torch.Tensor | None = None
        self._spatial_fn: SpatialFn | None = None
        self._handle: torch.utils.hooks.RemovableHandle | None = None

    def attach(self, layer: nn.Module) -> torch.utils.hooks.RemovableHandle:
        if self._handle is not None:
            self.remove()
        self._handle = layer.register_forward_hook(self._forward_hook)
        return self._handle

    def attach_to_backbone(self, backbone: nn.Module) -> torch.utils.hooks.RemovableHandle:
        """Resolve and attach to the configured layer in common HF Qwen layouts.

        Probes the conventional attribute paths first, then falls back to a
        breadth-first search for a decoder ``ModuleList`` — needed when the
        backbone is nested inside a PEFT wrapper and/or a multimodal shell.
        """
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
        found = self._search_decoder_layers(backbone)
        if found is not None:
            return self.attach(found[self.layer_index])
        raise AttributeError(
            "could not locate backbone layers at .layers, .model.layers, "
            ".transformer.layers, or via decoder ModuleList search"
        )

    def _search_decoder_layers(self, backbone: nn.Module) -> nn.ModuleList | None:
        """Breadth-first search for the transformer decoder's ModuleList."""
        best: nn.ModuleList | None = None
        queue: list[nn.Module] = [backbone]
        visited: set[int] = set()
        while queue:
            module = queue.pop(0)
            if id(module) in visited:
                continue
            visited.add(id(module))
            for child in module.children():
                if isinstance(child, nn.ModuleList) and len(child) > self.layer_index:
                    first = child[0]
                    if any("attn" in name or "attention" in name for name, _ in first.named_children()):
                        if best is None or len(child) > len(best):
                            best = child
                queue.append(child)
        return best

    def remove(self) -> None:
        if self._handle is not None:
            self._handle.remove()
            self._handle = None

    def set_context(
        self,
        input_ids: torch.Tensor,
        spatial_vector: torch.Tensor | None = None,
        spatial_fn: SpatialFn | None = None,
    ) -> None:
        if spatial_vector is None and spatial_fn is None:
            raise ValueError("provide either a precomputed spatial_vector or a spatial_fn callback")
        if spatial_vector is not None and spatial_fn is not None:
            raise ValueError("spatial_vector and spatial_fn are mutually exclusive")
        self._input_ids = input_ids
        self._spatial_vector = spatial_vector
        self._spatial_fn = spatial_fn

    @contextmanager
    def context(
        self,
        input_ids: torch.Tensor,
        spatial_vector: torch.Tensor | None = None,
        spatial_fn: SpatialFn | None = None,
    ) -> Iterator[None]:
        previous = (self._input_ids, self._spatial_vector, self._spatial_fn)
        self.set_context(input_ids, spatial_vector, spatial_fn)
        try:
            yield
        finally:
            self._input_ids, self._spatial_vector, self._spatial_fn = previous

    def clear_context(self) -> None:
        self._input_ids = None
        self._spatial_vector = None
        self._spatial_fn = None

    def _forward_hook(self, _module: nn.Module, _inputs: tuple[object, ...], output: object) -> object:
        if self._input_ids is None or (self._spatial_vector is None and self._spatial_fn is None):
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
        if self._spatial_fn is not None:
            vector = self._spatial_fn(hidden, mask.squeeze(-1))
        else:
            vector = self._spatial_vector
        vector = vector.to(device=hidden.device, dtype=hidden.dtype)
        if vector.ndim == 2:
            vector = vector.unsqueeze(1)
        if vector.shape[0] != hidden.shape[0] or vector.shape[-1] != hidden.shape[-1]:
            raise ValueError("spatial vector must have shape (batch, hidden_width) or (batch, 1, hidden_width)")
        injected = hidden + vector
        result = torch.where(mask, injected, hidden)
        return (result, *output[1:]) if isinstance(output, tuple) else result
