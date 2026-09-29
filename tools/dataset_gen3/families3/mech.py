"""gen3: threads, threaded caps and threaded thumb nuts."""

from __future__ import annotations

import math

from tools.dataset_gen2.common import Part, Rng, ScadBuilder, fmt
from tools.dataset_gen2.prompts import en_count, ru_count
from tools.dataset_gen3.prompts3 import finish_part3, inch_size
from tools.dataset_gen3.toolkit import cyl, external_thread_ring, hexprism, internal_thread_ring, num

# coarse metric pitches: (major diameter, pitch)
THREAD_TABLE = (
    (6.0, 1.0),
    (8.0, 1.25),
    (10.0, 1.5),
    (12.0, 1.75),
    (16.0, 2.0),
    (20.0, 2.5),
    (24.0, 3.0),
)

BOLT_RU = ("болт с шестигранной головкой", "болт со шестигранной головкой под ключ", "крепежный болт с резьбой", "винт с шестигранной головкой")
BOLT_EN = ("hex head bolt", "hex bolt", "hex cap screw", "threaded hex bolt")
CAP_RU = ("резьбовая крышка", "крышка с внутренней резьбой", "навинчивающаяся крышка", "заглушка с резьбой")
CAP_EN = ("threaded cap", "screw cap", "internally threaded lid", "threaded plug")
KNOB_RU = ("резьбовая барашка", "барашек с резьбой", "гайка-барашек", "прижимная гайка с накаткой")
KNOB_EN = ("threaded thumb nut", "wing nut blank", "knurled thumb nut", "hand knob with thread")


def build_threads(index: int) -> Part:
    """Threaded studs and bolts: hex head, plain shank, annular thread ridges."""
    rng = Rng("gen3_threads", index)
    variant = rng.choice(("stud", "stud", "bolt"))
    units = inch_size(rng, min_mm=6.35)
    if units is not None and units[0] >= 6.35:
        shank_d, pitch = units[0], rng.grid([1.5, 1.75, 2.0])
    else:
        units = None
        shank_d, pitch = rng.choice(THREAD_TABLE)
    length = rng.grid([40.0, 50.0, 60.0, 70.0, 80.0])
    depth = round(min(pitch * 0.6, shank_d / 4), 2)
    core_r = round(shank_d / 2 - depth, 3)
    if core_r < 2.4:  # keep the thread profile clear of the axis
        core_r = 2.4
        shank_d = round(2 * (core_r + depth), 3)
    head_af = round(shank_d * 1.6, 1)
    head_d = round(head_af * 2 / math.sqrt(3.0), 2)
    head_h = round(shank_d * 0.65, 1)
    if variant == "stud":
        thread_z = round(head_h - 0.5, 2)
        thread_len = round(length, 2)
        plain_len = 0.0
    else:
        thread_len = round(length * rng.uniform(0.45, 0.6), 2)
        plain_len = round(length - thread_len, 2)
        thread_z = round(head_h - 0.5 + plain_len, 2)
    chamfer = round(min(1.5, core_r * 0.4), 2)
    total = round(head_h + length, 2)

    builder = ScadBuilder(
        "Threaded stud" if variant == "stud" else "Hex bolt",
        f"M{fmt(shank_d)} x {fmt(pitch)} thread, {fmt(length)} mm long",
    )
    builder.param("shank_d", shank_d, "major diameter")
    builder.param("pitch", pitch, "thread pitch")
    builder.param("depth", depth, "thread depth")
    builder.param("core_d", round(2 * core_r, 3), "minor diameter")
    builder.param("length", length, "shank length under the head")
    if plain_len > 0:
        builder.param("plain_len", plain_len, "unthreaded length at the head")
    builder.param("thread_len", thread_len, "threaded length")
    builder.param("head_af", head_af, "hex across flats")
    builder.param("head_h", head_h, "head height")
    builder.param("chamfer", chamfer, "tip chamfer")

    lines = [
        "union() {",
        "  /* hex head */",
        "  " + hexprism(head_af, head_h),
        "  /* shank at the minor diameter, sunk into the head */",
        "  translate([0, 0, head_h - 0.5]) cylinder(h = length + 0.5, d = core_d);",
        "  /* thread ridges: crests at the major diameter, roots inside the shank */",
    ]
    lines.append(
        "  translate([0, 0, "
        + ("head_h - 0.5" if variant == "stud" else "head_h - 0.5 + plain_len")
        + "]) "
        + external_thread_ring(
            core_r=core_r,
            major_r=round(shank_d / 2, 3),
            z0=0.0,
            height=round(thread_len, 3),
            pitch=float(pitch),
        ).replace("\n", "\n  ")
    )
    lines.append(
        "  /* chamfered tip, exactly on the minor cylinder */"
    )
    lines.append(
        "  translate([0, 0, "
        + num(total - chamfer, 3)
        + "]) cylinder(h = "
        + num(chamfer, 3)
        + ", d1 = core_d, d2 = "
        + num(2 * core_r - 2 * chamfer, 3)
        + ");"
    )
    lines.append("}")
    builder.section("\n".join(lines))
    code = builder.render()

    # miniscad / OpenSCAD put a hexagon corner on +x, so the head is wider in x
    bbox = (float(head_d), float(head_af), float(total))
    features_ru = [
        f"резьба M{fmt(shank_d)} с шагом {fmt(pitch)} мм по {'всей длине' if not plain_len else 'части стержня'}",
        f"шестигранник {fmt(head_af)} мм под ключ",
        f"длина {fmt(length)} мм под головкой",
    ]
    features_en = [
        f"M{fmt(shank_d)} thread, {fmt(pitch)} mm pitch on "
        + ("the whole shank" if not plain_len else "the lower part of the shank"),
        f"{fmt(head_af)} mm hex across flats",
        f"{fmt(length)} mm under the head",
    ]
    if plain_len:
        features_ru.append(f"гладкий участок {fmt(plain_len)} мм у головки")
        features_en.append(f"a {fmt(plain_len)} mm plain section at the head")
    return finish_part3(
        rng,
        family="threads",
        variant=variant,
        code=code,
        bbox=bbox,
        params={
            "major_d": shank_d,
            "pitch": float(pitch),
            "length": length,
            "head_af": head_af,
            "wall": depth,
        },
        ru_nouns=BOLT_RU,
        en_nouns=BOLT_EN,
        features_ru=features_ru,
        features_en=features_en,
        units=units,
    )


