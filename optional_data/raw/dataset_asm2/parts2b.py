"""Extra part builders for the asm2 scenes (asm1's parts2 stays untouched).

Every builder returns an asm1 :class:`PartSpec`, so the audit keeps its two
safety nets: the declared analytic volume (a cutter that misses material is
caught) and the declared local bounds (a misplaced instance is caught).

The racetrack belt is written the way the receiver's real OpenSCAD likes it:
``concat`` of two ``for`` comprehensions sampling both caps at 45 degree
steps, so the polygon vertices are exact multiples of the grid.
"""

from __future__ import annotations

import math

from tools.dataset_asm1.parts2 import PartSpec, _box, _module, disc_area, num

__all__ = [
    "box_post",
    "fork",
    "hinge_half",
    "motor_body",
    "racetrack_belt",
    "shoelace",
]


def shoelace(points: list[tuple[float, float]]) -> float:
    total = 0.0
    count = len(points)
    for index in range(count):
        x0, y0 = points[index]
        x1, y1 = points[(index + 1) % count]
        total += x0 * y1 - x1 * y0
    return abs(total) / 2.0


def _racetrack_points(radius: float, span: float) -> list[tuple[float, float]]:
    """Caps sampled at 45 degree steps: 90..270 around (0,0), 270..450 around (span,0)."""
    points: list[tuple[float, float]] = []
    for step in range(5):
        angle = math.radians(90.0 + 45.0 * step)
        points.append((round(radius * math.cos(angle), 4), round(radius * math.sin(angle), 4)))
    for step in range(5):
        angle = math.radians(270.0 + 45.0 * step)
        points.append(
            (round(span + radius * math.cos(angle), 4), round(radius * math.sin(angle), 4))
        )
    return points


def racetrack_belt(
    name: str, r_out: float, belt_t: float, span: float, width: float
) -> PartSpec:
    """Flat belt loop around two equal pulleys `span` apart (module, XY plane)."""
    r_in = round(r_out - belt_t, 3)

    def ring_expr(radius: float) -> str:
        return (
            "concat("
            f"[for (a = [90 : 45 : 270]) [{num(radius)} * cos(a), {num(radius)} * sin(a)]], "
            f"[for (a = [270 : 45 : 450]) [{num(span)} + {num(radius)} * cos(a), {num(radius)} * sin(a)]])"
        )

    body = "difference() {\n"
    body += f"  linear_extrude(height = {num(width)}) polygon(points = {ring_expr(r_out)});\n"
    body += f"  translate([0, 0, {num(-1)}]) linear_extrude(height = {num(width + 2)}) "
    body += f"polygon(points = {ring_expr(r_in)});\n"
    body += "}"
    outer_area = shoelace(_racetrack_points(r_out, span))
    inner_area = shoelace(_racetrack_points(r_in, span))
    return PartSpec(
        name=name,
        source=_module(name, body),
        bounds=(-r_out, -r_out, 0.0, span + r_out, r_out, width),
        volume=(outer_area - inner_area) * width,
        params={"r_out": r_out, "belt_t": belt_t, "span": span, "width": width},
        ru=(
            f"плоский ремень-лента: контур из двух дуг радиусом {num(r_out)} мм "
            f"при базе {num(span)} мм, толщина ленты {num(belt_t)} мм, ширина {num(width)} мм"
        ),
        en=(
            f"flat belt loop: two {num(r_out)} mm radius caps on a {num(span)} mm centre distance, "
            f"{num(belt_t)} mm thick, {num(width)} mm wide"
        ),
    )


def _barrels_code(slots: list[tuple[float, float]], knuckle_r: float, bore: float) -> str:
    solid = ""
    cutters = ""
    for x0, x1 in slots:
        width = x1 - x0
        centre = (x0 + x1) / 2.0
        solid += (
            f"    translate([{num(centre)}, 0, 0]) rotate([0, 90, 0]) "
            f"cylinder(h = {num(width)}, d = {num(2 * knuckle_r)}, center = true);\n"
        )
        cutters += (
            f"  translate([{num(centre)}, 0, 0]) rotate([0, 90, 0]) "
            f"cylinder(h = {num(width + 2)}, d = {num(bore)}, center = true);\n"
        )
    return solid, cutters


