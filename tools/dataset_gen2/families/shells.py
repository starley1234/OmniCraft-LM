"""Shell families: enclosures with lids and display bezels.

Both families are built as *sketches* first (closed outlines, loops for the
screw patterns) and grown into solids, so they also teach wall thickness and
inside/outside bookkeeping.
"""

from __future__ import annotations

import math

from tools.dataset_gen2.common import Part, Rng, ScadBuilder, finish_part, fmt
from tools.dataset_gen2.prompts import en_count, ru_count

BOX_RU = (
    "корпус прибора", "монтажный корпус", "коробка с крышкой", "корпус с бобышками",
    "распределительный корпус", "корпус электроники",
)
BOX_EN = (
    "enclosure body", "electronics housing", "project box", "mounting case",
    "instrument enclosure", "junction box",
)
LID_RU = (
    "крышка корпуса", "плоская крышка", "крышка с буртиком", "накладная крышка",
    "крышка с ответными отверстиями", "панель крышки",
)
LID_EN = (
    "enclosure lid", "cover plate", "lipped lid", "bolt-on lid",
    "housing cover", "top panel",
)
BEZEL_RU = (
    "рамка дисплея", "фасадная рамка", "обрамление панели", "рамка-облицовка",
    "держатель стекла дисплея", "накладная рамка",
)
BEZEL_EN = (
    "display bezel", "front frame", "panel surround", "screen frame",
    "trim frame", "fascia plate",
)


# ---------------------------------------------------------------------------
# enclosure bodies
# ---------------------------------------------------------------------------


