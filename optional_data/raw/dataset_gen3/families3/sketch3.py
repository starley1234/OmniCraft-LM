"""gen3 sketch family: polar cams, smooth levers, hooks and belt rollers.

The outlines here are *sketches*: the point list is computed in Python and
written into the .scad as a literal, then extruded (or revolved for the
rollers).  That is the pattern the future SketchCanvas generator will use.
"""

from __future__ import annotations

import math

from tools.dataset_gen2.common import Part, Rng, ScadBuilder, fmt
from tools.dataset_gen2.prompts import en_count, ru_count
from tools.dataset_gen3.prompts3 import finish_part3, inch_size
from tools.dataset_gen3.toolkit import num

CAM_RU = ("кулачок", "кулачок с переменным радиусом", "профильный кулачок", "кулачок с подъёмом")
CAM_EN = ("cam", "variable radius cam", "profile cam", "cam with a lift")
LEVER_RU = ("рычаг", "рычаг с плавным контуром", "коромысло", "рычаг с двумя проушинами")
LEVER_EN = ("lever", "smooth contour lever", "rocker arm", "two-hole lever")
HOOK_RU = ("крюк", "крюк с гладким контуром", "крюк для тали", "грузовой крюк")
HOOK_EN = ("hook", "smooth contour hook", "hoist hook", "lifting hook")
ROLLER_RU = ("ролик ремня", "натяжной ролик", "опорный ролик ремня", "ролик с ребордами")
ROLLER_EN = ("belt roller", "idler roller", "belt support roller", "flanged belt roller")


def _outline(points: list[tuple[float, float]]) -> str:
    return "[" + ", ".join(f"[{num(x, 3)}, {num(y, 3)}]" for x, y in points) + "]"


def _circle_points(centre: tuple[float, float], radius: float, steps: int = 40) -> list[tuple[float, float]]:
    return [
        (centre[0] + radius * math.cos(2 * math.pi * index / steps), centre[1] + radius * math.sin(2 * math.pi * index / steps))
        for index in range(steps)
    ]


def _convex_hull(points: list[tuple[float, float]]) -> list[tuple[float, float]]:
    """Monotone chain hull, so a lever outline is smooth by construction."""
    unique = sorted({(round(x, 6), round(y, 6)) for x, y in points})
    if len(unique) <= 2:
        return unique

    def cross(o, a, b):
        return (a[0] - o[0]) * (b[1] - o[1]) - (a[1] - o[1]) * (b[0] - o[0])

    lower: list[tuple[float, float]] = []
    for point in unique:
        while len(lower) >= 2 and cross(lower[-2], lower[-1], point) <= 0:
            lower.pop()
        lower.append(point)
    upper: list[tuple[float, float]] = []
    for point in reversed(unique):
        while len(upper) >= 2 and cross(upper[-2], upper[-1], point) <= 0:
            upper.pop()
        upper.append(point)
    return lower[:-1] + upper[:-1]


