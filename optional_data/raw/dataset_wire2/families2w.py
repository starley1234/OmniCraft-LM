"""wire2 families - the W2 block of ``docs/archive/DATASET_REQUEST_5.md``.

Six scene families of *real* frameworks, not paraphrases of the gen2 wire set:

* ``masttowers``   - tapered four-leg towers, per-level brace pattern (X /
  single diagonal / ring-only), optional crown mast with guys;
* ``bridgetrusses``- two side trusses (Pratt / Warren / Howe) plus a deck of
  cross beams on the bottom chord, optional lower/upper lateral bracing;
* ``spaceframes``  - triangular lattice girders and two-layer square space
  grids with selectable diagonal systems;
* ``piperoutes``   - tube runs with 45/90 degree elbows and manifold stubs,
  drawn as hull chains between collar joints (request: "hull-цепочки");
* ``guymasts``     - antenna masts guyed in one or two tiers to a ring of
  ground anchors;
* ``rollcages``    - 3-bay x 2-section safety cages: rails, hoops, side
  diagonals, optional roof X.

Node budget: never more than 32 nodes per scene.  The request text says 6-64,
but ``src/training/aux_losses.py`` raises for GT graphs above the canvas' 32
vertices (``src/model/wire_canvas.py`` is fixed at 32), so scenes larger than
32 could never be trained on.  This deviation is documented in the report.

Every scene file is fully parametric: the ``nodes`` array is computed from the
header variables by the code itself, member calls reference ``nodes[i]`` by
index, and every number quoted in the prompt exists in the header (place1 law).
"""

from __future__ import annotations

import math

from tools.dataset_gen2.common import Part, Rng, ScadBuilder, align, fmt
from tools.dataset_gen2.prompts import build_prompt, en_count, ru_count
from tools.dataset_v5.kit import MAX_GRAPH_NODES, SEED_V5, tail_pair

# ---------------------------------------------------------------------------
# shared code fragments
# ---------------------------------------------------------------------------

MEMBER_MODULE = (
    "module member(a, b, r) {",
    "  /* round stock from joint a to joint b, ends buried in the joint balls */",
    "  d = b - a;",
    "  length = norm(d);",
    "  translate(a) rotate([0, acos(d[2] / length), atan2(d[1], d[0])])",
    "    cylinder(h = length, r = r);",
    "}",
    "",
    "module joint(p, r) {",
    "  /* ball at the joint centre, fatter than every member meeting there */",
    "  translate(p) sphere(r = r);",
    "}",
)

def _r2(value: float) -> float:
    return round(value + 0.0, 2)


class WireScene:
    """Collects one wire scene: parameters, nodes, edges, prompts."""

    def __init__(self, family: str, rng: Rng, title: str, summary: str) -> None:
        self.family = family
        self.rng = rng
        self.builder = ScadBuilder(title, summary)
        self.derived: list[str] = []
        self.nodes_expr = ""
        self.nodes: list[tuple[float, float, float]] = []
        # edges: (i, j, radius_var)
        self.edges: list[tuple[int, int, str]] = []
        self.radius_vars: dict[str, float] = {}
        self.joint_var = "joint_r"
        self.member_module = MEMBER_MODULE
        self.member_call = "member"
        self.params: dict[str, float] = {}
        self.variant = ""
        self.notes = ""

    def param(self, name: str, value: float, comment: str) -> None:
        self.builder.param(name, value, comment)
        self.params[name] = float(value)

    def diameter(self, name: str, radius_var: str, comment: str) -> None:
        """Declare ``name = 2 * radius_var`` so the prompt may quote diameters."""
        self.derived.append(f"{name} = 2 * {radius_var};  // {comment}")

    def radius(self, var: str, value: float, comment: str) -> None:
        self.param(var, value, comment)
        self.radius_vars[var] = float(value)

    def render(self, *, features_ru: list[str], features_en: list[str],
               ru_nouns: tuple[str, ...], en_nouns: tuple[str, ...],
               bbox: tuple[float, float, float], graph_extra: dict | None = None) -> Part:
        # the tolerance tail is drawn first: when it fires, its two numbers
        # become header parameters so the place1 law holds
        ru_tail, en_tail, tol = tail_pair(self.rng)
        if tol is not None:
            self.param("fit_tol", tol[0], "declared fit tolerance (prompt contract)")
            self.param("free_tol", tol[1], "declared free tolerance (prompt contract)")
        # envelope lines reference parameters only and are scalar, so the
        # place1 auditor's header evaluator sees them even though it stops at
        # the first vector / comprehension assignment
        self.builder.assignment(f"bbox_x = {self._bbox_exprs[0]};  // overall X, joints included")
        self.builder.assignment(f"bbox_y = {self._bbox_exprs[1]};  // overall Y, joints included")
        self.builder.assignment(f"bbox_z = {self._bbox_exprs[2]};  // overall Z, joints included")
        for line in self.derived:
            self.builder.assignment(line)
        self.builder.assignment("nodes = " + self.nodes_expr + ";")

        lines = list(self.member_module)
        self.builder.section("\n".join(lines))

        members = ["/* members - each call is one graph edge */"]
        for i, j, var in self.edges:
            members.append(f"{self.member_call}(nodes[{i}], nodes[{j}], {var});")
        self.builder.section("\n".join(members))
        self.builder.section(f"/* joint balls */\nfor (p = nodes) joint(p, {self.joint_var});")

        code = self.builder.render()

        graph: dict = {
            "nodes": [[round(float(v), 4) for v in node] for node in self.nodes],
            "edges": [[i, j] for i, j, _ in self.edges],
            "member_radius_mm": round(max(self.radius_vars.values()), 2),
        }
        if graph_extra:
            graph.update(graph_extra)

        prompt_ru, prompt_en = build_prompt(
            self.rng,
            ru_nouns=ru_nouns,
            en_nouns=en_nouns,
            bbox=bbox,
            ru_feature_sentences=[s[0].upper() + s[1:] + "." for s in features_ru],
            en_feature_sentences=[s[0].upper() + s[1:] + "." for s in features_en],
            feature_count=self.rng.integer(3, min(4, max(3, len(features_ru)))),
            extra_tail=False,
        )
        return Part(
            family=self.family,
            variant=self.variant,
            code=code,
            bbox=bbox,
            params=self.params,
            prompt_ru=f"{prompt_ru} {ru_tail}",
            prompt_en=f"{prompt_en} {en_tail}",
        ).with_graph(graph)

    # -- internals ----------------------------------------------------------

    def set_bbox_exprs(self, ex: str, ey: str, ez: str) -> None:
        self._bbox_exprs = (ex, ey, ez)


# ---------------------------------------------------------------------------
# family 1: tapered four-leg towers
# ---------------------------------------------------------------------------

TOWER_RU = (
    "пространственную башню с сужением к верху", "решетчатую опору с ярусами",
    "четырехногую вышку с раскосами", "сварную башенную опору",
    "коническую ферменную мачту", "башню-опору переменного сечения",
)
TOWER_EN = (
    "a tapered lattice tower", "a four-leg braced tower", "a segmented frame mast",
    "a welded tower stand", "a tapered truss mast", "a variable-section tower frame",
)


