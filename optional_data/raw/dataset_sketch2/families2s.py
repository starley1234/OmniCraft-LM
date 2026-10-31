"""sketch2 families - the S2 block of ``docs/archive/DATASET_REQUEST_5.md``.

* ``voidplates``   - plates whose profile carries windows / pockets: the
  primary polygon is extruded, the void polygons are subtracted afterwards
  (through windows and blind pockets);
* ``arcprofiles``  - composite outlines built from straight chords and arcs
  sampled at 1-degree steps: pointed sectors, lens plates, crowned bars,
  arc-notched bars (arc geometry is derived, every angle <= 1 deg per point);
* ``steppedbars``  - bars of two thicknesses: one primary outline extruded to
  the thick size, step regions cut back with void rings;
* ``groovedshafts``- revolved bushings / shafts with rectangular grooves,
  flanges and a 45-degree thread relief in the profile;
* ``gearsectors``  - toothed sectors on an arc (root/hub arcs at 3-degree
  steps - a 1-degree step would blow the 64-point profile cap; documented);
* ``vguides``      - V-groove, V-rib, dovetail and double-V guide rails.

All profiles: 6-64 points, CCW, simple, coordinates >= 0.
"""

from __future__ import annotations

import math

from tools.dataset_gen2.common import Rng, fmt
from tools.dataset_gen2.prompts import en_count, ru_count
from tools.dataset_sketch2.core2s import (
    Sketch2Part,
    arc_points,
    finish_sketch2,
)
from tools.dataset_v5.kit import SEED_V5


def _r3(value: float) -> float:
    return round(value + 0.0, 3)


def _rect(x0: float, y0: float, x1: float, y1: float) -> list[tuple[float, float]]:
    return [(_r3(x0), _r3(y0)), (_r3(x1), _r3(y0)), (_r3(x1), _r3(y1)), (_r3(x0), _r3(y1))]


def _chamfered_plate(length: float, width: float, c: float) -> list[tuple[float, float]]:
    """Rectangle with all four corners chamfered - 8 points, CCW."""
    return [
        (_r3(c), 0.0), (_r3(length - c), 0.0),
        (_r3(length), _r3(c)), (_r3(length), _r3(width - c)),
        (_r3(length - c), _r3(width)), (_r3(c), _r3(width)),
        (0.0, _r3(width - c)), (0.0, _r3(c)),
    ]


def _dedupe(points: list[tuple[float, float]]) -> list[tuple[float, float]]:
    cleaned: list[tuple[float, float]] = []
    for point in points:
        if not cleaned or math.dist(cleaned[-1], point) > 1e-6:
            cleaned.append(point)
    if len(cleaned) > 1 and math.dist(cleaned[0], cleaned[-1]) < 1e-6:
        cleaned.pop()
    return cleaned


# ---------------------------------------------------------------------------
# family 1: plates with windows / pockets
# ---------------------------------------------------------------------------

VOID_RU = (
    "пластину с окнами", "плиту с вырезами", "пластину с карманами",
    "панель с технологическими окнами", "пластину с облегчающими вырезами",
    "крышку с окнами под разъёмы",
)
VOID_EN = (
    "a plate with windows", "a panel with cut-outs", "a plate with pockets",
    "a lightening plate", "a cover with openings", "a windowed mounting plate",
)


