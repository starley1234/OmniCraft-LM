from __future__ import annotations

import torch

from src.model.latent_bridge import InProjector, OutProjector, ScaleMLP
from src.model.voxel_canvas import VoxelCanvas
from src.model.wire_canvas import WireCanvas


def test_latent_bridge_and_spatial_canvas_shapes_on_cpu() -> None:
    torch.set_num_threads(1)
    device = torch.device("cpu")
    batch = 2
    scale = ScaleMLP().to(device=device)
    projector_in = InProjector().to(device=device)
    voxel = VoxelCanvas().to(device=device)
    wire = WireCanvas().to(device=device)
    projector_out = OutProjector().to(device=device)

    target_bbox = torch.tensor([[80.0, 40.0, 30.0], [50.0, 35.0, 25.0]], device=device)
    with torch.inference_mode():
        scale_embedding = scale(target_bbox)
        assert scale_embedding.shape == (batch, 128)
        canvas_input = projector_in(torch.randn(batch, 2048, device=device), scale_embedding)
        assert canvas_input.shape == (batch, 512)
        voxel_output = voxel(canvas_input)
        wire_output = wire(canvas_input)
        assert voxel_output.shape == (batch, 512)
        assert wire_output.shape == (batch, 512)
        assert projector_out(voxel_output).shape == (batch, 2048)
        assert projector_out(wire_output).shape == (batch, 2048)


def test_cpu_bfloat16_request_falls_back_to_float32() -> None:
    module = ScaleMLP().to(device="cpu", dtype=torch.bfloat16)
    assert next(module.parameters()).dtype == torch.float32
    result = module(torch.tensor([[12.0, 8.0, 4.0]]))
    assert result.dtype == torch.float32

    # Moving a CUDA/bfloat16 module back to CPU without an explicit dtype also
    # restores float32 instead of leaving incompatible bfloat16 parameters.
    for parameter in module.parameters():
        parameter.data = parameter.data.to(dtype=torch.bfloat16)
    module.to(device="cpu")
    assert next(module.parameters()).dtype == torch.float32
