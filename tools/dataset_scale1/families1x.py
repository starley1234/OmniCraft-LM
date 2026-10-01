"""Scale-discipline families for the scale1 corpus (request no. 6 leftover).

Four families, each stressing one corner of the real-scale rule ("5-250 mm on
any axis, walls >= 1.2 mm"):

* ``microfeatures`` - everything fits into a 5-20 mm box, features still print;
* ``largestruc``    - one axis lives at the 200-250 mm ceiling;
* ``hardlayouts``   - the prompt dictates explicit (x, y) feature coordinates;
* ``thinwalls``     - walls sit right on the 1.2-1.5 mm floor.

Every prompt number is a header parameter or a derived scalar assignment, so
the place1 consistency auditor accepts both languages.
"""

from __future__ import annotations

from tools.dataset_gen2.common import Part, Rng, ScadBuilder, fmt
from tools.dataset_v5.kit import tail_pair

RU_OPENERS = (
    "Смоделируй деталь:",
    "Нужна модель:",
    "Сделай параметрическую деталь:",
    "Построй твердотельную модель:",
    "Сгенерируй деталь по описанию:",
    "Нарисуй в OpenSCAD:",
    "Собери модель по размерам:",
    "Требуется деталь:",
)
EN_OPENERS = (
    "Model the part:",
    "I need a model:",
    "Build a parametric part:",
    "Make a solid model:",
    "Generate the part from this description:",
    "Draw it in OpenSCAD:",
    "Produce the part to these dimensions:",
    "Here is a part to build:",
)


def _finish(
    rng: Rng,
    family: str,
    variant: str,
    builder: ScadBuilder,
    bbox: tuple[float, float, float],
    params: dict[str, float],
    noun_ru: str,
    noun_en: str,
    feats_ru: list[str],
    feats_en: list[str],
) -> Part:
    ru_tail, en_tail, tol = tail_pair(rng)
    if tol is not None:
        fit, free = tol
        builder.param("fit_tol", fit, "tolerance for press fits, mm")
        builder.param("free_tol", free, "tolerance for clearance fits, mm")
        params["fit_tol"] = fit
        params["free_tol"] = free
    code = builder.render()
    dims_ru = f"габарит {fmt(bbox[0])} x {fmt(bbox[1])} x {fmt(bbox[2])} мм"
    dims_en = f"overall {fmt(bbox[0])} x {fmt(bbox[1])} x {fmt(bbox[2])} mm"
    ru = " ".join(
        [f"{rng.choice(RU_OPENERS)} {noun_ru}, {dims_ru}."]
        + [feature[0].upper() + feature[1:] + "." for feature in feats_ru]
        + [ru_tail]
    )
    en = " ".join(
        [f"{rng.choice(EN_OPENERS)} {noun_en}, {dims_en}."]
        + [feature[0].upper() + feature[1:] + "." for feature in feats_en]
        + [en_tail]
    )
    return Part(
        family=family,
        variant=variant,
        code=code,
        bbox=(round(bbox[0], 3), round(bbox[1], 3), round(bbox[2], 3)),
        params=params,
        prompt_ru=ru,
        prompt_en=en,
    )


# ---------------------------------------------------------------------------
# 1. microfeatures: everything inside a 5-20 mm box
# ---------------------------------------------------------------------------


