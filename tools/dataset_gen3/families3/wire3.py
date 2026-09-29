"""gen3 wire families: arched trusses, stepped towers, chassis frames, scissor grids.

Same member/joint convention as the gen2 wire families (a rod between two joint
centres plus a ball at every joint, so every member is buried inside its balls),
but every sample here carries a connected node/edge graph:

* arched trusses - curved (parabolic or segmental) top chord,
* stepped towers - per-tier gussets and face crosses,
* chassis frames - rails, cross members, posts and face bracing,
* scissor grids - 3x3 / 4x4 diamond lattices.
"""

from __future__ import annotations

import math

from tools.dataset_gen2.common import Graph, Part, Rng, ScadBuilder, fmt
from tools.dataset_gen2.families.wire import MEMBER_MODULE, _joint_radius, _node_bbox
from tools.dataset_gen2.prompts import en_count, ru_count
from tools.dataset_gen3.prompts3 import finish_part3

ARCH_RU = ("арочная ферма", "ферма с изогнутым верхним поясом", "мостовая арка", "арочная балка")
ARCH_EN = ("arched truss", "truss with a curved top chord", "bridge arch truss", "cambered chord truss")
STEP_RU = ("башня с ярусами", "решетчатая вышка", "ярусная опора", "башня с раскосами и косынками")
STEP_EN = ("stepped lattice tower", "tiered mast", "braced tower", "lattice tower with gussets")
CHASSIS_RU = ("рама шасси", "трубчатая рама", "каркас шасси", "силовая рама с раскосами")
CHASSIS_EN = ("chassis frame", "tube frame", "space frame chassis", "braced chassis frame")
SCISSOR_RU = ("решетчатая сетка", "ножничная решётка", "сетчатая панель", "решетка с перекрестьями")
SCISSOR_EN = ("lattice grid", "scissor lattice", "diagonal grid panel", "cross braced grid")


def _pair_joint(r_member: float, *other_r: float) -> float:
    """Joint ball that also swallows the member/member intersection curve.

    Two rods of radii r1 and r2 meeting at a node cut each other along a curve
    that reaches sqrt(r1^2 + r2^2) from the node.  A ball that only just clears
    the rods leaves that curve tangent to its own surface, and the manifold
    kernel then triangulates a handful of zero-area facets there (archtrusses
    index 9, 4 degenerate triangles out of 9212).  Ball radius = 1.25 x the
    worst pair distance clears it with room to spare.
    """
    worst = r_member
    for other in other_r:
        worst = max(worst, math.hypot(r_member, other) * 1.5)
    return round(max(_joint_radius(r_member), worst), 2)


