"""gen3: snap-fit latches, living hinges and heat sinks."""

from __future__ import annotations

import math

from tools.dataset_gen2.common import Part, Rng, ScadBuilder, fmt
from tools.dataset_gen2.prompts import en_count, ru_count
from tools.dataset_gen3.prompts3 import finish_part3, inch_size
from tools.dataset_gen3.toolkit import box, cyl, hole_z, num

SNAP_RU = ("защёлка с поднутрением", "защёлка-фиксатор", "клипса-защёлка", "защёлка для крышки")
SNAP_EN = ("snap-fit latch", "snap hook clip", "undercut latch", "snap latch pair")
HINGE_RU = ("живой шарнир", "петля-перемычка", "шарнир с тонкой перемычкой", "гибкая петля")
HINGE_EN = ("living hinge", "thin-web hinge", "flexure hinge strip", "integral hinge plate")
SINK_RU = ("радиатор", "оребрённый радиатор", "теплоотвод", "корпус радиатора")
SINK_EN = ("heat sink", "finned heat sink", "heat sink body", "finned heat spreader")


def build_snapfits(index: int) -> Part:
    """Snap-fit pair: a base with flexible arms, each ending in an undercut hook."""
    rng = Rng("gen3_snapfits", index)
    variant = rng.choice(("pair", "pair", "quad"))
    span = rng.grid([28.0, 32.0, 36.0, 40.0])
    arm_t = rng.grid([2.4, 3.0, 3.6])
    arm_d = rng.grid([8.0, 10.0, 12.0])
    height = rng.grid([18.0, 22.0, 26.0, 30.0])
    head_len = rng.grid([3.0, 3.6, 4.2])
    head_h = rng.grid([4.0, 5.0, 6.0])
    base_h = rng.grid([4.0, 5.0, 6.0])
    base_d = round(span + rng.grid([8.0, 12.0, 16.0]), 2)
    lead = 1.4
    top = base_h + height
    bore_d = rng.grid([4.4, 5.4, 6.6])
    arms = 2 if variant == "pair" else 4

    builder = ScadBuilder(
        "Snap-fit latch",
        f"{arms} arms, {fmt(height)} mm tall, {fmt(head_len)} mm undercut hooks",
    )
    builder.param("base_d", base_d, "base plate depth")
    builder.param("base_h", base_h, "base plate thickness")
    builder.param("span", span, "distance between opposite arms")
    builder.param("arm_t", arm_t, "arm thickness")
    builder.param("arm_d", arm_d, "arm width")
    builder.param("height", height, "free arm length")
    builder.param("head_len", head_len, "hook reach")
    builder.param("head_h", head_h, "hook height")
    builder.param("lead", lead, "lead-in ramp thickness")
    builder.param("bore_d", bore_d, "base fixing bore")
    builder.param("top_z", top, "height of the arm tips above the base")
    builder.assignment("arms = " + str(arms) + ";")

    arm_body = [
        "    /* arm, sunk 0.5 mm into the base */",
        "    translate([-arm_d / 2, span / 2 - arm_t / 2, base_h - 0.5])"
        " cube([arm_d, arm_t, height + 0.5]);",
        "    /* hook: a convex hull of a tall inner block and a thin outer lip",
        "       gives a flat undercut below and a lead-in ramp on top */",
        "    hull() {",
        "      translate([-arm_d / 2, span / 2 + arm_t / 2 - 0.6, top_z - head_h])"
        " cube([arm_d, lead + 0.4, head_h]);",
        "      translate([-arm_d / 2, span / 2 + arm_t / 2 - 0.2, top_z - head_h])"
        " cube([arm_d, head_len, lead]);",
        "    }",
    ]
    lines = [
        "difference() {",
        "  union() {",
        "    /* base plate, centred on the arm ring */",
        "    translate([" + num(-base_d / 2, 3) + ", " + num(-base_d / 2, 3) + ", 0])"
        " cube([base_d, base_d, base_h]);",
        "    for (a = [0 : 360 / arms : 359]) rotate([0, 0, a]) {",
    ]
    lines += arm_body
    lines.append("    }")
    lines.append("  }")
    lines.append("  translate([0, 0, -2.5]) cylinder(h = base_h + 5, d = bore_d);")
    lines.append("}")
    builder.section("\n".join(lines))
    code = builder.render()

    reach = span / 2 + arm_t / 2 - 0.2 + head_len
    half = max(base_d / 2, reach)
    x_span = float(base_d) if arms == 2 else float(2 * half)
    bbox = (x_span, float(2 * half), float(top))
    features_ru = [
        f"{ru_count(arms, 'упругое плечо', 'упругих плеча', 'упругих плеч')} высотой {fmt(height)} мм",
        f"поднутрение {fmt(head_len)} мм с направляющим скосом {fmt(lead)} мм",
        f"плита {fmt(base_d)} мм толщиной {fmt(base_h)} мм",
    ]
    features_en = [
        f"{en_count(arms)} flexible {'arm' if arms == 2 else 'arms'}, {fmt(height)} mm long",
        f"a {fmt(head_len)} mm undercut with a {fmt(lead)} mm lead-in ramp",
        f"a {fmt(base_d)} mm base plate, {fmt(base_h)} mm thick",
    ]
    return finish_part3(
        rng,
        family="snapfits",
        variant=variant,
        code=code,
        bbox=bbox,
        params={
            "span": span,
            "height": top,
            "wall": arm_t,
            "arm_t": arm_t,
            "head_len": head_len,
        },
        ru_nouns=SNAP_RU,
        en_nouns=SNAP_EN,
        features_ru=features_ru,
        features_en=features_en,
    )