def build_cams(index: int) -> Part:
    """Polar cam: r(theta) = base radius plus a smooth lift, hub with keyway."""
    rng = Rng("gen3_cams", index)
    variant = rng.choice(("rise", "rise", "double", "dwell"))
    base_r = rng.grid([18.0, 20.0, 22.0, 24.0, 26.0])
    lift = rng.grid([8.0, 10.0, 12.0, 14.0])
    span = rng.grid([120.0, 150.0, 180.0])
    start = rng.grid([0.0, 30.0, 45.0, 90.0])
    thick = rng.grid([8.0, 10.0, 12.0])
    hub_d = round(base_r * rng.choice((0.85, 0.95)), 2)
    hub_h = round(thick + rng.grid([8.0, 10.0, 12.0]), 2)
    units = inch_size(rng, max_mm=14.0, min_mm=8.0)
    bore_d = units[0] if units else rng.grid([8.0, 10.0, 12.0, 14.0])
    key_w = rng.grid([4.0, 5.0, 6.0])
    key_depth = round(min(key_w * 0.5, (hub_d - bore_d) / 2 - 2.0), 2)
    if key_depth < 1.6:
        key_depth = 1.6
    steps = 72

    def profile(angle_deg: float) -> float:
        angle = angle_deg % 360.0
        value = base_r
        windows = [(start, span)]
        if variant == "double":
            windows = [(start, span * 0.55), (start + 180.0, span * 0.55)]
        for window_start, window_span in windows:
            offset = (angle - window_start) % 360.0
            if offset > window_span:
                continue
            progress = offset / window_span
            if variant == "dwell":
                if progress < 0.35:
                    bump = 0.5 * (1 - math.cos(math.pi * progress / 0.35))
                elif progress < 0.65:
                    bump = 1.0
                else:
                    bump = 0.5 * (1 - math.cos(math.pi * (1 - progress) / 0.35))
            else:
                bump = 0.5 * (1 - math.cos(2 * math.pi * progress))
            value = max(value, base_r + lift * bump)
        return value

    outline = []
    for step in range(steps):
        angle_deg = 360.0 * step / steps
        radius = profile(angle_deg)
        angle = math.radians(angle_deg)
        outline.append((round(radius * math.cos(angle), 3), round(radius * math.sin(angle), 3)))

    builder = ScadBuilder(
        "Cam",
        f"base radius {fmt(base_r)} mm with a {fmt(lift)} mm lift over {fmt(span)} degrees",
    )
    builder.param("base_r", base_r, "base radius")
    builder.param("lift", lift, "lift height above the base radius")
    builder.param("lift_span", span, "angular width of the lift")
    builder.param("lift_start", start, "angle where the lift starts")
    builder.param("cam_t", thick, "cam plate thickness")
    builder.param("hub_d", hub_d, "hub diameter")
    builder.param("hub_h", hub_h, "hub height")
    builder.param("bore_d", bore_d, "bore")
    builder.param("key_w", key_w, "keyway width")
    builder.param("key_depth", key_depth, "keyway depth")
    builder.assignment("cam_profile = " + _outline(outline) + ";")

    hub_z0 = round((thick - hub_h) / 2, 3)
    lines = [
        "difference() {",
        "  union() {",
        "    linear_extrude(height = cam_t) polygon(cam_profile);",
        "    /* hub, proud of the cam plate on both sides */",
        "    translate([0, 0, %s]) cylinder(h = hub_h, d = hub_d);" % num(hub_z0, 3),
        "  }",
        "  /* bore through the hub, 2.5 mm clear on both faces */",
        "  translate([0, 0, %s]) cylinder(h = hub_h + 5, d = bore_d);" % num(round(hub_z0 - 2.5, 3), 3),
        "  /* keyway, milled through the whole hub */",
        "  translate([%s, %s, %s]) cube([%s, %s, %s]);"
        % (
            num(round(bore_d / 2 - key_depth, 3), 3),
            num(-key_w / 2, 3),
            num(round(hub_z0 - 2.5, 3), 3),
            num(round(key_depth + 2.5, 3), 3),
            num(key_w, 3),
            num(hub_h + 5, 3),
        ),
        "}",
    ]
    builder.section("\n".join(lines))
    code = builder.render()

    xs = [x for x, _ in outline]
    ys = [y for _, y in outline]
    bbox = (
        float(max(round(max(xs) - min(xs), 3), hub_d)),
        float(max(round(max(ys) - min(ys), 3), hub_d)),
        float(hub_h),
    )
    features_ru = [
        f"подъём {fmt(lift)} мм на участке {fmt(span)} градусов от {fmt(start)} градусов",
        f"базовый радиус {fmt(base_r)} мм, толщина кулачка {fmt(thick)} мм",
        f"ступица {fmt(hub_d)} мм с отверстием {fmt(bore_d)} мм и шпоночным пазом {fmt(key_w)} мм",
    ]
    features_en = [
        f"a {fmt(lift)} mm lift over {fmt(span)} degrees starting at {fmt(start)} degrees",
        f"a {fmt(base_r)} mm base radius and a {fmt(thick)} mm cam plate",
        f"a {fmt(hub_d)} mm hub with a {fmt(bore_d)} mm bore and a {fmt(key_w)} mm keyway",
    ]
    return finish_part3(
        rng,
        family="cams",
        variant=variant,
        code=code,
        bbox=bbox,
        params={"base_r": base_r, "lift": lift, "thick": thick, "bore_d": bore_d},
        ru_nouns=CAM_RU,
        en_nouns=CAM_EN,
        features_ru=features_ru,
        features_en=features_en,
        units=units,
    )