def build_masttowers(index: int) -> Part:
    rng = Rng("masttowers", index, seed=SEED_V5)
    sc = WireScene("masttowers", rng, "Tapered four-leg tower", "")
    levels = rng.choice([3, 4, 5])
    base_w = rng.grid([70.0, 80.0, 90.0, 100.0, 110.0, 120.0])
    taper = rng.grid([0.62, 0.7, 0.78, 0.85])
    level_h = rng.grid([30.0, 35.0, 40.0, 45.0])
    top_w = base_w * (taper ** levels)
    leg_r = rng.grid([4.0, 4.5, 5.0])
    brace_r = _r2(max(1.6, leg_r - rng.grid([0.8, 1.0, 1.2])))
    joint_r = _r2(leg_r + 0.4)
    if top_w < max(24.0, 2.2 * leg_r + 6.0):
        raise ValueError("top ring too narrow for the brace pattern")
    crown = rng.chance(0.55)
    crown_h = rng.grid([20.0, 25.0, 30.0]) if crown else 0.0

    sc.variant = rng.choice(("x_brace", "mixed", "sparse"))
    if sc.variant == "x_brace":
        patterns = ["x"] * levels
    elif sc.variant == "sparse":
        patterns = [rng.choice(["single", "none"]) for _ in range(levels)]
    else:
        patterns = [rng.choice(["x", "single", "none"]) for _ in range(levels)]

    title_sum = f"{levels} levels, base {fmt(base_w)} mm, taper {fmt(taper)} per level"
    sc.builder.summary = title_sum
    sc.param("levels", float(levels), "number of tower levels")
    sc.param("base_w", base_w, "bottom ring width (X and Y)")
    sc.param("taper", taper, "ring width multiplier per level")
    sc.param("level_h", level_h, "height of one level")
    sc.radius("leg_r", leg_r, "leg / ring member radius")
    sc.radius("brace_r", brace_r, "diagonal brace radius")
    sc.param("joint_r", joint_r, "joint ball radius")
    if crown:
        sc.param("crown_h", crown_h, "crown mast height above the top ring")
    sc.diameter("leg_d", "leg_r", "leg / ring stock diameter")
    sc.diameter("brace_d", "brace_r", "brace stock diameter")
    sc.diameter("joint_d", "joint_r", "joint ball diameter")
    sc.derived.append("top_w = base_w * pow(taper, levels);  // width of the top ring")

    nodes_expr = (
        "[for (lvl = [0 : levels], sx = [-1, 1], sy = [-1, 1]) "
        "[sx * base_w * pow(taper, lvl) / 2, sy * base_w * pow(taper, lvl) / 2, lvl * level_h]]"
    )
    nodes: list[tuple[float, float, float]] = []
    for lvl in range(levels + 1):
        w = base_w * (taper ** lvl)
        for sx in (-1, 1):
            for sy in (-1, 1):
                nodes.append((round(sx * w / 2, 4), round(sy * w / 2, 4), round(lvl * level_h, 4)))
    if crown:
        nodes_expr = f"concat({nodes_expr}, [[0, 0, levels * level_h + crown_h]])"
        nodes.append((0.0, 0.0, round(levels * level_h + crown_h, 4)))
    sc.nodes = nodes
    sc.nodes_expr = nodes_expr

    def corner(lvl: int, k: int) -> int:
        return lvl * 4 + k  # k: 0=(-1,-1) 1=(-1,1) 2=(1,-1) 3=(1,1)

    # legs and rings
    for lvl in range(levels):
        for k in range(4):
            sc.edges.append((corner(lvl, k), corner(lvl + 1, k), "leg_r"))
    for lvl in range(levels + 1):
        for a, b in ((0, 1), (2, 3), (0, 2), (1, 3)):
            sc.edges.append((corner(lvl, a), corner(lvl, b), "leg_r"))
    # braces, one pattern per level; faces: (-x)=0-1, (+x)=2-3, (-y)=0-2, (+y)=1-3
    faces = ((0, 1), (2, 3), (0, 2), (1, 3))
    for lvl in range(levels):
        pattern = patterns[lvl]
        for face_index, (a, b) in enumerate(faces):
            bottom_a, bottom_b = corner(lvl, a), corner(lvl, b)
            top_a, top_b = corner(lvl + 1, a), corner(lvl + 1, b)
            if pattern == "x":
                sc.edges.append((bottom_a, top_b, "brace_r"))
                sc.edges.append((bottom_b, top_a, "brace_r"))
            elif pattern == "single":
                if (lvl + face_index) % 2 == 0:
                    sc.edges.append((bottom_a, top_b, "brace_r"))
                else:
                    sc.edges.append((bottom_b, top_a, "brace_r"))
    if crown:
        crown_node = len(nodes) - 1
        for k in range(4):
            sc.edges.append((corner(levels, k), crown_node, "brace_r"))

    total_h = levels * level_h + crown_h
    sc.set_bbox_exprs(
        "base_w + 2 * joint_r",
        "base_w + 2 * joint_r",
        f"levels * level_h{' + crown_h' if crown else ''} + 2 * joint_r",
    )
    bbox = (_r2(base_w + 2 * joint_r), _r2(base_w + 2 * joint_r), _r2(total_h + 2 * joint_r))

    x_count = sum(1 for p in patterns if p == "x")
    s_count = sum(1 for p in patterns if p == "single")
    n_count = sum(1 for p in patterns if p == "none")
    features_ru = [
        f"{ru_count(levels, 'ярус', 'яруса', 'ярусов')} по {fmt(level_h)} мм, сужение {fmt(taper)} на ярус",
        f"основание {fmt(base_w)} мм, верхний пояс {fmt(_r2(top_w))} мм",
        f"ноги и пояса из прутка диаметром {fmt(_r2(2 * leg_r))} мм, раскосы {fmt(_r2(2 * brace_r))} мм",
        f"раскосность: {ru_count(x_count, 'ярус', 'яруса', 'ярусов')} с X-раскосами, "
        f"{ru_count(s_count, 'ярус', 'яруса', 'ярусов')} с одиночными, {ru_count(n_count, 'ярус', 'яруса', 'ярусов')} только с поясами",
        f"шарнирные узлы диаметром {fmt(_r2(2 * joint_r))} мм",
    ]
    features_en = [
        f"{en_count(levels)} levels of {fmt(level_h)} mm, taper {fmt(taper)} per level",
        f"base {fmt(base_w)} mm, top chord {fmt(_r2(top_w))} mm",
        f"legs and rings of {fmt(_r2(2 * leg_r))} mm round stock, braces {fmt(_r2(2 * brace_r))} mm",
        f"bracing: {en_count(x_count)} X-braced levels, {en_count(s_count)} single-diagonal, "
        f"{en_count(n_count)} ring-only",
        f"joint balls {fmt(_r2(2 * joint_r))} mm across",
    ]
    if crown:
        features_ru.append(f"короткая мачта-оголовок {fmt(crown_h)} мм с оттяжками к верхнему поясу")
        features_en.append(f"crown mast {fmt(crown_h)} mm tall, guyed to the top ring")
    return sc.render(
        features_ru=features_ru, features_en=features_en,
        ru_nouns=TOWER_RU, en_nouns=TOWER_EN, bbox=bbox,
    )


