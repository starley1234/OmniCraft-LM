"""Sketch families: closed profiles that are revolved or extruded.

These samples teach the other half of OpenSCAD modelling: build a 2D sketch
(``polygon``) and turn it into a solid with ``rotate_extrude`` /
``linear_extrude`` instead of stacking primitives.
"""

from __future__ import annotations

import math

from tools.dataset_gen2.common import Part, Rng, ScadBuilder, finish_part, fmt
from tools.dataset_gen2.prompts import en_count, ru_count

SHAFT_RU = (
    "ступенчатый вал", "вал с канавками", "шлицевой вал-заготовка", "ось со ступенями",
    "вал под подшипники", "ступенчатая ось",
)
SHAFT_EN = (
    "stepped shaft", "shouldered shaft", "grooved shaft", "bearing shaft",
    "stepped axle", "shoulder spindle",
)
FLANGE_RU = (
    "фланец с отверстиями по окружности", "крепёжный фланец", "фланец под болтовой круг",
    "приварной фланец", "фланец-основание", "круглый фланец со ступицей",
)
FLANGE_EN = (
    "bolt-circle flange", "mounting flange", "flange plate", "flanged base",
    "bolted flange", "round flange",
)
HANDLE_RU = (
    "ручка для переноски", "эргономичная рукоятка", "ручка с бобышкой",
    "рукоятка для ящика", "ручка-скоба", "захват для крышки",
)
HANDLE_EN = (
    "carry handle", "ergonomic handle", "cabinet handle", "grip handle",
    "drawer pull", "tool handle blank",
)


# ---------------------------------------------------------------------------
# stepped shafts
# ---------------------------------------------------------------------------

STEP_TABLE = (8.0, 10.0, 12.0, 14.0, 16.0, 20.0, 25.0, 30.0, 40.0, 50.0)


