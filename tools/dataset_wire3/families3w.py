"""wire3 families - second wave of the wire canvas (all-new archetypes).

* ``geodome``    - geodesic domes: base ring + top ring + apex, zigzag web;
* ``bikeframe``  - diamond bicycle frames: two triangles, fork, rear axle,
  optional luggage rack;
* ``scaffold``   - scaffold towers: posts, ledgers, transoms, alternating
  face diagonals;
* ``cranejib``   - crane jibs: tapered square-ring boom, braced pyramid boom
  or a kingpost jib with ties;
* ``archtruss``  - paired parabolic arch trusses with cross bracing.

Node budget <= 32 (32-vertex WireCanvas cap), member radii 1.5-5 mm, every
edge longer than 2r + 2 mm, connected graph, place1 law on both prompts.
"""

from __future__ import annotations

import math

from tools.dataset_gen2.common import Part, Rng, fmt
from tools.dataset_gen2.prompts import en_count, ru_count
from tools.dataset_v5.kit import SEED_V5
from tools.dataset_wire2.families2w import MEMBER_MODULE, WireScene, _r2  # noqa: F401


def _r4(value: float) -> float:
    return round(value + 0.0, 4)


# ---------------------------------------------------------------------------
# 1. geodesic domes
# ---------------------------------------------------------------------------

DOME_RU = (
    "геодезический купол", "решетчатый купол из прутка",
    "сводчатую геоконструкцию", "купольный каркас",
)
DOME_EN = (
    "a geodesic dome", "a lattice wire dome",
    "a domed space frame", "a geodesic cupola frame",
)


def build_geodome(index: int) -> Part:
    rng = Rng("geodome3", index, seed=SEED_V5)
    sides = int(rng.choice((6.0, 8.0)))
    staggered = rng.chance(0.5)
    variant = ("hex" if sides == 6 else "oct") + ("_staggered" if staggered else "_aligned")
    base_r = rng.grid([40.0, 45.0, 50.0, 55.0])
    top_r = rng.grid([16.0, 20.0, 24.0])
    ring_h = rng.grid([25.0, 30.0, 35.0])
    rise = rng.grid([15.0, 20.0, 25.0])
    twist = round(180.0 / sides, 4) if staggered else 0.0
    chord_r = rng.grid([2.5, 3.0])
    brace_r = _r2(max(1.5, chord_r - 0.8))
    joint_r = _r2(chord_r + 0.4)

    sc = WireScene("geodome", rng, "Geodesic dome",
                   f"{sides}-gon rings, base R{base_r:g}, top R{top_r:g}")
    sc.variant = variant
    sc.param("sides", float(sides), "polygon order of both rings")
    sc.param("base_r", base_r, "base ring radius")
    sc.param("top_r", top_r, "top ring radius")
    sc.param("ring_h", ring_h, "height of the top ring")
    sc.param("rise", rise, "apex rise above the top ring")
    sc.param("twist", twist, "angular offset of the top ring, degrees")
    sc.radius("chord_r", chord_r, "ring member radius")
    sc.radius("brace_r", brace_r, "web member radius")
    sc.param("joint_r", joint_r, "joint ball radius")
    sc.diameter("chord_d", "chord_r", "ring stock diameter")
    sc.diameter("brace_d", "brace_r", "web stock diameter")
    sc.derived.append("apex_z = ring_h + rise;  // apex height")

    nodes: list[tuple[float, float, float]] = []
    for i in range(sides):
        angle = math.radians(i * 360.0 / sides)
        nodes.append((_r4(base_r * math.cos(angle)), _r4(base_r * math.sin(angle)), 0.0))
    for i in range(sides):
        angle = math.radians(i * 360.0 / sides + twist)
        nodes.append((_r4(top_r * math.cos(angle)), _r4(top_r * math.sin(angle)), _r4(ring_h)))
    nodes.append((0.0, 0.0, _r4(ring_h + rise)))
    sc.nodes = nodes
    sc.nodes_expr = (
        "concat("
        "[for (i = [0 : sides - 1]) [base_r * cos(i * 360 / sides), base_r * sin(i * 360 / sides), 0]], "
        "[for (i = [0 : sides - 1]) [top_r * cos(i * 360 / sides + twist), top_r * sin(i * 360 / sides + twist), ring_h]], "
        "[[0, 0, apex_z]])"
    )

    for i in range(sides):
        sc.edges.append((i, (i + 1) % sides, "chord_r"))
    for i in range(sides):
        sc.edges.append((sides + i, sides + (i + 1) % sides, "chord_r"))
    for i in range(sides):
        sc.edges.append((i, sides + i, "brace_r"))
        sc.edges.append((sides + i, (i + 1) % sides, "brace_r"))
    apex = 2 * sides
    for i in range(sides):
        sc.edges.append((apex, sides + i, "brace_r"))

    # the polygon ring only touches its bounding box where a vertex does ->
    # measure the real node extents and declare literal dims (bikeframe precedent)
    xs = [n[0] for n in nodes]
    ys = [n[1] for n in nodes]
    zs = [n[2] for n in nodes]
    bx = _r2(max(xs) - min(xs) + 2 * joint_r)
    by = _r2(max(ys) - min(ys) + 2 * joint_r)
    bz = _r2(max(zs) - min(zs) + 2 * joint_r)
    sc.set_bbox_exprs(str(bx), str(by), str(bz))
    return sc.render(
        features_ru=[
            f"{ru_count(sides, 'стойка', 'стойки', 'стоек')} в основании, радиус основания {fmt(base_r)} мм",
            f"верхнее кольцо радиусом {fmt(top_r)} мм на высоте {fmt(ring_h)} мм"
            + (", повёрнуто на полшага" if staggered else ", соосно основанию"),
            f"вершина на {fmt(rise)} мм выше верхнего кольца",
            f"пояса из прутка d{fmt(_r2(2 * chord_r))} мм, раскосы d{fmt(_r2(2 * brace_r))} мм",
        ],
        features_en=[
            f"{en_count(sides)} base posts, base radius {fmt(base_r)} mm",
            f"top ring of {fmt(top_r)} mm radius at {fmt(ring_h)} mm height"
            + (", twisted half a step" if staggered else ", aligned with the base"),
            f"apex {fmt(rise)} mm above the top ring",
            f"rings of {fmt(_r2(2 * chord_r))} mm stock, web of {fmt(_r2(2 * brace_r))} mm",
        ],
        ru_nouns=DOME_RU, en_nouns=DOME_EN,
        bbox=(bx, by, bz),
    )