def build_threadcaps(index: int) -> Part:
    """Caps with an internal thread and a fluted (knurled) rim."""
    rng = Rng("gen3_threadcaps", index)
    variant = rng.choice(("knurled", "knurled", "plain", "flanged"))
    outer_d = rng.grid([30.0, 36.0, 40.0, 45.0, 50.0])
    height = rng.grid([18.0, 22.0, 26.0, 30.0])
    wall = rng.grid([2.5, 3.0, 3.5, 4.0])
    top_t = rng.grid([3.0, 4.0, 5.0])
    pitch = rng.grid([1.5, 1.75, 2.0, 2.5])
    thread_depth = round(pitch * 0.6, 2)
    bore_d = round(outer_d - 2 * wall, 2)
    bore_r = bore_d / 2
    thread_z0 = 3.0
    thread_h = round(height - top_t - thread_z0 - 3.0, 2)
    flutes = rng.integer(8, 14)
    flute_d = rng.grid([5.0, 6.0, 7.0])
    flute_depth = rng.grid([1.0, 1.2, 1.4])
    flange_d = round(outer_d + rng.grid([6.0, 8.0, 10.0]), 2)
    flange_t = rng.grid([3.0, 4.0, 5.0])
    total = round(height + (flange_t if variant == "flanged" else 0.0), 2)
    if thread_h < 6.0:  # keep at least four thread turns
        thread_h = 6.0

    builder = ScadBuilder(
        "Threaded cap",
        f"{fmt(outer_d)} mm body, {fmt(height)} mm tall, {fmt(bore_d)} mm threaded bore",
    )
    builder.param("outer_d", outer_d, "cap outside diameter")
    builder.param("body_h", height, "cap height")
    builder.param("top_t", top_t, "closed top thickness")
    builder.param("bore_d", bore_d, "bore core diameter")
    builder.param("pitch", pitch, "thread pitch")
    builder.param("thread_d", thread_depth, "thread depth")
    builder.param("thread_z", thread_z0, "thread start above the rim")
    builder.param("thread_h", thread_h, "threaded height")
    if variant == "knurled":
        builder.param("flutes", float(flutes), "number of knurl flutes")
        builder.param("flute_d", flute_d, "flute cutter diameter")
        builder.param("flute_depth", flute_depth, "flute depth into the rim")
    if variant == "flanged":
        builder.param("flange_d", flange_d, "flange diameter")
        builder.param("flange_t", flange_t, "flange thickness")

    lines = ["difference() {", "  union() {"]
    if variant == "flanged":
        lines.append("    cylinder(h = " + num(flange_t, 3) + ", d = flange_d);")
        lines.append(
            "    translate([0, 0, " + num(flange_t - 0.5, 3) + "]) cylinder(h = "
            + num(height + 0.5, 3) + ", d = outer_d);"
        )
    else:
        lines.append("    cylinder(h = " + num(height, 3) + ", d = outer_d);")
    lines.append("  }")
    lines.append("  /* threaded bore, closed at the top */")
    lines.append(
        "  translate([0, 0, -2.5]) cylinder(h = "
        + num(total - top_t + 2.5, 3)
        + ", d = bore_d);"
    )
    lines.append(
        "  translate([0, 0, " + num(thread_z0, 3) + "]) "
        + internal_thread_ring(
            bore_r=bore_r,
            z0=0.0,
            height=thread_h,
            pitch=float(pitch),
            depth=thread_depth,
        ).replace("\n", "\n  ")
    )
    if variant == "knurled":
        lines.append("  /* knurl flutes around the rim */")
        lines.append("  for (i = [0 : flutes - 1]) {")
        lines.append(
            "    a = i * 360 / flutes;"
        )
        lines.append(
            "    translate([(outer_d / 2 + flute_d / 2 - flute_depth) * cos(a),"
            " (outer_d / 2 + flute_d / 2 - flute_depth) * sin(a), -2.5])"
            " cylinder(h = body_h + 5, d = flute_d);"
        )
        lines.append("  }")
    lines.append("}")
    builder.section("\n".join(lines))
    code = builder.render()

    bbox = (
        float(flange_d if variant == "flanged" else outer_d),
        float(flange_d if variant == "flanged" else outer_d),
        float(total),
    )
    features_ru = [
        f"внутренняя резьба с шагом {fmt(pitch)} мм на глубину {fmt(thread_h)} мм",
        f"отверстие {fmt(bore_d)} мм, глухой верх {fmt(top_t)} мм",
    ]
    features_en = [
        f"internal thread, {fmt(pitch)} mm pitch, {fmt(thread_h)} mm deep",
        f"{fmt(bore_d)} mm bore with a {fmt(top_t)} mm closed top",
    ]
    if variant == "knurled":
        features_ru.append(f"накатка из {flutes} канавок под руку")
        features_en.append(f"a {flutes} flute knurl for grip")
    if variant == "flanged":
        features_ru.append(f"буртик {fmt(flange_d)} мм толщиной {fmt(flange_t)} мм")
        features_en.append(f"a {fmt(flange_d)} mm collar, {fmt(flange_t)} mm thick")
    return finish_part3(
        rng,
        family="threadcaps",
        variant=variant,
        code=code,
        bbox=bbox,
        params={
            "outer_d": outer_d,
            "height": total,
            "bore_d": bore_d,
            "wall": wall,
            "pitch": float(pitch),
        },
        ru_nouns=CAP_RU,
        en_nouns=CAP_EN,
        features_ru=features_ru,
        features_en=features_en,
    )


