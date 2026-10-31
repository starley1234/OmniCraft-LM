"""Third wave of the voxel canvas: five solid families for the solid3 corpus.

* ``spurblank``   - gear blanks with stub teeth cut as sunk blocks;
* ``enclosurebox``- open enclosures with corner bosses and a cable notch;
* ``ribbracket``  - L brackets with extruded triangular gussets;
* ``hopper``      - square-flange funnels (cones, walls >= 1.5 mm);
* ``saddleclamp`` - shaft saddle clamps, plain or split with a saw kerf.

Every union overlap is >= 1 mm (never face-to-face tangency), every wall is
>= 1.5 mm, every prompt number is a header parameter or a derived scalar, so
the place1 auditor accepts both languages.
"""

from __future__ import annotations

import math

from tools.dataset_gen2.common import Part, Rng, ScadBuilder, fmt
from tools.dataset_solid2.families2v import _finish, _plural, _r2


# ---------------------------------------------------------------------------
# 1. spurblank: gear blank with stub teeth
# ---------------------------------------------------------------------------


def build_spurblank(index: int) -> Part:
    rng = Rng("solid3_spurblank", index)
    variant = rng.choice(("plain", "bored", "lightened"))
    disc_r = rng.grid([22.0, 26.0, 30.0, 34.0, 38.0])
    disc_t = rng.grid([8.0, 10.0, 12.0, 14.0])
    n_teeth = int(rng.choice((10.0, 12.0, 14.0, 16.0, 18.0)))
    tooth_w = rng.grid([4.0, 5.0, 6.0])
    tooth_h = rng.grid([3.0, 4.0, 5.0])
    if 2 * math.pi * disc_r / n_teeth < tooth_w + 1.0:
        raise ValueError("teeth crowd each other")

    builder = ScadBuilder("Spur blank", f"{variant} gear blank")
    params: dict[str, float] = {}
    for name, value, comment in (
        ("disc_r", disc_r, "blank root radius"),
        ("disc_t", disc_t, "blank thickness"),
        ("n_teeth", float(n_teeth), "stub tooth count"),
        ("tooth_w", tooth_w, "tooth width at the root"),
        ("tooth_h", tooth_h, "tooth height above the root"),
    ):
        builder.param(name, value, comment)
        params[name] = value
    out_r = _r2(disc_r + tooth_h)
    params["out_r"] = out_r
    # exact extents over the rotated tooth corners (teeth start at 0 deg)
    maxx = maxy = 0.0
    for i in range(n_teeth):
        theta = math.radians(i * 360.0 / n_teeth)
        for rx in (out_r, disc_r - 1.0):
            for ry in (tooth_w / 2, -tooth_w / 2):
                maxx = max(maxx, abs(rx * math.cos(theta) - ry * math.sin(theta)))
                maxy = max(maxy, abs(rx * math.sin(theta) + ry * math.cos(theta)))
    bbox_x = _r2(2 * maxx)
    bbox_y = _r2(2 * maxy)
    builder.assignment("out_r = disc_r + tooth_h;  // tip radius")
    builder.assignment(f"bbox_x = {bbox_x};  // measured width over the teeth")
    builder.assignment(f"bbox_y = {bbox_y};  // measured depth over the teeth")

    body = [
        "union() {",
        "  cylinder(r = disc_r, h = disc_t);",
        "  for (i = [0 : n_teeth - 1])",
        "    rotate([0, 0, i * 360 / n_teeth])",
        "      translate([disc_r - 1, -tooth_w / 2, 0])",
        "        cube([tooth_h + 1, tooth_w, disc_t]);",
        "}",
    ]
    bore_r = 0.0
    if variant != "plain":
        bore_r = rng.grid([5.0, 6.0, 8.0])
        builder.param("bore_r", bore_r, "central bore radius")
        params["bore_r"] = bore_r
    holes: list[str] = []
    if variant == "bored":
        holes.append("  translate([0, 0, -1]) cylinder(r = bore_r, h = disc_t + 2);")
    elif variant == "lightened":
        ring_r = rng.grid([12.0, 14.0, 16.0])
        pocket_r = rng.grid([3.5, 4.0, 5.0])
        if ring_r + pocket_r > disc_r - 2.5 or ring_r - pocket_r < 6.0 + 1.5:
            raise ValueError("pocket ring does not fit the blank")
        builder.param("ring_r", ring_r, "lightening pocket ring radius")
        builder.param("pocket_r", pocket_r, "lightening pocket radius")
        params["ring_r"] = ring_r
        params["pocket_r"] = pocket_r
        holes.append("  translate([0, 0, -1]) cylinder(r = bore_r, h = disc_t + 2);")
        holes.append(
            "  for (i = [0 : 5])\n"
            "    rotate([0, 0, i * 72])\n"
            "      translate([ring_r, 0, disc_t - 4])\n"
            "        cylinder(r = pocket_r, h = 5);"
        )
    if holes:
        builder.section("difference() {\n" + "\n".join(body) + "\n" + "\n".join(holes) + "\n}")
    else:
        builder.section("\n".join(body))

    feats_ru = [
        f"{n_teeth} {_plural(n_teeth, 'зуб', 'зуба', 'зубов')} высотой {fmt(tooth_h)} мм и шириной {fmt(tooth_w)} мм",
        f"диск радиусом {fmt(disc_r)} мм толщиной {fmt(disc_t)} мм",
    ]
    feats_en = [
        f"{n_teeth} stub teeth, {fmt(tooth_h)} mm tall and {fmt(tooth_w)} mm wide",
        f"disc {fmt(disc_r)} mm radius, {fmt(disc_t)} mm thick",
    ]
    if variant == "bored":
        feats_ru.append(f"центральное отверстие радиусом {fmt(bore_r)} мм")
        feats_en.append(f"central bore, {fmt(bore_r)} mm radius")
    elif variant == "lightened":
        feats_ru.append(
            f"пять карманов радиусом {fmt(pocket_r)} мм на кольце {fmt(ring_r)} мм глубиной 4 мм"
        )
        feats_en.append(
            f"five {fmt(pocket_r)} mm pockets on a {fmt(ring_r)} mm ring, 4 mm deep"
        )
    bbox = (bbox_x, bbox_y, disc_t)
    return _finish(rng, "spurblank", variant, builder, bbox, params,
                   "заготовку зубчатого колеса", "a spur gear blank",
                   feats_ru, feats_en)