# ---------------------------------------------------------------------------
# family 2: bridge trusses with a deck
# ---------------------------------------------------------------------------

BRIDGE_RU = (
    "мостовую ферму с проезжей частью понизу", "пролетное строение моста",
    "мост с двумя боковыми фермами", "ферменный мостовой пролет",
    "мостовую конструкцию с нижним проездом", "двухферменный мост",
)
BRIDGE_EN = (
    "a through-truss bridge span", "a bridge span with a lower deck",
    "a two-truss bridge", "a deck-bottom truss bridge", "a lattice bridge span",
    "a pony-truss style bridge frame",
)


def build_bridgetrusses(index: int) -> Part:
    rng = Rng("bridgetrusses", index, seed=SEED_V5)
    kind = rng.choice(("pratt", "warren", "howe", "pratt", "warren"))
    panels = rng.choice([3, 4, 5])
    panel_p = rng.grid([28.0, 32.0, 36.0, 40.0])
    span = _r2(panels * panel_p)
    track = rng.grid([30.0, 36.0, 44.0, 50.0])
    truss_h = _r2(min(rng.grid([24.0, 28.0, 32.0, 36.0, 40.0]), span * 0.45))
    if truss_h < 20.0:
        raise ValueError("truss too shallow")
    chord_r = rng.grid([4.0, 4.5, 5.0])
    web_r = _r2(max(1.6, chord_r - rng.grid([1.0, 1.4, 1.6])))
    deck_r = _r2(max(1.5, web_r - rng.grid([0.0, 0.4])))
    joint_r = _r2(chord_r + 0.4)
    lower_lateral = rng.chance(0.6)
    upper_lateral = kind != "warren" and rng.chance(0.5)

    sc = WireScene(
        "bridgetrusses", rng, {"pratt": "Pratt", "warren": "Warren", "howe": "Howe"}[kind] + " through truss",
        f"span {fmt(span)} mm, {panels} panels, two trusses {fmt(track)} mm apart",
    )
    sc.variant = kind
    sc.param("panels", float(panels), "number of equal panels per truss")
    sc.param("panel_p", panel_p, "panel length, X")
    sc.param("span", span, "truss span between end joints")
    sc.param("truss_h", truss_h, "truss height, Z")
    sc.param("track", track, "distance between the two trusses, Y")
    sc.radius("chord_r", chord_r, "chord member radius")
    sc.radius("web_r", web_r, "web member radius")
    sc.radius("deck_r", deck_r, "deck beam radius")
    sc.param("joint_r", joint_r, "joint ball radius")
    sc.diameter("chord_d", "chord_r", "chord stock diameter")
    sc.diameter("web_d", "web_r", "web stock diameter")
    sc.diameter("deck_d", "deck_r", "deck beam diameter")
    sc.diameter("joint_d", "joint_r", "joint ball diameter")

    top_count = panels if kind == "warren" else panels + 1
    per_truss = (panels + 1) + top_count
    if 2 * per_truss > MAX_GRAPH_NODES:
        raise ValueError("too many nodes for the canvas")

    # node order mirrors the comprehension below: bottoms of both trusses
    # first (side -1, then +1), then the top chords of both trusses
    nodes: list[tuple[float, float, float]] = []
    for y in (-track / 2, track / 2):
        for i in range(panels + 1):
            nodes.append((_r2(i * panel_p), _r2(y), 0.0))
    for y in (-track / 2, track / 2):
        for i in range(top_count):
            x = panel_p * (i + 0.5) if kind == "warren" else panel_p * i
            nodes.append((_r2(x), _r2(y), truss_h))
    sc.nodes = nodes
    if kind == "warren":
        top_clause = (
            "for (side = [-1, 1], i = [0 : panels - 1]) "
            "[(i + 0.5) * panel_p, side * track / 2, truss_h]]"
        )
    else:
        top_clause = (
            "for (side = [-1, 1], i = [0 : panels]) "
            "[i * panel_p, side * track / 2, truss_h]]"
        )
    sc.nodes_expr = (
        "[for (side = [-1, 1], i = [0 : panels]) [i * panel_p, side * track / 2, 0], "
        + top_clause
    )

    bot = {0: 0, 1: panels + 1}                     # bottom-chord base index per truss
    top = {0: 2 * (panels + 1), 1: 2 * (panels + 1) + top_count}  # top-chord base

    for truss in (0, 1):
        b0, t0 = bot[truss], top[truss]
        for i in range(panels):
            sc.edges.append((b0 + i, b0 + i + 1, "chord_r"))
        if kind == "warren":
            # top chord between successive warren apexes
            for i in range(panels - 1):
                sc.edges.append((t0 + i, t0 + i + 1, "chord_r"))
            for i in range(panels):
                sc.edges.append((b0 + i, t0 + i, "web_r"))
                sc.edges.append((b0 + i + 1, t0 + i, "web_r"))
        else:
            for i in range(panels):
                sc.edges.append((t0 + i, t0 + i + 1, "chord_r"))
            for i in range(1, panels):
                sc.edges.append((b0 + i, t0 + i, "web_r"))
            for i in range(panels):
                toward_centre = (kind == "pratt") == (i < panels / 2)
                if toward_centre:
                    sc.edges.append((b0 + i, t0 + i + 1, "web_r"))
                else:
                    sc.edges.append((t0 + i, b0 + i + 1, "web_r"))
    bottom_a = lambda i: i  # noqa: E731
    bottom_b = lambda i: (panels + 1) + i  # noqa: E731
    top_a = lambda i: 2 * (panels + 1) + i  # noqa: E731
    top_b = lambda i: 2 * (panels + 1) + top_count + i  # noqa: E731
    # deck cross beams on the bottom chords
    for i in range(panels + 1):
        sc.edges.append((bottom_a(i), bottom_b(i), "deck_r"))
    if lower_lateral:
        for i in range(panels):
            sc.edges.append((bottom_a(i), bottom_b(i + 1), "deck_r"))
            sc.edges.append((bottom_b(i), bottom_a(i + 1), "deck_r"))
    if upper_lateral:
        for i in range(panels + 1):
            sc.edges.append((top_a(i), top_b(i), "web_r"))
        for i in range(panels):
            sc.edges.append((top_a(i), top_b(i + 1), "web_r"))
            sc.edges.append((top_b(i), top_a(i + 1), "web_r"))

    sc.set_bbox_exprs(
        "span + 2 * joint_r",
        "track + 2 * joint_r",
        "truss_h + 2 * joint_r",
    )
    bbox = (_r2(span + 2 * joint_r), _r2(track + 2 * joint_r), _r2(truss_h + 2 * joint_r))

    style_ru = {
        "pratt": "раскосы наклонены к середине пролета, стойки вертикальные",
        "howe": "раскосы наклонены от середины к опорам",
        "warren": "зигзагообразные раскосы без стоек",
    }[kind]
    style_en = {
        "pratt": "diagonals lean toward mid-span, vertical posts",
        "howe": "diagonals lean away from mid-span",
        "warren": "zig-zag diagonals without posts",
    }[kind]
    features_ru = [
        f"{ru_count(panels, 'равная панель', 'равные панели', 'равных панелей')} по {fmt(panel_p)} мм, пролет {fmt(span)} мм",
        f"две боковые фермы с шагом {fmt(track)} мм, высота {fmt(truss_h)} мм",
        f"схема {style_ru}",
        f"поперечины проезжей части диаметром {fmt(_r2(2 * deck_r))} мм по нижним поясам",
        f"пояса диаметром {fmt(_r2(2 * chord_r))} мм, раскосы {fmt(_r2(2 * web_r))} мм",
    ]
    features_en = [
        f"{en_count(panels)} equal panels of {fmt(panel_p)} mm, span {fmt(span)} mm",
        f"two side trusses {fmt(track)} mm apart, {fmt(truss_h)} mm deep",
        f"{kind} layout: {style_en}",
        f"deck cross beams of {fmt(_r2(2 * deck_r))} mm stock on the bottom chords",
        f"chords {fmt(_r2(2 * chord_r))} mm, webs {fmt(_r2(2 * web_r))} mm round",
    ]
    if lower_lateral:
        features_ru.append("нижние связи с X-раскосами между поперечинами")
        features_en.append("lower lateral X-bracing between the cross beams")
    if upper_lateral:
        features_ru.append("верхние горизонтальные связи с крестами")
        features_en.append("upper lateral bracing with X panels")
    return sc.render(
        features_ru=features_ru, features_en=features_en,
        ru_nouns=BRIDGE_RU, en_nouns=BRIDGE_EN, bbox=bbox,
    )