# ---------------------------------------------------------------------------
# 2. bicycle frames
# ---------------------------------------------------------------------------

BIKE_RU = (
    "раму велосипеда из труб", "велосипедную раму-ромб",
    "трубчатую раму велосипеда", "каркас велосипедной рамы",
)
BIKE_EN = (
    "a tubular bicycle frame", "a diamond bicycle frame",
    "a bike frame skeleton", "a welded bicycle frame",
)


def build_bikeframe(index: int) -> Part:
    rng = Rng("bikeframe3", index, seed=SEED_V5)
    racked = rng.chance(0.45)
    variant = "racked" if racked else "classic"
    track = rng.grid([44.0, 48.0, 52.0])
    hub_z = rng.grid([18.0, 20.0, 22.0])
    bb_x = rng.grid([85.0, 90.0, 95.0, 100.0])
    bb_z = rng.grid([22.0, 25.0, 28.0])
    ht_bot_x = rng.grid([30.0, 33.0, 36.0])
    ht_bot_z = rng.grid([62.0, 68.0, 74.0])
    ht_top_x = rng.grid([18.0, 21.0, 24.0])
    ht_top_z = rng.grid([100.0, 106.0, 112.0])
    st_x = rng.grid([93.0, 98.0, 103.0])
    st_z = rng.grid([95.0, 102.0, 108.0])
    fh_x = rng.grid([128.0, 135.0, 142.0])
    tube_r = rng.grid([2.2, 2.5, 2.8])
    joint_r = _r2(tube_r + 0.5)
    rack_z = _r2(st_z - 12.0)
    if rack_z < hub_z + 2 * tube_r + 4:
        raise ValueError("rack sits too low over the dropout")

    sc = WireScene("bikeframe", rng, "Bicycle frame",
                   f"diamond frame, wheelbase {fh_x:g} mm" + (", with rack" if racked else ""))
    sc.variant = variant
    for name, value, comment in (
        ("track", track, "distance between the rear dropouts"),
        ("hub_z", hub_z, "wheel hub height"),
        ("bb_x", bb_x, "bottom bracket X"),
        ("bb_z", bb_z, "bottom bracket height"),
        ("ht_bot_x", ht_bot_x, "head tube bottom X"),
        ("ht_bot_z", ht_bot_z, "head tube bottom height"),
        ("ht_top_x", ht_top_x, "head tube top X"),
        ("ht_top_z", ht_top_z, "head tube top height"),
        ("st_x", st_x, "seat cluster X"),
        ("st_z", st_z, "seat cluster height"),
        ("fh_x", fh_x, "front hub X (wheelbase)"),
    ):
            sc.param(name, value, comment)
    sc.radius("tube_r", tube_r, "frame tube radius")
    sc.param("joint_r", joint_r, "joint ball radius")
    sc.diameter("tube_d", "tube_r", "frame tube diameter")
    sc.derived.append("wheelbase = fh_x;  // rear axle to front hub")
    if racked:
        sc.param("rack_z", rack_z, "luggage rack height")

    half = _r4(track / 2)
    nodes: list[tuple[float, float, float]] = [
        (_r4(bb_x), 0.0, _r4(bb_z)),          # 0 bottom bracket
        (_r4(ht_bot_x), 0.0, _r4(ht_bot_z)),  # 1 head tube bottom
        (_r4(ht_top_x), 0.0, _r4(ht_top_z)),  # 2 head tube top
        (_r4(st_x), 0.0, _r4(st_z)),          # 3 seat cluster
        (0.0, half, _r4(hub_z)),              # 4 rear dropout left
        (0.0, -half, _r4(hub_z)),             # 5 rear dropout right
        (_r4(fh_x), half, _r4(hub_z)),        # 6 front hub left
        (_r4(fh_x), -half, _r4(hub_z)),       # 7 front hub right
    ]
    listed = (
        f"[[bb_x, 0, bb_z], [ht_bot_x, 0, ht_bot_z], [ht_top_x, 0, ht_top_z], "
        f"[st_x, 0, st_z], [0, track / 2, hub_z], [0, -track / 2, hub_z], "
        f"[fh_x, track / 2, hub_z], [fh_x, -track / 2, hub_z]"
    )
    edges = [
        (1, 2, "tube_r"),   # head tube
        (1, 0, "tube_r"),   # down tube
        (2, 3, "tube_r"),   # top tube
        (3, 0, "tube_r"),   # seat tube
        (0, 4, "tube_r"), (0, 5, "tube_r"),   # chainstays
        (3, 4, "tube_r"), (3, 5, "tube_r"),   # seat stays
        (1, 6, "tube_r"), (1, 7, "tube_r"),   # fork
        (6, 7, "tube_r"), (4, 5, "tube_r"),   # axles
    ]
    if racked:
        nodes += [(0.0, half, _r4(rack_z)), (0.0, -half, _r4(rack_z))]
        listed += f", [0, track / 2, rack_z], [0, -track / 2, rack_z]"
        edges += [(3, 8, "tube_r"), (3, 9, "tube_r"), (8, 4, "tube_r"), (9, 5, "tube_r")]
    listed += "]"
    sc.nodes = nodes
    sc.nodes_expr = listed
    sc.edges = edges

    top_z = max(ht_top_z, st_z, rack_z if racked else 0.0)
    sc.set_bbox_exprs(
        f"fh_x + 2 * joint_r",
        "track + 2 * joint_r",
        f"{fmt(top_z)} - hub_z + 2 * joint_r",
    )
    bbox = (_r2(fh_x + 2 * joint_r), _r2(track + 2 * joint_r),
            _r2(top_z - hub_z + 2 * joint_r))
    feats_ru = [
        f"колесная база {fmt(fh_x)} мм, колея задних перьев {fmt(track)} мм",
        f"каретка на высоте {fmt(bb_z)} мм, рулевой узел {fmt(ht_bot_z)}-{fmt(ht_top_z)} мм",
        f"трубы d{fmt(_r2(2 * tube_r))} мм, два треугольника и вилка",
    ]
    feats_en = [
        f"wheelbase {fmt(fh_x)} mm, rear track {fmt(track)} mm",
        f"bottom bracket at {fmt(bb_z)} mm, head tube {fmt(ht_bot_z)}-{fmt(ht_top_z)} mm",
        f"{fmt(_r2(2 * tube_r))} mm tubes, two triangles and a fork",
    ]
    if racked:
        feats_ru.append(f"багажник над задними перьями на высоте {fmt(rack_z)} мм")
        feats_en.append(f"luggage rack over the rear stays at {fmt(rack_z)} mm")
    return sc.render(features_ru=feats_ru, features_en=feats_en,
                     ru_nouns=BIKE_RU, en_nouns=BIKE_EN, bbox=bbox)


