"""Helpers shared by the ``place1`` families: sizes, allowances, probes."""

from __future__ import annotations

from typing import Sequence

from tools.dataset_gen2.common import Rng
from tools.dataset_place1.core4 import CodePlan, Probe
from tools.dataset_place1.prompts4 import (
    INCH_TABLE,
    allowance_sentence_en,
    allowance_sentence_ru,
)


def inch_or_round(
    rng: Rng,
    values: Sequence[float],
    *,
    chance: float = 0.18,
    max_mm: float | None = None,
    min_mm: float | None = None,
) -> tuple[float, str | None]:
    """Either a round metric size, or an exact imperial fraction (with label)."""
    table = [
        (millimetres, label)
        for millimetres, label in INCH_TABLE
        if (max_mm is None or millimetres <= max_mm) and (min_mm is None or millimetres >= min_mm)
    ]
    if table and rng.chance(chance):
        return rng.choice(table)
    return rng.grid(values), None


TOLERANCE_SETS = ((0.05, 0.3), (0.1, 0.3), (0.1, 0.5), (0.15, 0.5))


def tolerance_note(rng: Rng, plan: CodePlan, chance: float = 0.05) -> tuple[float, float] | None:
    """Sometimes the prompt carries shop tolerances.

    Both numbers of the sentence (``±0.1`` and ``0.3``) are then declared in the
    parameter header, so the "every prompt number lives in the code" law holds
    for the tolerance sentence as well.
    """
    if not rng.chance(chance):
        return None
    seat, free = rng.choice(TOLERANCE_SETS)
    plan.param("seat_tol", seat, "tolerance at the seating features")
    plan.param("free_tol", free, "general tolerance on the free sizes")
    return (seat, free)


def hole_with_allowance(
    rng: Rng,
    plan: CodePlan,
    pool: Sequence[float],
    *,
    chance: float = 0.22,
    name: str = "hole_d",
) -> tuple[float, str | None, str | None]:
    """Declare the hole diameter.

    With ``chance`` probability the prompt talks about printing tolerances: the
    code then carries the nominal diameter *and* the allowance and derives the
    drilled diameter from them, so all three numbers of the sentence exist in the
    code.  Otherwise the hole is a plain parameter.
    """
    nominal = rng.grid(pool)
    if rng.chance(chance):
        allowance = rng.choice((0.15, 0.2, 0.25, 0.3))
        plan.param("bore_d", nominal, "nominal hole diameter from the drawing")
        plan.param("print_allowance", allowance, "clearance added for printing")
        hole_d = round(nominal + allowance, 3)
        plan.derived(name, "bore_d + print_allowance", hole_d, "hole diameter as printed")
        return (
            hole_d,
            allowance_sentence_ru(hole_d, nominal, allowance),
            allowance_sentence_en(hole_d, nominal, allowance),
        )
    plan.param(name, nominal, "hole diameter")
    return nominal, None, None


def hole_probes(
    centres: Sequence[Sequence[float]],
    hole_d: float,
    *,
    z: float,
    thickness: float,
    size: float | None = None,
    label: str = "hole",
) -> list[Probe]:
    """One ``empty`` probe in the middle of every drilled hole."""
    # 0.5 * diameter keeps even the corners of the probe cube inside the round
    # hole (half diagonal 0.43 d < 0.5 d), so a passing probe means a real hole
    probe_size = size if size is not None else min(hole_d * 0.5, thickness * 0.5, 3.0)
    return [
        Probe((float(centre[0]), float(centre[1]), float(z)), "empty", probe_size, f"{label} {index}")
        for index, centre in enumerate(centres)
    ]


def solid_probe(point: Sequence[float], size: float, label: str) -> Probe:
    return Probe((float(point[0]), float(point[1]), float(point[2])), "solid", size, label)


def empty_probe(point: Sequence[float], size: float, label: str) -> Probe:
    return Probe((float(point[0]), float(point[1]), float(point[2])), "empty", size, label)


def mirror_centres(x: float, y: float) -> list[list[float]]:
    """The four corners of a rectangle, clockwise from (+x, +y)."""
    return [[x, y], [-x, y], [-x, -y], [x, -y]]


def centre_expressions(centres: Sequence[Sequence[float]]) -> list[str]:
    return [f"[{x}, {y}]" for x, y in centres]
