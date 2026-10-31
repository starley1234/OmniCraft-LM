"""Wire families: lattices whose manifest row carries a node/edge graph.

Members are drawn as cylinders between the joint centres, joints as balls that
are slightly fatter than the members.  The members end exactly at the joint
centres, so every member is buried inside its joint ball - the union is one
solid with a strictly positive overlap at every node, and the graph nodes are
exactly the coordinates that appear in the code.

Hull-based capsules were tried first and rejected: the convex hull of two
spheres can leave hair-thin flap artefacts when the shells meet nearly
tangentially, and the result then decomposes into more than one solid.
"""

from __future__ import annotations

import math

from tools.dataset_gen2.common import Graph, Part, Rng, ScadBuilder, finish_part, fmt
from tools.dataset_gen2.prompts import en_count, ru_count

MEMBER_MODULE = (
    "module member(a, b, r) {",
    "  /* rod: cylinder from joint a to joint b */",
    "  d = b - a;",
    "  length = norm(d);",
    "  translate(a) rotate([0, acos(d[2] / length), atan2(d[1], d[0])])",
    "    cylinder(h = length, r = r);",
    "}",
    "",
    "module joint(p, r) {",
    "  /* ball at the joint centre */",
    "  translate(p) sphere(r = r);",
    "}",
)

TRUSS_RU = (
    "плоская ферма", "ферма с параллельными поясами", "сварная ферма", "решетчатая балка",
    "строительная ферма", "ферма пролетного строения",
)
TRUSS_EN = (
    "flat truss", "parallel-chord truss", "welded lattice girder", "truss beam",
    "roof truss", "lattice frame",
)
TOWER_RU = (
    "четырехногая башня", "пространственная опора", "решетчатая стойка", "башня с раскосами",
    "ферменная опора", "каркасная вышка",
)
TOWER_EN = (
    "four-leg tower", "lattice tower", "space frame column", "braced mast",
    "truss support", "open frame tower",
)
QUAD_RU = (
    "рама квадрокоптера", "лучевая рама дрона", "рама с четырьмя лучами", "плата-рама с лучами",
    "основание дрона", "несущая рама квадрокоптера",
)
QUAD_EN = (
    "quadcopter frame", "drone arm frame", "four-arm plate", "rotor frame plate",
    "drone chassis plate", "quad frame",
)
BEAM_RU = (
    "двутавровая балка", "решетчатая балка", "сварной двутавр", "балка с поясами",
    "балка двутаврового профиля", "прогон перекрытия",
)
BEAM_EN = (
    "I-beam", "lattice I-beam", "welded joist", "flanged beam",
    "lattice girder", "built-up beam",
)
PIPE_RU = (
    "трубная трасса", "трубопровод с отводами", "змеевик", "труба с поворотами",
    "участок трубопровода", "гнутая труба",
)
PIPE_EN = (
    "pipe route", "bent pipe run", "pipe with elbows", "tubing run",
    "pipe spool", "bent tube section",
)


def _node_bbox(nodes, joint_r: float):
    """Bounding box of a set of joint balls of a common radius."""
    xs = [point[0] - joint_r for point in nodes] + [point[0] + joint_r for point in nodes]
    ys = [point[1] - joint_r for point in nodes] + [point[1] + joint_r for point in nodes]
    zs = [point[2] - joint_r for point in nodes] + [point[2] + joint_r for point in nodes]
    return (round(max(xs) - min(xs), 2), round(max(ys) - min(ys), 2), round(max(zs) - min(zs), 2))


def _joint_radius(member_r: float, extra: float = 0.0) -> float:
    """Joint balls stay at least 0.4 mm fatter than the fattest member."""
    return round(max(member_r + 0.4, member_r * 1.2) + extra, 2)


# ---------------------------------------------------------------------------
# flat trusses
# ---------------------------------------------------------------------------


