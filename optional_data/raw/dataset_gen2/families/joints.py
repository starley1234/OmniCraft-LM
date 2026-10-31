"""Joints and routing hardware: hinges, cable clips, ducts, knobs, impellers."""

from __future__ import annotations

import math

from tools.dataset_gen2.common import Part, Rng, ScadBuilder, finish_part, fmt
from tools.dataset_gen2.prompts import en_count, ru_count

HINGE_RU = (
    "петля накладная", "шарнир с кольцевым зацеплением", "петля с втулками",
    "навес для дверцы", "петля-половинка с проушинами", "шарнирная планка",
)
HINGE_EN = (
    "hinge leaf", "knuckle hinge half", "barrel hinge leaf", "pintle hinge part",
    "door hinge half", "ring-joint hinge leaf",
)
CLIP_RU = (
    "клипса для кабеля", "зажим для провода", "хомутик с защёлкой", "клипса-держатель кабеля",
    "кабельный зажим", "клипса snap-fit",
)
CLIP_EN = (
    "cable clip", "cable clamp", "snap-fit cable holder", "wire retainer clip",
    "P-clip", "cable guide",
)
DUCT_RU = (
    "кабель-канал", "лоток для проводов", "кабельный лоток с прорезями", "короб для проводов",
    "канал с гребёнкой", "кабельный организатор",
)
DUCT_EN = (
    "cable duct", "wire tray", "slotted cable channel", "cable trunking",
    "finger duct", "wire raceway",
)
KNOB_RU = (
    "ручка-барашек", "гайка-барашек с насечкой", "круглая ручка с накаткой",
    "ручка-головка", "барашек для затяжки вручную", "ручка с лучами",
)
KNOB_EN = (
    "hand knob", "knurled thumb knob", "wing knob", "thumb nut with knurling",
    "clamping knob", "star knob",
)
IMPELLER_RU = (
    "крыльчатка", "импеллер вентилятора", "рабочее колесо вентилятора",
    "крыльчатка насоса", "колесо с лопатками", "импеллер с прямыми лопатками",
)
IMPELLER_EN = (
    "impeller", "fan rotor", "blower wheel", "pump impeller", "bladed rotor",
    "centrifugal impeller",
)


# ---------------------------------------------------------------------------
# hinge leaf
# ---------------------------------------------------------------------------

_HINGE_NAMES = (
    {"l": "leaf_len", "d": "leaf_w", "t": "leaf_t", "kd": "knuckle_d", "kw": "knuckle_w"},
    {"l": "plate_len", "d": "plate_w", "t": "plate_t", "kd": "barrel_d", "kw": "barrel_w"},
    {"l": "tab_len", "d": "tab_w", "t": "tab_t", "kd": "ring_d", "kw": "ring_w"},
)