def build_voidplates(index: int) -> Sketch2Part:
    rng = Rng("voidplates", index, seed=SEED_V5)
    variant = rng.choice(("through", "through", "pockets", "mixed"))
    plate_l = rng.grid([70.0, 80.0, 90.0, 100.0, 110.0, 120.0])
    plate_w = rng.grid([45.0, 50.0, 60.0, 70.0, 80.0])
    plate_t = rng.grid([5.0, 6.0, 8.0, 10.0])
    margin = rng.grid([8.0, 10.0, 12.0])
    layout = rng.choice(("row", "row", "grid", "one"))

    voids: list[list[tuple[float, float]]] = []
    depths: list[float] = []
    comments: list[str] = []
    params: list[tuple[str, float, str]] = [
        ("plate_l", plate_l, "plate length, X"),
        ("plate_w", plate_w, "plate width, Y"),
        ("plate_t", plate_t, "plate thickness, Z"),
        ("edge_margin", margin, "wall from the plate edge to any window"),
    ]
    feats_ru: list[str] = []
    feats_en: list[str] = []

    def draw_depth() -> float:
        if variant == "through":
            return plate_t
        if variant == "pockets":
            return round(rng.uniform(1.5, plate_t - 1.5), 1)
        return plate_t if rng.chance(0.5) else round(rng.uniform(1.5, plate_t - 1.5), 1)

    if layout == "one":
        w_l = round(plate_l - 2 * margin - rng.uniform(6, 16), 1)
        w_w = round(plate_w - 2 * margin - rng.uniform(6, 12), 1)
        if w_l < 8 or w_w < 6:
            raise ValueError("window degenerate for this plate")
        cx, cy = plate_l / 2, plate_w / 2
        depth = draw_depth()
        voids.append(_rect(cx - w_l / 2, cy - w_w / 2, cx + w_l / 2, cy + w_w / 2))
        depths.append(depth)
        comments.append("large central window")
        params += [("win1_l", w_l, "window length"), ("win1_w", w_w, "window width")]
        feats_ru.append(f"одно большое окно {fmt(w_l)} на {fmt(w_w)} мм по центру")
        feats_en.append(f"one large central window, {fmt(w_l)} by {fmt(w_w)} mm")
    elif layout == "row":
        count = rng.integer(2, 3)
        w_l = rng.grid([12.0, 15.0, 18.0, 22.0])
        w_w = rng.grid([10.0, 12.0, 14.0])
        pitch = round((plate_l - 2 * margin) / count, 1)
        if pitch < w_l + 3 or w_w > plate_w - 2 * margin - 2:
            raise ValueError("row does not fit the plate with the declared margin")
        cy = plate_w / 2
        for i in range(count):
            cx = margin + pitch * (i + 0.5)
            voids.append(_rect(cx - w_l / 2, cy - w_w / 2, cx + w_l / 2, cy + w_w / 2))
            depths.append(draw_depth())
            comments.append(f"window {i + 1} of the row")
        params += [
            ("windows", float(count), "number of windows in the row"),
            ("win_l", w_l, "window length"),
            ("win_w", w_w, "window width"),
            ("win_pitch", pitch, "window pitch along X"),
        ]
        feats_ru.append(
            f"{ru_count(count, 'окно', 'окна', 'окон')} {fmt(w_l)} на {fmt(w_w)} мм в ряд с шагом {fmt(pitch)} мм"
        )
        feats_en.append(
            f"{en_count(count)} windows of {fmt(w_l)} by {fmt(w_w)} mm in a row, {fmt(pitch)} mm pitch"
        )
    else:  # grid 2x2
        w_l = rng.grid([12.0, 15.0, 18.0])
        w_w = rng.grid([10.0, 12.0, 14.0])
        px = round((plate_l - 2 * margin) / 2, 1)
        py = round((plate_w - 2 * margin) / 2, 1)
        if px < w_l + 3 or py < w_w + 3:
            raise ValueError("grid does not fit the plate with the declared margin")
        for gx in range(2):
            for gy in range(2):
                cx = margin + px * (gx + 0.5)
                cy = margin + py * (gy + 0.5)
                voids.append(_rect(cx - w_l / 2, cy - w_w / 2, cx + w_l / 2, cy + w_w / 2))
                depths.append(draw_depth())
                comments.append(f"pocket at grid node {gx},{gy}")
        params += [
            ("win_l", w_l, "pocket length"),
            ("win_w", w_w, "pocket width"),
            ("pitch_x", px, "grid pitch along X"),
            ("pitch_y", py, "grid pitch along Y"),
        ]
        feats_ru.append(f"сетка карманов 2 на 2, каждый {fmt(w_l)} на {fmt(w_w)} мм, шаг {fmt(px)} на {fmt(py)} мм")
        feats_en.append(f"a 2 by 2 pocket grid, each {fmt(w_l)} by {fmt(w_w)} mm, pitch {fmt(px)} x {fmt(py)} mm")

    for i, depth in enumerate(depths, start=1):
        params.append((f"depth_{i}", depth, f"depth of void {i} (full thickness = through)"))

    corner_c = rng.grid([2.0, 2.5, 3.0, 4.0, 5.0])
    params.append(("corner_c", corner_c, "corner chamfer of the plate"))
    profile = _chamfered_plate(plate_l, plate_w, corner_c)
    bbox = (_r3(plate_l), _r3(plate_w), _r3(plate_t))
    feats_ru.append(f"углы с фаской {fmt(corner_c)} мм")
    feats_en.append(f"corners chamfered by {fmt(corner_c)} mm")
    through = sum(1 for d in depths if abs(d - plate_t) < 1e-9)
    feats_ru.append(f"толщина {fmt(plate_t)} мм, стенка до кромки {fmt(margin)} мм")
    feats_en.append(f"{fmt(plate_t)} mm thick, {fmt(margin)} mm wall to the plate edge")
    if through:
        feats_ru.append(f"{ru_count(through, 'сквозное окно', 'сквозных окна', 'сквозных окон')}")
        feats_en.append(f"{en_count(through)} of the openings go right through")
    return finish_sketch2(
        rng,
        family="voidplates",
        variant=variant,
        title="Windowed plate",
        summary=f"{len(voids)} voids, {fmt(plate_l)} x {fmt(plate_w)} x {fmt(plate_t)} mm",
        params=params,
        derived=[],
        profile=profile,
        extrude={"kind": "linear", "height_mm": plate_t},
        bbox=bbox,
        voids=voids,
        void_depths=depths,
        void_comments=comments,
        ru_nouns=VOID_RU,
        en_nouns=VOID_EN,
        features_ru=feats_ru,
        features_en=feats_en,
    )


# ---------------------------------------------------------------------------
# family 2: composite profiles with arcs (1-degree steps)
# ---------------------------------------------------------------------------

ARC_RU = (
    "пластину с дуговым контуром", "секторную пластину", "деталь с арочным краем",
    "пластину-сегмент", "направляющую с дугой", "фасонную пластину с радиусами",
)
ARC_EN = (
    "a plate with an arc edge", "a sector plate", "an arc-crowned bar",
    "a circular-segment plate", "a radius profile plate", "a contour plate with arcs",
)


