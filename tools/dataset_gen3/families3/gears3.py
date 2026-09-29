"""gen3 gears: two-module rims, herringbones and worm wheels.

The tooth outline is computed here in Python and written into the .scad as a
plain point list, so the geometry is exact, compact and easy to audit.  The
involute flank is approximated with two chords per flank (the "two point"
flank of the request), the rest of the outline is the tip and root arcs.
"""

from __future__ import annotations

import math

from tools.dataset_gen2.common import Part, Rng, ScadBuilder, fmt
from tools.dataset_gen2.prompts import en_count, ru_count
from tools.dataset_gen3.prompts3 import finish_part3, inch_size
from tools.dataset_gen3.toolkit import bolt_circle, num

PITCH_PRESSURE = 20.0

RIM_RU = ("зубчатый венец", "венец с двумя модулями", "зубчатый обод", "кольцевой зубчатый венец")
RIM_EN = ("two-module gear rim", "toothed rim", "double band gear ring", "gear rim blank")
HERRING_RU = ("шевронная шестерня", "шестерня с шевронным зубом", "двухкосая шестерня", "шевронное колесо")
HERRING_EN = ("herringbone gear", "double helical gear", "chevron gear", "herringbone wheel")
WORM_RU = ("червячное колесо", "колесо червячной передачи", "червячный венец", "колесо с винтовым зубом")
WORM_EN = ("worm wheel", "worm gear wheel", "worm wheel blank", "helical worm gear")


def gear_points(
    teeth: int,
    module: float,
    pressure_deg: float = PITCH_PRESSURE,
    flank_points: int = 2,
    root_extra: float = 1.25,
) -> list[tuple[float, float]]:
    """Closed outline of an external gear, counter-clockwise, two chords per flank."""
    pressure = math.radians(pressure_deg)
    pitch_r = module * teeth / 2
    base_r = pitch_r * math.cos(pressure)
    addendum_r = pitch_r + module
    dedendum_r = max(pitch_r - root_extra * module, module * 0.6)
    start_r = max(dedendum_r, base_r + 0.05)

    def involute(radius: float) -> float:
        ratio = min(1.0, base_r / radius)
        alpha = math.acos(ratio)
        return math.tan(alpha) - alpha

    def half_angle(radius: float) -> float:
        return math.pi / (2 * teeth) + involute(pitch_r) - involute(radius)

    radii = [start_r + (addendum_r - start_r) * index / (flank_points + 1) for index in range(1, flank_points + 1)]
    points: list[tuple[float, float]] = []
    for tooth in range(teeth):
        centre = 2 * math.pi * tooth / teeth
        steps = [(dedendum_r, -half_angle(start_r))] + [(radius, -half_angle(radius)) for radius in radii]
        steps += [(addendum_r, -half_angle(addendum_r)), (addendum_r, half_angle(addendum_r))]
        steps += [(radius, half_angle(radius)) for radius in reversed(radii)]
        steps += [(dedendum_r, half_angle(start_r))]
        for radius, offset in steps:
            angle = centre + offset
            points.append((round(radius * math.cos(angle), 3), round(radius * math.sin(angle), 3)))
    return points


def polygon_literal(points: list[tuple[float, float]]) -> str:
    return "[" + ", ".join(f"[{num(x, 3)}, {num(y, 3)}]" for x, y in points) + "]"


def _rim_radius(teeth: int, module: float) -> float:
    return module * (teeth / 2 + 1)


