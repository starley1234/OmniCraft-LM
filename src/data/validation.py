"""Trust-aware static, analytic, mock, and OpenSCAD dataset validation."""

from __future__ import annotations

import hashlib
import math
import re
from collections import deque
from dataclasses import asdict, dataclass, field
from typing import Any

from src.data.schema import CADSample
from src.env.cad_interface import CADRunnerBase, VerificationResult
from src.env.mock_runner import MockRunner
from src.env.openscad_runner import OpenSCADRunner
from src.utils.metrics import bbox_relative_error

_HEADER = "$fn = 32;\n"
_NONFINITE = re.compile(r"(?<![A-Za-z_])(?:nan|inf|infinity|undef)(?![A-Za-z_])", re.IGNORECASE)
_GEOMETRY = re.compile(
    r"\b(?:cube|sphere|cylinder|polyhedron|polygon|circle|square|import|surface)\s*\(|"
    r"\b(?:linear_extrude|rotate_extrude|hull|union|difference|intersection)\s*\("
)


def _strip_comments(source: str) -> tuple[str, list[str]]:
    """Blank line/block comments while preserving strings and source line breaks."""
    output: list[str] = []
    errors: list[str] = []
    state = "code"
    escaped = False
    line_number = 1
    index = 0
    while index < len(source):
        character = source[index]
        following = source[index + 1] if index + 1 < len(source) else ""
        if state == "line_comment":
            if character == "\n":
                output.append("\n")
                state = "code"
                line_number += 1
            else:
                output.append(" ")
            index += 1
            continue
        if state == "block_comment":
            if character == "*" and following == "/":
                output.extend((" ", " "))
                state = "code"
                index += 2
            elif character == "\n":
                output.append("\n")
                line_number += 1
                index += 1
            else:
                output.append(" ")
                index += 1
            continue
        if state == "string":
            output.append(character)
            if character == "\n":
                line_number += 1
            if escaped:
                escaped = False
            elif character == "\\":
                escaped = True
            elif character == '"':
                state = "code"
            index += 1
            continue
        if character == '"':
            state = "string"
            output.append(character)
            index += 1
        elif character == "/" and following == "/":
            state = "line_comment"
            output.extend((" ", " "))
            index += 2
        elif character == "/" and following == "*":
            state = "block_comment"
            output.extend((" ", " "))
            index += 2
        else:
            output.append(character)
            if character == "\n":
                line_number += 1
            index += 1
    if state == "block_comment":
        errors.append(f"unterminated block comment beginning before line {line_number}")
    elif state == "string":
        errors.append("unterminated string literal")
    return "".join(output), errors


@dataclass(frozen=True, slots=True)
class ValidationPolicy:
    max_bbox_relative_error: float = 0.15
    max_volume_relative_error: float = 0.05
    require_watertight: bool = True
    require_single_component: bool = True
    accept_exact_analytic: bool = False

    def __post_init__(self) -> None:
        if (
            not math.isfinite(self.max_bbox_relative_error)
            or not math.isfinite(self.max_volume_relative_error)
            or self.max_bbox_relative_error < 0
            or self.max_volume_relative_error < 0
        ):
            raise ValueError("validation tolerances must be finite and non-negative")


@dataclass(slots=True)
class SampleValidationReport:
    sample: CADSample
    accepted: bool
    status: str
    errors: list[str] = field(default_factory=list)
    warnings: list[str] = field(default_factory=list)