def build_livinghinges(index: int) -> Part:
    """Living hinge: two plates joined by a web of controlled thickness."""
    rng = Rng("gen3_livinghinges", index)
    plate_len = rng.grid([16.0, 20.0, 24.0])
    plate_w = rng.grid([30.0, 36.0, 42.0])
    thick = rng.grid([5.0, 6.0, 7.0])
    web_half = rng.grid([3.0, 4.0, 5.0])
    web_t = rng.choice((0.9, 1.0, 1.1, 1.2, 1.4))
    web_z = round((thick - web_t) / 2, 2)
    boss_d = rng.grid([9.0, 10.0, 11.0])
    boss_h = rng.grid([7.0, 8.0, 9.0])
    boss_x = round(plate_len * 0.55, 2)
    screw_d = rng.grid([3.6, 4.4, 5.4])
    screw_y = round(plate_w / 2 - boss_d / 2 - 2.0, 2)
    if screw_y < boss_d * 0.4:
        screw_y = round(boss_d * 0.4, 2)
    total_x = 2 * plate_len + 2 * web_half
    body_x0 = -(plate_len + web_half)

    builder = ScadBuilder(
        "Living hinge",
        f"{fmt(total_x)} x {fmt(plate_w)} mm plates, {fmt(web_t)} mm flexible web",
    )
    builder.param("plate_len", plate_len, "plate length outside the web")
    builder.param("plate_w", plate_w, "plate width")
    builder.param("thick", thick, "plate thickness")
    builder.param("web_half", web_half, "half width of the flex band")
    builder.param("web_t", web_t, "flexible web thickness")
    builder.param("web_z", web_z, "web position inside the thickness")
    builder.param("boss_d", boss_d, "screw boss diameter")
    builder.param("boss_h", boss_h, "screw boss height")
    builder.param("boss_x", boss_x, "screw boss distance from the web")
    builder.param("screw_d", screw_d, "screw hole")

    lines = [
        "difference() {",
        "  union() {",
        "    /* one flat strip, later thinned at the middle */",
        "    translate([" + num(body_x0, 3) + ", " + num(-plate_w / 2, 3) + ", 0]) cube(["
        + num(total_x, 3) + ", " + num(plate_w, 3) + ", " + num(thick, 3) + "]);",
        "    /* screw bosses, sunk 0.5 mm into the plates */",
        "    for (sx = [" + num(-boss_x, 3) + ", " + num(boss_x, 3) + "]) {",
        "      for (sy = [" + num(-screw_y, 3) + ", " + num(screw_y, 3) + "]) {",
        "        translate([sx, sy, 0]) cylinder(h = boss_h, d = boss_d);",
        "      }",
        "    }",
        "  }",
        "  /* channel from below: leaves the web on top of it */",
        "  translate([" + num(-web_half, 3) + ", " + num(-plate_w / 2 - 2.5, 3) + ", -2.5]) cube(["
        + num(2 * web_half, 3) + ", " + num(plate_w + 5, 3) + ", " + num(web_z + 2.5, 3) + "]);",
        "  /* channel from above: thins the web down to web_t */",
        "  translate([" + num(-web_half, 3) + ", " + num(-plate_w / 2 - 2.5, 3) + ", "
        + num(web_z + web_t, 3) + "]) cube([" + num(2 * web_half, 3) + ", " + num(plate_w + 5, 3)
        + ", " + num(thick - web_z - web_t + 2.5, 3) + "]);",
        "  /* screw holes through the bosses */",
        "  for (sx = [" + num(-boss_x, 3) + ", " + num(boss_x, 3) + "]) {",
        "    for (sy = [" + num(-screw_y, 3) + ", " + num(screw_y, 3) + "]) {",
        "      translate([sx, sy, -2.5]) cylinder(h = boss_h + 5, d = screw_d);",
        "    }",
        "  }",
        "}",
    ]
    builder.section("\n".join(lines))
    code = builder.render()

    bbox = (float(total_x), float(plate_w), float(boss_h))
    features_ru = [
        f"гибкая перемычка {fmt(web_t)} мм на участке {fmt(2 * web_half)} мм",
        f"две площадки {fmt(plate_len)} x {fmt(plate_w)} мм толщиной {fmt(thick)} мм",
        f"{ru_count(4, 'бобышка', 'бобышки', 'бобышек')} {fmt(boss_d)} мм под винт {fmt(screw_d)} мм",
    ]
    features_en = [
        f"a {fmt(web_t)} mm flexible web over a {fmt(2 * web_half)} mm band",
        f"two {fmt(plate_len)} x {fmt(plate_w)} mm plates, {fmt(thick)} mm thick",
        f"{en_count(4)} {fmt(boss_d)} mm bosses for {fmt(screw_d)} mm screws",
    ]
    return finish_part3(
        rng,
        family="livinghinges",
        variant="web_" + str(web_t).replace(".", "_"),
        code=code,
        bbox=bbox,
        params={
            "plate_w": plate_w,
            "thick": thick,
            "web_t": float(web_t),
            "wall": float(web_t),
            "length": total_x,
        },
        ru_nouns=HINGE_RU,
        en_nouns=HINGE_EN,
        features_ru=features_ru,
        features_en=features_en,
    )