def build_stepped_shafts(index: int) -> Part:
    rng = Rng("stepped_shafts", index)
    steps = rng.choice([3, 3, 4, 4, 5])
    diameters: list[float] = []
    available = list(STEP_TABLE)
    for _ in range(steps):
        choice = rng.choice(available)
        diameters.append(choice)
        keep = [value for value in available if value != choice]
        available = keep or list(STEP_TABLE)
    diameters.sort(reverse=True)
    lengths = [round(rng.grid([10.0, 15.0, 20.0, 25.0, 30.0, 40.0]), 1) for _ in range(steps)]
    total = round(sum(lengths), 2)
    if total > 240.0:
        scale = 240.0 / total
        lengths = [round(value * scale, 1) for value in lengths]
        total = round(sum(lengths), 2)
    # the chamfers are cut with a revolved ring, so the ring has to keep clear
    # of the axis by at least 1.2 mm on the small end
    chamfer = rng.grid([1.0, 1.5, 2.0, 2.5])
    chamfer = round(max(0.6, min(chamfer, diameters[0] * 0.08, diameters[-1] / 2 - 1.2)), 2)

    groove = rng.chance(0.6)
    groove_w = rng.grid([2.0, 2.5, 3.0, 3.5]) if groove else 0.0
    groove_depth = rng.grid([1.0, 1.3, 1.6, 2.0]) if groove else 0.0
    groove_index = rng.integer(0, steps - 2) if groove else 0
    keyway = rng.chance(0.45)
    key_w = rng.grid([4.0, 5.0, 6.0, 8.0]) if keyway else 0.0
    key_depth = round(key_w * 0.5, 2) if keyway else 0.0
    key_len = rng.grid([20.0, 25.0, 30.0, 40.0]) if keyway else 0.0
    cross_hole = rng.chance(0.45)
    cross_d = rng.grid([4.0, 5.0, 6.0, 8.0]) if cross_hole else 0.0

    # where each step starts along the shaft
    offsets = [0.0]
    for length in lengths[:-1]:
        offsets.append(round(offsets[-1] + length, 2))
    # the keyway is milled into the first (largest) step, clear of the chamfer
    if keyway:
        key_len = round(min(key_len, lengths[0] - chamfer - 6.0), 2)
        key_z = round(chamfer + 2.0, 2)
        if key_len < 10.0 or key_z + key_len > lengths[0] - 1.0:
            keyway = False
    # the circlip groove is turned into the smaller step, a couple of mm behind
    # the shoulder - inside the bigger step it would leave a floating ring
    groove_radius = round(diameters[groove_index + 1] / 2, 2) if groove else 0.0
    groove_z = round(offsets[groove_index + 1] + 2.0, 2) if groove else 0.0
    groove_limit = round(offsets[groove_index + 1] + lengths[groove_index + 1] - 2.0, 2)
    if groove and groove_z + groove_w > groove_limit:
        groove = False
    if groove:
        # the core left under the groove has to stay solid: >= 2.6 mm of radius
        groove_depth = round(min(groove_depth, groove_radius - 2.6), 2)
        if groove_depth < 1.0:
            groove = False
    # the pin hole goes through the step that keeps the most material around it
    cross_step = steps - 1
    if groove and groove_index + 1 == steps - 1:
        cross_step = 0
    if cross_hole:
        carries_groove = groove and groove_index + 1 == cross_step
        core_d = 2 * (groove_radius - groove_depth) if carries_groove else diameters[cross_step]
        cross_d = round(min(cross_d, core_d - 4.0), 2)
        if cross_d < 3.0 or lengths[cross_step] < cross_d + 4.0:
            cross_hole = False
        else:
            cross_z = round(offsets[cross_step] + lengths[cross_step] / 2, 2)

    builder = ScadBuilder(
        "Stepped shaft",
        f"diameters {', '.join(fmt(value) for value in diameters)} mm, {fmt(total)} mm long",
    )
    for position, (diameter, length) in enumerate(zip(diameters, lengths), start=1):
        builder.param(f"d{position}", diameter, f"step {position} diameter")
        builder.param(f"len{position}", length, f"step {position} length")
    builder.param("total", total, "overall length")
    builder.param("chamfer", chamfer, "end chamfer")
    if groove:
        builder.param("groove_r", groove_radius, "groove radius")
        builder.param("groove_z", groove_z, "groove position from the end")
        builder.param("groove_w", groove_w, "groove width")
        builder.param("groove_d", groove_depth, "groove depth")
    if keyway:
        builder.param("key_w", key_w, "keyway width")
        builder.param("key_d", key_depth, "keyway depth")
        builder.param("key_len", key_len, "keyway length")
        builder.param("key_z", key_z, "keyway start along the shaft")
    if cross_hole:
        builder.param("cross_d", cross_d, "cross pin hole")
        builder.param("cross_z", cross_z, "cross hole position")

    # Body: a stack of cylinders, every smaller step sunk 0.4 mm into the bigger
    # one so the joints overlap.  Nothing is revolved around the axis here: a
    # rotate_extrude whose profile touches the axis is what produced the broken
    # meshes in the previous delivery, so the turned shape is built from
    # primitives and only the chamfers and the groove are ring cuts that stay
    # clear of the axis.
    lines = [
        "difference() {",
        "  /* turned body: stacked cylinders, every step sunk into the bigger one */",
        "  union() {",
        "    cylinder(h = len1, d = d1);",
    ]
    for position in range(2, steps + 1):
        start = round(offsets[position - 1] - 0.4, 2)
        height = round(lengths[position - 1] + 0.4, 2)
        lines.append(
            f"    translate([0, 0, {fmt(start, 2)}])"
            f" cylinder(h = {fmt(height, 2)}, d = d{position});"
        )
    lines.append("  }")
    # the ring cuts run 2.5 mm past the body and stay 1.2 mm off the axis
    bottom_r = round(diameters[0] / 2 - chamfer, 3)
    wide = round(chamfer + 2.5, 3)
    lines.append("  /* bottom chamfer ring cut */")
    lines.append(
        f"  rotate_extrude() translate([{fmt(bottom_r, 3)}, -2.5])"
        f" polygon([[0, 0], [{fmt(wide, 3)}, 0],"
        f" [{fmt(wide, 3)}, {fmt(round(chamfer + 5.0, 3), 3)}], [0, 2.5]]);"
    )
    top_r = round(diameters[-1] / 2 - chamfer, 3)
    lines.append("  /* top chamfer ring cut */")
    lines.append(
        f"  rotate_extrude() translate([{fmt(top_r, 3)}, {fmt(total, 2)}])"
        f" polygon([[0, 0], [{fmt(wide, 3)}, {fmt(round(-chamfer - 2.5, 3), 3)}],"
        f" [{fmt(wide, 3)}, 2.5], [0, 2.5]]);"
    )
    if groove:
        lines.append("  /* circlip groove just behind the shoulder */")
        lines.append(
            "  rotate_extrude() translate([groove_r - groove_d, groove_z])"
            " square([groove_d + 2.5, groove_w]);"
        )
    if keyway:
        lines.append("  /* keyway milled along the first step */")
        lines.append(
            "  translate([d1 / 2 - key_d, -key_w / 2, key_z])"
            " cube([key_d + 2.5, key_w, key_len]);"
        )
    if cross_hole:
        lines.append("  /* cross pin hole through the small step */")
        lines.append(
            "  translate([0, 0, cross_z]) rotate([90, 0, 0])"
            " cylinder(h = d" + str(cross_step + 1) + " + 5, d = cross_d, center = true);"
        )
    lines.append("}")
    builder.section("\n".join(lines))
    code = builder.render()

    bbox = (float(diameters[0]), float(diameters[0]), float(total))
    features_ru = [
        f"{ru_count(steps, 'ступень', 'ступени', 'ступеней')} диаметрами "
        + ", ".join(fmt(value) + " мм" for value in diameters),
        f"общая длина {fmt(total)} мм",
        f"фаска {fmt(chamfer)} мм по торцам",
    ]
    features_en = [
        f"{en_count(steps)} steps of " + ", ".join(fmt(value) + " mm" for value in diameters),
        f"{fmt(total)} mm overall length",
        f"{fmt(chamfer)} mm chamfers on the ends",
    ]
    if groove:
        features_ru.append(f"канавка {fmt(groove_w)}x{fmt(groove_depth)} мм под стопорное кольцо")
        features_en.append(f"a {fmt(groove_w)}x{fmt(groove_depth)} mm circlip groove")
    if keyway:
        features_ru.append(f"шпоночный паз {fmt(key_w)}x{fmt(key_depth)} мм длиной {fmt(key_len)} мм")
        features_en.append(f"a {fmt(key_w)}x{fmt(key_depth)} mm keyway, {fmt(key_len)} mm long")
    if cross_hole:
        features_ru.append(f"поперечное отверстие {fmt(cross_d)} мм под штифт")
        features_en.append(f"a {fmt(cross_d)} mm cross pin hole")
    return finish_part(
        rng,
        family="shafts",
        variant=f"{steps}steps",
        code=code,
        bbox=bbox,
        params={
            "max_d": float(diameters[0]),
            "total": total,
            "steps": steps,
            "chamfer": chamfer,
        },
        ru_nouns=SHAFT_RU,
        en_nouns=SHAFT_EN,
        features_ru=features_ru,
        features_en=features_en,
        feature_count=(3, 4),
    )