def build_hinges(index: int) -> Part:
    rng = Rng("hinges", index)
    names = rng.choice(_HINGE_NAMES)
    leaf_len = rng.grid([40.0, 50.0, 60.0, 70.0, 80.0, 100.0])
    leaf_w = rng.grid([25.0, 30.0, 35.0, 40.0, 45.0])
    leaf_t = rng.grid([3.0, 4.0, 5.0, 6.0])
    knuckle_n = rng.choice([2, 3, 3, 4])
    knuckle_d = round(max(rng.grid([8.0, 10.0, 12.0, 14.0]), leaf_t * 1.8), 2)
    pin_d = round(knuckle_d * rng.grid([0.32, 0.38, 0.45]), 2)
    screw_n = rng.choice([2, 3, 3, 4])
    screw_d = rng.grid([3.4, 4.5, 5.5])
    countersink = rng.chance(0.5)
    gap = rng.grid([1.5, 2.0, 2.5, 3.0])
    knuckle_w = round((leaf_len - (knuckle_n + 1) * gap) / knuckle_n, 2)
    if knuckle_w < 4.0:
        knuckle_n = 2
        knuckle_w = round((leaf_len - (knuckle_n + 1) * gap) / knuckle_n, 2)
    margin = round(gap, 2)

    builder = ScadBuilder(
        "Hinge leaf", f"{fmt(leaf_len)} x {fmt(leaf_w + knuckle_d / 2)} x {fmt(knuckle_d)} mm"
    )
    builder.param(names["l"], leaf_len, "leaf length, X")
    builder.param(names["d"], leaf_w, "leaf width, Y")
    builder.param(names["t"], leaf_t, "leaf thickness")
    builder.param(names["kd"], knuckle_d, "knuckle diameter")
    builder.param(names["kw"], knuckle_w, "knuckle width")
    builder.param("knuckle_n", knuckle_n, "number of knuckles")
    builder.param("pin_d", pin_d, "pin bore")
    builder.param("gap", gap, "gap between the knuckles")
    builder.param("screw_d", screw_d, "screw clearance")
    if countersink:
        builder.param("cs_d", round(screw_d + 3.2, 1), "countersink diameter")
        builder.param("cs_h", 1.4, "countersink depth")

    lines = [
        "module leaf() {",
        "  cube([" + names["l"] + ", " + names["d"] + ", " + names["t"] + "]);",
        "}",
        "",
        "module knuckles() {",
        "  /* barrels sit on the leaf edge, the pin axis at half the leaf thickness */",
        "  for (i = [0 : knuckle_n - 1])",
        "    translate([gap + i * (" + names["kw"] + " + gap), 0, " + names["t"] + " * 0.5])",
        "      rotate([0, 90, 0]) cylinder(h = " + names["kw"] + ", d = " + names["kd"] + ");",
        "}",
    ]
    lines.extend(
        [
            "",
            "difference() {",
            "  union() {",
            "    leaf();",
            "    knuckles();",
            "  }",
            "  rotate([0, 90, 0]) translate([0, 0, -1])",
            "    cylinder(h = " + names["l"] + " + 2, d = pin_d);",
        ]
    )
    if screw_n == 2:
        positions = [leaf_len * 0.3, leaf_len * 0.7]
    else:
        positions = [leaf_len * (index_screw + 1) / (screw_n + 1) for index_screw in range(screw_n)]
    for position in positions:
        lines.append(
            "  translate([" + fmt(position) + ", " + names["d"] + " * 0.6, -1]) cylinder(h = "
            + names["t"] + " + 2, d = screw_d);"
        )
        if countersink:
            lines.append(
                "  translate([" + fmt(position) + ", " + names["d"] + " * 0.6, " + names["t"] + " - cs_h])"
                " cylinder(h = cs_h + 0.5, d = cs_d);"
            )
    lines.append("}")
    builder.section("\n".join(lines))
    code = builder.render()

    height = round(max(knuckle_d, leaf_t), 2)
    bbox = (float(leaf_len), float(leaf_w + knuckle_d / 2), float(height))
    features_ru = [
        f"{ru_count(knuckle_n, 'проушина', 'проушины', 'проушин')} диаметром {fmt(knuckle_d)} мм",
        f"ось шарнира {fmt(pin_d)} мм под палец",
    ]
    features_en = [
        f"{en_count(knuckle_n)} knuckles of {fmt(knuckle_d)} mm",
        f"{fmt(pin_d)} mm pin bore through the knuckles",
    ]
    features_ru.append(f"планка {fmt(leaf_t)} мм с {ru_count(screw_n, 'отверстием', 'отверстиями', 'отверстиями')} {fmt(screw_d)} мм")
    features_en.append(f"{fmt(leaf_t)} mm leaf with {en_count(screw_n)} {fmt(screw_d)} mm screw holes")
    if countersink:
        features_ru.append("зенковка под потайной винт")
        features_en.append("countersinks for flat head screws")
    return finish_part(
        rng,
        family="hinges",
        variant=f"{knuckle_n}knuckle",
        code=code,
        bbox=bbox,
        params={
            "leaf_len": leaf_len,
            "leaf_w": leaf_w,
            "leaf_t": leaf_t,
            "knuckle_d": knuckle_d,
            "knuckle_n": knuckle_n,
            "pin_d": pin_d,
            "screws": screw_n,
        },
        ru_nouns=HINGE_RU,
        en_nouns=HINGE_EN,
        features_ru=features_ru,
        features_en=features_en,
    )


# ---------------------------------------------------------------------------
# cable clip
# ---------------------------------------------------------------------------

_CLIP_NAMES = (
    {"w": "base_w", "d": "base_d", "t": "base_t", "cd": "clamp_d", "wall": "wall_t"},
    {"w": "foot_w", "d": "foot_d", "t": "foot_t", "cd": "hose_seat_d", "wall": "ring_t"},
    {"w": "plate_x", "d": "plate_y", "t": "plate_t", "cd": "wire_seat_d", "wall": "clip_t"},
)


