"""Bearing hardware: housings, retaining caps, spacer sleeves and Oldham couplings.

Bearing seats use real ball-bearing envelopes (608, 6000...6204) so the bore,
pocket depth and wall thickness match what a workshop would actually machine or
print.
"""

from __future__ import annotations

import math

from tools.dataset_gen2.common import Part, Rng, ScadBuilder, finish_part, fmt
from tools.dataset_gen2.prompts import en_count, ru_count

#: designation: (bore, outer diameter, width)
BEARINGS = {
    "608": (8.0, 22.0, 7.0),
    "6000": (10.0, 26.0, 8.0),
    "6001": (12.0, 28.0, 8.0),
    "6002": (15.0, 32.0, 9.0),
    "6202": (15.0, 35.0, 11.0),
    "6203": (17.0, 40.0, 12.0),
    "6204": (20.0, 47.0, 14.0),
    "6005": (25.0, 47.0, 12.0),
}

HOUSING_RU = (
    "стакан под подшипник", "корпус подшипникового узла", "подшипниковый стакан",
    "фланец под подшипник", "опора под подшипник", "стойка под подшипник",
)
HOUSING_EN = (
    "bearing housing", "bearing cup", "flanged bearing seat", "bearing block",
    "pillow housing", "bearing carrier",
)
CAP_RU = (
    "прижимная крышка подшипника", "крышка стакана", "накладная крышка узла",
    "крышка с буртиком", "фланец-крышка подшипника", "упорная крышка",
)
CAP_EN = (
    "bearing retaining cap", "bearing cover plate", "end cap with a spigot",
    "bearing clamp plate", "shaft cover cap", "bearing end cover",
)
SPACER_RU = (
    "дистанционная втулка", "распорная втулка", "втулка-проставка", "кольцо дистанционное",
    "втулка между подшипниками", "проставка под подшипник",
)
SPACER_EN = (
    "spacer sleeve", "distance bushing", "bearing spacer", "standoff sleeve",
    "shaft spacer ring", "sleeve standoff",
)
OLDHAM_RU = (
    "полумуфта Олдэма", "часть муфты Олдэма", "кулачковая муфта Олдэма", "диск муфты Олдэма",
    "полумуфта с кулачком", "муфта Олдэма, деталь",
)
OLDHAM_EN = (
    "Oldham coupling part", "Oldham coupling hub", "Oldham disc", "Oldham coupling half",
    "cam coupling part", "Oldham spider",
)


# ---------------------------------------------------------------------------
# bearing housing ("стакан")
# ---------------------------------------------------------------------------

_HOUSING_NAMES = (
    {"od": "housing_d", "h": "housing_h", "wall": "wall_t", "fd": "flange_d", "seat": "seat_d"},
    {"od": "body_od", "h": "body_h", "wall": "wall", "fd": "flange_dia", "seat": "pocket_d"},
    {"od": "case_d", "h": "case_h", "wall": "rim_t", "fd": "ear_d", "seat": "bearing_seat"},
)