# ---------------------------------------------------------------------------
# bolt-circle flanges
# ---------------------------------------------------------------------------


def build_bolt_flanges(index: int) -> Part:
    rng = Rng("bolt_flanges", index)
    flange_d = rng.grid([60.0, 70.0, 80.0, 100.0, 120.0, 150.0, 180.0])
    flange_t = rng.grid([6.0, 8.0, 10.0, 12.0, 15.0])
    bolts = rng.choice([4, 4, 5, 6, 8])
    bolt_d = rng.grid([6.0, 7.0, 9.0, 11.0, 13.0])
    edge = round(max(6.0, bolt_d * 1.6), 2)
    bolt_r = round(flange_d / 2 - edge, 2)
    if bolt_r < bolt_d:
        bolt_r = round(flange_d / 2 - 2 * bolt_d, 2)
    bore_d = round(min(flange_d * 0.4, rng.grid([20.0, 25.0, 30.0, 40.0, 50.0])), 2)
    hub = rng.chance(0.75)
    hub_d = round(min(flange_d * 0.55, max(bore_d + 14.0, 30.0)), 2)
    hub_h = rng.grid([8.0, 10.0, 12.0, 15.0, 20.0]) if hub else 0.0
    spigot = rng.chance(0.5)
    spigot_d = round(min(bore_d + 12.0, flange_d * 0.6), 2) if spigot else 0.0
    spigot_h = rng.grid([3.0, 4.0, 5.0, 6.0]) if spigot else 0.0
    spot_face = rng.chance(0.5)
    spot_d = round(bolt_d + 6.0, 2) if spot_face else 0.0
    spot_h = 1.6 if spot_face else 0.0
    groove = rng.chance(0.4)
    groove_w = rng.grid([2.5, 3.0, 4.0]) if groove else 0.0
    groove_z = round(flange_t - 1.2, 2) if groove else 0.0
    groove_d = 1.4 if groove else 0.0

    spigot_sink = 1.0
    builder = ScadBuilder(
        "Bolt-circle flange",
        f"{fmt(flange_d)} mm outside, {bolt_n_text(bolts)} bolt holes, bore {fmt(bore_d)} mm",
    )
    builder.param("flange_d", flange_d, "flange outside diameter")
    builder.param("flange_t", flange_t, "flange thickness")
    builder.param("bolts", float(bolts), "number of bolt holes")
    builder.param("bolt_d", bolt_d, "bolt clearance")
    builder.param("bolt_r", bolt_r, "bolt circle radius")
    builder.param("bore_d", bore_d, "centre bore")
    if hub:
        builder.param("hub_d", hub_d, "raised hub diameter")
        builder.param("hub_h", hub_h, "raised hub height")
    if spigot:
        builder.param("spigot_d", spigot_d, "spigot diameter")
        builder.param("spigot_h", spigot_h, "spigot height below the flange")
        builder.param("sink", spigot_sink, "overlap into the flange")
    if spot_face:
        builder.param("spot_d", spot_d, "spot faced bosses")
        builder.param("spot_h", spot_h, "spot face height")
    groove_r = round(max(bore_d / 2 + 2.0, (hub_d / 2 if hub else 0.0) + 2.0), 2)
    if groove and groove_r + groove_w + 1.0 > bolt_r - bolt_d / 2:
        groove = False
    if groove:
        builder.param("groove_w", groove_w, "gasket groove width")
        builder.param("groove_d", groove_d, "gasket groove depth")
        builder.param("groove_r", groove_r, "groove radius")
        builder.param("groove_z", round(flange_t - groove_d, 2), "groove floor depth from the face")
    hub_term = " + hub_h" if hub else ""
    spigot_term = " + spigot_h" if spigot else ""
    cut_height = "flange_t" + hub_term + spigot_term + " + 3"
    cut_start = "-spigot_h - 1" if spigot else "-1"

    lines = ["module body() {", "  cylinder(h = flange_t, d = flange_d);"]
    if hub:
        lines.append(
            "  /* raised hub, sunk 1 mm into the flange */\n"
            "  translate([0, 0, flange_t - 1]) cylinder(h = hub_h + 1, d = hub_d);"
        )
    if spigot:
        lines.append(
            "  /* spigot on the back face, sunk into the flange */\n"
            "  translate([0, 0, -spigot_h + sink]) cylinder(h = spigot_h, d = spigot_d);"
        )
    if spot_face:
        lines.append(
            "  /* spot faced pads under the bolt heads */\n"
            "  for (i = [0 : bolts - 1]) rotate([0, 0, i * 360 / bolts])"
            " translate([bolt_r, 0, flange_t - 1]) cylinder(h = spot_h + 1, d = spot_d);"
        )
    lines.append("}")
    lines += ["", "difference() {", "  body();"]
    lines.append(
        "  /* bolt circle */\n"
        "  for (i = [0 : bolts - 1]) rotate([0, 0, i * 360 / bolts])"
        " translate([bolt_r, 0, " + cut_start + "]) cylinder(h = " + cut_height + ", d = bolt_d);"
    )
    lines.append(
        "  translate([0, 0, " + cut_start + "]) cylinder(h = " + cut_height + ", d = bore_d);"
    )
    if groove:
        lines.append(
            "  /* gasket groove on the front face */\n"
            "  rotate_extrude() translate([groove_r, groove_z]) square([groove_w, groove_d + 1]);"
        )
    lines.append("}")
    builder.section("\n".join(lines))
    code = builder.render()

    bottom = round(spigot_h - spigot_sink, 2) if spigot else 0.0
    top = round(flange_t + (hub_h if hub else 0.0), 2)
    if spot_face:
        top = max(top, round(flange_t + spot_h, 2))
    depth = round(top + bottom, 2)
    bbox = (float(flange_d), float(flange_d), depth)
    features_ru = [
        f"болтовой круг {ru_count(bolts, 'отверстие', 'отверстия', 'отверстий')} "
        f"{fmt(bolt_d)} мм на радиусе {fmt(bolt_r)} мм",
        f"центральное отверстие {fmt(bore_d)} мм",
        f"толщина фланца {fmt(flange_t)} мм",
    ]
    features_en = [
        f"a bolt circle of {en_count(bolts)} {fmt(bolt_d)} mm holes at radius {fmt(bolt_r)} mm",
        f"a {fmt(bore_d)} mm centre bore",
        f"{fmt(flange_t)} mm flange thickness",
    ]
    if hub:
        features_ru.append(f"ступица {fmt(hub_d)} мм высотой {fmt(hub_h)} мм")
        features_en.append(f"a {fmt(hub_d)} mm hub {fmt(hub_h)} mm tall")
    if spigot:
        features_ru.append(f"центрирующий бурт {fmt(spigot_d)} мм высотой {fmt(spigot_h)} мм")
        features_en.append(f"a {fmt(spigot_d)} mm centring spigot {fmt(spigot_h)} mm deep")
    if spot_face:
        features_ru.append("цековки под головки болтов")
        features_en.append("spot faced pads under the bolt heads")
    if groove:
        features_ru.append(f"канавка под прокладку {fmt(groove_w)} мм")
        features_en.append(f"a {fmt(groove_w)} mm gasket groove")
    return finish_part(
        rng,
        family="flanges",
        variant=f"{bolts}bolt",
        code=code,
        bbox=bbox,
        params={
            "flange_d": flange_d,
            "flange_t": flange_t,
            "bolts": bolts,
            "bolt_d": bolt_d,
            "bolt_r": bolt_r,
            "bore_d": bore_d,
            "depth": depth,
        },
        ru_nouns=FLANGE_RU,
        en_nouns=FLANGE_EN,
        features_ru=features_ru,
        features_en=features_en,
        feature_count=(3, 4),
    )


