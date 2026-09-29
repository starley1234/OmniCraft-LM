"""Bracket families: L-, U- and Z-shaped mounts with real fastener patterns.

Geometry rules used throughout (see the dataset request):

* plates always share a corner *block*, so a union has a positive volumetric
  overlap (>= 1.5 mm in every direction) instead of a tangential touch;
* gussets are sunk ``0.9 mm`` into the plates they stiffen, so even the ribs
  overlap positively and no face is ever exactly coplanar with another;
* every hole keeps at least ``edge_margin`` of material to the outer faces, so
  no cutter lands exactly on a surface;
* the declared bounding box is the outer envelope of the plates, which is what
  the generated prompt states as well.
"""

from __future__ import annotations

from tools.dataset_gen2.common import Part, Rng, ScadBuilder, fmt, hole_for_thread
from tools.dataset_gen2.prompts import build_prompt, en_count, ru_count

# ---------------------------------------------------------------------------
# shared vocabulary
# ---------------------------------------------------------------------------

_L_RU_NOUNS = (
    "уголок крепёжный", "L-образный кронштейн", "кронштейн-уголок", "монтажный уголок",
    "кронштейн Г-образный", "опорный уголок", "кронштейн с двумя полками", "угловая опора",
    "крепёжный уголок", "кронштейн из листа",
)
_L_EN_NOUNS = (
    "L-bracket", "corner bracket", "angle bracket", "mounting cleat", "L-shaped mount",
    "right-angle bracket", "corner gusset plate", "sheet-metal corner bracket",
)
_U_RU_NOUNS = (
    "П-образный кронштейн", "U-кронштейн", "кронштейн-скоба", "скоба крепёжная",
    "кронштейн с двумя стойками", "опора П-образная", "скоба с полками", "U-образная опора",
)
_U_EN_NOUNS = (
    "U-bracket", "channel bracket", "clevis mount", "U-shaped clamp bracket",
    "two-wall bracket", "saddle bracket", "U-channel mount",
)
_Z_RU_NOUNS = (
    "Z-образный кронштейн", "кронштейн со смещением", "переходной уголок Z-типа",
    "кронштейн Z-профиля", "смещённая опора", "переходник Z-образный",
)
_Z_EN_NOUNS = (
    "Z-bracket", "offset bracket", "Z-shaped mounting bracket", "stepped angle bracket",
    "offset cleat", "Z-profile transition bracket",
)

_EDGE_RU = (
    "Наружные кромки притупи",
    "Скругли углы на 1 мм",
    "Кромки сними фаской 0.5",
)
_EDGE_EN = (
    "Break the outer edges",
    "Round the corners a little",
    "Add a 0.5 mm chamfer on the rim",
)


def _sentence_ru_holes(thread: str, count: int, place: str) -> str:
    return f"{ru_count(count, 'отверстие', 'отверстия', 'отверстий')} {thread} в {place}"


def _sentence_en_holes(thread: str, count: int, place: str) -> str:
    return f"{en_count(count)} {thread} holes in the {place}"


def _finish_prompts(
    rng: Rng,
    *,
    family: str,
    variant: str,
    code: str,
    bbox: tuple[float, float, float],
    params: dict[str, float],
    ru_nouns: tuple[str, ...],
    en_nouns: tuple[str, ...],
    features_ru: list[str],
    features_en: list[str],
) -> Part:
    prompt_ru, prompt_en = build_prompt(
        rng,
        ru_nouns=ru_nouns,
        en_nouns=en_nouns,
        bbox=bbox,
        ru_feature_sentences=[sentence[0].upper() + sentence[1:] + "." for sentence in features_ru],
        en_feature_sentences=[sentence[0].upper() + sentence[1:] + "." for sentence in features_en],
        feature_count=rng.integer(2, 3),
    )
    return Part(
        family=family,
        variant=variant,
        code=code,
        bbox=bbox,
        params=params,
        prompt_ru=prompt_ru,
        prompt_en=prompt_en,
    )