# ---------------------------------------------------------------------------
# 3. scaffold towers
# ---------------------------------------------------------------------------

SCAFFOLD_RU = (
    "башню строительных лесов", "каркас лесов",
    "секцию рамных лесов", "лесовую вышку-башню",
)
SCAFFOLD_EN = (
    "a scaffold tower", "a scaffolding frame tower",
    "a tower scaffold bay stack", "a mobile scaffold frame",
)


def build_scaffold(index: int) -> Part:
    rng = Rng("scaffold3", index, seed=SEED_V5)
    spans = int(rng.grid([2.0, 3.0]))
    levels = int(rng.grid([2.0, 3.0]))
    if 2 * (spans + 1) * (levels + 1) > 32:
        raise ValueError("scaffold exceeds the node budget")
    variant = f"{spans}x{levels}"
    bay_l = rng.grid([40.0, 45.0, 50.0])
    tower_w = rng.grid([24.0, 28.0, 32.0])
    lift_h = rng.grid([30.0, 35.0, 40.0])
    post_r = rng.grid([2.5, 3.0])
    brace_r = _r2(max(1.5, post_r - 0.8))
    joint_r = _r2(post_r + 0.4)

    sc = WireScene("scaffold", rng, "Scaffold tower",
                   f"{spans} spans x {levels} lifts")
    sc.variant = variant
    sc.param("spans", float(spans), "spans along X")
    sc.param("levels", float(levels), "lift levels")
    sc.param("bay_l", bay_l, "span length, X")
    sc.param("tower_w", tower_w, "tower width, Y")
    sc.param("lift_h", lift_h, "lift height, Z")
    sc.radius("post_r", post_r, "post and ledger radius")
    sc.radius("brace_r", brace_r, "diagonal brace radius")
    sc.param("joint_r", joint_r, "joint ball radius")
    sc.diameter("post_d", "post_r", "post stock diameter")
    sc.diameter("brace_d", "brace_r", "brace stock diameter")
    sc.derived.append("tower_l = spans * bay_l;  // tower footprint length")
    sc.derived.append("tower_h = levels * lift_h;  // tower height")

    nodes: list[tuple[float, float, float]] = []
    for lvl in range(levels + 1):
        for side in (0, 1):
            for st in range(spans + 1):
                nodes.append((_r4(st * bay_l), _r4(side * tower_w), _r4(lvl * lift_h)))
    sc.nodes = nodes
    sc.nodes_expr = (
        "[for (lvl = [0 : levels], side = [0, 1], st = [0 : spans]) "
        "[st * bay_l, side * tower_w, lvl * lift_h]]"
    )

    stride_side = spans + 1
    stride_lvl = 2 * (spans + 1)

    def idx(lvl: int, side: int, st: int) -> int:
        return lvl * stride_lvl + side * stride_side + st

    for lvl in range(levels):
        for side in (0, 1):
            for st in range(spans + 1):
                sc.edges.append((idx(lvl, side, st), idx(lvl + 1, side, st), "post_r"))
            for st in range(spans):
                sc.edges.append((idx(lvl, side, st), idx(lvl, side, st + 1), "post_r"))
    for lvl in range(levels + 1):
        for st in range(spans + 1):
            sc.edges.append((idx(lvl, 0, st), idx(lvl, 1, st), "post_r"))
    for lvl in range(levels):
        for side in (0, 1):
            for st in range(spans):
                if (st + lvl) % 2 == 0:
                    sc.edges.append((idx(lvl, side, st), idx(lvl + 1, side, st + 1), "brace_r"))
                else:
                    sc.edges.append((idx(lvl + 1, side, st), idx(lvl, side, st + 1), "brace_r"))

    sc.set_bbox_exprs(
        "spans * bay_l + 2 * joint_r",
        "tower_w + 2 * joint_r",
        "levels * lift_h + 2 * joint_r",
    )
    bbox = (_r2(spans * bay_l + 2 * joint_r), _r2(tower_w + 2 * joint_r),
            _r2(levels * lift_h + 2 * joint_r))
    return sc.render(
        features_ru=[
            f"{ru_count(spans, 'пролёт', 'пролёта', 'пролётов')} по {fmt(bay_l)} мм, "
            f"{ru_count(levels, 'ярус', 'яруса', 'ярусов')} по {fmt(lift_h)} мм",
            f"ширина башни {fmt(tower_w)} мм",
            f"стойки и ригели d{fmt(_r2(2 * post_r))} мм, диагонали d{fmt(_r2(2 * brace_r))} мм в шахматном порядке",
            f"поперечины на каждом ярусе, высота {fmt(levels * lift_h)} мм",
        ],
        features_en=[
            f"{en_count(spans)} spans of {fmt(bay_l)} mm, {en_count(levels)} lifts of {fmt(lift_h)} mm",
            f"tower {fmt(tower_w)} mm wide",
            f"posts and ledgers d{fmt(_r2(2 * post_r))} mm, staggered d{fmt(_r2(2 * brace_r))} mm diagonals",
            f"a transom at every level, {fmt(levels * lift_h)} mm tall overall",
        ],
        ru_nouns=SCAFFOLD_RU, en_nouns=SCAFFOLD_EN, bbox=bbox,
    )


