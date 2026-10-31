"""Shared machinery of the ``place1`` corpus: code layout, part model, gate.

The corpus teaches *feature placement*: the prompt states where every feature
sits, the code derives those positions from the header variables and drives the
actual cut with the very same array (``feature_centers``).  This module provides

* :class:`CodePlan` — renders the parameter header, the derived-position block
  and the geometry of one sample in a fixed, readable shape;
* :class:`PlacePart` / :class:`Probe` — one sample and the geometric probes that
  prove a feature really is where the manifest says;
* :func:`check_place` — the local gate: manifold evaluation, single component,
  bounding box, and every probe (a probe is a small cube intersected with the
  solid; an ``empty`` probe must vanish, a ``solid`` probe must survive whole).
"""

from __future__ import annotations

import hashlib
from dataclasses import dataclass, field
from typing import Any, Sequence

import manifold3d as m3d

from tools.dataset_gen2.common import fmt

CLEARANCE_MM = 0.2  # request: never touch a face exactly, always >= 0.2 mm
MAX_SOURCE_BYTES = 12000


# ---------------------------------------------------------------------------
# code layout
# ---------------------------------------------------------------------------

class CodePlan:
    """Assemble one .scad file: banner, parameters, derived positions, body."""

    def __init__(self, title: str, summary: str = "") -> None:
        self.title = title
        self.summary = summary
        self.params: list[tuple[str, str, float | list[float], str]] = []
        self.derived_vars: list[tuple[str, str, float | list[float], str]] = []

    # -- declaration helpers ------------------------------------------------
    def param(self, name: str, value: float | Sequence[float], comment: str) -> str:
        """A header parameter written as a literal (number or plain list)."""
        return self._declare(self.params, name, _literal(value), value, comment)

    def derived(self, name: str, expression: str, value: float | Sequence[float], comment: str) -> str:
        """A header variable computed from earlier ones (no magic literals)."""
        return self._declare(self.derived_vars, name, expression.strip(), value, comment)

    def _declare(self, block: list, name: str, expression: str, value, comment: str) -> str:
        if any(existing == name for existing, _, _, _ in self.params + self.derived_vars):
            raise ValueError(f"duplicate declaration {name!r} in {self.title}")
        block.append((name, expression, value, comment))
        return name

    # -- rendering ----------------------------------------------------------
    def render(self, body: str) -> str:
        lines: list[str] = ["$fn = 32;", ""]
        lines.append("// " + "-" * 70)
        lines.append(f"// {self.title}")
        if self.summary:
            lines.append(f"// {self.summary}")
        lines.append("// " + "-" * 70)
        lines.append("")
        if self.params:
            lines.append("// --- parameters (mm) ---")
            lines.extend(_render_block(self.params))
        if self.derived_vars:
            lines.append("")
            lines.append("// --- derived feature positions (mm) ---")
            lines.extend(_render_block(self.derived_vars, show_value=True))
        lines.append("")
        lines.append(body.strip("\n"))
        return "\n".join(lines).rstrip() + "\n"


def precise(value: float, digits: int = 3) -> str:
    """Number formatted with enough decimals to stay exact to the last digit."""
    text = fmt(round(float(value), digits), digits)
    return text


def _literal(value: float | Sequence[float]) -> str:
    if isinstance(value, (int, float)):
        return precise(float(value))
    return "[" + ", ".join(precise(float(item)) for item in value) + "]"


def _render_block(
    block: Sequence[tuple[str, str, Any, str]], show_value: bool = False, column: int = 34
) -> list[str]:
    """``name = expression;  // note`` lines, aligned into a column."""
    lefts = [f"{name} = {expression};" for name, expression, _, _ in block]
    single = [len(left) for left in lefts if "\n" not in left]
    width = min(max(single or [18]), column)
    lines: list[str] = []
    for left, (_, _, value, comment) in zip(lefts, block):
        if show_value and value is not None:
            if isinstance(value, (int, float)):
                note = f"// = {fmt(float(value))}"
            else:
                note = "// = [" + ", ".join(fmt(float(item)) for item in value) + "]"
            if comment:
                note = f"{note}   {comment}"
        else:
            note = f"// {comment}" if comment else ""
        if "\n" in left:
            body = left.split("\n")
            if note:
                body[-1] = f"{body[-1]}   {note}"
            lines.extend(body)
        elif note:
            lines.append(f"{left.ljust(width)}  {note}")
        else:
            lines.append(left)
    return lines


def array_expression(items: Sequence[str], indent: str = "  ") -> str:
    """Render ``[[..], [..]]`` as a multi-line list of expressions."""
    if not items:
        return "[]"
    body = ",\n".join(f"{indent}{item}" for item in items)
    return "[\n" + body + "\n]"


# ---------------------------------------------------------------------------
# one sample
# ---------------------------------------------------------------------------

@dataclass
class Probe:
    """A small cube that must be fully inside a void or fully inside material."""

    point: tuple[float, float, float]
    expect: str  # "empty" or "solid"
    size: float = 1.0
    label: str = ""


@dataclass
class PlacePart:
    family: str
    variant: str
    code: str
    prompt_ru: str
    prompt_en: str
    bbox: tuple[float, float, float]
    params: dict[str, float]
    placement: dict[str, Any]
    probes: list[Probe] = field(default_factory=list)
    notes: str = ""

    @property
    def sha256(self) -> str:
        return hashlib.sha256(self.code.encode("utf-8")).hexdigest()

    def manifest_row(self, file_name: str, row_id: str) -> dict[str, Any]:
        return {
            "id": row_id,
            "file": file_name,
            "family": self.family,
            "variant": self.variant,
            "prompt_ru": self.prompt_ru,
            "prompt_en": self.prompt_en,
            "expected_bbox_mm": [round(value, 3) for value in self.bbox],
            "parameters": {key: round(value, 3) for key, value in self.params.items()},
            "placement": self.placement,
            "graph": None,
        }


