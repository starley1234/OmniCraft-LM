"""Sample model and audit for the sketch1 corpus.

A sketch1 sample is one flat profile plus exactly one extrusion: it is the
ground truth SketchCanvas is supposed to predict (``profile`` in the manifest)
and the code the model has to write (``polygon(points = profile)`` plus one
``linear_extrude`` / ``rotate_extrude``).
"""

from __future__ import annotations

import json
import math
import re
from dataclasses import dataclass, field
from typing import Any, Sequence

from tools.dataset_gen2.common import Part, Rng, fmt
from tools.dataset_gen2.prompts import build_prompt
from tools.dataset_gen3.prompts3 import tail3
from tools.dataset_sketch1.geom1 import (
    MAX_POINTS,
    MIN_POINTS,
    area,
    bbox2,
    centroid_x,
    perimeter,
    polygon_literal,
    validate_profile,
)

MAX_BYTES = 12000
BBOX_TOLERANCE = 0.03
FORBIDDEN = (
    "import(",
    "surface(",
    "text(",
    "children(",
    "rands(",
    "echo(",
    "hull(",
    "difference(",
    "union(",
    "intersection(",
    "linear_extrude(scale",
)

PROFILE_KINDS = ("linear", "rotate")


@dataclass
class SketchPart:
    """One sketch sample: profile, extrusion, source and prompts."""

    family: str
    variant: str
    code: str
    bbox: tuple[float, float, float]
    params: dict[str, float]
    prompt_ru: str
    prompt_en: str
    profile: list[tuple[float, float]]
    extrude: dict[str, Any]
    notes: str = ""
    tags: tuple[str, ...] = ()

    @property
    def kind(self) -> str:
        return str(self.extrude["kind"])

    def manifest_row(self, file_name: str) -> dict[str, Any]:
        return {
            "file": file_name,
            "family": self.family,
            "prompt_ru": self.prompt_ru,
            "prompt_en": self.prompt_en,
            "expected_bbox_mm": [round(value, 3) for value in self.bbox],
            "parameters": {key: round(value, 3) for key, value in self.params.items()},
            "graph": None,
            "profile": [[round(x, 3), round(y, 3)] for x, y in self.profile],
            "extrude": dict(self.extrude),
        }


# ---------------------------------------------------------------------------
# emission
# ---------------------------------------------------------------------------


def render_sketch(title: str, summary: str, profile, extrude: dict[str, Any], comments: Sequence[str] = ()) -> str:
    """Emit the .scad file: header, profile array, then the one extrusion."""
    kind = str(extrude["kind"])
    body = ["$fn = 32;", ""]
    body.append("// " + "-" * 70)
    body.append(f"// {title}" + (f": {summary}" if summary else ""))
    body.append("// " + "-" * 70)
    body.append("")
    body.append("// --- parameters (mm) ---")
    if kind == "linear":
        height = float(extrude["height_mm"])
        left = f"profile_height = {fmt(height)};"
        body.append(left + " " * max(2, 26 - len(left)) + "// extrusion height")
    else:
        left = "revolve_angle = 360;"
        body.append(left + " " * max(2, 26 - len(left)) + "// full turn around the Z axis")
    points_literal = polygon_literal(profile)
    left = "profile_points = " + str(len(profile)) + ";"
    body.append(left + " " * max(2, 26 - len(left)) + "// points of the closed outline")
    body.append("")
    body.append(
        f"profile = {points_literal};  // single closed polygon,"
        f" {len(profile)} points, counter clockwise"
    )
    if comments:
        body.append("")
        for comment in comments:
            body.append(f"// {comment}")
    body.append("")
    body.append("// --- the one profile operation ---")
    if kind == "linear":
        body.append("linear_extrude(height = profile_height) polygon(points = profile);")
    else:
        body.append("rotate_extrude(angle = revolve_angle) polygon(points = profile);")
    return "\n".join(body).rstrip() + "\n"