def build_levers(index: int) -> Part:
    """Lever: a smooth outline through two or three bosses, with bores and a slot."""
    rng = Rng("gen3_levers", index)
    variant = rng.choice(("straight", "straight", "knee", "slotted"))
    length = rng.grid([70.0, 85.0, 100.0, 115.0])
    boss_a = rng.grid([9.0, 10.0, 12.0])
    boss_b = rng.grid([7.0, 8.0, 9.0])
    units = inch_size(rng, max_mm=12.7, min_mm=6.0)
    bore_a = units[0] if units else round(boss_a * rng.choice((0.45, 0.5)), 2)
    boss_a = round(max(boss_a, bore_a / 2 + 3.5), 2)
    bore_b = round(boss_b * rng.choice((0.4, 0.45)), 2)
    boss_c = rng.grid([11.0, 13.0])
    bend = round(length * rng.choice((0.08, 0.12, 0.16)), 2)
    thick = rng.grid([6.0, 8.0, 10.0])
    slot_w = rng.grid([5.4, 6.6])

    centre_a = (-length / 2, 0.0)
    centre_b = (length / 2, 0.0)
    circles = [
        (centre_a, boss_a),
        (centre_b, boss_b),
    ]
    if variant in ("knee", "slotted"):
        circles.append(((0.0, -bend), boss_c))
    points: list[tuple[float, float]] = []
    for centre, radius in circles:
        points += _circle_points(centre, radius, 40)
    outline = _convex_hull(points)

    builder = ScadBuilder(
        "Lever",
        f"{fmt(length)} mm between the bosses, {fmt(thick)} mm thick, smooth outline",
    )
    builder.param("lever_l", length, "distance between the boss centres")
    builder.param("boss_a", round(2 * boss_a, 2), "first boss diameter")
    builder.param("boss_b", round(2 * boss_b, 2), "second boss diameter")
    builder.param("bore_a", bore_a, "first bore")
    builder.param("bore_b", bore_b, "second bore")
    builder.param("lever_t", thick, "lever thickness")
    if variant in ("knee", "slotted"):
        builder.param("boss_c", round(2 * boss_c, 2), "middle boss diameter")
        builder.param("bend", bend, "how far the middle boss drops")
    if variant == "slotted":
        builder.param("slot_w", slot_w, "adjustment slot width")
    builder.assignment("lever_profile = " + _outline(outline) + ";")

    lines = ["difference() {", "  linear_extrude(height = lever_t) polygon(lever_profile);"]
    lines.append(
        "  translate([%s, 0, -2.5]) cylinder(h = lever_t + 5, d = bore_a);" % num(centre_a[0], 3)
    )
    lines.append(
        "  translate([%s, 0, -2.5]) cylinder(h = lever_t + 5, d = bore_b);" % num(centre_b[0], 3)
    )
    if variant == "slotted":
        offset = round(length * 0.12, 2)
        lines.append("  /* slotted adjustment, stadium shaped */")
        lines.append("  hull() {")
        for x in (-offset, offset):
            lines.append(
                "    translate([%s, 0, -2.5]) cylinder(h = lever_t + 5, d = slot_w);" % num(x, 3)
            )
        lines.append("  }")
    lines.append("}")
    builder.section("\n".join(lines))
    code = builder.render()

    xs = [x for x, _ in outline]
    ys = [y for _, y in outline]
    bbox = (float(round(max(xs) - min(xs), 3)), float(round(max(ys) - min(ys), 3)), float(thick))
    features_ru = [
        f"плавный контур через {ru_count(len(circles), 'бобышку', 'бобышки', 'бобышек')} {fmt(2 * boss_a)} и {fmt(2 * boss_b)} мм",
        f"отверстия {fmt(bore_a)} и {fmt(bore_b)} мм по центрам {fmt(length)} мм",
        f"толщина {fmt(thick)} мм по всей детали",
    ]
    features_en = [
        f"a smooth outline through {en_count(len(circles))} bosses of {fmt(2 * boss_a)} and {fmt(2 * boss_b)} mm",
        f"{fmt(bore_a)} and {fmt(bore_b)} mm bores {fmt(length)} mm apart",
        f"{fmt(thick)} mm thick all over",
    ]
    if variant in ("knee", "slotted"):
        features_ru.append(f"средняя бобышка {fmt(2 * boss_c)} мм смещена на {fmt(bend)} мм")
        features_en.append(f"a {fmt(2 * boss_c)} mm middle boss offset by {fmt(bend)} mm")
    if variant == "slotted":
        features_ru.append(f"паз {fmt(slot_w)} мм под регулировку")
        features_en.append(f"a {fmt(slot_w)} mm adjustment slot")
    return finish_part3(
        rng,
        family="levers",
        variant=variant,
        code=code,
        bbox=bbox,
        params={"length": length, "thick": thick, "wall": round(boss_b - bore_b / 2, 2), "bore_a": bore_a},
        ru_nouns=LEVER_RU,
        en_nouns=LEVER_EN,
        features_ru=features_ru,
        features_en=features_en,
        units=units,
    )