def build_archtrusses(index: int) -> Part:
    """Bridge truss whose top chord follows a curve, with verticals and diagonals."""
    rng = Rng("gen3_archtrusses", index)
    variant = rng.choice(("parabola", "parabola", "segmental", "cambered"))
    panels = rng.choice([5, 6, 7, 8])
    chord_r = rng.grid([2.6, 3.0, 3.4, 3.8])
    diag_r = rng.grid([2.0, 2.4, 2.8])
    joint_r = _pair_joint(chord_r, diag_r)
    max_panel = (250.0 - 2 * joint_r - 2.0) / panels
    panel_p = round(min(rng.grid([22.0, 26.0, 30.0, 34.0]), max_panel), 1)
    span = round(panels * panel_p, 2)
    rise = round(min(span * rng.choice((0.22, 0.28, 0.34)), 95.0), 2)
    camber = round(rise * rng.choice((0.25, 0.35, 0.45)), 2)

    bottom = [(round(i * panel_p, 3), 0.0, 0.0) for i in range(panels + 1)]
    top: list[tuple[float, float, float]] = []
    for i in range(panels + 1):
        x = i * panel_p
        ratio = (x - span / 2) / (span / 2)
        if variant == "segmental":
            z = camber + rise * math.cos(math.radians(90.0 * ratio))
        elif variant == "cambered":
            z = camber + rise * (1.0 - abs(ratio) ** 2.2)
        else:
            z = camber + rise * (1.0 - ratio * ratio)
        top.append((round(x, 3), 0.0, round(z, 3)))

    builder = ScadBuilder(
        "Arched truss",
        f"span {fmt(span)} mm, rise {fmt(rise)} mm, {panels} panels",
    )
    builder.param("panels", float(panels), "number of panels")
    builder.param("panel_p", panel_p, "panel length, X")
    builder.param("span", span, "span between the end joints")
    builder.param("rise", rise, "top chord rise above the springing")
    builder.param("camber", camber, "top chord height above the bottom chord at the ends")
    builder.param("chord_r", chord_r, "chord member radius")
    builder.param("diag_r", diag_r, "diagonal radius")
    builder.param("joint_r", joint_r, "joint ball radius")

    bottom_literal = "[" + ", ".join(f"[{fmt(x, 3)}, 0, 0]" for x, _, _ in bottom) + "]"
    top_literal = "[" + ", ".join(f"[{fmt(x, 3)}, 0, {fmt(z, 3)}]" for x, _, z in top) + "]"
    lines = list(MEMBER_MODULE)
    lines += [
        "",
        "bottom = " + bottom_literal + ";",
        "top = " + top_literal + ";",
        "",
        "for (i = [0 : panels - 1]) member(bottom[i], bottom[i + 1], chord_r);",
        "for (i = [0 : panels - 1]) member(top[i], top[i + 1], chord_r);",
        "/* verticals */",
        "for (i = [1 : panels - 1]) member(bottom[i], top[i], diag_r);",
        "/* diagonals lean toward mid span */",
        "for (i = [0 : panels - 1]) {",
        "  if (i < panels / 2) {",
        "    member(bottom[i], top[i + 1], diag_r);",
        "  } else {",
        "    member(top[i], bottom[i + 1], diag_r);",
        "  }",
        "}",
        "/* joint balls */",
        "for (i = [0 : panels]) joint(bottom[i], joint_r);",
        "for (i = [0 : panels]) joint(top[i], joint_r);",
    ]
    builder.section("\n".join(lines))
    code = builder.render()

    graph = Graph()
    for i in range(panels):
        graph.edge(bottom[i], bottom[i + 1])
        graph.edge(top[i], top[i + 1])
    for i in range(1, panels):
        graph.edge(bottom[i], top[i])
    for i in range(panels):
        if i < panels / 2:
            graph.edge(bottom[i], top[i + 1])
        else:
            graph.edge(top[i], bottom[i + 1])
    bbox = _node_bbox(list(bottom) + list(top), joint_r)

    features_ru = [
        f"верхний пояс по кривой с подъёмом {fmt(rise)} мм над опорами",
        f"пролёт {fmt(span)} мм из {ru_count(panels, 'панели', 'панелей', 'панелей')}",
        f"пояс {fmt(2 * chord_r)} мм, раскосы {fmt(2 * diag_r)} мм, шары в узлах {fmt(2 * joint_r)} мм",
    ]
    features_en = [
        f"a curved top chord rising {fmt(rise)} mm above the springing",
        f"a {fmt(span)} mm span in {en_count(panels)} panels",
        f"{fmt(2 * chord_r)} mm chords, {fmt(2 * diag_r)} mm diagonals and {fmt(2 * joint_r)} mm joint balls",
    ]
    if variant == "parabola":
        features_ru.append("верхний пояс параболический, раскосы к середине пролёта")
        features_en.append("the top chord is a parabola and the diagonals lean to mid span")
    elif variant == "segmental":
        features_ru.append("верхний пояс по дуге окружности")
        features_en.append("the top chord follows a circular arc")
    else:
        features_ru.append("верхний пояс с усиленной серединой и пологими концами")
        features_en.append("the top chord is fuller at mid span and flatter at the ends")
    return finish_part3(
        rng,
        family="archtrusses",
        variant=variant,
        code=code,
        bbox=bbox,
        params={"span": span, "rise": rise, "chord_r": chord_r, "joint_r": joint_r},
        ru_nouns=ARCH_RU,
        en_nouns=ARCH_EN,
        features_ru=features_ru,
        features_en=features_en,
    ).with_graph(graph.as_json())


