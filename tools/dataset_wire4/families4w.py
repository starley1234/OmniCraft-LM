"""wire4 families - third wave of the wire canvas (delivery no. 7).

* ``pergola``    - garden arches: two post-and-arch frames tied by purlins;
* ``shopcart``   - trolley frames: basket loop, slanted legs, push handle;
* ``stoolchair`` - stool / chair frames: splayed legs, stretchers, back hoop;
* ``shelfunit``  - shelving towers: posts, shelf loops, back and side braces;
* ``aladder``    - A-frame ladders: two frames, rungs, a top platform.

Every scene uses literal node coordinates (rounded to 4 decimals, the graph
replay tolerance is 5e-4), so the manifest graph and the code always agree.
Built on the wire2 ``WireScene`` API, audited by wire2's audit.
"""

from __future__ import annotations

import math

from tools.dataset_gen2.common import Part, Rng, fmt
from tools.dataset_gen2.prompts import ru_count, en_count
from tools.dataset_v5.kit import SEED_V5
from tools.dataset_wire2.families2w import MEMBER_MODULE, WireScene


def _r4(value: float) -> float:
    return round(value + 0.0, 4)


def _nodes_literal(nodes: list[tuple[float, float, float]]) -> str:
    body = ", ".join(
        "[%s, %s, %s]" % (repr(x), repr(y), repr(z)) for x, y, z in nodes
    )
    return "[" + body + "]"


def _bbox_of(nodes, joint_r: float) -> tuple[float, float, float]:
    xs = [n[0] for n in nodes]
    ys = [n[1] for n in nodes]
    zs = [n[2] for n in nodes]
    return (round(max(xs) - min(xs) + 2 * joint_r, 2),
            round(max(ys) - min(ys) + 2 * joint_r, 2),
            round(max(zs) - min(zs) + 2 * joint_r, 2))


# ---------------------------------------------------------------------------
# 1. pergola
# ---------------------------------------------------------------------------

PERGOLA_RU = ("садовую перголу-арку", "арочную шпалеру", "перголу с арками", "решётчатую арку для вьюнков")
PERGOLA_EN = ("a garden pergola arch", "an arched trellis", "a pergola with arch frames", "a lattice arch")


def build_pergola(index: int) -> Part:
    rng = Rng("pergola4", index, seed=SEED_V5)
    n_arch = int(rng.choice((5.0, 7.0)))  # arch polyline samples per frame
    span = rng.grid([90.0, 100.0, 110.0, 120.0])
    post_h = rng.grid([30.0, 40.0, 50.0])
    arch_r = _r4(span / 2)
    depth = rng.grid([40.0, 50.0, 60.0])
    chord_r = rng.grid([2.5, 3.0])
    brace_r = round(max(1.5, chord_r - 0.8), 2)
    joint_r = round(chord_r + 0.4, 2)

    sc = WireScene("pergola", rng, "Pergola arch",
                   f"{n_arch}-segment arches, span {span:g} mm")
    sc.param("span", span, "arch span, X")
    sc.param("post_h", post_h, "post height")
    sc.param("arch_r", arch_r, "arch radius")
    sc.param("depth", depth, "frame spacing, Y")
    sc.radius("chord_r", chord_r, "arch and post member radius")
    sc.radius("brace_r", brace_r, "purlin member radius")
    sc.param("joint_r", joint_r, "joint ball radius")
    sc.diameter("chord_d", "chord_r", "arch stock diameter")
    sc.diameter("brace_d", "brace_r", "purlin stock diameter")

    # two frames at y = 0 and y = depth; each: 2 posts + arch polyline
    nodes: list[tuple[float, float, float]] = []
    edges: list[tuple[int, int, str]] = []
    for side, y in ((0, 0.0), (1, depth)):
        base = len(nodes)
        nodes.append((0.0, y, 0.0))                       # post foot A
        nodes.append((_r4(span), y, 0.0))                 # post foot B
        nodes.append((0.0, y, _r4(post_h)))               # post top A
        nodes.append((_r4(span), y, _r4(post_h)))         # post top B
        arch_pts = []
        for k in range(n_arch + 1):
            angle = math.radians(180.0 - 180.0 * k / n_arch)
            arch_pts.append((_r4(span / 2 + arch_r * math.cos(angle)),
                             y,
                             _r4(post_h + arch_r + arch_r * math.sin(angle))))
        arch_start = len(nodes)
        nodes.extend(arch_pts)
        # posts: foot -> the arch end above it
        edges.append((base + 0, arch_start, "chord_r"))
        edges.append((base + 1, arch_start + n_arch, "chord_r"))
        # feet tied to the arch ends (base chord)
        edges.append((base + 0, base + 1, "chord_r"))
        # arch polyline; the ends coincide with the post tops, tie them too
        for k in range(n_arch):
            edges.append((arch_start + k, arch_start + k + 1, "chord_r"))
        edges.append((base + 2, arch_start, "brace_r"))
        edges.append((base + 3, arch_start + n_arch, "brace_r"))
    # purlins between the two arches at every polyline vertex
    a0 = 4
    a1 = 9 + n_arch  # side 0: 4 posts + (n_arch + 1) arch nodes, then 4 posts
    for k in range(n_arch + 1):
        edges.append((a0 + k, a1 + k, "brace_r"))
    sc.nodes = nodes
    sc.nodes_expr = _nodes_literal(nodes)
    sc.edges = edges
    bbox = _bbox_of(nodes, joint_r)
    sc.set_bbox_exprs(str(bbox[0]), str(bbox[1]), str(bbox[2]))
    return sc.render(
        features_ru=[
            f"две арочные рамы пролётом {fmt(span)} мм из {n_arch + 1} узлов",
            f"стойки высотой {fmt(post_h)} мм, радиус арки {fmt(arch_r)} мм",
            f"{n_arch + 1} {_plural(n_arch + 1, 'прогон', 'прогона', 'прогонов')} длиной {fmt(depth)} мм",
        ],
        features_en=[
            f"two arch frames on a {fmt(span)} mm span, {n_arch + 1} nodes each",
            f"posts {fmt(post_h)} mm tall, arch radius {fmt(arch_r)} mm",
            f"{n_arch + 1} purlins, {fmt(depth)} mm long",
        ],
        ru_nouns=PERGOLA_RU,
        en_nouns=PERGOLA_EN,
        bbox=bbox,
    )


