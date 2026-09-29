"""Pydantic schema for generated and geometrically validated JSONL records."""

from __future__ import annotations

import hashlib
import json
import math
from pathlib import Path
from typing import Any, Literal

from pydantic import BaseModel, Field, field_validator, model_validator

ValidationStatus = Literal[
    "generated", "static", "analytic", "openscad_manifold", "mock", "rejected"
]


class SampleVerification(BaseModel):
    """Separate requested geometry from measured or analytically derived metrics.

    Generated candidates intentionally leave measured fields empty. In particular,
    ``mock`` results are never equivalent to CAD-validated results and must not be
    marked accepted by a dataset pipeline.
    """

    target_bbox: tuple[float, float, float]
    actual_bbox: tuple[float, float, float] | None = None
    bbox_relative_error: float | None = Field(default=None, ge=0, allow_inf_nan=False)
    volume_mm3: float | None = Field(default=None, gt=0, allow_inf_nan=False)
    euler_characteristic: int | None = None
    holes_count: int | None = Field(default=None, ge=0)
    is_watertight: bool | None = None
    components_count: int | None = Field(default=None, ge=1)
    validation_status: ValidationStatus = "generated"
    validation_backend: str = "none"
    accepted: bool = False
    validation_error: str | None = None

    @field_validator("target_bbox", "actual_bbox")
    @classmethod
    def bbox_is_positive(
        cls, value: tuple[float, float, float] | None
    ) -> tuple[float, float, float] | None:
        if value is not None and (
            len(value) != 3
            or any(not math.isfinite(dimension) or dimension <= 0 for dimension in value)
        ):
            raise ValueError("bounding boxes must contain exactly three finite positive dimensions")
        return value


class AuxiliaryGroundTruth(BaseModel):
    nodes: list[tuple[float, float, float]] = Field(default_factory=list)
    edges: list[tuple[int, int]] = Field(default_factory=list)

    @field_validator("nodes")
    @classmethod
    def node_coordinates_are_finite(
        cls, value: list[tuple[float, float, float]]
    ) -> list[tuple[float, float, float]]:
        if any(not math.isfinite(coordinate) for node in value for coordinate in node):
            raise ValueError("auxiliary node coordinates must be finite")
        return value

    @field_validator("edges")
    @classmethod
    def edge_indices_are_nonnegative(cls, value: list[tuple[int, int]]) -> list[tuple[int, int]]:
        if any(start < 0 or end < 0 for start, end in value):
            raise ValueError("edge indices must be non-negative")
        return value


class CADSample(BaseModel):
    id: str = Field(min_length=1)
    layer: Literal["voxel", "wire", "sketch", "brep", "assembly"]
    prompts: dict[str, str]
    images: list[str] = Field(default_factory=list)
    code: str
    verification: SampleVerification
    auxiliary_ground_truth: AuxiliaryGroundTruth = Field(default_factory=AuxiliaryGroundTruth)
    metadata: dict[str, Any] = Field(default_factory=dict)

    @field_validator("code")
    @classmethod
    def code_has_required_facet_header(cls, value: str) -> str:
        if not value.startswith("$fn = 32;\n"):
            raise ValueError('OpenSCAD code must start with "$fn = 32;\\n"')
        return value

    @model_validator(mode="after")
    def accepted_samples_must_have_trusted_evidence(self) -> CADSample:
        verification = self.verification
        if not verification.accepted:
            return self
        expected_hash = self.metadata.get("code_sha256")
        actual_hash = hashlib.sha256(self.code.encode("utf-8")).hexdigest()
        if not expected_hash or expected_hash != actual_hash:
            raise ValueError("accepted sample must have a matching code_sha256")
        if verification.validation_status == "analytic":
            descriptor = self.metadata.get("analytic_geometry")
            if (
                self.layer != "voxel"
                or self.metadata.get("source") != "voxel_csg_gen"
                or self.metadata.get("generator_version") != 1
                or not isinstance(descriptor, dict)
                or descriptor.get("exact") is not True
                or verification.validation_backend != "analytic"
                or verification.actual_bbox is None
                or verification.volume_mm3 is None
                or verification.is_watertight is not True
                or verification.components_count != 1
                or verification.euler_characteristic is None
            ):
                raise ValueError("analytic acceptance is limited to exact supported voxel-generator records")
        elif verification.validation_status == "openscad_manifold":
            runtime = self.metadata.get("validation_runtime")
            bbox_limit = float(runtime.get("max_bbox_relative_error", -1)) if isinstance(runtime, dict) else -1.0
            volume_limit = float(runtime.get("max_volume_relative_error", -1)) if isinstance(runtime, dict) else -1.0
            if (
                not math.isfinite(bbox_limit)
                or bbox_limit < 0
                or not math.isfinite(volume_limit)
                or volume_limit < 0
            ):
                raise ValueError("OpenSCAD acceptance must record finite non-negative validation tolerances")
            if (
                verification.validation_backend != "openscad-manifold"
                or not isinstance(runtime, dict)
                or runtime.get("backend") != "openscad-manifold"
                or not runtime.get("openscad_version")
                or runtime.get("openscad_version") == "unknown"
                or verification.is_watertight is not True
                or verification.components_count != 1
                or verification.volume_mm3 is None
                or verification.actual_bbox is None
                or verification.euler_characteristic is None
                or verification.bbox_relative_error is None
                or verification.bbox_relative_error > bbox_limit
            ):
                raise ValueError("OpenSCAD acceptance requires versioned manifold mesh metrics within policy")
            if verification.is_watertight and verification.components_count == 1:
                genus_numerator = 2 - verification.euler_characteristic
                if genus_numerator < 0 or genus_numerator % 2:
                    raise ValueError("accepted mesh Euler characteristic is inconsistent with a closed solid")
            descriptor = self.metadata.get("analytic_geometry")
            if isinstance(descriptor, dict) and descriptor.get("exact") is True:
                expected_volume = float(descriptor["volume_mm3"])
                measured_volume = float(verification.volume_mm3)
                volume_error = abs(measured_volume - expected_volume) / expected_volume
                if volume_error > volume_limit:
                    raise ValueError("accepted mesh volume violates the recorded analytic tolerance")
        else:
            raise ValueError("mock, static, generated, and rejected records cannot be accepted")
        return self


def parse_jsonl(path: Path) -> list[CADSample]:
    """Load and validate records, reporting the physical line number on errors."""
    records: list[CADSample] = []
    seen_ids: set[str] = set()
    with Path(path).open("r", encoding="utf-8") as stream:
        for line_number, line in enumerate(stream, start=1):
            if not line.strip():
                continue
            try:
                payload = json.loads(line)
                record = CADSample.model_validate(payload)
                if record.id in seen_ids:
                    raise ValueError(f"duplicate sample id {record.id!r}")
                seen_ids.add(record.id)
            except Exception as exc:
                raise ValueError(f"invalid JSONL record at {path}:{line_number}: {exc}") from exc
            records.append(record)
    return records


def write_jsonl(path: Path, samples: list[CADSample]) -> None:
    """Write schema-validated records as UTF-8 JSONL using an atomic replacement."""
    destination = Path(path)
    destination.parent.mkdir(parents=True, exist_ok=True)
    temporary = destination.with_name(destination.name + ".tmp")
    try:
        with temporary.open("w", encoding="utf-8", newline="\n") as stream:
            for sample in samples:
                validated = CADSample.model_validate(sample.model_dump(mode="python"))
                stream.write(validated.model_dump_json() + "\n")
        temporary.replace(destination)
    finally:
        temporary.unlink(missing_ok=True)