def build_steptowers(index: int) -> Part:
    """Tiered lattice tower: tapered legs, a ring per tier, crosses on every face."""
    rng = Rng("gen3_steptowers", index)
    variant = rng.choice(("braced", "braced", "gusseted"))
    tiers = rng.choice([3, 4, 5])
    tier_h = rng.grid([36.0, 42.0, 48.0, 56.0])
    base_w = rng.grid([56.0, 64.0, 72.0, 80.0])
    taper = rng.grid([0.82, 0.86, 0.9])
    chord_r = rng.grid([2.4, 2.8, 3.2])
    diag_r = rng.grid([2.0, 2.4, 2.8])
    joint_r = _pair_joint(chord_r, diag_r)
    heights = [round(level * tier_h, 2) for level in range(tiers + 1)]
    widths = [round(base_w * (taper**level), 2) for level in range(tiers + 1)]
    if heights[-1] + 2 * joint_r > 250.0:
        tier_h = round((250.0 - 2 * joint_r - 2.0) / tiers, 2)
        heights = [round(level * tier_h, 2) for level in range(tiers + 1)]

    builder = ScadBuilder(
        "Stepped tower",
        f"{fmt(base_w)} mm base, {tiers} tiers to {fmt(heights[-1])} mm",
    )
    builder.param("tiers", float(tiers), "number of tiers")
    builder.param("tier_h", tier_h, "tier height")
    builder.param("base_w", base_w, "bottom footprint width")
    builder.param("taper", taper, "footprint shrink per tier")
    builder.param("chord_r", chord_r, "leg radius")
    builder.param("diag_r", diag_r, "brace radius")
    builder.param("joint_r", joint_r, "joint ball radius")
    builder.assignment(
        "cx = [-1, 1, 1, -1];\ncy = [-1, -1, 1, 1];\nwidths = ["
        + ", ".join(fmt(value, 3) for value in widths)
        + "];\nheights = ["
        + ", ".join(fmt(value, 3) for value in heights)
        + "];"
    )

    lines = list(MEMBER_MODULE)
    lines += [
        "",
        "/* legs */",
        "for (l = [0 : tiers - 1]) {",
        "  for (c = [0 : 3]) {",
        "    member([cx[c] * widths[l] / 2, cy[c] * widths[l] / 2, heights[l]],"
        " [cx[c] * widths[l + 1] / 2, cy[c] * widths[l + 1] / 2, heights[l + 1]], chord_r);",
        "  }",
        "}",
        "/* ring at every level */",
        "for (l = [0 : tiers]) {",
        "  member([cx[0] * widths[l] / 2, cy[0] * widths[l] / 2, heights[l]],"
        " [cx[1] * widths[l] / 2, cy[1] * widths[l] / 2, heights[l]], diag_r);",
        "  member([cx[1] * widths[l] / 2, cy[1] * widths[l] / 2, heights[l]],"
        " [cx[2] * widths[l] / 2, cy[2] * widths[l] / 2, heights[l]], diag_r);",
        "  member([cx[2] * widths[l] / 2, cy[2] * widths[l] / 2, heights[l]],"
        " [cx[3] * widths[l] / 2, cy[3] * widths[l] / 2, heights[l]], diag_r);",
        "  member([cx[3] * widths[l] / 2, cy[3] * widths[l] / 2, heights[l]],"
        " [cx[0] * widths[l] / 2, cy[0] * widths[l] / 2, heights[l]], diag_r);",
        "}",
        "/* face crosses, one X per face per tier */",
        "for (l = [0 : tiers - 1]) {",
        "  member([cx[0] * widths[l] / 2, cy[0] * widths[l] / 2, heights[l]],"
        " [cx[1] * widths[l + 1] / 2, cy[1] * widths[l + 1] / 2, heights[l + 1]], diag_r);",
        "  member([cx[1] * widths[l] / 2, cy[1] * widths[l] / 2, heights[l]],"
        " [cx[2] * widths[l + 1] / 2, cy[2] * widths[l + 1] / 2, heights[l + 1]], diag_r);",
        "  member([cx[2] * widths[l] / 2, cy[2] * widths[l] / 2, heights[l]],"
        " [cx[3] * widths[l + 1] / 2, cy[3] * widths[l + 1] / 2, heights[l + 1]], diag_r);",
        "  member([cx[3] * widths[l] / 2, cy[3] * widths[l] / 2, heights[l]],"
        " [cx[0] * widths[l + 1] / 2, cy[0] * widths[l + 1] / 2, heights[l + 1]], diag_r);",
        "}",
        "/* joint balls */",
        "for (l = [0 : tiers]) {",
        "  for (c = [0 : 3]) joint([cx[c] * widths[l] / 2, cy[c] * widths[l] / 2, heights[l]], joint_r);",
        "}",
    ]
    builder.section("\n".join(lines))
    code = builder.render()

    signs = [(-1.0, -1.0), (1.0, -1.0), (1.0, 1.0), (-1.0, 1.0)]

    def node(level: int, corner: int):
        return (widths[level] / 2 * signs[corner][0], widths[level] / 2 * signs[corner][1], heights[level])

    graph = Graph()
    for level in range(tiers):
        for corner in range(4):
            graph.edge(node(level, corner), node(level + 1, corner))
    for level in range(tiers + 1):
        for corner in range(4):
            graph.edge(node(level, corner), node(level, (corner + 1) % 4))
    for level in range(tiers):
        for corner in range(4):
            graph.edge(node(level, corner), node(level + 1, corner))
            graph.edge(node(level, corner), node(level + 1, (corner + 1) % 4))
    bbox = _node_bbox([node(level, corner) for level in range(tiers + 1) for corner in range(4)], joint_r)

    features_ru = [
        f"{ru_count(tiers, 'ярус', 'яруса', 'ярусов')} высотой {fmt(tier_h)} мм с сужением {fmt(taper)} на ярус",
        f"четыре стойки {fmt(2 * chord_r)} мм и связи {fmt(2 * diag_r)} мм",
        f"обвязка по каждому ярусу и крестовые раскосы на всех четырёх гранях",
    ]
    features_en = [
        f"{en_count(tiers)} tiers of {fmt(tier_h)} mm with a {fmt(taper)} footprint taper",
        f"four {fmt(2 * chord_r)} mm legs and {fmt(2 * diag_r)} mm braces",
        f"a ring at every level and crosses on all four faces",
    ]
    if variant == "gusseted":
        features_ru.append("косынки усилены двойными раскосами в каждом ярусе")
        features_en.append("every tier is gusseted with a double set of braces")
    return finish_part3(
        rng,
        family="steptowers",
        variant=variant,
        code=code,
        bbox=bbox,
        params={"tiers": float(tiers), "tier_h": tier_h, "base_w": base_w, "joint_r": joint_r},
        ru_nouns=STEP_RU,
        en_nouns=STEP_EN,
        features_ru=features_ru,
        features_en=features_en,
    ).with_graph(graph.as_json())


