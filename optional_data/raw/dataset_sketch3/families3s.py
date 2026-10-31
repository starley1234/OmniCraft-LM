"""sketch3 families - second wave of the sketch canvas (all-new archetypes).

* ``racks``          - gear racks: a toothed strip, trapezoid teeth on one edge;
* ``structsections`` - structural sections: I-beam, C-channel, T-bar, angle;
* ``hexplates``      - regular polygon plates (hex/oct) with a centre bore and
  a bolt-circle of octagonal windows;
* ``keyways``        - shaft cross-sections: 24-gon circle with a rectangular
  keyway notch, extruded into a prism;
* ``frameplates``    - rectangular frames: chamfered outline, a window void
  and bolt / slot voids at the corners.

All profiles: 6-64 points, CCW, simple, coordinates >= 0. Rendered through
sketch2's ``core2s`` (one extrusion, void rings via difference), audited by
sketch2's audit + the place1 law on both prompts.
"""

from __future__ import annotations

import math

from tools.dataset_gen2.common import Rng, fmt
from tools.dataset_sketch1.geom1 import bbox2
from tools.dataset_gen2.prompts import en_count, ru_count
from tools.dataset_sketch2.core2s import Sketch2Part, finish_sketch2
from tools.dataset_v5.kit import SEED_V5


def _r3(value: float) -> float:
    return round(value + 0.0, 3)


def _octagon(cx: float, cy: float, radius: float) -> list[tuple[float, float]]:
    """Regular octagon ring, CCW, vertices at 22.5 + 45k degrees."""
    return [
        (_r3(cx + radius * math.cos(math.radians(22.5 + 45.0 * k))),
         _r3(cy + radius * math.sin(math.radians(22.5 + 45.0 * k))))
        for k in range(8)
    ]


# ---------------------------------------------------------------------------
# 1. gear racks
# ---------------------------------------------------------------------------

RACK_RU = (
    "зубчатую рейку", "реечную планку с трапециевидными зубьями",
    "рейку зубчатой передачи", "направляющую рейку с зубьями",
)
RACK_EN = (
    "a gear rack", "a rack bar with trapezoid teeth",
    "a rack-and-pinion rack", "a toothed slide bar",
)


def build_racks(index: int) -> Sketch2Part:
    rng = Rng("racks3", index, seed=SEED_V5)
    variant = rng.choice(("fine", "coarse", "tall"))
    teeth = int(rng.grid([6.0, 8.0, 10.0, 12.0]))
    pitch = rng.grid([6.0, 8.0]) if variant == "fine" else rng.grid([10.0, 12.0])
    base_h = rng.grid([10.0, 12.0, 14.0])
    tooth_h = rng.grid([3.0, 4.0]) if variant != "tall" else rng.grid([5.0, 6.0])
    plate_t = rng.grid([8.0, 10.0, 12.0, 15.0])
    root_w = round(pitch * 0.7, 2)
    tip_w = round(pitch * 0.35, 2)
    rack_l = round(teeth * pitch, 2)

    profile: list[tuple[float, float]] = [(0.0, 0.0), (_r3(rack_l), 0.0), (_r3(rack_l), _r3(base_h))]
    for i in range(teeth - 1, -1, -1):
        cell = i * pitch
        profile += [
            (_r3(cell + (pitch + root_w) / 2), _r3(base_h)),
            (_r3(cell + (pitch + tip_w) / 2), _r3(base_h + tooth_h)),
            (_r3(cell + (pitch - tip_w) / 2), _r3(base_h + tooth_h)),
            (_r3(cell + (pitch - root_w) / 2), _r3(base_h)),
        ]
    profile.append((0.0, _r3(base_h)))

    return finish_sketch2(
        rng,
        family="racks",
        variant=variant,
        title="Gear rack",
        summary=f"{teeth} teeth, pitch {pitch:g} mm",
        params=[
            ("teeth", float(teeth), "number of teeth"),
            ("pitch", pitch, "tooth pitch, X"),
            ("root_w", root_w, "tooth width at the root"),
            ("tip_w", tip_w, "tooth width at the tip"),
            ("base_h", base_h, "rack body height, Y"),
            ("tooth_h", tooth_h, "tooth height above the body"),
            ("plate_t", plate_t, "rack width, Z (extrusion height)"),
        ],
        derived=[
            "rack_l = teeth * pitch;  // overall length",
            "total_h = base_h + tooth_h;  // overall height",
        ],
        profile=profile,
        extrude={"kind": "linear", "height_mm": plate_t},
        bbox=(rack_l, round(base_h + tooth_h, 3), plate_t),
        ru_nouns=RACK_RU,
        en_nouns=RACK_EN,
        features_ru=[
            f"{ru_count(teeth, 'зуб', 'зуба', 'зубьев')} с шагом {fmt(pitch)} мм, длина рейки {fmt(rack_l)} мм",
            f"высота зуба {fmt(tooth_h)} мм, ширина по основанию {fmt(root_w)} мм, по вершине {fmt(tip_w)} мм",
            f"корпус высотой {fmt(base_h)} мм, ширина рейки {fmt(plate_t)} мм",
        ],
        features_en=[
            f"{en_count(teeth)} teeth on a {fmt(pitch)} mm pitch, {fmt(rack_l)} mm long",
            f"teeth {fmt(tooth_h)} mm tall, {fmt(root_w)} mm at the root, {fmt(tip_w)} mm at the tip",
            f"body {fmt(base_h)} mm high, rack {fmt(plate_t)} mm wide",
        ],
    )