# ---------------------------------------------------------------------------
# 2. enclosurebox: open enclosure with bosses and a cable notch
# ---------------------------------------------------------------------------


def build_enclosurebox(index: int) -> Part:
    rng = Rng("solid3_enclosurebox", index)
    variant = rng.choice(("bosses", "notch", "both"))
    box_l = rng.grid([70.0, 80.0, 90.0, 100.0])
    box_w = rng.grid([50.0, 60.0, 70.0])
    box_h = rng.grid([40.0, 50.0, 60.0])
    wall_t = rng.grid([2.0, 2.5, 3.0])
    boss_r = rng.grid([4.0, 5.0])
    hole_r = rng.grid([1.5, 2.0])
    boss_in = rng.grid([10.0, 12.0])

    builder = ScadBuilder("Enclosure box", f"{variant} enclosure")
    params: dict[str, float] = {}
    for name, value, comment in (
        ("box_l", box_l, "outer length, X"),
        ("box_w", box_w, "outer width, Y"),
        ("box_h", box_h, "outer height"),
        ("wall_t", wall_t, "wall thickness"),
    ):
        builder.param(name, value, comment)
        params[name] = value
    builder.assignment("inner_h = box_h - wall_t;  // cavity depth")
    builder.assignment("boss_h = inner_h - 2;  // corner boss height")
    params["boss_h"] = _r2(box_h - wall_t - 2)

    shell = [
        "difference() {",
        "  union() {",
        "    difference() {",
        "      cube([box_l, box_w, box_h]);",
        "      translate([wall_t, wall_t, wall_t])",
        "        cube([box_l - 2 * wall_t, box_w - 2 * wall_t, box_h]);",
        "    }",
    ]
    feats_ru = [f"корпус {fmt(box_l)} x {fmt(box_w)} x {fmt(box_h)} мм со стенкой {fmt(wall_t)} мм"]
    feats_en = [f"enclosure {fmt(box_l)} x {fmt(box_w)} x {fmt(box_h)} mm, walls {fmt(wall_t)} mm"]

    if variant in ("bosses", "both"):
        for name, value, comment in (
            ("boss_r", boss_r, "corner boss radius"),
            ("hole_r", hole_r, "boss screw hole radius"),
            ("boss_in", boss_in, "boss inset from the corners"),
        ):
            builder.param(name, value, comment)
            params[name] = value
        if boss_in + boss_r > box_l / 2 - 1 or boss_r - hole_r < 1.5:
            raise ValueError("boss geometry too tight")
        shell.append(
            "    for (sx = [0, 1], sy = [0, 1])\n"
            "      translate([sx ? box_l - boss_in : boss_in,\n"
            "                 sy ? box_w - boss_in : boss_in, wall_t - 1])\n"
            "        difference() {\n"
            "          cylinder(r = boss_r, h = boss_h);\n"
            "          translate([0, 0, boss_h - 4])\n"
            "            cylinder(r = hole_r, h = 5);\n"
            "        }"
        )
        feats_ru.append(
            f"четыре бобышки радиусом {fmt(boss_r)} мм с отверстиями радиусом {fmt(hole_r)} мм"
        )
        feats_en.append(
            f"four bosses, {fmt(boss_r)} mm radius, holes {fmt(hole_r)} mm radius"
        )
    shell.append("  }")
    if variant in ("notch", "both"):
        notch_w = rng.grid([8.0, 10.0, 12.0])
        notch_h = rng.grid([10.0, 12.0, 15.0])
        if notch_h > box_h - wall_t - 6 or notch_w > box_w - 2 * wall_t - 8:
            raise ValueError("cable notch too big")
        builder.param("notch_w", notch_w, "cable notch width")
        builder.param("notch_h", notch_h, "cable notch height")
        params["notch_w"] = notch_w
        params["notch_h"] = notch_h
        shell.append(
            "  translate([box_l / 2 - notch_w / 2, -1, box_h - notch_h])\n"
            "    cube([notch_w, wall_t + 2, notch_h + 1]);"
        )
        feats_ru.append(
            f"кабельный вырез {fmt(notch_w)} x {fmt(notch_h)} мм в передней стенке"
        )
        feats_en.append(
            f"cable notch {fmt(notch_w)} x {fmt(notch_h)} mm in the front wall"
        )
    shell.append("}")
    builder.section("\n".join(shell))
    bbox = (box_l, box_w, box_h)
    return _finish(rng, "enclosurebox", variant, builder, bbox, params,
                   "открытый корпус", "an open enclosure box",
                   feats_ru, feats_en)