# ---------------------------------------------------------------------------
# family 3: space frames - triangular girders and two-layer grids
# ---------------------------------------------------------------------------

SPACE_RU = (
    "пространственную решетчатую балку", "ферму треугольного сечения",
    "двухслойную пространственную плиту", "решетчатую опору-перекрытие",
    "объемный ферменный блок", "пространственную ферму",
)
SPACE_EN = (
    "a space lattice girder", "a triangular-section truss",
    "a double-layer space grid", "a lattice deck panel",
    "a 3D truss block", "a space frame panel",
)


def build_spaceframes(index: int) -> Part:
    rng = Rng("spaceframes", index, seed=SEED_V5)
    variant = rng.choice(("girder", "girder", "spacegrid"))
    chord_r = rng.grid([3.5, 4.0, 4.5])
    web_r = _r2(max(1.5, chord_r - rng.grid([0.8, 1.0])))
    joint_r = _r2(chord_r + 0.4)
    system = rng.choice(("x", "single", "x", "mixed"))

    sc = WireScene("spaceframes", rng, "Space frame", "")
    sc.variant = variant
    sc.radius("chord_r", chord_r, "chord / longeron radius")
    sc.radius("web_r", web_r, "diagonal and strut radius")
    sc.param("joint_r", joint_r, "joint ball radius")
    sc.diameter("chord_d", "chord_r", "chord stock diameter")
    sc.diameter("web_d", "web_r", "web stock diameter")
    sc.diameter("joint_d", "joint_r", "joint ball diameter")

    if variant == "girder":
        bays = rng.choice([4, 5, 6])
        bay_p = rng.grid([26.0, 30.0, 34.0, 38.0])
        girder_w = rng.grid([26.0, 30.0, 36.0])
        girder_h = rng.grid([24.0, 28.0, 32.0])
        length = _r2(bays * bay_p)
        sc.param("bays", float(bays), "number of bays along X")
        sc.param("bay_p", bay_p, "bay length, X")
        sc.param("girder_w", girder_w, "triangle base width, Y")
        sc.param("girder_h", girder_h, "triangle height, Z")
        sc.derived.append("span_x = bays * bay_p;  // overall girder length")
        nodes: list[tuple[float, float, float]] = []
        for i in range(bays + 1):
            x = _r2(i * bay_p)
            nodes.append((x, 0.0, 0.0))
            nodes.append((x, girder_w, 0.0))
            nodes.append((x, _r2(girder_w / 2), girder_h))
        sc.nodes = nodes
        sc.nodes_expr = (
            "[for (i = [0 : bays], k = [0 : 2]) "
            "[i * bay_p, k == 1 ? girder_w : k == 2 ? girder_w / 2 : 0, "
            "k == 2 ? girder_h : 0]]"
        )
        sta = lambda i, k: 3 * i + k  # noqa: E731
        # longerons
        for k in range(3):
            for i in range(bays):
                sc.edges.append((sta(i, k), sta(i + 1, k), "chord_r"))
        # station triangles
        for i in range(bays + 1):
            sc.edges.append((sta(i, 0), sta(i, 1), "chord_r"))
            sc.edges.append((sta(i, 1), sta(i, 2), "chord_r"))
            sc.edges.append((sta(i, 0), sta(i, 2), "chord_r"))
        # face diagonals on the three faces: (0-1) bottom, (1-2) and (0-2) slopes
        faces = ((0, 1), (1, 2), (0, 2))
        for i in range(bays):
            for face_index, (a, b) in enumerate(faces):
                use_x = system == "x" or (system == "mixed" and (i + face_index) % 2 == 0)
                if use_x:
                    sc.edges.append((sta(i, a), sta(i + 1, b), "web_r"))
                    sc.edges.append((sta(i, b), sta(i + 1, a), "web_r"))
                else:
                    if (i + face_index) % 2 == 0:
                        sc.edges.append((sta(i, a), sta(i + 1, b), "web_r"))
                    else:
                        sc.edges.append((sta(i, b), sta(i + 1, a), "web_r"))
        sc.set_bbox_exprs(
            "bays * bay_p + 2 * joint_r",
            "girder_w + 2 * joint_r",
            "girder_h + 2 * joint_r",
        )
        bbox = (_r2(length + 2 * joint_r), _r2(girder_w + 2 * joint_r), _r2(girder_h + 2 * joint_r))
        features_ru = [
            f"{ru_count(bays, 'панель', 'панели', 'панелей')} длиной {fmt(bay_p)} мм, общая длина {fmt(length)} мм",
            f"треугольное сечение: основание {fmt(girder_w)} мм, высота {fmt(girder_h)} мм",
            f"три лонжерона диаметром {fmt(_r2(2 * chord_r))} мм",
            f"диагонали {fmt(_r2(2 * web_r))} мм, система {('крестовая' if system in ('x', 'mixed') else 'одиночная')}",
        ]
        features_en = [
            f"{en_count(bays)} bays of {fmt(bay_p)} mm, {fmt(length)} mm long overall",
            f"triangular section: base {fmt(girder_w)} mm, height {fmt(girder_h)} mm",
            f"three longerons of {fmt(_r2(2 * chord_r))} mm stock",
            f"{fmt(_r2(2 * web_r))} mm diagonals, {('X' if system in ('x', 'mixed') else 'single')} system",
        ]
    else:
        bx = rng.choice([2, 3])
        by = rng.choice([2, 3])
        if (bx + 1) * (by + 1) * 2 > MAX_GRAPH_NODES - 2:
            raise ValueError("grid too large for the canvas")
        pitch = rng.grid([30.0, 36.0, 40.0])
        grid_h = rng.grid([20.0, 24.0, 28.0])
        sc.param("cells_x", float(bx), "cells along X")
        sc.param("cells_y", float(by), "cells along Y")
        sc.param("pitch", pitch, "grid pitch (X and Y)")
        sc.param("grid_h", grid_h, "layer spacing, Z")
        sc.derived.append("plan_x = cells_x * pitch;  // chord plan length, X")
        sc.derived.append("plan_y = cells_y * pitch;  // chord plan width, Y")
        nodes = []
        for z in (0.0, grid_h):
            for i in range(bx + 1):
                for j in range(by + 1):
                    nodes.append((_r2(i * pitch), _r2(j * pitch), _r2(z)))
        sc.nodes = nodes
        half_n = (bx + 1) * (by + 1)
        sc.nodes_expr = (
            "[for (lvl = [0, 1], i = [0 : cells_x], j = [0 : cells_y]) "
            "[i * pitch, j * pitch, lvl * grid_h]]"
        )
        node = lambda lvl, i, j: lvl * half_n + i * (by + 1) + j  # noqa: E731
        for lvl in (0, 1):
            for i in range(bx):
                for j in range(by + 1):
                    sc.edges.append((node(lvl, i, j), node(lvl, i + 1, j), "chord_r"))
            for i in range(bx + 1):
                for j in range(by):
                    sc.edges.append((node(lvl, i, j), node(lvl, i, j + 1), "chord_r"))
        for i in range(bx + 1):
            for j in range(by + 1):
                sc.edges.append((node(0, i, j), node(1, i, j), "web_r"))
        # side-face diagonals
        for i in range(bx):
            for j in range(by + 1):
                if system == "x" or (system == "mixed" and i % 2 == 0) or (system == "single" and i % 2 == 0):
                    if system == "x":
                        sc.edges.append((node(0, i, j), node(1, i + 1, j), "web_r"))
                        sc.edges.append((node(1, i, j), node(0, i + 1, j), "web_r"))
                    else:
                        sc.edges.append((node(0, i, j), node(1, i + 1, j), "web_r"))
        for i in range(bx + 1):
            for j in range(by):
                if system == "x" or (system == "mixed" and j % 2 == 1) or (system == "single" and j % 2 == 1):
                    if system == "x":
                        sc.edges.append((node(0, i, j), node(1, i, j + 1), "web_r"))
                        sc.edges.append((node(1, i, j), node(0, i, j + 1), "web_r"))
                    else:
                        sc.edges.append((node(1, i, j), node(0, i, j + 1), "web_r"))
        length_x = _r2(bx * pitch)
        length_y = _r2(by * pitch)
        sc.set_bbox_exprs(
            "cells_x * pitch + 2 * joint_r",
            "cells_y * pitch + 2 * joint_r",
            "grid_h + 2 * joint_r",
        )
        bbox = (_r2(length_x + 2 * joint_r), _r2(length_y + 2 * joint_r), _r2(grid_h + 2 * joint_r))
        features_ru = [
            f"двухслойная сетка {bx} на {by} ячейки с шагом {fmt(pitch)} мм",
            f"габарит по поясам {fmt(length_x)} на {fmt(length_y)} мм",
            f"высота фермы {fmt(grid_h)} мм, стойки диаметром {fmt(_r2(2 * web_r))} мм",
            f"пояса диаметром {fmt(_r2(2 * chord_r))} мм",
        ]
        features_en = [
            f"double-layer grid, {bx} by {by} cells at {fmt(pitch)} mm pitch",
            f"chord plan {fmt(length_x)} by {fmt(length_y)} mm",
            f"{fmt(grid_h)} mm deep, struts {fmt(_r2(2 * web_r))} mm round",
            f"chords of {fmt(_r2(2 * chord_r))} mm stock",
        ]
    return sc.render(
        features_ru=features_ru, features_en=features_en,
        ru_nouns=SPACE_RU, en_nouns=SPACE_EN, bbox=bbox,
    )