# ---------------------------------------------------------------------------
# L-bracket
# ---------------------------------------------------------------------------

_L_NAMES = (
    {"a": "leg_a", "b": "leg_b", "t": "thick", "d": "depth"},
    {"a": "arm_x", "b": "arm_z", "t": "wall", "d": "width"},
    {"a": "horiz_len", "b": "vert_len", "t": "plate_t", "d": "profile_w"},
    {"a": "base_len", "b": "upright_h", "t": "mat_t", "d": "flange_w"},
    {"a": "run_out", "b": "rise", "t": "sheet_t", "d": "bracket_w"},
)
_L_RIB_SINK = 0.9


def build_brackets_l(index: int) -> Part:
    rng = Rng("brackets_l", index)
    names = rng.choice(_L_NAMES)
    leg_a = rng.grid([30, 35, 40, 45, 50, 55, 60, 65, 70, 80, 90, 100])
    leg_b = rng.grid([25, 30, 35, 40, 45, 50, 55, 60, 70, 80])
    depth = rng.grid([16, 20, 24, 25, 30, 32, 40])
    thick = rng.grid([3, 3.5, 4, 4.5, 5, 6])
    thread, hole_d, head_d, head_h = hole_for_thread(rng)
    variant = rng.choice(
        ("two_holes", "two_holes", "two_holes", "euro_slots", "adjust_slot", "center_holes")
    )
    counterbore = variant in ("two_holes", "center_holes") and thick >= 4.5 and rng.chance(0.6)
    rib = rng.chance(0.5) and min(leg_a, leg_b) >= 40

    margin = max(6.0, hole_d * 2.0)
    if variant == "euro_slots":
        margin = max(margin, 10.0)
    count_x = 2 if (leg_a >= 2 * margin + 12 and variant != "center_holes") else 1
    count_z = 2 if (leg_b >= 2 * margin + 12 and variant not in ("adjust_slot", "center_holes")) else 1

    builder = ScadBuilder("L-bracket", f"{fmt(leg_a)} x {fmt(depth)} x {fmt(leg_b)} mm")
    builder.param(names["a"], leg_a, "horizontal leg, X")
    builder.param(names["b"], leg_b, "vertical leg, Z")
    builder.param(names["d"], depth, "bracket depth, Y")
    builder.param(names["t"], thick, "plate thickness")
    builder.param("hole_d", hole_d, f"clearance for {thread}")
    if counterbore:
        builder.param("cb_d", head_d, "counterbore seat")
        builder.param("cb_h", round(min(head_h, thick - 1.8), 2), "counterbore depth")
    if variant == "euro_slots":
        builder.param("slot_w", 5.5, "euro screw slot width")
        builder.param("slot_l", 13.0, "euro screw slot length")
    if variant == "adjust_slot":
        builder.param("slot_l", rng.grid([16.0, 20.0, 24.0, 28.0]), "adjustment slot length")
    if rib:
        builder.param("rib_leg", round(min(leg_a, leg_b) * rng.uniform(0.42, 0.58), 1), "gusset leg")
        builder.param("rib_sink", _L_RIB_SINK, "gusset overlap into the plates")

    modules = [
        f"""module hole_z(px, py) {{
  translate([px, py, -0.5]) cylinder(h = {names['t']} + 1, d = hole_d);
}}""",
        f"""module hole_x(pz, py) {{
  translate([-0.5, py, pz]) rotate([0, 90, 0]) cylinder(h = {names['t']} + 1, d = hole_d);
}}""",
    ]
    if counterbore:
        modules.append(
            f"""module cb_z(px, py) {{
  translate([px, py, {names['t']} - cb_h]) cylinder(h = cb_h + 0.4, d = cb_d);
}}"""
        )
        modules.append(
            f"""module cb_x(pz, py) {{
  translate([{names['t']} - cb_h, py, pz]) rotate([0, -90, 0]) cylinder(h = cb_h + 0.4, d = cb_d);
}}"""
        )
    if variant == "euro_slots":
        modules.append(
            f"""module euro_slot_z(px, py) {{
  hull() {{
    translate([px - (slot_l - slot_w) / 2, py, -0.5]) cylinder(h = {names['t']} + 1, d = slot_w);
    translate([px + (slot_l - slot_w) / 2, py, -0.5]) cylinder(h = {names['t']} + 1, d = slot_w);
  }}
}}"""
        )
        modules.append(
            f"""module euro_slot_x(pz, py) {{
  translate([-0.5, 0, 0]) rotate([0, 90, 0]) hull() {{
    translate([0, py, pz - (slot_l - slot_w) / 2]) cylinder(h = {names['t']} + 1, d = slot_w);
    translate([0, py, pz + (slot_l - slot_w) / 2]) cylinder(h = {names['t']} + 1, d = slot_w);
  }}
}}"""
        )
    if variant == "adjust_slot":
        modules.append(
            f"""module adjust_slot(px, py) {{
  hull() {{
    translate([px - (slot_l - hole_d) / 2, py, -0.5]) cylinder(h = {names['t']} + 1, d = hole_d);
    translate([px + (slot_l - hole_d) / 2, py, -0.5]) cylinder(h = {names['t']} + 1, d = hole_d);
  }}
}}"""
        )
    if rib:
        modules.append(
            f"""module gusset() {{
  translate([0, {names['d']} - rib_sink, 0])
    rotate([90, 0, 0])
      linear_extrude(height = {names['d']} - 2 * rib_sink)
        polygon(points = [[rib_sink, rib_sink], [rib_leg, rib_sink], [rib_sink, rib_leg]]);
}}"""
        )

    cuts: list[str] = []
    if variant == "euro_slots":
        cuts.append(f"  euro_slot_z({fmt(margin)}, {fmt(depth / 2)});")
        cuts.append(f"  euro_slot_x({fmt(margin)}, {fmt(depth / 2)});")
        if count_x == 2:
            cuts.append(f"  euro_slot_z({fmt(leg_a - margin)}, {fmt(depth / 2)});")
    else:
        xs = (
            [margin, leg_a - margin] if count_x == 2 else [round(leg_a * 0.5, 2)]
        )
        for px in xs:
            if variant == "adjust_slot" and count(px) == 0:
                continue
            cuts.append(f"  hole_z({fmt(px)}, {fmt(depth / 2)});")
            if counterbore:
                cuts.append(f"  cb_z({fmt(px)}, {fmt(depth / 2)});")
        if variant == "adjust_slot":
            cuts = [line for line in cuts if "hole_z" not in line]
            cuts.append(f"  adjust_slot({fmt(leg_a * 0.5)}, {fmt(depth / 2)});")
        zs = [margin, leg_b - margin] if count_z == 2 else [round(leg_b * 0.5, 2)]
        for pz in zs:
            cuts.append(f"  hole_x({fmt(pz)}, {fmt(depth / 2)});")
            if counterbore:
                cuts.append(f"  cb_x({fmt(pz)}, {fmt(depth / 2)});")

    lines = list(modules)
    lines.append("")
    lines.append("difference() {")
    lines.append("  union() {")
    lines.append(f"    /* horizontal leg */")
    lines.append(f"    cube([{names['a']}, {names['d']}, {names['t']}]);")
    lines.append(f"    /* vertical leg, overlapping the corner block */")
    lines.append(f"    cube([{names['t']}, {names['d']}, {names['b']}]);")
    if rib:
        lines.append("    gusset();")
    lines.append("  }")
    lines.extend(cuts)
    lines.append("}")
    builder.section("\n".join(lines))
    code = builder.render()

    bbox = (float(leg_a), float(depth), float(leg_b))
    features_ru = [f"обе полки толщиной {fmt(thick)} мм"]
    features_en = [f"both legs {fmt(thick)} mm thick"]
    if variant == "euro_slots":
        features_ru.append("пазы 5.5 мм под евровинт в обеих полках")
        features_en.append("5.5 mm euro-screw slots in both legs")
    elif variant == "adjust_slot":
        features_ru.append("в горизонтальной полке паз под регулировку, в вертикальной круглое отверстие")
        features_en.append("an adjustment slot in the horizontal leg and a round hole in the upright")
    else:
        features_ru.append(_sentence_ru_holes(thread, count_x, "горизонтальной полке"))
        features_ru.append(_sentence_ru_holes(thread, count_z, "вертикальной полке"))
        features_en.append(_sentence_en_holes(thread, count_x, "horizontal leg"))
        features_en.append(_sentence_en_holes(thread, count_z, "upright"))
    if counterbore:
        features_ru.append("цековки под головки винтов")
        features_en.append("counterbores for the screw heads")
    if rib:
        features_ru.append("в углу ребро жёсткости на всю глубину")
        features_en.append("a full-depth stiffening gusset in the corner")
    if rng.chance(0.35):
        features_ru.append(rng.choice(_EDGE_RU))
        features_en.append(rng.choice(_EDGE_EN))

    return _finish_prompts(
        rng,
        family="lbrackets",
        variant=variant + ("_rib" if rib else ""),
        code=code,
        bbox=bbox,
        params={
            "leg_a": leg_a,
            "leg_b": leg_b,
            "depth": depth,
            "wall": thick,
            "hole_d": hole_d,
            "holes": count_x + count_z,
        },
        ru_nouns=_L_RU_NOUNS,
        en_nouns=_L_EN_NOUNS,
        features_ru=features_ru,
        features_en=features_en,
    )