# ---------------------------------------------------------------------------
# 3. ribbracket: L bracket with triangular gussets
# ---------------------------------------------------------------------------


def build_ribbracket(index: int) -> Part:
    rng = Rng("solid3_ribbracket", index)
    n_gus = int(rng.choice((2.0, 3.0)))
    variant = f"gusset{n_gus}"
    base_l = rng.grid([60.0, 70.0, 80.0])
    base_w = rng.grid([40.0, 50.0, 60.0])
    base_t = rng.grid([6.0, 8.0, 10.0])
    plate_t = rng.grid([6.0, 8.0])
    plate_h = rng.grid([50.0, 60.0, 70.0, 80.0])
    gus_l = rng.grid([16.0, 20.0, 24.0])
    gus_h = rng.grid([16.0, 20.0, 24.0])
    gus_t = rng.grid([4.0, 5.0, 6.0])
    gus_edge = rng.grid([4.0, 5.0, 6.0])
    if plate_h < base_t + gus_h + 2:
        raise ValueError("gusset taller than the plate")
    span = base_w - 2 * gus_edge - gus_t
    if n_gus > 1:
        gus_pitch = span / (n_gus - 1)
    else:
        gus_pitch = 0.0
    if n_gus > 1 and gus_pitch < gus_t + 4:
        raise ValueError("gussets crowd each other")

    builder = ScadBuilder("Rib bracket", f"{n_gus}-gusset L bracket")
    params: dict[str, float] = {}
    for name, value, comment in (
        ("base_l", base_l, "foot length, X"),
        ("base_w", base_w, "foot width, Y"),
        ("base_t", base_t, "foot thickness"),
        ("plate_t", plate_t, "upright plate thickness"),
        ("plate_h", plate_h, "overall height"),
        ("gus_l", gus_l, "gusset leg along the foot"),
        ("gus_h", gus_h, "gusset height"),
        ("gus_t", gus_t, "gusset thickness"),
        ("gus_edge", gus_edge, "gusset margin from the foot edge"),
        ("n_gus", float(n_gus), "gusset count"),
    ):
        builder.param(name, value, comment)
        params[name] = value
    if n_gus > 1:
        builder.assignment("gus_pitch = (base_w - 2 * gus_edge - gus_t) / (n_gus - 1);  // gusset pitch")
        params["gus_pitch"] = _r2(gus_pitch)
        gus_y_expr = "gus_edge + i * gus_pitch"
    else:
        builder.assignment("gus_y = (base_w - gus_t) / 2;  // centred gusset offset")
        params["gus_y"] = _r2(span / 2 + gus_edge)
        gus_y_expr = "gus_y + i * 0"

    body = [
        "union() {",
        "  cube([base_l, base_w, base_t]);",
        "  translate([base_l - plate_t, 0, base_t - 1])",
        "    cube([plate_t, base_w, plate_h - base_t + 1]);",
        "  for (i = [0 : n_gus - 1])",
        "    translate([base_l - plate_t - gus_l, " + gus_y_expr + ", base_t - 1])",
        "      rotate([-90, 0, 0])",
        "        linear_extrude(height = gus_t)",
        "          polygon(points = [[0, 0], [gus_l + 1, 0], [0, -gus_h]]);",
        "}",
    ]
    builder.section("\n".join(body))
    feats_ru = [
        f"угольник: основание {fmt(base_l)} x {fmt(base_w)} мм толщиной {fmt(base_t)} мм",
        f"стойка толщиной {fmt(plate_t)} мм, высота {fmt(plate_h)} мм",
        f"{n_gus} {_plural(n_gus, 'косынка', 'косынки', 'косынок')} {fmt(gus_l)} x {fmt(gus_h)} мм толщиной {fmt(gus_t)} мм",
    ]
    feats_en = [
        f"L bracket: foot {fmt(base_l)} x {fmt(base_w)} mm, {fmt(base_t)} mm thick",
        f"upright {fmt(plate_t)} mm thick, {fmt(plate_h)} mm overall height",
        f"{n_gus} gussets {fmt(gus_l)} x {fmt(gus_h)} mm, {fmt(gus_t)} mm thick",
    ]
    bbox = (base_l, base_w, plate_h)
    return _finish(rng, "ribbracket", variant, builder, bbox, params,
                   "уголок с косынками", "a gusseted L bracket",
                   feats_ru, feats_en)