def build_trusses(index: int) -> Part:
    rng = Rng("trusses", index)
    variant = rng.choice(("pratt", "warren", "howe", "warren", "pratt"))
    panels = rng.choice([4, 5, 6, 7, 8])
    chord_r = rng.grid([3.0, 3.5, 4.0, 5.0])
    diag_r = rng.grid([2.6, 3.0, 3.4])
    vert_r = diag_r
    joint_r = _joint_radius(chord_r)
    # joint balls add to both ends, so the span stays inside the 250 mm ceiling
    max_panel = (250.0 - 2 * joint_r - 2.0) / panels
    panel_p = round(min(rng.grid([20.0, 25.0, 30.0, 35.0, 40.0]), max_panel), 1)
    span = round(panels * panel_p, 2)
    frame_h = round(min(rng.grid([40.0, 50.0, 60.0, 70.0, 80.0, 90.0, 100.0]), span * 0.6), 1)
    frame_h = max(frame_h, 30.0)
    with_verticals = variant in ("pratt", "howe")

    title = {"pratt": "Pratt truss", "howe": "Howe truss", "warren": "Warren truss"}[variant]
    builder = ScadBuilder(
        title, f"span {fmt(span)} mm, height {fmt(frame_h)} mm, {panels} equal panels"
    )
    builder.param("panels", float(panels), "number of equal panels")
    builder.param("panel_p", panel_p, "panel length, X")
    builder.param("span", span, "span between the end joints")
    builder.param("frame_h", frame_h, "truss height, Z")
    builder.param("chord_r", chord_r, "chord member radius")
    builder.param("diag_r", diag_r, "diagonal member radius")
    if with_verticals:
        builder.param("vert_r", vert_r, "vertical post radius")
    builder.param("joint_r", joint_r, "joint ball radius")

    lines = list(MEMBER_MODULE)
    lines += [
        "",
        "bottom = [for (i = [0 : panels]) [i * panel_p, 0, 0]];",
    ]
    if variant == "warren":
        lines.append("top = [for (i = [0 : panels - 1]) [i * panel_p + panel_p / 2, 0, frame_h]];")
    else:
        lines.append("top = [for (i = [0 : panels]) [i * panel_p, 0, frame_h]];")
    top_last = panels - 2 if variant == "warren" else panels - 1
    lines += [
        "",
        "for (i = [0 : panels - 1]) member(bottom[i], bottom[i + 1], chord_r);",
        f"for (i = [0 : {top_last}]) member(top[i], top[i + 1], chord_r);",
    ]
    if variant == "warren":
        lines += [
            "",
            "/* zig-zag diagonals up to the mid-panel joints */",
            "for (i = [0 : panels - 1]) {",
            "  member(bottom[i], top[i], diag_r);",
            "  member(bottom[i + 1], top[i], diag_r);",
            "}",
        ]
    else:
        lines += [
            "",
            "/* vertical posts */",
            "for (i = [1 : panels - 1]) member(bottom[i], top[i], vert_r);",
            "",
            "/* diagonals " + ("lean toward" if variant == "pratt" else "lean away from") + " mid-span */",
            "for (i = [0 : panels - 1]) {",
            "  if (i < panels / 2) {",
        ]
        if variant == "pratt":
            lines += [
                "    member(bottom[i], top[i + 1], diag_r);",
                "  } else {",
                "    member(top[i], bottom[i + 1], diag_r);",
            ]
        else:
            lines += [
                "    member(top[i], bottom[i + 1], diag_r);",
                "  } else {",
                "    member(bottom[i], top[i + 1], diag_r);",
            ]
        lines += ["  }", "}"]
    lines += [
        "",
        "/* joint balls */",
        "for (i = [0 : panels]) joint(bottom[i], joint_r);",
        f"for (i = [0 : {panels if variant != 'warren' else panels - 1}]) joint(top[i], joint_r);",
    ]
    builder.section("\n".join(lines))
    code = builder.render()

    bottom = [(i * panel_p, 0.0, 0.0) for i in range(panels + 1)]
    if variant == "warren":
        top = [(i * panel_p + panel_p / 2, 0.0, frame_h) for i in range(panels)]
    else:
        top = [(i * panel_p, 0.0, frame_h) for i in range(panels + 1)]
    graph = Graph()
    for i in range(panels):
        graph.edge(bottom[i], bottom[i + 1])
    for i in range(top_last + 1):
        graph.edge(top[i], top[i + 1])
    if variant == "warren":
        for i in range(panels):
            graph.edge(bottom[i], top[i])
            graph.edge(bottom[i + 1], top[i])
    else:
        for i in range(1, panels):
            graph.edge(bottom[i], top[i])
        for i in range(panels):
            leaning_toward_centre = (variant == "pratt") == (i < panels / 2)
            if leaning_toward_centre:
                graph.edge(bottom[i], top[i + 1])
            else:
                graph.edge(top[i], bottom[i + 1])
    bbox = _node_bbox(list(bottom) + list(top), joint_r)

    style_ru = {
        "pratt": "раскосы наклонены к середине пролёта, стойки вертикальные",
        "howe": "раскосы наклонены от середины к опорам, стойки вертикальные",
        "warren": "зигзагообразные раскосы без стоек",
    }[variant]
    style_en = {
        "pratt": "diagonals leaning toward mid-span with vertical posts",
        "howe": "diagonals leaning away from mid-span with vertical posts",
        "warren": "zig-zag diagonals without posts",
    }[variant]
    features_ru = [
        f"{ru_count(panels, 'равная панель', 'равные панели', 'равных панелей')} по {fmt(panel_p)} мм",
        f"пояса из стержней диаметром {fmt(2 * chord_r)} мм",
        f"{style_ru}",
    ]
    features_en = [
        f"{en_count(panels)} equal panels of {fmt(panel_p)} mm",
        f"chords of {fmt(2 * chord_r)} mm round stock",
        f"{style_en}",
    ]
    return finish_part(
        rng,
        family="trusses",
        variant=variant,
        code=code,
        bbox=bbox,
        params={
            "span": span,
            "panel_p": panel_p,
            "panels": panels,
            "frame_h": frame_h,
            "chord_r": chord_r,
            "diag_r": diag_r,
            "joint_r": joint_r,
        },
        ru_nouns=TRUSS_RU,
        en_nouns=TRUSS_EN,
        features_ru=features_ru,
        features_en=features_en,
        feature_count=(3, 3),
    ).with_graph(graph.as_json())