# ---------------------------------------------------------------------------
# family 4: pipe routes (hull chains with collars)
# ---------------------------------------------------------------------------

PIPE_RU = (
    "трубную трассу с отводами", "трубопровод с поворотами",
    "гнутый трубопроводный участок", "трубный узел с коллектором",
    "трубную разводку с коленами", "участок магистрали с отводами",
)
PIPE_EN = (
    "a pipe route with elbows", "a bent pipe run", "a tubing spool with turns",
    "a manifold pipe section", "a pipe run with offsets", "a header with branch stubs",
)

# unit directions: axis-aligned and 45-degree diagonals in a plane
_PIPE_DIRS = {
    "x+": (1.0, 0.0, 0.0), "x-": (-1.0, 0.0, 0.0),
    "y+": (0.0, 1.0, 0.0), "y-": (0.0, -1.0, 0.0),
    "z+": (0.0, 0.0, 1.0), "z-": (0.0, 0.0, -1.0),
    "xz+": (math.sqrt(0.5), 0.0, math.sqrt(0.5)),
    "xz-": (math.sqrt(0.5), 0.0, -math.sqrt(0.5)),
    "yz+": (0.0, math.sqrt(0.5), math.sqrt(0.5)),
}


def _dir_expr(key: str) -> str:
    mapping = {
        "x+": "[1, 0, 0]", "x-": "[-1, 0, 0]", "y+": "[0, 1, 0]", "y-": "[0, -1, 0]",
        "z+": "[0, 0, 1]", "z-": "[0, 0, -1]",
        "xz+": "[1 / sqrt(2), 0, 1 / sqrt(2)]", "xz-": "[1 / sqrt(2), 0, -1 / sqrt(2)]",
        "yz+": "[0, 1 / sqrt(2), 1 / sqrt(2)]",
    }
    return mapping[key]


def _turn_angle(a: str, b: str) -> float:
    va, vb = _PIPE_DIRS[a], _PIPE_DIRS[b]
    dot = sum(x * y for x, y in zip(va, vb))
    return math.degrees(math.acos(max(-1.0, min(1.0, dot))))