def build_ringgears(index: int) -> Part:
    """A rim carrying two tooth bands of different module, on a webbed ring."""
    rng = Rng("gen3_ringgears", index)
    variant = rng.choice(("double", "double", "single"))
    module_a = rng.grid([2.0, 2.5, 3.0, 3.5])
    teeth_a = int(rng.grid([12, 14, 16, 18, 20]))
    if variant == "double":
        module_b = round(module_a * rng.choice((0.6, 0.7, 0.75)), 3)
        teeth_b = int(rng.grid([18, 20, 24, 28, 32]))
    else:
        module_b, teeth_b = module_a, teeth_a
    outer_r = _rim_radius(teeth_a, module_a)
    if _rim_radius(teeth_b, module_b) > outer_r:
        outer_r = _rim_radius(teeth_b, module_b)
    band_h = rng.grid([8.0, 10.0, 12.0])
    web_t = rng.grid([4.0, 5.0, 6.0])
    root_r = round(module_a * (teeth_a / 2 - 1.25), 2)
    hub_r = round(max(root_r * rng.uniform(0.35, 0.5), module_a * 3.0), 2)
    bore_r = round(hub_r * rng.uniform(0.45, 0.7), 2)
    bore_d = round(2 * bore_r, 2)
    if bore_d < 8.0:
        bore_d = 8.0
        bore_r = 4.0
    hole_count = int(rng.grid([4, 5, 6]))
    hole_r = round((hub_r + root_r) / 2, 2)
    hole_d = round(max(4.0, min((root_r - hub_r) * 0.45, 10.0)), 2)
    total = round(2 * band_h + web_t, 2)
    units = inch_size(rng, max_mm=38.1, min_mm=19.0)
    if units is not None:
        bore_d = units[0]
        bore_r = bore_d / 2
        if bore_r + 2.0 >= hub_r:
            hub_r = round(bore_r + 4.0, 2)

    builder = ScadBuilder(
        "Two-module gear rim",
        f"z{teeth_a} m{fmt(module_a)} and z{teeth_b} m{fmt(module_b)}, {fmt(total)} mm wide",
    )
    builder.param("module_a", module_a, "first tooth module")
    builder.param("teeth_a", float(teeth_a), "first band tooth count")
    builder.param("module_b", module_b, "second tooth module")
    builder.param("teeth_b", float(teeth_b), "second band tooth count")
    builder.param("band_h", band_h, "height of one tooth band")
    builder.param("web_t", web_t, "web thickness between the bands")
    builder.param("total", total, "overall width over both bands")
    builder.param("root_r", root_r, "root radius of the coarse band")
    builder.param("hub_r", hub_r, "hub radius")
    builder.param("bore_d", bore_d, "hub bore")
    builder.param("hole_count", float(hole_count), "lightening holes")
    builder.param("hole_r", hole_r, "lightening hole circle radius")
    builder.param("hole_d", hole_d, "lightening hole diameter")
    builder.assignment("band_a = " + polygon_literal(gear_points(teeth_a, module_a)) + ";")
    builder.assignment("band_b = " + polygon_literal(gear_points(teeth_b, module_b)) + ";")

    lines = [
        "difference() {",
        "  union() {",
        "    /* tooth band A, overlapping the web by 0.4 mm */",
        "    linear_extrude(height = band_h + 0.4) polygon(band_a);",
        "    /* web */",
        "    translate([0, 0, band_h - 0.4]) cylinder(h = web_t + 0.8, d = 2 * root_r);",
        "    /* tooth band B */",
        "    translate([0, 0, band_h + web_t]) linear_extrude(height = band_h + 0.4) polygon(band_b);",
        "    /* hub */",
        "    translate([0, 0, -0.5]) cylinder(h = total + 1.0, d = 2 * hub_r);",
        "  }",
        "  /* bore */",
        "  translate([0, 0, -2.5]) cylinder(h = total + 5, d = bore_d);",
        "  /* lightening holes through the web */",
        "  for (i = [0 : hole_count - 1]) {",
        "    a = i * 360 / hole_count;",
        "    translate([hole_r * cos(a), hole_r * sin(a), -2.5])"
        " cylinder(h = total + 5, d = hole_d);",
        "  }",
        "}",
    ]
    builder.section("\n".join(lines))
    code = builder.render()

    points_a = gear_points(teeth_a, module_a)
    points_b = gear_points(teeth_b, module_b)
    span_x = max(max(x for x, _ in points_a), max(x for x, _ in points_b)) - min(
        min(x for x, _ in points_a), min(x for x, _ in points_b)
    )
    span_y = max(max(y for _, y in points_a), max(y for _, y in points_b)) - min(
        min(y for _, y in points_a), min(y for _, y in points_b)
    )
    outer_r = max(span_x, span_y, 2.0 * hub_r)
    bbox = (float(outer_r), float(outer_r), float(total + 1.0))
    features_ru = [
        f"венец Z{teeth_a} модуль {fmt(module_a)} и венец Z{teeth_b} модуль {fmt(module_b)}",
        f"ступица {fmt(2 * hub_r)} мм с отверстием {fmt(bore_d)} мм",
        f"{ru_count(hole_count, 'окно', 'окна', 'окон')} облегчения на окружности {fmt(2 * hole_r)} мм",
    ]
    features_en = [
        f"Z{teeth_a} module {fmt(module_a)} band and Z{teeth_b} module {fmt(module_b)} band",
        f"{fmt(2 * hub_r)} mm hub with a {fmt(bore_d)} mm bore",
        f"{en_count(hole_count)} lightening holes on a {fmt(2 * hole_r)} mm circle",
    ]
    return finish_part3(
        rng,
        family="ringgears",
        variant=variant,
        code=code,
        bbox=bbox,
        params={
            "module_a": module_a,
            "teeth_a": float(teeth_a),
            "module_b": module_b,
            "teeth_b": float(teeth_b),
            "width": total,
            "wall": round(max(web_t, (hub_r - bore_r)), 2),
        },
        ru_nouns=RIM_RU,
        en_nouns=RIM_EN,
        features_ru=features_ru,
        features_en=features_en,
        units=units,
    )