def build_chassisframes(index: int) -> Part:
    """Chassis tube frame: rails, cross members, corner posts and face bracing."""
    rng = Rng("gen3_chassisframes", index)
    variant = rng.choice(("chassis", "chassis", "cage"))
    length = rng.grid([150.0, 170.0, 190.0, 210.0])
    width = rng.grid([70.0, 80.0, 90.0])
    height = rng.grid([45.0, 55.0, 65.0]) if variant == "cage" else rng.grid([20.0, 28.0, 36.0])
    crossings = rng.choice([2, 3, 4])
    chord_r = rng.grid([2.6, 3.0, 3.4, 3.8])
    diag_r = rng.grid([2.0, 2.4, 2.8])
    joint_r = _pair_joint(chord_r, diag_r)
    if length + 2 * joint_r > 250.0:
        length = round(250.0 - 2 * joint_r - 2.0, 1)

    xs = [round(-length / 2 + length * (index_step + 1) / (crossings + 1), 2) for index_step in range(crossings)]
    bottom = [
        (round(-length / 2, 2), round(-width / 2, 2), 0.0),
        (round(length / 2, 2), round(-width / 2, 2), 0.0),
        (round(length / 2, 2), round(width / 2, 2), 0.0),
        (round(-length / 2, 2), round(width / 2, 2), 0.0),
    ]
    top = [(x, y, round(height, 2)) for x, y, _ in bottom]

    builder = ScadBuilder(
        "Chassis frame",
        f"{fmt(length)} x {fmt(width)} mm, {fmt(height)} mm tall, {crossings} cross members",
    )
    builder.param("frame_l", length, "frame length, X")
    builder.param("frame_w", width, "frame width, Y")
    builder.param("frame_h", height, "frame height, Z")
    builder.param("crossings", float(crossings), "number of cross members")
    builder.param("chord_r", chord_r, "main tube radius")
    builder.param("diag_r", diag_r, "brace radius")
    builder.param("joint_r", joint_r, "joint ball radius")
    floor_side = 1.0 if crossings % 2 else -1.0
    floor_nodes = [
        (round(xs[index], 2), round(floor_side * (-1) ** index * width / 2, 2), 0.0) for index in range(crossings)
    ]
    builder.assignment("cross_x = [" + ", ".join(fmt(value, 3) for value in xs) + "];")
    builder.assignment(
        "floor_nodes = [" + ", ".join("[%s, %s, 0]" % (fmt(x, 3), fmt(y, 3)) for x, y, _ in floor_nodes) + "];"
    )
    builder.assignment(
        "bottom = [" + ", ".join("[%s, %s, 0]" % (fmt(x, 3), fmt(y, 3)) for x, y, _ in bottom) + "];"
    )
    builder.assignment(
        "top = [" + ", ".join("[%s, %s, %s]" % (fmt(x, 3), fmt(y, 3), fmt(z, 3)) for x, y, z in top) + "];"
    )

    lines = list(MEMBER_MODULE)
    lines += [
        "",
        "/* bottom rails, one member per side */",
        "member(bottom[0], bottom[1], chord_r);",
        "member(bottom[1], bottom[2], chord_r);",
        "member(bottom[2], bottom[3], chord_r);",
        "member(bottom[3], bottom[0], chord_r);",
        "/* cross members */",
        "for (i = [0 : crossings - 1]) {",
        "  member([cross_x[i], -frame_w / 2, 0], [cross_x[i], frame_w / 2, 0], diag_r);",
        "}",
        "/* floor zig-zag brace between the cross member ends */",
        "member(bottom[0], floor_nodes[0], diag_r);",
        "for (i = [0 : crossings - 2]) member(floor_nodes[i], floor_nodes[i + 1], diag_r);",
        "member(floor_nodes[crossings - 1], bottom[1], diag_r);",
        "/* corner posts and top ring */",
        "for (c = [0 : 3]) member(bottom[c], top[c], chord_r);",
        "member(top[0], top[1], diag_r);",
        "member(top[1], top[2], diag_r);",
        "member(top[2], top[3], diag_r);",
        "member(top[3], top[0], diag_r);",
        "/* face crosses on the two long sides */",
        "member(bottom[0], top[1], diag_r);",
        "member(top[0], bottom[1], diag_r);",
        "member(bottom[3], top[2], diag_r);",
        "member(top[3], bottom[2], diag_r);",
        "/* joint balls */",
        "for (c = [0 : 3]) joint(bottom[c], joint_r);",
        "for (c = [0 : 3]) joint(top[c], joint_r);",
        "for (i = [0 : crossings - 1]) joint([cross_x[i], -frame_w / 2, 0], joint_r);",
        "for (i = [0 : crossings - 1]) joint([cross_x[i], frame_w / 2, 0], joint_r);",
    ]
    builder.section("\n".join(lines))
    code = builder.render()

    graph = Graph()
    for corner in range(4):
        graph.edge(bottom[corner], bottom[(corner + 1) % 4])
        graph.edge(top[corner], top[(corner + 1) % 4])
        graph.edge(bottom[corner], top[corner])
    for value in xs:
        graph.edge((value, -width / 2, 0.0), (value, width / 2, 0.0))
    graph.edge(bottom[0], floor_nodes[0])
    for index in range(crossings - 1):
        graph.edge(floor_nodes[index], floor_nodes[index + 1])
    graph.edge(floor_nodes[-1], bottom[1])
    graph.edge(bottom[0], top[1])
    graph.edge(top[0], bottom[1])
    graph.edge(bottom[3], top[2])
    graph.edge(top[3], bottom[2])
    bbox = _node_bbox(
        list(bottom) + list(top) + [(value, -width / 2, 0.0) for value in xs] + [(value, width / 2, 0.0) for value in xs],
        joint_r,
    )

    features_ru = [
        f"продольные лонжероны и {ru_count(crossings, 'поперечина', 'поперечины', 'поперечин')} {fmt(2 * diag_r)} мм",
        f"стойки по углам на высоту {fmt(height)} мм и верхняя обвязка",
        f"трубы {fmt(2 * chord_r)} мм, раскосы {fmt(2 * diag_r)} мм, шары {fmt(2 * joint_r)} мм в узлах",
    ]
    features_en = [
        f"long rails plus {en_count(crossings)} {fmt(2 * diag_r)} mm cross members",
        f"{fmt(height)} mm corner posts with a top ring",
        f"{fmt(2 * chord_r)} mm tubes, {fmt(2 * diag_r)} mm braces and {fmt(2 * joint_r)} mm joint balls",
    ]
    if variant == "cage":
        features_ru.append("высокий каркас с раскосами по обоим бортам")
        features_en.append("a tall cage with bracing on both sides")
    return finish_part3(
        rng,
        family="chassisframes",
        variant=variant,
        code=code,
        bbox=bbox,
        params={"length": length, "width": width, "height": height, "joint_r": joint_r},
        ru_nouns=CHASSIS_RU,
        en_nouns=CHASSIS_EN,
        features_ru=features_ru,
        features_en=features_en,
    ).with_graph(graph.as_json())