def build_microfeatures(index: int) -> Part:
    rng = Rng("scale1_microfeatures", index)
    variant = rng.choice(("drilled_pad", "two_hole_pad", "flanged_post", "slotted_block"))
    params: dict[str, float] = {}
    if variant == "drilled_pad":
        pad_l = rng.grid([10.0, 12.0, 14.0, 16.0, 18.0, 20.0])
        pad_w = rng.grid([8.0, 10.0, 12.0, 14.0])
        pad_t = rng.grid([5.0, 6.0, 8.0])
        hole_d = rng.grid([2.5, 3.0, 3.5, 4.0])
        if hole_d / 2 + 1.5 > min(pad_l, pad_w) / 2:
            raise ValueError("hole breaks the micro pad wall")
        builder = ScadBuilder("Micro pad", "drilled pad, 5-20 mm class")
        for name, value, comment in (
            ("pad_l", pad_l, "pad length, X"),
            ("pad_w", pad_w, "pad width, Y"),
            ("pad_t", pad_t, "pad thickness, Z"),
            ("hole_d", hole_d, "through hole diameter"),
        ):
            builder.param(name, value, comment)
            params[name] = value
        builder.section(
            "difference() {\n"
            "  cube([pad_l, pad_w, pad_t]);\n"
            "  translate([pad_l / 2, pad_w / 2, -1])\n"
            "    cylinder(h = pad_t + 2, d = hole_d);\n"
            "}"
        )
        bbox = (pad_l, pad_w, pad_t)
        feats_ru = [f"сквозное отверстие d{fmt(hole_d)} мм в центре"]
        feats_en = [f"a central through hole, d{fmt(hole_d)} mm"]
        noun_ru, noun_en = "миниатюрную площадку", "a miniature pad"
    elif variant == "two_hole_pad":
        pad_l = rng.grid([14.0, 16.0, 18.0, 20.0])
        pad_w = rng.grid([8.0, 10.0, 12.0])
        pad_t = rng.grid([5.0, 6.0])
        hole_d = rng.grid([2.5, 3.0, 3.5])
        hole_x = rng.grid([5.0, 6.0, 7.0])
        if hole_x - hole_d / 2 < 1.5 or pad_l - hole_x - hole_d / 2 < 1.5:
            raise ValueError("hole breaks the pad edge wall")
        builder = ScadBuilder("Micro pad", "two-hole pad, 5-20 mm class")
        for name, value, comment in (
            ("pad_l", pad_l, "pad length, X"),
            ("pad_w", pad_w, "pad width, Y"),
            ("pad_t", pad_t, "pad thickness, Z"),
            ("hole_d", hole_d, "hole diameter"),
            ("hole_x", hole_x, "X of the first hole centre"),
        ):
            builder.param(name, value, comment)
            params[name] = value
        builder.section(
            "difference() {\n"
            "  cube([pad_l, pad_w, pad_t]);\n"
            "  for (x = [hole_x, pad_l - hole_x])\n"
            "    translate([x, pad_w / 2, -1])\n"
            "      cylinder(h = pad_t + 2, d = hole_d);\n"
            "}"
        )
        bbox = (pad_l, pad_w, pad_t)
        feats_ru = [f"два отверстия d{fmt(hole_d)} мм на оси Y, центры в {fmt(hole_x)} мм от торцов"]
        feats_en = [f"two d{fmt(hole_d)} mm holes, centres {fmt(hole_x)} mm from each end"]
        noun_ru, noun_en = "миниатюрную площадку", "a miniature pad"
    elif variant == "flanged_post":
        post_d = rng.grid([6.0, 7.0, 8.0])
        post_h = rng.grid([8.0, 10.0, 12.0])
        flange_d = rng.grid([12.0, 14.0, 16.0])
        flange_t = rng.grid([2.0, 3.0])
        bore_d = rng.grid([2.5, 3.0])
        builder = ScadBuilder("Micro post", "flanged post, 5-20 mm class")
        for name, value, comment in (
            ("post_d", post_d, "post diameter"),
            ("post_h", post_h, "post height above the flange"),
            ("flange_d", flange_d, "flange diameter"),
            ("flange_t", flange_t, "flange thickness"),
            ("bore_d", bore_d, "through bore"),
        ):
            builder.param(name, value, comment)
            params[name] = value
        builder.assignment("total_h = post_h + flange_t;  // overall height")
        params["total_h"] = post_h + flange_t
        builder.section(
            "difference() {\n"
            "  union() {\n"
            "    cylinder(h = flange_t, d = flange_d);\n"
            "    translate([0, 0, flange_t]) cylinder(h = post_h, d = post_d);\n"
            "  }\n"
            "  translate([0, 0, -1]) cylinder(h = total_h + 2, d = bore_d);\n"
            "}"
        )
        bbox = (flange_d, flange_d, post_h + flange_t)
        feats_ru = [
            f"фланец d{fmt(flange_d)} x {fmt(flange_t)} мм",
            f"стойка d{fmt(post_d)} высотой {fmt(post_h)} мм, сквозное отверстие d{fmt(bore_d)} мм",
        ]
        feats_en = [
            f"flange d{fmt(flange_d)} mm, {fmt(flange_t)} mm thick",
            f"post d{fmt(post_d)}, {fmt(post_h)} mm tall, d{fmt(bore_d)} through bore",
        ]
        noun_ru, noun_en = "миниатюрную стойку с фланцем", "a miniature flanged post"
    else:  # slotted_block
        block_l = rng.grid([12.0, 14.0, 16.0])
        block_w = rng.grid([10.0, 12.0, 14.0])
        block_h = rng.grid([8.0, 10.0])
        slot_w = rng.grid([1.5, 2.0, 2.5])
        slot_d = rng.grid([4.0, 5.0, 6.0])
        if (block_w - slot_w) / 2 < 1.2 or block_h - slot_d < 1.2:
            raise ValueError("slot leaves a wall under 1.2 mm")
        builder = ScadBuilder("Micro clip", "slotted block, 5-20 mm class")
        for name, value, comment in (
            ("block_l", block_l, "block length, X"),
            ("block_w", block_w, "block width, Y"),
            ("block_h", block_h, "block height, Z"),
            ("slot_w", slot_w, "slot width"),
            ("slot_d", slot_d, "slot depth from the top"),
        ):
            builder.param(name, value, comment)
            params[name] = value
        builder.section(
            "difference() {\n"
            "  cube([block_l, block_w, block_h]);\n"
            "  translate([-1, block_w / 2 - slot_w / 2, block_h - slot_d])\n"
            "    cube([block_l + 2, slot_w, slot_d + 1]);\n"
            "}"
        )
        bbox = (block_l, block_w, block_h)
        feats_ru = [f"паз шириной {fmt(slot_w)} мм и глубиной {fmt(slot_d)} мм с торца"]
        feats_en = [f"an end slot {fmt(slot_w)} mm wide, {fmt(slot_d)} mm deep"]
        noun_ru, noun_en = "миниатюрный зажим", "a miniature clip block"
    return _finish(rng, "microfeatures", variant, builder, bbox, params, noun_ru, noun_en, feats_ru, feats_en)