def build_arcprofiles(index: int) -> Sketch2Part:
    rng = Rng("arcprofiles", index, seed=SEED_V5)
    variant = rng.choice(("sector", "lens", "crown", "notch"))
    plate_t = rng.grid([5.0, 6.0, 8.0, 10.0])

    if variant == "sector":
        # pointed sector: outer arc at 1-degree steps + the apex point
        angle = rng.grid([30.0, 36.0, 40.0, 45.0, 50.0])
        radius = rng.grid([60.0, 70.0, 80.0, 90.0])
        arc = arc_points((0.0, 0.0), radius, -angle / 2, angle / 2, 1.0)
        profile = _dedupe(arc + [(0.0, 0.0)])
        min_x = min(x for x, _ in profile)
        min_y = min(y for _, y in profile)
        profile = [(_r3(x - min_x), _r3(y - min_y)) for x, y in profile]
        params = [
            ("sector_angle", angle, "sector angle, degrees"),
            ("sector_r", radius, "outer radius"),
            ("arc_step", 1.0, "sampling step of the arc, degrees"),
            ("plate_t", plate_t, "plate thickness, Z"),
        ]
        derived = [
            "bbox_x = 2 * sector_r * sin(sector_angle / 2);  // chord of the sector",
            "bbox_y = sector_r;  // depth of the sector (apex to arc)",
        ]
        bbox = (
            _r3(max(x for x, _ in profile)),
            _r3(max(y for _, y in profile)),
            plate_t,
        )
        feats_ru = [
            f"круговой сектор {fmt(angle)} градусов радиусом {fmt(radius)} мм",
            f"дуга аппроксимирована точками с шагом 1 градус",
            f"вершина сектора острая, без скругления",
        ]
        feats_en = [
            f"circular sector of {fmt(angle)} degrees, {fmt(radius)} mm radius",
            f"the arc is sampled at 1 degree steps",
            f"sharp apex, no root rounding",
        ]
    elif variant == "lens":
        arc_angle = rng.grid([24.0, 28.0, 30.0])
        chord = rng.grid([80.0, 90.0, 100.0, 110.0])
        radius = round(chord / (2 * math.sin(math.radians(arc_angle / 2))), 2)
        sagitta = round(radius * (1 - math.cos(math.radians(arc_angle / 2))), 2)
        # upper arc bulges up from the endpoint line; lower arc mirrors it:
        # both circles have radius `radius`, centres `2*(radius - sagitta)` apart
        upper = arc_points((chord / 2, 0.0), radius, 90 - arc_angle / 2, 90 + arc_angle / 2, 1.0)
        lower_centre_y = 2 * (radius - sagitta)
        # the upper arc travels right-to-left, so the lower one must travel
        # left-to-right for the ring to close without crossing itself
        lower = arc_points(
            (chord / 2, lower_centre_y), radius, 270 - arc_angle / 2, 270 + arc_angle / 2, 1.0
        )
        # snap both arc joins to the exact shared endpoints: at 3 decimals
        # float noise would otherwise leave a 2 um sliver at each join
        upper[0] = (chord, radius - sagitta)
        upper[-1] = (0.0, radius - sagitta)
        lower[0] = (0.0, radius - sagitta)
        lower[-1] = (chord, radius - sagitta)
        profile = _dedupe([(x, y) for x, y in upper] + [(x, y) for x, y in lower])
        min_y = min(y for _, y in profile)
        profile = [(_r3(x), _r3(y - min_y)) for x, y in profile]
        params = [
            ("lens_chord", chord, "chord length of the lens, X"),
            ("arc_r", radius, "radius of both arcs"),
            ("arc_angle", arc_angle, "angle of each arc, degrees"),
            ("sagitta", sagitta, "bulge of each arc (half the lens height)"),
            ("arc_step", 1.0, "sampling step of the arcs, degrees"),
            ("plate_t", plate_t, "plate thickness, Z"),
        ]
        derived = ["bbox_y = 2 * sagitta;  // full lens height"]
        bbox = (_r3(chord), _r3(2 * sagitta), plate_t)
        feats_ru = [
            f"линза хордой {fmt(chord)} мм из двух дуг радиусом {fmt(radius)} мм",
            f"каждая дуга по {fmt(arc_angle)} градусов, стрелка {fmt(sagitta)} мм, шаг точек 1 градус",
        ]
        feats_en = [
            f"lens with a {fmt(chord)} mm chord, both arcs of {fmt(radius)} mm radius",
            f"each arc spans {fmt(arc_angle)} degrees, sagitta {fmt(sagitta)} mm, 1 degree steps",
        ]
    elif variant == "crown":
        bar_l = rng.grid([90.0, 100.0, 110.0, 120.0])
        bar_w = rng.grid([30.0, 36.0, 40.0])
        arc_angle = rng.grid([16.0, 20.0, 24.0])
        radius = round(bar_l / (2 * math.sin(math.radians(arc_angle / 2))), 2)
        rise = round(radius * (1 - math.cos(math.radians(arc_angle / 2))), 2)
        crown = arc_points((bar_l / 2, 0.0), radius, 90 - arc_angle / 2, 90 + arc_angle / 2, 1.0)
        crown_low = min(y for _, y in crown)
        # the arc runs from x = bar_l down to x = 0 (cos(90 - a) = +sin(a));
        # the bottom corners follow in the same travel direction to keep CCW
        profile = [(_r3(x), _r3(y - crown_low + bar_w)) for x, y in crown]
        profile += [(0.0, 0.0), (_r3(bar_l), 0.0)]
        profile = _dedupe(profile)
        params = [
            ("bar_l", bar_l, "bar length, X"),
            ("bar_w", bar_w, "bar height at the ends, Y"),
            ("arc_r", radius, "radius of the crown arc"),
            ("arc_angle", arc_angle, "crown arc angle, degrees"),
            ("crown_rise", rise, "rise of the crown over the ends"),
            ("arc_step", 1.0, "sampling step of the crown arc, degrees"),
            ("plate_t", plate_t, "plate thickness, Z"),
        ]
        derived = ["bbox_y = bar_w + crown_rise;  // full height with the crown"]
        bbox = (_r3(bar_l), _r3(bar_w + rise), plate_t)
        feats_ru = [
            f"планка {fmt(bar_l)} на {fmt(bar_w)} мм с выпуклой дугой по верхней кромке",
            f"радиус дуги {fmt(radius)} мм, стрелка подъёма {fmt(rise)} мм, шаг 1 градус",
        ]
        feats_en = [
            f"bar {fmt(bar_l)} by {fmt(bar_w)} mm, top edge crowned by an arc",
            f"arc radius {fmt(radius)} mm, rise {fmt(rise)} mm, 1 degree steps",
        ]
    else:  # notch: the arc passes exactly through both top corners
        bar_l = rng.grid([90.0, 100.0, 110.0])
        bar_w = rng.grid([36.0, 40.0, 46.0])
        notch_depth = rng.grid([8.0, 10.0, 12.0])
        # circle through (0, bar_w), (bar_l, bar_w), (bar_l/2, bar_w - notch_depth)
        radius = round((bar_l * bar_l / 4 + notch_depth ** 2) / (2 * notch_depth), 2)
        half_angle = math.degrees(math.asin(min(1.0, bar_l / (2 * radius))))
        centre_y = bar_w + radius - notch_depth
        notch = arc_points((bar_l / 2, centre_y), radius, 270 + half_angle, 270 - half_angle, 1.0)
        profile = [(_r3(0.0), _r3(0.0)), (_r3(bar_l), _r3(0.0)), (_r3(bar_l), _r3(bar_w))]
        profile += [(_r3(x), _r3(y)) for x, y in notch]
        profile += [(_r3(0.0), _r3(bar_w))]
        profile = _dedupe(profile)
        arc_angle = _r3(2 * half_angle)
        params = [
            ("bar_l", bar_l, "bar length, X"),
            ("bar_w", bar_w, "bar width, Y"),
            ("notch_depth", notch_depth, "depth of the arc notch at mid-span"),
            ("arc_r", radius, "radius of the notch arc"),
            ("arc_angle", arc_angle, "notch arc angle, degrees"),
            ("arc_step", 1.0, "sampling step of the notch arc, degrees"),
            ("plate_t", plate_t, "plate thickness, Z"),
        ]
        derived = []
        bbox = (_r3(bar_l), _r3(bar_w), plate_t)
        feats_ru = [
            f"планка {fmt(bar_l)} на {fmt(bar_w)} мм с дуговой выемкой глубиной {fmt(notch_depth)} мм",
            f"радиус выемки {fmt(radius)} мм, дуга {fmt(arc_angle)} градусов с шагом 1 градус",
        ]
        feats_en = [
            f"bar {fmt(bar_l)} by {fmt(bar_w)} mm with an arc notch {fmt(notch_depth)} mm deep",
            f"notch radius {fmt(radius)} mm, arc {fmt(arc_angle)} degrees at 1 degree steps",
        ]

    if len(profile) > 64:
        raise ValueError(f"profile has {len(profile)} points, over the 64 cap")
    if len(profile) < 6:
        raise ValueError(f"profile has {len(profile)} points, under the 6 floor")
    return finish_sketch2(
        rng,
        family="arcprofiles",
        variant=variant,
        title="Arc profile plate",
        summary=f"{variant}, {len(profile)} points",
        params=params,
        derived=derived,
        profile=profile,
        extrude={"kind": "linear", "height_mm": plate_t},
        bbox=bbox,
        ru_nouns=ARC_RU,
        en_nouns=ARC_EN,
        features_ru=feats_ru,
        features_en=feats_en,
    )