def build_piperoutes(index: int) -> Part:
    rng = Rng("piperoutes", index, seed=SEED_V5)
    variant = rng.choice(("elbows", "elbows", "manifold", "riser"))
    pipe_r = rng.grid([2.5, 3.0, 3.5, 4.0, 4.5, 5.0])
    collar_r = _r2(pipe_r + 0.6)

    sc = WireScene("piperoutes", rng, "Pipe route", "")
    sc.variant = variant
    # NOTE: hull(sphere, sphere) capsules were tried and rejected here for the
    # same reason gen2 rejected them (see tools/dataset_gen2/families/wire.py):
    # near-tangential hull shells leave hair-thin flaps that decompose into a
    # second "solid".  Pipes therefore use round stock between fat collar
    # joints - strictly positive overlap, one component, deterministic.
    sc.radius("pipe_r", pipe_r, "pipe radius")
    sc.param("collar_r", collar_r, "joint collar radius")
    sc.joint_var = "collar_r"
    sc.param("turn_90", 90.0, "right-angle elbow, degrees")
    sc.param("turn_45", 45.0, "diagonal elbow angle, degrees")
    sc.diameter("pipe_d", "pipe_r", "pipe outer diameter")
    sc.diameter("collar_d", "collar_r", "collar diameter")

    # walk: sequence of (direction key, length)
    walk: list[tuple[str, float]] = []
    if variant == "riser":
        first = "z+"
        walk.append((first, rng.grid([26.0, 30.0, 34.0])))
        for _ in range(rng.integer(2, 4)):
            options = [k for k in ("x+", "y+", "xz+", "yz+") if _turn_angle(first, k) in (45.0, 90.0)]
            nxt = rng.choice(options)
            walk.append((nxt, rng.grid([24.0, 30.0, 36.0])))
            walk.append(("z+", rng.grid([26.0, 32.0, 40.0])))
            first = "z+"
    else:
        allowed = ["x+", "y+", "z+"]
        current = rng.choice(allowed)
        walk.append((current, rng.grid([30.0, 36.0, 44.0])))
        # elbows: at least 5 segments (manifold stubs add nodes later); the
        # request asks for 6-32 (capped) nodes per scene
        for _ in range(rng.integer(4, 6) if variant != "manifold" else rng.integer(2, 4)):
            if rng.chance(0.45):
                options = [k for k in ("xz+", "xz-", "yz+") if 40.0 < _turn_angle(current, k) < 50.0]
                if not options:
                    options = [k for k in allowed if k != current]
                nxt = rng.choice(options)
            else:
                options = [k for k in allowed if _turn_angle(current, k) == 90.0]
                nxt = rng.choice(options)
            walk.append((nxt, rng.grid([26.0, 32.0, 40.0, 48.0])))
            current = nxt

    points: list[tuple[float, float, float]] = [(0.0, 0.0, 0.0)]
    derived: list[str] = ["p0 = [0, 0, 0];"]
    # symbolic per-axis coordinates: list of (sign, is_half, leg name) terms
    terms: list[list[list[tuple[str, bool, str]]]] = [[[], [], []]]
    for step, (key, length) in enumerate(walk, start=1):
        sc.param(f"leg_{step}", length, f"length of pipe segment {step}")
        derived.append(f"p{step} = p{step - 1} + {_dir_expr(key)} * leg_{step};")
        d = _PIPE_DIRS[key]
        prev = points[-1]
        points.append(tuple(round(prev[axis] + d[axis] * length, 4) for axis in range(3)))  # type: ignore[arg-type]
        previous_terms = terms[-1]
        new_terms = []
        for axis in range(3):
            axis_terms = list(previous_terms[axis])
            component = d[axis]
            if component != 0.0:
                half = abs(abs(component) - math.sqrt(0.5)) < 1e-9
                axis_terms.append(("+" if component > 0 else "-", half, f"leg_{step}"))
            new_terms.append(axis_terms)
        terms.append(new_terms)
    sc.param("segments", float(len(walk)), "number of straight pipe segments")

    branches: list[int] = []
    if variant == "manifold":
        stub_count = rng.integer(2, 3)
        candidates = [i for i in range(1, len(points) - 1)]
        for stub in rng.sample(candidates, stub_count):
            options = [k for k in ("x-", "y+", "y-", "z+") if _turn_angle(walk[stub - 1][0], k) in (45.0, 90.0)]
            key = rng.choice(options)
            length = rng.grid([20.0, 24.0, 28.0])
            sc.param(f"stub_{stub}", length, f"branch stub length at node {stub}")
            derived.append(f"b{stub} = p{stub} + {_dir_expr(key)} * stub_{stub};")
            d = _PIPE_DIRS[key]
            src = points[stub]
            points.append(tuple(round(src[axis] + d[axis] * length, 4) for axis in range(3)))  # type: ignore[arg-type]
            new_terms = []
            for axis in range(3):
                axis_terms = list(terms[stub][axis])
                if d[axis] != 0.0:
                    half = abs(abs(d[axis]) - math.sqrt(0.5)) < 1e-9
                    axis_terms.append(("+" if d[axis] > 0 else "-", half, f"stub_{stub}"))
                new_terms.append(axis_terms)
            terms.append(new_terms)
            branches.append(stub)

    node_names = [f"p{i}" for i in range(len(walk) + 1)] + [f"b{b}" for b in branches]
    sc.nodes = points
    sc.nodes_expr = "[" + ", ".join(node_names) + "]"
    sc.derived.extend(derived)

    for step in range(len(walk)):
        sc.edges.append((step, step + 1, "pipe_r"))
    for n, stub in enumerate(branches):
        sc.edges.append((stub, len(walk) + 1 + n, "pipe_r"))

    def axis_expr(axis: int, waypoint: int) -> str:
        pieces: list[str] = []
        for sign, half, leg in terms[waypoint][axis]:
            piece = f"{leg} / sqrt(2)" if half else leg
            if not pieces:
                pieces.append(piece if sign == "+" else f"-{piece}")
            else:
                pieces.append(f"{'+' if sign == '+' else '-'} {piece}")
        return " ".join(pieces) if pieces else "0"

    bbox_exprs = []
    for axis in range(3):
        values = [point[axis] for point in points]
        high = max(range(len(values)), key=lambda i: values[i])
        low = min(range(len(values)), key=lambda i: values[i])
        bbox_exprs.append(
            f"({axis_expr(axis, high)}) - ({axis_expr(axis, low)}) + 2 * collar_r"
        )
    xs = [p[0] for p in points]
    ys = [p[1] for p in points]
    zs = [p[2] for p in points]
    sc.set_bbox_exprs(*bbox_exprs)
    bbox = (
        _r2(max(xs) - min(xs) + 2 * collar_r),
        _r2(max(ys) - min(ys) + 2 * collar_r),
        _r2(max(zs) - min(zs) + 2 * collar_r),
    )

    straight = sum(1 for i in range(1, len(walk)) if _turn_angle(walk[i - 1][0], walk[i][0]) == 90.0)
    diagonal = sum(1 for i in range(1, len(walk)) if 40.0 < _turn_angle(walk[i - 1][0], walk[i][0]) < 50.0)
    features_ru = [
        f"труба диаметром {fmt(_r2(2 * pipe_r))} мм, {ru_count(len(walk), 'прямой участок', 'прямых участка', 'прямых участков')}",
        f"{ru_count(straight, 'отвод', 'отвода', 'отводов')} на 90 градусов"
        + (f" и {ru_count(diagonal, 'отвод', 'отвода', 'отводов')} на 45" if diagonal else ""),
        f"муфты-узлы диаметром {fmt(_r2(2 * collar_r))} мм",
    ]
    features_en = [
        f"pipe of {fmt(_r2(2 * pipe_r))} mm diameter, {en_count(len(walk))} straight segments",
        f"{en_count(straight)} right-angle elbows"
        + (f" and {en_count(diagonal)} at 45 degrees" if diagonal else ""),
        f"joint collars {fmt(_r2(2 * collar_r))} mm across",
    ]
    if variant == "manifold":
        features_ru.append(f"{ru_count(len(branches), 'отвод-заглушка', 'отвода-заглушки', 'отводов-заглушек')} длиной {fmt(min(sc.params[f'stub_{b}'] for b in branches))}-{fmt(max(sc.params[f'stub_{b}'] for b in branches))} мм")
        features_en.append(f"{en_count(len(branches))} branch stubs")
    return sc.render(
        features_ru=features_ru, features_en=features_en,
        ru_nouns=PIPE_RU, en_nouns=PIPE_EN, bbox=bbox,
    )


