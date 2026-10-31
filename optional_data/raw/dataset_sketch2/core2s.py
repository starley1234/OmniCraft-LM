"""Sample model and audit for the sketch2 corpus (request 5, block S2).

A sketch2 sample is one primary profile plus one extrusion - the ground truth
SketchCanvas predicts - *plus* optional void rings subtracted after the
extrusion (the request makes this explicit: "the first polygon is the body,
subtract with a second polygon after extrusion - that is legal").  Revolve
families carry grooves / flanges / thread reliefs inside the profile itself.

Discipline (all checked locally on the manifold kernel before writing):

* primary profile: 6-64 points, CCW, simple, coordinates >= 0; for revolve
  the profile stays at x >= 0.5 (sketch1 precedent - no degenerate axis fan);
* void rings: simple polygons, strictly inside the primary profile with a
  declared wall margin, pairwise disjoint;
* the emitted code is exactly one ``difference()`` of one ``linear_extrude``
  and the void cutters (or one bare ``rotate_extrude`` for revolves);
* volume is checked analytically: ``A(profile) * t - sum(A(void) * depth)``
  for linear, Pappus for revolve;
* every prompt number lives in the code (place1 law).
"""

from __future__ import annotations

import math
from dataclasses import dataclass, field
from typing import Any, Sequence

from tools.dataset_gen2.common import Rng, fmt
from tools.dataset_gen2.prompts import build_prompt
from tools.dataset_sketch1.geom1 import (
    area,
    bbox2,
    centroid_x,
    is_simple,
    polygon_literal,
    segments_cross,
    signed_area,
)
from tools.dataset_v5.kit import SEED_V5, tail_pair

MAX_BYTES = 12000
MIN_POINTS = 6
MAX_POINTS = 64
FORBIDDEN = (
    "import(", "surface(", "text(", "children(", "rands(", "echo(",
    "hull(", "union(", "intersection(", "minkowski(", "linear_extrude(scale",
)


# ---------------------------------------------------------------------------
# sample model
# ---------------------------------------------------------------------------


