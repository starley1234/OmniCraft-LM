"""Parametric part sources for the asm1 scenes.

Every builder returns a :class:`PartSpec`: the module source, the local bounds
of the solid (used by the audit to predict the world bounding box of a placed
node), the analytic volume of the solid (the audit compares it with the mesh, so
a cutter that misses the material cannot slip through), the driving dimensions,
and one short feature phrase in RU and EN for the prompt.

Parts are modelled the way a shop drawing would show them - one module, no
arguments, the numbers baked in by the generator - and each one is designed so
that the scene templates can place it with a controlled clearance instead of
guessing.

Volume notes: ``disc_volume`` is the volume of a regular 32-gon prism, because
the file sets ``$fn = 32`` and that is what the mesh really contains (a straight
cylinder is 0.64 % smaller than the ideal one).  Everything else - boxes and the
hexagon - is exact.
"""

from __future__ import annotations

import math
from dataclasses import dataclass, field

CLEAR = 0.2
FIT = 0.8  # diametral clearance of a clearance hole (0.4 mm radial)
FN = 32


def num(value: float) -> str:
    text = f"{value:.3f}".rstrip("0").rstrip(".")
    if text in ("", "-0"):
        return "0"
    return text


def disc_area(diameter: float) -> float:
    radius = diameter / 2.0
    return (FN / 2.0) * radius * radius * math.sin(2.0 * math.pi / FN)


def disc_volume(diameter: float, height: float) -> float:
    return disc_area(diameter) * height


def hex_area(across_flats: float) -> float:
    return math.sqrt(3.0) / 2.0 * across_flats * across_flats


def _box(x0: float, y0: float, z0: float, x1: float, y1: float, z1: float) -> str:
    return (
        f"translate([{num(x0)}, {num(y0)}, {num(z0)}]) "
        f"cube([{num(x1 - x0)}, {num(y1 - y0)}, {num(z1 - z0)}]);"
    )


def _ring_code(od: float, bore: float, h: float, z0: float) -> str:
    if bore <= 0:
        return f"translate([0, 0, {num(z0)}]) cylinder(h = {num(h)}, d = {num(od)});"
    return (
        "difference() {\n"
        f"    translate([0, 0, {num(z0)}]) cylinder(h = {num(h)}, d = {num(od)});\n"
        f"    translate([0, 0, {num(z0 - 1)}]) cylinder(h = {num(h + 2)}, d = {num(bore)});\n"
        "  }"
    )


def _module(name: str, body: str) -> str:
    lines = body.strip().splitlines()
    indented = "\n".join("  " + line for line in lines)
    return f"module {name}() {{\n{indented}\n}}\n"


def set_screw_removal(outer_d: float, bore: float, height: float, screw_d: float, steps: int = 96) -> float:
    """Volume the radial set screw hole takes out of a ring.

    Integrated on the disc that the hole projects onto, so the hole may stick
    out of the ring's top or bottom without breaking the number.
    """
    outer_r = outer_d / 2.0
    bore_r = bore / 2.0
    screw_r = screw_d / 2.0
    centre_z = height / 2.0
    total = 0.0
    step = 2.0 * screw_r / (steps - 1)
    for i in range(steps):
        x = -screw_r + i * step
        weight_x = 0.5 if i in (0, steps - 1) else 1.0
        if abs(x) >= outer_r:
            continue
        outer_chord = 2.0 * math.sqrt(max(0.0, outer_r * outer_r - x * x))
        inner_chord = 2.0 * math.sqrt(max(0.0, bore_r * bore_r - x * x)) if abs(x) <= bore_r else 0.0
        length = outer_chord - inner_chord
        for j in range(steps):
            z = centre_z - screw_r + j * step
            weight_z = 0.5 if j in (0, steps - 1) else 1.0
            if not (0.0 <= z <= height):
                continue
            if (x * x + (z - centre_z) ** 2) > screw_r * screw_r:
                continue
            total += weight_x * weight_z * length
    return total * step * step


@dataclass
class PartSpec:
    name: str
    source: str
    bounds: tuple[float, float, float, float, float, float]
    volume: float = 0.0
    params: dict[str, float] = field(default_factory=dict)
    ru: str = ""
    en: str = ""

    def module(self) -> str:
        return _module(self.name, self.source)


