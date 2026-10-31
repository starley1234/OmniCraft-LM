"""gen3 marine-ish hardware: spring clips, pipe clamps and boat fittings."""

from __future__ import annotations

import math

from tools.dataset_gen2.common import Part, Rng, ScadBuilder, fmt
from tools.dataset_gen2.prompts import en_count, ru_count
from tools.dataset_gen3.prompts3 import finish_part3, inch_size
from tools.dataset_gen3.toolkit import box, cyl, hole_z, num

CLIP_RU = ("пружинный зажим", "пружинный хомут", "клипса-зажим", "пружинная скоба")
CLIP_EN = ("spring clip", "spring clamp", "pipe spring clip", "spring retaining clip")
PIPE_RU = ("хомут для трубы", "обжимной хомут", "хомут с шарниром", "трубный зажим")
PIPE_EN = ("pipe clamp", "hose clamp body", "hinged pipe clamp", "tube clamp")
CLEAT_RU = ("кнехт", "утка для швартовки", "катерный кнехт", "швартовная утка")
CLEAT_EN = ("boat cleat", "mooring cleat", "dock cleat", "horn cleat")
EYE_RU = ("рым", "рым-болт", "проушина для фала", "рым-скоба")
EYE_EN = ("eye strap", "mooring eye", "eye plate", "deck eye")


def _annulus_sector(outer_r: float, inner_r: float, start_deg: float, end_deg: float, steps: int = 40) -> list[tuple[float, float]]:
    """Closed outline of an annulus sector, outer arc then inner arc back."""
    points: list[tuple[float, float]] = []
    for index in range(steps + 1):
        angle = math.radians(start_deg + (end_deg - start_deg) * index / steps)
        points.append((outer_r * math.cos(angle), outer_r * math.sin(angle)))
    for index in range(steps + 1):
        angle = math.radians(end_deg + (start_deg - end_deg) * index / steps)
        points.append((inner_r * math.cos(angle), inner_r * math.sin(angle)))
    return points


def _outline(points: list[tuple[float, float]]) -> str:
    return "[" + ", ".join(f"[{num(x, 3)}, {num(y, 3)}]" for x, y in points) + "]"


def build_springclamps(index: int) -> Part:
    """Spring clip: a C shaped band that snaps over a pipe, with an optional tab."""
    rng = Rng("gen3_springclamps", index)
    variant = rng.choice(("clip", "clip", "tab"))
    outer_r = rng.grid([20.0, 24.0, 28.0, 32.0])
    band = rng.grid([3.0, 3.5, 4.0, 5.0])
    inner_r = round(outer_r - band, 2)
    width = rng.grid([10.0, 12.0, 14.0])
    gap = rng.grid([50.0, 60.0, 70.0, 80.0])
    start = round(90 + gap / 2, 2)
    end = round(450 - gap / 2, 2)
    steps = 36
    tab_w = rng.grid([18.0, 22.0, 26.0])
    tab_len = rng.grid([10.0, 12.0, 14.0])
    tab_hole = rng.grid([4.4, 5.4, 6.6])
    sink = 2.0

    outline = _annulus_sector(outer_r, inner_r, start, end, steps)
    end_angle = math.radians(start)
    tab_y0 = round(-(outer_r + tab_len), 2)
    tab_top = round(-(outer_r - sink), 2)

    builder = ScadBuilder(
        "Spring clip",
        f"{fmt(2 * outer_r)} mm outside, {fmt(band)} mm band, {fmt(gap)} degree opening",
    )
    builder.param("outer_r", outer_r, "clip outside radius")
    builder.param("inner_r", inner_r, "clip bore radius")
    builder.param("band", band, "band thickness")
    builder.param("clip_w", width, "clip width")
    builder.param("opening", gap, "opening angle")
    if variant == "tab":
        builder.param("tab_w", tab_w, "tab width")
        builder.param("tab_len", tab_len, "tab length past the clip")
        builder.param("tab_hole", tab_hole, "tab fixing hole")
    builder.assignment("clip_profile = " + _outline(outline) + ";")

    lines = ["difference() {", "  union() {", "    linear_extrude(height = clip_w) polygon(clip_profile);"]
    if variant == "tab":
        lines.append("    /* mounting tab, sunk 2 mm into the band */")
        lines.append(
            "    translate([%s, %s, 0]) cube([tab_w, %s, clip_w]);"
            % (num(-tab_w / 2, 3), num(tab_y0, 3), num(round(tab_top - tab_y0, 3), 3))
        )
    lines.append("  }")
    if variant == "tab":
        lines.append("  translate([0, %s, -2.5]) cylinder(h = clip_w + 5, d = tab_hole);" % num((tab_y0 + tab_top) / 2, 3))
    lines.append("}")
    builder.section("\n".join(lines))
    code = builder.render()

    outline_x = [x for x, _ in outline]
    outline_y = [y for _, y in outline]
    if variant == "tab":
        outline_x += [-tab_w / 2, tab_w / 2]
        outline_y += [tab_y0, tab_top]
    bbox = (
        float(round(max(outline_x) - min(outline_x), 3)),
        float(round(max(outline_y) - min(outline_y), 3)),
        float(width),
    )
    features_ru = [
        f"кольцо {fmt(inner_r)} мм внутри и {fmt(outer_r)} мм снаружи",
        f"раствор {fmt(gap)} градусов для защёлкивания на трубе",
        f"лента шириной {fmt(width)} мм и толщиной {fmt(band)} мм",
    ]
    features_en = [
        f"a ring {fmt(inner_r)} mm inside and {fmt(outer_r)} mm outside",
        f"a {fmt(gap)} degree opening so it snaps over the pipe",
        f"a {fmt(width)} mm wide band, {fmt(band)} mm thick",
    ]
    if variant == "tab":
        features_ru.append(f"монтажное ушко с отверстием {fmt(tab_hole)} мм")
        features_en.append(f"a mounting tab with a {fmt(tab_hole)} mm hole")
    return finish_part3(
        rng,
        family="springclamps",
        variant=variant,
        code=code,
        bbox=bbox,
        params={"outer_r": outer_r, "band": band, "width": width, "inner_r": inner_r},
        ru_nouns=CLIP_RU,
        en_nouns=CLIP_EN,
        features_ru=features_ru,
        features_en=features_en,
    )