# ---------------------------------------------------------------------------
# four-leg towers
# ---------------------------------------------------------------------------


def build_towers(index: int) -> Part:
    rng = Rng("towers", index)
    variant = rng.choice(("z_braces", "z_braces", "x_braces", "rings"))
    levels = rng.choice([3, 4, 5])
    size = rng.grid([40.0, 50.0, 60.0, 80.0, 100.0])
    leg_r = rng.grid([4.0, 4.5, 5.0, 6.0])
    brace_r = rng.grid([2.6, 3.0, 3.4])
    joint_r = _joint_radius(leg_r)
    # joint balls stick out at both ends: keep the whole tower under 250 mm
    max_level = (250.0 - 2 * joint_r - 2.0) / levels
    lvl = round(min(rng.grid([40.0, 50.0, 60.0, 70.0, 80.0]), max_level), 1)
    tower_h = round(levels * lvl, 2)
    top_plate = rng.chance(0.5)
    plate_t = rng.grid([5.0, 6.0, 7.0]) if top_plate else 0.0
    plate_hole_d = rng.grid([6.6, 8.4, 9.0]) if top_plate else 0.0
    inset = 12.0

    builder = ScadBuilder(
        "Four-leg tower",
        f"{fmt(size)} x {fmt(size)} x {fmt(tower_h)} mm, {levels} bays of {fmt(lvl)} mm",
    )
    builder.param("size", size, "footprint across the legs")
    builder.param("lvl", lvl, "bay height between the rings")
    builder.param("levels", float(levels), "number of bays")
    builder.param("tower_h", tower_h, "overall height")
    builder.param("leg_r", leg_r, "leg tube radius")
    builder.param("brace_r", brace_r, "brace tube radius")
    builder.param("joint_r", joint_r, "joint ball radius")
    if top_plate:
        builder.param("plate_t", plate_t, "top plate thickness")
        builder.param("plate_hole_d", plate_hole_d, "top plate bolt holes")
        builder.param("inset", inset, "bolt hole inset from the corner")

    lines = list(MEMBER_MODULE)
    lines += [
        "",
        "p = [[1, 1], [1, -1], [-1, -1], [-1, 1]];",
        "",
        "/* legs */",
        "for (i = [0 : levels - 1]) {",
        "  for (j = [0 : 3]) {",
        "    member([p[j][0] * size / 2, p[j][1] * size / 2, i * lvl],",
        "           [p[j][0] * size / 2, p[j][1] * size / 2, (i + 1) * lvl], leg_r);",
        "  }",
        "}",
        "",
        "/* rings at every level */",
        "for (i = [0 : levels]) {",
        "  for (j = [0 : 3]) {",
        "    member([p[j][0] * size / 2, p[j][1] * size / 2, i * lvl],",
        "           [p[(j + 1) % 4][0] * size / 2, p[(j + 1) % 4][1] * size / 2, i * lvl], brace_r);",
        "  }",
        "}",
    ]
    if variant == "x_braces":
        lines += [
            "",
            "/* cross bracing in every bay */",
            "for (i = [0 : levels - 1]) {",
            "  for (j = [0 : 3]) {",
            "    member([p[j][0] * size / 2, p[j][1] * size / 2, i * lvl],",
            "           [p[(j + 1) % 4][0] * size / 2, p[(j + 1) % 4][1] * size / 2, (i + 1) * lvl], brace_r);",
            "    member([p[(j + 1) % 4][0] * size / 2, p[(j + 1) % 4][1] * size / 2, i * lvl],",
            "           [p[j][0] * size / 2, p[j][1] * size / 2, (i + 1) * lvl], brace_r);",
            "  }",
            "}",
        ]
    elif variant == "z_braces":
        lines += [
            "",
            "/* braces alternate direction bay by bay */",
            "for (i = [0 : levels - 1]) {",
            "  for (j = [0 : 3]) {",
            "    if (i % 2 == 0) {",
            "      member([p[j][0] * size / 2, p[j][1] * size / 2, i * lvl],",
            "             [p[(j + 1) % 4][0] * size / 2, p[(j + 1) % 4][1] * size / 2, (i + 1) * lvl], brace_r);",
            "    } else {",
            "      member([p[(j + 1) % 4][0] * size / 2, p[(j + 1) % 4][1] * size / 2, i * lvl],",
            "             [p[j][0] * size / 2, p[j][1] * size / 2, (i + 1) * lvl], brace_r);",
            "    }",
            "  }",
            "}",
        ]
    lines += [
        "",
        "/* joint balls */",
        "for (i = [0 : levels]) {",
        "  for (j = [0 : 3]) {",
        "    joint([p[j][0] * size / 2, p[j][1] * size / 2, i * lvl], joint_r);",
        "  }",
        "}",
    ]
    if top_plate:
        lines += [
            "",
            "module top_plate() {",
            "  /* sunk 1 mm into the top ring so the joint overlaps */",
            "  translate([-size / 2, -size / 2, tower_h - 1]) cube([size, size, plate_t + 1]);",
            "}",
            "",
            "difference() {",
            "  top_plate();",
            "  for (sx = [-1, 1]) for (sy = [-1, 1])",
            "    translate([sx * (size / 2 - inset), sy * (size / 2 - inset), tower_h - 2])",
            "      cylinder(h = plate_t + 3, d = plate_hole_d);",
            "}",
        ]
    builder.section("\n".join(lines))
    code = builder.render()

    corners = [(1, 1), (1, -1), (-1, -1), (-1, 1)]
    graph = Graph()
    for level in range(levels + 1):
        for j in range(4):
            start, end = corners[j], corners[(j + 1) % 4]
            graph.edge(
                (start[0] * size / 2, start[1] * size / 2, level * lvl),
                (end[0] * size / 2, end[1] * size / 2, level * lvl),
            )
    for level in range(levels):
        for j in range(4):
            start, end = corners[j], corners[(j + 1) % 4]
            graph.edge(
                (start[0] * size / 2, start[1] * size / 2, level * lvl),
                (start[0] * size / 2, start[1] * size / 2, (level + 1) * lvl),
            )
            if variant == "x_braces":
                graph.edge(
                    (start[0] * size / 2, start[1] * size / 2, level * lvl),
                    (end[0] * size / 2, end[1] * size / 2, (level + 1) * lvl),
                )
                graph.edge(
                    (end[0] * size / 2, end[1] * size / 2, level * lvl),
                    (start[0] * size / 2, start[1] * size / 2, (level + 1) * lvl),
                )
            elif variant == "z_braces":
                if level % 2 == 0:
                    graph.edge(
                        (start[0] * size / 2, start[1] * size / 2, level * lvl),
                        (end[0] * size / 2, end[1] * size / 2, (level + 1) * lvl),
                    )
                else:
                    graph.edge(
                        (end[0] * size / 2, end[1] * size / 2, level * lvl),
                        (start[0] * size / 2, start[1] * size / 2, (level + 1) * lvl),
                    )

    nodes = [(cx * size / 2, cy * size / 2, level * lvl) for level in range(levels + 1) for cx, cy in corners]
    bbox = _node_bbox(nodes, joint_r)
    plate_top = tower_h - 1.0 + plate_t if top_plate else 0.0
    if top_plate:
        bbox = (
            max(bbox[0], round(size, 2)),
            max(bbox[1], round(size, 2)),
            round(max(tower_h + joint_r, plate_top) + joint_r, 2),
        )
    pattern_ru = {
        "z_braces": "раскосы переменного направления по ярусам",
        "x_braces": "крестовые раскосы в каждой ячейке",
        "rings": "только стойки и горизонтальные связи",
    }[variant]
    pattern_en = {
        "z_braces": "diagonal braces alternating direction bay by bay",
        "x_braces": "cross bracing in every bay",
        "rings": "legs and horizontal rings only",
    }[variant]
    features_ru = [
        f"{ru_count(levels, 'ярус', 'яруса', 'ярусов')} по {fmt(lvl)} мм",
        f"опоры из трубы диаметром {fmt(2 * leg_r)} мм",
        pattern_ru,
    ]
    features_en = [
        f"{en_count(levels)} bays of {fmt(lvl)} mm",
        f"{fmt(2 * leg_r)} mm leg tubes",
        pattern_en,
    ]
    if top_plate:
        features_ru.append(f"верхняя плита {fmt(plate_t)} мм с отверстиями {fmt(plate_hole_d)} мм")
        features_en.append(f"a {fmt(plate_t)} mm top plate with {fmt(plate_hole_d)} mm bolt holes")
    return finish_part(
        rng,
        family="towers",
        variant=variant,
        code=code,
        bbox=bbox,
        params={
            "size": size,
            "lvl": lvl,
            "levels": levels,
            "tower_h": tower_h,
            "leg_r": leg_r,
            "brace_r": brace_r,
            "joint_r": joint_r,
        },
        ru_nouns=TOWER_RU,
        en_nouns=TOWER_EN,
        features_ru=features_ru,
        features_en=features_en,
        feature_count=(3, 3),
    ).with_graph(graph.as_json())