# ---------------------------------------------------------------------------
# fasteners
# ---------------------------------------------------------------------------


def bolt(name: str, shank_d: float, shank_l: float, head_d: float, head_h: float) -> PartSpec:
    """Head up, shank pointing down: head z in [0, head_h], shank z in [-shank_l, 0]."""
    body = f"cylinder(h = {num(head_h)}, d = {num(head_d)});\n"
    body += f"translate([0, 0, {num(-shank_l)}]) cylinder(h = {num(shank_l)}, d = {num(shank_d)});"
    bounds = (-head_d / 2, -head_d / 2, -shank_l, head_d / 2, head_d / 2, head_h)
    return PartSpec(
        name=name,
        source=_module(name, body),
        bounds=bounds,
        volume=disc_volume(shank_d, shank_l) + disc_volume(head_d, head_h),
        params={"shank_d": shank_d, "shank_l": shank_l, "head_d": head_d, "head_h": head_h},
        ru=f"болт с резьбовым стержнем d{num(shank_d)} длиной {num(shank_l)} мм, головка d{num(head_d)} x {num(head_h)} мм",
        en=f"bolt with a d{num(shank_d)} shank {num(shank_l)} mm long and a d{num(head_d)} x {num(head_h)} mm head",
    )


def hexnut(name: str, across_flats: float, height: float, bore: float) -> PartSpec:
    radius = across_flats / math.sqrt(3.0)
    points = [
        (round(radius * math.cos(math.radians(60 * index)), 3), round(radius * math.sin(math.radians(60 * index)), 3))
        for index in range(6)
    ]
    listed = ", ".join(f"[{num(x)}, {num(y)}]" for x, y in points)
    body = "difference() {\n"
    body += f"  linear_extrude(height = {num(height)}) polygon(points = [{listed}]);\n"
    body += f"  translate([0, 0, {num(-1)}]) cylinder(h = {num(height + 2)}, d = {num(bore)});\n"
    body += "}"
    xs = [point[0] for point in points]
    ys = [point[1] for point in points]
    bounds = (min(xs), min(ys), 0.0, max(xs), max(ys), height)
    return PartSpec(
        name=name,
        source=_module(name, body),
        bounds=bounds,
        volume=hex_area(across_flats) * height - disc_volume(bore, height),
        params={"af": across_flats, "height": height, "bore": bore},
        ru=f"шестигранная гайка под ключ {num(across_flats)} мм, высота {num(height)} мм, отверстие d{num(bore)}",
        en=f"hex nut {num(across_flats)} mm across flats, {num(height)} mm high, d{num(bore)} bore",
    )


def washer(name: str, outer_d: float, bore: float, thickness: float) -> PartSpec:
    return PartSpec(
        name=name,
        source=_module(name, _ring_code(outer_d, bore, thickness, 0.0)),
        bounds=(-outer_d / 2, -outer_d / 2, 0.0, outer_d / 2, outer_d / 2, thickness),
        volume=disc_volume(outer_d, thickness) - disc_volume(bore, thickness),
        params={"outer_d": outer_d, "bore": bore, "thickness": thickness},
        ru=f"шайба d{num(outer_d)} с отверстием d{num(bore)}, толщина {num(thickness)} мм",
        en=f"washer d{num(outer_d)} with a d{num(bore)} bore, {num(thickness)} mm thick",
    )


def ring(name: str, outer_d: float, bore: float, height: float, ru_noun: str, en_noun: str) -> PartSpec:
    return PartSpec(
        name=name,
        source=_module(name, _ring_code(outer_d, bore, height, 0.0)),
        bounds=(-outer_d / 2, -outer_d / 2, 0.0, outer_d / 2, outer_d / 2, height),
        volume=disc_volume(outer_d, height) - disc_volume(bore, height),
        params={"outer_d": outer_d, "bore": bore, "height": height},
        ru=f"{ru_noun} d{num(outer_d)}, отверстие d{num(bore)}, высота {num(height)} мм",
        en=f"{en_noun} d{num(outer_d)}, d{num(bore)} bore, {num(height)} mm high",
    )


