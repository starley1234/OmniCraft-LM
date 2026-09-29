from __future__ import annotations

import hashlib
import shutil
from pathlib import Path

import pytest

from src.data.generators.voxel_csg_gen import VoxelCSGGenerator
from src.data.generators.wire_truss_gen import WireTrussGenerator
from src.data.schema import CADSample, SampleVerification
from src.data.validation import DatasetValidator, ValidationPolicy
from src.data.validation_cache import ValidationCache
from src.env.cad_interface import VerificationResult
from src.env.mock_runner import MockRunner
from src.env.openscad_runner import OpenSCADRunner


class FixedMeshRunner(OpenSCADRunner):
    def __init__(self, result: VerificationResult) -> None:
        self.result = result
        self.backend = "manifold"
        self.version = "OpenSCAD validation test double"

    def compile(self, code: str) -> VerificationResult:
        return self.result


def _simple_sample() -> CADSample:
    code = "$fn = 32;\n// target_bbox: 10, 20, 30\ncube([10, 20, 30]);\n"
    return CADSample(
        id="fixed-cube",
        layer="voxel",
        prompts={"en": "cube"},
        code=code,
        verification=SampleVerification(target_bbox=(10.0, 20.0, 30.0)),
        metadata={"code_sha256": hashlib.sha256(code.encode("utf-8")).hexdigest()},
    )


def test_voxel_analytic_validation_is_explicit_and_exact() -> None:
    sample = VoxelCSGGenerator(seed=17).generate(0)
    provisional = DatasetValidator().validate(sample)
    assert provisional.status == "analytic"
    assert provisional.accepted is False
    assert provisional.sample.verification.actual_bbox == sample.verification.target_bbox
    assert provisional.sample.verification.volume_mm3 is not None
    assert provisional.sample.verification.is_watertight is True

    admitted = DatasetValidator(
        policy=ValidationPolicy(accept_exact_analytic=True)
    ).validate(sample)
    assert admitted.status == "analytic"
    assert admitted.accepted is True
    CADSample.model_validate(admitted.sample.model_dump())


def test_wire_analytic_check_recomputes_graph_bounds_but_not_volume() -> None:
    sample = WireTrussGenerator(seed=23).generate(0)
    report = DatasetValidator().validate(sample)
    assert report.status == "analytic"
    assert report.accepted is False
    assert report.sample.verification.actual_bbox == sample.verification.target_bbox
    assert report.sample.verification.volume_mm3 is None
    assert report.sample.verification.is_watertight is None
    assert not report.errors


def test_real_backend_metrics_are_checked_before_acceptance() -> None:
    sample = _simple_sample()
    good_mesh = VerificationResult(
        is_watertight=True,
        bbox=(10.0, 20.0, 30.0),
        volume=6000.0,
        euler_characteristic=2,
        components_count=1,
        backend="openscad-manifold",
        validation_status="openscad_manifold",
    )
    accepted = DatasetValidator(runner=FixedMeshRunner(good_mesh)).validate(sample)
    assert accepted.accepted is True
    assert accepted.sample.verification.validation_status == "openscad_manifold"
    assert accepted.sample.verification.volume_mm3 == 6000.0
    CADSample.model_validate(accepted.sample.model_dump())

    bad_mesh = VerificationResult(
        is_watertight=False,
        bbox=(10.0, 20.0, 30.0),
        volume=6000.0,
        euler_characteristic=2,
        components_count=2,
        backend="openscad-manifold",
        validation_status="openscad_manifold",
    )
    rejected = DatasetValidator(runner=FixedMeshRunner(bad_mesh)).validate(sample)
    assert rejected.accepted is False
    assert rejected.status == "rejected"
    assert any("watertight" in error for error in rejected.errors)
    assert any("component" in error for error in rejected.errors)


def test_mock_metrics_never_promote_a_candidate_to_accepted() -> None:
    sample = VoxelCSGGenerator(seed=9).generate(0)
    report = DatasetValidator(runner=MockRunner()).validate(sample)
    assert report.status == "mock"
    assert report.accepted is False
    assert report.sample.verification.volume_mm3 is None
    assert any("never accepted" in warning for warning in report.warnings)


def test_code_hash_detects_post_generation_mutation() -> None:
    sample = VoxelCSGGenerator(seed=3).generate(0)
    changed = sample.model_copy(update={"code": sample.code + "{\n"})
    report = DatasetValidator().validate(changed)
    assert report.status == "rejected"
    assert any("code_sha256" in error for error in report.errors)


def test_validation_cache_roundtrip_is_fingerprint_scoped(tmp_path: Path) -> None:
    sample = VoxelCSGGenerator(seed=4).generate(0)
    validator = DatasetValidator()
    report = validator.validate(sample)
    cache_path = tmp_path / "validation-cache.json"
    cache = ValidationCache(cache_path, validator.cache_fingerprint)
    cache.put(sample, report)
    cache.save()

    restored = ValidationCache(cache_path, validator.cache_fingerprint).get(sample)
    assert restored is not None
    assert restored.sample.id == sample.id
    assert restored.status == report.status
    assert restored.sample.verification.volume_mm3 == report.sample.verification.volume_mm3
    assert ValidationCache(cache_path, "other-policy").get(sample) is None


def test_openscad_runner_rejects_non_manifold_backend() -> None:
    with pytest.raises(ValueError, match="--backend=manifold"):
        OpenSCADRunner(backend="cgal")


def test_optional_real_openscad_manifold_integration() -> None:
    if shutil.which("openscad") is None:
        pytest.skip("OpenSCAD is not installed in this environment")
    sample = _simple_sample()
    report = DatasetValidator(runner=OpenSCADRunner()).validate(sample)
    assert report.accepted, report.errors