# ---------------------------------------------------------------------------
# family 3: stepped bars (two thicknesses in one profile)
# ---------------------------------------------------------------------------

STEP_RU = (
    "ступенчатую планку", "планку переменной толщины", "пластину со ступенью",
    "планку с утоньшением", "двухтолщинную планку", "планку с полкой",
)
STEP_EN = (
    "a stepped bar", "a bar of two thicknesses", "a plate with a step",
    "a locally thinned bar", "a two-thickness strip", "a lipped bar",
)


def build_steppedbars(index: int) -> Sketch2Part:
    rng = Rng("steppedbars", index, seed=SEED_V5)
    variant = rng.choice(("endstep", "centerstep", "sidestep", "twostep"))
    bar_l = rng.grid([90.0, 100.0, 110.0, 120.0, 130.0])
    bar_w = rng.grid([34.0, 40.0, 46.0, 52.0])
    thick_t = rng.grid([8.0, 10.0, 12.0])
    thin_t = round(rng.uniform(2.5, thick_t - 2.5), 1)
    if thick_t - thin_t < 1.5:
        raise ValueError("step too shallow")

    corner_c = rng.grid([2.0, 2.5, 3.0])
    profile = _chamfered_plate(bar_l, bar_w, corner_c)
    voids: list[list[tuple[float, float]]] = []
    depths: list[float] = []
    comments: list[str] = []
    params: list[tuple[str, float, str]] = [
        ("bar_l", bar_l, "bar length, X"),
        ("bar_w", bar_w, "bar width, Y"),
        ("plate_t", thick_t, "thickness of the thick zone, Z"),
        ("thin_t", thin_t, "thickness of the thin zone"),
        ("corner_c", corner_c, "corner chamfer of the bar"),
    ]
    cut = round(thick_t - thin_t, 1)
    params.append(("step_cut", cut, "material removed from the thin zone"))

    if variant == "endstep":
        x_cut = round(rng.uniform(0.35, 0.65) * bar_l, 1)
        voids.append(_rect(x_cut, -1, bar_l + 1, bar_w + 1))
        depths.append(cut)
        comments.append("thin zone beyond the step")
        params.append(("step_x", x_cut, "step position from the left end"))
        feats_ru = [f"ступень на {fmt(x_cut)} мм от левого края, дальше толщина {fmt(thin_t)} мм"]
        feats_en = [f"step {fmt(x_cut)} mm from the left end, {fmt(thin_t)} mm beyond it"]
    elif variant == "centerstep":
        x_a = round(rng.uniform(0.2, 0.35) * bar_l, 1)
        x_b = round(rng.uniform(0.65, 0.8) * bar_l, 1)
        voids.append(_rect(-1, -1, x_a, bar_w + 1))
        voids.append(_rect(x_b, -1, bar_l + 1, bar_w + 1))
        depths += [cut, cut]
        comments += ["thin left end", "thin right end"]
        params.append(("thick_from", x_a, "start of the thick middle zone"))
        params.append(("thick_to", x_b, "end of the thick middle zone"))
        feats_ru = [f"толстое среднее поле от {fmt(x_a)} до {fmt(x_b)} мм, концы по {fmt(thin_t)} мм"]
        feats_en = [f"thick middle from {fmt(x_a)} to {fmt(x_b)} mm, both ends {fmt(thin_t)} mm"]
    elif variant == "sidestep":
        y_cut = round(rng.uniform(0.5, 0.65) * bar_w, 1)
        voids.append(_rect(-1, y_cut, bar_l + 1, bar_w + 1))
        depths.append(cut)
        comments.append("ledge cut along one edge")
        params.append(("ledge_y", y_cut, "start of the ledge from the front edge"))
        feats_ru = [f"продольная полка: {fmt(y_cut)} мм полной толщины, далее {fmt(thin_t)} мм"]
        feats_en = [f"long ledge: {fmt(y_cut)} mm full thickness, then {fmt(thin_t)} mm"]
    else:  # twostep - a staircase along the length (non-overlapping cutters)
        x_a = round(rng.uniform(0.28, 0.4) * bar_l, 1)
        x_b = round(rng.uniform(0.62, 0.74) * bar_l, 1)
        mid_t = round((thick_t + thin_t) / 2, 1)
        voids.append(_rect(x_a, -1, x_b, bar_w + 1))
        voids.append(_rect(x_b, -1, bar_l + 1, bar_w + 1))
        depths += [round(thick_t - mid_t, 1), cut]
        comments += ["first stair", "second stair"]
        params.append(("stair1_x", x_a, "position of the first stair"))
        params.append(("stair2_x", x_b, "position of the second stair"))
        params.append(("mid_t", mid_t, "thickness of the middle zone"))
        feats_ru = [
            f"две ступени: от {fmt(x_a)} мм толщина {fmt(mid_t)} мм, от {fmt(x_b)} мм — {fmt(thin_t)} мм",
        ]
        feats_en = [
            f"two stairs: {fmt(mid_t)} mm from {fmt(x_a)} mm, {fmt(thin_t)} mm from {fmt(x_b)} mm",
        ]

    for i, depth in enumerate(depths, start=1):
        params.append((f"depth_{i}", depth, f"depth of cut {i} from the top face"))
    feats_ru.append(f"полная толщина {fmt(thick_t)} мм, тонкая зона {fmt(thin_t)} мм")
    feats_en.append(f"full thickness {fmt(thick_t)} mm, thin zone {fmt(thin_t)} mm")
    feats_ru.append(f"углы с фаской {fmt(corner_c)} мм")
    feats_en.append(f"corners chamfered by {fmt(corner_c)} mm")
    bbox = (_r3(bar_l), _r3(bar_w), _r3(thick_t))
    return finish_sketch2(
        rng,
        family="steppedbars",
        variant=variant,
        title="Stepped bar",
        summary=f"{variant}, {fmt(bar_l)} x {fmt(bar_w)} x {fmt(thick_t)}/{fmt(thin_t)} mm",
        params=params,
        derived=[],
        profile=profile,
        extrude={"kind": "linear", "height_mm": thick_t},
        bbox=bbox,
        voids=voids,
        void_depths=depths,
        void_comments=comments,
        ru_nouns=STEP_RU,
        en_nouns=STEP_EN,
        features_ru=feats_ru,
        features_en=feats_en,
    )