def shaft(name: str, diameter: float, length: float) -> PartSpec:
    """Cylinder along Z, centred: z in [-length/2, length/2]."""
    body = f"translate([0, 0, {num(-length / 2)}]) cylinder(h = {num(length)}, d = {num(diameter)});"
    half = diameter / 2
    return PartSpec(
        name=name,
        source=_module(name, body),
        bounds=(-half, -half, -length / 2, half, half, length / 2),
        volume=disc_volume(diameter, length),
        params={"diameter": diameter, "length": length},
        ru=f"вал d{num(diameter)} длиной {num(length)} мм",
        en=f"shaft d{num(diameter)}, {num(length)} mm long",
    )


def collar(name: str, outer_d: float, bore: float, height: float, set_screw_d: float) -> PartSpec:
    body = "difference() {\n"
    body += f"  cylinder(h = {num(height)}, d = {num(outer_d)});\n"
    body += f"  translate([0, 0, {num(-1)}]) cylinder(h = {num(height + 2)}, d = {num(bore)});\n"
    body += (
        f"  translate([0, 0, {num(height / 2)}]) rotate([90, 0, 0]) "
        f"cylinder(h = {num(outer_d + 2)}, d = {num(set_screw_d)}, center = true);\n"
    )
    body += "}"
    half = outer_d / 2
    volume = disc_volume(outer_d, height) - disc_volume(bore, height)
    volume -= set_screw_removal(outer_d, bore, height, set_screw_d)
    return PartSpec(
        name=name,
        source=_module(name, body),
        bounds=(-half, -half, 0.0, half, half, height),
        volume=volume,
        params={"outer_d": outer_d, "bore": bore, "height": height, "set_screw_d": set_screw_d},
        ru=f"установочное кольцо d{num(outer_d)} на вал d{num(bore)} с резьбовым отверстием d{num(set_screw_d)}",
        en=f"collar d{num(outer_d)} for a d{num(bore)} shaft with a d{num(set_screw_d)} set screw hole",
    )


# ---------------------------------------------------------------------------
# plates, housings, brackets
# ---------------------------------------------------------------------------


def plate(
    name: str,
    length: float,
    width: float,
    thickness: float,
    holes: list[tuple[float, float]] | None = None,
    hole_d: float = 0.0,
    centre_bore: float = 0.0,
    ru_note: str = "",
    en_note: str = "",
) -> PartSpec:
    """Rectangle centred on the origin, z in [0, thickness]."""
    body = "difference() {\n"
    body += "  " + _box(-length / 2, -width / 2, 0.0, length / 2, width / 2, thickness) + "\n"
    for x, y in holes or []:
        body += (
            f"  translate([{num(x)}, {num(y)}, {num(-1)}]) "
            f"cylinder(h = {num(thickness + 2)}, d = {num(hole_d)});\n"
        )
    if centre_bore > 0:
        body += f"  translate([0, 0, {num(-1)}]) cylinder(h = {num(thickness + 2)}, d = {num(centre_bore)});\n"
    body += "}"
    volume = length * width * thickness
    volume -= len(holes or []) * disc_volume(hole_d, thickness) if hole_d > 0 else 0.0
    if centre_bore > 0:
        volume -= disc_volume(centre_bore, thickness)
    ru = ru_note or f"плита {num(length)} x {num(width)} x {num(thickness)} мм"
    en = en_note or f"plate {num(length)} x {num(width)} x {num(thickness)} mm"
    return PartSpec(
        name=name,
        source=_module(name, body),
        bounds=(-length / 2, -width / 2, 0.0, length / 2, width / 2, thickness),
        volume=volume,
        params={"length": length, "width": width, "thickness": thickness, "hole_d": hole_d},
        ru=ru,
        en=en,
    )