@dataclass
class Sketch2Part:
    family: str
    variant: str
    code: str
    bbox: tuple[float, float, float]
    params: dict[str, float]
    prompt_ru: str
    prompt_en: str
    profile: list[tuple[float, float]]
    extrude: dict[str, Any]
    voids: list[list[tuple[float, float]]] = field(default_factory=list)
    void_depths: list[float] = field(default_factory=list)
    notes: str = ""

    @property
    def kind(self) -> str:
        return str(self.extrude["kind"])

    def manifest_row(self, file_name: str) -> dict[str, Any]:
        row: dict[str, Any] = {
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
        if self.voids:
            row["voids_profiles"] = [
                [[round(x, 3), round(y, 3)] for x, y in void] for void in self.voids
            ]
            row["void_depth_mm"] = [round(depth, 3) for depth in self.void_depths]
        return row


# ---------------------------------------------------------------------------
# emission
# ---------------------------------------------------------------------------


def render_sketch2(
    title: str,
    summary: str,
    params: Sequence[tuple[str, float, str]],
    derived: Sequence[str],
    profile: Sequence[Sequence[float]],
    extrude: dict[str, Any],
    voids: Sequence[Sequence[Sequence[float]]] = (),
    void_depths: Sequence[float] = (),
    void_comments: Sequence[str] = (),
) -> str:
    """Emit the .scad file: header block, profile (+void) arrays, one cut."""
    from tools.dataset_gen2.common import align

    kind = str(extrude["kind"])
    body: list[str] = ["$fn = 32;", ""]
    body.append("// " + "-" * 70)
    body.append(f"// {title}" + (f": {summary}" if summary else ""))
    body.append("// " + "-" * 70)
    body.append("")
    body.append("// --- parameters (mm) ---")
    body.append(align([(name, float(value), comment) for name, value, comment in params]))
    if derived:
        body.append("")
        body.extend(derived)
    body.append("")
    body.append(
        f"profile = {polygon_literal(profile)};  // primary outline, "
        f"{len(profile)} points, counter clockwise"
    )
    for index, void in enumerate(voids, start=1):
        comment = void_comments[index - 1] if index <= len(void_comments) else "void ring"
        body.append(
            f"void_{index} = {polygon_literal(void)};  // {comment}, {len(void)} points"
        )
    body.append("")
    body.append("// --- the one profile operation ---")
    if kind == "linear":
        height = float(extrude["height_mm"])
        if voids:
            body.append("difference() {")
            body.append("  linear_extrude(height = plate_t) polygon(points = profile);")
            for index, depth in enumerate(void_depths, start=1):
                if abs(depth - height) < 1e-9:
                    # through window: cutter overshoots both faces by 1 mm
                    body.append("  translate([0, 0, -1])")
                    body.append(
                        f"    linear_extrude(height = plate_t + 2) polygon(points = void_{index});"
                    )
                else:
                    # blind pocket from the top face, 1 mm overshoot upwards
                    body.append(f"  translate([0, 0, plate_t - depth_{index}])")
                    body.append(
                        f"    linear_extrude(height = depth_{index} + 1) polygon(points = void_{index});"
                    )
            body.append("}")
        else:
            body.append("linear_extrude(height = plate_t) polygon(points = profile);")
    else:
        body.append("rotate_extrude(angle = revolve_angle) polygon(points = profile);")
    return "\n".join(body).rstrip() + "\n"


# ---------------------------------------------------------------------------
# prompts
# ---------------------------------------------------------------------------


def finish_sketch2(
    rng: Rng,
    *,
    family: str,
    variant: str,
    title: str,
    summary: str,
    params: Sequence[tuple[str, float, str]],
    derived: Sequence[str],
    profile: list[tuple[float, float]],
    extrude: dict[str, Any],
    bbox: tuple[float, float, float],
    voids: list[list[tuple[float, float]]] | None = None,
    void_depths: list[float] | None = None,
    void_comments: Sequence[str] = (),
    ru_nouns: Sequence[str],
    en_nouns: Sequence[str],
    features_ru: Sequence[str],
    features_en: Sequence[str],
    param_values: dict[str, float] | None = None,
) -> Sketch2Part:
    ru_tail, en_tail, tol = tail_pair(rng)
    final_params = list(params)
    if tol is not None:
        final_params.append(("fit_tol", tol[0], "declared fit tolerance (prompt contract)"))
        final_params.append(("free_tol", tol[1], "declared free tolerance (prompt contract)"))
    code = render_sketch2(title, summary, final_params, derived, profile, extrude,
                          voids or (), void_depths or (), void_comments)
    prompt_ru, prompt_en = build_prompt(
        rng,
        ru_nouns=ru_nouns,
        en_nouns=en_nouns,
        bbox=bbox,
        ru_feature_sentences=[s[0].upper() + s[1:] + "." for s in features_ru],
        en_feature_sentences=[s[0].upper() + s[1:] + "." for s in features_en],
        feature_count=rng.integer(3, min(4, max(3, len(features_ru)))),
        extra_tail=False,
    )
    values = {name: float(value) for name, value, _ in final_params}
    if param_values:
        values.update(param_values)
    return Sketch2Part(
        family=family,
        variant=variant,
        code=code,
        bbox=bbox,
        params=values,
        prompt_ru=f"{prompt_ru} {ru_tail}",
        prompt_en=f"{prompt_en} {en_tail}",
        profile=profile,
        extrude=extrude,
        voids=list(voids or []),
        void_depths=list(void_depths or []),
    )


# ---------------------------------------------------------------------------
# geometry helpers
# ---------------------------------------------------------------------------


def convex_clip_area(subject: Sequence[Sequence[float]],
                     convex: Sequence[Sequence[float]]) -> float:
    """Area of (subject ∩ convex) via Sutherland-Hodgman; `convex` must be CCW.

    Edge cutters overshoot the plate on purpose, so the removed volume is the
    clipped intersection area times the depth, not the raw cutter area.
    """
    poly: list[tuple[float, float]] = [(float(p[0]), float(p[1])) for p in subject]
    count = len(convex)

    def side(px: float, py: float, x0: float, y0: float, edge_x: float, edge_y: float) -> float:
        # positive = left of the directed edge = inside for a CCW polygon
        return edge_x * (py - y0) - edge_y * (px - x0)

    for i in range(count):
        if not poly:
            break
        x0, y0 = convex[i]
        x1, y1 = convex[(i + 1) % count]
        edge_x, edge_y = x1 - x0, y1 - y0
        clipped: list[tuple[float, float]] = []
        for j in range(len(poly)):
            px, py = poly[j]
            qx, qy = poly[(j + 1) % len(poly)]
            side_p = side(px, py, x0, y0, edge_x, edge_y)
            side_q = side(qx, qy, x0, y0, edge_x, edge_y)
            if side_p >= -1e-12:
                clipped.append((px, py))
            if (side_p > 1e-12) != (side_q > 1e-12):
                denom = side_p - side_q
                if abs(denom) > 1e-15:
                    t = side_p / denom
                    clipped.append((px + t * (qx - px), py + t * (qy - py)))
        poly = clipped
    return abs(signed_area(poly)) if len(poly) >= 3 else 0.0


def _is_simple_ring(points: Sequence[Sequence[float]]) -> bool:
    """Simplicity without the sketch1 6-point floor (void rects have 4)."""
    count = len(points)
    if count < 3:
        return False
    for index in range(count):
        if math.dist(points[index], points[(index + 1) % count]) < 1e-6:
            return False
    for i in range(count):
        for j in range(i + 1, count):
            if (j - i) % count in (1, count - 1):
                continue
            if segments_cross(points[i], points[(i + 1) % count],
                              points[j], points[(j + 1) % count]):
                return False
    return True


def point_in_polygon(point: Sequence[float], ring: Sequence[Sequence[float]]) -> bool:
    inside = False
    x, y = float(point[0]), float(point[1])
    count = len(ring)
    for index in range(count):
        x0, y0 = ring[index]
        x1, y1 = ring[(index + 1) % count]
        if (y0 > y) != (y1 > y) and x < (x1 - x0) * (y - y0) / (y1 - y0) + x0:
            inside = not inside
    return inside


def ring_distance(ring_a: Sequence[Sequence[float]], ring_b: Sequence[Sequence[float]]) -> float:
    """Conservative ring separation: min distance between any two vertices."""
    return min(math.dist(a, b) for a in ring_a for b in ring_b)


def _distance_to_ring(point: Sequence[float], ring: Sequence[Sequence[float]]) -> float:
    """Distance from a point to the closest edge of the ring."""
    x, y = float(point[0]), float(point[1])
    best = float("inf")
    count = len(ring)
    for index in range(count):
        x0, y0 = ring[index]
        x1, y1 = ring[(index + 1) % count]
        dx, dy = x1 - x0, y1 - y0
        length_sq = dx * dx + dy * dy
        t = 0.0 if length_sq <= 1e-18 else max(0.0, min(1.0, ((x - x0) * dx + (y - y0) * dy) / length_sq))
        best = min(best, math.hypot(x - (x0 + t * dx), y - (y0 + t * dy)))
    return best


def arc_points(
    centre: Sequence[float], radius: float, start_deg: float, end_deg: float, step_deg: float = 1.0
) -> list[tuple[float, float]]:
    """Arc samples including both endpoints; the step never exceeds step_deg."""
    sweep = end_deg - start_deg
    count = max(1, int(math.ceil(abs(sweep) / step_deg)))
    points = []
    for index in range(count + 1):
        angle = math.radians(start_deg + sweep * index / count)
        points.append(
            (round(centre[0] + radius * math.cos(angle), 3),
             round(centre[1] + radius * math.sin(angle), 3))
        )
    return points


# ---------------------------------------------------------------------------
# audit
# ---------------------------------------------------------------------------


def _validate_profile2(points: list[tuple[float, float]], kind: str) -> list[str]:
    """Sketch2 profile rules: 6-64 points (request 5), CCW, simple, x/y >= 0."""
    problems: list[str] = []
    count = len(points)
    if count < MIN_POINTS:
        problems.append(f"profile has {count} points, fewer than {MIN_POINTS}")
    if count > MAX_POINTS:
        problems.append(f"profile has {count} points, more than {MAX_POINTS}")
    if any(x < -1e-9 or y < -1e-9 for x, y in points):
        problems.append("profile has a negative coordinate")
    if not is_simple(points):
        problems.append("profile is not a simple polygon")
    if signed_area(points) <= 0:
        problems.append("profile is not counter clockwise")
    if kind == "rotate" and min(x for x, _ in points) < 0.5:
        problems.append("revolved profile reaches the axis (x < 0.5)")
    return problems


def audit_sketch2(part: Sketch2Part, stl: bool = True) -> list[str]:
    from tools.dataset_gen2.miniscad import MiniScadError, evaluate_3d

    errors: list[str] = []
    lines = part.code.splitlines()
    if not lines or lines[0] != "$fn = 32;":
        errors.append("missing '$fn = 32;' header")
    for token in FORBIDDEN:
        if token in part.code:
            errors.append(f"forbidden construct {token}")
    if len(part.code.encode("utf-8")) > MAX_BYTES:
        errors.append("source exceeds 12 kB")
    if part.kind == "linear" and "linear_extrude(height = plate_t)" not in part.code:
        errors.append("the body must be exactly one linear_extrude of the profile")
    if part.kind == "rotate" and "rotate_extrude(angle = revolve_angle)" not in part.code:
        errors.append("revolve samples must call rotate_extrude(angle = revolve_angle)")

    errors.extend(_validate_profile2(part.profile, part.kind))
    outer = part.profile
    outer_box = bbox2(outer)
    for index, void in enumerate(part.voids):
        if len(void) < 3:
            errors.append(f"void {index} has fewer than 3 points")
            continue
        if not _is_simple_ring(void):
            errors.append(f"void {index} is not a simple polygon")
        if abs(signed_area(void)) <= 1e-6:
            errors.append(f"void {index} has no area")
        void_box = bbox2(void)
        enclosed = (
            void_box[0] >= outer_box[0] - 1e-9 and void_box[1] >= outer_box[1] - 1e-9
            and void_box[2] <= outer_box[2] + 1e-9 and void_box[3] <= outer_box[3] + 1e-9
        )
        if enclosed:
            # a closed window / pocket: strictly inside with a printable wall
            for point in void:
                if not point_in_polygon(point, outer):
                    errors.append(f"void {index} leaves the primary profile at {point}")
                    break
            for point in void:
                if _distance_to_ring(point, outer) < 1.2:
                    errors.append(f"void {index} comes within 1.2 mm of the profile boundary")
                    break
        else:
            # an edge cutter (step / ledge): it must overlap the profile
            if (void_box[2] <= outer_box[0] or void_box[0] >= outer_box[2]
                    or void_box[3] <= outer_box[1] or void_box[1] >= outer_box[3]):
                errors.append(f"void {index} does not overlap the primary profile at all")
        depth = part.void_depths[index] if index < len(part.void_depths) else None
        if depth is None or depth <= 0:
            errors.append(f"void {index} has no positive depth")
        elif part.kind == "linear":
            height = float(part.extrude["height_mm"])
            if depth > height + 1e-9:
                errors.append(f"void {index} is deeper than the plate")
            elif depth < height - 1e-9 and height - depth < 1.2:
                errors.append(f"void {index} leaves a floor thinner than 1.2 mm")
    for i in range(len(part.voids)):
        for j in range(i + 1, len(part.voids)):
            box_i = bbox2(part.voids[i])
            box_j = bbox2(part.voids[j])
            overlap = not (
                box_i[2] <= box_j[0] + 1e-6 or box_j[2] <= box_i[0] + 1e-6
                or box_i[3] <= box_j[1] + 1e-6 or box_j[3] <= box_i[1] + 1e-6
            )
            if overlap:
                errors.append(f"voids {i} and {j} overlap")
            elif (convex_clip_area(part.voids[i], outer) == area(part.voids[i])
                  and convex_clip_area(part.voids[j], outer) == area(part.voids[j])
                  and ring_distance(part.voids[i], part.voids[j]) < 1.2):
                errors.append(f"voids {i} and {j} leave less than 1.2 mm between them")
    if part.kind == "rotate" and part.voids:
        errors.append("revolve samples carry grooves in the profile, not void rings")

    try:
        mesh = evaluate_3d(part.code)
    except MiniScadError as exc:
        errors.append(f"evaluation failed: {exc}")
        return errors
    if len(mesh.decompose()) != 1:
        errors.append(f"{len(mesh.decompose())} components, expected a single solid")
    if mesh.volume() <= 0:
        errors.append("non-positive volume")
    box = mesh.bounding_box()
    measured = (box[3] - box[0], box[4] - box[1], box[5] - box[2])
    for axis, want, have in zip("XYZ", part.bbox, measured):
        if want <= 0:
            errors.append(f"axis {axis} target is not positive")
            continue
        if abs(have - want) / want > 0.015:
            errors.append(f"axis {axis}: measured {have:.3f} vs declared {want:.3f} mm")
        if have < 5.0 or have > 250.0:
            errors.append(f"axis {axis} is {have:.2f} mm, outside 5-250 mm")

    volume = float(mesh.volume())
    if part.kind == "linear":
        height = float(part.extrude["height_mm"])
        expected = area(part.profile) * height
        for void, depth in zip(part.voids, part.void_depths):
            # edge cutters overshoot the plate: count only the clipped part
            expected -= convex_clip_area(void, part.profile) * min(depth, height)
        if expected > 0 and abs(volume - expected) / expected > 0.015:
            errors.append(f"volume {volume:.1f} mm3 vs analytic {expected:.1f} mm3")
        x0, y0, x1, y1 = bbox2(part.profile)
        if abs(measured[0] - (x1 - x0)) > 0.05 or abs(measured[1] - (y1 - y0)) > 0.05:
            errors.append("mesh footprint does not match the profile bbox")
        if abs(measured[2] - height) > 0.05:
            errors.append(f"mesh height {measured[2]:.3f} mm vs declared {height:.3f} mm")
    else:
        expected = area(part.profile) * 2.0 * math.pi * centroid_x(part.profile)
        if expected > 0 and abs(volume - expected) / expected > 0.02:
            errors.append(f"revolved volume {volume:.1f} mm3 vs Pappus {expected:.1f} mm3")
        x1 = max(x for x, _ in part.profile)
        _, y0, _, y1 = bbox2(part.profile)
        if abs(measured[0] - 2 * x1) > 0.05 or abs(measured[1] - 2 * x1) > 0.05:
            errors.append("revolved footprint does not match 2 x max radius")
        if abs(measured[2] - (y1 - y0)) > 0.05:
            errors.append("revolved height does not match the profile")

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
    return errors