# ---------------------------------------------------------------------------
# quadcopter frames
# ---------------------------------------------------------------------------

MOTOR_TABLE = (
    (16.0, 19.0, 3.4),
    (19.0, 19.0, 3.4),
    (25.0, 25.0, 3.4),
    (16.0, 16.0, 3.0),
)


def build_quad_frames(index: int) -> Part:
    rng = Rng("quad_frames", index)
    pattern = rng.choice(("x", "x", "h"))
    hub = rng.grid([40.0, 50.0, 60.0, 70.0, 80.0])
    plate_t = rng.grid([5.0, 6.0, 7.0])
    arm_len = rng.grid([60.0, 80.0, 100.0, 110.0])
    bar_w = rng.grid([10.0, 12.0, 14.0, 16.0])
    hole_x, hole_y, hole_d = rng.choice(MOTOR_TABLE)
    pad_d = round(max(rng.grid([24.0, 28.0, 32.0]), math.hypot(hole_x, hole_y) + 8.0), 2)
    # the pads set the diagonal span: keep it under the 250 mm ceiling
    arm_len = round(min(arm_len, 125.0 - pad_d / 2 - 1.0), 2)
    motor_holes = rng.chance(0.85)
    centre_cut = rng.chance(0.6)
    centre_d = round(min(hub * 0.45, 34.0), 2)
    angles = (45.0, 135.0, 225.0, 315.0) if pattern == "x" else (0.0, 90.0, 180.0, 270.0)
    joint_r = _joint_radius(min(bar_w, plate_t * 1.5))
    corner_r = round(arm_len + pad_d / 2, 2)

    builder = ScadBuilder(
        "Quadcopter frame",
        f"{fmt(2 * corner_r)} mm across the motor pads, arms {fmt(arm_len)} mm",
    )
    builder.param("hub", hub, "central plate size")
    builder.param("plate_t", plate_t, "plate thickness")
    builder.param("arm_len", arm_len, "hub centre to motor pad centre")
    builder.param("bar_w", bar_w, "arm width")
    builder.param("pad_d", pad_d, "motor pad diameter")
    if motor_holes:
        builder.param("hole_x", hole_x, "motor bolt spacing, X")
        builder.param("hole_y", hole_y, "motor bolt spacing, Y")
        builder.param("hole_d", hole_d, "motor bolt clearance")
    if centre_cut:
        builder.param("centre_d", centre_d, "central cut-out for the stack")

    lines = [
        "module arm_bar() {",
        "  /* flat bar: hull of a stub inside the hub and a box at the pad */",
        "  hull() {",
        "    translate([hub / 4, 0, plate_t / 2]) cube([bar_w, bar_w, plate_t], center = true);",
        "    translate([arm_len, 0, plate_t / 2]) cube([bar_w, bar_w, plate_t], center = true);",
        "  }",
        "}",
        "",
        "module pad() {",
        "  translate([arm_len, 0, 0]) cylinder(h = plate_t, d = pad_d);",
        "}",
        "",
        "module frame() {",
        "  translate([-hub / 2, -hub / 2, 0]) cube([hub, hub, plate_t]);",
    ]
    for angle in angles:
        lines.append(f"  rotate([0, 0, {fmt(angle)}]) arm_bar();")
        lines.append(f"  rotate([0, 0, {fmt(angle)}]) pad();")
    lines.append("}")
    lines.append("")
    lines.append("difference() {")
    lines.append("  frame();")
    if motor_holes:
        lines.append(f"  for (a = [0 : 3]) rotate([0, 0, a * 90 + {fmt(angles[0])}])")
        lines.append("    for (sx = [-1, 1]) for (sy = [-1, 1])")
        lines.append(
            "      translate([arm_len + sx * hole_x / 2, sy * hole_y / 2, -1])"
            " cylinder(h = plate_t + 2, d = hole_d);"
        )
    if centre_cut:
        lines.append("  translate([0, 0, -1]) cylinder(h = plate_t + 2, d = centre_d);")
    lines.append("}")
    builder.section("\n".join(lines))
    code = builder.render()

    graph = Graph()
    graph.node((0.0, 0.0, plate_t / 2))
    for angle in angles:
        radians = math.radians(angle)
        graph.edge(
            (0.0, 0.0, plate_t / 2),
            (arm_len * math.cos(radians), arm_len * math.sin(radians), plate_t / 2),
        )

    points: list[tuple[float, float]] = [
        (-hub / 2, -hub / 2),
        (hub / 2, -hub / 2),
        (hub / 2, hub / 2),
        (-hub / 2, hub / 2),
    ]
    for angle in angles:
        radians = math.radians(angle)
        centre_x = arm_len * math.cos(radians)
        centre_y = arm_len * math.sin(radians)
        for radius in (hub / 4, arm_len):
            for corner_x in (-bar_w / 2, bar_w / 2):
                for corner_y in (-bar_w / 2, bar_w / 2):
                    points.append(
                        (
                            radius * math.cos(radians) - corner_x * math.sin(radians) + corner_y * math.sin(radians)
                            if False
                            else radius * math.cos(radians) + corner_x * math.cos(radians) - corner_y * math.sin(radians),
                            radius * math.sin(radians) + corner_x * math.sin(radians) + corner_y * math.cos(radians),
                        )
                    )
        # the pad is a disc of radius pad_d / 2 around the arm tip centre
        points.append((centre_x - pad_d / 2, centre_y))
        points.append((centre_x + pad_d / 2, centre_y))
        points.append((centre_x, centre_y - pad_d / 2))
        points.append((centre_x, centre_y + pad_d / 2))
    x_min = min(point[0] for point in points)
    x_max = max(point[0] for point in points)
    y_min = min(point[1] for point in points)
    y_max = max(point[1] for point in points)
    bbox = (round(x_max - x_min, 2), round(y_max - y_min, 2), float(plate_t))

    shape_ru = "X-образная" if pattern == "x" else "H-образная"
    shape_en = "X" if pattern == "x" else "H"
    features_ru = [
        f"{shape_ru} рама с лучами {fmt(arm_len)} мм от центра",
        f"площадки {fmt(pad_d)} мм под моторы",
        f"плита {fmt(hub)} мм толщиной {fmt(plate_t)} мм",
    ]
    features_en = [
        f"{shape_en}-frame with arms {fmt(arm_len)} mm long",
        f"{fmt(pad_d)} mm motor pads",
        f"a {fmt(hub)} mm plate {fmt(plate_t)} mm thick",
    ]
    if motor_holes:
        features_ru.append(
            f"в каждой площадке четыре отверстия {fmt(hole_d)} мм по схеме "
            f"{fmt(hole_x)}x{fmt(hole_y)} мм"
        )
        features_en.append(
            f"each pad takes four {fmt(hole_d)} mm bolts on a {fmt(hole_x)}x{fmt(hole_y)} mm pattern"
        )
    if centre_cut:
        features_ru.append(f"центральный вырез {fmt(centre_d)} мм под стойку")
        features_en.append(f"a {fmt(centre_d)} mm central cut-out for the stack")
    return finish_part(
        rng,
        family="quadframes",
        variant=f"{pattern}_frame",
        code=code,
        bbox=bbox,
        params={
            "hub": hub,
            "plate_t": plate_t,
            "arm_len": arm_len,
            "bar_w": bar_w,
            "pad_d": pad_d,
        },
        ru_nouns=QUAD_RU,
        en_nouns=QUAD_EN,
        features_ru=features_ru,
        features_en=features_en,
        feature_count=(3, 4),
    ).with_graph(graph.as_json())