def bracket(
    name: str,
    base_l: float,
    base_w: float,
    thickness: float,
    leg_h: float,
    leg_t: float,
    hole_d: float,
    hole_z: list[float],
    ru_note: str = "",
    en_note: str = "",
) -> PartSpec:
    """L bracket cut from a single block: base in z [0, thickness], leg on +X.

    The leg is leg_t thick and carries horizontal clearance holes (axis X) at
    the given heights, so a scene can slide a bolt through the leg thickness.
    """
    body = "difference() {\n"
    body += "  " + _box(-base_l / 2, -base_w / 2, 0.0, base_l / 2, base_w / 2, leg_h) + "\n"
    body += (
        "  "
        + _box(-base_l / 2 - 1.0, -base_w / 2 - 1.0, thickness, base_l / 2 - leg_t, base_w / 2 + 1.0, leg_h + 1.0)
        + "\n"
    )
    for height in hole_z:
        body += (
            f"  translate([{num(base_l / 2 - leg_t / 2)}, 0, {num(height)}]) rotate([0, 90, 0]) "
            f"cylinder(h = {num(leg_t + 2)}, d = {num(hole_d)}, center = true);\n"
        )
    body += "}"
    volume = base_l * base_w * leg_h - (base_l - leg_t) * base_w * (leg_h - thickness)
    volume -= len(hole_z) * disc_volume(hole_d, leg_t)
    holes_ru = " и ".join(f"{num(value)}" for value in hole_z)
    ru = ru_note or (
        f"уголок {num(base_l)} x {num(base_w)} мм, основание {num(thickness)} мм, "
        f"полка {num(leg_h)} x {num(leg_t)} мм с отверстием d{num(hole_d)} на высоте {holes_ru} мм"
    )
    en = en_note or (
        f"L bracket {num(base_l)} x {num(base_w)} mm, {num(thickness)} mm base, "
        f"{num(leg_h)} x {num(leg_t)} mm leg with a d{num(hole_d)} hole at {holes_ru} mm"
    )
    return PartSpec(
        name=name,
        source=_module(name, body),
        bounds=(-base_l / 2, -base_w / 2, 0.0, base_l / 2, base_w / 2, leg_h),
        volume=volume,
        params={"base_l": base_l, "base_w": base_w, "thickness": thickness, "leg_h": leg_h, "leg_t": leg_t, "hole_d": hole_d},
        ru=ru,
        en=en,
    )


def cup(name: str, outer_d: float, wall: float, height: float, base: float, centre_hole: float) -> PartSpec:
    """Housing: outer cylinder with a bored interior and a centre hole in the floor."""
    bore = outer_d - 2 * wall
    body = "difference() {\n"
    body += f"  cylinder(h = {num(height)}, d = {num(outer_d)});\n"
    body += f"  translate([0, 0, {num(base)}]) cylinder(h = {num(height - base + 1)}, d = {num(bore)});\n"
    body += f"  translate([0, 0, {num(-1)}]) cylinder(h = {num(base + 2)}, d = {num(centre_hole)});\n"
    body += "}"
    half = outer_d / 2
    volume = disc_volume(outer_d, height) - disc_volume(bore, height - base) - disc_volume(centre_hole, base)
    return PartSpec(
        name=name,
        source=_module(name, body),
        bounds=(-half, -half, 0.0, half, half, height),
        volume=volume,
        params={"outer_d": outer_d, "wall": wall, "height": height, "base": base, "centre_hole": centre_hole},
        ru=f"стакан d{num(outer_d)} высотой {num(height)} мм, стенка {num(wall)} мм, дно {num(base)} мм, центральное отверстие d{num(centre_hole)}",
        en=f"housing cup d{num(outer_d)}, {num(height)} mm tall, {num(wall)} mm wall, {num(base)} mm floor, d{num(centre_hole)} centre hole",
    )