# ---------------------------------------------------------------------------
# 4. hopper: square-flange funnel
# ---------------------------------------------------------------------------


def build_hopper(index: int) -> Part:
    rng = Rng("solid3_hopper", index)
    variant = rng.choice(("funnel", "flanged"))
    fl = rng.grid([80.0, 90.0, 100.0, 110.0])
    fl_t = rng.grid([6.0, 8.0, 10.0])
    cone_h = rng.grid([40.0, 50.0, 60.0])
    top_d = rng.grid([50.0, 60.0, 70.0])
    bot_d = rng.grid([20.0, 24.0, 28.0])
    wall = rng.grid([2.0, 2.5, 3.0])
    hole_r = rng.grid([2.5, 3.0])
    hole_in = rng.grid([8.0, 10.0])
    bore_d = _r2(bot_d - 2 * wall)
    if bore_d < 6.0:
        raise ValueError("spout wall too thick")
    if top_d > fl - 4 or bot_d / 2 + hole_in + hole_r > fl / 2 - 1:
        raise ValueError("flange layout too tight")

    builder = ScadBuilder("Hopper", f"{variant} with square flange")
    params: dict[str, float] = {}
    for name, value, comment in (
        ("fl", fl, "flange side, X and Y"),
        ("fl_t", fl_t, "flange thickness"),
        ("cone_h", cone_h, "cone height above the flange"),
        ("top_d", top_d, "cone mouth diameter"),
        ("bot_d", bot_d, "cone spout diameter"),
        ("wall", wall, "cone wall thickness"),
    ):
        builder.param(name, value, comment)
        params[name] = value
    builder.assignment("bore_d = bot_d - 2 * wall;  // spout bore diameter")
    builder.assignment("total_h = fl_t + cone_h - 1;  // overall height")
    params["bore_d"] = bore_d

    body = [
        "difference() {",
        "  union() {",
        "    cube([fl, fl, fl_t]);",
        "    translate([fl / 2, fl / 2, fl_t - 1])",
        "      cylinder(h = cone_h, d1 = bot_d, d2 = top_d);",
        "  }",
        "  translate([fl / 2, fl / 2, fl_t - 2])",
        "    cylinder(h = cone_h + 1, d1 = bore_d, d2 = top_d - 2 * wall);",
    ]
    if variant == "flanged":
        builder.param("hole_r", hole_r, "flange hole radius")
        builder.param("hole_in", hole_in, "hole inset from the corners")
        params["hole_r"] = hole_r
        params["hole_in"] = hole_in
        body.append(
            "  for (sx = [0, 1], sy = [0, 1])\n"
            "    translate([sx ? fl - hole_in : hole_in,\n"
            "               sy ? fl - hole_in : hole_in, -1])\n"
            "      cylinder(r = hole_r, h = fl_t + 2);"
        )
    body.append("}")
    builder.section("\n".join(body))
    feats_ru = [
        f"воронка: конус высотой {fmt(cone_h)} мм, горловина {fmt(top_d)} мм, выход {fmt(bot_d)} мм",
        f"фланец {fmt(fl)} x {fmt(fl)} мм толщиной {fmt(fl_t)} мм, стенка конуса {fmt(wall)} мм",
    ]
    feats_en = [
        f"funnel cone {fmt(cone_h)} mm tall, mouth {fmt(top_d)} mm, spout {fmt(bot_d)} mm",
        f"flange {fmt(fl)} x {fmt(fl)} mm, {fmt(fl_t)} mm thick, cone wall {fmt(wall)} mm",
    ]
    if variant == "flanged":
        feats_ru.append(
            f"четыре монтажных отверстия радиусом {fmt(hole_r)} мм с отступом {fmt(hole_in)} мм"
        )
        feats_en.append(
            f"four mounting holes, {fmt(hole_r)} mm radius, {fmt(hole_in)} mm inset"
        )
    bbox = (fl, fl, _r2(fl_t + cone_h - 1))
    return _finish(rng, "hopper", variant, builder, bbox, params,
                   "воронку с фланцем", "a flanged hopper funnel",
                   feats_ru, feats_en)