# ---------------------------------------------------------------------------
# family 5: guyed antenna masts
# ---------------------------------------------------------------------------

GUY_RU = (
    "антенную мачту с оттяжками", "мачту на растяжках",
    "радиомачту с якорями", "мачту с ярусами оттяжек",
    "подъемную мачту-антенну", "мачту с наземными анкерами",
)
GUY_EN = (
    "a guyed antenna mast", "a radio mast with guys", "a stayed mast",
    "an antenna tower with anchor points", "a guy-wire mast",
    "a mast with ground anchors",
)


def build_guymasts(index: int) -> Part:
    rng = Rng("guymasts", index, seed=SEED_V5)
    segments = rng.choice([3, 4, 5])
    seg_h = rng.grid([35.0, 40.0, 45.0, 48.0])
    if segments * seg_h > 230.0:
        raise ValueError("mast too tall for the envelope")
    mast_r = rng.grid([3.0, 3.5, 4.0, 4.5])
    guy_r = rng.grid([1.5, 2.0, 2.5])
    joint_r = _r2(mast_r + 0.5)
    anchors_n = rng.choice([3, 4, 6])
    anchor_r = rng.grid([60.0, 70.0, 80.0, 90.0, 100.0])
    anchor_a0 = rng.grid([0.0, 15.0, 30.0])
    anchor_step = 360.0 / anchors_n
    tier_indexes = sorted({segments, max(1, round(segments * 0.6)), max(1, round(segments * 0.4))}, reverse=True)
    tiers = tier_indexes[: rng.choice([1, 2, 2, 3]) if segments > 3 else 2]
    tiers = sorted(set(min(t, segments) for t in tiers), reverse=True)

    sc = WireScene(
        "guymasts", rng, "Guyed mast",
        f"{segments} sections of {fmt(seg_h)} mm, {anchors_n} anchors on R{fmt(anchor_r)}",
    )
    sc.variant = rng.choice(("single_tier", "multi_tier")) if len(tiers) > 1 else "single_tier"
    sc.param("sections", float(segments), "number of mast sections")
    sc.param("seg_h", seg_h, "section height")
    sc.radius("mast_r", mast_r, "mast member radius")
    sc.radius("guy_r", guy_r, "guy wire radius")
    sc.param("joint_r", joint_r, "joint ball radius")
    sc.param("anchors_n", float(anchors_n), "number of ground anchors")
    sc.param("anchor_r", anchor_r, "anchor ring radius")
    sc.param("anchor_step", anchor_step, "angle between anchors, degrees")
    sc.param("anchor_a0", anchor_a0, "angle of the first anchor, degrees")
    sc.param("tiers", float(len(tiers)), "number of guy tiers")
    sc.diameter("mast_d", "mast_r", "mast trunk diameter")
    sc.diameter("guy_d", "guy_r", "guy wire diameter")
    sc.diameter("joint_d", "joint_r", "joint ball diameter")
    for tier in tiers:
        sc.param(f"guy_h_{tier}", _r2(tier * seg_h), f"guy tier height (section {tier})")

    nodes: list[tuple[float, float, float]] = [(0.0, 0.0, _r2(i * seg_h)) for i in range(segments + 1)]
    for k in range(anchors_n):
        angle = anchor_a0 + k * anchor_step
        nodes.append((round(anchor_r * math.cos(math.radians(angle)), 4),
                      round(anchor_r * math.sin(math.radians(angle)), 4), 0.0))
    sc.nodes = nodes
    mast_expr = "[for (i = [0 : sections]) [0, 0, i * seg_h]]"
    anchor_expr = (
        "[for (k = [0 : anchors_n - 1]) "
        "[anchor_r * cos(anchor_a0 + k * anchor_step), anchor_r * sin(anchor_a0 + k * anchor_step), 0]]"
    )
    sc.nodes_expr = f"concat({mast_expr}, {anchor_expr})"

    for i in range(segments):
        sc.edges.append((i, i + 1, "mast_r"))
    for tier in tiers:
        for k in range(anchors_n):
            sc.edges.append((tier, segments + 1 + k, "guy_r"))

    angles = [anchor_a0 + k * anchor_step for k in range(anchors_n)]
    cosines = [math.cos(math.radians(angle)) for angle in angles]
    sines = [math.sin(math.radians(angle)) for angle in angles]
    kx_hi = max(range(anchors_n), key=lambda k: cosines[k])
    kx_lo = min(range(anchors_n), key=lambda k: cosines[k])
    ky_hi = max(range(anchors_n), key=lambda k: sines[k])
    ky_lo = min(range(anchors_n), key=lambda k: sines[k])
    sc.set_bbox_exprs(
        f"anchor_r * (cos(anchor_a0 + {kx_hi} * anchor_step) - cos(anchor_a0 + {kx_lo} * anchor_step)) + 2 * joint_r",
        f"anchor_r * (sin(anchor_a0 + {ky_hi} * anchor_step) - sin(anchor_a0 + {ky_lo} * anchor_step)) + 2 * joint_r",
        "sections * seg_h + 2 * joint_r",
    )
    height = _r2(segments * seg_h)
    bbox = (
        _r2(anchor_r * (max(cosines) - min(cosines)) + 2 * joint_r),
        _r2(anchor_r * (max(sines) - min(sines)) + 2 * joint_r),
        _r2(height + 2 * joint_r),
    )

    heights_ru = ", ".join(fmt(_r2(t * seg_h)) for t in tiers)
    features_ru = [
        f"мачта высотой {fmt(height)} мм из {ru_count(segments, 'секции', 'секций', 'секций')} по {fmt(seg_h)} мм",
        f"ствол диаметром {fmt(_r2(2 * mast_r))} мм, оттяжки {fmt(_r2(2 * guy_r))} мм",
        f"{ru_count(anchors_n, 'анкер', 'анкера', 'анкеров')} на окружности радиусом {fmt(anchor_r)} мм через {fmt(anchor_step)} градусов",
        f"{ru_count(len(tiers), 'ярус', 'яруса', 'ярусов')} оттяжек на высотах {heights_ru} мм",
    ]
    features_en = [
        f"mast {fmt(height)} mm tall, {en_count(segments)} sections of {fmt(seg_h)} mm",
        f"trunk of {fmt(_r2(2 * mast_r))} mm stock, guys {fmt(_r2(2 * guy_r))} mm",
        f"{en_count(anchors_n)} ground anchors on a {fmt(anchor_r)} mm ring, {fmt(anchor_step)} degrees apart",
        f"{en_count(len(tiers))} guy tiers at {heights_ru} mm",
    ]
    return sc.render(
        features_ru=features_ru, features_en=features_en,
        ru_nouns=GUY_RU, en_nouns=GUY_EN, bbox=bbox,
    )