def frame_plate(
    name: str,
    length: float,
    width: float,
    thickness: float,
    window: tuple[float, float],
    sockets: list[tuple[float, float]],
    socket_d: float,
    socket_depth: float,
    ru_note: str = "",
    en_note: str = "",
) -> PartSpec:
    """Base frame: a plate with a rectangular window and round sockets for posts."""
    body = "difference() {\n"
    body += "  " + _box(-length / 2, -width / 2, 0.0, length / 2, width / 2, thickness) + "\n"
    body += "  " + _box(-window[0] / 2, -window[1] / 2, -1.0, window[0] / 2, window[1] / 2, thickness + 1) + "\n"
    for x, y in sockets:
        body += (
            f"  translate([{num(x)}, {num(y)}, {num(thickness - socket_depth)}]) "
            f"cylinder(h = {num(socket_depth + 1)}, d = {num(socket_d)});\n"
        )
    body += "}"
    volume = length * width * thickness - window[0] * window[1] * thickness
    volume -= len(sockets) * disc_volume(socket_d, socket_depth)
    return PartSpec(
        name=name,
        source=_module(name, body),
        bounds=(-length / 2, -width / 2, 0.0, length / 2, width / 2, thickness),
        volume=volume,
        params={"length": length, "width": width, "thickness": thickness, "window_x": window[0], "window_y": window[1], "socket_d": socket_d},
        ru=ru_note
        or f"рамное основание {num(length)} x {num(width)} x {num(thickness)} мм с окном {num(window[0])} x {num(window[1])} мм и гнёздами d{num(socket_d)} глубиной {num(socket_depth)} мм",
        en=en_note
        or f"frame base {num(length)} x {num(width)} x {num(thickness)} mm with a {num(window[0])} x {num(window[1])} mm window and d{num(socket_d)} x {num(socket_depth)} mm sockets",
    )


def post(name: str, diameter: float, height: float) -> PartSpec:
    half = diameter / 2
    return PartSpec(
        name=name,
        source=_module(name, f"cylinder(h = {num(height)}, d = {num(diameter)});"),
        bounds=(-half, -half, 0.0, half, half, height),
        volume=disc_volume(diameter, height),
        params={"diameter": diameter, "height": height},
        ru=f"стойка d{num(diameter)} высотой {num(height)} мм",
        en=f"post d{num(diameter)}, {num(height)} mm tall",
    )


def cover(
    name: str,
    outer_d: float,
    thickness: float,
    holes: list[tuple[float, float]],
    hole_d: float,
    bore: float,
    ru_note: str = "",
    en_note: str = "",
) -> PartSpec:
    body = "difference() {\n"
    body += f"  cylinder(h = {num(thickness)}, d = {num(outer_d)});\n"
    if bore > 0:
        body += f"  translate([0, 0, {num(-1)}]) cylinder(h = {num(thickness + 2)}, d = {num(bore)});\n"
    for x, y in holes:
        body += (
            f"  translate([{num(x)}, {num(y)}, {num(-1)}]) "
            f"cylinder(h = {num(thickness + 2)}, d = {num(hole_d)});\n"
        )
    body += "}"
    volume = disc_volume(outer_d, thickness)
    if bore > 0:
        volume -= disc_volume(bore, thickness)
    volume -= len(holes) * disc_volume(hole_d, thickness)
    half = outer_d / 2
    return PartSpec(
        name=name,
        source=_module(name, body),
        bounds=(-half, -half, 0.0, half, half, thickness),
        volume=volume,
        params={"outer_d": outer_d, "thickness": thickness, "hole_d": hole_d, "bore": bore},
        ru=ru_note
        or f"крышка d{num(outer_d)} толщиной {num(thickness)} мм с центральным отверстием d{num(bore)} и {len(holes)} отверстиями d{num(hole_d)} по окружности",
        en=en_note
        or f"cover d{num(outer_d)}, {num(thickness)} mm thick, d{num(bore)} centre bore and {len(holes)} d{num(hole_d)} holes on a circle",
    )


def pulley(name: str, outer_d: float, bore: float, height: float, flange_h: float, hub_d: float) -> PartSpec:
    """Flanged pulley: two side discs on a hub, the gap between them takes the belt."""
    body = "difference() {\n"
    body += "  union() {\n"
    body += f"    cylinder(h = {num(height)}, d = {num(hub_d)});\n"
    body += f"    cylinder(h = {num(flange_h)}, d = {num(outer_d)});\n"
    body += f"    translate([0, 0, {num(height - flange_h)}]) cylinder(h = {num(flange_h)}, d = {num(outer_d)});\n"
    body += "  }\n"
    body += f"  translate([0, 0, {num(-1)}]) cylinder(h = {num(height + 2)}, d = {num(bore)});\n"
    body += "}"
    half = outer_d / 2
    volume = disc_volume(hub_d, height)
    volume += 2.0 * (disc_volume(outer_d, flange_h) - disc_volume(hub_d, flange_h))
    volume -= disc_volume(bore, height)
    return PartSpec(
        name=name,
        source=_module(name, body),
        bounds=(-half, -half, 0.0, half, half, height),
        volume=volume,
        params={"outer_d": outer_d, "bore": bore, "height": height, "flange_h": flange_h, "hub_d": hub_d},
        ru=f"шкив d{num(outer_d)} высотой {num(height)} мм, ступица d{num(hub_d)}, посадка на вал d{num(bore)}, реборды по {num(flange_h)} мм",
        en=f"pulley d{num(outer_d)}, {num(height)} mm tall, d{num(hub_d)} hub bored to d{num(bore)}, {num(flange_h)} mm flanges",
    )