# ---------------------------------------------------------------------------
# 2. structural sections
# ---------------------------------------------------------------------------

SECTION_RU = (
    "отрезок фасонного профиля", "заготовку конструкционного профиля",
    "сегмент балочного профиля", "кусок профильного проката",
)
SECTION_EN = (
    "a structural section cut", "a profile bar segment",
    "a beam section piece", "a length of structural profile",
)


def build_structsections(index: int) -> Sketch2Part:
    rng = Rng("structsections3", index, seed=SEED_V5)
    variant = rng.choice(("ibeam", "channel", "tee", "angle"))
    width = rng.grid([40.0, 50.0, 60.0, 80.0])
    height = rng.grid([40.0, 50.0, 60.0, 80.0])
    flange_t = rng.grid([5.0, 6.0, 8.0])
    web_t = rng.grid([4.0, 5.0, 6.0])
    bar_l = rng.grid([40.0, 50.0, 60.0, 80.0])

    if variant == "ibeam":
        cw0 = round(width / 2 - web_t / 2, 3)
        cw1 = round(width / 2 + web_t / 2, 3)
        profile = [
            (0.0, 0.0), (_r3(width), 0.0), (_r3(width), _r3(flange_t)),
            (cw1, _r3(flange_t)), (cw1, _r3(height - flange_t)), (_r3(width), _r3(height - flange_t)),
            (_r3(width), _r3(height)), (0.0, _r3(height)),
            (0.0, _r3(height - flange_t)), (cw0, _r3(height - flange_t)),
            (cw0, _r3(flange_t)), (0.0, _r3(flange_t)),
        ]
        params = [
            ("sec_w", width, "section width, X"),
            ("sec_h", height, "section height, Y"),
            ("flange_t", flange_t, "flange thickness"),
            ("web_t", web_t, "web thickness"),
            ("plate_t", bar_l, "cut length, Z (extrusion height)"),
        ]
        feats_ru = [f"двутавр {fmt(width)} x {fmt(height)} мм, полка {fmt(flange_t)} мм, стенка {fmt(web_t)} мм",
                    f"длина заготовки {fmt(bar_l)} мм"]
        feats_en = [f"I-beam {fmt(width)} x {fmt(height)} mm, {fmt(flange_t)} mm flanges, {fmt(web_t)} mm web",
                    f"cut {fmt(bar_l)} mm long"]
    elif variant == "channel":
        profile = [
            (0.0, 0.0), (_r3(width), 0.0), (_r3(width), _r3(flange_t)),
            (_r3(web_t), _r3(flange_t)), (_r3(web_t), _r3(height - flange_t)),
            (_r3(width), _r3(height - flange_t)), (_r3(width), _r3(height)), (0.0, _r3(height)),
        ]
        params = [
            ("sec_w", width, "channel width, X"),
            ("sec_h", height, "channel height, Y"),
            ("flange_t", flange_t, "flange thickness"),
            ("web_t", web_t, "web thickness"),
            ("plate_t", bar_l, "cut length, Z (extrusion height)"),
        ]
        feats_ru = [f"швеллер {fmt(width)} x {fmt(height)} мм, полка {fmt(flange_t)} мм, стенка {fmt(web_t)} мм",
                    f"длина заготовки {fmt(bar_l)} мм"]
        feats_en = [f"C-channel {fmt(width)} x {fmt(height)} mm, {fmt(flange_t)} mm flanges, {fmt(web_t)} mm web",
                    f"cut {fmt(bar_l)} mm long"]
    elif variant == "tee":
        cw0 = round(width / 2 - web_t / 2, 3)
        cw1 = round(width / 2 + web_t / 2, 3)
        profile = [
            (cw0, 0.0), (cw1, 0.0), (cw1, _r3(height - flange_t)), (_r3(width), _r3(height - flange_t)),
            (_r3(width), _r3(height)), (0.0, _r3(height)),
            (0.0, _r3(height - flange_t)), (cw0, _r3(height - flange_t)),
        ]
        params = [
            ("sec_w", width, "tee width, X"),
            ("sec_h", height, "tee height, Y"),
            ("flange_t", flange_t, "top flange thickness"),
            ("web_t", web_t, "web thickness"),
            ("plate_t", bar_l, "cut length, Z (extrusion height)"),
        ]
        feats_ru = [f"тавр {fmt(width)} x {fmt(height)} мм, полка {fmt(flange_t)} мм, стенка {fmt(web_t)} мм",
                    f"длина заготовки {fmt(bar_l)} мм"]
        feats_en = [f"T-bar {fmt(width)} x {fmt(height)} mm, {fmt(flange_t)} mm flange, {fmt(web_t)} mm web",
                    f"cut {fmt(bar_l)} mm long"]
    else:  # angle
        profile = [
            (0.0, 0.0), (_r3(width), 0.0), (_r3(width), _r3(flange_t)),
            (_r3(flange_t), _r3(flange_t)), (_r3(flange_t), _r3(height)), (0.0, _r3(height)),
        ]
        params = [
            ("sec_w", width, "leg width, X"),
            ("sec_h", height, "leg height, Y"),
            ("flange_t", flange_t, "leg thickness"),
            ("plate_t", bar_l, "cut length, Z (extrusion height)"),
        ]
        feats_ru = [f"уголок {fmt(width)} x {fmt(height)} мм с полкой {fmt(flange_t)} мм",
                    f"длина заготовки {fmt(bar_l)} мм", "полки равной толщины по всей длине"]
        feats_en = [f"equal-thickness angle {fmt(width)} x {fmt(height)} mm, legs {fmt(flange_t)} mm thick",
                    f"cut {fmt(bar_l)} mm long", "both legs keep the thickness along the cut"]

    return finish_sketch2(
        rng,
        family="structsections",
        variant=variant,
        title="Structural section",
        summary=f"{variant} {width:g} x {height:g} mm",
        params=params,
        derived=[],
        profile=profile,
        extrude={"kind": "linear", "height_mm": bar_l},
        bbox=(width, height, bar_l),
        ru_nouns=SECTION_RU,
        en_nouns=SECTION_EN,
        features_ru=feats_ru,
        features_en=feats_en,
    )