def build_cable_clips(index: int) -> Part:
    rng = Rng("cable_clips", index)
    names = rng.choice(_CLIP_NAMES)
    cable_d = rng.grid([4.0, 5.0, 6.0, 8.0, 10.0, 12.0, 16.0])
    wall = rng.grid([2.0, 2.5, 3.0, 4.0])
    clamp_d = round(cable_d + 2 * wall, 2)
    base_w = round(clamp_d + rng.grid([8.0, 12.0, 16.0, 20.0]), 2)
    base_d = round(clamp_d + rng.grid([4.0, 6.0, 8.0]), 2)
    base_t = rng.grid([3.0, 4.0, 5.0, 6.0])
    ring_w = round(rng.grid([6.0, 8.0, 10.0, 12.0]), 2)
    base_w = round(max(base_w, clamp_d + ring_w + 8.0), 2) if False else base_w
    variant = rng.choice(("snap", "snap", "closed", "double"))
    throat = round(cable_d * rng.grid([0.62, 0.7, 0.78]), 2)
    screw_d = rng.grid([3.4, 4.5, 5.5])
    if variant == "double":
        base_w = round(max(base_w, clamp_d + ring_w + 8.0, 2 * clamp_d + 12.0), 2)
    screw_n = 2 if variant == "double" or base_w >= clamp_d + 14 else 1
    clearance = rng.grid([0.2, 0.3, 0.4])

    builder = ScadBuilder(
        "Cable clip", f"cable {fmt(cable_d)} mm, clamp {fmt(clamp_d)} mm, base {fmt(base_w)} mm"
    )
    builder.param(names["w"], base_w, "base length, X")
    builder.param(names["d"], base_d, "base width, Y")
    builder.param(names["t"], base_t, "base thickness")
    builder.param(names["cd"], clamp_d, "clamp outside diameter")
    builder.param(names["wall"], wall, "clamp wall")
    builder.param("cable_d", cable_d, "cable opening")
    builder.param("ring_w", ring_w, "clamp width along the cable")
    builder.param("screw_d", screw_d, "screw clearance")
    pitch_value = round(min(clamp_d + 6.0, base_w - ring_w - 1.0), 2)
    if variant == "snap":
        builder.param("throat", throat, "snap throat width")
    builder.param("sink", 1.0, "overlap of the clamp into the base")
    if variant == "double":
        builder.param("pitch", pitch_value, "distance between the two clamps")

    lines = [
        "module base() {",
        "  cube([" + names["w"] + ", " + names["d"] + ", " + names["t"] + "]);",
        "}",
    ]
    if variant == "double":
        lines.extend(
            [
                "",
                "module clamps() {",
                "  for (sx = [-1, 1])",
                "    translate([" + names["w"] + " / 2 + sx * pitch / 2, " + names["d"] + " / 2, "
                + names["t"] + " + " + names["cd"] + " / 2 - sink]) rotate([0, 90, 0])",
                "      cylinder(h = ring_w, d = " + names["cd"] + ", center = true);",
                "}",
            ]
        )
    else:
        lines.extend(
            [
                "",
                "module clamp() {",
                "  translate([" + names["w"] + " / 2, " + names["d"] + " / 2, " + names["t"] + " + "
                + names["cd"] + " / 2 - sink]) rotate([0, 90, 0])",
                "    cylinder(h = ring_w, d = " + names["cd"] + ", center = true);",
                "}",
            ]
        )
    lines.extend(["", "difference() {", "  union() {", "    base();"])
    if variant == "double":
        lines.append("    clamps();")
    else:
        lines.append("    clamp();")
    lines.append("  }")
    if variant == "double":
        lines.append("  for (sx = [-1, 1])")
        lines.append(
            "    translate([" + names["w"] + " / 2 + sx * pitch / 2, " + names["d"] + " / 2, " + names["t"] + " + "
            + names["cd"] + " / 2 - sink]) rotate([0, 90, 0]) translate([0, 0, -ring_w / 2 - 1])"
            " cylinder(h = ring_w + 2, d = cable_d);"
        )
    else:
        lines.append(
            "  translate([" + names["w"] + " / 2, " + names["d"] + " / 2, " + names["t"] + " + "
            + names["cd"] + " / 2 - sink]) rotate([0, 90, 0]) translate([0, 0, -ring_w / 2 - 1])"
            " cylinder(h = ring_w + 2, d = cable_d);"
        )
    if variant == "snap":
        if variant == "double":
            pass
        lines.append(
            "  /* snap throat: the opening is narrower than the cable */"
        )
        lines.append(
            "  translate([" + names["w"] + " / 2 - throat / 2, " + names["d"] + " / 2, " + names["t"] + " + "
            + names["cd"] + " / 2 - sink]) rotate([0, 90, 0]) translate([0, 0, -ring_w / 2 - 1])"
            " cube([throat, " + names["cd"] + " + 2, ring_w + 2]);"
        )
    if screw_n == 2:
        spots = [base_w * 0.25, base_w * 0.75]
    else:
        spots = [base_w * 0.5]
    for spot in spots:
        lines.append(
            "  translate([" + fmt(spot) + ", " + names["d"] + " / 2, -1])"
            " cylinder(h = " + names["t"] + " + 2, d = screw_d);"
        )
    lines.append("}")
    builder.section("\n".join(lines))
    code = builder.render()

    height = round(base_t - 1.0 + clamp_d, 2)
    bbox = (float(base_w), float(max(base_d, clamp_d)), float(height))
    features_ru = [f"клипса под кабель {fmt(cable_d)} мм"]
    features_en = [f"holder for a {fmt(cable_d)} mm cable"]
    if variant == "snap":
        features_ru.append(f"защёлка с перехлёстом: горловина {fmt(throat)} мм уже кабеля")
        features_en.append(f"a snap throat of {fmt(throat)} mm, narrower than the cable")
    elif variant == "closed":
        features_ru.append("замкнутое кольцо под протяжку кабеля")
        features_en.append("a closed ring, the cable is threaded through")
    else:
        features_ru.append(f"два кольца на одной планке с шагом {fmt(pitch_value)} мм")
        features_en.append(f"two clamps on one base plate, {fmt(pitch_value)} mm apart")
    features_ru.append(f"{ru_count(screw_n, 'отверстие', 'отверстия', 'отверстий')} {fmt(screw_d)} мм в основании")
    features_en.append(f"{en_count(screw_n)} {fmt(screw_d)} mm screw holes in the base")
    return finish_part(
        rng,
        family="clips",
        variant=variant,
        code=code,
        bbox=bbox,
        params={
            "cable_d": cable_d,
            "clamp_d": clamp_d,
            "wall": wall,
            "base_w": base_w,
            "base_t": base_t,
            "height": height,
            "pitch": pitch_value if variant == "double" else 0.0,
        },
        ru_nouns=CLIP_RU,
        en_nouns=CLIP_EN,
        features_ru=features_ru,
        features_en=features_en,
    )


