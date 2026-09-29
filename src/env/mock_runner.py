"""Deterministic CAD verifier for CPU-only development and unit tests."""

from __future__ import annotations

import math
import re

from src.env.cad_interface import CADRunnerBase, VerificationResult

_FACET_HEADER = "$fn = 32;\n"
_NUMBER = r"[-+]?(?:\d+(?:\.\d*)?|\.\d+)(?:[eE][-+]?\d+)?"
_BBOX_COMMENT = re.compile(r"//\s*target_bbox\s*:\s*(" + _NUMBER + r")\s*,\s*(" + _NUMBER + r")\s*,\s*(" + _NUMBER + r")")
_CUBE = re.compile(r"cube\s*\(\s*\[\s*(" + _NUMBER + r")\s*,\s*(" + _NUMBER + r")\s*,\s*(" + _NUMBER + r")")
_CYLINDER = re.compile(r"cylinder\s*\(\s*h\s*=\s*(" + _NUMBER + r")\s*,\s*r\s*=\s*(" + _NUMBER + r")")


class MockRunner(CADRunnerBase):
    """Return stable synthetic mesh metrics without requiring OpenSCAD."""

    def compile(self, code: str) -> VerificationResult:
        if not code.startswith(_FACET_HEADER):
            return VerificationResult(False, None, None, None, None,
                                      'source must start with "$fn = 32;\\n"', backend="mock", validation_status="mock")

        bbox_match = _BBOX_COMMENT.search(code)
        if bbox_match:
            bbox = tuple(float(value) for value in bbox_match.groups())
        else:
            cube_match = _CUBE.search(code)
            if cube_match:
                bbox = tuple(abs(float(value)) for value in cube_match.groups())
            else:
                cylinder_match = _CYLINDER.search(code)
                if cylinder_match:
                    height, radius = (abs(float(value)) for value in cylinder_match.groups())
                    bbox = (2.0 * radius, 2.0 * radius, height)
                else:
                    return VerificationResult(
                        False, None, None, None, None, "could not infer geometry bounds", backend="mock", validation_status="mock"
                    )
        if not all(math.isfinite(value) and value > 0 for value in bbox):
            return VerificationResult(False, bbox, None, None, None,
                                      "inferred bounding box must be finite and positive", backend="mock", validation_status="mock")
        volume = float(bbox[0] * bbox[1] * bbox[2] * 0.8)
        return VerificationResult(
            True, bbox, volume, 2, 1, error=None, backend="mock", validation_status="mock"
        )


# Backwards-compatible descriptive name used in the architecture document.
MockCADRunner = MockRunner
