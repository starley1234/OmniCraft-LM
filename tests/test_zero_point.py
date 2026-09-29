"""Zero-point anchor: deterministic init, verified rollback, tamper detection."""

from __future__ import annotations

from pathlib import Path

import pytest
import torch

from src.training.checkpoints import (
    build_stack_with_seed,
    load_manifest,
    load_zero_point,
    save_zero_point,
    verify_zero_point,
)
from src.training.spatial_stack import SpatialStack

SEED = 1234
LAYERS = ("wire",)


def _state_signature(stack: SpatialStack) -> dict[str, tuple]:
    signature: dict[str, tuple] = {}
    for name, parameter in stack.named_parameters():
        signature[name] = tuple(parameter.detach().flatten().tolist())
    return signature


def test_seeded_initialization_is_bit_identical() -> None:
    first = build_stack_with_seed(SEED, LAYERS)
    second = build_stack_with_seed(SEED, LAYERS)
    assert _state_signature(first) == _state_signature(second)
    different = build_stack_with_seed(SEED + 1, LAYERS)
    assert _state_signature(first) != _state_signature(different)


def test_zero_point_roundtrip_restores_mutated_weights(tmp_path: Path) -> None:
    directory = tmp_path / "zero_point"
    manifest = save_zero_point(directory, SEED, LAYERS)
    assert manifest.seed == SEED
    assert verify_zero_point(directory) == []

    stack = build_stack_with_seed(SEED, LAYERS)
    initial = _state_signature(stack)
    with torch.no_grad():  # simulate a failed training run
        for parameter in stack.parameters():
            parameter.add_(torch.randn_like(parameter) * 10.0)
    assert _state_signature(stack) != initial

    loaded = load_zero_point(stack, directory)
    assert loaded.seed == SEED
    assert _state_signature(stack) == initial


def test_zero_point_detects_tampering(tmp_path: Path) -> None:
    directory = tmp_path / "zero_point"
    save_zero_point(directory, SEED, LAYERS)
    target = directory / "wire" / "canvas.pt"
    payload = bytearray(target.read_bytes())
    payload[-1] ^= 0xFF
    target.write_bytes(bytes(payload))

    violations = verify_zero_point(directory)
    assert violations and "canvas.pt" in violations[0]
    with pytest.raises(RuntimeError, match="corrupted"):
        load_zero_point(build_stack_with_seed(SEED, LAYERS), directory)


def test_zero_point_refuses_overwrite_without_force(tmp_path: Path) -> None:
    directory = tmp_path / "zero_point"
    save_zero_point(directory, SEED, LAYERS)
    with pytest.raises(FileExistsError):
        save_zero_point(directory, SEED + 1, LAYERS)
    overwritten = save_zero_point(directory, SEED + 1, LAYERS, force=True)
    assert load_manifest(directory).seed == SEED + 1
    assert overwritten.seed == SEED + 1


def test_load_rejects_layer_mismatch(tmp_path: Path) -> None:
    directory = tmp_path / "zero_point"
    save_zero_point(directory, SEED, LAYERS)
    with pytest.raises(ValueError, match="layers"):
        load_zero_point(build_stack_with_seed(SEED, ("voxel",)), directory)


def test_spatial_stack_forward_paths() -> None:
    torch.set_num_threads(1)
    stack = build_stack_with_seed(SEED, ("voxel", "wire"))
    llm_hidden = torch.randn(2, 2048)
    log_bbox = torch.log(torch.tensor([[80.0, 40.0, 30.0], [50.0, 35.0, 25.0]]))
    for layer in ("voxel", "wire"):
        output = stack.forward_layer(layer, llm_hidden, log_bbox)
        assert output.shape == (2, 2048)
        assert torch.isfinite(output).all()
    with pytest.raises(ValueError, match="not part of this stack"):
        stack.forward_layer("sketch", llm_hidden, log_bbox)
    assembly_stack = build_stack_with_seed(SEED, ("assembly",))
    with pytest.raises(ValueError, match="requires raw canvas inputs"):
        assembly_stack.forward_layer("assembly", llm_hidden, log_bbox)


def test_isolated_trainable_parameter_sets() -> None:
    stack = build_stack_with_seed(SEED, ("voxel", "wire"))
    voxel_params = set(map(id, stack.trainable_parameters("voxel")))
    wire_params = set(map(id, stack.trainable_parameters("wire")))
    assert voxel_params and wire_params
    assert voxel_params.isdisjoint(wire_params)