def build_thumbscrews(index: int) -> Part:
    """Sketch family: lobed grip outline, extruded, with a threaded bore."""
    rng = Rng("gen3_thumbscrews", index)
    variant = rng.choice(("knurled", "knurled", "lobed"))
    lobes = rng.integer(4, 8)
    base_r = rng.grid([14.0, 16.0, 18.0, 20.0, 22.0])
    lobe_amp = rng.grid([1.2, 1.6, 2.0, 2.5])
    grip_h = rng.grid([10.0, 12.0, 14.0, 16.0])
    units = inch_size(rng, max_mm=12.7, min_mm=6.0)
    if units is not None:
        bore_d, pitch = units[0], 1.75
    else:
        bore_d, pitch = rng.choice(((6.0, 1.0), (8.0, 1.25), (10.0, 1.5), (12.0, 1.75)))
    thread_depth = round(pitch * 0.6, 2)
    boss_d = round(min(base_r * 2 - 6.0, bore_d + 2 * rng.grid([3.0, 4.0, 5.0])), 2)
    boss_h = rng.grid([4.0, 6.0, 8.0])
    total = round(grip_h + boss_h, 2)

    outline = []
    steps = 48
    for step in range(steps):
        angle = 2 * math.pi * step / steps
        radius = base_r + lobe_amp * math.cos(lobes * angle)
        outline.append((round(radius * math.cos(angle), 3), round(radius * math.sin(angle), 3)))
    polygon = "[" + ", ".join(f"[{num(x, 3)}, {num(y, 3)}]" for x, y in outline) + "]"

    builder = ScadBuilder(
        "Thumb nut",
        f"{lobes} lobe grip, {fmt(total)} mm tall, M{fmt(bore_d)} thread",
    )
    builder.param("base_r", base_r, "grip base radius")
    builder.param("lobe_amp", lobe_amp, "lobe height above the base radius")
    builder.param("lobes", float(lobes), "number of grip lobes")
    builder.param("grip_h", grip_h, "grip height")
    builder.param("boss_d", boss_d, "threaded boss diameter")
    builder.param("boss_h", boss_h, "boss height")
    builder.param("bore_d", bore_d, "thread core diameter")
    builder.param("pitch", pitch, "thread pitch")
    builder.param("thread_d", thread_depth, "thread depth")
    builder.assignment(f"grip = {polygon};")

    lines = [
        "difference() {",
        "  union() {",
        "    /* grip outline extruded straight up */",
        "    linear_extrude(height = grip_h) polygon(grip);",
        "    /* boss sunk half a millimetre into the grip */",
        "    translate([0, 0, grip_h - 0.5]) cylinder(h = boss_h + 0.5, d = boss_d);",
        "  }",
        "  /* threaded bore through grip and boss */",
        "  translate([0, 0, -2.5]) cylinder(h = grip_h + boss_h + 5, d = bore_d);",
        "  translate([0, 0, 2.0]) "
        + internal_thread_ring(
            bore_r=bore_d / 2,
            z0=0.0,
            height=round(grip_h + boss_h - 4.0, 2),
            pitch=float(pitch),
            depth=thread_depth,
        ).replace("\n", "\n  "),
        "}",
    ]
    builder.section("\n".join(lines))
    code = builder.render()

    span = 2 * (base_r + lobe_amp)
    xs = [x for x, _ in outline]
    ys = [y for _, y in outline]
    bbox = (float(round(max(xs) - min(xs), 3)), float(round(max(ys) - min(ys), 3)), float(total))
    features_ru = [
        f"{ru_count(lobes, 'лепесток', 'лепестка', 'лепестков')} на рукоятке высотой {fmt(lobe_amp)} мм",
        f"резьбовое отверстие M{fmt(bore_d)} с шагом {fmt(pitch)} мм",
        f"бобышка {fmt(boss_d)} мм высотой {fmt(boss_h)} мм",
    ]
    features_en = [
        f"{en_count(lobes)} grip lobes, {fmt(lobe_amp)} mm proud of the base circle",
        f"M{fmt(bore_d)} threaded bore, {fmt(pitch)} mm pitch",
        f"a {fmt(boss_d)} mm boss, {fmt(boss_h)} mm tall",
    ]
    return finish_part3(
        rng,
        family="thumbscrews",
        variant=variant,
        code=code,
        bbox=bbox,
        params={
            "grip_d": span,
            "height": total,
            "bore_d": bore_d,
            "wall": round((span - bore_d) / 2, 2),
        },
        ru_nouns=KNOB_RU,
        en_nouns=KNOB_EN,
        features_ru=features_ru,
        features_en=features_en,
        units=units,
    )