def build_pipeclamps(index: int) -> Part:
    """Pipe clamp: a ring with a hinge knuckle on one end and a bolt lug on the other."""
    rng = Rng("gen3_pipeclamps", index)
    variant = rng.choice(("hinge", "hinge", "lugs"))
    units = inch_size(rng, max_mm=32.0, min_mm=20.0)
    band = rng.grid([3.5, 4.0, 4.5, 5.0])
    if units:
        inner_r = round(units[0] / 2, 2)
        outer_r = round(inner_r + band, 2)
    else:
        outer_r = rng.grid([26.0, 30.0, 34.0, 38.0])
        inner_r = round(outer_r - band, 2)
    width = rng.grid([12.0, 14.0, 16.0])
    gap = rng.grid([40.0, 50.0, 60.0])
    start = round(90 + gap / 2, 2)
    end = round(450 - gap / 2, 2)
    knuckle_d = rng.grid([12.0, 14.0, 16.0])
    pin_d = rng.grid([4.4, 5.4, 6.6])
    lug_w = rng.grid([16.0, 20.0, 24.0])
    lug_len = rng.grid([14.0, 17.0, 20.0])
    bolt_d = rng.grid([6.6, 8.4])
    steps = 36

    outline = _annulus_sector(outer_r, inner_r, start, end, steps)
    start_angle = math.radians(end)  # the lug end
    end_angle = math.radians(start)  # the hinge end
    band_mid = round((outer_r + inner_r) / 2, 2)
    knuckle = (round(band_mid * math.cos(end_angle), 2), round(band_mid * math.sin(end_angle), 2))
    lug_anchor = (round(band_mid * math.cos(start_angle), 2), round(band_mid * math.sin(start_angle), 2))
    lug_x0 = round(lug_anchor[0] - lug_w / 2, 2)
    lug_y1 = round(lug_anchor[1] + lug_len - 3.0, 2)
    lug_y0 = round(lug_anchor[1] - 3.0, 2)
    bolt_center = (round(lug_anchor[0], 2), round((lug_y0 + lug_y1) / 2, 2))
    corners: list[tuple[float, float]] = list(outline)
    corners += [(lug_x0, lug_y0), (lug_x0 + lug_w, lug_y0), (lug_x0, lug_y1), (lug_x0 + lug_w, lug_y1)]
    if variant == "hinge":
        corners += [
            (knuckle[0] - knuckle_d / 2, knuckle[1] - knuckle_d / 2),
            (knuckle[0] + knuckle_d / 2, knuckle[1] + knuckle_d / 2),
        ]

    builder = ScadBuilder(
        "Pipe clamp",
        f"{fmt(2 * outer_r)} mm ring, {fmt(band)} mm wall, {fmt(width)} mm wide",
    )
    builder.param("outer_r", outer_r, "clamp outside radius")
    builder.param("inner_r", inner_r, "pipe bore radius")
    builder.param("band", band, "band thickness")
    builder.param("clamp_w", width, "clamp width")
    builder.param("opening", gap, "opening angle between the ends")
    builder.param("lug_w", lug_w, "lug width")
    builder.param("lug_len", lug_len, "lug length")
    builder.param("bolt_d", bolt_d, "bolt hole")
    if variant == "hinge":
        builder.param("knuckle_d", knuckle_d, "hinge knuckle diameter")
        builder.param("pin_d", pin_d, "hinge pin hole")
    builder.assignment("clamp_profile = " + _outline(outline) + ";")

    lines = ["difference() {", "  union() {", "    linear_extrude(height = clamp_w) polygon(clamp_profile);"]
    if variant == "hinge":
        lines.append("    /* hinge knuckle, sunk 2 mm into the band end */")
        lines.append(
            "    translate([%s, %s, 0]) cylinder(h = clamp_w, d = knuckle_d);"
            % (num(knuckle[0], 3), num(knuckle[1], 3))
        )
    lines.append("    /* bolt lug on the other end */")
    lines.append(
        "    translate([%s, %s, 0]) cube([lug_w, %s, clamp_w]);"
        % (num(lug_x0, 3), num(lug_y0, 3), num(round(lug_y1 - lug_y0, 3), 3))
    )
    lines.append("  }")
    lines.append(
        "  translate([%s, %s, -2.5]) cylinder(h = clamp_w + 5, d = bolt_d);"
        % (num(bolt_center[0], 3), num(bolt_center[1], 3))
    )
    if variant == "hinge":
        lines.append(
            "  translate([%s, %s, -2.5]) cylinder(h = clamp_w + 5, d = pin_d);"
            % (num(knuckle[0], 3), num(knuckle[1], 3))
        )
    lines.append("}")
    builder.section("\n".join(lines))
    code = builder.render()

    span_x = max(x for x, _ in corners) - min(x for x, _ in corners)
    span_y = max(y for _, y in corners) - min(y for _, y in corners)
    bbox = (float(round(span_x, 3)), float(round(span_y, 3)), float(width))
    features_ru = [
        f"кольцо под трубу {fmt(inner_r)} мм, наружный {fmt(outer_r)} мм",
        f"ушко {fmt(lug_w)} x {fmt(lug_len)} мм с отверстием {fmt(bolt_d)} мм",
    ]
    features_en = [
        f"a {fmt(inner_r)} mm pipe seat in a {fmt(outer_r)} mm body",
        f"a {fmt(lug_w)} x {fmt(lug_len)} mm lug with a {fmt(bolt_d)} mm bolt hole",
    ]
    if variant == "hinge":
        features_ru.append(f"шарнирная проушина {fmt(knuckle_d)} мм с пальцем {fmt(pin_d)} мм")
        features_en.append(f"a {fmt(knuckle_d)} mm hinge knuckle taking a {fmt(pin_d)} mm pin")
    else:
        features_ru.append("второе ушко под болт вместо шарнира")
        features_en.append("a second bolt lug instead of the hinge")
    return finish_part3(
        rng,
        family="pipeclamps",
        variant=variant,
        code=code,
        bbox=bbox,
        params={"outer_r": outer_r, "band": band, "width": width, "inner_r": inner_r},
        ru_nouns=PIPE_RU,
        en_nouns=PIPE_EN,
        features_ru=features_ru,
        features_en=features_en,
        units=units,
    )