def finish_sketch(
    rng: Rng,
    *,
    family: str,
    variant: str,
    title: str,
    summary: str,
    profile: list[tuple[float, float]],
    extrude: dict[str, Any],
    bbox: tuple[float, float, float],
    params: dict[str, float],
    ru_nouns: Sequence[str],
    en_nouns: Sequence[str],
    features_ru: Sequence[str],
    features_en: Sequence[str],
    units: tuple[float, str] | None = None,
    feature_count: tuple[int, int] = (2, 3),
    comments: Sequence[str] = (),
) -> SketchPart:
    """Compose prompts (with the profile sentence) and build the sample."""
    code = render_sketch(title, summary, profile, extrude, comments)
    count = len(profile)
    kind_ru = "выдавливается на %.1f мм" % extrude["height_mm"] if extrude["kind"] == "linear" else "заворачивается вокруг оси Z"
    kind_en = "extruded to %.1f mm" % extrude["height_mm"] if extrude["kind"] == "linear" else "revolved around the Z axis"
    profile_ru = rng.choice(
        (
            f"Профиль — один замкнутый полигон из {count} точек, он {kind_ru}.",
            f"Контур одним полигоном: {count} точек, обход против часовой стрелки, затем {kind_ru}.",
            f"Деталь {kind_ru} из одного полигона на {count} точек.",
            f"Полигон из {count} точек (ccw) и {kind_ru} — больше ничего.",
        )
    )
    profile_en = rng.choice(
        (
            f"The profile is a single closed polygon of {count} points, {kind_en}.",
            f"One polygon, {count} points, counter clockwise, then {kind_en}.",
            f"The part is {kind_en} from a {count} point outline.",
            f"A {count} point ccw polygon, {kind_en}, nothing else.",
        )
    )
    ru_sentences = [profile_ru] + [sentence[0].upper() + sentence[1:] + "." for sentence in features_ru]
    en_sentences = [profile_en] + [sentence[0].upper() + sentence[1:] + "." for sentence in features_en]
    prompt_ru, prompt_en = build_prompt(
        rng,
        ru_nouns=ru_nouns,
        en_nouns=en_nouns,
        bbox=bbox,
        ru_feature_sentences=ru_sentences,
        en_feature_sentences=en_sentences,
        feature_count=max(2, rng.integer(feature_count[0], feature_count[1]) + 1),
        extra_tail=False,
    )
    ru_tail, en_tail, _ = tail3(rng, units)
    prompt_ru = re.sub(r"\s+", " ", f"{prompt_ru} {ru_tail}").strip()
    prompt_en = re.sub(r"\s+", " ", f"{prompt_en} {en_tail}").strip()
    return SketchPart(
        family=family,
        variant=variant,
        code=code,
        bbox=bbox,
        params=params,
        prompt_ru=prompt_ru,
        prompt_en=prompt_en,
        profile=[(round(x, 3), round(y, 3)) for x, y in profile],
        extrude=dict(extrude),
    )


# ---------------------------------------------------------------------------
# audit
# ---------------------------------------------------------------------------


@dataclass
class SketchCheck:
    ok: bool
    errors: list[str] = field(default_factory=list)
    measured_bbox: tuple[float, float, float] | None = None
    volume: float = 0.0
    profile_area: float = 0.0
    profile_perimeter: float = 0.0
    relative_error: tuple[float, float, float] = (0.0, 0.0, 0.0)


def parse_profile(code: str) -> list[tuple[float, float]] | None:
    match = re.search(r"^profile = (\[.*\]);", code, flags=re.MULTILINE)
    if not match:
        return None
    try:
        data = json.loads(match.group(1))
    except json.JSONDecodeError:
        return None
    return [(float(point[0]), float(point[1])) for point in data]