# ---------------------------------------------------------------------------
# lattice I-beams (twin flanges + zig-zag web)
# ---------------------------------------------------------------------------


def build_i_beams(index: int) -> Part:
    rng = Rng("i_beams", index)
    panels = rng.choice([4, 5, 6, 8])
    flange_r = rng.grid([3.0, 3.5, 4.0, 5.0])
    web_r = rng.grid([2.6, 3.0, 3.4])
    joint_r = _joint_radius(flange_r)
    max_panel = (250.0 - 2 * joint_r - 2.0) / panels
    panel_p = round(min(rng.grid([20.0, 25.0, 30.0, 40.0]), max_panel), 1)
    length = round(panels * panel_p, 2)
    beam_h = round(max(rng.grid([20.0, 25.0, 30.0, 40.0, 50.0, 60.0]), flange_r * 4), 1)

    builder = ScadBuilder(
        "Lattice I-beam", f"{fmt(length)} mm long, {fmt(beam_h)} mm deep, {panels} panels"
    )
    builder.param("panels", float(panels), "number of web panels")
    builder.param("panel_p", panel_p, "panel length, X")
    builder.param("length", length, "beam length")
    builder.param("beam_h", beam_h, "depth between the flange axes")
    builder.param("flange_r", flange_r, "flange tube radius")
    builder.param("web_r", web_r, "web brace radius")
    builder.param("joint_r", joint_r, "joint ball radius")

    lines = list(MEMBER_MODULE)
    lines += [
        "",
        "bottom = [for (i = [0 : panels]) [i * panel_p, 0, 0]];",
        "top = [for (i = [0 : panels]) [i * panel_p, 0, beam_h]];",
        "",
        "/* flanges */",
        "for (i = [0 : panels - 1]) {",
        "  member(bottom[i], bottom[i + 1], flange_r);",
        "  member(top[i], top[i + 1], flange_r);",
        "}",
        "",
        "/* continuous zig-zag web */",
        "for (i = [0 : panels - 1]) {",
        "  if (i % 2 == 0) {",
        "    member(bottom[i], top[i + 1], web_r);",
        "  } else {",
        "    member(top[i], bottom[i + 1], web_r);",
        "  }",
        "}",
        "",
        "/* joint balls */",
        "for (i = [0 : panels]) {",
        "  joint(bottom[i], joint_r);",
        "  joint(top[i], joint_r);",
        "}",
    ]
    builder.section("\n".join(lines))
    code = builder.render()

    bottom = [(i * panel_p, 0.0, 0.0) for i in range(panels + 1)]
    top = [(i * panel_p, 0.0, beam_h) for i in range(panels + 1)]
    graph = Graph()
    for i in range(panels):
        graph.edge(bottom[i], bottom[i + 1])
        graph.edge(top[i], top[i + 1])
    for i in range(panels):
        if i % 2 == 0:
            graph.edge(bottom[i], top[i + 1])
        else:
            graph.edge(top[i], bottom[i + 1])
    bbox = _node_bbox(list(bottom) + list(top), joint_r)

    features_ru = [
        f"два пояса из трубы диаметром {fmt(2 * flange_r)} мм",
        f"зигзагообразная решетка шагом {fmt(panel_p)} мм",
        f"высота балки по осям поясов {fmt(beam_h)} мм",
    ]
    features_en = [
        f"two {fmt(2 * flange_r)} mm chord tubes",
        f"zig-zag web on a {fmt(panel_p)} mm pitch",
        f"{fmt(beam_h)} mm depth between the chord axes",
    ]
    return finish_part(
        rng,
        family="ibeams",
        variant=f"{panels}p",
        code=code,
        bbox=bbox,
        params={
            "length": length,
            "panels": panels,
            "panel_p": panel_p,
            "beam_h": beam_h,
            "flange_r": flange_r,
            "web_r": web_r,
            "joint_r": joint_r,
        },
        ru_nouns=BEAM_RU,
        en_nouns=BEAM_EN,
        features_ru=features_ru,
        features_en=features_en,
        feature_count=(3, 3),
    ).with_graph(graph.as_json())