def build_enclosures(index: int) -> Part:
    rng = Rng("enclosures", index)
    length = rng.grid([60.0, 80.0, 100.0, 120.0, 140.0, 160.0])
    width = rng.grid([40.0, 50.0, 60.0, 80.0, 100.0])
    height = rng.grid([25.0, 30.0, 40.0, 50.0, 60.0, 80.0])
    wall = rng.grid([2.0, 2.5, 3.0, 4.0])
    floor_t = rng.grid([2.5, 3.0, 4.0, 5.0])
    boss_d = rng.grid([8.0, 10.0, 12.0])
    boss_hole_d = rng.grid([3.4, 4.5])
    boss_h = round(height - floor_t - 2.0, 2)
    # the boss is sunk 1 mm into both side walls, so it never pokes outside
    boss_lip = round(wall + boss_d / 2 - 1.0, 2)
    vents = rng.chance(0.6)
    vent_slots = rng.choice([5, 6, 8, 10]) if vents else 0
    vent_w = min(rng.grid([3.0, 4.0, 5.0]), width * 0.06) if vents else 0.0
    vent_h = rng.grid([12.0, 16.0, 20.0, 25.0]) if vents else 0.0
    vent_pitch = round(width / (vent_slots + 1), 2) if vents else 0.0
    nipple = rng.chance(0.5)
    nipple_d = rng.grid([12.0, 16.0, 20.0]) if nipple else 0.0
    nipple_h = rng.grid([8.0, 10.0, 14.0]) if nipple else 0.0
    nipple_bore = rng.grid([5.0, 6.5, 8.0]) if nipple else 0.0
    ears = rng.chance(0.45)
    ear_w = 14.0 if ears else 0.0
    ear_t = round(max(wall, 3.0), 2) if ears else 0.0
    ear_ext = 8.0 if ears else 0.0
    ear_hole_d = rng.grid([3.4, 4.5, 5.5]) if ears else 0.0

    builder = ScadBuilder(
        "Enclosure body", f"{fmt(length)} x {fmt(width)} x {fmt(height)} mm, wall {fmt(wall)} mm"
    )
    builder.param("length", length, "outside length, X")
    builder.param("width", width, "outside width, Y")
    builder.param("height", height, "outside height, Z")
    builder.param("wall", wall, "side wall thickness")
    builder.param("floor_t", floor_t, "floor thickness")
    builder.param("boss_d", boss_d, "corner boss diameter")
    builder.param("boss_h", boss_h, "corner boss height above the floor")
    builder.param("boss_hole_d", boss_hole_d, "lid screw clearance in the boss")
    builder.param("boss_lip", boss_lip, "boss centre inset from the corner")
    if ears:
        builder.param("ear_w", ear_w, "mounting ear width")
        builder.param("ear_t", ear_t, "mounting ear thickness")
        builder.param("ear_ext", ear_ext, "mounting ear reach")
        builder.param("ear_hole_d", ear_hole_d, "mounting ear drills")
    if vents:
        builder.param("vent_slots", float(vent_slots), "vent slots in the long wall")
        builder.param("vent_w", vent_w, "vent slot width")
        builder.param("vent_h", vent_h, "vent slot height")
        builder.param("vent_pitch", vent_pitch, "vent slot pitch")
        builder.param("vent_z", round(height * 0.5, 2), "vent slot sill height")
    if nipple:
        builder.param("nipple_d", nipple_d, "cable gland boss diameter")
        builder.param("nipple_h", nipple_h, "cable gland boss height")
        builder.param("nipple_bore", nipple_bore, "cable gland bore")

    lines = [
        "module shell() {",
        "  difference() {",
        "    cube([length, width, height]);",
        "    /* hollow, open at the top */",
        "    translate([wall, wall, floor_t])",
        "      cube([length - 2 * wall, width - 2 * wall, height]);",
        "  }",
        "}",
        "",
        "module bosses() {",
        "  /* corner bosses, sunk 1 mm into the floor */",
        "  for (sx = [0, 1]) for (sy = [0, 1])",
        "    translate([sx * (length - 2 * boss_lip) + boss_lip, sy * (width - 2 * boss_lip) + boss_lip,"
        " floor_t - 1])",
        "      cylinder(h = boss_h + 1, d = boss_d);",
        "}",
    ]
    if nipple:
        lines += [
            "",
            "module gland() {",
            "  /* boss on the short wall, sunk 1 mm into it */",
            "  translate([length - 1, width / 2, height * 0.5]) rotate([0, 90, 0])",
            "    cylinder(h = nipple_h + 1, d = nipple_d);",
            "}",
        ]
    if ears:
        lines += [
            "",
            "module ears() {",
            "  /* mounting ears on the short walls, sunk into the wall */",
            "  for (sz = [0, 1])",
            "    translate([-ear_ext, width / 2 - ear_w / 2, sz * (height - ear_t)])",
            "      cube([ear_ext + 2.5, ear_w, ear_t]);",
            "}",
        ]
    lines += ["", "difference() {", "  union() {", "    shell();", "    bosses();"]
    if nipple:
        lines.append("    gland();")
    if ears:
        lines.append("    ears();")
    lines.append("  }")
    lines.append("  /* boss screw holes */")
    lines.append("  for (sx = [0, 1]) for (sy = [0, 1])")
    lines.append(
        "    translate([sx * (length - 2 * boss_lip) + boss_lip, sy * (width - 2 * boss_lip) + boss_lip, -1])"
        " cylinder(h = floor_t + boss_h + 2, d = boss_hole_d);"
    )
    if vents:
        lines.append("  /* vent grille in the +Y wall */")
        lines.append(
            "  for (i = [0 : vent_slots - 1])"
            " translate([vent_pitch * (i + 1) - vent_w / 2, width - wall - 1, vent_z])"
            " cube([vent_w, wall + 2, vent_h]);"
        )
    if nipple:
        lines.append(
            "  translate([length, width / 2, height * 0.5]) rotate([0, 90, 0])"
            " translate([0, 0, -nipple_h - 2]) cylinder(h = nipple_h + wall + 4, d = nipple_bore);"
        )
    if ears:
        lines.append(
            "  for (sz = [0, 1]) for (sx = [0, 1])"
            " translate([-ear_ext - 1, width / 2 + (2 * sx - 1) * (ear_w / 2 - 3),"
            " sz * (height - ear_t) + ear_t / 2])"
            " rotate([0, 90, 0]) cylinder(h = ear_ext + 2, d = ear_hole_d);"
        )
    lines.append("}")
    builder.section("\n".join(lines))
    code = builder.render()

    extra_x = (nipple_h if nipple else 0.0) + (ear_ext if ears else 0.0)
    bbox = (round(length + extra_x, 2), round(width, 2), round(height, 2))
    features_ru = [
        f"стенка {fmt(wall)} мм и дно {fmt(floor_t)} мм",
        f"{ru_count(4, 'бобышка', 'бобышки', 'бобышек')} {fmt(boss_d)} мм под винты {fmt(boss_hole_d)} мм",
    ]
    features_en = [
        f"{fmt(wall)} mm walls and a {fmt(floor_t)} mm floor",
        f"{en_count(4)} corner bosses of {fmt(boss_d)} mm for {fmt(boss_hole_d)} mm screws",
    ]
    if vents:
        features_ru.append(f"вентиляционная решетка: {vent_slots} прорезей {fmt(vent_w)}x{fmt(vent_h)} мм")
        features_en.append(f"a vent grille of {vent_slots} slots {fmt(vent_w)}x{fmt(vent_h)} mm")
    if nipple:
        features_ru.append(f"кабельный ввод {fmt(nipple_d)} мм с отверстием {fmt(nipple_bore)} мм")
        features_en.append(f"a {fmt(nipple_d)} mm cable gland with a {fmt(nipple_bore)} mm bore")
    if ears:
        features_ru.append(f"монтажные ушки с отверстиями {fmt(ear_hole_d)} мм")
        features_en.append(f"mounting ears drilled {fmt(ear_hole_d)} mm")
    return finish_part(
        rng,
        family="enclosures",
        variant=("vent" if vents else "plain") + ("_gland" if nipple else "") + ("_ears" if ears else ""),
        code=code,
        bbox=bbox,
        params={
            "length": bbox[0],
            "width": width,
            "height": height,
            "wall": wall,
            "floor_t": floor_t,
            "boss_hole_d": boss_hole_d,
        },
        ru_nouns=BOX_RU,
        en_nouns=BOX_EN,
        features_ru=features_ru,
        features_en=features_en,
    )