def build_scissorgrids(index: int) -> Part:
    """Scissor / diamond lattice: an m x n grid of cells, each with an X brace."""
    rng = Rng("gen3_scissorgrids", index)
    variant = rng.choice(("3x3", "4x4", "3x4", "4x3"))
    columns, rows = {"3x3": (3, 3), "4x4": (4, 4), "3x4": (3, 4), "4x3": (4, 3)}[variant]
    cell = rng.grid([42.0, 48.0, 54.0, 60.0])
    chord_r = rng.grid([2.6, 3.0, 3.4])
    diag_r = rng.grid([2.0, 2.4, 2.8])
    joint_r = _pair_joint(chord_r, diag_r)
    span_x = columns * cell
    span_y = rows * cell
    if max(span_x, span_y) + 2 * joint_r > 250.0:
        cell = round((250.0 - 2 * joint_r - 2.0) / max(columns, rows), 1)
        span_x = columns * cell
        span_y = rows * cell

    builder = ScadBuilder(
        "Scissor lattice",
        f"{variant.replace('x', ' x ')} cells of {fmt(cell)} mm, {fmt(span_x)} x {fmt(span_y)} mm",
    )
    builder.param("columns", float(columns), "cells along X")
    builder.param("rows", float(rows), "cells along Y")
    builder.param("cell", cell, "cell size")
    builder.param("chord_r", chord_r, "boundary chord radius")
    builder.param("diag_r", diag_r, "diagonal radius")
    builder.param("joint_r", joint_r, "joint ball radius")

    lines = list(MEMBER_MODULE)
    lines += [
        "",
        "/* X braces, one pair per cell */",
        "for (i = [0 : columns - 1]) {",
        "  for (j = [0 : rows - 1]) {",
        "    member([i * cell, j * cell, 0], [(i + 1) * cell, (j + 1) * cell, 0], diag_r);",
        "    member([(i + 1) * cell, j * cell, 0], [i * cell, (j + 1) * cell, 0], diag_r);",
        "  }",
        "}",
        "/* boundary chords */",
        "for (i = [0 : columns - 1]) {",
        "  member([i * cell, 0, 0], [(i + 1) * cell, 0, 0], chord_r);",
        "  member([i * cell, rows * cell, 0], [(i + 1) * cell, rows * cell, 0], chord_r);",
        "}",
        "for (j = [0 : rows - 1]) {",
        "  member([0, j * cell, 0], [0, (j + 1) * cell, 0], chord_r);",
        "  member([columns * cell, j * cell, 0], [columns * cell, (j + 1) * cell, 0], chord_r);",
        "}",
        "/* joint balls at every grid corner */",
        "for (i = [0 : columns]) {",
        "  for (j = [0 : rows]) joint([i * cell, j * cell, 0], joint_r);",
        "}",
    ]
    builder.section("\n".join(lines))
    code = builder.render()

    graph = Graph()
    for i in range(columns):
        graph.edge((i * cell, 0.0, 0.0), ((i + 1) * cell, 0.0, 0.0))
        graph.edge((i * cell, rows * cell, 0.0), ((i + 1) * cell, rows * cell, 0.0))
    for j in range(rows):
        graph.edge((0.0, j * cell, 0.0), (0.0, (j + 1) * cell, 0.0))
        graph.edge((columns * cell, j * cell, 0.0), (columns * cell, (j + 1) * cell, 0.0))
    for i in range(columns):
        for j in range(rows):
            graph.edge((i * cell, j * cell, 0.0), ((i + 1) * cell, (j + 1) * cell, 0.0))
            graph.edge(((i + 1) * cell, j * cell, 0.0), (i * cell, (j + 1) * cell, 0.0))
    corners = [(i * cell, j * cell, 0.0) for i in range(columns + 1) for j in range(rows + 1)]
    bbox = _node_bbox(corners, joint_r)

    features_ru = [
        f"сетка {columns} на {rows} ячеек по {fmt(cell)} мм",
        f"крестовые раскосы {fmt(2 * diag_r)} мм в каждой ячейке",
        f"контурные связи {fmt(2 * chord_r)} мм и шары {fmt(2 * joint_r)} мм во всех узлах",
    ]
    features_en = [
        f"a {columns} by {rows} grid of {fmt(cell)} mm cells",
        f"X bracing {fmt(2 * diag_r)} mm across every cell",
        f"{fmt(2 * chord_r)} mm boundary chords and {fmt(2 * joint_r)} mm joint balls at every node",
    ]
    return finish_part3(
        rng,
        family="scissorgrids",
        variant=variant,
        code=code,
        bbox=bbox,
        params={"columns": float(columns), "rows": float(rows), "cell": cell, "joint_r": joint_r},
        ru_nouns=SCISSOR_RU,
        en_nouns=SCISSOR_EN,
        features_ru=features_ru,
        features_en=features_en,
    ).with_graph(graph.as_json())
