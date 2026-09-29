"""CUDA smoke tests proving the fixed-flag promise of the architecture.

The spatial stack must run on the RTX 5060 Ti (sm_120) in bfloat16 without any
architectural changes — only the device/dtype placement differs from the CPU
path. Every test is skipped automatically on CPU-only machines to preserve the
CPU-first CI contract.
"""

from __future__ import annotations

import pytest
import torch

from src.model.assembly_canvas import AssemblyCanvas
from src.model.brep_canvas import BRepCanvas
from src.model.device import get_device, get_compute_dtype
from src.model.hook_manager import SpatialHookManager
from src.model.latent_bridge import (
    CANVAS_DIM,
    LLM_DIM,
    InProjector,
    OutProjector,
    ScaleMLP,
)
from src.model.sketch_canvas import SketchCanvas
from src.model.voxel_canvas import VoxelCanvas
from src.model.wire_canvas import WireCanvas
from torch import nn

pytestmark = pytest.mark.skipif(not torch.cuda.is_available(), reason="CUDA device is unavailable")

DEVICE = torch.device("cuda")
DTYPE = torch.bfloat16
BATCH = 2


def _canvases() -> dict[str, nn.Module]:
    return {
        "voxel": VoxelCanvas(),
        "wire": WireCanvas(),
        "sketch": SketchCanvas(),
        "brep": BRepCanvas(),
        "assembly": AssemblyCanvas(),
    }


def _canvas_inputs() -> dict[str, tuple[torch.Tensor, ...]]:
    latent = torch.randn(BATCH, CANVAS_DIM, device=DEVICE, dtype=DTYPE)
    return {
        "voxel": (latent,),
        "wire": (latent,),
        "sketch": (torch.randn(BATCH, 16, 64, 64, device=DEVICE, dtype=DTYPE),),
        "brep": (torch.randn(BATCH, 12, 32, device=DEVICE, dtype=DTYPE),),
        "assembly": (
            torch.eye(4, device=DEVICE, dtype=DTYPE).expand(BATCH, 5, 4, 4).contiguous(),
        ),
    }


def test_compute_dtype_policy_prefers_bfloat16_on_cuda() -> None:
    assert get_device().type == "cuda"
    assert get_compute_dtype() is torch.bfloat16
    assert get_compute_dtype("cpu") is torch.float32


def test_full_spatial_stack_runs_on_cuda_in_bfloat16() -> None:
    modules = {
        "scale": ScaleMLP(),
        "in_projector": InProjector(),
        "out_projector": OutProjector(),
        **_canvases(),
    }
    for name, module in modules.items():
        module.to(device=DEVICE, dtype=DTYPE)
        parameter = next(module.parameters())
        assert parameter.device.type == "cuda", f"{name} did not move to CUDA"
        assert parameter.dtype is DTYPE, f"{name} did not convert to bfloat16"

    target_bbox = torch.tensor([[80.0, 40.0, 30.0], [50.0, 35.0, 25.0]], device=DEVICE)
    llm_hidden = torch.randn(BATCH, LLM_DIM, device=DEVICE, dtype=DTYPE)

    scale_embedding = modules["scale"](target_bbox)
    assert scale_embedding.shape == (BATCH, 128)
    assert scale_embedding.dtype is DTYPE

    canvas_input = modules["in_projector"](llm_hidden, scale_embedding)
    assert canvas_input.shape == (BATCH, CANVAS_DIM)

    inputs = _canvas_inputs()
    for name, canvas in modules.items():
        if name in ("scale", "in_projector", "out_projector"):
            continue
        output = canvas(*inputs[name])
        assert output.shape == (BATCH, CANVAS_DIM), f"{name} output shape"
        assert output.dtype is DTYPE, f"{name} output dtype"
        assert output.device.type == "cuda", f"{name} output device"
        assert torch.isfinite(output.float()).all(), f"{name} produced non-finite values"
        restored = modules["out_projector"](output)
        assert restored.shape == (BATCH, LLM_DIM), f"{name} out-projection shape"


def test_backward_pass_flows_through_cuda_canvases() -> None:
    torch.manual_seed(0)
    scale = ScaleMLP().to(device=DEVICE, dtype=DTYPE)
    projector_in = InProjector().to(device=DEVICE, dtype=DTYPE)
    projector_out = OutProjector().to(device=DEVICE, dtype=DTYPE)
    voxel = VoxelCanvas().to(device=DEVICE, dtype=DTYPE)
    wire = WireCanvas().to(device=DEVICE, dtype=DTYPE)

    target_bbox = torch.tensor([[60.0, 30.0, 20.0], [120.0, 45.0, 30.0]], device=DEVICE)
    llm_hidden = torch.randn(BATCH, LLM_DIM, device=DEVICE, dtype=DTYPE)
    z_in = projector_in(llm_hidden, scale(target_bbox))
    total = projector_out(voxel(z_in)).sum() + projector_out(wire(z_in)).sum()
    total.float().backward()

    for name, module in (
        ("scale", scale),
        ("in_projector", projector_in),
        ("out_projector", projector_out),
        ("voxel", voxel),
        ("wire", wire),
    ):
        gradients = [parameter.grad for parameter in module.parameters() if parameter.requires_grad]
        assert gradients and all(gradient is not None for gradient in gradients), f"{name} missing gradients"
        assert all(
            torch.isfinite(gradient.float()).all() for gradient in gradients
        ), f"{name} produced non-finite gradients"