class DatasetValidator:
    """Validate canonical samples without confusing mock metrics for CAD truth."""

    def __init__(
        self,
        runner: CADRunnerBase | None = None,
        policy: ValidationPolicy | None = None,
    ) -> None:
        self.runner = runner
        self.policy = policy or ValidationPolicy()

    @property
    def cache_fingerprint(self) -> str:
        if isinstance(self.runner, OpenSCADRunner):
            backend = f"openscad:{self.runner.backend}:{self.runner.version}"
        elif isinstance(self.runner, MockRunner):
            backend = "mock-runner-v1"
        elif self.runner is None:
            backend = "static-analytic-v1"
        else:
            backend = f"{type(self.runner).__module__}.{type(self.runner).__qualname__}"
        return f"validator-v1|{backend}|{self.policy!r}|{asdict(self.policy)}"

    def validate(self, sample: CADSample) -> SampleValidationReport:
        static_errors = self._static_errors(sample)
        if static_errors:
            return self._finish(sample, "rejected", False, static_errors, [])

        verification = sample.verification.model_copy(
            update={
                "actual_bbox": None,
                "bbox_relative_error": None,
                "volume_mm3": None,
                "euler_characteristic": None,
                "holes_count": None,
                "is_watertight": None,
                "components_count": None,
                "validation_status": "static",
                "validation_backend": "static",
                "accepted": False,
                "validation_error": None,
            }
        )
        sample = sample.model_copy(update={"verification": verification})
        analytic, analytic_errors, analytic_warnings = self._analytic_metrics(sample)
        if analytic_errors:
            return self._finish(sample, "rejected", False, analytic_errors, analytic_warnings)
        if analytic is not None:
            verification = sample.verification.model_copy(update=analytic)
            sample = sample.model_copy(update={"verification": verification})
            verification = sample.verification.model_copy(
                update={"validation_status": "analytic", "validation_backend": "analytic"}
            )
            sample = sample.model_copy(update={"verification": verification})

        if self.runner is None:
            descriptor = sample.metadata.get("analytic_geometry")
            exact_analytic = isinstance(descriptor, dict) and descriptor.get("exact") is True
            if analytic is not None and exact_analytic:
                if self.policy.accept_exact_analytic:
                    return self._finish(sample, "analytic", True, [], analytic_warnings)
                analytic_warnings.append("exact analytic result is provisional; pass accept_exact_analytic to admit it")
            elif analytic is not None:
                analytic_warnings.append("only analytic bounds/connectivity are known; no mesh was compiled")
            else:
                analytic_warnings.append("OpenSCAD is unavailable; static checks do not parse OpenSCAD syntax")
            return self._finish(sample, sample.verification.validation_status, False, [], analytic_warnings)

        # Results obtained from a mock or CAD process must stand on their own;
        # do not carry analytic estimates into a field presented as measured mesh data.
        verification = sample.verification.model_copy(
            update={
                "actual_bbox": None,
                "bbox_relative_error": None,
                "volume_mm3": None,
                "euler_characteristic": None,
                "holes_count": None,
                "is_watertight": None,
                "components_count": None,
                "validation_status": "static",
                "validation_backend": "static",
                "accepted": False,
                "validation_error": None,
            }
        )
        sample = sample.model_copy(update={"verification": verification})
        try:
            result = self.runner.compile(sample.code)
        except Exception as exc:
            return self._finish(
                sample,
                "rejected",
                False,
                [f"backend execution failed: {exc}"],
                analytic_warnings,
                backend="openscad" if isinstance(self.runner, OpenSCADRunner) else type(self.runner).__name__,
            )

        if isinstance(self.runner, MockRunner) or result.validation_status == "mock" or result.backend == "mock":
            warnings = [*analytic_warnings, "MockRunner output is synthetic and is never accepted as CAD validation"]
            verification = sample.verification.model_copy(
                update={"validation_status": "mock", "validation_backend": "mock", "accepted": False}
            )
            if result.error:
                warnings.append(result.error)
            sample = sample.model_copy(update={"verification": verification})
            return SampleValidationReport(sample, False, "mock", [], warnings)

        if isinstance(self.runner, OpenSCADRunner):
            metadata = dict(sample.metadata)
            metadata["validation_runtime"] = {
                "backend": "openscad-manifold",
                "openscad_version": self.runner.version,
                "max_bbox_relative_error": self.policy.max_bbox_relative_error,
                "max_volume_relative_error": self.policy.max_volume_relative_error,
            }
            sample = sample.model_copy(update={"metadata": metadata})

        errors = self._check_mesh_result(sample, result)
        if errors:
            verification = sample.verification.model_copy(
                update={
                    "validation_status": "rejected",
                    "validation_backend": result.backend,
                    "accepted": False,
                    "validation_error": "; ".join(errors),
                }
            )
            sample = sample.model_copy(update={"verification": verification})
            return SampleValidationReport(sample, False, "rejected", errors, analytic_warnings)

        assert result.bbox is not None and result.volume is not None
        updates: dict[str, Any] = {
            "actual_bbox": result.bbox,
            "bbox_relative_error": bbox_relative_error(result.bbox, sample.verification.target_bbox),
            "volume_mm3": result.volume,
            "euler_characteristic": result.euler_characteristic,
            "is_watertight": result.is_watertight,
            "components_count": result.components_count,
            "validation_status": "openscad_manifold",
            "validation_backend": result.backend,
            "accepted": True,
            "validation_error": None,
        }
        analytic_descriptor = sample.metadata.get("analytic_geometry", {})
        if isinstance(analytic_descriptor, dict) and analytic_descriptor.get("holes_count") is not None:
            updates["holes_count"] = int(analytic_descriptor["holes_count"])
        verification = sample.verification.model_copy(update=updates)
        sample = sample.model_copy(update={"verification": verification})
        return SampleValidationReport(sample, True, "openscad_manifold", [], analytic_warnings)

    def _static_errors(self, sample: CADSample) -> list[str]:
        errors: list[str] = []
        code = sample.code
        if not code.startswith(_HEADER):
            errors.append('source must start with exactly "$fn = 32;\\n"')
        cleaned_code, lexical_errors = _strip_comments(code)
        errors.extend(lexical_errors)
        if _NONFINITE.search(cleaned_code):
            errors.append("source contains a non-finite or undefined numeric token")
        if not _GEOMETRY.search(cleaned_code):
            errors.append("source contains no recognized OpenSCAD geometry operation")

        stack: list[tuple[str, int]] = []
        opening = {"(": ")", "[": "]", "{": "}"}
        closing = {value: key for key, value in opening.items()}
        for line_number, line in enumerate(cleaned_code.splitlines(), start=1):
            in_string = False
            escaped = False
            for character in line:
                if in_string:
                    if escaped:
                        escaped = False
                    elif character == "\\":
                        escaped = True
                    elif character == '"':
                        in_string = False
                    continue
                if character == '"':
                    in_string = True
                elif character in opening:
                    stack.append((character, line_number))
                elif character in closing:
                    if not stack or stack[-1][0] != closing[character]:
                        errors.append(f"unmatched {character!r} on line {line_number}")
                        break
                    stack.pop()
        if stack:
            character, line_number = stack[-1]
            errors.append(f"unclosed {character!r} opened on line {line_number}")
        expected_hash = sample.metadata.get("code_sha256")
        if expected_hash:
            actual_hash = hashlib.sha256(code.encode("utf-8")).hexdigest()
            if actual_hash != expected_hash:
                errors.append("code_sha256 does not match the OpenSCAD source")
        return errors

    def _analytic_metrics(self, sample: CADSample) -> tuple[dict[str, Any] | None, list[str], list[str]]:
        descriptor = sample.metadata.get("analytic_geometry")
        if not isinstance(descriptor, dict):
            return None, [], []
        provenance_error = self._verify_generator_provenance(sample, descriptor)
        if provenance_error is not None:
            return None, [provenance_error], []
        errors: list[str] = []
        warnings: list[str] = []
        bbox_raw = descriptor.get("bbox")
        if not isinstance(bbox_raw, (list, tuple)) or len(bbox_raw) != 3:
            return None, ["analytic descriptor has no three-dimensional bbox"], []
        try:
            bbox = tuple(float(value) for value in bbox_raw)
            if any(not math.isfinite(value) or value <= 0 for value in bbox):
                raise ValueError("bbox must be finite and positive")
            error = bbox_relative_error(bbox, sample.verification.target_bbox)
            if error > self.policy.max_bbox_relative_error:
                errors.append(
                    f"analytic bbox differs from target by {error:.3%}, above "
                    f"{self.policy.max_bbox_relative_error:.3%}"
                )
        except (TypeError, ValueError) as exc:
            return None, [f"invalid analytic bbox: {exc}"], []

        if sample.layer == "wire":
            graph_errors = self._check_wire_graph(sample)
            errors.extend(graph_errors)
            try:
                radius = float(descriptor["member_radius_mm"])
                if not math.isfinite(radius) or radius <= 0:
                    raise ValueError("member radius must be finite and positive")
                centers = sample.auxiliary_ground_truth.nodes
                derived_bbox = tuple(
                    max(point[axis] for point in centers) - min(point[axis] for point in centers) + 2 * radius
                    for axis in range(3)
                )
                derived_error = bbox_relative_error(derived_bbox, bbox)
                if derived_error > 1e-9:
                    errors.append(
                        f"wire node bounds plus member radius disagree with descriptor by {derived_error:.3%}"
                    )
            except (KeyError, TypeError, ValueError) as exc:
                errors.append(f"could not derive wire bounds from graph: {exc}")
            if not descriptor.get("exact_bbox", False):
                warnings.append("wireframe bounds are not marked exact by the generator")
            return {"actual_bbox": bbox, "bbox_relative_error": error}, errors, warnings

        if sample.layer == "voxel" and descriptor.get("exact") is True:
            try:
                volume = float(descriptor["volume_mm3"])
                euler = int(descriptor["euler_characteristic"])
                components = int(descriptor["components_count"])
                watertight = bool(descriptor["is_watertight"])
                holes = int(descriptor["holes_count"])
                if not math.isfinite(volume) or volume <= 0 or volume > math.prod(bbox):
                    raise ValueError("analytic volume is non-finite, non-positive, or exceeds its bbox")
                if components != 1 or not watertight:
                    raise ValueError("analytic descriptor must describe one watertight solid")
                if 2 - euler < 0 or (2 - euler) % 2:
                    raise ValueError("Euler characteristic is inconsistent with a connected closed orientable surface")
                return {
                    "actual_bbox": bbox,
                    "bbox_relative_error": error,
                    "volume_mm3": volume,
                    "euler_characteristic": euler,
                    "is_watertight": watertight,
                    "components_count": components,
                    "holes_count": holes,
                }, errors, warnings
            except (KeyError, TypeError, ValueError) as exc:
                return None, [f"invalid exact analytic descriptor: {exc}"], warnings

        warnings.append("analytic descriptor does not provide exact solid-volume/topology metrics")
        return {"actual_bbox": bbox, "bbox_relative_error": error}, errors, warnings

    @staticmethod
    def _verify_generator_provenance(sample: CADSample, descriptor: dict[str, Any]) -> str | None:
        """Recreate generated source by seed/index before trusting analytic labels."""
        source_by_layer = {"voxel": "voxel_csg_gen", "wire": "wire_truss_gen"}
        expected_source = source_by_layer.get(sample.layer)
        if expected_source is None:
            return f"analytic descriptors are not implemented for layer {sample.layer!r}"
        if sample.metadata.get("source") != expected_source or sample.metadata.get("generator_version") != 1:
            return "analytic metrics require provenance from a supported generator/version"
        if not sample.metadata.get("code_sha256"):
            return "analytic metrics require a source code_sha256"
        try:
            seed = int(sample.metadata["generator_seed"])
            index = int(sample.metadata["generator_index"])
            if index < 0:
                raise ValueError("generator index must be non-negative")
            if sample.layer == "voxel":
                from src.data.generators.voxel_csg_gen import VoxelCSGGenerator

                regenerated = VoxelCSGGenerator(seed).generate(index)
            else:
                from src.data.generators.wire_truss_gen import WireTrussGenerator

                regenerated = WireTrussGenerator(seed).generate(index)
        except (KeyError, TypeError, ValueError) as exc:
            return f"invalid generator seed/index metadata: {exc}"
        if regenerated.code != sample.code:
            return "analytic code does not match deterministic generator output for its recorded seed/index"
        if regenerated.verification.target_bbox != sample.verification.target_bbox:
            return "analytic target bbox does not match deterministic generator output"
        if regenerated.metadata.get("analytic_geometry") != descriptor:
            return "analytic descriptor does not match deterministic generator output"
        if regenerated.metadata.get("generator_parameters") != sample.metadata.get("generator_parameters"):
            return "generator parameters do not match deterministic generator output"
        if sample.layer == "wire" and regenerated.auxiliary_ground_truth != sample.auxiliary_ground_truth:
            return "wire auxiliary graph does not match deterministic generator output"
        return None

    @staticmethod
    def _check_wire_graph(sample: CADSample) -> list[str]:
        nodes = sample.auxiliary_ground_truth.nodes
        edges = sample.auxiliary_ground_truth.edges
        if not nodes:
            return ["wire sample has no graph nodes"]
        if not edges:
            return ["wire sample has no graph edges"]
        adjacency: list[set[int]] = [set() for _ in nodes]
        for edge_index, (start, end) in enumerate(edges):
            if start == end:
                return [f"wire edge {edge_index} is a self-loop"]
            if start < 0 or end < 0 or start >= len(nodes) or end >= len(nodes):
                return [f"wire edge {edge_index} references a missing node"]
            if any(not math.isfinite(value) for value in (*nodes[start], *nodes[end])):
                return [f"wire edge {edge_index} contains non-finite coordinates"]
            if math.dist(nodes[start], nodes[end]) <= 0:
                return [f"wire edge {edge_index} has zero length"]
            adjacency[start].add(end)
            adjacency[end].add(start)
        if any(not neighbors for neighbors in adjacency):
            return ["wire graph contains an isolated node"]
        visited: set[int] = set()
        queue = deque([0])
        while queue:
            node = queue.popleft()
            if node in visited:
                continue
            visited.add(node)
            queue.extend(adjacency[node] - visited)
        if len(visited) != len(nodes):
            return [f"wire graph is disconnected ({len(visited)} of {len(nodes)} nodes are reachable)"]
        return []

    def _check_mesh_result(self, sample: CADSample, result: VerificationResult) -> list[str]:
        errors: list[str] = []
        if result.error:
            errors.append(result.error)
        if result.validation_status != "openscad_manifold" or not result.backend.startswith("openscad-manifold"):
            errors.append("only a successful OpenSCAD manifold result can be accepted")
        if isinstance(self.runner, OpenSCADRunner) and self.runner.version == "unknown":
            errors.append("OpenSCAD version could not be determined; refusing an unauditable acceptance")
        if result.bbox is None or len(result.bbox) != 3:
            errors.append("CAD backend did not return a three-dimensional bbox")
        else:
            if any(not math.isfinite(float(value)) or float(value) <= 0 for value in result.bbox):
                errors.append("measured bbox contains non-finite or non-positive dimensions")
            else:
                error = bbox_relative_error(result.bbox, sample.verification.target_bbox)
                if error > self.policy.max_bbox_relative_error:
                    errors.append(
                        f"bbox error {error:.3%} exceeds {self.policy.max_bbox_relative_error:.3%}"
                    )
        if result.volume is None or not math.isfinite(result.volume) or result.volume <= 0:
            errors.append("CAD backend did not return a finite positive volume")
        if self.policy.require_watertight and result.is_watertight is not True:
            errors.append("mesh is not watertight")
        if result.components_count is None or result.components_count < 1:
            errors.append("CAD backend returned no connected components")
        elif self.policy.require_single_component and result.components_count != 1:
            errors.append(f"expected one connected component, got {result.components_count}")
        if result.euler_characteristic is None:
            errors.append("CAD backend did not return an Euler characteristic")
        elif result.is_watertight and result.components_count == 1:
            numerator = 2 - result.euler_characteristic
            if numerator < 0 or numerator % 2:
                errors.append(
                    f"Euler characteristic {result.euler_characteristic} is inconsistent "
                    "with a connected closed orientable surface"
                )
        descriptor = sample.metadata.get("analytic_geometry", {})
        if (
            isinstance(descriptor, dict)
            and descriptor.get("exact") is True
            and descriptor.get("volume_mm3") is not None
            and result.volume is not None
            and result.volume > 0
        ):
            expected_volume = float(descriptor["volume_mm3"])
            volume_error = abs(result.volume - expected_volume) / expected_volume
            if volume_error > self.policy.max_volume_relative_error:
                errors.append(
                    f"volume differs from analytic expectation by {volume_error:.3%}, "
                    f"above {self.policy.max_volume_relative_error:.3%}"
                )
        if (
            isinstance(descriptor, dict)
            and descriptor.get("exact") is True
            and result.euler_characteristic is not None
            and result.euler_characteristic != descriptor.get("euler_characteristic")
        ):
            errors.append(
                f"Euler characteristic {result.euler_characteristic} differs from analytic "
                f"expectation {descriptor.get('euler_characteristic')}"
            )
        return errors

    @staticmethod
    def _finish(
        sample: CADSample,
        status: str,
        accepted: bool,
        errors: list[str],
        warnings: list[str],
        backend: str | None = None,
    ) -> SampleValidationReport:
        updates: dict[str, Any] = {
            "validation_status": status,
            "accepted": accepted,
            "validation_error": "; ".join(errors) if errors else None,
        }
        if backend is not None:
            updates["validation_backend"] = backend
        verification = sample.verification.model_copy(update=updates)
        validated_sample = sample.model_copy(update={"verification": verification})
        return SampleValidationReport(validated_sample, accepted, status, errors, warnings)