def check_sketch(part: SketchPart, max_relative_error: float = BBOX_TOLERANCE, stl: bool = True) -> SketchCheck:
    """Full audit: source rules, profile rules, mesh, profile <-> mesh agreement."""
    from tools.dataset_gen2.miniscad import evaluate_3d

    errors: list[str] = []
    lines = part.code.splitlines()
    if not lines or lines[0] != "$fn = 32;":
        errors.append("first line is not '$fn = 32;'")
    if len(part.code.encode("utf-8")) > MAX_BYTES:
        errors.append(f"source is larger than {MAX_BYTES} bytes")
    for token in FORBIDDEN:
        if token in part.code:
            errors.append(f"forbidden construct {token!r}")
    linear = part.code.count("linear_extrude(")
    rotate = part.code.count("rotate_extrude(")
    if linear + rotate != 1 or linear > 1 or rotate > 1:
        errors.append(f"expected exactly one extrusion, found linear={linear} rotate={rotate}")
    if part.kind == "linear" and linear != 1:
        errors.append("manifest says linear but the code does not extrude linearly")
    if part.kind == "rotate" and rotate != 1:
        errors.append("manifest says rotate but the code does not revolve")
    if "polygon(points = profile)" not in part.code:
        errors.append("code does not use polygon(points = profile)")

    profile = parse_profile(part.code)
    if profile is None:
        errors.append("could not parse the profile array")
    else:
        if [(round(x, 3), round(y, 3)) for x, y in profile] != part.profile:
            errors.append("manifest profile does not match the array in the code")
        errors += validate_profile(profile, kind=part.kind)

    result = SketchCheck(ok=True)
    result.profile_area = area(part.profile)
    result.profile_perimeter = perimeter(part.profile)
    if errors:
        result.errors = errors
        result.ok = False
        return result

    try:
        mesh = evaluate_3d(part.code)
    except Exception as exc:  # noqa: BLE001
        result.errors = [f"evaluation failed: {exc}"]
        result.ok = False
        return result
    parts = mesh.decompose()
    if len(parts) != 1:
        errors.append(f"{len(parts)} components instead of one")
    box = mesh.bounding_box()
    measured = (box[3] - box[0], box[4] - box[1], box[5] - box[2])
    result.measured_bbox = measured
    result.volume = float(mesh.volume())
    for axis, want, have in zip("XYZ", part.bbox, measured):
        if want <= 0:
            errors.append(f"axis {axis} target is not positive")
            continue
        error = abs(have - want) / want
        if error > max_relative_error:
            errors.append(f"axis {axis}: measured {have:.3f} mm vs declared {want:.3f} mm ({error:.1%})")
        if have < 5.0 or have > 250.0:
            errors.append(f"axis {axis} is {have:.2f} mm, outside the 5-250 mm window")
    result.relative_error = tuple(
        abs(have - want) / want if want else 0.0 for want, have in zip(part.bbox, measured)
    )

    x0, y0, x1, y1 = bbox2(part.profile)
    if part.kind == "linear":
        height = float(part.extrude["height_mm"])
        expected = result.profile_area * height
        if expected > 0 and abs(result.volume - expected) / expected > 0.015:
            errors.append(
                f"volume {result.volume:.1f} mm3 vs profile area x height {expected:.1f} mm3"
            )
        for name, want, have in (("x", x1 - x0, measured[0]), ("y", y1 - y0, measured[1])):
            if abs(want - have) > 0.05:
                errors.append(f"profile {name} span {want:.3f} mm vs mesh {have:.3f} mm")
        if abs(measured[2] - height) > 0.05:
            errors.append(f"mesh height {measured[2]:.3f} mm vs declared {height:.3f} mm")
    else:
        expected = result.profile_area * 2.0 * math.pi * centroid_x(part.profile)
        if expected > 0 and abs(result.volume - expected) / expected > 0.02:
            errors.append(f"revolved volume {result.volume:.1f} mm3 vs Pappus {expected:.1f} mm3")
        if abs(measured[0] - 2 * x1) > 0.05 or abs(measured[1] - 2 * x1) > 0.05:
            errors.append(
                f"revolved footprint {measured[0]:.3f} x {measured[1]:.3f} mm vs 2 x {x1:.3f} mm"
            )
        if abs(measured[2] - (y1 - y0)) > 0.05:
            errors.append(f"revolved height {measured[2]:.3f} mm vs profile {y1 - y0:.3f} mm")

    if stl and not errors:
        from tools.dataset_gen2.stlcheck import check_source, is_bad

        try:
            info = check_source(part.code)
            if is_bad(info):
                errors.append(
                    f"STL gate: watertight {info['watertight']}, components {info['components']}, "
                    f"degenerate {info['degenerate']}"
                )
        except Exception as exc:  # noqa: BLE001
            errors.append(f"STL gate crashed: {exc}")

    result.errors = errors
    result.ok = not errors
    return result


def as_part(sketch: SketchPart) -> Part:
    """Bridge to the shared tooling (bbox / prompt inspection helpers)."""
    return Part(
        family=sketch.family,
        variant=sketch.variant,
        code=sketch.code,
        bbox=sketch.bbox,
        params=sketch.params,
        prompt_ru=sketch.prompt_ru,
        prompt_en=sketch.prompt_en,
    )


def profile_summary(part: SketchPart) -> str:
    x0, y0, x1, y1 = bbox2(part.profile)
    return (
        f"{len(part.profile)} points, {x1 - x0:.1f} x {y1 - y0:.1f} mm, "
        f"area {area(part.profile):.0f} mm2"
    )


__all__ = [
    "MAX_BYTES",
    "MIN_POINTS",
    "MAX_POINTS",
    "SketchCheck",
    "SketchPart",
    "as_part",
    "check_sketch",
    "finish_sketch",
    "parse_profile",
    "profile_summary",
    "render_sketch",
]