# ---------------------------------------------------------------------------
# pipe routes
# ---------------------------------------------------------------------------


def build_pipe_routes(index: int) -> Part:
    rng = Rng("pipe_routes", index)
    pipe_r = rng.grid([5.0, 6.0, 8.0, 10.0])
    run_a = rng.grid([60.0, 70.0, 80.0, 90.0, 100.0])
    run_b = rng.grid([40.0, 50.0, 60.0, 70.0, 90.0])
    diag = rng.grid([30.0, 40.0, 50.0, 60.0])
    run_c = rng.grid([30.0, 40.0, 50.0, 60.0])
    joint_r = _joint_radius(pipe_r)
    collars = rng.chance(0.65)
    collar_w = rng.grid([5.0, 6.0, 8.0]) if collars else 0.0
    collar_d = round(2 * pipe_r + 10.0, 2)
    brace = rng.chance(0.4)
    brace_len = round(min(run_b * 0.5, 60.0), 1)

    builder = ScadBuilder(
        "Pipe route",
        f"tube {fmt(2 * pipe_r)} mm, run {fmt(run_a)} mm + {fmt(run_b)} mm + 45 deg bend",
    )
    builder.param("pipe_r", pipe_r, "pipe outside radius")
    builder.param("joint_r", joint_r, "joint ball radius")
    builder.param("run_a", run_a, "first straight run, X")
    builder.param("run_b", run_b, "second straight run, Y")
    builder.param("diag", diag, "45 degree run, per axis")
    builder.param("run_c", run_c, "last straight run, Z")
    if collars:
        builder.param("collar_d", collar_d, "reinforcing collar diameter")
        builder.param("collar_w", collar_w, "collar width")
    if brace:
        builder.param("brace_len", brace_len, "branch stub length")

    lines = list(MEMBER_MODULE)
    lines += [
        "",
        "p0 = [0, 0, 0];",
        "p1 = [run_a, 0, 0];",
        "p2 = [run_a, run_b, 0];",
        "p3 = [run_a + diag, run_b + diag, 0];",
        "p4 = [run_a + diag, run_b + diag, run_c];",
        "",
        "member(p0, p1, pipe_r);",
        "member(p1, p2, pipe_r);",
        "member(p2, p3, pipe_r);",
        "member(p3, p4, pipe_r);",
    ]
    if brace:
        lines.append("member(p2, [run_a + brace_len, run_b, 0], pipe_r);")
    lines += [
        "",
        "/* joint balls */",
        "joint(p0, joint_r);",
        "joint(p1, joint_r);",
        "joint(p2, joint_r);",
        "joint(p3, joint_r);",
        "joint(p4, joint_r);",
    ]
    if brace:
        lines.append("joint([run_a + brace_len, run_b, 0], joint_r);")
    if collars:
        lines += [
            "",
            "/* welded collars on the straight runs */",
            "translate([run_a / 2, 0, 0]) rotate([0, 90, 0])",
            "  cylinder(h = collar_w, d = collar_d, center = true);",
            "translate([run_a, run_b / 2, 0]) rotate([90, 0, 0])",
            "  cylinder(h = collar_w, d = collar_d, center = true);",
        ]
    builder.section("\n".join(lines))
    code = builder.render()

    p0 = (0.0, 0.0, 0.0)
    p1 = (run_a, 0.0, 0.0)
    p2 = (run_a, run_b, 0.0)
    p3 = (run_a + diag, run_b + diag, 0.0)
    p4 = (run_a + diag, run_b + diag, run_c)
    graph = Graph()
    graph.edge(p0, p1)
    graph.edge(p1, p2)
    graph.edge(p2, p3)
    graph.edge(p3, p4)
    if brace:
        graph.edge(p2, (run_a + brace_len, run_b, 0.0))

    nodes = [p0, p1, p2, p3, p4]
    if brace:
        nodes.append((run_a + brace_len, run_b, 0.0))
    bbox = _node_bbox(nodes, joint_r)
    if collars:
        xs = [run_a / 2 - collar_w / 2, run_a / 2 + collar_w / 2, run_a - collar_d / 2, run_a + collar_d / 2]
        ys = [-collar_d / 2, collar_d / 2, run_b / 2 - collar_w / 2, run_b / 2 + collar_w / 2]
        zs = [-collar_d / 2, collar_d / 2]
        node_xs = [point[0] - joint_r for point in nodes] + [point[0] + joint_r for point in nodes]
        node_ys = [point[1] - joint_r for point in nodes] + [point[1] + joint_r for point in nodes]
        node_zs = [point[2] - joint_r for point in nodes] + [point[2] + joint_r for point in nodes]
        bbox = (
            round(max(max(xs), max(node_xs)) - min(min(xs), min(node_xs)), 2),
            round(max(max(ys), max(node_ys)) - min(min(ys), min(node_ys)), 2),
            round(max(max(zs), max(node_zs)) - min(min(zs), min(node_zs)), 2),
        )

    features_ru = [
        f"труба наружным диаметром {fmt(2 * pipe_r)} мм",
        f"прямой участок {fmt(run_a)} мм, поворот 90 градусов, участок {fmt(run_b)} мм",
        f"отвод 45 градусов по {fmt(diag)} мм на каждую ось",
    ]
    features_en = [
        f"{fmt(2 * pipe_r)} mm outside diameter tube",
        f"a {fmt(run_a)} mm straight run with a 90 degree elbow into a {fmt(run_b)} mm run",
        f"a 45 degree bend stepping {fmt(diag)} mm per axis",
    ]
    if collars:
        features_ru.append(f"два усиливающих бурта диаметром {fmt(collar_d)} мм")
        features_en.append(f"two welded collars of {fmt(collar_d)} mm")
    if brace:
        features_ru.append(f"ответвление длиной {fmt(brace_len)} мм")
        features_en.append(f"a {fmt(brace_len)} mm branch stub")
    return finish_part(
        rng,
        family="pipes",
        variant=f"{len(nodes)}joints",
        code=code,
        bbox=bbox,
        params={
            "pipe_r": pipe_r,
            "run_a": run_a,
            "run_b": run_b,
            "diag": diag,
            "run_c": run_c,
            "joint_r": joint_r,
        },
        ru_nouns=PIPE_RU,
        en_nouns=PIPE_EN,
        features_ru=features_ru,
        features_en=features_en,
        feature_count=(3, 3),
    ).with_graph(graph.as_json())