# ---------------------------------------------------------------------------
# 2. largerstruc: one axis at the 200-250 mm ceiling
# ---------------------------------------------------------------------------


def build_largerstruc(index: int) -> Part:
    rng = Rng("scale1_largerstruc", index)
    variant = rng.choice(("long_rail", "big_plate", "box_beam", "gantry_bracket"))
    params: dict[str, float] = {}
    if variant == "long_rail":
        rail_l = rng.grid([200.0, 210.0, 220.0, 230.0, 240.0, 250.0])
        rail_w = rng.grid([25.0, 30.0, 35.0, 40.0])
        rail_t = rng.grid([8.0, 10.0, 12.0])
        hole_d = rng.grid([5.0, 6.0])
        hole_start = rng.grid([20.0, 25.0, 30.0])
        hole_pitch = rng.grid([40.0, 45.0, 50.0])
        holes = int((rail_l - 2 * hole_start) // hole_pitch) + 1
        if holes < 3:
            raise ValueError("rail too short for the pitch")
        builder = ScadBuilder("Long rail", "200-250 mm mounting rail")
        for name, value, comment in (
            ("rail_l", rail_l, "rail length, X"),
            ("rail_w", rail_w, "rail width, Y"),
            ("rail_t", rail_t, "rail thickness, Z"),
            ("hole_d", hole_d, "mounting hole diameter"),
            ("hole_start", hole_start, "first hole offset from the end"),
            ("hole_pitch", hole_pitch, "hole pitch"),
            ("holes", float(holes), "number of holes"),
        ):
            builder.param(name, value, comment)
            params[name] = value
        builder.section(
            "difference() {\n"
            "  cube([rail_l, rail_w, rail_t]);\n"
            "  for (i = [0 : holes - 1])\n"
            "    translate([hole_start + i * hole_pitch, rail_w / 2, -1])\n"
            "      cylinder(h = rail_t + 2, d = hole_d);\n"
            "}"
        )
        bbox = (rail_l, rail_w, rail_t)
        feats_ru = [f"{holes} монтажных отверстий d{fmt(hole_d)} мм с шагом {fmt(hole_pitch)} мм, отступ от торца {fmt(hole_start)} мм"]
        feats_en = [f"{holes} mounting holes, d{fmt(hole_d)} mm on a {fmt(hole_pitch)} mm pitch, {fmt(hole_start)} mm from the ends"]
        noun_ru, noun_en = "длинную монтажную рейку", "a long mounting rail"
    elif variant == "big_plate":
        plate_l = rng.grid([200.0, 220.0, 240.0])
        plate_w = rng.grid([150.0, 170.0, 190.0])
        plate_t = rng.grid([5.0, 6.0, 8.0])
        corner_d = rng.grid([8.0, 10.0])
        corner_in = rng.grid([15.0, 20.0])
        bore_d = rng.grid([30.0, 40.0, 50.0])
        builder = ScadBuilder("Big plate", "200-250 mm adapter plate")
        for name, value, comment in (
            ("plate_l", plate_l, "plate length, X"),
            ("plate_w", plate_w, "plate width, Y"),
            ("plate_t", plate_t, "plate thickness, Z"),
            ("corner_d", corner_d, "corner hole diameter"),
            ("corner_in", corner_in, "corner hole inset from the edges"),
            ("bore_d", bore_d, "central bore"),
        ):
            builder.param(name, value, comment)
            params[name] = value
        builder.section(
            "difference() {\n"
            "  cube([plate_l, plate_w, plate_t]);\n"
            "  translate([corner_in, corner_in, -1]) cylinder(h = plate_t + 2, d = corner_d);\n"
            "  translate([plate_l - corner_in, corner_in, -1]) cylinder(h = plate_t + 2, d = corner_d);\n"
            "  translate([corner_in, plate_w - corner_in, -1]) cylinder(h = plate_t + 2, d = corner_d);\n"
            "  translate([plate_l - corner_in, plate_w - corner_in, -1]) cylinder(h = plate_t + 2, d = corner_d);\n"
            "  translate([plate_l / 2, plate_w / 2, -1]) cylinder(h = plate_t + 2, d = bore_d);\n"
            "}"
        )
        bbox = (plate_l, plate_w, plate_t)
        feats_ru = [
            f"центральное отверстие d{fmt(bore_d)} мм",
            f"четыре угловых отверстия d{fmt(corner_d)} мм с отступом {fmt(corner_in)} мм от краёв",
        ]
        feats_en = [
            f"a d{fmt(bore_d)} mm central bore",
            f"four d{fmt(corner_d)} mm corner holes, {fmt(corner_in)} mm in from the edges",
        ]
        noun_ru, noun_en = "большую переходную плиту", "a large adapter plate"
    elif variant == "box_beam":
        beam_l = rng.grid([200.0, 220.0, 240.0, 250.0])
        beam_w = rng.grid([30.0, 40.0, 50.0])
        beam_h = rng.grid([30.0, 40.0, 50.0])
        wall = rng.grid([3.0, 4.0, 5.0])
        builder = ScadBuilder("Box beam", "200-250 mm hollow beam")
        for name, value, comment in (
            ("beam_l", beam_l, "beam length, X"),
            ("beam_w", beam_w, "beam width, Y"),
            ("beam_h", beam_h, "beam height, Z"),
            ("wall", wall, "wall thickness"),
        ):
            builder.param(name, value, comment)
            params[name] = value
        builder.section(
            "difference() {\n"
            "  cube([beam_l, beam_w, beam_h]);\n"
            "  translate([-1, wall, wall])\n"
            "    cube([beam_l + 2, beam_w - 2 * wall, beam_h - 2 * wall]);\n"
            "}"
        )
        bbox = (beam_l, beam_w, beam_h)
        feats_ru = [f"полый короб со стенкой {fmt(wall)} мм, открытый с торцов"]
        feats_en = [f"a hollow box with {fmt(wall)} mm walls, open at both ends"]
        noun_ru, noun_en = "полую балку-короб", "a hollow box beam"
    else:  # gantry_bracket
        base_l = rng.grid([200.0, 220.0, 240.0])
        arm_w = rng.grid([40.0, 50.0])
        thick = rng.grid([10.0, 12.0])
        up_h = rng.grid([60.0, 80.0, 100.0])
        slot_w = rng.grid([12.0, 14.0])
        builder = ScadBuilder("Gantry bracket", "200-250 mm L bracket")
        for name, value, comment in (
            ("base_l", base_l, "base arm length, X"),
            ("arm_w", arm_w, "arm width, Y"),
            ("thick", thick, "arm thickness"),
            ("up_h", up_h, "vertical arm height, Z"),
            ("slot_w", slot_w, "adjustment slot width in the base"),
        ):
            builder.param(name, value, comment)
            params[name] = value
        builder.assignment("total_h = up_h + thick;  // overall height")
        params["total_h"] = up_h + thick
        builder.section(
            "difference() {\n"
            "  union() {\n"
            "    cube([base_l, arm_w, thick]);\n"
            "    cube([thick, arm_w, total_h]);\n"
            "  }\n"
            "  translate([base_l / 2 - slot_w / 2, arm_w / 2 - slot_w / 2, -1])\n"
            "    cube([slot_w, slot_w, thick + 2]);\n"
            "}"
        )
        bbox = (base_l, arm_w, up_h + thick)
        feats_ru = [
            f"горизонтальное плечо {fmt(base_l)} мм, вертикальное {fmt(up_h)} мм, толщина {fmt(thick)} мм",
            f"регулировочный паз {fmt(slot_w)} x {fmt(slot_w)} мм в середине основания",
        ]
        feats_en = [
            f"{fmt(base_l)} mm base arm, {fmt(up_h)} mm upright, {fmt(thick)} mm thick",
            f"a {fmt(slot_w)} x {fmt(slot_w)} mm adjustment slot mid-base",
        ]
        noun_ru, noun_en = "большой угловой кронштейн", "a large L bracket"
    return _finish(rng, "largestruc", variant, builder, bbox, params, noun_ru, noun_en, feats_ru, feats_en)


# ---------------------------------------------------------------------------
# 3. hardlayouts: prompt dictates explicit coordinates
# ---------------------------------------------------------------------------


def _coord_list(points: list[tuple[float, float]]) -> str:
    return ", ".join(f"({fmt(x)}, {fmt(y)})" for x, y in points)


def build_hardlayouts(index: int) -> Part:
    rng = Rng("scale1_hardlayouts", index)
    variant = rng.choice(("boss_field", "hole_field", "mixed_field"))
    plate_l = rng.grid([80.0, 90.0, 100.0, 110.0, 120.0])
    plate_w = rng.grid([50.0, 60.0, 70.0, 80.0])
    plate_t = rng.grid([4.0, 5.0, 6.0])
    params: dict[str, float] = {"plate_l": plate_l, "plate_w": plate_w, "plate_t": plate_t}

    lattice_x = [round(v, 1) for v in range(15, int(plate_l) - 9, 10)]
    lattice_y = [round(v, 1) for v in range(15, int(plate_w) - 9, 10)]
    if len(lattice_x) < 2 or len(lattice_y) < 2:
        raise ValueError("plate too small for a lattice")

    if variant == "boss_field":
        count = rng.integer(3, 5)
        picks = rng.sample([(x, y) for x in lattice_x for y in lattice_y], count)
        picks.sort()
        boss_d = rng.grid([10.0, 12.0])
        boss_h = rng.grid([5.0, 6.0, 8.0])
        bore_d = rng.grid([3.0, 4.0])
        if any(x - boss_d / 2 < 3 or x + boss_d / 2 > plate_l - 3
               or y - boss_d / 2 < 3 or y + boss_d / 2 > plate_w - 3 for x, y in picks):
            raise ValueError("boss off the plate")
        builder = ScadBuilder("Boss field", "plate with bosses at given coordinates")
        for name, value, comment in (
            ("plate_l", plate_l, "plate length, X"),
            ("plate_w", plate_w, "plate width, Y"),
            ("plate_t", plate_t, "plate thickness, Z"),
            ("boss_d", boss_d, "boss diameter"),
            ("boss_h", boss_h, "boss height above the plate"),
            ("bore_d", bore_d, "boss bore"),
        ):
            builder.param(name, value, comment)
            params[name] = value
        builder.assignment("total_h = plate_t + boss_h;  // overall height")
        params["total_h"] = plate_t + boss_h
        body = ["difference() {", "  union() {", "    cube([plate_l, plate_w, plate_t]);"]
        for x, y in picks:
            body.append(f"    translate([{fmt(x)}, {fmt(y)}, plate_t]) cylinder(h = boss_h, d = boss_d);")
        body.append("  }")
        for x, y in picks:
            body.append(f"  translate([{fmt(x)}, {fmt(y)}, -1]) cylinder(h = total_h + 2, d = bore_d);")
        body.append("}")
        builder.section("\n".join(body))
        bbox = (plate_l, plate_w, plate_t + boss_h)
        feats_ru = [f"боссы d{fmt(boss_d)} высотой {fmt(boss_h)} мм со сквозными отверстиями d{fmt(bore_d)} мм в точках {_coord_list(picks)}"]
        feats_en = [f"d{fmt(boss_d)} bosses {fmt(boss_h)} mm tall, d{fmt(bore_d)} bores, at {_coord_list(picks)}"]
        noun_ru, noun_en = "плиту с боссами по координатам", "a plate with bosses at explicit coordinates"
    elif variant == "hole_field":
        count = rng.integer(4, 6)
        picks = rng.sample([(x, y) for x in lattice_x for y in lattice_y], count)
        picks.sort()
        hole_d = rng.grid([5.0, 6.0, 8.0])
        if any(x - hole_d / 2 < 3 or x + hole_d / 2 > plate_l - 3
               or y - hole_d / 2 < 3 or y + hole_d / 2 > plate_w - 3 for x, y in picks):
            raise ValueError("hole off the plate")
        builder = ScadBuilder("Hole field", "plate with holes at given coordinates")
        for name, value, comment in (
            ("plate_l", plate_l, "plate length, X"),
            ("plate_w", plate_w, "plate width, Y"),
            ("plate_t", plate_t, "plate thickness, Z"),
            ("hole_d", hole_d, "hole diameter"),
        ):
            builder.param(name, value, comment)
            params[name] = value
        body = ["difference() {", "  cube([plate_l, plate_w, plate_t]);"]
        for x, y in picks:
            body.append(f"  translate([{fmt(x)}, {fmt(y)}, -1]) cylinder(h = plate_t + 2, d = hole_d);")
        body.append("}")
        builder.section("\n".join(body))
        bbox = (plate_l, plate_w, plate_t)
        feats_ru = [f"сквозные отверстия d{fmt(hole_d)} мм в точках {_coord_list(picks)}"]
        feats_en = [f"through holes d{fmt(hole_d)} mm at {_coord_list(picks)}"]
        noun_ru, noun_en = "плиту с отверстиями по координатам", "a plate with holes at explicit coordinates"
    else:  # mixed_field
        bosses = rng.sample([(x, y) for x in lattice_x for y in lattice_y], 2)
        boss_d = rng.grid([12.0, 14.0])
        boss_h = rng.grid([6.0, 8.0])
        hole_d = rng.grid([5.0, 6.0])
        if any(x - boss_d / 2 < 3 or x + boss_d / 2 > plate_l - 3
               or y - boss_d / 2 < 3 or y + boss_d / 2 > plate_w - 3 for x, y in bosses):
            raise ValueError("boss off the plate")
        keep_out = boss_d / 2 + hole_d / 2 + 3.0
        rest = [
            (x, y)
            for x in lattice_x
            for y in lattice_y
            if (x, y) not in bosses
            and all(abs(x - bx) >= keep_out or abs(y - by) >= keep_out for bx, by in bosses)
        ]
        if len(rest) < 2:
            raise ValueError("no room for holes next to the bosses")
        holes = rng.sample(rest, rng.integer(2, 3))
        bosses.sort()
        holes.sort()
        builder = ScadBuilder("Mixed field", "bosses and holes at given coordinates")
        for name, value, comment in (
            ("plate_l", plate_l, "plate length, X"),
            ("plate_w", plate_w, "plate width, Y"),
            ("plate_t", plate_t, "plate thickness, Z"),
            ("boss_d", boss_d, "boss diameter"),
            ("boss_h", boss_h, "boss height above the plate"),
            ("hole_d", hole_d, "through hole diameter"),
        ):
            builder.param(name, value, comment)
            params[name] = value
        builder.assignment("total_h = plate_t + boss_h;  // overall height")
        params["total_h"] = plate_t + boss_h
        body = ["difference() {", "  union() {", "    cube([plate_l, plate_w, plate_t]);"]
        for x, y in bosses:
            body.append(f"    translate([{fmt(x)}, {fmt(y)}, plate_t]) cylinder(h = boss_h, d = boss_d);")
        body.append("  }")
        for x, y in bosses:
            body.append(f"  translate([{fmt(x)}, {fmt(y)}, -1]) cylinder(h = total_h + 2, d = boss_d / 2);")
        for x, y in holes:
            body.append(f"  translate([{fmt(x)}, {fmt(y)}, -1]) cylinder(h = plate_t + 2, d = hole_d);")
        body.append("}")
        builder.section("\n".join(body))
        bbox = (plate_l, plate_w, plate_t + boss_h)
        feats_ru = [
            f"боссы d{fmt(boss_d)} высотой {fmt(boss_h)} мм в точках {_coord_list(bosses)}",
            f"сквозные отверстия d{fmt(hole_d)} мм в точках {_coord_list(holes)}",
        ]
        feats_en = [
            f"d{fmt(boss_d)} bosses {fmt(boss_h)} mm tall at {_coord_list(bosses)}",
            f"d{fmt(hole_d)} mm through holes at {_coord_list(holes)}",
        ]
        noun_ru, noun_en = "плиту со смешанной раскладкой", "a plate with a mixed feature layout"
    return _finish(rng, "hardlayouts", variant, builder, bbox, params, noun_ru, noun_en, feats_ru, feats_en)


# ---------------------------------------------------------------------------
# 4. thinwalls: walls at the 1.2-1.5 mm floor
# ---------------------------------------------------------------------------


def build_thinwalls(index: int) -> Part:
    rng = Rng("scale1_thinwalls", index)
    variant = rng.choice(("open_box", "thin_tube", "ribbed_panel"))
    params: dict[str, float] = {}
    if variant == "open_box":
        box_l = rng.grid([40.0, 50.0, 60.0, 70.0, 80.0])
        box_w = rng.grid([30.0, 40.0, 50.0, 60.0])
        box_h = rng.grid([20.0, 25.0, 30.0, 40.0])
        wall = rng.grid([1.2, 1.3, 1.4, 1.5])
        floor = rng.grid([1.5, 2.0])
        builder = ScadBuilder("Open box", f"{fmt(wall)} mm walls")
        for name, value, comment in (
            ("box_l", box_l, "outer length, X"),
            ("box_w", box_w, "outer width, Y"),
            ("box_h", box_h, "outer height, Z"),
            ("wall", wall, "wall thickness"),
            ("floor", floor, "floor thickness"),
        ):
            builder.param(name, value, comment)
            params[name] = value
        builder.section(
            "difference() {\n"
            "  cube([box_l, box_w, box_h]);\n"
            "  translate([wall, wall, floor])\n"
            "    cube([box_l - 2 * wall, box_w - 2 * wall, box_h]);\n"
            "}"
        )
        bbox = (box_l, box_w, box_h)
        feats_ru = [f"короб без крышки, стенки {fmt(wall)} мм, дно {fmt(floor)} мм"]
        feats_en = [f"an open-top box, {fmt(wall)} mm walls, {fmt(floor)} mm floor"]
        noun_ru, noun_en = "тонкостенный короб", "a thin-walled open box"
    elif variant == "thin_tube":
        tube_od = rng.grid([25.0, 30.0, 40.0, 50.0, 60.0])
        tube_h = rng.grid([20.0, 30.0, 40.0, 50.0, 60.0])
        wall = rng.grid([1.2, 1.3, 1.4, 1.5])
        builder = ScadBuilder("Thin tube", f"{fmt(wall)} mm wall")
        for name, value, comment in (
            ("tube_od", tube_od, "outer diameter"),
            ("tube_h", tube_h, "height, Z"),
            ("wall", wall, "wall thickness"),
        ):
            builder.param(name, value, comment)
            params[name] = value
        builder.section(
            "difference() {\n"
            "  cylinder(h = tube_h, d = tube_od);\n"
            "  translate([0, 0, -1]) cylinder(h = tube_h + 2, d = tube_od - 2 * wall);\n"
            "}"
        )
        bbox = (tube_od, tube_od, tube_h)
        feats_ru = [f"труба d{fmt(tube_od)} мм высотой {fmt(tube_h)} мм со стенкой {fmt(wall)} мм"]
        feats_en = [f"a d{fmt(tube_od)} mm tube {fmt(tube_h)} mm tall with a {fmt(wall)} mm wall"]
        noun_ru, noun_en = "тонкостенную трубу", "a thin-walled tube"
    else:  # ribbed_panel
        panel_l = rng.grid([60.0, 80.0, 100.0])
        panel_w = rng.grid([40.0, 50.0, 60.0])
        panel_t = rng.grid([1.2, 1.3, 1.4, 1.5])
        rib_t = rng.grid([1.2, 1.3, 1.4, 1.5])
        rib_h = rng.grid([8.0, 10.0, 12.0])
        ribs = int(rng.grid([2.0, 3.0, 4.0]))
        builder = ScadBuilder("Ribbed panel", f"{fmt(panel_t)} mm panel")
        for name, value, comment in (
            ("panel_l", panel_l, "panel length, X"),
            ("panel_w", panel_w, "panel width, Y"),
            ("panel_t", panel_t, "panel thickness, Z"),
            ("rib_t", rib_t, "rib thickness"),
            ("rib_h", rib_h, "rib height below the panel"),
            ("ribs", float(ribs), "number of ribs"),
        ):
            builder.param(name, value, comment)
            params[name] = value
        builder.assignment("total_h = panel_t + rib_h;  // overall height")
        params["total_h"] = panel_t + rib_h
        builder.section(
            "union() {\n"
            "  cube([panel_l, panel_w, panel_t]);\n"
            "  for (i = [1 : ribs])\n"
            "    translate([i * panel_l / (ribs + 1) - rib_t / 2, 0, -rib_h])\n"
            "      cube([rib_t, panel_w, rib_h + panel_t]);\n"
            "}"
        )
        bbox = (panel_l, panel_w, panel_t + rib_h)
        feats_ru = [
            f"панель {fmt(panel_l)} x {fmt(panel_w)} мм толщиной {fmt(panel_t)} мм",
            f"{ribs} ребра толщиной {fmt(rib_t)} мм и высотой {fmt(rib_h)} мм снизу",
        ]
        feats_en = [
            f"a {fmt(panel_l)} x {fmt(panel_w)} mm panel, {fmt(panel_t)} mm thick",
            f"{ribs} ribs {fmt(rib_t)} mm thick, {fmt(rib_h)} mm deep underneath",
        ]
        noun_ru, noun_en = "тонкую панель с рёбрами", "a thin ribbed panel"
    return _finish(rng, "thinwalls", variant, builder, bbox, params, noun_ru, noun_en, feats_ru, feats_en)


FAMILY_BUILDERS = {
    "microfeatures": build_microfeatures,
    "largestruc": build_largerstruc,
    "hardlayouts": build_hardlayouts,
    "thinwalls": build_thinwalls,
}

COVERAGE_NOTES = {
    "microfeatures": "all axes 5-20 mm; holes >= d2.5, walls >= 1.2 mm",
    "largestruc": "one axis 200-250 mm: rails, plates, box beams, brackets",
    "hardlayouts": "prompts quote explicit (x, y) feature coordinates",
    "thinwalls": "walls exactly at the 1.2-1.5 mm floor",
}