# ---------------------------------------------------------------------------
# family 4: revolved bodies with grooves / flange / thread relief
# ---------------------------------------------------------------------------

GROOVE_RU = (
    "втулку с канавками", "вал с проточками", "ступицу с буртиком",
    "втулку с резьбовой проточкой", "фланцевую втулку", "дистанционную втулку с канавками",
)
GROOVE_EN = (
    "a grooved bushing", "a shaft with relief grooves", "a flanged hub",
    "a bushing with a thread relief", "a collar with grooves", "a spacer sleeve with grooves",
)


def build_groovedshafts(index: int) -> Sketch2Part:
    rng = Rng("groovedshafts", index, seed=SEED_V5)
    variant = rng.choice(("plain_grooves", "flanged", "thread_relief", "stepped"))
    bore_r = rng.grid([3.0, 4.0, 5.0, 6.0, 8.0])
    wall = rng.grid([2.5, 3.0, 4.0, 5.0])
    total_h = rng.grid([24.0, 30.0, 36.0, 44.0])
    groove_w = rng.grid([2.5, 3.0, 4.0])
    groove_d = round(min(rng.uniform(1.0, max(1.2, wall - 1.3)), wall - 1.2), 1)
    relief = rng.grid([1.2, 1.5, 2.0])

    outer_r = round(bore_r + wall, 2)
    if variant == "flanged":
        flange_r = round(outer_r + rng.grid([5.0, 6.0, 8.0]), 2)
        flange_h = rng.grid([4.0, 5.0, 6.0])
    else:
        flange_r, flange_h = outer_r, 0.0
    if variant == "flanged" and total_h - flange_h < 12.0:
        raise ValueError("flange eats the whole body")

    # walk the closed revolve profile (x = radius, y = axial), CCW, x >= 0.5
    profile: list[tuple[float, float]] = [(_r3(bore_r), _r3(0.0)), (_r3(outer_r), _r3(0.0))]
    y = 0.0
    if variant == "flanged":
        profile += [
            (_r3(flange_r), _r3(0.0)),
            (_r3(flange_r), _r3(flange_h)),
            (_r3(outer_r), _r3(flange_h)),
        ]
        y = flange_h
    body_h = total_h - y
    n_grooves = 1 if variant in ("thread_relief", "flanged") else rng.integer(1, 2)
    seg = body_h / (n_grooves + 1)
    if seg < groove_w + 4.0:
        raise ValueError("grooves do not fit the body")
    for g in range(n_grooves):
        y0 = y + seg * (g + 1) - groove_w / 2
        profile += [
            (_r3(outer_r), _r3(y0)),
            (_r3(outer_r - groove_d), _r3(y0)),
            (_r3(outer_r - groove_d), _r3(y0 + groove_w)),
            (_r3(outer_r), _r3(y0 + groove_w)),
        ]
    profile.append((_r3(outer_r), _r3(total_h)))
    if variant == "thread_relief":
        profile.append((_r3(bore_r + relief), _r3(total_h)))
        profile.append((_r3(bore_r), _r3(total_h - relief)))
    else:
        profile.append((_r3(bore_r), _r3(total_h)))
    profile = _dedupe(profile)

    params: list[tuple[str, float, str]] = [
        ("bore_r", bore_r, "bore radius"),
        ("outer_r", outer_r, "outer radius of the body"),
        ("total_h", total_h, "overall height, Z"),
        ("wall", wall, "radial wall thickness"),
        ("groove_w", groove_w, "groove width"),
        ("groove_d", groove_d, "groove depth"),
        ("grooves", float(n_grooves), "number of outer grooves"),
    ]
    if variant == "flanged":
        params += [
            ("flange_r", flange_r, "flange radius"),
            ("flange_h", flange_h, "flange height"),
        ]
    if variant == "thread_relief":
        params.append(("relief", relief, "thread relief leg at the bore mouth"))
        params.append(("relief_angle", 45.0, "thread relief chamfer angle, degrees"))
    derived = [
        "bbox_x = 2 * " + ("flange_r" if variant == "flanged" else "outer_r") + ";  // full diameter",
        "bore_d = 2 * bore_r;  // bore diameter",
        "body_d = 2 * outer_r;  // body diameter",
        "revolve_angle = 360;  // full turn around the Z axis",
    ]
    if variant == "flanged":
        derived.insert(3, "flange_d = 2 * flange_r;  // flange diameter")
    max_r = flange_r if variant == "flanged" else outer_r
    bbox = (_r3(2 * max_r), _r3(2 * max_r), _r3(total_h))
    feats_ru = [
        f"втулка диаметром {fmt(_r3(2 * outer_r))} мм, высота {fmt(total_h)} мм, отверстие {fmt(_r3(2 * bore_r))} мм",
        f"{ru_count(n_grooves, 'круговая канавка', 'круговые канавки', 'круговых канавок')} шириной {fmt(groove_w)} мм, глубиной {fmt(groove_d)} мм",
        f"радиальная стенка {fmt(wall)} мм",
    ]
    feats_en = [
        f"bushing {fmt(_r3(2 * outer_r))} mm across, {fmt(total_h)} mm tall, bore {fmt(_r3(2 * bore_r))} mm",
        f"{en_count(n_grooves)} circumferential grooves, {fmt(groove_w)} mm wide, {fmt(groove_d)} mm deep",
        f"{fmt(wall)} mm radial wall",
    ]
    if variant == "flanged":
        feats_ru.append(f"буртик диаметром {fmt(_r3(2 * flange_r))} мм, высотой {fmt(flange_h)} мм")
        feats_en.append(f"flange {fmt(_r3(2 * flange_r))} mm across, {fmt(flange_h)} mm tall")
    if variant == "thread_relief":
        feats_ru.append(f"фаска-проточка {fmt(relief)} мм под 45 градусов у зева отверстия")
        feats_en.append(f"{fmt(relief)} mm 45-degree thread relief at the bore mouth")
    if len(profile) > 64:
        raise ValueError("profile over the point cap")
    return finish_sketch2(
        rng,
        family="groovedshafts",
        variant=variant,
        title="Grooved revolve",
        summary=f"{variant}, bore R{fmt(bore_r)}",
        params=params,
        derived=derived,
        profile=profile,
        extrude={"kind": "rotate"},
        bbox=bbox,
        ru_nouns=GROOVE_RU,
        en_nouns=GROOVE_EN,
        features_ru=feats_ru,
        features_en=feats_en,
    )