def build_bearing_housings(index: int) -> Part:
    rng = Rng("bearing_housings", index)
    names = rng.choice(_HOUSING_NAMES)
    designation = rng.choice(list(BEARINGS))
    bearing_bore, bearing_od, bearing_w = BEARINGS[designation]
    clearance = rng.grid([0.1, 0.15, 0.2, 0.25])
    seat_d = round(bearing_od + clearance, 2)
    wall = rng.grid([3.0, 4.0, 5.0, 6.0])
    body_od = round(seat_d + 2 * wall, 2)
    flange = rng.chance(0.75)
    flange_t = rng.grid([4.0, 5.0, 6.0, 8.0]) if flange else 0.0
    flange_d = round(body_od + rng.grid([12.0, 16.0, 20.0, 26.0]), 2) if flange else body_od
    shoulder = rng.grid([2.0, 3.0, 4.0, 5.0])
    body_h = round(bearing_w + 0.4 + shoulder, 2)
    body_h = round(body_h + flange_t, 2)
    pass_d = round(bearing_bore + rng.grid([0.3, 0.5, 1.0, 2.0]), 2)
    bolt_n = 4
    bolt_d = rng.grid([3.4, 4.5, 5.5, 6.6])
    bolt_r = round((flange_d - (bolt_d + 6.0)) / 2, 2)
    ribs = flange and rng.chance(0.4)

    builder = ScadBuilder(
        "Bearing housing",
        f"seat for {designation} ({fmt(bearing_od)} x {fmt(bearing_w)} mm), {fmt(body_od)} mm body",
    )
    builder.param(names["od"], body_od, "housing outside diameter")
    builder.param(names["h"], body_h, "overall housing height")
    builder.param(names["wall"], wall, "wall thickness")
    builder.param(names["seat"], seat_d, f"{designation} seat, {fmt(clearance)} mm clearance")
    builder.param("seat_h", round(bearing_w + 0.4, 2), "pocket depth")
    builder.param("shoulder", shoulder, "shoulder under the bearing")
    builder.param("pass_d", pass_d, "shaft passage")
    if flange:
        builder.param(names["fd"], flange_d, "mounting flange diameter")
        builder.param("flange_t", flange_t, "flange thickness")
        builder.param("bolt_d", bolt_d, "flange bolt clearance")
        builder.param("bolt_r", bolt_r, "flange bolt circle radius")
    if ribs:
        builder.param("rib_w", rng.grid([4.0, 5.0, 6.0]), "rib width")
        builder.param("rib_n", 4.0, "rib count")

    lines = [
        "module body() {",
        "  cylinder(h = " + names["h"] + ", d = " + names["od"] + ");",
        "}",
    ]
    if flange:
        lines.extend(
            [
                "",
                "module flange() {",
                "  /* flange sunk 1.5 mm into the body */",
                "  cylinder(h = flange_t + 1.5, d = " + names["fd"] + ");",
                "}",
            ]
        )
    if ribs:
        lines.extend(
            [
                "",
                "module ribs() {",
                "  for (i = [0 : rib_n - 1])",
                "    rotate([0, 0, i * 360 / rib_n])",
                "      translate([-rib_w / 2, " + names["od"] + " / 2 - 0.8, flange_t - 1])",
                "        cube([rib_w, (" + names["fd"] + " - " + names["od"] + ") / 2 + 0.8, " + names["h"] + " - flange_t + 1]);",
                "}",
            ]
        )
    lines.extend(["", "difference() {", "  union() {", "    body();"])
    if flange:
        lines.append("    flange();")
    if ribs:
        lines.append("    ribs();")
    lines.append("  }")
    lines.append(
        "  translate([0, 0, " + names["h"] + " - seat_h]) cylinder(h = seat_h + 1, d = " + names["seat"] + ");"
    )
    lines.append(
        "  translate([0, 0, -1]) cylinder(h = " + names["h"] + " - seat_h + 1, d = pass_d);"
    )
    if flange:
        lines.append("  for (i = [0 : 3]) rotate([0, 0, 45 + i * 90]) translate([bolt_r, 0, -1])")
        lines.append("    cylinder(h = flange_t + 3, d = bolt_d);")
    lines.append("}")
    builder.section("\n".join(lines))
    code = builder.render()

    bbox = (float(flange_d), float(flange_d), float(body_h))
    features_ru = [f"посадочное место под подшипник {designation} ({fmt(bearing_od)}x{fmt(bearing_w)} мм)"]
    features_en = [f"{designation} bearing seat ({fmt(bearing_od)}x{fmt(bearing_w)} mm)"]
    features_ru.append(f"стенка {fmt(wall)} мм, бортик под подшипник {fmt(shoulder)} мм")
    features_en.append(f"{fmt(wall)} mm wall, {fmt(shoulder)} mm shoulder under the bearing")
    features_ru.append(f"проход под вал {fmt(pass_d)} мм")
    features_en.append(f"{fmt(pass_d)} mm shaft passage")
    if flange:
        features_ru.append(f"фланец {fmt(flange_d)} мм с четырьмя отверстиями {fmt(bolt_d)} мм по окружности {fmt(2 * bolt_r)} мм")
        features_en.append(f"{fmt(flange_d)} mm flange, four {fmt(bolt_d)} mm holes on a {fmt(2 * bolt_r)} mm circle")
    if ribs:
        features_ru.append("четыре ребра между фланцем и стаканом")
        features_en.append("four ribs between the flange and the body")
    return finish_part(
        rng,
        family="bearings",
        variant=designation + ("_flanged" if flange else "") + ("_ribbed" if ribs else ""),
        code=code,
        bbox=bbox,
        params={
            "bearing": float(designation[:2]) if designation[:2].isdigit() else 0.0,
            "bearing_od": bearing_od,
            "bearing_w": bearing_w,
            "seat_d": seat_d,
            "housing_d": body_od,
            "height": body_h,
        },
        ru_nouns=HOUSING_RU,
        en_nouns=HOUSING_EN,
        features_ru=features_ru,
        features_en=features_en,
    )