# ---------------------------------------------------------------------------
# cable duct
# ---------------------------------------------------------------------------

_DUCT_NAMES = (
    {"l": "duct_len", "w": "duct_w", "h": "duct_h", "t": "wall_t"},
    {"l": "tray_len", "w": "tray_w", "h": "tray_h", "t": "tray_t"},
    {"l": "channel_l", "w": "channel_w", "h": "channel_h", "t": "channel_t"},
)


def build_cable_ducts(index: int) -> Part:
    rng = Rng("cable_ducts", index)
    names = rng.choice(_DUCT_NAMES)
    duct_len = rng.grid([60.0, 80.0, 100.0, 120.0, 150.0, 180.0])
    duct_w = rng.grid([20.0, 25.0, 30.0, 40.0, 50.0])
    duct_h = rng.grid([15.0, 20.0, 25.0, 30.0, 40.0])
    wall = rng.grid([2.0, 2.5, 3.0, 4.0])
    floor = round(max(wall, rng.grid([2.0, 3.0, 4.0])), 2)
    slot_w = rng.grid([3.0, 4.0, 5.0, 6.0])
    fingers = rng.choice([6, 8, 10, 12])
    pitch = round(duct_len / fingers, 2)
    # fingers must stay at least 2 mm wide, otherwise the slots merge and the
    # whole upper rim of the duct would disappear
    slot_w = round(min(slot_w, pitch - 2.0), 2)
    if slot_w < 1.6:
        fingers = max(3, int(duct_len // 8))
        pitch = round(duct_len / fingers, 2)
        slot_w = round(min(6.0, pitch - 2.0), 2)
    slot_h = round(duct_h * rng.uniform(0.5, 0.7), 2)
    holes = rng.chance(0.6)
    hole_d = rng.grid([3.4, 4.5, 5.5])
    hole_n = max(2, int(duct_len // 50))
    mount_ears = rng.chance(0.35)

    builder = ScadBuilder(
        "Cable duct", f"{fmt(duct_len)} x {fmt(duct_w)} x {fmt(duct_h)} mm, {fingers} fingers"
    )
    builder.param(names["l"], duct_len, "duct length, X")
    builder.param(names["w"], duct_w, "duct width, Y")
    builder.param(names["h"], duct_h, "duct height, Z")
    builder.param(names["t"], wall, "side wall thickness")
    builder.param("floor_t", floor, "floor thickness")
    builder.param("slot_w", slot_w, "finger slot width")
    builder.param("slot_h", slot_h, "finger slot height")
    builder.param("fingers", float(fingers), "number of finger slots per side")
    builder.param("pitch", pitch, "finger pitch")
    if holes:
        builder.param("hole_d", hole_d, "floor mounting hole")
        builder.param("hole_n", float(hole_n), "mounting holes in the floor")
    if mount_ears:
        builder.param("ear_w", round(wall + 8.0, 2), "mounting ear width")
        builder.param("ear_l", 14.0, "mounting ear length")

    lines = [
        "module shell() {",
        "  difference() {",
        "    cube([" + names["l"] + ", " + names["w"] + ", " + names["h"] + "]);",
        "    /* open top channel */",
        "    translate([-" + names["t"] + " - 1, " + names["t"] + ", floor_t])",
        "      cube([" + names["l"] + " + 2 * " + names["t"] + " + 2, " + names["w"] + " - 2 * " + names["t"] + ", "
        + names["h"] + " + 1]);",
        "  }",
        "}",
    ]
    if mount_ears:
        lines.extend(
            [
                "",
                "module ears() {",
                "  translate([0, -ear_w + 1, 0]) cube([ear_l, ear_w, floor_t]);",
                "  translate([0, " + names["w"] + " - 1, 0]) cube([ear_l, ear_w, floor_t]);",
                "}",
            ]
        )
    lines.extend(["", "difference() {", "  union() {", "    shell();"])
    if mount_ears:
        lines.append("    ears();")
    lines.append("  }")
    lines.append(
        "  /* finger slots cut through both side walls */"
    )
    lines.append(
        "  for (i = [0 : fingers - 1])"
        " translate([pitch / 2 + i * pitch - slot_w / 2, -1, floor_t + slot_h])"
        " cube([slot_w, " + names["w"] + " + 2, " + names["h"] + "]);"
    )
    if holes:
        lines.append(
            "  for (i = [0 : hole_n - 1])"
            " translate([(" + names["l"] + " / hole_n) * (i + 0.5), " + names["w"] + " / 2, -1])"
            " cylinder(h = floor_t + 2, d = hole_d);"
        )
    lines.append("}")
    builder.section("\n".join(lines))
    code = builder.render()

    bbox = (
        float(duct_len),
        float(duct_w + (mount_ears and 2 * (wall + 8.0 - 1.0) or 0.0)),
        float(duct_h),
    )
    features_ru = [
        f"лоток {fmt(duct_w)}x{fmt(duct_h)} мм со стенкой {fmt(wall)} мм",
        f"{fingers} прорезей шириной {fmt(slot_w)} мм на каждой стороне",
    ]
    features_en = [
        f"{fmt(duct_w)}x{fmt(duct_h)} mm channel with {fmt(wall)} mm walls",
        f"{fingers} slots {fmt(slot_w)} mm wide per side",
    ]
    if holes:
        features_ru.append(f"{ru_count(hole_n, 'отверстие', 'отверстия', 'отверстий')} {fmt(hole_d)} мм в дне")
        features_en.append(f"{en_count(hole_n)} {fmt(hole_d)} mm holes in the floor")
    if mount_ears:
        features_ru.append("монтажные ушки по краям")
        features_en.append("mounting ears at the ends")
    return finish_part(
        rng,
        family="ducts",
        variant="ears" if mount_ears else "plain",
        code=code,
        bbox=bbox,
        params={
            "length": duct_len,
            "width": bbox[1],
            "height": duct_h,
            "wall": wall,
            "slot_w": slot_w,
            "fingers": fingers,
        },
        ru_nouns=DUCT_RU,
        en_nouns=DUCT_EN,
        features_ru=features_ru,
        features_en=features_en,
    )


# ---------------------------------------------------------------------------
# knurled knobs
# ---------------------------------------------------------------------------

_KNOB_NAMES = (
    {"d": "knob_d", "h": "knob_h", "bore": "bore_d", "k": "knurl_d"},
    {"d": "grip_d", "h": "grip_h", "bore": "shaft_d", "k": "knurl_dia"},
    {"d": "head_d", "h": "head_h", "bore": "hole_d", "k": "notch_d"},
)


def build_knobs(index: int) -> Part:
    rng = Rng("knobs", index)
    names = rng.choice(_KNOB_NAMES)
    knob_d = rng.grid([20.0, 25.0, 30.0, 35.0, 40.0, 50.0])
    knob_h = rng.grid([10.0, 12.0, 15.0, 18.0, 20.0, 25.0])
    bore_d = rng.grid([5.0, 6.0, 6.35, 8.0, 10.0, 12.0])
    bore_d = round(min(bore_d, knob_d * 0.32), 2)
    variant = rng.choice(("knurled", "knurled", "star", "wing"))
    knurl_n = rng.choice([12, 16, 20, 24, 30])
    knurl_d = round(knob_d / knurl_n * rng.uniform(0.5, 0.7), 2)
    set_d = 4.5 if bore_d >= 10 else 3.4
    star_lobes = rng.choice([4, 5, 6]) if variant == "star" else 0
    wing_l = round(knob_d * rng.uniform(1.5, 1.9), 1) if variant == "wing" else 0.0
    wing_w = round(knob_d * 0.3, 2) if variant == "wing" else 0.0
    wing_h = round(knob_h * 0.6, 2) if variant == "wing" else 0.0
    cap = rng.chance(0.5)
    cap_h = round(knob_h * 0.35, 2) if cap else 0.0
    cap_term = "cap_h" if cap else "0"

    builder = ScadBuilder(
        "Hand knob", f"{fmt(knob_d)} x {fmt(max(knob_d, wing_l))} x {fmt(knob_h + cap_h)} mm"
    )
    builder.param(names["d"], knob_d, "knob diameter")
    builder.param(names["h"], knob_h, "knob height")
    builder.param(names["bore"], bore_d, "shaft bore")
    builder.param("set_d", set_d, "set screw tap hole")
    if variant in ("knurled", "star"):
        builder.param(names["k"], knurl_d, "knurl groove diameter")
    if variant == "star":
        builder.param("lobes", float(star_lobes), "grip lobes")
    if variant == "wing":
        builder.param("wing_l", wing_l, "wing span")
        builder.param("wing_w", wing_w, "wing width")
        builder.param("wing_h", wing_h, "wing thickness")
    if variant == "knurled":
        builder.param("knurl_n", float(knurl_n), "number of knurl grooves")
    if cap:
        builder.param("cap_h", cap_h, "raised centre cap")
        builder.param("cap_d", round(knob_d * 0.5, 2), "centre cap diameter")

    lines = []
    if variant == "star":
        lines.extend(
            [
                "module body() {",
                "  cylinder(h = " + names["h"] + ", d = " + names["d"] + ");",
                "  for (i = [0 : lobes - 1])",
                "    rotate([0, 0, i * 360 / lobes])",
                "      translate([" + names["d"] + " * 0.42, 0, 0])",
                "        cylinder(h = " + names["h"] + ", d = " + names["d"] + " * 0.3);",
                "}",
            ]
        )
    else:
        lines.extend(
            [
                "module body() {",
                "  cylinder(h = " + names["h"] + ", d = " + names["d"] + ");",
                "}",
            ]
        )
    if variant == "wing":
        lines.extend(
            [
                "",
                "module wing() {",
                "  /* wing sunk 2 mm into the knob so the joint overlaps */",
                "  translate([-wing_l / 2, -wing_w / 2, " + names["h"] + " - 2])",
                "    cube([wing_l, wing_w, wing_h + 2]);",
                "}",
            ]
        )
    if cap:
        lines.extend(
            [
                "",
                "module cap() {",
                "  translate([0, 0, " + names["h"] + " - 1]) cylinder(h = cap_h + 1, d = cap_d);",
                "}",
            ]
        )
    lines.extend(["", "difference() {", "  union() {", "    body();"])
    if variant == "wing":
        lines.append("    wing();")
    if cap:
        lines.append("    cap();")
    lines.append("  }")
    lines.append(
        "  translate([0, 0, -1]) cylinder(h = " + names["h"] + " + " + cap_term + " + 2, d = " + names["bore"] + ");"
    )
    if variant == "knurled":
        lines.extend(
            [
                "  /* knurl grooves */",
                "  for (i = [0 : knurl_n - 1])",
                "    rotate([0, 0, i * 360 / knurl_n])",
                "      translate([" + names["d"] + " / 2, 0, -0.5])",
                "        cylinder(h = " + names["h"] + " + 1, d = " + names["k"] + ");",
            ]
        )
    lines.append(
        "  translate([-" + names["d"] + " / 2 - 1, 0, " + names["h"] + " * 0.5])"
        " rotate([0, 90, 0]) cylinder(h = " + names["d"] + " / 2 + 2, d = set_d);"
    )
    lines.append("}")
    builder.section("\n".join(lines))
    code = builder.render()

    if variant == "wing":
        height = round(knob_h + max(cap_h, wing_h), 2)
    else:
        height = round(knob_h + cap_h, 2)
    if variant == "star":
        # lobes orbit at 0.42 d and are 0.30 d across, so track both extremes
        points = [(knob_d / 2, 0.0), (-knob_d / 2, 0.0), (0.0, knob_d / 2), (0.0, -knob_d / 2)]
        for lobe in range(star_lobes):
            angle = math.radians(lobe * 360.0 / star_lobes)
            centre_x = knob_d * 0.42 * math.cos(angle)
            centre_y = knob_d * 0.42 * math.sin(angle)
            lobe_r = knob_d * 0.15
            points.extend(
                [
                    (centre_x + lobe_r, centre_y),
                    (centre_x - lobe_r, centre_y),
                    (centre_x, centre_y + lobe_r),
                    (centre_x, centre_y - lobe_r),
                ]
            )
        bbox = (
            round(max(point[0] for point in points) - min(point[0] for point in points), 2),
            round(max(point[1] for point in points) - min(point[1] for point in points), 2),
            float(height),
        )
    else:
        bbox = (
            float(max(knob_d, wing_l)),
            float(max(knob_d, wing_w)),
            float(height),
        )
    features_ru = [f"корпус {fmt(knob_d)} мм, высота {fmt(knob_h)} мм"]
    features_en = [f"{fmt(knob_d)} mm body, {fmt(knob_h)} mm tall"]
    if variant == "knurled":
        features_ru.append(f"накатка: {knurl_n} канавок {fmt(knurl_d)} мм по окружности")
        features_en.append(f"knurling: {knurl_n} grooves of {fmt(knurl_d)} mm")
    elif variant == "star":
        features_ru.append(f"{star_lobes} лучей для захвата рукой")
        features_en.append(f"{en_count(star_lobes)} grip lobes")
    else:
        features_ru.append(f"крыло размахом {fmt(wing_l)} мм для затяжки рукой")
        features_en.append(f"a {fmt(wing_l)} mm wing for hand tightening")
    features_ru.append(f"посадка на вал {fmt(bore_d)} мм со стопорным винтом")
    features_en.append(f"{fmt(bore_d)} mm shaft bore with a set screw")
    if cap:
        features_ru.append("приподнятая центральная площадка")
        features_en.append("a raised centre cap")
    return finish_part(
        rng,
        family="knobs",
        variant=variant,
        code=code,
        bbox=bbox,
        params={
            "knob_d": knob_d,
            "knob_h": knob_h,
            "bore_d": bore_d,
            "height": height,
        },
        ru_nouns=KNOB_RU,
        en_nouns=KNOB_EN,
        features_ru=features_ru,
        features_en=features_en,
    )


# ---------------------------------------------------------------------------
# impellers
# ---------------------------------------------------------------------------

_IMP_NAMES = (
    {"d": "hub_d", "h": "hub_h", "n": "blades", "r": "imp_d"},
    {"d": "boss_d", "h": "boss_h", "n": "vane_count", "r": "rotor_d"},
    {"d": "center_d", "h": "center_h", "n": "blade_count", "r": "wheel_d"},
)


def build_impellers(index: int) -> Part:
    rng = Rng("impellers", index)
    names = rng.choice(_IMP_NAMES)
    blades = rng.choice([5, 6, 7, 8, 9, 12])
    imp_d = rng.grid([50.0, 60.0, 70.0, 80.0, 90.0, 100.0])
    hub_d = round(imp_d * rng.uniform(0.26, 0.36), 2)
    hub_h = rng.grid([8.0, 10.0, 12.0, 15.0, 18.0])
    blade_h = rng.grid([10.0, 14.0, 18.0, 22.0, 26.0])
    blade_t = rng.grid([1.6, 2.0, 2.4, 3.0])
    bore_d = round(min(hub_d * 0.4, rng.grid([5.0, 6.0, 8.0, 10.0])), 2)
    sweep = rng.grid([10.0, 15.0, 20.0, 25.0, 30.0])
    shroud = rng.chance(0.35)
    shroud_h = rng.grid([2.0, 2.5, 3.0]) if shroud else 0.0
    shroud_term = "shroud_h" if shroud else "0"
    shroud_r_term = "shroud_d" if shroud else "0"
    blades_sink = 1.0

    blade_in_r = round(hub_d * 0.5 - blades_sink, 2)
    blade_out_r = round(imp_d * 0.5 - blade_t, 2)
    blade_len = round(blade_out_r - blade_in_r, 2)
    if blade_len < 8:
        blade_len = 8.0
        blade_out_r = round(blade_in_r + blade_len, 2)
    total_h = round(hub_h + blade_h + (shroud_h if shroud else 0.0), 2)
    height = total_h
    caps_d = round(imp_d - 2 * blade_t, 2)

    builder = ScadBuilder(
        "Impeller", f"{fmt(imp_d)} mm, {blades} blades, {fmt(height)} mm tall"
    )
    builder.param(names["d"], hub_d, "hub diameter")
    builder.param(names["h"], hub_h, "hub height")
    builder.param(names["r"], imp_d, "outer diameter over the blades")
    builder.param(names["n"], float(blades), "number of blades")
    builder.param("blade_t", blade_t, "blade thickness")
    builder.param("blade_h", blade_h, "blade height")
    builder.param("blade_in_r", blade_in_r, "blade root radius")
    builder.param("blade_out_r", blade_out_r, "blade tip radius")
    builder.param("sweep", sweep, "blade sweep, degrees")
    builder.param("bore_d", bore_d, "shaft bore")
    if shroud:
        builder.param("shroud_h", shroud_h, "shroud ring thickness")
        builder.param("shroud_d", round(imp_d + 2.0, 2), "shroud outside diameter")

    lines = [
        "module hub() {",
        "  cylinder(h = " + names["h"] + ", d = " + names["d"] + ");",
        "}",
        "",
        "module blade() {",
        "  /* blade swept between two boxes: hull of the root and the tip section */",
        "  hull() {",
        "    translate([blade_in_r, 0, " + names["h"] + " - 1])",
        "      cube([blade_t, blade_t * 2.2, blade_h + 1], center = false);",
        "    rotate([0, 0, sweep])",
        "      translate([blade_out_r, 0, " + names["h"] + " - 1])",
        "        cube([blade_t, blade_t * 1.6, blade_h + 1], center = false);",
        "  }",
        "}",
        "",
        "module blades() {",
        "  for (i = [0 : " + names["n"] + " - 1])",
        "    rotate([0, 0, i * 360 / " + names["n"] + "]) blade();",
        "}",
    ]
    if shroud:
        lines.extend(
            [
                "",
                "module shroud() {",
                "  translate([0, 0, " + names["h"] + " + blade_h - 1])",
                "    difference() {",
                "      cylinder(h = shroud_h + 1, d = shroud_d);",
                "      translate([0, 0, -1]) cylinder(h = shroud_h + 3, d = shroud_d - 2 * 3);",
                "    }",
                "}",
            ]
        )
    lines.extend(["", "difference() {", "  union() {", "    hub();", "    blades();"])
    if shroud:
        lines.append("    shroud();")
    lines.append("  }")
    lines.append(
        "  translate([0, 0, -1]) cylinder(h = " + names["h"] + " + blade_h + " + shroud_term + " + 3, d = bore_d);"
    )
    lines.append("}")
    builder.section("\n".join(lines))
    code = builder.render()

    # exact envelope: blade tips (rotated boxes) plus the shroud ring
    # the blade union is not symmetric about the origin, so track both extremes
    corners = []
    for corner_x, corner_y in (
        (blade_in_r, 0.0),
        (blade_in_r + blade_t, 0.0),
        (blade_in_r, blade_t * 2.2),
        (blade_in_r + blade_t, blade_t * 2.2),
        (blade_out_r, 0.0),
        (blade_out_r + blade_t, 0.0),
        (blade_out_r, blade_t * 1.6),
        (blade_out_r + blade_t, blade_t * 1.6),
    ):
        for blade_index in range(blades):
            angle = math.radians(sweep + blade_index * 360.0 / blades)
            corners.append(
                (
                    corner_x * math.cos(angle) - corner_y * math.sin(angle),
                    corner_x * math.sin(angle) + corner_y * math.cos(angle),
                )
            )
    x_min = round(min(point[0] for point in corners), 2)
    x_max = round(max(point[0] for point in corners), 2)
    y_min = round(min(point[1] for point in corners), 2)
    y_max = round(max(point[1] for point in corners), 2)
    if shroud:
        shroud_r = round((imp_d + 2.0) / 2, 2)
        x_min = min(x_min, -shroud_r)
        x_max = max(x_max, shroud_r)
        y_min = min(y_min, -shroud_r)
        y_max = max(y_max, shroud_r)
    bbox = (round(x_max - x_min, 2), round(y_max - y_min, 2), height)
    features_ru = [
        f"{blades} лопаток высотой {fmt(blade_h)} мм",
        f"ступица {fmt(hub_d)} мм под вал {fmt(bore_d)} мм",
    ]
    features_en = [
        f"{en_count(blades)} blades, {fmt(blade_h)} mm tall",
        f"{fmt(hub_d)} mm hub with a {fmt(bore_d)} mm bore",
    ]
    if sweep > 12:
        features_ru.append(f"лопатки подкручены на {fmt(sweep)}°")
        features_en.append(f"blades swept by {fmt(sweep)} degrees")
    if shroud:
        features_ru.append("бандажное кольцо по верху лопаток")
        features_en.append("a shroud ring closing the blade tips")
    return finish_part(
        rng,
        family="impellers",
        variant="shrouded" if shroud else "open",
        code=code,
        bbox=bbox,
        params={
            "outer_d": bbox[0],
            "hub_d": hub_d,
            "hub_h": hub_h,
            "blades": blades,
            "blade_h": blade_h,
            "height": height,
        },
        ru_nouns=IMPELLER_RU,
        en_nouns=IMPELLER_EN,
        features_ru=features_ru,
        features_en=features_en,
    )