# ---------------------------------------------------------------------------
# family 5: gear sectors on an arc
# ---------------------------------------------------------------------------

GEAR_RU = (
    "зубчатый сектор", "секторную шестерню", "зубчатый сегмент",
    "поворотный зубчатый сектор", "сектор зацепления",
)
GEAR_EN = (
    "a gear sector", "a toothed sector", "a rack segment on an arc",
    "a rotary gear segment", "a sector gear blank",
)


def build_gearsectors(index: int) -> Sketch2Part:
    rng = Rng("gearsectors", index, seed=SEED_V5)
    angle = rng.grid([36.0, 42.0, 48.0, 54.0, 60.0])
    root_r = rng.grid([50.0, 60.0, 70.0, 80.0])
    tooth_h = rng.grid([5.0, 6.0, 7.0, 8.0])
    teeth = rng.integer(2, 4)
    hub_r = rng.grid([10.0, 12.0, 14.0])
    plate_t = rng.grid([5.0, 6.0, 8.0, 10.0])
    tip_r = round(root_r + tooth_h, 2)
    arc_step = 3.0  # 1-degree root+hub arcs would exceed the 64-point cap

    half = angle / 2
    tooth_span = angle * 0.6 / teeth
    gap_span = (angle - tooth_span * teeth) / (teeth + 1)
    profile: list[tuple[float, float]] = []

    def polar(radius: float, deg: float) -> tuple[float, float]:
        rad = math.radians(deg)
        return (_r3(radius * math.cos(rad)), _r3(radius * math.sin(rad)))

    cursor = -half
    for t in range(teeth):
        tooth_start = -half + gap_span * (t + 1) + tooth_span * t
        root_arc = arc_points((0.0, 0.0), root_r, cursor, tooth_start, arc_step)
        profile += root_arc if not profile else root_arc[:-1]
        a0 = tooth_start
        a1 = tooth_start + tooth_span
        am0 = a0 + tooth_span * 0.25
        am1 = a1 - tooth_span * 0.25
        profile += [polar(root_r, a0), polar(tip_r, am0), polar(tip_r, am1), polar(root_r, a1)]
        cursor = a1
    profile += arc_points((0.0, 0.0), root_r, cursor, half, arc_step)
    profile += arc_points((0.0, 0.0), hub_r, half, -half, arc_step)
    profile = _dedupe(profile)
    if len(profile) > 64:
        raise ValueError(f"{len(profile)} points, over the cap")
    min_x = min(x for x, _ in profile)
    min_y = min(y for _, y in profile)
    profile = [(_r3(x - min_x), _r3(y - min_y)) for x, y in profile]

    params = [
        ("sector_angle", angle, "sector angle, degrees"),
        ("root_r", root_r, "root circle radius"),
        ("tooth_h", tooth_h, "tooth height over the root circle"),
        ("teeth", float(teeth), "number of teeth on the sector"),
        ("hub_r", hub_r, "hub bore radius"),
        ("plate_t", plate_t, "sector thickness, Z"),
        ("arc_step", arc_step, "sampling step of the root/hub arcs, degrees"),
    ]
    derived = ["tip_r = root_r + tooth_h;  // tip circle radius"]
    bbox = (
        _r3(max(x for x, _ in profile)),
        _r3(max(y for _, y in profile)),
        plate_t,
    )
    feats_ru = [
        f"сектор {fmt(angle)} градусов с {ru_count(teeth, 'зубом', 'зубьями', 'зубьями')}",
        f"радиус корня {fmt(root_r)} мм, высота зуба {fmt(tooth_h)} мм",
        f"ступица с отверстием радиусом {fmt(hub_r)} мм",
        f"дуги корня и ступицы с шагом {fmt(arc_step)} градуса",
    ]
    feats_en = [
        f"{fmt(angle)} degree sector carrying {en_count(teeth)} teeth",
        f"root radius {fmt(root_r)} mm, tooth height {fmt(tooth_h)} mm",
        f"hub bore of {fmt(hub_r)} mm radius",
        f"root and hub arcs sampled at {fmt(arc_step)} degrees",
    ]
    return finish_sketch2(
        rng,
        family="gearsectors",
        variant="sector",
        title="Gear sector",
        summary=f"{teeth} teeth on {fmt(angle)} degrees",
        params=params,
        derived=derived,
        profile=profile,
        extrude={"kind": "linear", "height_mm": plate_t},
        bbox=bbox,
        ru_nouns=GEAR_RU,
        en_nouns=GEAR_EN,
        features_ru=feats_ru,
        features_en=feats_en,
    )