# ---------------------------------------------------------------------------
# 4. crane jibs
# ---------------------------------------------------------------------------

JIB_RU = (
    "стрелу крана из прутка", "решетчатую стрелу",
    "ферменную стрелу крана", "консольную ферму-стрелу",
)
JIB_EN = (
    "a lattice crane jib", "a trussed crane boom",
    "a wire-frame jib", "a cantilever boom truss",
)


def build_cranejib(index: int) -> Part:
    rng = Rng("cranejib3", index, seed=SEED_V5)
    variant = rng.choice(("tapered", "pyramid", "kingpost"))
    jib_l = rng.grid([90.0, 110.0, 130.0])
    w0 = rng.grid([16.0, 18.0, 20.0])
    w1 = rng.grid([8.0, 10.0, 12.0])
    deck_h = _r2(w0 + 2.0)
    chord_r = rng.grid([2.2, 2.5, 3.0])
    brace_r = _r2(max(1.5, chord_r - 0.7))
    joint_r = _r2(chord_r + 0.4)

    sc = WireScene("cranejib", rng, "Crane jib", f"{variant} jib, {jib_l:g} mm")
    sc.variant = variant
    sc.param("jib_l", jib_l, "jib length, X")
    sc.param("root_w", w0, "half width of the root ring")
    sc.param("tip_w", w1, "half width of the tip ring")
    sc.param("deck_h", deck_h, "height of the jib axis")
    sc.radius("chord_r", chord_r, "ring and chord radius")
    sc.radius("brace_r", brace_r, "diagonal radius")
    sc.param("joint_r", joint_r, "joint ball radius")
    sc.diameter("chord_d", "chord_r", "chord stock diameter")
    sc.diameter("brace_d", "brace_r", "brace stock diameter")
    sc.derived.append("root_d = 2 * root_w;  // root ring section")
    sc.derived.append("tip_d = 2 * tip_w;  // tip ring section")

    nodes: list[tuple[float, float, float]] = []
    corners = ((-1, -1), (1, -1), (1, 1), (-1, 1))
    for sy, sz in corners:
        nodes.append((0.0, _r4(sy * w0), _r4(deck_h + sz * w0)))
    listed = "[[0, -root_w, deck_h - root_w], [0, root_w, deck_h - root_w], " \
             "[0, root_w, deck_h + root_w], [0, -root_w, deck_h + root_w]"
    if variant == "pyramid":
        w_mid = _r2((w0 + w1) / 2)
        sc.param("mid_w", w_mid, "half width of the middle ring")
        sc.derived.append("mid_d = 2 * mid_w;  // middle ring section")
        for sy, sz in corners:
            nodes.append((_r4(jib_l / 2), _r4(sy * w_mid), _r4(deck_h + sz * w_mid)))
        nodes.append((_r4(jib_l), 0.0, _r4(deck_h)))
        listed += ", [jib_l / 2, -mid_w, deck_h - mid_w], [jib_l / 2, mid_w, deck_h - mid_w], " \
                  "[jib_l / 2, mid_w, deck_h + mid_w], [jib_l / 2, -mid_w, deck_h + mid_w], " \
                  "[jib_l, 0, deck_h]"
        edges = [(0, 1, "chord_r"), (1, 2, "chord_r"), (2, 3, "chord_r"), (3, 0, "chord_r"),
                 (4, 5, "chord_r"), (5, 6, "chord_r"), (6, 7, "chord_r"), (7, 4, "chord_r")]
        for k in range(4):
            edges.append((k, 4 + k, "chord_r"))
            edges.append((4 + k, 8, "chord_r"))
            edges.append((k, 4 + (k + 1) % 4, "brace_r"))
        sc.derived.append("jib_h = 2 * root_w;  // root ring height")
    elif variant == "kingpost":
        post_h = rng.grid([25.0, 30.0, 35.0])
        kp_x = rng.grid([30.0, 35.0, 40.0])
        sc.param("post_h", post_h, "kingpost height above the axis")
        sc.param("kp_x", kp_x, "kingpost position along the jib")
        for sy, sz in corners:
            nodes.append((_r4(jib_l), _r4(sy * w1), _r4(deck_h + sz * w1)))
        nodes.append((_r4(kp_x), 0.0, _r4(deck_h + post_h)))
        listed += ", [jib_l, -tip_w, deck_h - tip_w], [jib_l, tip_w, deck_h - tip_w], " \
                  "[jib_l, tip_w, deck_h + tip_w], [jib_l, -tip_w, deck_h + tip_w], " \
                  "[kp_x, 0, deck_h + post_h]"
        edges = [(0, 1, "chord_r"), (1, 2, "chord_r"), (2, 3, "chord_r"), (3, 0, "chord_r"),
                 (4, 5, "chord_r"), (5, 6, "chord_r"), (6, 7, "chord_r"), (7, 4, "chord_r")]
        for k in range(4):
            edges.append((k, 4 + k, "chord_r"))
            edges.append((k, 4 + (k + 1) % 4, "brace_r"))
            edges.append((8, k, "brace_r"))
            edges.append((8, 4 + k, "brace_r"))
        sc.derived.append("jib_h = 2 * root_w;  // root ring height")
    else:  # tapered
        for sy, sz in corners:
            nodes.append((_r4(jib_l), _r4(sy * w1), _r4(deck_h + sz * w1)))
        listed += ", [jib_l, -tip_w, deck_h - tip_w], [jib_l, tip_w, deck_h - tip_w], " \
                  "[jib_l, tip_w, deck_h + tip_w], [jib_l, -tip_w, deck_h + tip_w]"
        edges = [(0, 1, "chord_r"), (1, 2, "chord_r"), (2, 3, "chord_r"), (3, 0, "chord_r"),
                 (4, 5, "chord_r"), (5, 6, "chord_r"), (6, 7, "chord_r"), (7, 4, "chord_r")]
        for k in range(4):
            edges.append((k, 4 + k, "chord_r"))
            edges.append((k, 4 + (k + 1) % 4, "brace_r"))
        sc.derived.append("jib_h = 2 * root_w;  // root ring height")

    listed += "]"
    sc.nodes = nodes
    sc.nodes_expr = listed
    sc.edges = edges

    top = deck_h + w0
    if variant == "kingpost":
        top = max(top, deck_h + nodes[8][2] - deck_h)
        top = deck_h + sc.params["post_h"]
    sc.set_bbox_exprs(
        "jib_l + 2 * joint_r",
        "2 * root_w + 2 * joint_r",
        f"{fmt(top - (deck_h - w0))} + 2 * joint_r",
    )
    bbox = (_r2(jib_l + 2 * joint_r), _r2(2 * w0 + 2 * joint_r),
            _r2(top - (deck_h - w0) + 2 * joint_r))
    feats_ru = [
        f"длина стрелы {fmt(jib_l)} мм, корневое сечение {fmt(2 * w0)} мм",
        f"пояса d{fmt(_r2(2 * chord_r))} мм, раскосы d{fmt(_r2(2 * brace_r))} мм",
    ]
    feats_en = [
        f"jib {fmt(jib_l)} mm long, root section {fmt(2 * w0)} mm",
        f"chords d{fmt(_r2(2 * chord_r))} mm, diagonals d{fmt(_r2(2 * brace_r))} mm",
    ]
    if variant == "tapered":
        feats_ru.append(f"сужение к оголовку до {fmt(2 * w1)} мм")
        feats_en.append(f"tapering to {fmt(2 * w1)} mm at the tip")
    elif variant == "pyramid":
        feats_ru.append(f"пирамида: середина {fmt(2 * sc.params['mid_w'])} мм, вершина в оголовке")
        feats_en.append(f"pyramid bracing: {fmt(2 * sc.params['mid_w'])} mm mid ring, apex at the tip")
    else:
        feats_ru.append(f"пилолон высотой {fmt(sc.params['post_h'])} мм на {fmt(sc.params['kp_x'])} мм от корня с тягами")
        feats_en.append(f"kingpost {fmt(sc.params['post_h'])} mm tall at {fmt(sc.params['kp_x'])} mm, with ties")
    return sc.render(features_ru=feats_ru, features_en=feats_en,
                     ru_nouns=JIB_RU, en_nouns=JIB_EN, bbox=bbox)


