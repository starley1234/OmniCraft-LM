"""Second wave of the voxel canvas: five solid families for the solid2 corpus.

* ``heatsink``     - finned cooling blocks (uniform / slotted / cross fins);
* ``manifoldblock``- ported distribution blocks with a top gallery;
* ``controlknob``  - panel knobs (pointer / dimpled / skirted with grip ribs);
* ``drilljig``     - drill jigs with guide bosses, slots and fence variants;
* ``ventbox``      - vented enclosures (louver wall / cross grid / round vent).

Every union overlap is >= 0.5 mm (never face-to-face tangency), every shell
wall >= 1.5 mm, every prompt number is a header parameter or a derived
scalar, so the place1 auditor accepts both languages.
"""

from __future__ import annotations

import math

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


def _r2(value: float) -> float:
    return round(value + 1e-9, 2)


def _plural(n: int, one: str, few: str, many: str) -> str:
    if n % 10 == 1 and n % 100 != 11:
        return one
    if 2 <= n % 10 <= 4 and not 12 <= n % 100 <= 14:
        return few
    return many


# ---------------------------------------------------------------------------
# 1. heatsink: finned cooling blocks
# ---------------------------------------------------------------------------


def build_heatsink(index: int) -> Part:
    rng = Rng("solid2_heatsink", index)
    variant = rng.choice(("uniform", "slotted", "cross"))
    base_l = rng.grid([70.0, 80.0, 90.0, 100.0, 110.0, 120.0])
    base_w = rng.grid([45.0, 50.0, 60.0, 70.0, 80.0])
    base_t = rng.grid([6.0, 8.0, 10.0])
    fin_h = rng.grid([20.0, 25.0, 30.0, 40.0])
    fin_t = rng.grid([2.0, 2.5, 3.0])
    edge = rng.grid([3.0, 4.0])
    pitch = rng.grid([8.0, 9.0, 10.0, 12.0])
    usable = base_l - 2 * edge
    n_fins = int((usable - fin_t) // pitch) + 1
    if n_fins < 4:
        raise ValueError("fin pattern does not fit the base")

    builder = ScadBuilder("Heatsink", f"{variant} fin block")
    params: dict[str, float] = {}
    for name, value, comment in (
        ("base_l", base_l, "base length, X"),
        ("base_w", base_w, "base width, Y"),
        ("base_t", base_t, "base plate thickness"),
        ("fin_h", fin_h, "fin height above the base"),
        ("fin_t", fin_t, "fin thickness"),
        ("edge", edge, "margin from the base ends"),
        ("pitch", pitch, "fin pitch"),
    ):
        builder.param(name, value, comment)
        params[name] = value
    builder.assignment("n_fins = floor((base_l - 2 * edge - fin_t) / pitch) + 1;  // fin count")
    builder.assignment("total_h = base_t + fin_h - 1;  // overall height")
    params["n_fins"] = float(n_fins)

    body = ["union() {", "  cube([base_l, base_w, base_t]);"]
    # fins sink 1 mm into the base plate: real volume overlap, no tangency
    body.append(
        "  for (i = [0 : n_fins - 1])\n"
        "    translate([edge + i * pitch, edge, base_t - 1])\n"
        "      cube([fin_t, base_w - 2 * edge, fin_h]);"
    )
    if variant == "cross":
        rib_pitch = rng.grid([14.0, 16.0, 18.0])
        n_ribs = int((base_w - 2 * edge) // rib_pitch)
        if n_ribs < 2:
            raise ValueError("no room for cross ribs")
        builder.param("rib_pitch", rib_pitch, "cross rib pitch")
        params["rib_pitch"] = rib_pitch
        builder.assignment("n_ribs = floor((base_w - 2 * edge) / rib_pitch);  // rib count")
        params["n_ribs"] = float(n_ribs)
        body.append(
            "  for (i = [0 : n_ribs - 1])\n"
            "    translate([edge, edge + 1 + i * rib_pitch, base_t - 1])\n"
            "      cube([base_l - 2 * edge, fin_t, fin_h]);"
        )
    body.append("}")
    feats_ru = [
        f"{n_fins} {_plural(n_fins, 'ребро', 'ребра', 'ребер')} высотой {fmt(fin_h)} мм с шагом {fmt(pitch)} мм",
        f"основание {fmt(base_l)} x {fmt(base_w)} мм толщиной {fmt(base_t)} мм",
    ]
    feats_en = [
        f"{n_fins} fins, {fmt(fin_h)} mm tall on a {fmt(pitch)} mm pitch",
        f"base plate {fmt(base_l)} x {fmt(base_w)} mm, {fmt(base_t)} mm thick",
    ]
    noun_ru, noun_en = "радиатор охлаждения", "a heatsink block"

    if variant == "slotted":
        slot_w = rng.grid([6.0, 8.0, 10.0])
        if slot_w + 2 > base_w - 2 * edge:
            raise ValueError("slot wider than the fin field")
        builder.param("slot_w", slot_w, "central slot width, Y")
        params["slot_w"] = slot_w
        code_fin = "\n".join(body)
        # the slot stops 0.5 mm inside the base, so both fin fields stay
        # connected through the plate
        builder.section(
            "difference() {\n"
            f"{code_fin}\n"
            "  translate([-1, base_w / 2 - slot_w / 2, base_t - 0.5])\n"
            "    cube([base_l + 2, slot_w, fin_h + 2]);\n"
            "}"
        )
        feats_ru.append(f"сквозной паз шириной {fmt(slot_w)} мм поперёк рёбер")
        feats_en.append(f"a {fmt(slot_w)} mm slot cut across the fins")
    else:
        builder.section("\n".join(body))
        if variant == "cross":
            feats_ru.append(f"поперечные рёбра с шагом {fmt(rib_pitch)} мм")
            feats_en.append(f"cross ribs on a {fmt(rib_pitch)} mm pitch")
    bbox = (base_l, base_w, _r2(base_t + fin_h - 1))
    return _finish(rng, "heatsink", variant, builder, bbox, params,
                   noun_ru, noun_en, feats_ru, feats_en)


# ---------------------------------------------------------------------------
# 2. manifoldblock: ported distribution block
# ---------------------------------------------------------------------------


def build_manifoldblock(index: int) -> Part:
    rng = Rng("solid2_manifoldblock", index)
    variant = rng.choice(("gallery_top", "side_outlet"))
    block_l = rng.grid([80.0, 90.0, 100.0, 110.0, 120.0])
    block_w = rng.grid([45.0, 50.0, 60.0])
    block_h = rng.grid([30.0, 35.0, 40.0])
    port_d = rng.grid([8.0, 10.0, 12.0])
    port_pitch = rng.grid([18.0, 20.0, 22.0, 24.0])
    margin = port_d / 2 + 8.0
    n_ports = int((block_l - 2 * margin) // port_pitch) + 1
    if n_ports < 3:
        raise ValueError("port row does not fit the block")
    gallery_d = rng.grid([14.0, 16.0])
    gallery_depth = rng.grid([12.0, 14.0, 16.0])
    wall_p = rng.grid([8.0, 10.0])
    mnt_d = rng.grid([4.5, 5.0])
    mnt_in = rng.grid([6.0, 7.0])

    builder = ScadBuilder("Manifold block", f"{variant} manifold")
    params: dict[str, float] = {}
    for name, value, comment in (
        ("block_l", block_l, "block length, X"),
        ("block_w", block_w, "block width, Y"),
        ("block_h", block_h, "block height, Z"),
        ("port_d", port_d, "port bore diameter"),
        ("port_pitch", port_pitch, "port pitch along X"),
        ("gallery_d", gallery_d, "top gallery width, Y"),
        ("gallery_depth", gallery_depth, "gallery pocket depth"),
        ("wall_p", wall_p, "gallery end wall thickness, X"),
        ("mnt_d", mnt_d, "mounting hole diameter"),
        ("mnt_in", mnt_in, "mounting hole inset from the edges"),
    ):
        builder.param(name, value, comment)
        params[name] = value
    builder.assignment(f"n_ports = {n_ports};  // ports in the row")
    builder.assignment("port_x0 = (block_l - (n_ports - 1) * port_pitch) / 2;  // first port X")
    params["n_ports"] = float(n_ports)

    tool = [
        "  for (i = [0 : n_ports - 1])\n"
        "    translate([port_x0 + i * port_pitch, block_w / 2, -1])\n"
        "      cylinder(h = block_h + 2, d = port_d);"
    ]
    tool.append(
        "  translate([wall_p, block_w / 2 - gallery_d / 2, block_h - gallery_depth])\n"
        "    cube([block_l - 2 * wall_p, gallery_d, gallery_depth + 1]);"
    )
    tool.append(
        "  for (cx = [mnt_in, block_l - mnt_in])\n"
        "    for (cy = [mnt_in, block_w - mnt_in])\n"
        "      translate([cx, cy, -1]) cylinder(h = block_h + 2, d = mnt_d);"
    )
    feats_ru = [
        f"{n_ports} {_plural(n_ports, 'порт', 'порта', 'портов')} d{fmt(port_d)} мм с шагом {fmt(port_pitch)} мм",
        f"верхняя галерея шириной {fmt(gallery_d)} мм глубиной {fmt(gallery_depth)} мм",
    ]
    feats_en = [
        f"{n_ports} ports, d{fmt(port_d)} mm on a {fmt(port_pitch)} mm pitch",
        f"a {fmt(gallery_d)} mm top gallery, {fmt(gallery_depth)} mm deep",
    ]
    if variant == "side_outlet":
        out_d = rng.grid([10.0, 12.0])
        out_z = rng.grid([8.0, 10.0])
        if out_d / 2 + 1.5 > out_z or out_d / 2 > block_w / 2 - 1.5:
            raise ValueError("outlet breaks the block wall")
        # the outlet axis passes the block centre: with an even port count the
        # nearest ports sit at pitch/2 - the crossing must be transversal
        nearest = 0.0 if n_ports % 2 else port_pitch / 2
        if not nearest + 0.5 < (port_d + out_d) / 2:
            raise ValueError("outlet misses or grazes the port row")
        builder.param("out_d", out_d, "outlet bore diameter")
        builder.param("out_z", out_z, "outlet axis height")
        params["out_d"] = out_d
        params["out_z"] = out_z
        tool.append(
            "  translate([block_l / 2, -1, out_z]) rotate([-90, 0, 0])\n"
            "    cylinder(h = block_w + 2, d = out_d);"
        )
        feats_ru.append(f"боковой выход d{fmt(out_d)} мм на высоте {fmt(out_z)} мм")
        feats_en.append(f"a side outlet, d{fmt(out_d)} mm at {fmt(out_z)} mm height")
    builder.section(
        "difference() {\n"
        "  cube([block_l, block_w, block_h]);\n"
        + "\n".join(tool)
        + "\n}"
    )
    feats_ru.append(f"монтажные отверстия d{fmt(mnt_d)} мм по углам, отступ {fmt(mnt_in)} мм")
    feats_en.append(f"corner mounting holes, d{fmt(mnt_d)} mm, {fmt(mnt_in)} mm inset")
    bbox = (block_l, block_w, block_h)
    return _finish(rng, "manifoldblock", variant, builder, bbox, params,
                   "распределительный коллектор", "a manifold block",
                   feats_ru, feats_en)


# ---------------------------------------------------------------------------
# 3. controlknob: panel knobs
# ---------------------------------------------------------------------------


def build_controlknob(index: int) -> Part:
    rng = Rng("solid2_controlknob", index)
    variant = rng.choice(("pointer", "dimpled", "skirt"))
    knob_d = rng.grid([30.0, 35.0, 40.0, 45.0, 50.0])
    knob_h = rng.grid([14.0, 16.0, 18.0, 20.0])
    bore_d = rng.grid([4.0, 5.0, 6.0])
    set_d = rng.grid([3.0, 3.5])
    params: dict[str, float] = {"knob_d": knob_d, "knob_h": knob_h,
                                "bore_d": bore_d, "set_d": set_d}

    feats_ru = [f"корпус d{fmt(knob_d)} мм высотой {fmt(knob_h)} мм",
                f"посадочное отверстие d{fmt(bore_d)} мм и стопорный винт d{fmt(set_d)} мм"]
    feats_en = [f"body d{fmt(knob_d)} mm, {fmt(knob_h)} mm tall",
                f"a d{fmt(bore_d)} mm bore with a d{fmt(set_d)} mm set screw"]

    # bore + set screw: the screw opens on +X and breaks into the bore, so the
    # cut never splits the knob (material stays above and below the cut plane)
    body_tool = (
        "  translate([0, 0, -1]) cylinder(h = knob_h + 2, d = bore_d);\n"
        "  translate([-1, 0, knob_h / 2]) rotate([0, 90, 0])\n"
        "    cylinder(h = knob_d / 2 + bore_d / 2 + 2, d = set_d);"
    )
    if variant == "pointer":
        rib_w = rng.grid([3.0, 4.0])
        rib_h = rng.grid([4.0, 5.0])
        builder = ScadBuilder("Control knob", "pointer knob")
        builder.param("rib_w", rib_w, "pointer rib width")
        builder.param("rib_h", rib_h, "pointer rib height")
        builder.assignment("rib_poke = rib_h - 1;  // rib height above the top")
        builder.assignment("total_h = knob_h + rib_h - 1;  // overall height")
        params.update({"rib_w": rib_w, "rib_h": rib_h})
        # rib sinks 1 mm into the top face: volume overlap, no tangency
        builder.section(
            "difference() {\n"
            "  union() {\n"
            "    cylinder(h = knob_h, d = knob_d);\n"
            "    translate([-rib_w / 2, 0, knob_h - 1])\n"
            "      cube([rib_w, knob_d / 2 - 2, rib_h]);\n"
            "  }\n"
            + body_tool +
            "}"
        )
        bbox = (knob_d, knob_d, _r2(knob_h + rib_h - 1))
        feats_ru.append(f"указательное ребро шириной {fmt(rib_w)} мм, выступает на {fmt(_r2(rib_h - 1))} мм")
        feats_en.append(f"a pointer rib {fmt(rib_w)} mm wide, standing {fmt(_r2(rib_h - 1))} mm proud")
    elif variant == "dimpled":
        dimp_d = rng.grid([4.0, 5.0])
        n_dimp = int(rng.choice((5.0, 6.0, 8.0)))
        dimp_r = _r2(knob_d / 2 - dimp_d / 2 - 2.0)
        builder = ScadBuilder("Control knob", "dimpled knob")
        builder.param("dimp_d", dimp_d, "finger dimple diameter")
        builder.param("n_dimp", float(n_dimp), "number of dimples")
        builder.param("dimp_r", dimp_r, "dimple ring radius")
        builder.assignment("dimp_step = 360 / n_dimp;  // dimple angular step")
        params.update({"dimp_d": dimp_d, "n_dimp": float(n_dimp), "dimp_r": dimp_r})
        builder.section(
            "difference() {\n"
            "  cylinder(h = knob_h, d = knob_d);\n"
            + body_tool +
            "  for (i = [0 : n_dimp - 1])\n"
            "    rotate([0, 0, i * dimp_step])\n"
            "      translate([dimp_r, 0, knob_h - 1])\n"
            "        cylinder(h = 2, d = dimp_d);\n"
            "}"
        )
        bbox = (knob_d, knob_d, knob_h)
        feats_ru.append(f"{n_dimp} {_plural(n_dimp, 'ямка', 'ямки', 'ямок')} под палец d{fmt(dimp_d)} мм по радиусу {fmt(dimp_r)} мм")
        feats_en.append(f"{n_dimp} finger dimples, d{fmt(dimp_d)} mm on a {fmt(dimp_r)} mm ring")
    else:
        skirt_d = knob_d + rng.grid([10.0, 12.0])
        skirt_t = rng.grid([4.0, 5.0])
        rib_w = rng.grid([4.0, 5.0])
        rib_out = rng.grid([2.5, 3.0])
        n_ribs = int(rng.choice((10.0, 12.0, 14.0)))
        builder = ScadBuilder("Control knob", "skirt knob with grip ribs")
        builder.param("skirt_d", skirt_d, "skirt diameter")
        builder.param("skirt_t", skirt_t, "skirt thickness")
        builder.param("rib_w", rib_w, "grip rib width")
        builder.param("rib_out", rib_out, "grip rib radial protrusion")
        builder.param("n_ribs", float(n_ribs), "number of grip ribs")
        builder.assignment("rib_step = 360 / n_ribs;  // rib angular step")
        builder.assignment("total_h = skirt_t + knob_h;  // overall height")
        params.update({"skirt_d": skirt_d, "skirt_t": skirt_t, "rib_w": rib_w,
                       "rib_out": rib_out, "n_ribs": float(n_ribs)})
        # ribs start 1 mm inside the body wall: volume overlap all the way up
        builder.section(
            "difference() {\n"
            "  union() {\n"
            "    translate([0, 0, skirt_t]) cylinder(h = knob_h, d = knob_d);\n"
            "    cylinder(h = skirt_t, d = skirt_d);\n"
            "    for (i = [0 : n_ribs - 1])\n"
            "      rotate([0, 0, i * rib_step])\n"
            "        translate([knob_d / 2 - 1, -rib_w / 2, skirt_t])\n"
            "          cube([rib_out, rib_w, knob_h]);\n"
            "  }\n"
            "  translate([0, 0, skirt_t - 1]) cylinder(h = knob_h + 2, d = bore_d);\n"
            "  translate([-1, 0, skirt_t + knob_h / 2]) rotate([0, 90, 0])\n"
            "    cylinder(h = knob_d / 2 + bore_d / 2 + 2, d = set_d);\n"
            "}"
        )
        total_h = _r2(skirt_t + knob_h)
        # the skirt itself is the widest feature: ribs stay inside its diameter
        bbox = (skirt_d, skirt_d, total_h)
        feats_ru = [
            f"юбка d{fmt(skirt_d)} мм толщиной {fmt(skirt_t)} мм",
            f"{n_ribs} {_plural(n_ribs, 'ребро', 'ребра', 'ребер')} хвата, выступают на {fmt(rib_out)} мм",
        ]
        feats_en = [
            f"a d{fmt(skirt_d)} mm skirt, {fmt(skirt_t)} mm thick",
            f"{n_ribs} grip ribs protruding {fmt(rib_out)} mm",
        ]
    for name, value, comment in (
        ("knob_d", knob_d, "knob body diameter"),
        ("knob_h", knob_h, "knob body height"),
        ("bore_d", bore_d, "shaft bore diameter"),
        ("set_d", set_d, "set screw bore diameter"),
    ):
        if not any(existing == name for existing, _, _ in builder.declarations):
            builder.param(name, value, comment)
    return _finish(rng, "controlknob", variant, builder, bbox, params,
                   "ручку управления", "a control knob", feats_ru, feats_en)


# ---------------------------------------------------------------------------
# 4. drilljig: guide-boss drill jigs
# ---------------------------------------------------------------------------


def build_drilljig(index: int) -> Part:
    rng = Rng("solid2_drilljig", index)
    variant = rng.choice(("two_boss", "three_boss_slot", "fence"))
    plate_l = rng.grid([90.0, 100.0, 110.0, 120.0])
    plate_w = rng.grid([60.0, 70.0, 80.0])
    plate_t = rng.grid([8.0, 10.0, 12.0])
    boss_h = rng.grid([10.0, 12.0, 15.0])
    boss_d = rng.grid([16.0, 18.0, 20.0])
    guide_d = rng.grid([5.0, 6.0, 8.0])
    if guide_d / 2 + 2.0 > boss_d / 2:
        raise ValueError("guide hole breaks the boss wall")
    n_boss = 3 if variant == "three_boss_slot" else 2
    boss_pitch = rng.grid([30.0, 35.0, 40.0])
    if (n_boss - 1) * boss_pitch + boss_d > plate_l - 8:
        raise ValueError("boss row does not fit the plate")

    builder = ScadBuilder("Drill jig", f"{variant} jig")
    params: dict[str, float] = {}
    for name, value, comment in (
        ("plate_l", plate_l, "plate length, X"),
        ("plate_w", plate_w, "plate width, Y"),
        ("plate_t", plate_t, "plate thickness"),
        ("boss_d", boss_d, "guide boss diameter"),
        ("boss_h", boss_h, "boss height above the plate"),
        ("guide_d", guide_d, "guide hole diameter"),
        ("boss_pitch", boss_pitch, "boss pitch"),
    ):
        builder.param(name, value, comment)
        params[name] = value
    builder.assignment(f"n_boss = {n_boss};  // guide bosses")
    builder.assignment("boss_x0 = (plate_l - (n_boss - 1) * boss_pitch) / 2;  // first boss X")
    builder.assignment("boss_top = plate_t - 1 + boss_h;  // boss crown height")
    params["n_boss"] = float(n_boss)

    solid = [
        "  cube([plate_l, plate_w, plate_t]);",
        # bosses sink 1 mm into the plate
        "  for (i = [0 : n_boss - 1])\n"
        "    translate([boss_x0 + i * boss_pitch, plate_w / 2, plate_t - 1])\n"
        "      cylinder(h = boss_h, d = boss_d);",
    ]
    tool = [
        "  for (i = [0 : n_boss - 1])\n"
        "    translate([boss_x0 + i * boss_pitch, plate_w / 2, -1])\n"
        "      cylinder(h = plate_t + boss_h, d = guide_d);"
    ]
    feats_ru = [
        f"{n_boss} {_plural(n_boss, 'бобышка', 'бобышки', 'бобышек')} d{fmt(boss_d)} мм высотой {fmt(boss_h)} мм с шагом {fmt(boss_pitch)} мм",
        f"направляющие отверстия d{fmt(guide_d)} мм сквозь плиту",
    ]
    feats_en = [
        f"{n_boss} guide bosses, d{fmt(boss_d)} mm, {fmt(boss_h)} mm tall on a {fmt(boss_pitch)} mm pitch",
        f"through guide holes, d{fmt(guide_d)} mm",
    ]
    if variant == "three_boss_slot":
        slot_w = rng.grid([6.0, 8.0])
        slot_l = rng.grid([22.0, 26.0])
        slot_x = rng.grid([12.0, 14.0])
        if slot_x < 4 or slot_x + slot_l > plate_l - 4:
            raise ValueError("clamp slot breaks the plate edge")
        builder.param("slot_w", slot_w, "clamp slot width")
        builder.param("slot_l", slot_l, "clamp slot length")
        builder.param("slot_x", slot_x, "slot start X")
        params.update({"slot_w": slot_w, "slot_l": slot_l, "slot_x": slot_x})
        tool.append(
            "  for (cy = [plate_w * 0.25, plate_w * 0.75])\n"
            "    translate([slot_x, cy - slot_w / 2, -1])\n"
            "      cube([slot_l, slot_w, plate_t + 2]);"
        )
        feats_ru.append(f"два прижимных паза {fmt(slot_l)} x {fmt(slot_w)} мм")
        feats_en.append(f"two clamp slots, {fmt(slot_l)} x {fmt(slot_w)} mm")
    if variant == "fence":
        fence_h = rng.grid([15.0, 18.0, 20.0])
        fence_t = rng.grid([8.0, 10.0])
        builder.param("fence_h", fence_h, "fence height above the plate")
        builder.param("fence_t", fence_t, "fence thickness")
        params.update({"fence_h": fence_h, "fence_t": fence_t})
        # fence sinks 1 mm into the plate
        solid.append(
            "  translate([0, 0, plate_t - 1]) cube([plate_l, fence_t, fence_h]);"
        )
        feats_ru.append(f"упорная стенка высотой {fmt(fence_h)} мм толщиной {fmt(fence_t)} мм")
        feats_en.append(f"a fence wall {fmt(fence_h)} mm tall, {fmt(fence_t)} mm thick")
    builder.section(
        "difference() {\n"
        "  union() {\n" + "\n".join(solid) + "\n  }\n"
        + "\n".join(tool) + "\n}"
    )
    if variant == "fence":
        builder.assignment("fence_top = plate_t - 1 + fence_h;  // fence crown height")
        builder.assignment("total_h = max([fence_top, boss_top]);  // overall height")
        bbox = (plate_l, plate_w, _r2(plate_t - 1 + max(fence_h, boss_h)))
    else:
        builder.assignment("total_h = boss_top;  // overall height")
        bbox = (plate_l, plate_w, _r2(plate_t - 1 + boss_h))
    return _finish(rng, "drilljig", variant, builder, bbox, params,
                   "сверлильный кондуктор", "a drill jig", feats_ru, feats_en)


# ---------------------------------------------------------------------------
# 5. ventbox: vented enclosure shells
# ---------------------------------------------------------------------------


def build_ventbox(index: int) -> Part:
    rng = Rng("solid2_ventbox", index)
    variant = rng.choice(("louvers", "crossgrid", "roundvent"))
    box_l = rng.grid([90.0, 100.0, 110.0, 120.0])
    box_w = rng.grid([70.0, 80.0, 90.0])
    box_h = rng.grid([45.0, 50.0, 60.0])
    wall_t = rng.grid([2.0, 2.5, 3.0])
    win_l = rng.grid([40.0, 50.0, 60.0])
    win_h = rng.grid([24.0, 28.0, 32.0])
    if win_l + 2 * (wall_t + 3) > box_l or win_h + 2 * (wall_t + 3) > box_h:
        raise ValueError("window breaks the shell walls")

    builder = ScadBuilder("Vent box", f"{variant} enclosure")
    params: dict[str, float] = {}
    base_params = [
        ("box_l", box_l, "box length, X"),
        ("box_w", box_w, "box width, Y"),
        ("box_h", box_h, "box height, Z"),
        ("wall_t", wall_t, "shell wall thickness"),
    ]
    if variant != "roundvent":
        base_params += [
            ("win_l", win_l, "vent window width, X"),
            ("win_h", win_h, "vent window height, Z"),
        ]
    for name, value, comment in base_params:
        builder.param(name, value, comment)
        params[name] = value
    cavity_tool = (
        "  translate([wall_t, wall_t, wall_t])\n"
        "    cube([box_l - 2 * wall_t, box_w - 2 * wall_t, box_h]);"
    )
    window_tool = (
        "  translate([(box_l - win_l) / 2, box_w - wall_t - 1, win_z0])\n"
        "    cube([win_l, wall_t + 2, win_h]);"
    )
    feats_ru = [f"короб {fmt(box_l)} x {fmt(box_w)} x {fmt(box_h)} мм со стенкой {fmt(wall_t)} мм"]
    feats_en = [f"shell {fmt(box_l)} x {fmt(box_w)} x {fmt(box_h)} mm, walls {fmt(wall_t)} mm"]

    if variant == "louvers":
        slat_t = rng.grid([2.0, 2.5])
        slat_d = rng.grid([8.0, 10.0])
        slat_a = rng.grid([35.0, 40.0, 45.0])
        pitch = rng.grid([10.0, 12.0, 14.0])
        rad = math.radians(slat_a)
        proj = slat_d * math.sin(rad) + slat_t * math.cos(rad)
        if pitch < proj + 1.2:
            raise ValueError("louver slats would overlap")
        n_slats = int(win_h // pitch)
        if n_slats < 2:
            raise ValueError("too few slats")
        # rotated footprint in Y; the top slat edge bites 1 mm into the back
        # wall so every slat is anchored outside the window cut
        y_half = (slat_d * math.cos(rad) + slat_t * math.sin(rad)) / 2
        yc = _r2(box_w - wall_t + 1.0 - y_half)
        builder.param("slat_t", slat_t, "louver slat thickness")
        builder.param("slat_d", slat_d, "louver slat depth")
        builder.param("slat_a", slat_a, "louver slat angle, degrees")
        builder.param("slat_pitch", pitch, "louver pitch")
        builder.param("slat_yc", yc, "slat centreline Y")
        builder.assignment("win_z0 = (box_h - win_h) / 2;  // window lower edge Z")
        builder.assignment(f"n_slats = {n_slats};  // louver count")
        builder.assignment("slat_z0 = win_z0 + (win_h - (n_slats - 1) * slat_pitch) / 2;")
        params.update({"slat_t": slat_t, "slat_d": slat_d, "slat_a": slat_a,
                       "slat_pitch": pitch, "slat_yc": yc, "n_slats": float(n_slats)})
        builder.section(
            "difference() {\n"
            "  union() {\n"
            "    difference() {\n"
            "      cube([box_l, box_w, box_h]);\n"
            + cavity_tool + "\n"
            + window_tool + "\n"
            "    }\n"
            # slats span the window plus 0.5 mm into the frame on each side;
            # the window cut happened before the union, so slats survive
            "    for (i = [0 : n_slats - 1])\n"
            "      translate([box_l / 2, slat_yc, slat_z0 + i * slat_pitch])\n"
            "        rotate([slat_a, 0, 0])\n"
            "          cube([win_l + 1, slat_d, slat_t], center = true);\n"
            "  }\n"
            "}"
        )
        feats_ru.append(f"вентиляционное окно {fmt(win_l)} x {fmt(win_h)} мм в задней стенке")
        feats_en.append(f"a {fmt(win_l)} x {fmt(win_h)} mm vent window in the back wall")
        feats_ru.append(f"{n_slats} {_plural(n_slats, 'жалюзи', 'жалюзи', 'жалюзи')} под углом {fmt(slat_a)}° с шагом {fmt(pitch)} мм")
        feats_en.append(f"{n_slats} louver slats at {fmt(slat_a)} deg on a {fmt(pitch)} mm pitch")
    elif variant == "crossgrid":
        bar_w = rng.grid([4.0, 5.0])
        n_v = int(rng.choice((3.0, 4.0, 5.0)))
        v_step = win_l / (n_v + 1)
        n_h = int(rng.choice((2.0, 3.0)))
        h_step = win_h / (n_h + 1)
        if v_step < bar_w + 3 or h_step < bar_w + 3:
            raise ValueError("grid bars too dense")
        builder.param("bar_w", bar_w, "grid bar width")
        builder.param("n_v", float(n_v), "vertical bar count")
        builder.param("n_h", float(n_h), "horizontal bar count")
        builder.assignment("win_z0 = (box_h - win_h) / 2;  // window lower edge Z")
        builder.assignment("v_step = win_l / (n_v + 1);  // vertical bar step")
        builder.assignment("h_step = win_h / (n_h + 1);  // horizontal bar step")
        params.update({"bar_w": bar_w, "n_v": float(n_v), "n_h": float(n_h)})
        # bars bite 1 mm into the frame (top/bottom or sides) and end flush
        # with the outer face, so nothing protrudes past the shell
        builder.section(
            "difference() {\n"
            "  union() {\n"
            "    difference() {\n"
            "      cube([box_l, box_w, box_h]);\n"
            + cavity_tool + "\n"
            + window_tool + "\n"
            "    }\n"
            "    for (i = [1 : n_v])\n"
            "      translate([(box_l - win_l) / 2 + i * v_step - bar_w / 2,\n"
            "                 box_w - wall_t - 1, win_z0 - 1])\n"
            "        cube([bar_w, wall_t + 1, win_h + 2]);\n"
            "    for (i = [1 : n_h])\n"
            "      translate([(box_l - win_l) / 2 - 1, box_w - wall_t - 1,\n"
            "                 win_z0 + i * h_step - bar_w / 2])\n"
            "        cube([win_l + 2, wall_t + 1, bar_w]);\n"
            "  }\n"
            "}"
        )
        feats_ru.append(f"вентиляционное окно {fmt(win_l)} x {fmt(win_h)} мм в задней стенке")
        feats_en.append(f"a {fmt(win_l)} x {fmt(win_h)} mm vent window in the back wall")
        feats_ru.append(
            f"решётка: {n_v} {_plural(n_v, 'планка', 'планки', 'планок')} вертикально и {n_h} горизонтально, ширина {fmt(bar_w)} мм"
        )
        feats_en.append(f"a grid of {n_v} vertical and {n_h} horizontal bars, {fmt(bar_w)} mm wide")
    else:
        vent_d = rng.grid([20.0, 24.0, 28.0])
        ring_d = rng.grid([5.0, 6.0])
        n_ring = int(rng.choice((6.0, 8.0)))
        ring_r = _r2(vent_d / 2 + ring_d / 2 + 3.0)
        if ring_r + ring_d / 2 + 1.5 > min(box_l, box_h) / 2:
            raise ValueError("ring holes break the shell")
        builder.param("vent_d", vent_d, "central vent diameter")
        builder.param("ring_d", ring_d, "ring hole diameter")
        builder.param("n_ring", float(n_ring), "holes in the ring")
        builder.param("ring_r", ring_r, "ring radius")
        builder.assignment("ring_step = 360 / n_ring;  // ring hole angular step")
        params.update({"vent_d": vent_d, "ring_d": ring_d, "n_ring": float(n_ring),
                       "ring_r": ring_r})
        # round vent: no window - the holes pierce the solid back wall
        builder.section(
            "difference() {\n"
            "  cube([box_l, box_w, box_h]);\n"
            + cavity_tool + "\n"
            "  translate([box_l / 2, box_w - wall_t - 1, box_h / 2])\n"
            "    rotate([-90, 0, 0]) cylinder(h = wall_t + 2, d = vent_d);\n"
            "  for (i = [0 : n_ring - 1])\n"
            "    translate([box_l / 2, box_w - wall_t - 1, box_h / 2])\n"
            "      rotate([0, 0, i * ring_step])\n"
            "        translate([ring_r, 0, 0]) rotate([-90, 0, 0])\n"
            "          cylinder(h = wall_t + 2, d = ring_d);\n"
            "}"
        )
        feats_ru.append(
            f"центральное отверстие d{fmt(vent_d)} мм и {n_ring} "
            f"{_plural(n_ring, 'отверстие', 'отверстия', 'отверстий')} d{fmt(ring_d)} мм по радиусу {fmt(ring_r)} мм в задней стенке"
        )
        feats_en.append(
            f"a d{fmt(vent_d)} mm central vent ringed by {n_ring} holes, "
            f"d{fmt(ring_d)} mm at R{fmt(ring_r)} mm in the back wall"
        )
    bbox = (box_l, box_w, box_h)
    return _finish(rng, "ventbox", variant, builder, bbox, params,
                   "вентилируемый корпус", "a vented enclosure box",
                   feats_ru, feats_en)


FAMILY_BUILDERS = {
    "heatsink": build_heatsink,
    "manifoldblock": build_manifoldblock,
    "controlknob": build_controlknob,
    "drilljig": build_drilljig,
    "ventbox": build_ventbox,
}