def _plural(n: int, one: str, few: str, many: str) -> str:
    if n % 10 == 1 and n % 100 != 11:
        return one
    if 2 <= n % 10 <= 4 and not 12 <= n % 100 <= 14:
        return few
    return many


# ---------------------------------------------------------------------------
# 2. shopcart
# ---------------------------------------------------------------------------


def build_shopcart(index: int) -> Part:
    rng = Rng("shopcart4", index, seed=SEED_V5)
    variant = rng.choice(("basket", "flatbed"))
    bed_l = rng.grid([70.0, 80.0, 90.0])
    bed_w = rng.grid([40.0, 45.0, 50.0])
    bed_h = rng.grid([10.0, 12.0])          # bottom loop height (wheel stubs)
    top_h = rng.grid([45.0, 55.0, 65.0])
    top_dx = rng.grid([8.0, 10.0, 12.0])    # basket slant
    handle_up = rng.grid([18.0, 22.0, 26.0])
    handle_dx = rng.grid([10.0, 12.0])
    tube_r = rng.grid([2.0, 2.5])
    joint_r = round(tube_r + 0.4, 2)

    sc = WireScene("shopcart", rng, "Shop cart frame", f"{variant} trolley")
    sc.variant = variant
    sc.param("bed_l", bed_l, "bed length, X")
    sc.param("bed_w", bed_w, "bed width, Y")
    sc.param("bed_h", bed_h, "bed height (caster stubs)")
    sc.param("top_h", top_h, "rim height")
    sc.param("top_dx", top_dx, "rim slant, X")
    sc.param("handle_up", handle_up, "handle rise above the rim")
    sc.param("handle_dx", handle_dx, "handle reach, -X")
    sc.radius("tube_r", tube_r, "frame tube radius")
    sc.param("joint_r", joint_r, "joint ball radius")
    sc.diameter("tube_d", "tube_r", "tube diameter")

    nodes: list[tuple[float, float, float]] = []
    # bottom loop (z = bed_h): 4 corners
    for x, y in ((0.0, 0.0), (bed_l, 0.0), (bed_l, bed_w), (0.0, bed_w)):
        nodes.append((_r4(x), _r4(y), _r4(bed_h)))
    # rim loop (z = top_h), shifted by top_dx
    for x, y in ((top_dx, 0.0), (bed_l + top_dx, 0.0),
                 (bed_l + top_dx, bed_w), (top_dx, bed_w)):
        nodes.append((_r4(x), _r4(y), _r4(top_h)))
    # handle: two nodes behind the rim (back edge = x top_dx side)
    hx = _r4(top_dx - handle_dx)
    hz = _r4(top_h + handle_up)
    nodes.append((hx, 0.0, hz))
    nodes.append((hx, _r4(bed_w), hz))
    edges: list[tuple[int, int, str]] = []
    for i in range(4):  # bottom loop
        edges.append((i, (i + 1) % 4, "tube_r"))
    for i in range(4):  # rim loop
        edges.append((4 + i, 4 + (i + 1) % 4, "tube_r"))
    for i in range(4):  # legs
        edges.append((i, 4 + i, "tube_r"))
    # handle posts rise from the rim back corners (indices 4+3 and 4+0? back = x=top_dx: nodes 4+0 (top_dx,0) and 4+3 (top_dx,bed_w))
    edges.append((4 + 0, 8, "tube_r"))
    edges.append((4 + 3, 9, "tube_r"))
    edges.append((8, 9, "tube_r"))
    # caster stubs: hang each bottom corner down to z=0
    for i in range(4):
        nodes.append((nodes[i][0], nodes[i][1], 0.0))
        edges.append((i, 10 + i, "tube_r"))
    sc.nodes = nodes
    sc.nodes_expr = _nodes_literal(nodes)
    sc.edges = edges
    bbox = _bbox_of(nodes, joint_r)
    sc.set_bbox_exprs(str(bbox[0]), str(bbox[1]), str(bbox[2]))
    return sc.render(
        features_ru=[
            f"каркас телечки {fmt(bed_l)} x {fmt(bed_w)} мм, обод на высоте {fmt(top_h)} мм",
            f"ручка поднимается на {fmt(handle_up)} мм и вынесена на {fmt(handle_dx)} мм",
            f"четыре опоры-колеса высотой {fmt(bed_h)} мм",
        ],
        features_en=[
            f"trolley frame {fmt(bed_l)} x {fmt(bed_w)} mm, rim at {fmt(top_h)} mm",
            f"handle rises {fmt(handle_up)} mm and reaches {fmt(handle_dx)} mm back",
            f"four caster stubs, {fmt(bed_h)} mm tall",
        ],
        ru_nouns=("каркас тележки", "раму магазинной тележки", "каркас грузовой тележки"),
        en_nouns=("a shop cart frame", "a trolley frame", "a hand truck frame"),
        bbox=bbox,
    )