# ---------------------------------------------------------------------------
# 3. polygon plates with a bolt circle
# ---------------------------------------------------------------------------

POLY_RU = (
    "многоугольную пластину с болтовой окружностью", "фланец-многогранник",
    "шестигранную монтажную пластину", "полигональную крышку с отверстиями",
)
POLY_EN = (
    "a polygon plate with a bolt circle", "a polygonal flange plate",
    "a hexagonal mounting plate", "a polygon cover with bolt windows",
)


def build_hexplates(index: int) -> Sketch2Part:
    rng = Rng("hexplates3", index, seed=SEED_V5)
    sides = int(rng.choice((6.0, 8.0)))
    variant = "hex" if sides == 6 else "octagon"
    plate_r = rng.grid([25.0, 30.0, 35.0, 40.0])
    rot = rng.choice((0.0, 90.0 / sides))  # vertex-up or flat-up
    bore_r = rng.grid([6.0, 8.0, 10.0])
    bolts = int(rng.choice((3.0, 4.0, 6.0)))
    bolt_r = rng.grid([2.5, 3.0, 4.0])
    plate_t = rng.grid([5.0, 6.0, 8.0, 10.0])

    apothem = plate_r * math.cos(math.pi / sides)
    max_bolt_r = bolt_r + 1.2
    min_bolt_r = bore_r + bolt_r + 1.5
    if max_bolt_r + 0.0 > apothem - 1.2 or min_bolt_r > apothem - 1.2 - bolt_r:
        pass  # resolved by the ring choice below
    ring_r = None
    for candidate in [round(apothem - 1.2 - bolt_r, 2), round((bore_r + apothem) / 2, 2)]:
        if candidate - bolt_r >= bore_r + 1.5 and candidate + bolt_r <= apothem - 1.2:
            ring_r = candidate
            break
    if ring_r is None:
        raise ValueError("no bolt ring fits between the bore and the polygon edge")

    raw = [
        (plate_r * math.cos(math.radians(rot + 360.0 * k / sides)),
         plate_r * math.sin(math.radians(rot + 360.0 * k / sides)))
        for k in range(sides)
    ]
    min_x = min(x for x, _ in raw)
    min_y = min(y for _, y in raw)
    profile = [(_r3(x - min_x), _r3(y - min_y)) for x, y in raw]
    centre_x = round(-min_x, 3)
    centre_y = round(-min_y, 3)
    plate_box = bbox2(profile)
    plate_w_x = round(plate_box[2] - plate_box[0], 3)
    plate_w_y = round(plate_box[3] - plate_box[1], 3)
    voids = [_octagon(centre_x, centre_y, bore_r)]
    comments = ["centre bore"]
    for k in range(bolts):
        angle = math.radians(rot + 360.0 * k / bolts)
        cx = centre_x + ring_r * math.cos(angle)
        cy = centre_y + ring_r * math.sin(angle)
        voids.append(_octagon(cx, cy, bolt_r))
        comments.append(f"bolt window {k + 1}")

    return finish_sketch2(
        rng,
        family="hexplates",
        variant=variant,
        title="Polygon plate",
        summary=f"{sides}-gon R{plate_r:g}, {bolts} bolt windows",
        params=[
            ("sides", float(sides), "number of polygon sides"),
            ("plate_r", plate_r, "circumscribed radius of the polygon"),
            ("bore_r", bore_r, "centre bore radius"),
            ("bolts", float(bolts), "number of bolt windows"),
            ("ring_r", ring_r, "bolt-circle radius"),
            ("bolt_r", bolt_r, "bolt window radius"),
            ("plate_t", plate_t, "plate thickness, Z (extrusion height)"),
        ],
        derived=[
            "plate_d = 2 * plate_r;  // circumscribed diameter",
            "bore_d = 2 * bore_r;  // centre bore diameter",
            "bolt_d = 2 * bolt_r;  // bolt window diameter",
            "ring_d = 2 * ring_r;  // bolt-circle diameter",
        ],
        profile=profile,
        extrude={"kind": "linear", "height_mm": plate_t},
        bbox=(plate_w_x, plate_w_y, plate_t),
        voids=voids,
        void_depths=[plate_t] * len(voids),
        void_comments=comments,
        ru_nouns=POLY_RU,
        en_nouns=POLY_EN,
        features_ru=[
            f"{ru_count(sides, 'грань', 'грани', 'граней')}, описанный диаметр {fmt(2 * plate_r)} мм",
            f"центральное отверстие d{fmt(2 * bore_r)} мм",
            f"{ru_count(bolts, 'окно', 'окна', 'окон')} под болты d{fmt(2 * bolt_r)} мм на окружности d{fmt(2 * ring_r)} мм",
            f"толщина {fmt(plate_t)} мм, окна сквозные",
        ],
        features_en=[
            f"{en_count(sides)} sides, {fmt(2 * plate_r)} mm across the corners",
            f"a d{fmt(2 * bore_r)} mm centre bore",
            f"{en_count(bolts)} d{fmt(2 * bolt_r)} mm bolt windows on a d{fmt(2 * ring_r)} mm circle",
            f"{fmt(plate_t)} mm thick, windows cut through",
        ],
    )


