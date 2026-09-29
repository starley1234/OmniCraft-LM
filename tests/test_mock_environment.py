from __future__ import annotations

import pytest

from src.data.generators.voxel_csg_gen import VoxelCSGGenerator
from src.data.schema import CADSample
from src.env.mock_runner import MockRunner


def test_mock_runner_verifies_generated_geometry_deterministically() -> None:
    sample = VoxelCSGGenerator(seed=7).generate(0)
    runner = MockRunner()
    first = runner.compile(sample.code)
    second = runner.compile(sample.code)
    assert first == second
    assert first.is_watertight is True
    assert first.error is None
    assert first.validation_status == "mock"
    assert first.bbox == sample.verification.target_bbox
    assert first.volume and first.volume > 0
    assert first.components_count == 1


def test_mock_runner_rejects_missing_facet_invariant() -> None:
    result = MockRunner().compile("cube([10, 10, 10]);\n")
    assert not result.is_watertight
    assert result.error is not None


def test_schema_enforces_canonical_code_and_roundtrip() -> None:
    sample = VoxelCSGGenerator(seed=3).generate(2)
    payload = sample.model_dump()
    restored = CADSample(**payload)
    assert restored.code.startswith("$fn = 32;\n")
    payload["code"] = "cube([1, 1, 1]);"
    with pytest.raises(Exception):
        CADSample(**payload)


def test_schema_rejects_forged_mock_acceptance() -> None:
    sample = VoxelCSGGenerator(seed=13).generate(0)
    payload = sample.model_dump()
    payload["verification"].update(
        {"accepted": True, "validation_status": "mock", "validation_backend": "mock"}
    )
    with pytest.raises(Exception, match="cannot be accepted"):
        CADSample.model_validate(payload)