def belt(name: str, inner_d: float, outer_d: float, height: float) -> PartSpec:
    half = outer_d / 2
    return PartSpec(
        name=name,
        source=_module(name, _ring_code(outer_d, inner_d, height, 0.0)),
        bounds=(-half, -half, 0.0, half, half, height),
        volume=disc_volume(outer_d, height) - disc_volume(inner_d, height),
        params={"inner_d": inner_d, "outer_d": outer_d, "height": height},
        ru=f"ремень/лента: кольцо с внутренним d{num(inner_d)}, наружным d{num(outer_d)} и шириной {num(height)} мм",
        en=f"belt: a ring with a d{num(inner_d)} inner and d{num(outer_d)} outer diameter, {num(height)} mm wide",
    )


def clevis(
    name: str,
    length: float,
    width: float,
    height: float,
    slot_w: float,
    pin_d: float,
    pin_z: float,
    base_t: float,
    ru_note: str = "",
    en_note: str = "",
) -> PartSpec:
    """U shaped block: a solid base with a slot cut from the top, drilled along Y."""
    body = "difference() {\n"
    body += "  " + _box(-length / 2, -width / 2, 0.0, length / 2, width / 2, height) + "\n"
    body += "  " + _box(-length / 2 - 1.0, -slot_w / 2, base_t, length / 2 + 1.0, slot_w / 2, height + 1.0) + "\n"
    body += (
        f"  translate([0, 0, {num(pin_z)}]) rotate([90, 0, 0]) "
        f"cylinder(h = {num(width + 2)}, d = {num(pin_d)}, center = true);\n"
    )
    body += "}"
    # the cross hole only removes material from the two cheeks, the slot is empty
    volume = length * width * height - length * slot_w * (height - base_t) - disc_volume(pin_d, width - slot_w)
    return PartSpec(
        name=name,
        source=_module(name, body),
        bounds=(-length / 2, -width / 2, 0.0, length / 2, width / 2, height),
        volume=volume,
        params={"length": length, "width": width, "height": height, "slot_w": slot_w, "pin_d": pin_d, "pin_z": pin_z},
        ru=ru_note
        or f"вилка {num(length)} x {num(width)} мм высотой {num(height)} мм, зев {num(slot_w)} мм, отверстие d{num(pin_d)} по оси Y на высоте {num(pin_z)} мм",
        en=en_note
        or f"clevis {num(length)} x {num(width)} mm, {num(height)} mm tall, {num(slot_w)} mm slot, d{num(pin_d)} cross hole on Y at {num(pin_z)} mm",
    )


def pin(name: str, diameter: float, length: float, head_d: float, head_h: float) -> PartSpec:
    """Pin along X: shaft x in [-length/2, length/2], head on the -X side."""
    body = f"rotate([0, 90, 0]) cylinder(h = {num(length)}, d = {num(diameter)}, center = true);\n"
    body += (
        f"translate([{num(-length / 2 - head_h)}, 0, 0]) rotate([0, 90, 0]) "
        f"cylinder(h = {num(head_h + 1.0)}, d = {num(head_d)});"
    )
    half = max(diameter, head_d) / 2
    return PartSpec(
        name=name,
        source=_module(name, body),
        bounds=(-length / 2 - head_h, -half, -half, length / 2, half, half),
        volume=disc_volume(diameter, length) + disc_volume(head_d, head_h),
        params={"diameter": diameter, "length": length, "head_d": head_d, "head_h": head_h},
        ru=f"палец d{num(diameter)} длиной {num(length)} мм с головкой d{num(head_d)}",
        en=f"pin d{num(diameter)}, {num(length)} mm long, with a d{num(head_d)} head",
    )