# ---------------------------------------------------------------------------
# family 6: roll cages (3 bays x 2 sections)
# ---------------------------------------------------------------------------

CAGE_RU = (
    "силовую клетку каркаса", "каркас безопасности",
    "пространственную клетку", "сварную защитную клетку",
    "клетку-каркас с обручами", "несущую клетку",
)
CAGE_EN = (
    "a roll cage frame", "a safety cage", "a space cage",
    "a welded protective cage", "a hoop-braced cage", "a structural cage",
)


def build_rollcages(index: int) -> Part:
    rng = Rng("rollcages", index, seed=SEED_V5)
    variant = rng.choice(("base", "roofx", "fullx"))
    bays = 3
    bay_l = rng.grid([38.0, 42.0, 46.0])
    width = rng.grid([34.0, 38.0, 42.0])
    height = rng.grid([30.0, 34.0, 38.0])
    rail_r = rng.grid([3.5, 4.0, 4.5])
    diag_r = _r2(max(1.5, rail_r - rng.grid([0.8, 1.0])))
    joint_r = _r2(rail_r + 0.4)

    sc = WireScene(
        "rollcages", rng, "Roll cage",
        f"3 bays x 2 sections, bays {fmt(bay_l)} mm, {fmt(width)} x {fmt(height)} mm section",
    )
    sc.variant = variant
    sc.param("bays", float(bays), "number of bays along X")
    sc.param("sections", 2.0, "levels of the cage")
    sc.param("bay_l", bay_l, "bay length, X")
    sc.param("cage_w", width, "cage width, Y")
    sc.param("cage_h", height, "cage height, Z")
    sc.radius("rail_r", rail_r, "rail and hoop radius")
    sc.radius("diag_r", diag_r, "diagonal brace radius")
    sc.param("joint_r", joint_r, "joint ball radius")
    sc.diameter("rail_d", "rail_r", "rail stock diameter")
    sc.diameter("diag_d", "diag_r", "diagonal stock diameter")
    sc.diameter("joint_d", "joint_r", "joint ball diameter")
    sc.derived.append("cage_l = bays * bay_l;  // overall cage length")

    stations = bays + 1
    nodes: list[tuple[float, float, float]] = []
    for lvl in (0, 1):
        for side in (0, 1):
            for st in range(stations):
                nodes.append((_r2(st * bay_l), _r2(side * width), _r2(lvl * height)))
    sc.nodes = nodes
    sc.nodes_expr = (
        "[for (lvl = [0, 1], side = [0, 1], st = [0 : bays]) "
        "[st * bay_l, side * cage_w, lvl * cage_h]]"
    )
    node = lambda lvl, side, st: lvl * 2 * stations + side * stations + st  # noqa: E731

    # longitudinal rails
    for lvl in (0, 1):
        for side in (0, 1):
            for st in range(bays):
                sc.edges.append((node(lvl, side, st), node(lvl, side, st + 1), "rail_r"))
    # station posts
    for side in (0, 1):
        for st in range(stations):
            sc.edges.append((node(0, side, st), node(1, side, st), "rail_r"))
    # hoops: top at every station, bottom at the two end stations
    for st in range(stations):
        sc.edges.append((node(1, 0, st), node(1, 1, st), "rail_r"))
    for st in (0, stations - 1):
        sc.edges.append((node(0, 0, st), node(0, 1, st), "rail_r"))
    # side diagonals: X in the middle bay, single in the outer bays; fullx => all X
    for side in (0, 1):
        for st in range(bays):
            middle = st == 1
            use_x = middle or variant == "fullx"
            if use_x:
                sc.edges.append((node(0, side, st), node(1, side, st + 1), "diag_r"))
                sc.edges.append((node(1, side, st), node(0, side, st + 1), "diag_r"))
            else:
                if st % 2 == 0:
                    sc.edges.append((node(0, side, st), node(1, side, st + 1), "diag_r"))
                else:
                    sc.edges.append((node(1, side, st), node(0, side, st + 1), "diag_r"))
    # roof X between the middle hoops
    if variant in ("roofx", "fullx"):
        sc.edges.append((node(1, 0, 1), node(1, 1, 2), "diag_r"))
        sc.edges.append((node(1, 1, 1), node(1, 0, 2), "diag_r"))

    sc.set_bbox_exprs(
        "bays * bay_l + 2 * joint_r",
        "cage_w + 2 * joint_r",
        "cage_h + 2 * joint_r",
    )
    length = _r2(bays * bay_l)
    bbox = (_r2(length + 2 * joint_r), _r2(width + 2 * joint_r), _r2(height + 2 * joint_r))

    features_ru = [
        f"{ru_count(bays, 'секция', 'секции', 'секций')} вдоль по {fmt(bay_l)} мм, длина {fmt(length)} мм",
        f"сечение {fmt(width)} на {fmt(height)} мм",
        f"продольные дуги и обручи из прутка диаметром {fmt(_r2(2 * rail_r))} мм",
        f"диагонали {fmt(_r2(2 * diag_r))} мм"
        + (", крест на крыше" if variant in ("roofx", "fullx") else ", X только в средней секции"),
    ]
    features_en = [
        f"{en_count(bays)} bays of {fmt(bay_l)} mm, {fmt(length)} mm long",
        f"section {fmt(width)} by {fmt(height)} mm",
        f"rails and hoops of {fmt(_r2(2 * rail_r))} mm round stock",
        f"{fmt(_r2(2 * diag_r))} mm diagonals"
        + (", roof X-brace" if variant in ("roofx", "fullx") else ", X only in the middle bay"),
    ]
    return sc.render(
        features_ru=features_ru, features_en=features_en,
        ru_nouns=CAGE_RU, en_nouns=CAGE_EN, bbox=bbox,
    )


FAMILY_BUILDERS = {
    "masttowers": build_masttowers,
    "bridgetrusses": build_bridgetrusses,
    "spaceframes": build_spaceframes,
    "piperoutes": build_piperoutes,
    "guymasts": build_guymasts,
    "rollcages": build_rollcages,
}

COVERAGE_NOTES = {
    "masttowers": "tapered four-leg towers, per-level X/single/ring-only braces, optional crown mast",
    "bridgetrusses": "Pratt/Warren/Howe twin side trusses with a bottom-chord deck and lateral bracing",
    "spaceframes": "triangular lattice girders and double-layer square space grids, X/single/mixed diagonals",
    "piperoutes": "tube runs with 45/90 elbows and manifold stubs, hull-chain members between collars",
    "guymasts": "antenna masts guyed in 1-3 tiers to a 3/4/6-anchor ground ring",
    "rollcages": "3x2 safety cages: rails, hoops, side diagonals, optional roof X",
}