# ---------------------------------------------------------------------------
# 3. stoolchair
# ---------------------------------------------------------------------------


def build_stoolchair(index: int) -> Part:
    rng = Rng("stoolchair4", index, seed=SEED_V5)
    is_chair = rng.chance(0.5)
    variant = "chair" if is_chair else "stool"
    seat = rng.grid([34.0, 38.0, 42.0])
    seat_h = rng.grid([42.0, 46.0, 50.0])
    splay = rng.grid([5.0, 6.0, 8.0])
    str_h = rng.grid([12.0, 15.0, 18.0])
    back_h = rng.grid([30.0, 36.0, 42.0]) if is_chair else 0.0
    bar_r = rng.grid([2.0, 2.5])
    joint_r = round(bar_r + 0.4, 2)

    sc = WireScene("stoolchair", rng, variant.title() + " frame",
                   f"seat {seat:g} mm, splay {splay:g} mm")
    sc.variant = variant
    sc.param("seat", seat, "seat side, X and Y")
    sc.param("seat_h", seat_h, "seat height")
    sc.param("splay", splay, "leg splay at the floor")
    sc.param("str_h", str_h, "stretcher ring height")
    if is_chair:
        sc.param("back_h", back_h, "backrest height above the seat")
    sc.radius("bar_r", bar_r, "frame bar radius")
    sc.param("joint_r", joint_r, "joint ball radius")
    sc.diameter("bar_d", "bar_r", "bar diameter")

    hs = _r4(seat / 2)
    nodes: list[tuple[float, float, float]] = []
    # seat loop
    for x, y in ((-hs, -hs), (hs, -hs), (hs, hs), (-hs, hs)):
        nodes.append((_r4(x), _r4(y), _r4(seat_h)))
    # feet (splayed)
    fs = _r4(seat / 2 + splay)
    for x, y in ((-fs, -fs), (fs, -fs), (fs, fs), (-fs, fs)):
        nodes.append((_r4(x), _r4(y), 0.0))
    # stretcher ring
    ss = _r4(seat / 2 + splay * str_h / seat_h)
    for x, y in ((-ss, -ss), (ss, -ss), (ss, ss), (-ss, ss)):
        nodes.append((_r4(x), _r4(y), _r4(str_h)))
    edges: list[tuple[int, int, str]] = []
    for i in range(4):
        edges.append((i, (i + 1) % 4, "bar_r"))          # seat
        edges.append((4 + i, 4 + (i + 1) % 4, "bar_r"))  # feet ring
        edges.append((i, 4 + i, "bar_r"))                # legs
        edges.append((8 + i, 8 + (i + 1) % 4, "bar_r"))  # stretcher
        edges.append((4 + i, 8 + i, "bar_r"))            # leg to stretcher
    if is_chair:
        # backrest: two uprights on the -X seat edge + two slats
        bz = _r4(seat_h + back_h)
        nodes.append((-hs, -hs, bz))
        nodes.append((-hs, hs, bz))
        edges.append((0, 12, "bar_r"))
        edges.append((3, 13, "bar_r"))
        edges.append((12, 13, "bar_r"))
        mid_z = _r4(seat_h + back_h / 2)
        nodes.append((-hs, -hs, mid_z))
        nodes.append((-hs, hs, mid_z))
        edges.append((12, 14, "bar_r"))
        edges.append((14, 15, "bar_r"))
        edges.append((15, 13, "bar_r"))
    sc.nodes = nodes
    sc.nodes_expr = _nodes_literal(nodes)
    sc.edges = edges
    bbox = _bbox_of(nodes, joint_r)
    sc.set_bbox_exprs(str(bbox[0]), str(bbox[1]), str(bbox[2]))
    feats_ru = [
        f"сиденье {fmt(seat)} x {fmt(seat)} мм на высоте {fmt(seat_h)} мм",
        f"ноги с развалом {fmt(splay)} мм, кольцо жёсткости на {fmt(str_h)} мм",
    ]
    feats_en = [
        f"seat {fmt(seat)} x {fmt(seat)} mm at {fmt(seat_h)} mm height",
        f"legs splayed {fmt(splay)} mm, stretcher ring at {fmt(str_h)} mm",
    ]
    if is_chair:
        feats_ru.append(f"спинка высотой {fmt(back_h)} мм с двумя планками")
        feats_en.append(f"backrest {fmt(back_h)} mm tall with two slats")
    return sc.render(
        features_ru=feats_ru,
        features_en=feats_en,
        ru_nouns=("каркас табурета", "каркас стула", "раму сиденья"),
        en_nouns=("a stool frame", "a chair frame", "a seat frame"),
        bbox=bbox,
    )