def eye_plate(name: str, length: float, thickness: float, height: float, bore: float) -> PartSpec:
    """Clevis tongue: a bar along X whose bore runs along Y, z in [0, height]."""
    body = "difference() {\n"
    body += "  " + _box(-length / 2, -thickness / 2, 0.0, length / 2, thickness / 2, height) + "\n"
    body += (
        f"  translate([0, 0, {num(height / 2)}]) rotate([90, 0, 0]) "
        f"cylinder(h = {num(thickness + 2)}, d = {num(bore)}, center = true);\n"
    )
    body += "}"
    return PartSpec(
        name=name,
        source=_module(name, body),
        bounds=(-length / 2, -thickness / 2, 0.0, length / 2, thickness / 2, height),
        volume=length * thickness * height - disc_volume(bore, thickness),
        params={"length": length, "thickness": thickness, "height": height, "bore": bore},
        ru=f"проушина {num(length)} x {num(thickness)} x {num(height)} мм с отверстием d{num(bore)} по оси Y",
        en=f"eye lug {num(length)} x {num(thickness)} x {num(height)} mm with a d{num(bore)} bore on the Y axis",
    )


def bushing(name: str, outer_d: float, bore: float, height: float, flange_d: float, flange_h: float) -> PartSpec:
    """Sleeve with a flange at the bottom: z in [0, flange_h + height]."""
    body = "difference() {\n"
    body += "  union() {\n"
    body += f"    cylinder(h = {num(flange_h)}, d = {num(flange_d)});\n"
    body += f"    translate([0, 0, {num(flange_h)}]) cylinder(h = {num(height)}, d = {num(outer_d)});\n"
    body += "  }\n"
    body += f"  translate([0, 0, {num(-1)}]) cylinder(h = {num(flange_h + height + 2)}, d = {num(bore)});\n"
    body += "}"
    half = flange_d / 2
    volume = (
        disc_volume(flange_d, flange_h)
        + disc_volume(outer_d, height)
        - disc_volume(bore, flange_h + height)
    )
    return PartSpec(
        name=name,
        source=_module(name, body),
        bounds=(-half, -half, 0.0, half, half, flange_h + height),
        volume=volume,
        params={"outer_d": outer_d, "bore": bore, "height": height, "flange_d": flange_d, "flange_h": flange_h},
        ru=f"втулка d{num(outer_d)} с буртом d{num(flange_d)} x {num(flange_h)} мм, высота {num(height)} мм, отверстие d{num(bore)}",
        en=f"bushing d{num(outer_d)} with a d{num(flange_d)} x {num(flange_h)} mm flange, {num(height)} mm tall, d{num(bore)} bore",
    )


def block(
    name: str,
    length: float,
    width: float,
    height: float,
    bore: float,
    bore_z: float,
    ru_note: str = "",
    en_note: str = "",
) -> PartSpec:
    """Rectangular body with a horizontal bore along X."""
    body = "difference() {\n"
    body += "  " + _box(-length / 2, -width / 2, 0.0, length / 2, width / 2, height) + "\n"
    body += (
        f"  translate([0, 0, {num(bore_z)}]) rotate([0, 90, 0]) "
        f"cylinder(h = {num(length + 2)}, d = {num(bore)}, center = true);\n"
    )
    body += "}"
    return PartSpec(
        name=name,
        source=_module(name, body),
        bounds=(-length / 2, -width / 2, 0.0, length / 2, width / 2, height),
        volume=length * width * height - disc_volume(bore, length),
        params={"length": length, "width": width, "height": height, "bore": bore, "bore_z": bore_z},
        ru=ru_note
        or f"корпус {num(length)} x {num(width)} x {num(height)} мм с расточкой d{num(bore)} по оси X на высоте {num(bore_z)} мм",
        en=en_note
        or f"body {num(length)} x {num(width)} x {num(height)} mm bored d{num(bore)} along X at {num(bore_z)} mm",
    )