# ---------------------------------------------------------------------------
# 4. shaft cross-sections with a keyway
# ---------------------------------------------------------------------------

KEYWAY_RU = (
    "призму вала со шпоночным пазом", "заготовку вала со шпоночным пазом",
    "сечение вала со шпонкой", "вал-заготовку с пазом под шпонку",
)
KEYWAY_EN = (
    "a shaft prism with a keyway", "a keyway shaft blank",
    "a shaft section with a key slot", "a keyway bar",
)


def build_keyways(index: int) -> Sketch2Part:
    rng = Rng("keyways3", index, seed=SEED_V5)
    variant = rng.choice(("shallow", "deep", "wide"))
    shaft_r = rng.grid([12.0, 14.0, 16.0, 18.0, 20.0])
    key_w = rng.grid([4.0, 5.0]) if variant != "wide" else rng.grid([6.0, 8.0])
    key_d = rng.grid([2.5, 3.0]) if variant != "deep" else rng.grid([3.5, 4.0])
    shaft_l = rng.grid([40.0, 50.0, 60.0, 80.0])
    if key_w / 2 + 1.5 > shaft_r or key_d + 1.5 > shaft_r:
        raise ValueError("keyway breaks the shaft section")

    y0 = math.sqrt(shaft_r * shaft_r - (key_w / 2) ** 2)
    a0 = math.degrees(math.asin((key_w / 2) / shaft_r))  # half wedge taken by the keyway
    # 24-gon sampled every 15 degrees, CCW the long way from the left corner
    profile: list[tuple[float, float]] = []
    start = 90.0 + a0
    end = 450.0 - a0
    angle = start
    while angle <= end + 1e-9:
        snapped = round(angle / 15.0) * 15.0
        if snapped < angle - 1e-9:
            snapped += 15.0
        if snapped > end + 1e-9:
            break
        radians = math.radians(snapped)
        profile.append((_r3(shaft_r + shaft_r * math.cos(radians)),
                        _r3(shaft_r + shaft_r * math.sin(radians))))
        angle = snapped + 15.0
    profile += [
        (_r3(shaft_r + key_w / 2), _r3(shaft_r + y0)),
        (_r3(shaft_r + key_w / 2), _r3(shaft_r + y0 - key_d)),
        (_r3(shaft_r - key_w / 2), _r3(shaft_r + y0 - key_d)),
        (_r3(shaft_r - key_w / 2), _r3(shaft_r + y0)),
    ]
    # dedupe (arc sample may coincide with a keyway corner)
    cleaned: list[tuple[float, float]] = []
    for point in profile:
        if not cleaned or math.dist(cleaned[-1], point) > 1e-6:
            cleaned.append(point)
    profile = cleaned

    return finish_sketch2(
        rng,
        family="keyways",
        variant=variant,
        title="Keyway shaft",
        summary=f"d{2 * shaft_r:g} shaft, key {key_w:g} x {key_d:g} mm",
        params=[
            ("shaft_r", shaft_r, "shaft radius"),
            ("key_w", key_w, "keyway width"),
            ("key_d", key_d, "keyway depth below the surface line"),
            ("plate_t", shaft_l, "shaft length, Z (extrusion height)"),
        ],
        derived=[
            "shaft_d = 2 * shaft_r;  // shaft diameter",
            "circle_step = 15;  // polygon sampling step, degrees",
        ],
        profile=profile,
        extrude={"kind": "linear", "height_mm": shaft_l},
        bbox=(round(bbox2(profile)[2] - bbox2(profile)[0], 3),
              round(bbox2(profile)[3] - bbox2(profile)[1], 3), shaft_l),
        ru_nouns=KEYWAY_RU,
        en_nouns=KEYWAY_EN,
        features_ru=[
            f"вал d{fmt(2 * shaft_r)} мм длиной {fmt(shaft_l)} мм",
            f"шпоночный паз шириной {fmt(key_w)} мм и глубиной {fmt(key_d)} мм вдоль всей длины",
            "сечение округлое, с огранкой под многоугольник",
        ],
        features_en=[
            f"shaft d{fmt(2 * shaft_r)} mm, {fmt(shaft_l)} mm long",
            f"keyway {fmt(key_w)} mm wide, {fmt(key_d)} mm deep, running the full length",
            "round section with a faceted polygon outline",
        ],
    )