# ---------------------------------------------------------------------------
# 4. shelfunit
# ---------------------------------------------------------------------------


def build_shelfunit(index: int) -> Part:
    rng = Rng("shelfunit4", index, seed=SEED_V5)
    n_shelf = int(rng.choice((2.0, 3.0)))
    width = rng.grid([60.0, 70.0, 80.0])
    depth = rng.grid([30.0, 35.0, 40.0])
    pitch = rng.grid([40.0, 45.0, 50.0])
    base_h = rng.grid([10.0, 12.0])
    bar_r = rng.grid([2.0, 2.5])
    brace_r = round(max(1.5, bar_r - 0.5), 2)
    joint_r = round(bar_r + 0.4, 2)
    top_z = _r4(base_h + n_shelf * pitch + 10.0)

    sc = WireScene("shelfunit", rng, "Shelf unit",
                   f"{n_shelf} shelves, {width:g} x {depth:g} mm")
    sc.param("n_shelf", float(n_shelf), "number of shelf loops")
    sc.param("width", width, "unit width, X")
    sc.param("depth", depth, "unit depth, Y")
    sc.param("pitch", pitch, "shelf pitch")
    sc.param("base_h", base_h, "foot height")
    sc.radius("bar_r", bar_r, "frame bar radius")
    sc.radius("brace_r", brace_r, "tie and brace member radius")
    sc.param("joint_r", joint_r, "joint ball radius")
    sc.diameter("bar_d", "bar_r", "bar diameter")
    sc.diameter("brace_d", "brace_r", "brace stock diameter")
    sc.derived.append("top_z = base_h + n_shelf * pitch + 10;  // post top height")

    nodes: list[tuple[float, float, float]] = []
    edges: list[tuple[int, int, str]] = []
    # posts: 4 verticals
    corners = ((0.0, 0.0), (width, 0.0), (width, depth), (0.0, depth))
    for x, y in corners:
        nodes.append((_r4(x), _r4(y), 0.0))
        nodes.append((_r4(x), _r4(y), top_z))
    for i in range(4):
        edges.append((2 * i, 2 * i + 1, "bar_r"))
    # shelf loops (foot ring + each shelf); every loop ties up to the post tops
    levels = [base_h] + [base_h + k * pitch for k in range(1, n_shelf + 1)]
    for z in levels:
        start = len(nodes)
        for x, y in corners:
            nodes.append((_r4(x), _r4(y), _r4(z)))
        for i in range(4):
            edges.append((start + i, start + (i + 1) % 4, "bar_r"))
        for i in range(4):
            edges.append((start + i, 2 * i + 1, "brace_r"))
    # X brace on the back face (y = 0) and one diagonal per side face
    edges.append((0, 3, "brace_r"))
    edges.append((2, 1, "brace_r"))
    edges.append((2, 5, "brace_r"))
    edges.append((6, 5, "brace_r"))
    sc.nodes = nodes
    sc.nodes_expr = _nodes_literal(nodes)
    sc.edges = edges
    bbox = _bbox_of(nodes, joint_r)
    sc.set_bbox_exprs(str(bbox[0]), str(bbox[1]), str(bbox[2]))
    return sc.render(
        features_ru=[
            f"{n_shelf} {_plural(n_shelf, 'полка', 'полки', 'полок')} {fmt(width)} x {fmt(depth)} мм с шагом {fmt(pitch)} мм",
            f"четыре стойки высотой {fmt(top_z)} мм",
            f"диагональные связи по задней и боковой стенкам",
        ],
        features_en=[
            f"{n_shelf} shelves {fmt(width)} x {fmt(depth)} mm on a {fmt(pitch)} mm pitch",
            f"four posts, {fmt(top_z)} mm tall",
            f"diagonal braces on the back and one side",
        ],
        ru_nouns=("каркас стеллажа", "стеллажную раму", "полочный каркас"),
        en_nouns=("a shelf unit frame", "a shelving frame", "a rack frame"),
        bbox=bbox,
    )


