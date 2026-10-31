"""Geometry helpers shared by the gen3 generators.

Every helper emits OpenSCAD that follows the hard rules learned from the
previous delivery:

* nothing is revolved around the axis - a ``rotate_extrude`` profile always
  stays at least ~1 mm clear of x = 0,
* every cutter passes through its material with >= 2.5 mm of overhang on each
  open side, so a cut never ends inside material at a grazing angle,
* unions overlap, and a ring that is added to a body reaches inside the body
  by >= 1.5 mm instead of sitting on its surface.
"""

from __future__ import annotations

import math

from tools.dataset_gen2.common import fmt

MIN_WALL = 1.2


def num(value: float, digits: int = 2) -> str:
    return fmt(value, digits)


def box(size: tuple[float, float, float], at: tuple[float, float, float] | None = None) -> str:
    line = "cube([" + ", ".join(num(value) for value in size) + "]);"
    if at is None:
        return line
    return "translate([" + ", ".join(num(value) for value in at) + "]) " + line


def cyl(d: float, h: float, at: tuple[float, float, float] | None = None, center: bool = False) -> str:
    tail = ", center = true" if center else ""
    line = f"cylinder(h = {num(h)}, d = {num(d)}{tail});"
    if at is None:
        return line
    return "translate([" + ", ".join(num(value) for value in at) + "]) " + line


def hexprism(across_flats: float, h: float, at: tuple[float, float, float] | None = None) -> str:
    """Hex head / nut: OpenSCAD draws a cylinder with 6 fragments over the corners."""
    d = round(across_flats * 2.0 / math.sqrt(3.0), 3)
    line = f"cylinder(h = {num(h)}, d = {num(d, 3)}, $fn = 6);"
    if at is None:
        return line
    return "translate([" + ", ".join(num(value) for value in at) + "]) " + line


def hole_z(x: float, y: float, d: float, z0: float, z1: float, overhang: float = 2.5) -> str:
    """Vertical through hole, 2.5 mm past the material on both sides."""
    return cyl(d, (z1 - z0) + 2 * overhang, (x, y, z0 - overhang))


def hole_x(y: float, z: float, d: float, x0: float, x1: float, overhang: float = 2.5) -> str:
    return (
        f"translate([{num(x0 - overhang)}, {num(y)}, {num(z)}]) rotate([0, 90, 0])"
        f" cylinder(h = {num((x1 - x0) + 2 * overhang)}, d = {num(d)});"
    )


def hole_y(x: float, z: float, d: float, y0: float, y1: float, overhang: float = 2.5) -> str:
    return (
        f"translate([{num(x)}, {num(y0 - overhang)}, {num(z)}]) rotate([-90, 0, 0])"
        f" cylinder(h = {num((y1 - y0) + 2 * overhang)}, d = {num(d)});"
    )


def ring_cut(inner_r: float, outer_r: float, z0: float, z1: float) -> str:
    """Annular cut: a revolved square that stays clear of the axis."""
    width = round(outer_r - inner_r, 3)
    height = round(z1 - z0, 3)
    return (
        f"rotate_extrude() translate([{num(inner_r, 3)}, {num(z0, 3)}])"
        f" square([{num(width, 3)}, {num(height, 3)}]);"
    )


def _polygon_line(points: list[tuple[float, float]], indent: str = "    ") -> str:
    body = ", ".join(f"[{num(r, 3)}, {num(z, 3)}]" for r, z in points)
    return f"polygon([{body}])"


def external_thread_ring(
    core_r: float,
    major_r: float,
    z0: float,
    height: float,
    pitch: float,
    depth: float = 0.9,
) -> str:
    """A ring of annular thread ridges, unioned with the core cylinder.

    The ring's inner wall and its roots sit *inside* the core, so the union has
    no coincident surfaces: the visible surface is the core cylinder with the
    ridge crests standing proud of it.
    """
    inner_r = round(max(core_r - 2.0, 0.5), 3)
    root_r = round(max(core_r - 0.3, inner_r + 0.3), 3)
    teeth = max(3, int((height - 0.6) // pitch))
    points: list[tuple[float, float]] = [(inner_r, z0), (inner_r, z0 + height)]
    for index in range(teeth):
        crest_z = round(z0 + height - index * pitch, 3)
        points.append((major_r, crest_z))
        points.append((root_r, round(crest_z - pitch * 0.45, 3)))
    points.append((root_r, z0))
    points.append((inner_r, z0))
    return "rotate_extrude() " + _polygon_line(points) + ";"


def internal_thread_ring(
    bore_r: float,
    z0: float,
    height: float,
    pitch: float,
    depth: float = 0.9,
) -> str:
    """Annular grooves cut into a bore, leaving the bore's crests in place.

    The cutter's valleys reach 0.5 mm inside the bore (into the void, so they
    never graze the bore surface) and its inner wall is 1 mm inside the void.
    """
    inner_r = round(bore_r - 1.0, 3)
    root_r = round(bore_r - 0.5, 3)
    deep_r = round(bore_r + depth, 3)
    teeth = max(3, int((height - 0.6) // pitch))
    points: list[tuple[float, float]] = [(inner_r, z0), (inner_r, z0 + height)]
    for index in range(teeth):
        groove_z = round(z0 + height - index * pitch, 3)
        points.append((root_r, groove_z))
        points.append((deep_r, round(groove_z - pitch * 0.5, 3)))
    points.append((root_r, z0))
    points.append((inner_r, z0))
    return "rotate_extrude() " + _polygon_line(points) + ";"


def polar_points(count: int, radius, start_deg: float = 0.0) -> list[tuple[float, float]]:
    """``count`` points on a polar radius function (callable or constant)."""
    points: list[tuple[float, float]] = []
    for index in range(count):
        angle = math.radians(start_deg + 360.0 * index / count)
        value = radius(angle) if callable(radius) else float(radius)
        points.append((round(value * math.cos(angle), 3), round(value * math.sin(angle), 3)))
    return points


def bolt_circle(count: int, radius: float, start_deg: float = 0.0) -> list[tuple[float, float]]:
    points = []
    for index in range(count):
        angle = math.radians(start_deg + 360.0 * index / count)
        points.append((round(radius * math.cos(angle), 3), round(radius * math.sin(angle), 3)))
    return points


def hull_chain(profiles: list[str]) -> str:
    """A chain of ``hull()`` blocks, one per consecutive pair of profiles."""
    lines = []
    for first, second in zip(profiles, profiles[1:]):
        lines.append("hull() {")
        lines.append("  " + first)
        lines.append("  " + second)
        lines.append("}")
    return "\n".join(lines)


def hex_cell_cutouts(pitch: float, rows: int, columns: int, r_corner: float) -> list[tuple[float, float]]:
    """Centres of a honeycomb grid (odd rows offset by half a pitch)."""
    centres: list[tuple[float, float]] = []
    for row in range(rows):
        for column in range(columns):
            x = column * pitch + (pitch / 2 if row % 2 else 0.0)
            y = row * pitch * math.sqrt(3) / 2
            centres.append((round(x, 3), round(y, 3)))
    return centres