def build_herringbones(index: int) -> Part:
    """Herringbone wheel: two opposite twisted extrusions of one tooth outline."""
    rng = Rng("gen3_herringbones", index)
    module = rng.grid([2.0, 2.5, 3.0, 4.0])
    max_teeth = int((2 * (115.0 - module)) / module)
    teeth = int(min(rng.grid([14, 16, 18, 20, 24, 28]), max_teeth))
    helix = rng.grid([18.0, 22.0, 26.0, 30.0])
    total = rng.grid([20.0, 24.0, 28.0, 32.0])
    half = round(total / 2, 2)
    hub_r = round(module * (teeth / 2 - 1.25) * rng.uniform(0.45, 0.62), 2)
    hub_r = max(hub_r, module * 2.5)
    bore_d = round(2 * max(hub_r * rng.uniform(0.4, 0.6), 5.0), 2)
    hub_h = round(total + rng.grid([4.0, 6.0, 8.0]), 2)
    rim_r = _rim_radius(teeth, module)

    builder = ScadBuilder(
        "Herringbone gear",
        f"z{teeth} module {fmt(module)}, {fmt(total)} mm wide, {fmt(helix)} degree helix",
    )
    builder.param("gear_module", module, "tooth module")
    builder.param("teeth", float(teeth), "tooth count")
    builder.param("half_w", half, "half width")
    builder.param("helix", helix, "helix angle of each half")
    builder.param("hub_r", hub_r, "hub radius")
    builder.param("hub_h", hub_h, "hub height")
    builder.param("total", total, "overall width over both chevron halves")
    builder.param("bore_d", bore_d, "hub bore")
    builder.assignment("teeth_profile = " + polygon_literal(gear_points(teeth, module)) + ";")

    lines = [
        "difference() {",
        "  union() {",
        "    /* lower half, twisted one way */",
        "    linear_extrude(height = half_w + 0.4, twist = helix, slices = 20)"
        " polygon(teeth_profile);",
        "    /* upper half, twisted the other way, overlapping the joint */",
        "    translate([0, 0, half_w - 0.4])"
        " linear_extrude(height = half_w + 0.4, twist = -helix, slices = 20)"
        " polygon(teeth_profile);",
        "    /* hub */",
        "    translate([0, 0, (total - hub_h) / 2]) cylinder(h = hub_h, d = 2 * hub_r);",
        "  }",
        "  translate([0, 0, (total - hub_h) / 2 - 2.5])"
        " cylinder(h = hub_h + 5, d = bore_d);",
        "}",
    ]
    builder.section("\n".join(lines))
    code = builder.render()

    outer_r = max(rim_r, hub_r)
    bbox = (float(2 * outer_r), float(2 * outer_r), float(hub_h))
    features_ru = [
        f"шевронный зуб Z{teeth} модуль {fmt(module)} под углом {fmt(helix)} градусов",
        f"полуширина {fmt(half)} мм на каждую косую ступень",
        f"ступица {fmt(2 * hub_r)} мм с отверстием {fmt(bore_d)} мм",
    ]
    features_en = [
        f"Z{teeth} module {fmt(module)} herringbone teeth at {fmt(helix)} degrees",
        f"{fmt(half)} mm per chevron half",
        f"{fmt(2 * hub_r)} mm hub with a {fmt(bore_d)} mm bore",
    ]
    return finish_part3(
        rng,
        family="herringbones",
        variant="double_helical",
        code=code,
        bbox=bbox,
        params={
            "module": module,
            "teeth": float(teeth),
            "width": hub_h,
            "wall": round(hub_r - bore_d / 2, 2),
        },
        ru_nouns=HERRING_RU,
        en_nouns=HERRING_EN,
        features_ru=features_ru,
        features_en=features_en,
    )