def build_hooks(index: int) -> Part:
    """Hook: boss with a bore, a straight shank and a smooth circular curl."""
    rng = Rng("gen3_hooks", index)
    variant = rng.choice(("hook", "hook", "hook", "eye"))
    shank_len = rng.grid([50.0, 60.0, 70.0, 80.0])
    shank_w = rng.grid([10.0, 12.0, 14.0])
    boss_d = rng.grid([26.0, 30.0, 34.0])
    if variant == "eye":
        units = inch_size(rng, max_mm=19.0, min_mm=13.0)
        bore_d = units[0] if units else rng.grid([14.0, 16.0, 18.0])
        curl_in = rng.grid([18.0, 22.0, 26.0])
        sweep = 350.0
    else:
        units = inch_size(rng, max_mm=13.0, min_mm=8.0)
        bore_d = units[0] if units else rng.grid([8.0, 10.0, 12.0])
        curl_in = rng.grid([14.0, 18.0, 22.0])
        sweep = rng.grid([250.0, 270.0, 290.0])
    band = rng.grid([9.0, 11.0, 13.0])
    curl_out = round(curl_in + band, 2)
    thick = rng.grid([8.0, 10.0, 12.0])
    boss_r = boss_d / 2
    z_curl = round(shank_len * 0.5, 2)
    shank_top = round(boss_r - 2.0, 2)
    shank_bottom = round(z_curl + curl_in - band * 0.4, 2)

    shank_points = [
        (-shank_w / 2, shank_bottom),
        (shank_w / 2, shank_bottom),
        (shank_w / 2, shank_top),
        (-shank_w / 2, shank_top),
    ]
    boss_points = _circle_points((0.0, 0.0), boss_r, 40)
    curl_points: list[tuple[float, float]] = []
    steps = 32
    for index_step in range(steps + 1):
        angle = math.radians(90.0 + sweep * index_step / steps)
        curl_points.append((curl_out * math.cos(angle), z_curl + curl_out * math.sin(angle)))
    for index_step in range(steps + 1):
        angle = math.radians(90.0 + sweep * (steps - index_step) / steps)
        curl_points.append((curl_in * math.cos(angle), z_curl + curl_in * math.sin(angle)))

    builder = ScadBuilder(
        "Hook",
        f"{fmt(shank_len)} mm shank into a {fmt(curl_in)} mm curl, {fmt(thick)} mm thick",
    )
    builder.param("shank_len", shank_len, "shank length from the boss centre")
    builder.param("shank_w", shank_w, "shank width")
    builder.param("boss_d", boss_d, "boss diameter")
    builder.param("bore_d", bore_d, "boss bore")
    builder.param("curl_in", curl_in, "curl inner radius")
    builder.param("curl_out", curl_out, "curl outer radius")
    builder.param("curl_sweep", sweep, "curl sweep angle")
    builder.param("hook_t", thick, "hook thickness")
    builder.assignment("shank_profile = " + _outline(shank_points) + ";")
    builder.assignment("boss_profile = " + _outline(boss_points) + ";")
    builder.assignment("curl_profile = " + _outline(curl_points) + ";")

    lines = [
        "difference() {",
        "  union() {",
        "    /* three overlapping outlines: shank, boss and the smooth curl */",
        "    linear_extrude(height = hook_t) polygon(shank_profile);",
        "    linear_extrude(height = hook_t) polygon(boss_profile);",
        "    linear_extrude(height = hook_t) polygon(curl_profile);",
        "  }",
        "  translate([0, 0, -2.5]) cylinder(h = hook_t + 5, d = bore_d);",
        "}",
    ]
    builder.section("\n".join(lines))
    code = builder.render()

    all_points = shank_points + boss_points + curl_points
    xs = [x for x, _ in all_points]
    ys = [y for _, y in all_points]
    bbox = (float(round(max(xs) - min(xs), 3)), float(round(max(ys) - min(ys), 3)), float(thick))
    features_ru = [
        f"гладкий зев радиусом {fmt(curl_in)} мм при наружном {fmt(curl_out)} мм",
        f"проушина {fmt(boss_d)} мм с отверстием {fmt(bore_d)} мм",
        f"хвостовик {fmt(shank_len)} мм шириной {fmt(shank_w)} мм",
    ]
    features_en = [
        f"a smooth {fmt(curl_in)} mm mouth inside a {fmt(curl_out)} mm curl",
        f"a {fmt(boss_d)} mm boss with a {fmt(bore_d)} mm bore",
        f"a {fmt(shank_len)} mm shank, {fmt(shank_w)} mm wide",
    ]
    if variant == "eye":
        features_ru.append(f"зев почти замкнут: разрыв {fmt(round(360 - sweep, 1))} градуса")
        features_en.append(f"the curl is almost closed, leaving a {fmt(round(360 - sweep, 1))} degree gap")
    return finish_part3(
        rng,
        family="hooks",
        variant=variant,
        code=code,
        bbox=bbox,
        params={"shank_len": shank_len, "band": band, "thick": thick, "bore_d": bore_d},
        ru_nouns=HOOK_RU,
        en_nouns=HOOK_EN,
        features_ru=features_ru,
        features_en=features_en,
        units=units,
    )