# ---------------------------------------------------------------------------
# 5. frame plates
# ---------------------------------------------------------------------------

FRAME_RU = (
    "рамную пластину с окном", "пластину-рамку", "монтажную рамку с окном",
    "панель-рамку с крепежом по углам",
)
FRAME_EN = (
    "a frame plate with a window", "a frame panel",
    "a mounting frame with a window", "a windowed frame plate",
)


def build_frameplates(index: int) -> Sketch2Part:
    rng = Rng("frameplates3", index, seed=SEED_V5)
    variant = rng.choice(("window4bolt", "window4bolt", "windowslots"))
    plate_l = rng.grid([80.0, 90.0, 100.0, 110.0, 120.0])
    plate_w = rng.grid([60.0, 70.0, 80.0])
    plate_t = rng.grid([6.0, 8.0, 10.0])
    corner_c = rng.grid([3.0, 4.0, 5.0])
    frame_bar = rng.grid([12.0, 14.0, 16.0])
    win_l = round(plate_l - 2 * frame_bar, 2)
    win_w = round(plate_w - 2 * frame_bar, 2)
    if win_l < 20.0 or win_w < 20.0:
        raise ValueError("window too small for the frame bar")

    profile = [
        (_r3(corner_c), 0.0), (_r3(plate_l - corner_c), 0.0),
        (_r3(plate_l), _r3(corner_c)), (_r3(plate_l), _r3(plate_w - corner_c)),
        (_r3(plate_l - corner_c), _r3(plate_w)), (_r3(corner_c), _r3(plate_w)),
        (0.0, _r3(plate_w - corner_c)), (0.0, _r3(corner_c)),
    ]
    x0 = frame_bar
    y0 = frame_bar
    voids = [[(_r3(x0), _r3(y0)), (_r3(x0 + win_l), _r3(y0)),
              (_r3(x0 + win_l), _r3(y0 + win_w)), (_r3(x0), _r3(y0 + win_w))]]
    comments = ["the window"]

    if variant == "window4bolt":
        bolt_r = rng.grid([3.0, 3.5, 4.0])
        inset = round(frame_bar / 2, 2)
        if inset - bolt_r < 1.2:
            raise ValueError("bolt window breaks the frame bar")
        for cx, cy in ((inset, inset), (plate_l - inset, inset),
                       (inset, plate_w - inset), (plate_l - inset, plate_w - inset)):
            voids.append(_octagon(cx, cy, bolt_r))
            comments.append("corner bolt window")
        feats_ru = [f"{ru_count(4, 'отверстие', 'отверстия', 'отверстий')} d{fmt(2 * bolt_r)} мм по углам, на {fmt(inset)} мм от краёв"]
        feats_en = [f"{en_count(4)} d{fmt(2 * bolt_r)} mm corner holes, {fmt(inset)} mm in from the edges"]
        extra_params = [("bolt_r", bolt_r, "corner bolt window radius"),
                        ("bolt_inset", inset, "bolt centre inset from the edges")]
        extra_derived = ["bolt_d = 2 * bolt_r;  // corner hole diameter"]
    else:  # windowslots
        slot_l = round(frame_bar - 4.0, 2)
        slot_w = rng.grid([4.0, 5.0])
        if slot_l < 4.0:
            raise ValueError("frame bar too thin for slots")
        cx0 = round(plate_l / 2, 2)
        for cy in (round(frame_bar / 2, 2), round(plate_w - frame_bar / 2, 2)):
            voids.append([(_r3(cx0 - slot_l / 2), _r3(cy - slot_w / 2)),
                          (_r3(cx0 + slot_l / 2), _r3(cy - slot_w / 2)),
                          (_r3(cx0 + slot_l / 2), _r3(cy + slot_w / 2)),
                          (_r3(cx0 - slot_l / 2), _r3(cy + slot_w / 2))])
            comments.append("adjustment slot")
        feats_ru = [f"два регулировочных паза {fmt(slot_l)} x {fmt(slot_w)} мм на серединых верхней и нижней перемычках"]
        feats_en = [f"two {fmt(slot_l)} x {fmt(slot_w)} mm adjustment slots mid top and bottom rails"]
        extra_params = [("slot_l", slot_l, "adjustment slot length"),
                        ("slot_w", slot_w, "adjustment slot width")]
        extra_derived = []

    return finish_sketch2(
        rng,
        family="frameplates",
        variant=variant,
        title="Frame plate",
        summary=f"{plate_l:g} x {plate_w:g} frame, {frame_bar:g} mm rails",
        params=[
            ("plate_l", plate_l, "plate length, X"),
            ("plate_w", plate_w, "plate width, Y"),
            ("plate_t", plate_t, "plate thickness, Z (extrusion height)"),
            ("corner_c", corner_c, "corner chamfer"),
            ("frame_bar", frame_bar, "frame rail width"),
        ] + extra_params,
        derived=[
            "win_l = plate_l - 2 * frame_bar;  // window length",
            "win_w = plate_w - 2 * frame_bar;  // window width",
        ] + extra_derived,
        profile=profile,
        extrude={"kind": "linear", "height_mm": plate_t},
        bbox=(plate_l, plate_w, plate_t),
        voids=voids,
        void_depths=[plate_t] * len(voids),
        void_comments=comments,
        ru_nouns=FRAME_RU,
        en_nouns=FRAME_EN,
        features_ru=[
            f"контур {fmt(plate_l)} x {fmt(plate_w)} мм с фаской {fmt(corner_c)} мм по углам",
            f"окно {fmt(win_l)} x {fmt(win_w)} мм, перемычка {fmt(frame_bar)} мм",
            feats_ru[0],
            f"толщина {fmt(plate_t)} мм, всё вырезано насквозь",
        ],
        features_en=[
            f"outline {fmt(plate_l)} x {fmt(plate_w)} mm, corners chamfered by {fmt(corner_c)} mm",
            f"window {fmt(win_l)} x {fmt(win_w)} mm, rails {fmt(frame_bar)} mm wide",
            feats_en[0],
            f"{fmt(plate_t)} mm thick, everything cut through",
        ],
    )


FAMILY_BUILDERS = {
    "racks": build_racks,
    "structsections": build_structsections,
    "hexplates": build_hexplates,
    "keyways": build_keyways,
    "frameplates": build_frameplates,
}