def bolt_n_text(count: int) -> str:
    return f"{count}"


def build_handles(index: int) -> Part:
    rng = Rng("handles", index)
    length = rng.grid([60.0, 80.0, 100.0, 120.0, 150.0, 180.0])
    width = rng.grid([22.0, 26.0, 30.0, 36.0, 42.0])
    thickness = rng.grid([10.0, 12.0, 14.0, 16.0, 20.0])
    waist = rng.grid([0.72, 0.8, 0.86])          # middle width factor
    scallops = rng.choice([0, 0, 4, 5, 6])       # finger rests
    ripple = rng.grid([0.04, 0.05, 0.06]) if scallops else 0.0
    draft = rng.grid([0.9, 0.94, 0.97])          # top face scale of the extrusion
    boss = rng.chance(0.7)
    boss_h = rng.grid([6.0, 8.0, 10.0]) if boss else 0.0
    boss_d = round(min(width * 1.05, 30.0), 2) if boss else 0.0
    boss_hole_d = round(min(boss_d * 0.42, 12.0), 2) if boss else 0.0
    boss_r = round(length / 2 - boss_d / 2 - 2.0, 2) if boss else 0.0
    half_w = round(width / 2, 3)
    straight = round(length / 2 - half_w, 3)
    samples = 16
    cap_samples = 6

    def boundary(position: float) -> float:
        """Half width of the grip at a position along its straight section."""
        norm = position / straight if straight > 0 else 0.0
        body = 1.0 - (1.0 - waist) * (1.0 - norm * norm)
        wave = 1.0 + ripple * math.cos(math.pi * scallops * norm) * (1.0 - norm * norm)
        return half_w * body * wave

    points: list[str] = []
    for step in range(samples + 1):
        x = round(-straight + 2 * straight * step / samples, 3)
        points.append(f"[{fmt(x, 3)}, {fmt(round(boundary(x), 3), 3)}]")
    for step in range(1, cap_samples + 1):
        # right end cap, swept from the top corner round to the bottom corner
        angle = math.pi / 2 - math.pi * step / cap_samples
        points.append(
            f"[{fmt(round(straight + half_w * math.cos(angle), 3), 3)},"
            f" {fmt(round(half_w * math.sin(angle), 3), 3)}]"
        )
    for step in range(samples + 1):
        x = round(straight - 2 * straight * step / samples, 3)
        points.append(f"[{fmt(x, 3)}, {fmt(round(-boundary(x), 3), 3)}]")
    for step in range(1, cap_samples + 1):
        # left end cap, swept from the bottom corner back round to the top
        angle = -math.pi / 2 + math.pi * step / cap_samples
        points.append(
            f"[{fmt(round(-straight - half_w * math.cos(angle), 3), 3)},"
            f" {fmt(round(half_w * math.sin(angle), 3), 3)}]"
        )

    builder = ScadBuilder(
        "Handle",
        f"{fmt(length)} x {fmt(width)} mm grip, {fmt(thickness)} mm thick",
    )
    builder.param("length", length, "grip length")
    builder.param("width", width, "grip width")
    builder.param("thickness", thickness, "grip thickness")
    builder.param("waist", waist, "width factor at the middle")
    builder.param("draft", draft, "top face scale of the extrusion")
    if scallops:
        builder.param("scallops", float(scallops), "finger rests per side")
        builder.param("ripple", ripple, "depth factor of the finger rests")
    if boss:
        builder.param("boss_d", boss_d, "mounting boss diameter")
        builder.param("boss_h", boss_h, "mounting boss height")
        builder.param("boss_hole_d", boss_hole_d, "screw clearance through the boss")
        builder.param("boss_r", boss_r, "boss centre from the grip centre")

    lines = [
        "/* ergonomic grip outline, closed spline-like polygon in the XY plane */",
        "grip = [" + ", ".join(points) + "];",
        "",
        "module grip_body() {",
        "  linear_extrude(height = thickness, scale = draft) polygon(grip);",
        "}",
    ]
    if boss:
        lines += [
            "",
            "module boss_body() {",
            "  /* sunk 1 mm into the grip so the joint overlaps */",
            "  translate([boss_r, 0, thickness - 1]) cylinder(h = boss_h + 1, d = boss_d);",
            "}",
        ]
    lines += ["", "difference() {", "  union() {", "    grip_body();"]
    if boss:
        lines.append("    boss_body();")
    lines.append("  }")
    if boss:
        lines.append(
            "  translate([boss_r, 0, -1]) cylinder(h = thickness + boss_h + 2, d = boss_hole_d);"
        )
    lines.append("}")
    builder.section("\n".join(lines))
    code = builder.render()

    height = round(thickness + boss_h, 2) if boss else float(thickness)
    width_total = round(max(width, boss_d), 2) if boss else round(width, 2)
    bbox = (round(length, 2), width_total, float(height))

    features_ru = [
        f"захват {fmt(length)}x{fmt(width)} мм толщиной {fmt(thickness)} мм",
        f"сужение до {fmt(waist * 100)} % в середине хвата",
        f"уклон боковых стенок {fmt(draft * 100)} %",
    ]
    features_en = [
        f"a {fmt(length)}x{fmt(width)} mm grip, {fmt(thickness)} mm thick",
        f"waisted to {fmt(waist * 100)} percent at the middle",
        f"side walls drafted to {fmt(draft * 100)} percent",
    ]
    if scallops:
        features_ru.append(f"{scallops} подпальцевых выемок по бокам")
        features_en.append(f"{scallops} finger rests per side")
    if boss:
        features_ru.append(
            f"бобышка {fmt(boss_d)} мм под винт {fmt(boss_hole_d)} мм на расстоянии {fmt(boss_r)} мм"
        )
        features_en.append(
            f"a {fmt(boss_d)} mm boss with a {fmt(boss_hole_d)} mm screw hole at {fmt(boss_r)} mm"
        )
    return finish_part(
        rng,
        family="handles",
        variant=f"{scallops}ribs" if scallops else "plain",
        code=code,
        bbox=bbox,
        params={
            "length": length,
            "width": width,
            "thickness": thickness,
            "waist": waist,
            "height": height,
        },
        ru_nouns=HANDLE_RU,
        en_nouns=HANDLE_EN,
        features_ru=features_ru,
        features_en=features_en,
        feature_count=(3, 4),
    )
