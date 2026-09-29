"""Multi-LoRA mounting on the frozen Qwen backbone (ARCHITECTURE.md section 5).

Each spatial layer gets an isolated adapter ``lora_<layer>`` on the attention
projections. Only the active adapter receives gradients; the frozen base model
and the inactive adapters never see an optimizer step. Adapters are recreated
from the zero-point seed (``lora_B`` starts at zeros), which is the documented
rollback state.
"""

from __future__ import annotations

import torch
from torch import nn

LORA_RANK = 16
LORA_ALPHA = 32
LORA_TARGETS = ("q_proj", "k_proj", "v_proj", "o_proj")


def adapter_name(layer: str) -> str:
    return f"lora_{layer}"


def freeze_module(module: nn.Module) -> None:
    for parameter in module.parameters():
        parameter.requires_grad_(False)


def attach_lora_adapters(
    backbone: nn.Module,
    layers: tuple[str, ...],
    *,
    rank: int = LORA_RANK,
    alpha: int = LORA_ALPHA,
    dropout: float = 0.0,
    seed: int | None = None,
) -> nn.Module:
    """Wrap the backbone with one PEFT LoRA adapter per spatial layer.

    Deterministic for a fixed ``seed``: adapters are created in ``layers``
    order, and PEFT initializes ``lora_B`` to zeros, so fresh adapters contribute
    exactly the identity mapping before any training.
    """
    try:
        from peft import LoraConfig, get_peft_model
    except ImportError as exc:
        raise RuntimeError("peft is required for LoRA training; install requirements") from exc
    if not layers:
        raise ValueError("at least one spatial layer is required")
    config = LoraConfig(
        r=rank,
        lora_alpha=alpha,
        lora_dropout=dropout,
        target_modules=list(LORA_TARGETS),
        bias="none",
        init_lora_weights=True,
    )
    if seed is not None:
        torch.manual_seed(seed)
    model = get_peft_model(backbone, config, adapter_name=adapter_name(layers[0]))
    for layer in layers[1:]:
        model.add_adapter(adapter_name(layer), config)
    set_active_adapter(model, layers[0])
    return model


def set_active_adapter(model: nn.Module, layer: str) -> None:
    """Switch the backbone to the adapter of the requested spatial layer."""
    name = adapter_name(layer)
    set_adapter = getattr(model, "set_adapter", None)
    if set_adapter is None:
        raise TypeError("backbone is not PEFT-wrapped; call attach_lora_adapters first")
    set_adapter(name)


def adapter_parameters(model: nn.Module, layer: str) -> list[nn.Parameter]:
    """Trainable LoRA parameters of a single adapter (for isolated optimizer steps)."""
    name = adapter_name(layer)
    return [
        parameter
        for parameter_name, parameter in model.named_parameters()
        if parameter.requires_grad and f".{name}." in parameter_name
    ]


def freeze_inactive_adapters(model: nn.Module, active_layer: str) -> None:
    """Hard-freeze every adapter except the active one (defense-in-depth for isolation)."""
    active = adapter_name(active_layer)
    for parameter_name, parameter in model.named_parameters():
        if "lora_" in parameter_name:
            parameter.requires_grad_(f".{active}." in parameter_name)