def count(value: float) -> int:  # pragma: no cover - helper kept for readability
    return int(value)


# ---------------------------------------------------------------------------
# U-bracket
# ---------------------------------------------------------------------------

_U_NAMES = (
    {"l": "length", "w": "width", "h": "height", "t": "thick"},
    {"l": "span", "w": "outer_w", "h": "wall_h", "t": "plate_t"},
    {"l": "base_len", "w": "channel_w", "h": "upright_h", "t": "mat_t"},
    {"l": "rail_len", "w": "jaw_w", "h": "jaw_h", "t": "web_t"},
)


def build_brackets_u(index: int) -> Part:
    rng = Rng("brackets_u", index)
    names = rng.choice(_U_NAMES)
    length = rng.grid([40, 45, 50, 55, 60, 70, 80, 90, 100, 110])
    width = rng.grid([30, 35, 40, 45, 50, 55, 60, 70])
    height = rng.grid([25, 30, 35, 40, 45, 50, 55, 60])
    thick = rng.grid([3, 4, 4.5, 5, 6, 8])
    thread, hole_d, head_d, head_h = hole_for_thread(rng)
    variant = rng.choice(
        ("base_holes", "base_holes", "slots", "side_holes", "windows", "side_holes")
    )
    base_holes = 2 if length >= 48 else 1
    side_holes = 2 if height >= 38 and length >= 40 else 1
    counterbore = thick >= 5 and variant in ("base_holes",) and rng.chance(0.5)

    margin = max(6.0, hole_d * 2.0)
    inner = width - 2 * thick

    builder = ScadBuilder("U-bracket", f"{fmt(length)} x {fmt(width)} x {fmt(height)} mm")
    builder.param(names["l"], length, "outer length, X")
    builder.param(names["w"], width, "outer width, Y")
    builder.param(names["h"], height, "upright height, Z")
    builder.param(names["t"], thick, "wall thickness")
    builder.param("hole_d", hole_d, f"clearance for {thread}")
    if counterbore:
        builder.param("cb_d", head_d, "counterbore diameter")
        builder.param("cb_h", round(min(head_h, thick - 2.0), 2), "counterbore depth")
    if variant == "slots":
        builder.param("slot_l", rng.grid([14.0, 18.0, 20.0, 24.0]), "slot length")
    if variant == "windows":
        builder.param("window_l", round(max(10.0, length * rng.uniform(0.35, 0.5)), 1), "window length")
        builder.param("window_h", round(max(8.0, height * rng.uniform(0.3, 0.45)), 1), "window height")

    modules = [
        f"""module hole_z(px, py) {{
  translate([px, py, -0.5]) cylinder(h = {names['t']} + 1, d = hole_d);
}}""",
        f"""module hole_y_pz(pz) {{
  /* through both uprights along Y */
  translate([0, -0.5, pz]) rotate([-90, 0, 0]) cylinder(h = {names['w']} + 1, d = hole_d);
}}""",
    ]
    if counterbore:
        modules.append(
            f"""module cb_z(px, py) {{
  translate([px, py, {names['t']} - cb_h]) cylinder(h = cb_h + 0.4, d = cb_d);
}}"""
        )
    if variant == "slots":
        modules.append(
            f"""module slot_z(px, py) {{
  hull() {{
    translate([px - (slot_l - hole_d) / 2, py, -0.5]) cylinder(h = {names['t']} + 1, d = hole_d);
    translate([px + (slot_l - hole_d) / 2, py, -0.5]) cylinder(h = {names['t']} + 1, d = hole_d);
  }}
}}"""
        )

    cuts: list[str] = []
    if variant == "slots":
        cuts.append(f"  slot_z({fmt(length / 2)}, {fmt(width / 2)});")
    else:
        xs = (
            [margin, length - margin]
            if base_holes == 2
            else [round(length / 2, 2)]
        )
        for px in xs:
            cuts.append(f"  hole_z({fmt(px)}, {fmt(width / 2)});")
            if counterbore:
                cuts.append(f"  cb_z({fmt(px)}, {fmt(width / 2)});")
    if variant == "side_holes":
        zs = [margin, height - margin] if side_holes == 2 else [round(height * 0.6, 2)]
        for pz in zs:
            cuts.append(f"  hole_y_pz({fmt(pz)});")
    if variant == "windows":
        cuts.append(
            f"""  /* lightening window through both uprights */
  translate([{names['l']} / 2 - window_l / 2, -1, {names['t']} + 4])
    cube([window_l, {names['w']} + 2, window_h]);"""
        )

    lines = list(modules)
    lines.append("")
    lines.append("module base() {")
    lines.append(f"  cube([{names['l']}, {names['w']}, {names['t']}]);")
    lines.append("}")
    lines.append("")
    lines.append("module uprights() {")
    lines.append(f"  cube([{names['l']}, {names['t']}, {names['h']}]);")
    lines.append(
        f"  translate([0, {names['w']} - {names['t']}, 0]) cube([{names['l']}, {names['t']}, {names['h']}]);"
    )
    lines.append("}")
    lines.append("")
    lines.append("difference() {")
    lines.append("  union() {")
    lines.append("    base();")
    lines.append("    uprights();")
    lines.append("  }")
    lines.extend(cuts)
    lines.append("}")
    builder.section("\n".join(lines))
    code = builder.render()

    bbox = (float(length), float(width), float(height))
    features_ru = [
        f"днище и боковины толщиной {fmt(thick)} мм",
        f"внутренний размер между стойками {fmt(inner)} мм",
    ]
    features_en = [
        f"{fmt(thick)} mm base and uprights",
        f"{fmt(inner)} mm clear width between the uprights",
    ]
    if variant == "slots":
        features_ru.append("в основании продолговатый паз под регулировку")
        features_en.append("an elongated adjustment slot in the base")
    else:
        features_ru.append(_sentence_ru_holes(thread, base_holes, "основании"))
        features_en.append(_sentence_en_holes(thread, base_holes, "base"))
    if variant == "side_holes":
        features_ru.append(f"{ru_count(side_holes, 'сквозное отверстие', 'сквозных отверстия', 'сквозных отверстий')} {thread} через обе стойки")
        features_en.append(f"a {thread} cross hole through both uprights")
    if variant == "windows":
        features_ru.append("в стойках окно для облегчения")
        features_en.append("a lightening window through the uprights")
    if counterbore:
        features_ru.append("цековки под головки винтов")
        features_en.append("counterbores for the screw heads")

    return _finish_prompts(
        rng,
        family="ubrackets",
        variant=variant,
        code=code,
        bbox=bbox,
        params={
            "length": length,
            "width": width,
            "height": height,
            "wall": thick,
            "hole_d": hole_d,
        },
        ru_nouns=_U_RU_NOUNS,
        en_nouns=_U_EN_NOUNS,
        features_ru=features_ru,
        features_en=features_en,
    )


