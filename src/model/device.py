"""Device and precision policy shared by spatial modules."""

from __future__ import annotations

from typing import Any

import torch
from torch import nn


def get_device() -> torch.device:
    """Choose CUDA when available, otherwise CPU (without probing CUDA eagerly)."""
    return torch.device("cuda" if torch.cuda.is_available() else "cpu")


def get_compute_dtype(device: torch.device | str | None = None) -> torch.dtype:
    """Use bfloat16 on CUDA and float32 on CPU for reliable native kernels."""
    resolved = torch.device(device) if device is not None else get_device()
    return torch.bfloat16 if resolved.type == "cuda" else torch.float32


def align_tensor(tensor: torch.Tensor, module: nn.Module) -> torch.Tensor:
    """Move an input to a module's parameter device/dtype while preserving gradients."""
    parameter = next(module.parameters(), None)
    if parameter is None:
        return tensor.to(device=get_device(), dtype=get_compute_dtype())
    device = parameter.device
    dtype = parameter.dtype
    if device.type == "cpu" and dtype == torch.bfloat16:
        # This is a defensive fallback for modules converted outside the project policy.
        dtype = torch.float32
    return tensor.to(device=device, dtype=dtype)


class DeviceAwareModule(nn.Module):
    """nn.Module whose ``to`` method prevents unsupported CPU bfloat16 execution."""

    def to(self, *args: Any, **kwargs: Any) -> DeviceAwareModule:  # type: ignore[override]
        requested_device = kwargs.get("device")
        requested_dtype = kwargs.get("dtype")
        positional = list(args)
        if positional:
            first = positional[0]
            if isinstance(first, (str, torch.device, int)):
                requested_device = first
                if len(positional) > 1 and isinstance(positional[1], torch.dtype):
                    requested_dtype = positional[1]
            elif isinstance(first, torch.Tensor):
                requested_device = first.device
                requested_dtype = first.dtype
            elif isinstance(first, torch.dtype):
                requested_dtype = first

        current_parameter = next(self.parameters(), None)
        resolved_device = (
            torch.device(requested_device)
            if requested_device is not None
            else current_parameter.device if current_parameter is not None else get_device()
        )
        fallback_to_float32 = resolved_device.type == "cpu" and (
            requested_dtype == torch.bfloat16
            or (requested_dtype is None and current_parameter is not None
                and current_parameter.dtype == torch.bfloat16)
        )
        if fallback_to_float32:
            if positional and isinstance(positional[0], torch.Tensor):
                target_tensor = positional.pop(0)
                kwargs["device"] = target_tensor.device
                kwargs["dtype"] = torch.float32
            elif "dtype" in kwargs or ("device" in kwargs and requested_dtype is None):
                kwargs["dtype"] = torch.float32
            elif positional and isinstance(positional[0], torch.dtype):
                positional[0] = torch.float32
            elif len(positional) > 1 and isinstance(positional[1], torch.dtype):
                positional[1] = torch.float32
            elif positional:
                positional.append(torch.float32)
            else:
                kwargs["dtype"] = torch.float32
            args = tuple(positional)
        return super().to(*args, **kwargs)