# ---------------------------------------------------------------------------
# enclosure lids
# ---------------------------------------------------------------------------


def build_enclosure_lids(index: int) -> Part:
    rng = Rng("enclosure_lids", index)
    length = rng.grid([60.0, 80.0, 100.0, 120.0, 140.0, 160.0])
    width = rng.grid([40.0, 50.0, 60.0, 80.0, 100.0])
    plate_t = rng.grid([5.0, 6.0, 7.0, 8.0])
    lip = rng.chance(0.75)
    lip_h = rng.grid([3.0, 4.0, 5.0]) if lip else 0.0
    lip_wall = rng.grid([2.0, 2.5, 3.0]) if lip else 0.0
    bolt_d = rng.grid([3.4, 4.5, 5.5])
    boss_lip = rng.grid([3.0, 4.0, 5.0])
    countersink = rng.chance(0.5)
    cs_d = round(bolt_d + 3.4, 2) if countersink else 0.0
    ribs = rng.chance(0.4)
    rib_n = rng.choice([2, 3, 4]) if ribs else 0
    rib_t = rng.grid([2.0, 2.5, 3.0]) if ribs else 0.0
    rib_h = rng.grid([4.0, 6.0, 8.0]) if ribs else 0.0
    label = rng.chance(0.4)
    label_h = 1.2 if label else 0.0
    sink = 1.0

    builder = ScadBuilder(
        "Enclosure lid", f"{fmt(length)} x {fmt(width)} x {fmt(plate_t)} mm, 4 bolt holes"
    )
    builder.param("length", length, "lid length, X")
    builder.param("width", width, "lid width, Y")
    builder.param("plate_t", plate_t, "lid plate thickness")
    builder.param("bolt_d", bolt_d, "bolt clearance")
    builder.param("boss_lip", boss_lip, "bolt hole inset from the corner")
    builder.param("sink", sink, "overlap of the lip and ribs into the plate")
    if lip:
        builder.param("lip_h", lip_h, "lip height below the plate")
        builder.param("lip_wall", lip_wall, "lip wall thickness")
    if countersink:
        builder.param("cs_d", cs_d, "countersink diameter")
        builder.param("cs_h", round(cs_d * 0.25, 2), "countersink depth")
    if ribs:
        builder.param("rib_n", float(rib_n), "stiffening ribs")
        builder.param("rib_t", rib_t, "rib thickness")
        builder.param("rib_h", rib_h, "rib height below the plate")
    if label:
        builder.param("label_h", label_h, "raised marking pad")

    lines = ["module plate() {", "  cube([length, width, plate_t]);"]
    if lip:
        lines.append(
            "  /* lip that drops into the housing opening, sunk into the plate */\n"
            "  translate([lip_wall, lip_wall, -lip_h + sink])"
            " cube([length - 2 * lip_wall, width - 2 * lip_wall, lip_h]);"
        )
    if ribs:
        lip_wall_term = "lip_wall" if lip else "0"
        lines.append("  /* stiffening ribs under the plate */")
        lines.append(
            "  for (i = [1 : rib_n])"
            " translate([length * i / (rib_n + 1) - rib_t / 2, " + lip_wall_term + ", -rib_h + sink])"
            " cube([rib_t, width - 2 * " + lip_wall_term + ", rib_h]);"
        )
    if label:
        lines.append(
            "  /* raised marking pad on top, sunk 1 mm into the plate */\n"
            "  translate([length * 0.08, width * 0.28, plate_t - 1])"
            " cube([length * 0.4, width * 0.44, label_h + 1]);"
        )
    lines.append("}")
    lines += ["", "difference() {", "  plate();"]
    lip_term = "lip_h" if lip else "0"
    lines.append(
        "  /* bolt pattern matching the corner bosses */\n"
        "  for (sx = [0, 1]) for (sy = [0, 1])\n"
        "    translate([sx * (length - 2 * boss_lip) + boss_lip, sy * (width - 2 * boss_lip) + boss_lip, -"
        + lip_term + " - 1])\n"
        "      cylinder(h = plate_t + " + lip_term + " + 2, d = bolt_d);"
    )
    if countersink:
        lines.append(
            "  /* countersinks so the heads sit flush */\n"
            "  for (sx = [0, 1]) for (sy = [0, 1])\n"
            "    translate([sx * (length - 2 * boss_lip) + boss_lip, sy * (width - 2 * boss_lip) + boss_lip,"
            " plate_t - cs_h])\n"
            "      cylinder(h = cs_h + 0.5, d = cs_d);"
        )
    lines.append("}")
    builder.section("\n".join(lines))
    code = builder.render()

    height = round(plate_t + (label_h if label else 0.0), 2)
    depth = 0.0
    if lip:
        depth = max(depth, round(lip_h - sink, 2))
    if ribs:
        depth = max(depth, round(rib_h - sink, 2))
    bbox = (float(length), float(width), round(height + depth, 2))
    features_ru = [
        f"плита {fmt(plate_t)} мм с четырьмя отверстиями {fmt(bolt_d)} мм",
        f"шаг отверстий {fmt(length - 2 * boss_lip)}x{fmt(width - 2 * boss_lip)} мм",
    ]
    features_en = [
        f"a {fmt(plate_t)} mm plate with four {fmt(bolt_d)} mm bolt holes",
        f"bolt spacing {fmt(length - 2 * boss_lip)}x{fmt(width - 2 * boss_lip)} mm",
    ]
    if lip:
        features_ru.append(f"буртик {fmt(lip_h)} мм со стенкой {fmt(lip_wall)} мм")
        features_en.append(f"a {fmt(lip_h)} mm lip with {fmt(lip_wall)} mm walls")
    if countersink:
        features_ru.append(f"зенковки {fmt(cs_d)} мм под потайные винты")
        features_en.append(f"{fmt(cs_d)} mm countersinks")
    if ribs:
        features_ru.append(f"{ru_count(rib_n, 'ребро', 'ребра', 'ребер')} жесткости высотой {fmt(rib_h)} мм")
        features_en.append(f"{en_count(rib_n)} stiffening ribs {fmt(rib_h)} mm tall")
    if label:
        features_ru.append("приподнятая площадка под маркировку")
        features_en.append("a raised marking pad")
    return finish_part(
        rng,
        family="lids",
        variant=("lip" if lip else "flat") + ("_ribs" if ribs else "") + ("_cs" if countersink else ""),
        code=code,
        bbox=bbox,
        params={
            "length": length,
            "width": width,
            "plate_t": plate_t,
            "bolt_d": bolt_d,
            "bolt_pitch_x": round(length - 2 * boss_lip, 2),
            "bolt_pitch_y": round(width - 2 * boss_lip, 2),
            "height": bbox[2],
        },
        ru_nouns=LID_RU,
        en_nouns=LID_EN,
        features_ru=features_ru,
        features_en=features_en,
    )