# ---------------------------------------------------------------------------
# 5. aladder
# ---------------------------------------------------------------------------


def build_aladder(index: int) -> Part:
    rng = Rng("aladder4", index, seed=SEED_V5)
    n_rung = int(rng.choice((3.0, 4.0)))
    height = rng.grid([90.0, 100.0, 110.0])
    foot_w = rng.grid([40.0, 45.0, 50.0])
    lean = rng.grid([25.0, 30.0, 35.0])   # foot offset from the apex, X
    ladder_w = rng.grid([30.0, 34.0, 38.0])
    plat_l = rng.grid([24.0, 28.0])
    rail_r = rng.grid([2.5, 3.0])
    rung_r = round(max(1.5, rail_r - 0.8), 2)
    joint_r = round(rail_r + 0.4, 2)

    sc = WireScene("aladder", rng, "A-frame ladder",
                   f"{n_rung} rungs, {height:g} mm tall")
    sc.param("n_rung", float(n_rung), "rungs per climbing face")
    sc.param("height", height, "apex height")
    sc.param("foot_w", foot_w, "frame foot spread, X")
    sc.param("lean", lean, "rear frame foot offset")
    sc.param("ladder_w", ladder_w, "ladder width, Y")
    sc.param("plat_l", plat_l, "top platform length")
    sc.radius("rail_r", rail_r, "rail member radius")
    sc.radius("rung_r", rung_r, "rung member radius")
    sc.param("joint_r", joint_r, "joint ball radius")
    sc.diameter("rail_d", "rail_r", "rail stock diameter")
    sc.diameter("rung_d", "rung_r", "rung stock diameter")

    if foot_w / (n_rung + 1) < 2 * rung_r + 4.0:
        raise ValueError("lowest rung too short")
    hy = _r4(ladder_w / 2)
    nodes: list[tuple[float, float, float]] = []
    # front A-frame: apex F, two feet at x = -+foot_w/2? front frame in the
    # plane y=-hy: apex (0,-hy,height), feet (+-foot_w/2, -hy, 0)
    nodes.append((0.0, -hy, _r4(height)))                       # 0 front apex
    nodes.append((_r4(-foot_w / 2), -hy, 0.0))                  # 1 front foot L
    nodes.append((_r4(foot_w / 2), -hy, 0.0))                   # 2 front foot R
    nodes.append((0.0, hy, _r4(height)))                        # 3 back apex
    nodes.append((_r4(-foot_w / 2 - lean), hy, 0.0))            # 4 rear foot L
    nodes.append((_r4(foot_w / 2 - lean), hy, 0.0))             # 5 rear foot R
    edges: list[tuple[int, int, str]] = [
        (0, 1, "rail_r"), (0, 2, "rail_r"), (1, 2, "rung_r"),
        (3, 4, "rail_r"), (3, 5, "rail_r"), (4, 5, "rung_r"),
        (0, 3, "rail_r"),  # apex tie
    ]
    # rungs on the front face
    for k in range(1, n_rung + 1):
        t = k / (n_rung + 1)
        zl = _r4(height * (1 - t))
        xl = _r4(-foot_w / 2 * t)
        xr = _r4(foot_w / 2 * t)
        nodes.append((xl, -hy, zl))
        nodes.append((xr, -hy, zl))
        li, ri = len(nodes) - 2, len(nodes) - 1
        edges.append((li, ri, "rung_r"))
        edges.append((1, li, "rung_r")) if k == 1 else None
        edges.append((2, ri, "rung_r")) if k == 1 else None
    # step rungs tie both rails: connect consecutive rung ends along the rails
    rung_ids = [6 + 2 * k for k in range(n_rung)]
    for a, b in zip(rung_ids, rung_ids[1:]):
        edges.append((a, b, "rung_r"))
        edges.append((a + 1, b + 1, "rung_r"))
    # top platform: small loop between the two apexes
    pz = _r4(height - 6.0)
    pl = _r4(plat_l / 2)
    base_p = len(nodes)
    for x, y in ((-pl, -hy), (pl, -hy), (pl, hy), (-pl, hy)):
        nodes.append((_r4(x), _r4(y), pz))
    for i in range(4):
        edges.append((base_p + i, base_p + (i + 1) % 4, "rung_r"))
    edges.append((0, base_p + 0, "rung_r"))
    edges.append((0, base_p + 1, "rung_r"))
    edges.append((3, base_p + 2, "rung_r"))
    edges.append((3, base_p + 3, "rung_r"))
    sc.nodes = nodes
    sc.nodes_expr = _nodes_literal(nodes)
    sc.edges = edges
    bbox = _bbox_of(nodes, joint_r)
    sc.set_bbox_exprs(str(bbox[0]), str(bbox[1]), str(bbox[2]))
    return sc.render(
        features_ru=[
            f"стремянка высотой {fmt(height)} мм с {n_rung} {_plural(n_rung, 'ступенью', 'ступенями', 'ступенями')}",
            f"передняя рама с опорой {fmt(foot_w)} мм, задняя смещена на {fmt(lean)} мм",
            f"площадка {fmt(plat_l)} мм под верхней точкой, ширина {fmt(ladder_w)} мм",
        ],
        features_en=[
            f"A-frame ladder {fmt(height)} mm tall with {n_rung} rungs",
            f"front frame {fmt(foot_w)} mm wide, rear frame offset {fmt(lean)} mm",
            f"top platform {fmt(plat_l)} mm, ladder width {fmt(ladder_w)} mm",
        ],
        ru_nouns=("стремянку", "каркас складной лестницы", "раму стремянки"),
        en_nouns=("a step ladder frame", "an A-frame ladder", "a folding ladder frame"),
        bbox=bbox,
    )


FAMILY_BUILDERS = {
    "pergola": build_pergola,
    "shopcart": build_shopcart,
    "stoolchair": build_stoolchair,
    "shelfunit": build_shelfunit,
    "aladder": build_aladder,
}
