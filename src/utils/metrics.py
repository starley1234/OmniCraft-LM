"""Lightweight geometry and topology metrics independent of CAD libraries."""

from __future__ import annotations

import math
from collections.abc import Sequence


def bbox_relative_error(predicted: Sequence[float], target: Sequence[float]) -> float:
    """Return the largest per-axis relative bbox deviation."""
    if len(predicted) != 3 or len(target) != 3:
        raise ValueError("predicted and target bounding boxes must each have three dimensions")
    if any(not math.isfinite(float(value)) or float(value) <= 0 for value in target):
        raise ValueError("target bbox dimensions must be finite and positive")
    if any(not math.isfinite(float(value)) for value in predicted):
        raise ValueError("predicted bbox dimensions must be finite")
    return max(abs(float(actual) - float(expected)) / float(expected) for actual, expected in zip(predicted, target))


def bbox_axis_relative_errors(predicted: Sequence[float], target: Sequence[float]) -> tuple[float, float, float]:
    """Return X/Y/Z relative errors separately for actionable CAD reports."""
    if len(predicted) != 3 or len(target) != 3:
        raise ValueError("predicted and target bounding boxes must each have three dimensions")
    if any(not math.isfinite(float(value)) or float(value) <= 0 for value in target):
        raise ValueError("target bbox dimensions must be finite and positive")
    if any(not math.isfinite(float(value)) for value in predicted):
        raise ValueError("predicted bbox dimensions must be finite")
    return tuple(
        abs(float(actual) - float(expected)) / float(expected)
        for actual, expected in zip(predicted, target)
    )  # type: ignore[return-value]


def bbox_within_tolerance(predicted: Sequence[float], target: Sequence[float], tolerance: float = 0.15) -> bool:
    if tolerance < 0:
        raise ValueError("tolerance must be non-negative")
    return bbox_relative_error(predicted, target) <= tolerance


def euler_characteristic(vertices: int, edges: int, faces: int) -> int:
    """Compute V - E + F for a mesh or cell complex."""
    return int(vertices - edges + faces)


def genus_from_euler(euler_value: int, components_count: int = 1) -> int:
    """Infer total genus for a closed orientable surface with known components.

    For ``C`` closed connected orientable components, chi = 2C - 2G.
    """
    if components_count < 1:
        raise ValueError("components_count must be at least one")
    numerator = 2 * components_count - euler_value
    if numerator < 0 or numerator % 2:
        raise ValueError("Euler characteristic is inconsistent with closed orientable surfaces")
    return numerator // 2


def topology_summary(
    *, vertices: int, edges: int, faces: int, components_count: int = 1
) -> dict[str, int]:
    if components_count < 1:
        raise ValueError("components_count must be at least one")
    euler = euler_characteristic(vertices, edges, faces)
    return {
        "euler_characteristic": euler,
        "components_count": components_count,
        "genus": genus_from_euler(euler, components_count),
    }