def build_cleats(index: int) -> Part:
    """Boat fittings: a horn cleat (base + post + tapered horn) or an eye strap."""
    rng = Rng("gen3_cleats", index)
    variant = rng.choice(("cleat", "cleat", "eye"))
    if variant == "cleat":
        base_l = rng.grid([70.0, 80.0, 90.0])
        base_w = rng.grid([26.0, 30.0, 34.0])
        base_t = rng.grid([6.0, 8.0, 10.0])
        horn_len = round(base_l * rng.choice((0.85, 0.95)), 2)
        horn_d = rng.grid([14.0, 18.0, 22.0])
        horn_z = round(base_t + rng.grid([24.0, 30.0, 36.0]), 2)
        end_drop = rng.grid([6.0, 8.0, 10.0])
        post_d = round(horn_d * rng.choice((0.5, 0.6)), 2)
        units = inch_size(rng, max_mm=9.0, min_mm=6.0)
        holes_d = units[0] if units else rng.grid([6.6, 8.4])
        hole_x = round(base_l / 2 - rng.grid([10.0, 12.0]), 2)
        total_h = round(horn_z + horn_d / 2, 2)

        builder = ScadBuilder("Boat cleat", f"{fmt(base_l)} mm base, horn {fmt(horn_z)} mm up")
        builder.param("base_l", base_l, "base length")
        builder.param("base_w", base_w, "base width")
        builder.param("base_t", base_t, "base thickness")
        builder.param("horn_len", horn_len, "horn length")
        builder.param("horn_d", horn_d, "horn diameter at the middle")
        builder.param("horn_z", horn_z, "horn axis height")
        builder.param("end_drop", end_drop, "how far the horn tips drop")
        builder.param("post_d", post_d, "centre post diameter")
        builder.param("holes_d", holes_d, "fixing holes")
        builder.param("hole_x", hole_x, "fixing hole spacing")

        horn_radius = round(horn_d / 2, 2)
        stations = [
            (round(-horn_len / 2, 2), round(horn_d * 0.45, 2), round(max(horn_d - end_drop, horn_d * 0.45), 2), round(horn_z - horn_radius, 2)),
            (round(-horn_len * 0.32, 2), round(horn_d * 0.8, 2), round(horn_d - end_drop * 0.25, 2), round(horn_z - horn_radius, 2)),
            (0.0, horn_d, horn_d, round(horn_z - horn_radius, 2)),
            (round(horn_len * 0.32, 2), round(horn_d * 0.8, 2), round(horn_d - end_drop * 0.25, 2), round(horn_z - horn_radius, 2)),
            (round(horn_len / 2, 2), round(horn_d * 0.45, 2), round(max(horn_d - end_drop, horn_d * 0.45), 2), round(horn_z - horn_radius, 2)),
        ]
        horn_lines = []
        for first, second in zip(stations, stations[1:]):
            horn_lines.append("hull() {")
            for x, w, h, z0 in (first, second):
                horn_lines.append(
                    "  translate([%s, %s, %s]) cube([0.4, %s, %s], center = false);"
                    % (num(x, 3), num(-w / 2, 3), num(z0, 3), num(w, 3), num(h, 3))
                )
            horn_lines.append("}")

        lines = [
            "difference() {",
            "  union() {",
            "    translate([%s, %s, 0]) cube([base_l, base_w, base_t]);" % (num(-base_l / 2, 3), num(-base_w / 2, 3)),
            "    /* centre post, sunk 1 mm into the base */",
            "    translate([0, 0, %s]) cylinder(h = %s, d = post_d);" % (num(base_t - 1.0, 3), num(round(horn_z - base_t + 1.0, 3), 3)),
            "    /* horn: a hull chain of boxes, full in the middle and lighter at the tips */",
            "\n".join("    " + line for line in horn_lines),
            "  }",
        ]
        for hx in (-hole_x, hole_x):
            lines.append("  translate([%s, 0, -2.5]) cylinder(h = base_t + 5, d = holes_d);" % num(hx, 3))
        lines.append("}")
        builder.section("\n".join(lines))
        code = builder.render()

        bbox = (float(max(base_l, round(horn_len + 0.4, 2))), float(base_w), float(total_h))
        features_ru = [
            f"рога {fmt(horn_len)} мм с осью на высоте {fmt(horn_z)} мм",
            f"центральная стойка {fmt(post_d)} мм и основание {fmt(base_l)} x {fmt(base_w)} x {fmt(base_t)} мм",
            f"{ru_count(2, 'крепёжное отверстие', 'крепёжных отверстия', 'крепёжных отверстий')} {fmt(holes_d)} мм с шагом {fmt(2 * hole_x)} мм",
        ]
        features_en = [
            f"a {fmt(horn_len)} mm horn with its axis {fmt(horn_z)} mm up",
            f"a {fmt(post_d)} mm post on a {fmt(base_l)} x {fmt(base_w)} x {fmt(base_t)} mm base",
            f"{en_count(2)} {fmt(holes_d)} mm fixing holes on a {fmt(2 * hole_x)} mm spacing",
        ]
        return finish_part3(
            rng,
            family="cleats",
            variant=variant,
            code=code,
            bbox=bbox,
            params={"base_l": base_l, "height": total_h, "wall": post_d, "horn_d": horn_d},
            ru_nouns=CLEAT_RU,
            en_nouns=CLEAT_EN,
            features_ru=features_ru,
            features_en=features_en,
            units=units,
        )

    base_l = rng.grid([40.0, 48.0, 56.0])
    base_w = rng.grid([24.0, 28.0, 32.0])
    base_t = rng.grid([6.0, 8.0, 10.0])
    eye_r = rng.grid([12.0, 14.0, 16.0, 18.0])
    web = rng.grid([4.0, 5.0, 6.0])
    eye_w = rng.grid([10.0, 12.0, 14.0])
    sink = 3.0
    units = inch_size(rng, max_mm=8.0, min_mm=5.0)
    holes_d = units[0] if units else rng.grid([5.4, 6.6, 8.4])
    hole_off = round(base_l / 2 - rng.grid([8.0, 10.0]), 2)
    eye_z = round(base_t + eye_r - sink, 2)
    total_h = round(eye_z + eye_r, 2)

    eye_bore = round(2 * (eye_r - web), 2)
    builder = ScadBuilder("Deck eye", f"{fmt(2 * eye_r)} mm eye on a {fmt(base_l)} mm base")
    builder.param("base_l", base_l, "base length")
    builder.param("base_w", base_w, "base width")
    builder.param("base_t", base_t, "base thickness")
    builder.param("eye_r", eye_r, "eye outside radius")
    builder.param("eye_bore", eye_bore, "eye bore diameter")
    builder.param("eye_w", eye_w, "eye thickness")
    builder.param("eye_z", eye_z, "eye centre height")
    builder.param("holes_d", holes_d, "fixing holes")
    builder.param("hole_x", hole_off, "fixing hole spacing")

    lines = [
        "difference() {",
        "  union() {",
        "    translate([%s, %s, 0]) cube([base_l, base_w, base_t]);" % (num(-base_l / 2, 3), num(-base_w / 2, 3)),
        "    /* eye standing upright, its foot sunk 3 mm into the base */",
        "    translate([0, %s, %s]) rotate([-90, 0, 0]) cylinder(h = %s, d = %s);"
        % (num(-eye_w / 2, 3), num(eye_z, 3), num(eye_w, 3), num(2 * eye_r, 3)),
        "  }",
        "  /* eye bore, 2.5 mm clear of both faces */",
        "  translate([0, %s, %s]) rotate([-90, 0, 0]) cylinder(h = %s, d = %s);"
        % (num(-eye_w / 2 - 2.5, 3), num(eye_z, 3), num(eye_w + 5, 3), num(eye_bore, 3)),
    ]
    for hx in (-hole_off, hole_off):
        lines.append("  translate([%s, 0, -2.5]) cylinder(h = base_t + 5, d = holes_d);" % num(hx, 3))
    lines.append("}")
    builder.section("\n".join(lines))
    code = builder.render()

    bbox = (float(max(base_l, 2 * eye_r)), float(max(base_w, eye_w)), float(total_h))
    features_ru = [
        f"рым с наружным радиусом {fmt(eye_r)} мм и отверстием {fmt(eye_bore)} мм",
        f"проушина толщиной {fmt(eye_w)} мм утоплена на {fmt(sink)} мм в основание",
        f"{ru_count(2, 'крепёжное отверстие', 'крепёжных отверстия', 'крепёжных отверстий')} {fmt(holes_d)} мм по краям основания",
    ]
    features_en = [
        f"an eye {fmt(eye_r)} mm outside with a {fmt(eye_bore)} mm bore",
        f"a {fmt(eye_w)} mm thick eye sunk {fmt(sink)} mm into the base",
        f"{en_count(2)} {fmt(holes_d)} mm fixing holes at the base ends",
    ]
    return finish_part3(
        rng,
        family="cleats",
        variant=variant,
        code=code,
        bbox=bbox,
        params={"base_l": base_l, "height": total_h, "wall": web, "eye_r": eye_r},
        ru_nouns=EYE_RU,
        en_nouns=EYE_EN,
        features_ru=features_ru,
        features_en=features_en,
        units=units,
    )