# ---------------------------------------------------------------------------
# display bezels
# ---------------------------------------------------------------------------


def build_bezels(index: int) -> Part:
    rng = Rng("bezels", index)
    length = rng.grid([60.0, 80.0, 100.0, 120.0, 140.0, 160.0, 180.0])
    width = rng.grid([40.0, 50.0, 60.0, 80.0, 100.0, 120.0])
    frame_w = rng.grid([8.0, 10.0, 12.0, 15.0, 18.0])
    thickness = rng.grid([5.0, 6.0, 8.0, 10.0, 12.0])
    corner_r = rng.grid([4.0, 6.0, 8.0, 12.0, 16.0])
    chamfer = rng.grid([0.85, 0.9, 0.93, 0.96])     # outer wall taper
    funnel = rng.grid([0.9, 0.94, 0.97])            # inner opening taper
    holes = rng.chance(0.6)
    hole_d = rng.grid([3.4, 4.5, 5.5]) if holes else 0.0
    holes_per_side = rng.choice([1, 2]) if holes else 0
    sink = 1.0
    opening_l = round(length - 2 * frame_w, 2)
    opening_w = round(width - 2 * frame_w, 2)
    hole_inset = round(frame_w / 2, 2)

    builder = ScadBuilder(
        "Display bezel",
        f"{fmt(length)} x {fmt(width)} mm frame, opening {fmt(opening_l)}x{fmt(opening_w)} mm",
    )
    builder.param("length", length, "frame outside length, X")
    builder.param("width", width, "frame outside width, Y")
    builder.param("frame_w", frame_w, "frame width")
    builder.param("thickness", thickness, "frame thickness")
    builder.param("corner_r", corner_r, "outside corner radius")
    builder.param("chamfer", chamfer, "outer wall taper")
    builder.param("funnel", funnel, "inner opening taper")
    builder.param("opening_l", opening_l, "opening length")
    builder.param("opening_w", opening_w, "opening width")
    builder.param("inner_r", round(max(corner_r - frame_w, 2.0), 2), "opening corner radius")
    if holes:
        builder.param("hole_d", hole_d, "mounting screw clearance")
        builder.param("holes_per_side", float(holes_per_side), "holes per short side")
        builder.param("hole_inset", hole_inset, "hole centre inset from the outside edge")

    lines = [
        "/* rounded-rectangle outlines, generated with loops */",
        "module rounded_ring(l_nom, w_nom, r) {",
        "  hull() {",
        "    for (sx = [-1, 1]) for (sy = [-1, 1])",
        "      translate([sx * (l_nom / 2 - r), sy * (w_nom / 2 - r)]) circle(r = r);",
        "  }",
        "}",
        "",
        "difference() {",
        "  /* frame body, drafted so the outer edge is a variable-depth chamfer */",
        "  linear_extrude(height = thickness, scale = chamfer)",
        "    rounded_ring(length, width, corner_r);",
        "  /* viewing opening, drafted the other way for a funnel edge */",
        "  linear_extrude(height = thickness + 2, scale = funnel)",
        "    translate([0, 0, -1]) rounded_ring(opening_l, opening_w, inner_r);",
    ]
    if holes:
        lines += [
            "  /* mounting screws through the frame lands */",
            "  for (sx = [-1, 1]) for (i = [1 : holes_per_side])",
            "    translate([sx * (length / 2 - hole_inset),",
            "               (i - (holes_per_side + 1) / 2) * width * 0.5, -1])",
            "      cylinder(h = thickness + 2, d = hole_d);",
        ]
    lines.append("}")
    builder.section("\n".join(lines))
    code = builder.render()

    bbox = (float(length), float(width), float(thickness))
    features_ru = [
        f"рамка шириной {fmt(frame_w)} мм, окно {fmt(opening_l)}x{fmt(opening_w)} мм",
        f"наружная фаска переменной глубины: сужение до {fmt(chamfer * 100)} %",
        f"скругление углов R{fmt(corner_r)}",
    ]
    features_en = [
        f"a {fmt(frame_w)} mm frame with a {fmt(opening_l)}x{fmt(opening_w)} mm opening",
        f"a variable-depth chamfer tapering the outside to {fmt(chamfer * 100)} percent",
        f"R{fmt(corner_r)} rounded corners",
    ]
    if holes:
        features_ru.append(
            f"{ru_count(holes_per_side * 2, 'винт', 'винта', 'винтов')} {fmt(hole_d)} мм по краям рамки"
        )
        features_en.append(f"{en_count(holes_per_side * 2)} {fmt(hole_d)} mm mounting screws in the frame")
    return finish_part(
        rng,
        family="bezels",
        variant=("screwed" if holes else "plain"),
        code=code,
        bbox=bbox,
        params={
            "length": length,
            "width": width,
            "frame_w": frame_w,
            "thickness": thickness,
            "opening_l": opening_l,
            "opening_w": opening_w,
        },
        ru_nouns=BEZEL_RU,
        en_nouns=BEZEL_EN,
        features_ru=features_ru,
        features_en=features_en,
        feature_count=(3, 4),
    )