def build_beltrollers(index: int) -> Part:
    """Belt roller: a revolved profile with a crown or guide groove and flanges."""
    rng = Rng("gen3_beltrollers", index)
    variant = rng.choice(("crowned", "crowned", "grooved", "flanged"))
    units = inch_size(rng, max_mm=15.9, min_mm=7.0)
    bore_r = round(units[0] / 2, 2) if units else rng.grid([5.0, 6.0, 7.0, 8.0])
    barrel_r = rng.grid([20.0, 24.0, 28.0, 32.0])
    barrel_h = rng.grid([18.0, 22.0, 26.0, 30.0])
    crown = rng.grid([0.6, 1.0, 1.4])
    flange_r = round(barrel_r + rng.grid([6.0, 8.0, 10.0]), 2)
    flange_t = rng.grid([4.0, 5.0, 6.0])
    groove_depth = rng.grid([3.0, 4.0, 5.0])
    groove_w = rng.grid([5.0, 6.0, 7.0])
    hub_r = round(bore_r + rng.grid([8.0, 10.0, 12.0]), 2)

    profile: list[tuple[float, float]] = []
    if variant == "flanged":
        total_h = round(2 * flange_t + barrel_h, 2)
        profile = [
            (bore_r, 0.0),
            (flange_r, 0.0),
            (flange_r, flange_t),
            (barrel_r, flange_t),
            (round(barrel_r + crown, 3), round(flange_t + barrel_h / 2, 3)),
            (barrel_r, round(flange_t + barrel_h, 3)),
            (flange_r, round(flange_t + barrel_h, 3)),
            (flange_r, total_h),
            (bore_r, total_h),
        ]
    elif variant == "crowned":
        total_h = barrel_h
        profile = [
            (bore_r, 0.0),
            (barrel_r, 0.0),
            (round(barrel_r + crown, 3), round(barrel_h / 2, 3)),
            (barrel_r, barrel_h),
            (bore_r, barrel_h),
        ]
    else:
        total_h = barrel_h
        half = round(barrel_h * 0.5, 2)
        profile = [
            (bore_r, 0.0),
            (barrel_r, 0.0),
            (barrel_r, round(half - groove_w / 2, 2)),
            (round(barrel_r - groove_depth, 2), half),
            (barrel_r, round(half + groove_w / 2, 2)),
            (barrel_r, barrel_h),
            (bore_r, barrel_h),
        ]

    builder = ScadBuilder(
        "Belt roller",
        f"{fmt(2 * barrel_r)} mm barrel, {fmt(total_h)} mm wide, bore {fmt(2 * bore_r)} mm",
    )
    builder.param("bore_d", round(2 * bore_r, 2), "bore")
    builder.param("barrel_d", round(2 * barrel_r, 2), "barrel diameter")
    builder.param("roller_w", total_h, "roller width")
    if variant == "crowned":
        builder.param("crown", crown, "crown height at mid width")
    if variant == "grooved":
        builder.param("groove_w", groove_w, "guide groove width")
        builder.param("groove_d", groove_depth, "guide groove depth")
    if variant == "flanged":
        builder.param("flange_d", round(2 * flange_r, 2), "flange diameter")
        builder.param("flange_t", flange_t, "flange thickness")
        builder.param("hub_d", round(2 * hub_r, 2), "hub diameter")
    builder.assignment("roller_profile = " + _outline(profile) + ";")

    lines = [
        "/* the profile stays clear of the axis, so the bore comes out of the revolve */",
        "rotate_extrude() polygon(roller_profile);",
    ]
    builder.section("\n".join(lines))
    code = builder.render()

    outer_r = flange_r if variant == "flanged" else barrel_r + (crown if variant == "crowned" else 0.0)
    bbox = (float(2 * outer_r), float(2 * outer_r), float(total_h))
    features_ru = [
        f"бочка {fmt(2 * barrel_r)} мм шириной {fmt(total_h)} мм",
        f"посадочное отверстие {fmt(2 * bore_r)} мм по всей длине",
    ]
    features_en = [
        f"a {fmt(2 * barrel_r)} mm barrel, {fmt(total_h)} mm wide",
        f"a {fmt(2 * bore_r)} mm bore right through",
    ]
    if variant == "crowned":
        features_ru.append(f"бочка с бочкообразностью {fmt(crown)} мм по середине")
        features_en.append(f"a {fmt(crown)} mm crown at mid width")
    elif variant == "grooved":
        features_ru.append(f"направляющая канавка {fmt(groove_w)} x {fmt(groove_depth)} мм")
        features_en.append(f"a {fmt(groove_w)} x {fmt(groove_depth)} mm guide groove")
    else:
        features_ru.append(f"реборды {fmt(2 * flange_r)} мм толщиной {fmt(flange_t)} мм")
        features_en.append(f"{fmt(2 * flange_r)} mm flanges, {fmt(flange_t)} mm thick")
    return finish_part3(
        rng,
        family="beltrollers",
        variant=variant,
        code=code,
        bbox=bbox,
        params={"barrel_d": round(2 * barrel_r, 2), "width": total_h, "bore_d": round(2 * bore_r, 2), "wall": round(barrel_r - bore_r, 2)},
        ru_nouns=ROLLER_RU,
        en_nouns=ROLLER_EN,
        features_ru=features_ru,
        features_en=features_en,
        units=units,
    )