def hinge_half(
    name: str,
    length: float,
    width: float,
    thickness: float,
    lug: float,
    bore: float,
    slots: list[tuple[float, float]],
    side: int,
    ru_noun: str,
    en_noun: str,
) -> PartSpec:
    """One comb-style hinge leaf: full-depth teeth around the X axis at the origin.

    Each tooth is a box spanning the hinge axis, bored along X for the pin.
    ``side`` = +1 grows the leaf towards +Y, -1 towards -Y; ``lug`` is how far
    past the axis each tooth reaches, which is what interleaves the two leaves.
    The teeth of the two leaves occupy disjoint X slots, so the moving leaf can
    swing through any angle without a collision.
    """
    # the connecting strip starts beyond the swing-tip radius of the opposite
    # leaf's teeth, so the hinge can swing through any angle
    strip_y = math.sqrt(lug * lug + (thickness / 2) ** 2) + 0.3
    if strip_y >= width - 1.2:
        raise ValueError("leaf too narrow for the strip")
    body = "difference() {\n  union() {\n"
    for x0, x1 in slots:
        w = x1 - x0
        if side > 0:
            body += "    " + _box(x0, -lug, -thickness / 2, x1, width, thickness / 2) + "\n"
        else:
            body += "    " + _box(x0, -width, -thickness / 2, x1, lug, thickness / 2) + "\n"
    if side > 0:
        body += "    " + _box(-length / 2, strip_y, -thickness / 2, length / 2, width, thickness / 2) + "\n"
    else:
        body += "    " + _box(-length / 2, -width, -thickness / 2, length / 2, -strip_y, thickness / 2) + "\n"
    body += "  }\n"
    for x0, x1 in slots:
        w = x1 - x0
        centre = (x0 + x1) / 2.0
        body += (
            f"  translate([{num(centre)}, 0, 0]) rotate([0, 90, 0]) "
            f"cylinder(h = {num(w + 2)}, d = {num(bore)}, center = true);\n"
        )
    body += "}"
    strip_span = width - strip_y
    volume = length * strip_span * thickness
    for x0, x1 in slots:
        tooth_span = (width + lug) - strip_span  # part of the tooth below the strip
        volume += tooth_span * thickness * (x1 - x0) - disc_area(bore) * (x1 - x0)
    if side > 0:
        y_lo, y_hi = -lug, width
    else:
        y_lo, y_hi = -width, lug
    return PartSpec(
        name=name,
        source=_module(name, body),
        bounds=(-length / 2, y_lo, -thickness / 2, length / 2, y_hi, thickness / 2),
        volume=volume,
        params={
            "length": length,
            "width": width,
            "thickness": thickness,
            "lug": lug,
            "bore": bore,
            "teeth": float(len(slots)),
        },
        ru=(
            f"{ru_noun}: {len(slots)} зуба {num(x1 - x0) if slots else 0} мм, пластина "
            f"{num(width)} x {num(thickness)} мм, проушины под палец d{num(bore)}"
        ),
        en=(
            f"{en_noun}: {len(slots)} teeth, {num(width)} x {num(thickness)} mm leaf, "
            f"d{num(bore)} pin bores"
        ),
    )