# ---------------------------------------------------------------------------
# Z-bracket
# ---------------------------------------------------------------------------

_Z_NAMES = (
    {"lb": "lower_len", "lt": "upper_len", "w": "width", "h": "rise", "t": "thick"},
    {"lb": "foot_len", "lt": "top_len", "w": "depth", "h": "step_h", "t": "plate_t"},
    {"lb": "bottom_run", "lt": "top_run", "w": "profile_w", "h": "height", "t": "mat_t"},
    {"lb": "lower_leg", "lt": "upper_leg", "w": "bracket_w", "h": "offset_h", "t": "sheet_t"},
)


def build_brackets_z(index: int) -> Part:
    rng = Rng("brackets_z", index)
    names = rng.choice(_Z_NAMES)
    lower = rng.grid([40, 45, 50, 55, 60, 70, 80])
    upper = rng.grid([25, 30, 35, 40, 45])
    width = rng.grid([20, 25, 30, 35, 40, 50])
    rise = rng.grid([25, 30, 35, 40, 45, 50, 60])
    thick = rng.grid([3, 4, 5, 6])
    thread, hole_d, head_d, head_h = hole_for_thread(rng)
    rib = rng.chance(0.6)
    counterbore = thick >= 5 and rng.chance(0.5)
    upper = min(upper, lower - 2 * thick)
    margin = max(6.0, hole_d * 2.0)

    builder = ScadBuilder("Z-bracket", f"{fmt(lower)} x {fmt(width)} x {fmt(rise)} mm")
    builder.param(names["lb"], lower, "lower foot length, X")
    builder.param(names["lt"], upper, "upper foot length, X")
    builder.param(names["w"], width, "bracket width, Y")
    builder.param(names["h"], rise, "overall rise, Z")
    builder.param(names["t"], thick, "plate thickness")
    builder.param("hole_d", hole_d, f"clearance for {thread}")
    if counterbore:
        builder.param("cb_d", head_d, "counterbore diameter")
        builder.param("cb_h", round(min(head_h, thick - 1.8), 2), "counterbore depth")
    if rib:
        builder.param("rib_len", round(rng.uniform(0.32, 0.46) * min(lower, rise), 1), "gusset leg")
        builder.param("rib_sink", 0.9, "gusset overlap into the plates")

    modules = [
        f"""module hole_z(px, py, z0) {{
  translate([px, py, z0 - 0.5]) cylinder(h = {names['t']} + 1, d = hole_d);
}}""",
        f"""module hole_x(py, pz) {{
  translate([-0.5, py, pz]) rotate([0, 90, 0]) cylinder(h = {names['t']} + 1, d = hole_d);
}}""",
    ]
    if counterbore:
        modules.append(
            f"""module cb_z(px, py, top_z) {{
  translate([px, py, top_z - cb_h]) cylinder(h = cb_h + 0.5, d = cb_d);
}}"""
        )
        modules.append(
            f"""module cb_x(py, pz) {{
  translate([{names['t']} - cb_h, py, pz]) rotate([0, -90, 0]) cylinder(h = cb_h + 0.5, d = cb_d);
}}"""
        )
    if rib:
        modules.append(
            f"""module gusset(x0) {{
  translate([x0, {names['w']} - rib_sink, 0])
    rotate([90, 0, 0])
      linear_extrude(height = {names['w']} - 2 * rib_sink)
        polygon(points = [[rib_sink, {names['t']} - rib_sink],
                          [rib_sink, {names['t']} - rib_sink + rib_len],
                          [-rib_len, {names['t']} - rib_sink]]);
}}"""
        )

    web_x = lower - thick
    top_x = web_x - upper
    lines = list(modules)
    lines.append("")
    lines.append("difference() {")
    lines.append("  union() {")
    lines.append(f"    cube([{names['lb']}, {names['w']}, {names['t']}]);")
    lines.append(f"    /* web, overlapping the lower foot */")
    lines.append(
        f"    translate([{names['lb']} - {names['t']}, 0, 0]) cube([{names['t']}, {names['w']}, {names['h']}]);"
    )
    lines.append(f"    /* upper foot, sunk into the web */")
    lines.append(
        f"    translate([{names['lb']} - {names['t']} - {names['lt']}, 0, {names['h']} - {names['t']}]) "
        f"cube([{names['lt']} + {names['t']}, {names['w']}, {names['t']}]);"
    )
    if rib:
        lines.append(f"    gusset({names['lb']} - {names['t']});")
    lines.append("  }")
    upper_hole_x = min(upper - margin, upper * 0.6)
    lines.append(f"  hole_z({fmt(margin)}, {fmt(width / 2)}, 0);")
    lines.append(
        f"  translate([{names['lb']} - {names['t']} - {fmt(upper_hole_x)}, 0, 0]) "
        f"hole_z(0, {fmt(width / 2)}, {names['h']} - {names['t']});"
    )
    lines.append(
        f"  translate([{names['lb']} - {names['t']}, 0, 0]) hole_x({fmt(width / 2)}, {fmt(margin)});"
    )
    if counterbore:
        lines.append(f"  cb_z({fmt(margin)}, {fmt(width / 2)}, {names['t']});")
        lines.append(
            f"  translate([{names['lb']} - {names['t']} - {fmt(upper_hole_x)}, 0, 0]) "
            f"cb_z(0, {fmt(width / 2)}, {names['h']});"
        )
        lines.append(
            f"  translate([{names['lb']} - {names['t']}, 0, 0]) cb_x({fmt(width / 2)}, {fmt(margin)});"
        )
    lines.append("}")
    builder.section("\n".join(lines))
    code = builder.render()

    bbox = (float(lower), float(width), float(rise))
    features_ru = [
        f"нижняя полка {fmt(lower)} мм, верхняя {fmt(upper)} мм в обратную сторону",
        f"лист {fmt(thick)} мм, перепад по высоте {fmt(rise)} мм",
    ]
    features_en = [
        f"{fmt(lower)} mm lower foot, {fmt(upper)} mm upper foot facing the other way",
        f"{fmt(thick)} mm sheet, {fmt(rise)} mm offset between the feet",
    ]
    features_ru.append(_sentence_ru_holes(thread, 3, "полках"))
    features_en.append(_sentence_en_holes(thread, 3, "feet"))
    if counterbore:
        features_ru.append("цековки под потайные винты")
        features_en.append("counterbores for the screws")
    if rib:
        features_ru.append("ребро жёсткости между нижней полкой и стойкой")
        features_en.append("a gusset between the lower foot and the web")
    if rng.chance(0.3):
        features_ru.append(rng.choice(_EDGE_RU))
        features_en.append(rng.choice(_EDGE_EN))

    return _finish_prompts(
        rng,
        family="zbrackets",
        variant="rib" if rib else "plain",
        code=code,
        bbox=bbox,
        params={
            "lower_len": lower,
            "upper_len": upper,
            "width": width,
            "rise": rise,
            "wall": thick,
            "hole_d": hole_d,
        },
        ru_nouns=_Z_RU_NOUNS,
        en_nouns=_Z_EN_NOUNS,
        features_ru=features_ru,
        features_en=features_en,
    )