# ---------------------------------------------------------------------------
# retaining cap
# ---------------------------------------------------------------------------

_CAP_NAMES = (
    {"d": "cap_d", "t": "cap_t", "lip": "lip_d", "h": "lip_h"},
    {"d": "cover_d", "t": "cover_t", "lip": "spigot_d", "h": "spigot_h"},
    {"d": "plate_d", "t": "plate_t", "lip": "boss_d", "h": "boss_h"},
)


def build_retaining_caps(index: int) -> Part:
    rng = Rng("retaining_caps", index)
    names = rng.choice(_CAP_NAMES)
    designation = rng.choice(list(BEARINGS))
    bearing_bore, bearing_od, bearing_w = BEARINGS[designation]
    clearance = rng.grid([0.1, 0.2])
    lip_d = round(bearing_od + clearance - rng.grid([0.3, 0.4, 0.5]), 2)
    lip_h = rng.grid([2.0, 3.0, 4.0, 5.0])
    cap_t = rng.grid([4.0, 5.0, 6.0, 8.0])
    edge = rng.grid([6.0, 8.0, 10.0, 12.0])
    cap_d = round(bearing_od + 2 * edge, 2)
    bolt_d = rng.grid([3.4, 4.5, 5.5, 6.6])
    bolt_r = round((lip_d + cap_d) / 4, 2)
    closed = rng.chance(0.45)
    shaft_d = round(bearing_bore + rng.grid([0.3, 0.5, 1.0]), 2)
    dome = (not closed) and rng.chance(0.35)
    dome_h_value = 0.0
    nip = rng.chance(0.25)

    builder = ScadBuilder(
        "Retaining cap", f"{designation} cover, {fmt(cap_d)} mm, spigot {fmt(lip_d)} mm"
    )
    builder.param(names["d"], cap_d, "cover diameter")
    builder.param(names["t"], cap_t, "cover thickness")
    builder.param(names["lip"], lip_d, "spigot that enters the housing")
    builder.param(names["h"], lip_h, "spigot height")
    if not closed:
        builder.param("shaft_d", shaft_d, "shaft opening")
    builder.param("bolt_d", bolt_d, "bolt clearance")
    builder.param("bolt_r", bolt_r, "bolt circle radius")
    if dome:
        dome_h_value = rng.grid([2.0, 3.0, 4.0])
        builder.param("dome_h", dome_h_value, "raised centre")
    if nip:
        builder.param("nipple_d", 6.0, "grease nipple boss")
        builder.param("nipple_h", 5.0, "grease nipple boss height")

    lines = [
        "module cover() {",
        "  cylinder(h = " + names["t"] + ", d = " + names["d"] + ");",
        "}",
        "",
        "module spigot() {",
        "  /* sunk 1 mm into the cover; the spigot sets the overall height */",
        "  translate([0, 0, -" + names["h"] + "]) cylinder(h = " + names["h"] + " + 1, d = " + names["lip"] + ");",
        "}",
    ]
    if dome:
        lines.extend(
            [
                "",
                "module dome() {",
                "  translate([0, 0, " + names["t"] + " - 1]) cylinder(h = dome_h + 1, d = " + names["d"] + " * 0.55);",
                "}",
            ]
        )
    if nip:
        lines.extend(
            [
                "",
                "module nipple() {",
                "  translate([" + names["d"] + " * 0.32, 0, " + names["t"] + " - 1])",
                "    cylinder(h = nipple_h + 1, d = nipple_d);",
                "}",
            ]
        )
    lines.extend(["", "difference() {", "  union() {", "    cover();", "    spigot();"])
    if dome:
        lines.append("    dome();")
    if nip:
        lines.append("    nipple();")
    lines.append("  }")
    lines.append("  for (i = [0 : 3]) rotate([0, 0, 45 + i * 90]) translate([bolt_r, 0, -" + names["h"] + " - 1])")
    lines.append("    cylinder(h = " + names["h"] + " + " + names["t"] + " + 2, d = bolt_d);")
    if not closed:
        lines.append(
            "  translate([0, 0, -" + names["h"] + " - 1]) cylinder(h = " + names["h"] + " + " + names["t"] + " + 2, d = shaft_d);"
        )
    if nip:
        lines.append(
            "  translate([" + names["d"] + " * 0.32, 0, " + names["t"] + " + nipple_h - 1.5])"
            " cylinder(h = 4, d = 3.4);"
        )
    lines.append("}")
    builder.section("\n".join(lines))
    code = builder.render()

    dome_h = 0.0
    if dome:
        dome_h = float(dome_h_value)
    nipple_h_value = 5.0 if nip else 0.0
    extra = max(dome_h, nipple_h_value)
    bbox = (float(cap_d), float(cap_d), float(lip_h + cap_t + extra))
    features_ru = [f"крышка под стакан подшипника {designation}"]
    features_en = [f"cover for a {designation} housing"]
    features_ru.append(f"буртик {fmt(lip_d)} мм на глубину {fmt(lip_h)} мм входит в стакан")
    features_en.append(f"a {fmt(lip_d)} mm spigot that sits {fmt(lip_h)} mm into the housing")
    features_ru.append(f"крепление четырьмя винтами {fmt(bolt_d)} мм по окружности {fmt(2 * bolt_r)} мм")
    features_en.append(f"four {fmt(bolt_d)} mm screws on a {fmt(2 * bolt_r)} mm circle")
    if closed:
        features_ru.append("глухая, без выхода вала")
        features_en.append("closed, no shaft opening")
    else:
        features_ru.append(f"отверстие под вал {fmt(shaft_d)} мм")
        features_en.append(f"{fmt(shaft_d)} mm shaft opening")
    if dome:
        features_ru.append("приподнятая центральная часть")
        features_en.append("a raised centre")
    if nip:
        features_ru.append("бобышка под пресс-маслёнку")
        features_en.append("a grease nipple boss")
    return finish_part(
        rng,
        family="caps",
        variant=designation + ("_closed" if closed else "_open"),
        code=code,
        bbox=bbox,
        params={
            "bearing_od": bearing_od,
            "cap_d": cap_d,
            "cap_t": cap_t,
            "lip_d": lip_d,
            "lip_h": lip_h,
            "height": bbox[2],
        },
        ru_nouns=CAP_RU,
        en_nouns=CAP_EN,
        features_ru=features_ru,
        features_en=features_en,
    )