# ---------------------------------------------------------------------------
# 5. paired arch trusses
# ---------------------------------------------------------------------------

ARCH_RU = (
    "арочную ферму-портал", "пару арочных ферм",
    "сводчатую ферменную конструкцию", "арочный каркас с затяжкой",
)
ARCH_EN = (
    "an arch truss portal", "a pair of arch trusses",
    "a tied arch frame", "a parabolic arch truss pair",
)


def build_archtruss(index: int) -> Part:
    rng = Rng("archtruss3", index, seed=SEED_V5)
    bays = int(rng.grid([4.0, 5.0, 6.0]))
    full = rng.chance(0.5)
    variant = f"{bays}bay_" + ("full" if full else "topcross")
    if 4 * (bays + 1) > 32:
        raise ValueError("arch truss exceeds the node budget")
    arch_bay = rng.grid([25.0, 28.0, 30.0])
    rise = rng.grid([20.0, 25.0, 30.0])
    col_h = rng.grid([10.0, 12.0, 14.0])
    arch_w = rng.grid([20.0, 24.0, 30.0])
    chord_r = rng.grid([2.2, 2.5, 3.0])
    brace_r = _r2(max(1.5, chord_r - 0.7))
    joint_r = _r2(chord_r + 0.4)

    sc = WireScene("archtruss", rng, "Arch truss pair",
                   f"{bays} bays of {arch_bay:g} mm, rise {rise:g} mm")
    sc.variant = variant
    sc.param("bays", float(bays), "number of arch bays")
    sc.param("arch_bay", arch_bay, "bay length, X")
    sc.param("rise", rise, "arch rise over the tie")
    sc.param("col_h", col_h, "end post height")
    sc.param("arch_w", arch_w, "distance between the two trusses, Y")
    sc.radius("chord_r", chord_r, "chord radius")
    sc.radius("brace_r", brace_r, "web and cross brace radius")
    sc.param("joint_r", joint_r, "joint ball radius")
    sc.diameter("chord_d", "chord_r", "chord stock diameter")
    sc.diameter("brace_d", "brace_r", "web stock diameter")
    sc.derived.append("arch_span = bays * arch_bay;  // truss span")
    sc.derived.append("crown_z = col_h + rise;  // crown height over the tie")

    def arch_z(i: int) -> float:
        t = i / bays
        return _r4(col_h + 4.0 * rise * t * (1.0 - t))

    nodes: list[tuple[float, float, float]] = []
    for i in range(bays + 1):
        nodes.append((_r4(i * arch_bay), 0.0, arch_z(i)))
    for i in range(bays + 1):
        nodes.append((_r4(i * arch_bay), 0.0, 0.0))
    for i in range(bays + 1):
        nodes.append((_r4(i * arch_bay), _r4(arch_w), arch_z(i)))
    for i in range(bays + 1):
        nodes.append((_r4(i * arch_bay), _r4(arch_w), 0.0))
    sc.nodes = nodes
    zexpr = "col_h + 4 * rise * (i / bays) * (1 - i / bays)"
    sc.nodes_expr = (
        "concat("
        f"[for (i = [0 : bays]) [i * arch_bay, 0, {zexpr}]], "
        "[for (i = [0 : bays]) [i * arch_bay, 0, 0]], "
        f"[for (i = [0 : bays]) [i * arch_bay, arch_w, {zexpr}]], "
        "[for (i = [0 : bays]) [i * arch_bay, arch_w, 0]])"
    )

    n = bays + 1
    for base in (0, 2 * n):  # truss A, truss B
        for i in range(bays):
            sc.edges.append((base + i, base + i + 1, "chord_r"))          # arch chord
            sc.edges.append((base + n + i, base + n + i + 1, "chord_r"))  # tie chord
        for i in range(n):
            sc.edges.append((base + i, base + n + i, "chord_r"))          # verticals
        for i in range(bays):
            if i % 2 == 0:
                sc.edges.append((base + n + i, base + i + 1, "brace_r"))
            else:
                sc.edges.append((base + i, base + n + i + 1, "brace_r"))
    for i in range(n):
        sc.edges.append((i, 2 * n + i, "brace_r"))          # top cross braces
        if full:
            sc.edges.append((n + i, 3 * n + i, "brace_r"))  # bottom cross braces

    sc.set_bbox_exprs(
        "bays * arch_bay + 2 * joint_r",
        "arch_w + 2 * joint_r",
        "col_h + rise + 2 * joint_r",
    )
    bbox = (_r2(bays * arch_bay + 2 * joint_r), _r2(arch_w + 2 * joint_r),
            _r2(col_h + rise + 2 * joint_r))
    cross_ru = "поперечные связи по верху и низу" if full else "поперечные связи только по верхнему поясу"
    cross_en = "cross bracing top and bottom" if full else "cross bracing along the top chord only"
    return sc.render(
        features_ru=[
            f"две фермы с пролётом {fmt(bays * arch_bay)} мм на расстоянии {fmt(arch_w)} мм",
            f"параболическая арка со стрелой {fmt(rise)} мм, концевые стойки {fmt(col_h)} мм",
            f"пояса d{fmt(_r2(2 * chord_r))} мм, решётка и связи d{fmt(_r2(2 * brace_r))} мм",
            cross_ru,
        ],
        features_en=[
            f"two trusses spanning {fmt(bays * arch_bay)} mm, {fmt(arch_w)} mm apart",
            f"parabolic arch with a {fmt(rise)} mm rise, {fmt(col_h)} mm end posts",
            f"chords d{fmt(_r2(2 * chord_r))} mm, web and braces d{fmt(_r2(2 * brace_r))} mm",
            cross_en,
        ],
        ru_nouns=ARCH_RU, en_nouns=ARCH_EN, bbox=bbox,
    )


FAMILY_BUILDERS = {
    "geodome": build_geodome,
    "bikeframe": build_bikeframe,
    "scaffold": build_scaffold,
    "cranejib": build_cranejib,
    "archtruss": build_archtruss,
}