# ---------------------------------------------------------------------------
# 5. saddleclamp: shaft saddle clamp
# ---------------------------------------------------------------------------


def build_saddleclamp(index: int) -> Part:
    rng = Rng("solid3_saddleclamp", index)
    split = rng.chance(0.5)
    variant = "split" if split else "plain"
    blk_l = rng.grid([50.0, 60.0, 70.0])
    blk_w = rng.grid([30.0, 36.0, 40.0])
    blk_h = rng.grid([30.0, 36.0, 40.0])
    clamp_r = rng.grid([10.0, 12.0, 14.0])
    hole_r = rng.grid([2.5, 3.0])
    hole_m = rng.grid([8.0, 10.0])
    if blk_h < clamp_r + 4:
        raise ValueError("groove breaks the foot")
    if hole_m + hole_r > blk_l / 2 - clamp_r - 1:
        raise ValueError("bolt holes crowd the groove")

    builder = ScadBuilder("Saddle clamp", f"{variant} shaft clamp")
    params: dict[str, float] = {}
    for name, value, comment in (
        ("blk_l", blk_l, "block length, X"),
        ("blk_w", blk_w, "block width, Y"),
        ("blk_h", blk_h, "block height"),
        ("clamp_r", clamp_r, "shaft groove radius"),
        ("hole_r", hole_r, "bolt hole radius"),
        ("hole_m", hole_m, "bolt hole margin from the ends"),
    ):
        builder.param(name, value, comment)
        params[name] = value
    builder.assignment("saw_depth = clamp_r + 3;  // saw kerf depth")
    params["saw_depth"] = _r2(clamp_r + 3)

    body = [
        "difference() {",
        "  cube([blk_l, blk_w, blk_h]);",
        "  translate([blk_l / 2, -1, blk_h])",
        "    rotate([-90, 0, 0])",
        "      cylinder(h = blk_w + 2, r = clamp_r);",
        "  for (sx = [0, 1])",
        "    translate([sx ? blk_l - hole_m : hole_m, blk_w / 2, -1])",
        "      cylinder(r = hole_r, h = blk_h + 2);",
    ]
    feats_ru = [
        f"седловой зажим {fmt(blk_l)} x {fmt(blk_w)} x {fmt(blk_h)} мм",
        f"полукруглый паз радиусом {fmt(clamp_r)} мм под вал",
        f"два болтовых отверстия радиусом {fmt(hole_r)} мм с отступом {fmt(hole_m)} мм",
    ]
    feats_en = [
        f"saddle clamp {fmt(blk_l)} x {fmt(blk_w)} x {fmt(blk_h)} mm",
        f"semicircular shaft groove, {fmt(clamp_r)} mm radius",
        f"two bolt holes, {fmt(hole_r)} mm radius, {fmt(hole_m)} mm from the ends",
    ]
    if split:
        saw_w = rng.grid([1.5, 2.0])
        builder.param("saw_w", saw_w, "saw kerf width")
        params["saw_w"] = saw_w
        body.append(
            "  translate([blk_l / 2 - saw_w / 2, -1, blk_h - saw_depth])\n"
            "    cube([saw_w, blk_w + 2, saw_depth + 1]);"
        )
        feats_ru.append(f"пропил шириной {fmt(saw_w)} мм глубиной {fmt(clamp_r + 3)} мм")
        feats_en.append(f"saw kerf {fmt(saw_w)} mm wide, {fmt(clamp_r + 3)} mm deep")
    body.append("}")
    builder.section("\n".join(body))
    bbox = (blk_l, blk_w, blk_h)
    return _finish(rng, "saddleclamp", variant, builder, bbox, params,
                   "седловой зажим вала", "a shaft saddle clamp",
                   feats_ru, feats_en)


FAMILY_BUILDERS = {
    "spurblank": build_spurblank,
    "enclosurebox": build_enclosurebox,
    "ribbracket": build_ribbracket,
    "hopper": build_hopper,
    "saddleclamp": build_saddleclamp,
}