# ---------------------------------------------------------------------------
# spacer sleeves
# ---------------------------------------------------------------------------

_SPACER_NAMES = (
    {"od": "outer_d", "id": "inner_d", "l": "length"},
    {"od": "sleeve_od", "id": "sleeve_id", "l": "sleeve_l"},
    {"od": "tube_d", "id": "bore_d", "l": "tube_l"},
)


def build_spacers(index: int) -> Part:
    rng = Rng("spacers", index)
    names = rng.choice(_SPACER_NAMES)
    designation = rng.choice(list(BEARINGS))
    bearing_bore, bearing_od, bearing_w = BEARINGS[designation]
    inner_d = round(bearing_bore + rng.grid([0.2, 0.3, 0.5]), 2)
    wall = rng.grid([1.5, 2.0, 2.5, 3.0, 4.0])
    outer_d = round(inner_d + 2 * wall, 2)
    length = rng.grid([5.0, 6.0, 8.0, 10.0, 12.0, 15.0, 20.0, 25.0])
    variant = rng.choice(("plain", "plain", "flanged", "stepped", "slotted"))
    if variant == "stepped":
        # the ring left at the step must stay printable: (step_d - inner_d) / 2 >= 1.2 mm
        step_drop = min(rng.grid([1.5, 2.0, 3.0]), round(wall - 1.2, 2))
        step_d = round(outer_d - step_drop, 2)
        step_l = round(length * rng.uniform(0.3, 0.45), 2)
    if variant == "flanged":
        flange_d = round(outer_d + rng.grid([3.0, 4.0, 6.0]), 2)
        flange_t = rng.grid([1.5, 2.0, 3.0])
    if variant == "slotted":
        for _ in range(1):
            slot_w = rng.grid([2.0, 3.0, 4.0])
            slot_len = round(min(length * 0.6, 12.0), 2)

    builder = ScadBuilder(
        "Spacer sleeve", f"{fmt(outer_d)} / {fmt(inner_d)} x {fmt(length)} mm"
    )
    builder.param(names["od"], outer_d, "outside diameter")
    builder.param(names["id"], inner_d, "shaft bore")
    builder.param(names["l"], length, "sleeve length")
    if variant == "flanged":
        builder.param("flange_d", flange_d, "collar diameter")
        builder.param("flange_t", flange_t, "collar thickness")
    if variant == "stepped":
        builder.param("step_d", step_d, "reduced diameter")
        builder.param("step_l", step_l, "length of the step")
    if variant == "slotted":
        builder.param("slot_w", slot_w, "clamp slot width")
        builder.param("slot_len", slot_len, "clamp slot length")

    lines = ["module sleeve() {", "  cylinder(h = " + names["l"] + ", d = " + names["od"] + ");"]
    if variant == "flanged":
        lines.append("  cylinder(h = flange_t + 0.6, d = flange_d);")
    if variant == "stepped":
        lines.append(
            "  translate([0, 0, " + names["l"] + " - step_l]) cylinder(h = step_l, d = step_d);"
        )
    lines.append("}")
    lines.extend(["", "difference() {", "  sleeve();"])
    lines.append(
        "  translate([0, 0, -1]) cylinder(h = " + names["l"] + " + 2, d = " + names["id"] + ");"
    )
    if variant == "slotted":
        lines.append(
            "  translate([-" + names["od"] + " / 2 - 1, -slot_w / 2, " + names["l"] + " / 2 - slot_len / 2])"
            " cube([" + names["od"] + " / 2 + 1, slot_w, slot_len]);"
        )
    lines.append("}")
    builder.section("\n".join(lines))
    code = builder.render()

    bbox = (
        float(flange_d if variant == "flanged" else outer_d),
        float(flange_d if variant == "flanged" else outer_d),
        float(length),
    )
    features_ru = [
        f"внутреннее отверстие {fmt(inner_d)} мм под вал {designation}",
        f"стенка {fmt(wall)} мм",
    ]
    features_en = [
        f"{fmt(inner_d)} mm bore for a {designation} shaft",
        f"{fmt(wall)} mm wall",
    ]
    if variant == "flanged":
        features_ru.append(f"буртик {fmt(flange_d)} мм толщиной {fmt(flange_t)} мм")
        features_en.append(f"a {fmt(flange_d)} mm collar, {fmt(flange_t)} mm thick")
    if variant == "stepped":
        features_ru.append(f"ступень {fmt(step_d)} мм на длине {fmt(step_l)} мм")
        features_en.append(f"a {fmt(step_d)} mm step over {fmt(step_l)} mm")
    if variant == "slotted":
        features_ru.append("разрез для обжима на валу")
        features_en.append("a clamp slit so it grips the shaft")
    return finish_part(
        rng,
        family="spacers",
        variant=variant,
        code=code,
        bbox=bbox,
        params={
            "outer_d": outer_d,
            "inner_d": inner_d,
            "length": length,
            "wall": wall,
            "height": bbox[2],
        },
        ru_nouns=SPACER_RU,
        en_nouns=SPACER_EN,
        features_ru=features_ru,
        features_en=features_en,
        feature_count=(2, 3),
    )