def test_spatial_hook_injects_only_during_prefill_on_cuda() -> None:
    control_token_id = 99
    manager = SpatialHookManager(control_token_id=control_token_id, layer_index=0)
    layer = nn.Linear(LLM_DIM, LLM_DIM).to(device=DEVICE, dtype=DTYPE)
    manager.attach(layer)
    try:
        sequence = 7
        hidden = torch.randn(BATCH, sequence, LLM_DIM, device=DEVICE, dtype=DTYPE)
        input_ids = torch.zeros(BATCH, sequence, dtype=torch.long, device=DEVICE)
        input_ids[:, 3] = control_token_id
        spatial_vector = torch.randn(BATCH, LLM_DIM, device=DEVICE, dtype=DTYPE)

        with manager.context(input_ids, spatial_vector):
            prefilled = layer(hidden)
        # Injection is residual on the layer output at control-token positions only.
        expected = layer(hidden)
        expected[:, 3] = expected[:, 3] + spatial_vector
        assert torch.allclose(prefilled.float(), expected.float(), atol=1e-2, rtol=1e-2)
        # Non-control positions stay untouched.
        mask = input_ids.eq(control_token_id).unsqueeze(-1).expand_as(hidden)
        assert torch.equal(prefilled[~mask], layer(hidden)[~mask])

        # Decode step with a single KV-cache token is transparent.
        decode_hidden = torch.randn(BATCH, 1, LLM_DIM, device=DEVICE, dtype=DTYPE)
        decode_ids = torch.full((BATCH, 1), control_token_id, dtype=torch.long, device=DEVICE)
        with manager.context(decode_ids, spatial_vector):
            decoded = layer(decode_hidden)
        assert torch.equal(decoded, layer(decode_hidden))

        # With no context set, prefill-length sequences pass through untouched.
        manager.clear_context()
        plain = torch.randn(BATCH, 4, LLM_DIM, device=DEVICE, dtype=DTYPE)
        expected_plain = torch.nn.functional.linear(plain, layer.weight, layer.bias)
        assert torch.equal(layer(plain), expected_plain)
    finally:
        manager.remove()


def test_spatial_hook_matches_cpu_result_within_bfloat16_tolerance() -> None:
    control_token_id = 5
    hidden_cpu = torch.randn(1, 6, LLM_DIM)
    vector_cpu = torch.randn(1, LLM_DIM)
    ids = torch.tensor([[0, 0, control_token_id, 0, 0, 0]])

    def run(device: torch.device, dtype: torch.dtype) -> torch.Tensor:
        manager = SpatialHookManager(control_token_id=control_token_id, layer_index=0)
        layer = nn.Identity().to(device=device, dtype=dtype)
        manager.attach(layer)
        try:
            with manager.context(ids.to(device), vector_cpu.to(device=device, dtype=dtype)):
                return layer(hidden_cpu.to(device=device, dtype=dtype)).float().cpu()
        finally:
            manager.remove()

    cpu_result = run(torch.device("cpu"), torch.float32)
    cuda_result = run(DEVICE, DTYPE)
    assert torch.allclose(cuda_result, cpu_result, atol=1e-2, rtol=1e-2)


def test_canvas_activation_memory_stays_far_below_vram_budget() -> None:
    """Batch-256 forward passes must use a fraction of the 14.2 GiB VRAM budget."""
    budget_bytes = int(4 * 1024**3)  # conservative ceiling far below 14.2 GiB
    torch.cuda.empty_cache()
    torch.cuda.reset_peak_memory_stats()
    batch = 256
    latent = torch.randn(batch, CANVAS_DIM, device=DEVICE, dtype=DTYPE)
    inputs: dict[str, tuple[torch.Tensor, ...]] = {
        "voxel": (latent,),
        "wire": (latent,),
        "sketch": (torch.randn(batch, 16, 64, 64, device=DEVICE, dtype=DTYPE),),
        "brep": (torch.randn(batch, 12, 32, device=DEVICE, dtype=DTYPE),),
        "assembly": (
            torch.eye(4, device=DEVICE, dtype=DTYPE).expand(batch, 6, 4, 4).contiguous(),
        ),
    }
    with torch.inference_mode():
        for name, canvas in _canvases().items():
            canvas.to(device=DEVICE, dtype=DTYPE)
            output = canvas(*inputs[name])
            assert output.shape == (batch, CANVAS_DIM), name
    peak = torch.cuda.max_memory_allocated()
    assert 0 < peak < budget_bytes, f"peak VRAM {peak / 1024**3:.2f} GiB exceeded budget"