def build_heatsinks(index: int) -> Part:
    """Finned heat sinks: flat base, straight fins or pin array, fixing holes."""
    rng = Rng("gen3_heatsinks", index)
    variant = rng.choice(("plate", "plate", "pin", "flanged"))
    base_w = rng.grid([40.0, 45.0, 50.0, 56.0, 60.0])
    base_d = rng.grid([40.0, 45.0, 50.0, 56.0])
    base_t = rng.grid([4.0, 5.0, 6.0, 8.0])
    fin_h = rng.grid([18.0, 22.0, 26.0, 30.0, 35.0])
    fin_t = rng.grid([1.6, 2.0, 2.4])
    fin_pitch = round(fin_t + rng.grid([4.0, 5.0, 6.0, 7.0]), 2)
    units = inch_size(rng, max_mm=6.5, min_mm=3.0)
    holes_d = units[0] if units else rng.grid([3.4, 4.4, 5.4])
    hole_inset = round(holes_d / 2 + rng.grid([4.0, 5.0, 6.0]), 2)
    flange_w = round(base_w + rng.grid([14.0, 18.0, 22.0]), 2)
    flange_t = rng.grid([3.0, 4.0])
    hole_x = round((flange_w if variant == "flanged" else base_w) / 2 - hole_inset, 2)
    hole_y = round(base_d / 2 - hole_inset, 2)
    fin_count = max(3, int((base_w - 2 * fin_t) // fin_pitch) + 1)
    span = round((fin_count - 1) * fin_pitch, 2)
    fin_x0 = round((base_w - span) / 2, 2)
    pin_d = rng.grid([4.0, 5.0, 6.0])
    pin_pitch = round(pin_d + rng.grid([4.0, 5.0]), 2)
    pin_nx = max(2, int((base_w - pin_d) // pin_pitch) + 1)
    pin_ny = max(2, int((base_d - pin_d) // pin_pitch) + 1)
    total_h = round(base_t + fin_h, 2)

    builder = ScadBuilder(
        "Finned heat sink",
        f"{fmt(base_w)} x {fmt(base_d)} mm base, {fmt(fin_h)} mm fins",
    )
    builder.param("base_w", base_w, "base width")
    builder.param("base_d", base_d, "base depth")
    builder.param("base_t", base_t, "base thickness")
    builder.param("fin_h", fin_h, "fin height above the base")
    builder.param("holes_d", holes_d, "fixing holes")
    builder.param("hole_x", hole_x, "hole offset in x")
    builder.param("hole_y", hole_y, "hole offset in y")

    lines = ["difference() {", "  union() {", "    cube([base_w, base_d, base_t]);"]
    if variant in ("plate", "flanged"):
        builder.param("fin_t", fin_t, "fin thickness")
        builder.param("fin_pitch", fin_pitch, "fin pitch")
        builder.param("fin_count", float(fin_count), "number of fins")
        builder.param("fin_x0", fin_x0, "first fin offset")
        lines.append("    for (i = [0 : fin_count - 1]) {")
        lines.append("      translate([fin_x0 + i * fin_pitch, 0, base_t - 0.5])"
                     " cube([fin_t, base_d, fin_h + 0.5]);")
        lines.append("    }")
    else:
        builder.param("pin_d", pin_d, "pin diameter")
        builder.param("pin_pitch", pin_pitch, "pin pitch")
        builder.param("pin_nx", float(pin_nx), "pins along x")
        builder.param("pin_ny", float(pin_ny), "pins along y")
        lines.append("    for (ix = [0 : pin_nx - 1]) {")
        lines.append("      for (iy = [0 : pin_ny - 1]) {")
        lines.append("        translate([(base_w - (pin_nx - 1) * pin_pitch) / 2 + ix * pin_pitch,"
                     " (base_d - (pin_ny - 1) * pin_pitch) / 2 + iy * pin_pitch, base_t - 0.5])"
                     " cylinder(h = fin_h + 0.5, d = pin_d);")
        lines.append("      }")
        lines.append("    }")
    if variant == "flanged":
        builder.param("flange_w", flange_w, "flange plate width")
        builder.param("flange_t", flange_t, "flange plate thickness")
        lines.append("    /* mounting flange, a wider plate sharing the base bottom */")
        lines.append("    translate([(base_w - flange_w) / 2, 0, 0])"
                     " cube([flange_w, base_d, flange_t + 0.5]);")
    lines.append("  }")
    lines.append("  /* fixing holes through the base, 2.5 mm clear on both sides */")
    lines.append("  for (hx = [" + num(-hole_x, 3) + ", " + num(hole_x, 3) + "]) {")
    lines.append("    for (hy = [" + num(-hole_y, 3) + ", " + num(hole_y, 3) + "]) {")
    lines.append("      translate([base_w / 2 + hx, base_d / 2 + hy, -2.5])"
                 " cylinder(h = base_t + 5, d = holes_d);")
    lines.append("    }")
    lines.append("  }")
    lines.append("}")
    builder.section("\n".join(lines))
    code = builder.render()

    bbox = (
        float(flange_w if variant == "flanged" else base_w),
        float(base_d),
        float(total_h),
    )
    if variant == "plate":
        features_ru = [
            f"{ru_count(fin_count, 'рёбро', 'ребра', 'рёбер')} толщиной {fmt(fin_t)} мм с шагом {fmt(fin_pitch)} мм",
            f"рёбра высотой {fmt(fin_h)} мм на основании {fmt(base_t)} мм",
        ]
        features_en = [
            f"{en_count(fin_count)} fins, {fmt(fin_t)} mm thick on a {fmt(fin_pitch)} mm pitch",
            f"{fmt(fin_h)} mm fins on a {fmt(base_t)} mm base",
        ]
    elif variant == "pin":
        features_ru = [
            f"{pin_nx} x {pin_ny} штырьков диаметром {fmt(pin_d)} мм с шагом {fmt(pin_pitch)} мм",
            f"штырьки высотой {fmt(fin_h)} мм на плите {fmt(base_t)} мм",
        ]
        features_en = [
            f"a {pin_nx} x {pin_ny} pin array, {fmt(pin_d)} mm pins on a {fmt(pin_pitch)} mm pitch",
            f"{fmt(fin_h)} mm pins on a {fmt(base_t)} mm plate",
        ]
    else:
        features_ru = [
            f"{ru_count(fin_count, 'рёбро', 'ребра', 'рёбер')} высотой {fmt(fin_h)} мм",
            f"фланец {fmt(flange_w)} мм под крепёж",
        ]
        features_en = [
            f"{en_count(fin_count)} fins, {fmt(fin_h)} mm tall",
            f"a {fmt(flange_w)} mm mounting flange",
        ]
    features_ru.append(f"{ru_count(4, 'отверстие', 'отверстия', 'отверстий')} {fmt(holes_d)} мм по углам")
    features_en.append(f"{en_count(4)} {fmt(holes_d)} mm fixing holes in the corners")
    return finish_part3(
        rng,
        family="heatsinks",
        variant=variant,
        code=code,
        bbox=bbox,
        params={
            "base_w": base_w,
            "base_d": base_d,
            "height": total_h,
            "wall": fin_t if variant != "pin" else pin_d,
            "fin_pitch": fin_pitch,
        },
        ru_nouns=SINK_RU,
        en_nouns=SINK_EN,
        features_ru=features_ru,
        features_en=features_en,
        units=units,
    )