def build_wormwheels(index: int) -> Part:
    """Worm wheel: strongly twisted rim, hub with keyway and a set screw."""
    rng = Rng("gen3_wormwheels", index)
    module = rng.grid([2.0, 2.5, 3.0, 3.5])
    max_teeth = int((2 * (110.0 - module)) / module)
    teeth = int(min(rng.grid([16, 20, 24, 28, 32]), max_teeth))
    helix = rng.grid([35.0, 42.0, 48.0, 55.0])
    rim_w = rng.grid([12.0, 14.0, 16.0, 18.0])
    hub_r = round(module * (teeth / 2 - 1.25) * rng.uniform(0.4, 0.55), 2)
    hub_r = max(hub_r, module * 2.5)
    hub_h = round(rim_w + rng.grid([10.0, 12.0, 14.0]), 2)
    units = inch_size(rng, max_mm=38.1, min_mm=19.0)
    if units is not None:
        bore_d = units[0]
        if bore_d / 2 + 3.0 > hub_r:
            hub_r = round(bore_d / 2 + 3.0, 2)
    else:
        bore_d = round(2 * max(hub_r * rng.uniform(0.4, 0.55), 5.0), 2)
    key_w = rng.grid([4.0, 5.0, 6.0])
    key_depth = round(key_w * 0.5, 2)
    screw_d = rng.grid([4.0, 5.0, 6.0])
    rim_r = _rim_radius(teeth, module)

    builder = ScadBuilder(
        "Worm wheel",
        f"z{teeth} module {fmt(module)}, {fmt(helix)} degree helix, {fmt(hub_h)} mm hub",
    )
    builder.param("gear_module", module, "tooth module")
    builder.param("teeth", float(teeth), "tooth count")
    builder.param("helix", helix, "helix angle of the rim")
    builder.param("rim_w", rim_w, "rim width")
    builder.param("hub_r", hub_r, "hub radius")
    builder.param("hub_h", hub_h, "hub height")
    builder.param("bore_d", bore_d, "hub bore")
    builder.param("key_w", key_w, "keyway width")
    builder.param("key_depth", key_depth, "keyway depth")
    builder.param("screw_d", screw_d, "set screw thread")
    builder.assignment("rim_profile = " + polygon_literal(gear_points(teeth, module)) + ";")

    lines = [
        "difference() {",
        "  union() {",
        "    /* rim, twisted to stand in for the helical worm teeth */",
        "    translate([0, 0, (hub_h - rim_w) / 2])"
        " linear_extrude(height = rim_w, twist = helix, slices = 24) polygon(rim_profile);",
        "    /* hub */",
        "    cylinder(h = hub_h, d = 2 * hub_r);",
        "  }",
        "  /* bore */",
        "  translate([0, 0, -2.5]) cylinder(h = hub_h + 5, d = bore_d);",
        "  /* keyway, milled through the whole hub */",
        "  translate([bore_d / 2 - key_depth, -key_w / 2, -2.5])"
        " cube([key_depth + 2.5, key_w, hub_h + 5]);",
        "  /* set screw hole straight through the hub wall */",
        "  translate([0, -hub_r - 2.5, hub_h / 2]) rotate([-90, 0, 0])"
        " cylinder(h = 2 * hub_r + 5, d = screw_d);",
        "}",
    ]
    builder.section("\n".join(lines))
    code = builder.render()

    outer_r = max(rim_r, hub_r)
    bbox = (float(2 * outer_r), float(2 * outer_r), float(hub_h))
    features_ru = [
        f"винтовой зуб Z{teeth} модуль {fmt(module)} с углом {fmt(helix)} градусов",
        f"ступица {fmt(2 * hub_r)} мм, отверстие {fmt(bore_d)} мм со шпоночным пазом {fmt(key_w)} мм",
        f"резьбовое отверстие {fmt(screw_d)} мм под стопорный винт",
    ]
    features_en = [
        f"Z{teeth} module {fmt(module)} helical teeth at {fmt(helix)} degrees",
        f"{fmt(2 * hub_r)} mm hub, {fmt(bore_d)} mm bore with a {fmt(key_w)} mm keyway",
        f"a {fmt(screw_d)} mm set screw hole through the hub",
    ]
    return finish_part3(
        rng,
        family="wormwheels",
        variant="helical_rim",
        code=code,
        bbox=bbox,
        params={
            "module": module,
            "teeth": float(teeth),
            "width": hub_h,
            "wall": round(hub_r - bore_d / 2, 2),
        },
        ru_nouns=WORM_RU,
        en_nouns=WORM_EN,
        features_ru=features_ru,
        features_en=features_en,
        units=units,
    )