def fork(
    name: str,
    leg_l: float,
    leg_t: float,
    gap_y: float,
    height: float,
    bridge_t: float,
    axle_bore: float,
    axle_z: float,
) -> PartSpec:
    """Cart fork: two side legs plus a top bridge, axle bores along X."""
    y_out = gap_y / 2 + leg_t
    body = "difference() {\n  union() {\n"
    body += "    " + _box(-leg_l / 2, gap_y / 2, 0.0, leg_l / 2, y_out, height) + "\n"
    body += "    " + _box(-leg_l / 2, -y_out, 0.0, leg_l / 2, -gap_y / 2, height) + "\n"
    body += "    " + _box(-leg_l / 2, -y_out, height, leg_l / 2, y_out, height + bridge_t) + "\n"
    body += "  }\n"
    for sign in (-1, 1):
        centre = sign * (gap_y / 2 + leg_t / 2)
        body += (
            f"  translate([0, {num(centre)}, {num(axle_z)}]) rotate([90, 0, 0]) "
            f"cylinder(h = {num(leg_t + 2)}, d = {num(axle_bore)}, center = true);\n"
        )
    body += "}"
    volume = 2 * leg_l * leg_t * height + leg_l * (2 * y_out) * bridge_t
    volume -= 2 * disc_area(axle_bore) * leg_t
    return PartSpec(
        name=name,
        source=_module(name, body),
        bounds=(-leg_l / 2, -y_out, 0.0, leg_l / 2, y_out, height + bridge_t),
        volume=volume,
        params={
            "leg_l": leg_l,
            "leg_t": leg_t,
            "gap_y": gap_y,
            "height": height,
            "bridge_t": bridge_t,
            "axle_bore": axle_bore,
            "axle_z": axle_z,
        },
        ru=(
            f"вилка: стойки {num(leg_l)} x {num(leg_t)} мм высотой {num(height)} мм, "
            f"проём {num(gap_y)} мм, мост {num(bridge_t)} мм, расточка под ось d{num(axle_bore)}"
        ),
        en=(
            f"fork: {num(leg_l)} x {num(leg_t)} mm legs {num(height)} mm tall, "
            f"{num(gap_y)} mm gap, {num(bridge_t)} mm bridge, d{num(axle_bore)} axle bores"
        ),
    )


def motor_body(
    name: str, length: float, width: float, height: float, boss_l: float, boss_d: float
) -> PartSpec:
    """NEMA-style motor: square body plus a front pilot boss along +X at mid height."""
    body = "union() {\n"
    body += "  " + _box(-length / 2, -width / 2, 0.0, length / 2, width / 2, height) + "\n"
    body += (
        f"  translate([{num(length / 2 + boss_l / 2)}, 0, {num(height / 2)}]) rotate([0, 90, 0]) "
        f"cylinder(h = {num(boss_l)}, d = {num(boss_d)}, center = true);\n"
    )
    body += "}"
    volume = length * width * height + disc_area(boss_d) * boss_l
    z_hi = max(height, height / 2 + boss_d / 2)
    return PartSpec(
        name=name,
        source=_module(name, body),
        bounds=(-length / 2, -width / 2, 0.0, length / 2 + boss_l, width / 2, z_hi),
        volume=volume,
        params={"length": length, "width": width, "height": height, "boss_d": boss_d},
        ru=(
            f"мотор {num(length)} x {num(width)} x {num(height)} мм "
            f"с пилотным буртом d{num(boss_d)} x {num(boss_l)} мм"
        ),
        en=(
            f"motor body {num(length)} x {num(width)} x {num(height)} mm "
            f"with a d{num(boss_d)} x {num(boss_l)} mm pilot boss"
        ),
    )


def box_post(name: str, side: float, height: float) -> PartSpec:
    half = side / 2
    return PartSpec(
        name=name,
        source=_module(
            name,
            f"translate([{num(-half)}, {num(-half)}, 0]) "
            f"cube([{num(side)}, {num(side)}, {num(height)}]);",
        ),
        bounds=(-half, -half, 0.0, half, half, height),
        volume=side * side * height,
        params={"side": side, "height": height},
        ru=f"стойка {num(side)} x {num(side)} мм высотой {num(height)} мм",
        en=f"post {num(side)} x {num(side)} mm, {num(height)} mm tall",
    )