# ---------------------------------------------------------------------------
# Oldham coupling: two hubs and the middle disc (three samples per design)
# ---------------------------------------------------------------------------

_OLDHAM_NAMES = (
    {"d": "hub_d", "l": "hub_l", "bore": "bore_d", "tongue": "tongue_w"},
    {"d": "body_d", "l": "body_l", "bore": "shaft_d", "tongue": "cam_w"},
    {"d": "flange_dia", "l": "flange_len", "bore": "hub_bore", "tongue": "key_w"},
)


def build_oldham(index: int) -> Part:
    """One Oldham coupling part; index % 3 selects hub A, hub B or the disc."""
    rng = Rng("oldham", index)
    names = rng.choice(_OLDHAM_NAMES)
    kind = ("hub_a", "hub_b", "disc")[index % 3]
    bore, hub_od, hub_len = (
        (rng.grid([6.0, 8.0, 10.0, 12.0]), rng.grid([28.0, 32.0, 36.0, 40.0]), rng.grid([14.0, 16.0, 18.0, 20.0]))
    )
    disc_d = round(hub_od - 6.0, 2)
    disc_t = rng.grid([8.0, 10.0, 12.0])
    tongue_w = round(bore + rng.grid([4.0, 6.0, 8.0]), 1)
    tongue_h = rng.grid([4.0, 5.0, 6.0])
    set_d = 4.5 if bore >= 10 else 3.4

    if kind == "disc":
        builder = ScadBuilder("Oldham coupling disc", f"{fmt(disc_d)} x {fmt(disc_t + 2 * tongue_h)} mm")
        builder.param("disc_d", disc_d, "disc diameter")
        builder.param("disc_t", disc_t, "disc thickness")
        builder.param("tongue_w", tongue_w, "tongue width")
        builder.param("tongue_h", tongue_h, "tongue height")
        builder.param("bore_d", round(bore + 2.0, 2), "centre lightening bore")
        lines = [
            "module disc() {",
            "  cylinder(h = disc_t, d = disc_d);",
            "  /* tongue on the top face, sunk 1 mm into the disc */",
            "  translate([-tongue_w / 2, -disc_d / 2, disc_t - 1]) cube([tongue_w, disc_d, tongue_h + 1]);",
            "  /* slot wall on the bottom face, 90 degrees turned */",
            "  translate([-disc_d / 2, -tongue_w / 2, -tongue_h]) cube([disc_d, tongue_w, tongue_h + 1]);",
            "}",
            "",
            "difference() {",
            "  disc();",
            "  translate([0, 0, -tongue_h - 1]) cylinder(h = disc_t + 2 * tongue_h + 2, d = bore_d);",
            "}",
        ]
        bbox = (float(disc_d), float(disc_d), float(disc_t + 2 * tongue_h))
        features_ru = [
            f"диск {fmt(disc_d)} мм толщиной {fmt(disc_t)} мм",
            f"кулачок {fmt(tongue_w)}x{fmt(tongue_h)} мм сверху и паз такого же размера снизу под 90°",
        ]
        features_en = [
            f"{fmt(disc_d)} mm disc, {fmt(disc_t)} mm thick",
            f"a {fmt(tongue_w)}x{fmt(tongue_h)} mm tongue on top and a matching slot below, turned 90 degrees",
        ]
        variant = "disc"
        params = {
            "disc_d": disc_d,
            "disc_t": disc_t,
            "tongue_w": tongue_w,
            "tongue_h": tongue_h,
            "height": bbox[2],
        }
    else:
        tongue_on_top = kind == "hub_a"
        builder = ScadBuilder(
            "Oldham coupling hub", f"{fmt(hub_od)} x {fmt(hub_len + tongue_h)} mm"
        )
        builder.param(names["d"], hub_od, "hub diameter")
        builder.param(names["l"], hub_len, "hub length")
        builder.param(names["bore"], bore, "shaft bore")
        builder.param(names["tongue"], tongue_w, "drive tongue width")
        builder.param("tongue_h", tongue_h, "drive tongue height")
        builder.param("set_d", set_d, "set screw tap hole")
        if tongue_on_top:
            lines = [
                "module hub() {",
                "  cylinder(h = " + names["l"] + ", d = " + names["d"] + ");",
                "  /* tongue, clipped to the hub disc and sunk 1 mm into the face */",
                "  intersection() {",
                "    translate([-" + names["tongue"] + " / 2, -" + names["d"] + " / 2, " + names["l"] + " - 1])",
                "      cube([" + names["tongue"] + ", " + names["d"] + ", tongue_h + 1]);",
                "    translate([0, 0, " + names["l"] + " - 1]) cylinder(h = tongue_h + 1, d = " + names["d"] + ");",
                "  }",
                "}",
            ]
        else:
            lines = [
                "module hub() {",
                "  /* the slot side is a raised disc with a groove milled across it */",
                "  cylinder(h = " + names["l"] + " + tongue_h, d = " + names["d"] + ");",
                "}",
            ]
        lines.extend(
            [
                "",
                "difference() {",
                "  hub();",
                "  translate([0, 0, -1]) cylinder(h = " + names["l"] + " + tongue_h + 2, d = " + names["bore"] + ");",
                "  translate([-" + names["d"] + " / 2 - 1, 0, " + names["l"] + " * 0.5])",
                "    rotate([0, 90, 0]) cylinder(h = " + names["d"] + " / 2 + 2, d = set_d);"
                + ("" if tongue_on_top else
                   "\n  translate([-" + names["tongue"] + " / 2, -" + names["d"] + " / 2 - 1, " + names["l"] + " - 1])"
                   "\n    cube([" + names["tongue"] + ", " + names["d"] + " + 2, tongue_h + 1]);"),
                "}",
            ]
        )
        bbox = (float(hub_od), float(hub_od), float(hub_len + tongue_h))
        features_ru = [
            f"ступица {fmt(hub_od)} мм длиной {fmt(hub_len)} мм",
            f"отверстие под вал {fmt(bore)} мм со стопорным винтом",
        ]
        features_en = [
            f"{fmt(hub_od)} mm hub, {fmt(hub_len)} mm long",
            f"{fmt(bore)} mm shaft bore with a set screw",
        ]
        if tongue_on_top:
            features_ru.append(f"кулачок {fmt(tongue_w)}x{fmt(tongue_h)} мм на торце")
            features_en.append(f"a {fmt(tongue_w)}x{fmt(tongue_h)} mm tongue on the face")
        else:
            features_ru.append(f"паз {fmt(tongue_w)} мм под кулачок ответной полумуфты")
            features_en.append(f"a {fmt(tongue_w)} mm slot for the mating tongue")
        variant = kind
        params = {
            "hub_d": hub_od,
            "hub_len": hub_len,
            "bore_d": bore,
            "tongue_w": tongue_w,
            "tongue_h": tongue_h,
            "height": bbox[2],
        }
    builder.section("\n".join(lines))
    code = builder.render()
    return finish_part(
        rng,
        family="oldhams",
        variant=variant,
        code=code,
        bbox=bbox,
        params=params,
        ru_nouns=OLDHAM_RU,
        en_nouns=OLDHAM_EN,
        features_ru=features_ru,
        features_en=features_en,
    )