@dataclass
class PlaceCheck:
    ok: bool
    errors: list[str] = field(default_factory=list)
    measured_bbox: tuple[float, float, float] | None = None
    volume: float = 0.0
    components: int = 0
    relative_error: tuple[float, float, float] = (0.0, 0.0, 0.0)
    probe_failures: list[str] = field(default_factory=list)


def make_part(
    *,
    family: str,
    variant: str,
    rng,
    plan: CodePlan,
    body: str,
    bbox: Sequence[float],
    params: dict[str, float],
    placement: dict[str, Any],
    probes: Sequence[Probe],
    ru_noun: str,
    en_noun: str,
    ru_features: Sequence[str],
    en_features: Sequence[str],
    tolerance: bool = False,
    notes: str = "",
) -> PlacePart:
    """Render one sample: code first, then the prompt that quotes that code."""
    from tools.dataset_place1.prompts4 import build_prompt4

    code = plan.render(body)
    declared = {name for name, _, _, _ in plan.params}
    tol_pair = None
    if {"seat_tol", "free_tol"} <= declared:
        tol_pair = (
            float(next(v for n, _, v, _ in plan.params if n == "seat_tol")),
            float(next(v for n, _, v, _ in plan.params if n == "free_tol")),
        )
    prompt_ru, prompt_en = build_prompt4(
        rng,
        ru_noun=ru_noun,
        en_noun=en_noun,
        bbox=bbox,
        ru_features=ru_features,
        en_features=en_features,
        tolerance=tolerance,
        tol_pair=tol_pair,
    )
    return PlacePart(
        family=family,
        variant=variant,
        code=code,
        prompt_ru=prompt_ru,
        prompt_en=prompt_en,
        bbox=(float(bbox[0]), float(bbox[1]), float(bbox[2])),
        params=dict(params),
        placement=placement,
        probes=list(probes),
        notes=notes,
    )


def feature_lines(entries: Sequence[tuple[str, str]]) -> str:
    """Render ``["[a, b]", "[c, d]"]`` as the body of an array assignment."""
    return ",\n".join(f"  {entry}" for entry in entries)


def check_place(part: PlacePart, max_relative_error: float = 0.03, probes: bool = True) -> PlaceCheck:
    """Evaluate the sample with the manifold kernel and audit it."""
    from tools.dataset_gen2.miniscad import MiniScadError, evaluate_3d

    errors: list[str] = []
    lines = part.code.splitlines()
    if not lines or lines[0] != "$fn = 32;":
        errors.append("missing '$fn = 32;' header")
    if any(token in part.code for token in ("import(", "surface(", "text(", "children(", "rands(", "echo(")):
        errors.append("forbidden construct in source")
    if len(part.code.encode("utf-8")) > MAX_SOURCE_BYTES:
        errors.append("source exceeds 12 kB")
    if any(bad in part.code for bad in ("nan", "undef", "-0.0;")):
        errors.append("suspicious token in source")
    try:
        manifold = evaluate_3d(part.code)
    except MiniScadError as exc:
        return PlaceCheck(False, errors + [f"evaluation failed: {exc}"])

    box = manifold.bounding_box()
    measured = (box[3] - box[0], box[4] - box[1], box[5] - box[2])
    components = manifold.decompose()
    relative = tuple(
        abs(measured[index] - part.bbox[index]) / max(part.bbox[index], 1e-9) for index in range(3)
    )
    if len(components) != 1:
        errors.append(f"expected a single connected solid, got {len(components)}")
    if any(error > max_relative_error for error in relative):
        errors.append(
            "bounding box mismatch: measured "
            f"{tuple(round(value, 3) for value in measured)} vs declared "
            f"{tuple(round(value, 3) for value in part.bbox)}"
        )
    if manifold.volume() <= 0:
        errors.append("non-positive volume")

    failures: list[str] = []
    if probes:
        for probe in part.probes:
            size = float(probe.size)
            # a probe that hangs outside the declared envelope would "pass" as a
            # void for free, so an out-of-bounds probe is an error of its own
            if any(
                probe.point[axis] - size / 2.0 < box[axis] - 1e-6
                or probe.point[axis] + size / 2.0 > box[axis + 3] + 1e-6
                for axis in range(3)
            ):
                failures.append(f"{probe.label or probe.point}: probe lies outside the part envelope")
                continue
            cube = m3d.Manifold.cube([size, size, size], True).translate(list(probe.point))
            part_volume = (manifold ^ cube).volume()
            ratio = part_volume / (size ** 3)
            if probe.expect == "empty" and ratio > 0.02:
                failures.append(f"{probe.label or probe.point}: expected a void, found {ratio:.0%} material")
            elif probe.expect == "solid" and ratio < 0.98:
                failures.append(f"{probe.label or probe.point}: expected material, found {ratio:.0%}")
    if failures:
        errors.extend([f"probe: {failure}" for failure in failures])

    return PlaceCheck(
        not errors,
        errors,
        measured,  # type: ignore[arg-type]
        manifold.volume(),
        len(components),
        relative,  # type: ignore[arg-type]
        failures,
    )