# ---------------------------------------------------------------------------
# family 6: V guides and dovetails
# ---------------------------------------------------------------------------

GUIDE_RU = (
    "V-образную направляющую", "направляющую с клиновым пазом",
    "рельс с V-пазом", "направляющую типа ласточкин хвост",
    "полозок с V-ребром", "направляющую планку",
)
GUIDE_EN = (
    "a V-groove guide rail", "a dovetail guide", "a V-way rail",
    "a prism guide bar", "a V-rib slide", "a machine way strip",
)


def build_vguides(index: int) -> Sketch2Part:
    rng = Rng("vguides", index, seed=SEED_V5)
    variant = rng.choice(("vway", "vrib", "dovetail", "doublev"))
    rail_w = rng.grid([40.0, 46.0, 52.0, 60.0])
    base_t = rng.grid([8.0, 10.0, 12.0])
    v_depth = rng.grid([6.0, 8.0, 10.0])
    v_half_w = rng.grid([7.0, 8.0, 10.0, 12.0])
    if variant in ("vway", "doublev") and v_depth > base_t - 2.0:
        raise ValueError("V groove breaks the rail floor")
    if 2 * v_half_w > rail_w - 8:
        raise ValueError("V feature too wide for the rail")
    rail_l = rng.grid([30.0, 40.0, 50.0, 60.0, 80.0])

    cx = rail_w / 2
    params: list[tuple[str, float, str]] = [
        ("rail_w", rail_w, "rail width, X"),
        ("base_t", base_t, "base plate thickness"),
        ("v_depth", v_depth, "V feature depth / height"),
        ("v_half_w", v_half_w, "half width of the V at the base face"),
        ("plate_t", rail_l, "rail length, Z (the extrusion height)"),
    ]
    if variant == "vway":
        profile = [
            (_r3(0.0), _r3(0.0)), (_r3(rail_w), _r3(0.0)),
            (_r3(rail_w), _r3(base_t)),
            (_r3(cx + v_half_w), _r3(base_t)),
            (_r3(cx), _r3(base_t - v_depth)),
            (_r3(cx - v_half_w), _r3(base_t)),
            (_r3(0.0), _r3(base_t)),
        ]
        derived = []
        feats_ru = [f"V-паз глубиной {fmt(v_depth)} мм, половина ширины {fmt(v_half_w)} мм"]
        feats_en = [f"V groove {fmt(v_depth)} mm deep, {fmt(v_half_w)} mm half width"]
    elif variant == "vrib":
        profile = [
            (_r3(0.0), _r3(0.0)), (_r3(rail_w), _r3(0.0)),
            (_r3(rail_w), _r3(base_t)),
            (_r3(cx + v_half_w), _r3(base_t)),
            (_r3(cx), _r3(base_t + v_depth)),
            (_r3(cx - v_half_w), _r3(base_t)),
            (_r3(0.0), _r3(base_t)),
        ]
        derived = []
        feats_ru = [f"V-ребро высотой {fmt(v_depth)} мм, половина основания {fmt(v_half_w)} мм"]
        feats_en = [f"V rib {fmt(v_depth)} mm tall, {fmt(v_half_w)} mm half base"]
    elif variant == "dovetail":
        narrow = round(v_half_w * rng.uniform(0.5, 0.7), 1)
        profile = [
            (_r3(0.0), _r3(0.0)), (_r3(rail_w), _r3(0.0)),
            (_r3(rail_w), _r3(base_t)),
            (_r3(cx + v_half_w), _r3(base_t)),
            (_r3(cx + narrow), _r3(base_t + v_depth)),
            (_r3(cx - narrow), _r3(base_t + v_depth)),
            (_r3(cx - v_half_w), _r3(base_t)),
            (_r3(0.0), _r3(base_t)),
        ]
        params.append(("top_half_w", narrow, "half width at the dovetail top"))
        derived = [
            "dovetail_base = 2 * v_half_w;  // dovetail width at the base",
            "dovetail_top = 2 * top_half_w;  // dovetail width at the top",
        ]
        feats_ru = [
            f"ласточкин хвост высотой {fmt(v_depth)} мм, низ {fmt(_r3(2 * v_half_w))} мм, верх {fmt(_r3(2 * narrow))} мм",
        ]
        feats_en = [
            f"dovetail {fmt(v_depth)} mm tall, {fmt(_r3(2 * v_half_w))} mm at the base, {fmt(_r3(2 * narrow))} mm at the top",
        ]
    else:  # doublev - two V grooves
        off = round(rail_w / 4, 1)
        if v_half_w / 2 * 2 + 2 > off:
            raise ValueError("double V grooves collide")
        profile = [(_r3(0.0), _r3(0.0)), (_r3(rail_w), _r3(0.0)), (_r3(rail_w), _r3(base_t))]
        for centre_x in (cx + off, cx - off):
            profile += [
                (_r3(centre_x + v_half_w / 2), _r3(base_t)),
                (_r3(centre_x), _r3(base_t - v_depth)),
                (_r3(centre_x - v_half_w / 2), _r3(base_t)),
            ]
        profile += [(_r3(0.0), _r3(base_t))]
        params.append(("groove_off", off, "offset of each groove from the centreline"))
        derived = [
            "centre_x = rail_w / 2;  // rail centreline",
            "groove_a = centre_x - groove_off;  // axis of the first groove",
            "groove_b = centre_x + groove_off;  // axis of the second groove",
        ]
        feats_ru = [
            f"два V-паза глубиной {fmt(v_depth)} мм на осях {fmt(_r3(cx - off))} и {fmt(_r3(cx + off))} мм",
        ]
        feats_en = [
            f"two V grooves {fmt(v_depth)} mm deep, centred at {fmt(_r3(cx - off))} and {fmt(_r3(cx + off))} mm",
        ]

    profile = _dedupe(profile)
    feats_ru.append(f"рельс шириной {fmt(rail_w)} мм, длиной {fmt(rail_l)} мм")
    feats_en.append(f"rail {fmt(rail_w)} mm wide, {fmt(rail_l)} mm long")
    bbox = (_r3(rail_w), _r3(max(y for _, y in profile)), _r3(rail_l))
    return finish_sketch2(
        rng,
        family="vguides",
        variant=variant,
        title="V guide rail",
        summary=f"{variant}, {fmt(rail_w)} mm wide",
        params=params,
        derived=derived,
        profile=profile,
        extrude={"kind": "linear", "height_mm": rail_l},
        bbox=bbox,
        ru_nouns=GUIDE_RU,
        en_nouns=GUIDE_EN,
        features_ru=feats_ru,
        features_en=feats_en,
    )


FAMILY_BUILDERS = {
    "voidplates": build_voidplates,
    "arcprofiles": build_arcprofiles,
    "steppedbars": build_steppedbars,
    "groovedshafts": build_groovedshafts,
    "gearsectors": build_gearsectors,
    "vguides": build_vguides,
}

COVERAGE_NOTES = {
    "voidplates": "plates with through windows and blind pockets subtracted after the extrusion",
    "arcprofiles": "pointed sectors, lens plates, crowned and arc-notched bars; arcs at 1-degree steps",
    "steppedbars": "one profile, two thicknesses: step regions cut back with void rings",
    "groovedshafts": "revolved bushings with grooves, flange and 45-degree thread relief",
    "gearsectors": "toothed sectors on an arc; root/hub arcs at 3-degree steps (64-point cap)",
    "vguides": "V-groove, V-rib, dovetail and double-V guide rail profiles",
}
