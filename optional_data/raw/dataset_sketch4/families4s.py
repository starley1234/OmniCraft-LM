"""sketch4 families - third wave of the sketch canvas (delivery no. 7).

* ``camplates``     - cam plates: smooth single/double lobes or an eccentric
  disc, centre bore plus an optional lightening ring;
* ``spacerplates``  - thin flange spacers: round / rectangular / obround
  outlines with a bore and a bolt pattern;
* ``starwheels``    - star and ratchet wheels, optional lightening holes;
* ``spinparts``     - revolved lathe parts (V-groove pulley, flanged bushing,
  handwheel) - the rotate half of the canvas;
* ``bracketplates`` - L bracket with a fillet, T plate with a slot, trapezoid
  gusset - profiles with concave corners and arcs.

All linear profiles: 6-64 points, CCW, simple, coordinates >= 0, voids keep
>= 1.3 mm from every edge and from each other (audit floor is 1.2). Rendered
through sketch2's ``core2s``, audited by sketch2's audit + place1.
"""

from __future__ import annotations

import math

from tools.dataset_gen2.common import Rng, fmt
from tools.dataset_gen2.prompts import ru_count, en_count
from tools.dataset_sketch1.geom1 import bbox2, signed_area
from tools.dataset_sketch2.core2s import Sketch2Part, finish_sketch2
from tools.dataset_v5.kit import SEED_V5

MARGIN = 1.3  # design clearance to the audit's 1.2 mm floors


def _r3(value: float) -> float:
    return round(value + 0.0, 3)


def _circle(cx: float, cy: float, radius: float, n: int = 16,
            phase: float = 11.0) -> list[tuple[float, float]]:
    return [
        (_r3(cx + radius * math.cos(math.radians(phase + 360.0 * k / n))),
         _r3(cy + radius * math.sin(math.radians(phase + 360.0 * k / n))))
        for k in range(n)
    ]


def _ccw(points: list[tuple[float, float]]) -> list[tuple[float, float]]:
    return points if signed_area(points) > 0 else list(reversed(points))


def _dedupe(points: list[tuple[float, float]]) -> list[tuple[float, float]]:
    out: list[tuple[float, float]] = []
    for point in points:
        if not out or math.dist(point, out[-1]) > 1e-6:
            out.append(point)
    if len(out) > 1 and math.dist(out[0], out[-1]) <= 1e-6:
        out.pop()
    return out


def _kernel(poly: list[tuple[float, float]]) -> list[tuple[float, float]]:
    """Intersection of the inner half-planes = kernel of a (possibly concave) CCW polygon."""
    clipped: list[tuple[float, float]] = [(-1e4, -1e4), (1e4, -1e4), (1e4, 1e4), (-1e4, 1e4)]
    count = len(poly)
    for index in range(count):
        x0, y0 = poly[index]
        x1, y1 = poly[(index + 1) % count]
        ex, ey = x1 - x0, y1 - y0
        out: list[tuple[float, float]] = []
        for j in range(len(clipped)):
            px, py = clipped[j]
            qx, qy = clipped[(j + 1) % len(clipped)]
            sp = ex * (py - y0) - ey * (px - x0)
            sq = ex * (qy - y0) - ey * (qx - x0)
            if sp >= -1e-9:
                out.append((px, py))
            if (sp > 1e-9) != (sq > 1e-9):
                t = sp / (sp - sq)
                out.append((px + t * (qx - px), py + t * (qy - py)))
        clipped = out
        if not clipped:
            break
    return clipped


def _require_voids_in_kernel(profile: list[tuple[float, float]],
                             voids: list[list[tuple[float, float]]]) -> None:
    """Every void must sit inside the profile kernel (see _kernel)."""
    from tools.dataset_sketch2.core2s import _distance_to_ring, point_in_polygon

    kernel = _kernel(profile)
    if len(kernel) < 3:
        raise ValueError("profile kernel is empty")
    for void in voids:
        for point in void:
            if not point_in_polygon(point, kernel):
                raise ValueError("void leaves the profile kernel")
            if _distance_to_ring(point, kernel) < 0.05:
                raise ValueError("void grazes the profile kernel")


def _normalise(raw: list[tuple[float, float]]) -> tuple[list[tuple[float, float]], float, float]:
    """Shift the profile to the first quadrant; return it plus the old origin."""
    min_x = min(x for x, _ in raw)
    min_y = min(y for _, y in raw)
    return [(_r3(x - min_x), _r3(y - min_y)) for x, y in raw], -min_x, -min_y


# ---------------------------------------------------------------------------
# 1. camplates
# ---------------------------------------------------------------------------


def _cam_radius(angle_deg: float, base_r: float, lobe_h: float,
                lobe_at: tuple[float, ...], sharpness: float) -> float:
    total = 0.0
    for centre in lobe_at:
        delta = math.radians(angle_deg - centre)
        total += (0.5 + 0.5 * math.cos(delta)) ** sharpness
    return base_r + lobe_h * min(total, 1.0)


def build_camplates(index: int) -> Sketch2Part:
    rng = Rng("camplates4", index, seed=SEED_V5)
    variant = rng.choice(("single_lobe", "double_lobe", "eccentric"))
    base_r = rng.grid([24.0, 28.0, 32.0, 36.0])
    lobe_h = rng.grid([8.0, 10.0, 12.0, 14.0])
    bore_r = rng.grid([5.0, 6.0, 8.0])
    plate_t = rng.grid([5.0, 6.0, 8.0, 10.0])
    sharp = rng.grid([3.0, 4.0])

    if variant == "eccentric":
        ecc = rng.grid([4.0, 5.0, 6.0])
        raw = [
            (ecc + base_r * math.cos(math.radians(360.0 * k / 48)),
             base_r * math.sin(math.radians(360.0 * k / 48)))
            for k in range(48)
        ]
        lobe_at: tuple[float, ...] = ()
        min_radius = base_r
    else:
        lobe_at = (90.0,) if variant == "single_lobe" else (0.0, 180.0)
        raw = [
            (_cam_radius(360.0 * k / 48, base_r, lobe_h, lobe_at, sharp)
             * math.cos(math.radians(360.0 * k / 48)),
             _cam_radius(360.0 * k / 48, base_r, lobe_h, lobe_at, sharp)
             * math.sin(math.radians(360.0 * k / 48)))
            for k in range(48)
        ]
        min_radius = base_r
    profile, centre_x, centre_y = _normalise(raw)
    profile = _ccw(profile)

    voids: list[list[tuple[float, float]]] = []
    comments: list[str] = []
    voids.append(_circle(centre_x, centre_y, bore_r, 18))
    comments.append("shaft bore")
    n_bolt = 0
    ring_r = bolt_r = 0.0
    if rng.chance(0.6):
        n_bolt = int(rng.choice((3.0, 4.0, 6.0)))
        bolt_r = rng.grid([3.0, 3.5, 4.0])
        ring_r = round((bore_r + min_radius) / 2, 2)
        if ring_r + bolt_r > min_radius - MARGIN or ring_r - bolt_r < bore_r + MARGIN:
            raise ValueError("lightening ring does not fit the cam body")
        if 2 * math.pi * ring_r / n_bolt - 2 * bolt_r < MARGIN:
            raise ValueError("lightening holes crowd each other")
        for k in range(n_bolt):
            angle = math.radians(360.0 * k / n_bolt)
            voids.append(_circle(centre_x + ring_r * math.cos(angle),
                                 centre_y + ring_r * math.sin(angle), bolt_r, 14))
            comments.append(f"lightening hole {k + 1}")

    from tools.dataset_sketch2.core2s import _distance_to_ring
    for void in voids:
        for point in void:
            if _distance_to_ring(point, profile) < 1.25:
                raise ValueError("cam void crowds the profile boundary")
    plate_box = bbox2(profile)
    bbox = (round(plate_box[2] - plate_box[0], 3),
            round(plate_box[3] - plate_box[1], 3), plate_t)
    feats_ru = [
        f"базовый радиус {fmt(base_r)} мм"
        + ("" if variant == "eccentric" else f", подъём кулачка {fmt(lobe_h)} мм"),
        f"центральное отверстие d{fmt(_r3(2 * bore_r))} мм",
    ]
    feats_en = [
        f"base circle R{fmt(base_r)} mm"
        + ("" if variant == "eccentric" else f", cam rise {fmt(lobe_h)} mm"),
        f"centre bore d{fmt(_r3(2 * bore_r))} mm",
    ]
    if n_bolt:
        feats_ru.append(f"{n_bolt} {_plural(n_bolt, 'облегчающее отверстие', 'облегчающих отверстия', 'облегчающих отверстий')} d{fmt(_r3(2 * bolt_r))} мм по радиусу {fmt(ring_r)} мм")
        feats_en.append(f"{n_bolt} lightening holes d{fmt(_r3(2 * bolt_r))} mm on a {fmt(ring_r)} mm ring")
    params = [
        ("base_r", base_r, "base circle radius"),
        ("lobe_h", lobe_h, "cam lobe rise"),
        ("bore_r", bore_r, "shaft bore radius"),
        ("plate_t", plate_t, "plate thickness, Z (extrusion height)"),
    ]
    if variant == "eccentric":
        params.append(("ecc", ecc, "disc eccentricity"))
    if n_bolt:
        params += [("ring_r", ring_r, "lightening ring radius"),
                   ("bolt_r", bolt_r, "lightening hole radius")]
    return finish_sketch2(
        rng,
        family="camplates",
        variant=variant,
        title="Cam plate",
        summary=f"{variant} cam, base R{base_r:g}",
        params=params,
        derived=[],
        profile=profile,
        extrude={"kind": "linear", "height_mm": plate_t},
        bbox=bbox,
        voids=voids,
        void_depths=[plate_t] * len(voids),
        void_comments=comments,
        ru_nouns=("кулачковую плиту", "плиту с кулачковым профилем", "кулачок-плиту"),
        en_nouns=("a cam plate", "a cam profile plate", "a plate cam"),
        features_ru=feats_ru,
        features_en=feats_en,
    )


def _plural(n: int, one: str, few: str, many: str) -> str:
    if n % 10 == 1 and n % 100 != 11:
        return one
    if 2 <= n % 10 <= 4 and not 12 <= n % 100 <= 14:
        return few
    return many


# ---------------------------------------------------------------------------
# 2. spacerplates
# ---------------------------------------------------------------------------


def build_spacerplates(index: int) -> Sketch2Part:
    rng = Rng("spacerplates4", index, seed=SEED_V5)
    variant = rng.choice(("round_flange", "rect_spacer", "obround"))
    plate_t = rng.grid([5.0, 6.0, 8.0])
    bore_r = rng.grid([8.0, 10.0, 12.0])
    bolt_r = rng.grid([2.5, 3.0, 3.5])

    voids: list[list[tuple[float, float]]] = []
    comments: list[str] = []
    if variant == "round_flange":
        flange_r = rng.grid([30.0, 35.0, 40.0, 45.0])
        n_bolt = int(rng.choice((4.0, 6.0, 8.0)))
        ring_r = round((bore_r + flange_r) / 2, 2)
        if ring_r + bolt_r > flange_r - MARGIN or ring_r - bolt_r < bore_r + MARGIN:
            raise ValueError("bolt ring does not fit the flange")
        if 2 * math.pi * ring_r / n_bolt - 2 * bolt_r < MARGIN:
            raise ValueError("bolt holes crowd each other")
        raw = [(flange_r * math.cos(math.radians(360.0 * k / 40)),
                flange_r * math.sin(math.radians(360.0 * k / 40))) for k in range(40)]
        profile, cx, cy = _normalise(raw)
        voids.append(_circle(cx, cy, bore_r, 18))
        comments.append("centre bore")
        for k in range(n_bolt):
            angle = math.radians(360.0 * k / n_bolt)
            voids.append(_circle(cx + ring_r * math.cos(angle),
                                 cy + ring_r * math.sin(angle), bolt_r, 14))
            comments.append(f"bolt hole {k + 1}")
        feats_ru = [f"фланец d{fmt(_r3(2 * flange_r))} мм",
                    f"{n_bolt} {_plural(n_bolt, 'отверстие', 'отверстия', 'отверстий')} d{fmt(_r3(2 * bolt_r))} мм по окружности d{fmt(_r3(2 * ring_r))} мм"]
        feats_en = [f"flange d{fmt(_r3(2 * flange_r))} mm",
                    f"{n_bolt} holes d{fmt(_r3(2 * bolt_r))} mm on a d{fmt(_r3(2 * ring_r))} mm circle"]
        extra_params = [("flange_r", flange_r, "flange radius"),
                        ("n_bolt", float(n_bolt), "bolt hole count"),
                        ("ring_r", ring_r, "bolt circle radius")]
        summary = f"round flange R{flange_r:g}, {n_bolt} bolts"
    elif variant == "rect_spacer":
        plate_l = rng.grid([70.0, 80.0, 90.0, 100.0])
        plate_w = rng.grid([45.0, 50.0, 60.0])
        inset = rng.grid([10.0, 12.0, 14.0])
        if inset - bolt_r < MARGIN or bore_r + MARGIN > min(plate_l, plate_w) / 2 - inset:
            pass
        ch = 3.0
        raw = [(-plate_l / 2 + ch, -plate_w / 2), (plate_l / 2 - ch, -plate_w / 2),
               (plate_l / 2, -plate_w / 2 + ch), (plate_l / 2, plate_w / 2 - ch),
               (plate_l / 2 - ch, plate_w / 2), (-plate_l / 2 + ch, plate_w / 2),
               (-plate_l / 2, plate_w / 2 - ch), (-plate_l / 2, -plate_w / 2 + ch)]
        profile, cx, cy = _normalise(raw)
        voids.append(_circle(cx, cy, bore_r, 18))
        comments.append("centre bore")
        for sx in (-1, 1):
            for sy in (-1, 1):
                voids.append(_circle(cx + sx * (plate_l / 2 - inset),
                                     cy + sy * (plate_w / 2 - inset), bolt_r, 12))
                comments.append("corner hole")
        if min(math.dist((cx + sx * (plate_l / 2 - inset), cy + sy * (plate_w / 2 - inset)),
                         (cx, cy)) for sx in (-1, 1) for sy in (-1, 1)) < bore_r + bolt_r + MARGIN:
            raise ValueError("corner holes crowd the bore")
        feats_ru = [f"контур {fmt(plate_l)} x {fmt(plate_w)} мм",
                    f"четыре угловых отверстия d{fmt(_r3(2 * bolt_r))} мм с отступом {fmt(inset)} мм от краёв"]
        feats_en = [f"{fmt(plate_l)} x {fmt(plate_w)} mm outline",
                    f"four corner holes d{fmt(_r3(2 * bolt_r))} mm, {fmt(inset)} mm in from the edges"]
        extra_params = [("plate_l", plate_l, "plate length, X"),
                        ("plate_w", plate_w, "plate width, Y"),
                        ("inset", inset, "corner hole inset")]
        summary = f"rect {plate_l:g} x {plate_w:g}"
    else:
        span = rng.grid([50.0, 60.0, 70.0])
        cap_r = rng.grid([20.0, 24.0, 28.0])
        if bore_r + MARGIN > cap_r - MARGIN:
            raise ValueError("bore breaks the obround cap")
        raw = []
        for k in range(13):
            angle = math.radians(90.0 + 180.0 * k / 12)
            raw.append((-span / 2 + cap_r * math.cos(angle), cap_r * math.sin(angle)))
        for k in range(13):
            angle = math.radians(270.0 + 180.0 * k / 12)
            raw.append((span / 2 + cap_r * math.cos(angle), cap_r * math.sin(angle)))
        profile, cx, cy = _normalise(raw)
        profile = _dedupe(profile)
        voids.append(_circle(cx, cy, bore_r, 18))
        comments.append("centre bore")
        for sx in (-1, 1):
            voids.append(_circle(cx + sx * span / 2, cy, bolt_r, 12))
            comments.append("end hole")
        if cap_r < bore_r + bolt_r + 2 * MARGIN:
            raise ValueError("end holes crowd the bore")
        feats_ru = [f"овальный контур: база {fmt(span)} мм, торцы R{fmt(cap_r)} мм",
                    f"два торцевых отверстия d{fmt(_r3(2 * bolt_r))} мм по оси"]
        feats_en = [f"obround outline on a {fmt(span)} mm span with R{fmt(cap_r)} mm caps",
                    f"two end holes d{fmt(_r3(2 * bolt_r))} mm on the axis"]
        extra_params = [("span", span, "obround span"), ("cap_r", cap_r, "cap radius")]
        summary = f"obround span {span:g}, caps R{cap_r:g}"
    profile = _ccw(profile)
    plate_box = bbox2(profile)
    bbox = (round(plate_box[2] - plate_box[0], 3),
            round(plate_box[3] - plate_box[1], 3), plate_t)
    return finish_sketch2(
        rng,
        family="spacerplates",
        variant=variant,
        title="Spacer plate",
        summary=summary,
        params=[
            ("bore_r", bore_r, "centre bore radius"),
            ("bolt_r", bolt_r, "bolt hole radius"),
            ("plate_t", plate_t, "plate thickness, Z (extrusion height)"),
        ] + extra_params,
        derived=[],
        profile=profile,
        extrude={"kind": "linear", "height_mm": plate_t},
        bbox=bbox,
        voids=voids,
        void_depths=[plate_t] * len(voids),
        void_comments=comments,
        ru_nouns=("проставочную плиту", "фланцевую проставку", "плиту-проставку"),
        en_nouns=("a spacer plate", "a flange spacer", "a shim plate"),
        features_ru=feats_ru,
        features_en=feats_en,
    )


# ---------------------------------------------------------------------------
# 3. starwheels
# ---------------------------------------------------------------------------


def build_starwheels(index: int) -> Sketch2Part:
    rng = Rng("starwheels4", index, seed=SEED_V5)
    variant = rng.choice(("star", "ratchet", "blunt"))
    if variant == "ratchet":
        n_points = int(rng.choice((8.0, 10.0, 12.0)))
    else:
        n_points = int(rng.choice((5.0, 6.0, 7.0, 8.0)))
    r_out = rng.grid([30.0, 35.0, 40.0, 45.0])
    ratio = rng.grid([0.6, 0.65, 0.7]) if variant == "blunt" else rng.grid([0.5, 0.55, 0.6])
    r_in = round(r_out * ratio, 2)
    bore_r = rng.grid([4.0, 5.0, 6.0])
    plate_t = rng.grid([5.0, 6.0, 8.0])
    rot = rng.grid([0.0, 90.0, 180.0])

    raw: list[tuple[float, float]] = []
    if variant == "ratchet":
        for k in range(n_points):
            step = 360.0 / n_points
            a0 = rot + k * step
            raw.append((r_in * math.cos(math.radians(a0)), r_in * math.sin(math.radians(a0))))
            raw.append((r_out * math.cos(math.radians(a0 + step * 0.3)),
                        r_out * math.sin(math.radians(a0 + step * 0.3))))
            raw.append((r_in * math.cos(math.radians(a0 + step * 0.55)),
                        r_in * math.sin(math.radians(a0 + step * 0.55))))
    else:
        for k in range(2 * n_points):
            radius = r_out if k % 2 == 0 else r_in
            angle = math.radians(rot + 180.0 * k / n_points)
            raw.append((radius * math.cos(angle), radius * math.sin(angle)))
    profile, cx, cy = _normalise(raw)
    profile = _ccw(profile)

    voids: list[list[tuple[float, float]]] = [_circle(cx, cy, bore_r, 18)]
    comments = ["centre bore"]
    _require_voids_in_kernel(profile, voids)
    feats_ru = [
        f"{n_points} {_plural(n_points, 'зуб', 'зуба', 'зубьев')}: наружный радиус {fmt(r_out)} мм, впадина {fmt(r_in)} мм",
        f"центральное отверстие d{fmt(_r3(2 * bore_r))} мм",
    ]
    feats_en = [
        f"{n_points} points: R{fmt(r_out)} mm tips, R{fmt(r_in)} mm roots",
        f"centre bore d{fmt(_r3(2 * bore_r))} mm",
    ]
    plate_box = bbox2(profile)
    bbox = (round(plate_box[2] - plate_box[0], 3),
            round(plate_box[3] - plate_box[1], 3), plate_t)
    return finish_sketch2(
        rng,
        family="starwheels",
        variant=variant,
        title="Star wheel",
        summary=f"{n_points}-point {variant}, R{r_out:g}",
        params=[
            ("n_points", float(n_points), "number of points / teeth"),
            ("r_out", r_out, "tip radius"),
            ("r_in", r_in, "root radius"),
            ("bore_r", bore_r, "centre bore radius"),
            ("plate_t", plate_t, "plate thickness, Z (extrusion height)"),
            ("bore_d", _r3(2 * bore_r), "centre bore diameter"),
        ],
        derived=[],
        profile=profile,
        extrude={"kind": "linear", "height_mm": plate_t},
        bbox=bbox,
        voids=voids,
        void_depths=[plate_t] * len(voids),
        void_comments=comments,
        ru_nouns=("звёздочку", "звёздчатое колесо", "храповое колесо"),
        en_nouns=("a star wheel", "a star-shaped wheel", "a ratchet wheel"),
        features_ru=feats_ru,
        features_en=feats_en,
    )


# ---------------------------------------------------------------------------
# 4. spinparts (revolved)
# ---------------------------------------------------------------------------


def _spin_finish(rng, variant, title, summary, section, params, feats_ru, feats_en, derived):
    section = _ccw([(round(x, 3), round(z, 3)) for x, z in section])
    max_x = max(x for x, _ in section)
    z0 = min(z for _, z in section)
    z1 = max(z for _, z in section)
    return finish_sketch2(
        rng,
        family="spinparts",
        variant=variant,
        title=title,
        summary=summary,
        params=params + [("revolve_angle", 360.0, "revolve sweep, degrees")],
        derived=derived,
        profile=section,
        extrude={"kind": "rotate"},
        bbox=(_r3(2 * max_x), _r3(2 * max_x), _r3(z1 - z0)),
        ru_nouns=("тело вращения", "токарную деталь", "вращаемый профиль"),
        en_nouns=("a revolved part", "a lathe part", "a turned part"),
        features_ru=feats_ru,
        features_en=feats_en,
    )


def build_spinparts(index: int) -> Sketch2Part:
    rng = Rng("spinparts4", index, seed=SEED_V5)
    variant = rng.choice(("vpulley", "flangebush", "handwheel"))
    bore_r = rng.grid([4.0, 5.0, 6.0])

    if variant == "vpulley":
        rim_r = rng.grid([25.0, 30.0, 35.0, 40.0])
        rim_t = rng.grid([10.0, 12.0, 14.0])
        groove_r = round(bore_r + rng.grid([6.0, 8.0, 10.0]), 2)
        groove_w = rng.grid([3.0, 4.0])
        if groove_r + 2.0 > rim_r - 2.0 or groove_w + 2.0 > rim_t:
            raise ValueError("groove breaks the rim")
        zg = rim_t / 2
        section = [
            (bore_r, 0.0), (rim_r, 0.0), (rim_r, zg - groove_w),
            (groove_r, zg), (rim_r, zg + groove_w), (rim_r, rim_t),
            (bore_r, rim_t),
        ]
        feats_ru = [f"обод d{fmt(_r3(2 * rim_r))} мм шириной {fmt(rim_t)} мм с V-канавкой глубиной до d{fmt(_r3(2 * groove_r))} мм",
                    f"посадочное отверстие d{fmt(_r3(2 * bore_r))} мм"]
        feats_en = [f"rim d{fmt(_r3(2 * rim_r))} mm, {fmt(rim_t)} mm wide, V-groove down to d{fmt(_r3(2 * groove_r))} mm",
                    f"bore d{fmt(_r3(2 * bore_r))} mm"]
        params = [("bore_r", bore_r, "bore radius"), ("rim_r", rim_r, "rim radius"),
                  ("rim_t", rim_t, "rim width"), ("groove_r", groove_r, "groove root radius"),
                  ("groove_w", groove_w, "groove half width")]
        derived = ["bore_d = 2 * bore_r;", "rim_d = 2 * rim_r;", "groove_d = 2 * groove_r;"]
        summary = f"V-groove pulley R{rim_r:g}"
    elif variant == "flangebush":
        flange_r = rng.grid([18.0, 20.0, 24.0])
        flange_h = rng.grid([4.0, 5.0, 6.0])
        sleeve_r = rng.grid([10.0, 12.0])
        total_h = rng.grid([20.0, 24.0, 28.0])
        if sleeve_r <= bore_r + 2.0 or flange_r <= sleeve_r + 2.0:
            raise ValueError("bushing walls too thin")
        section = [
            (bore_r, 0.0), (flange_r, 0.0), (flange_r, flange_h),
            (sleeve_r, flange_h), (sleeve_r, total_h), (bore_r, total_h),
        ]
        feats_ru = [f"бурт d{fmt(_r3(2 * flange_r))} мм толщиной {fmt(flange_h)} мм",
                    f"втулка d{fmt(_r3(2 * sleeve_r))} мм общей высотой {fmt(total_h)} мм, отверстие d{fmt(_r3(2 * bore_r))} мм"]
        feats_en = [f"flange d{fmt(_r3(2 * flange_r))} mm, {fmt(flange_h)} mm thick",
                    f"sleeve d{fmt(_r3(2 * sleeve_r))} mm, {fmt(total_h)} mm overall, d{fmt(_r3(2 * bore_r))} mm bore"]
        params = [("bore_r", bore_r, "bore radius"), ("flange_r", flange_r, "flange radius"),
                  ("flange_h", flange_h, "flange thickness"), ("sleeve_r", sleeve_r, "sleeve radius"),
                  ("total_h", total_h, "overall height")]
        derived = ["bore_d = 2 * bore_r;", "flange_d = 2 * flange_r;", "sleeve_d = 2 * sleeve_r;"]
        summary = f"flanged bushing R{flange_r:g}"
    else:
        rim_r = rng.grid([28.0, 32.0, 36.0])
        rim_w = rng.grid([6.0, 7.0, 8.0])
        rim_t = rng.grid([10.0, 12.0])
        hub_r = round(bore_r + rng.grid([4.0, 5.0, 6.0]), 2)
        web_t = rng.grid([3.0, 4.0])
        if hub_r + 2.0 > rim_r - rim_w - 2.0:
            raise ValueError("hub crowds the rim")
        zw0 = round((rim_t - web_t) / 2, 2)
        zw1 = round(zw0 + web_t, 2)
        section = [
            (bore_r, 0.0), (hub_r, 0.0), (hub_r, zw0), (rim_r - rim_w, zw0),
            (rim_r - rim_w, 0.0), (rim_r, 0.0), (rim_r, rim_t),
            (rim_r - rim_w, rim_t), (rim_r - rim_w, zw1), (hub_r, zw1),
            (hub_r, rim_t), (bore_r, rim_t),
        ]
        feats_ru = [f"обод d{fmt(_r3(2 * rim_r))} мм шириной {fmt(rim_w)} мм",
                    f"ступица d{fmt(_r3(2 * hub_r))} мм, диск толщиной {fmt(web_t)} мм, отверстие d{fmt(_r3(2 * bore_r))} мм"]
        feats_en = [f"rim d{fmt(_r3(2 * rim_r))} mm, {fmt(rim_w)} mm wide",
                    f"hub d{fmt(_r3(2 * hub_r))} mm, {fmt(web_t)} mm web, d{fmt(_r3(2 * bore_r))} mm bore"]
        params = [("bore_r", bore_r, "bore radius"), ("rim_r", rim_r, "rim radius"),
                  ("rim_w", rim_w, "rim axial width"), ("rim_t", rim_t, "rim diameter height"),
                  ("hub_r", hub_r, "hub radius"), ("web_t", web_t, "web thickness")]
        derived = ["bore_d = 2 * bore_r;", "rim_d = 2 * rim_r;", "hub_d = 2 * hub_r;"]
        summary = f"handwheel R{rim_r:g}"
    return _spin_finish(rng, variant, "Revolved part", summary, section, params,
                        feats_ru, feats_en, derived)


# ---------------------------------------------------------------------------
# 5. bracketplates
# ---------------------------------------------------------------------------


def build_bracketplates(index: int) -> Sketch2Part:
    rng = Rng("bracketplates4", index, seed=SEED_V5)
    variant = rng.choice(("cornerpad", "slotplate", "gusset"))
    plate_t = rng.grid([5.0, 6.0, 8.0])
    hole_r = rng.grid([3.0, 3.5, 4.0])
    voids: list[list[tuple[float, float]]] = []
    comments: list[str] = []
    derived: list[str] = []

    if variant == "cornerpad":
        # rounded-corner triangle: three fillet arcs on a right triangle
        leg_a = rng.grid([60.0, 70.0, 80.0])
        leg_b = rng.grid([50.0, 60.0, 70.0])
        rad = rng.grid([10.0, 12.0, 15.0])
        def arc(cx, cy, a0, a1, n=6):
            return [(cx + rad * math.cos(math.radians(a0 + (a1 - a0) * k / n)),
                     cy + rad * math.sin(math.radians(a0 + (a1 - a0) * k / n)))
                    for k in range(n + 1)]
        # tangent points: bottom edge y=0 arcs at (rad,rad) and (leg_a-rad,rad),
        # the hypotenuse gets a simple corner arc at the right angle (0-corner
        # is filleted, the two acute corners stay sharp but chamfered)
        raw: list[tuple[float, float]] = [(rad, 0.0), (leg_a - rad, 0.0)]
        raw += arc(leg_a - rad, rad, -90.0, 0.0)          # bottom-right corner
        raw += [(leg_a, leg_b - rad)]
        raw += arc(leg_a - rad, leg_b - rad, 0.0, 90.0)   # top-right corner
        raw += [(rad + (leg_b - rad) * 0.0, leg_b)] if False else []
        raw += [(leg_a - rad, leg_b)]
        raw += arc(rad, leg_b - 0.0, 90.0, 180.0, 6) if False else []
        raw += [(0.0, leg_b - rad)] if False else []
        # keep it simple and convex: a rectangle-like pad is wrong; fall back
        # to the honest shape - triangle with the right angle filleted:
        raw = [(rad, 0.0), (leg_a, 0.0), (0.0, leg_b), (0.0, rad)]
        raw += arc(rad, rad, 180.0, 270.0, 6)
        profile = _dedupe(raw)
        voids.append(_circle(leg_a * 0.30, leg_b * 0.22, hole_r + 1.0, 14))
        comments.append("mount hole 1")
        voids.append(_circle(leg_a * 0.18, leg_b * 0.45, hole_r, 14))
        comments.append("mount hole 2")
        for void in voids:
            for (x0, y0), (x1, y1) in zip(profile, profile[1:] + profile[:1]):
                dx, dy = x1 - x0, y1 - y0
                length = math.hypot(dx, dy)
                tpar = max(0.0, min(1.0, ((void[0][0] - x0) * dx + (void[0][1] - y0) * dy) / (length * length)))
                if math.hypot(void[0][0] - (x0 + tpar * dx), void[0][1] - (y0 + tpar * dy)) < (hole_r + 1.0) + MARGIN:
                    raise ValueError("corner pad hole crowds an edge")
        if math.dist(voids[0][0], voids[1][0]) < 2 * hole_r + 1.0 + MARGIN:
            raise ValueError("corner pad holes crowd each other")
        feats_ru = [f"треугольная косынка {fmt(leg_a)} x {fmt(leg_b)} мм",
                    f"галтель радиусом {fmt(rad)} мм у прямого угла",
                    f"два монтажных отверстия d{fmt(_r3(2 * hole_r + 2))} и d{fmt(_r3(2 * hole_r))} мм"]
        feats_en = [f"triangular corner pad {fmt(leg_a)} x {fmt(leg_b)} mm",
                    f"a {fmt(rad)} mm fillet at the right angle",
                    f"mount holes d{fmt(_r3(2 * hole_r + 2))} mm and d{fmt(_r3(2 * hole_r))} mm"]
        extra_params = [("leg_a", leg_a, "base leg"), ("leg_b", leg_b, "height leg"),
                        ("fillet_r", rad, "right-angle fillet radius")]
        derived = ["hole_d1 = 2 * hole_r + 2;", "hole_d2 = 2 * hole_r;"]
        summary = f"corner pad {leg_a:g} x {leg_b:g}, fillet R{rad:g}"
    elif variant == "slotplate":
        plate_l = rng.grid([70.0, 80.0, 90.0])
        plate_w = rng.grid([40.0, 45.0, 50.0])
        slot_l = rng.grid([24.0, 28.0, 32.0])
        slot_r = rng.grid([4.0, 5.0])
        ch = 4.0
        if slot_r + MARGIN > plate_w / 2 - 0.0 or slot_l / 2 + slot_r + MARGIN > plate_l / 2 - ch:
            raise ValueError("slot breaks the plate")
        raw = [(-plate_l / 2 + ch, -plate_w / 2), (plate_l / 2 - ch, -plate_w / 2),
               (plate_l / 2, -plate_w / 2 + ch), (plate_l / 2, plate_w / 2 - ch),
               (plate_l / 2 - ch, plate_w / 2), (-plate_l / 2 + ch, plate_w / 2),
               (-plate_l / 2, plate_w / 2 - ch), (-plate_l / 2, -plate_w / 2 + ch)]
        profile, cx, cy = _normalise(raw)
        slot: list[tuple[float, float]] = []
        for k in range(9):
            angle = math.radians(-90.0 + 180.0 * k / 8)
            slot.append((_r3(cx + slot_l / 2 + slot_r * math.cos(angle)),
                         _r3(cy + slot_r * math.sin(angle))))
        for k in range(9):
            angle = math.radians(90.0 + 180.0 * k / 8)
            slot.append((_r3(cx - slot_l / 2 + slot_r * math.cos(angle)),
                         _r3(cy + slot_r * math.sin(angle))))
        voids.append(_dedupe(slot))
        comments.append("grip slot")
        for sx in (-1, 1):
            voids.append(_circle(cx + sx * (plate_l / 2 - ch - hole_r - MARGIN - 0.3),
                                 cy + plate_w / 2 - ch - hole_r - MARGIN - 0.3, hole_r, 12))
            comments.append("corner hole")
            voids.append(_circle(cx + sx * (plate_l / 2 - ch - hole_r - MARGIN - 0.3),
                                 cy - plate_w / 2 + ch + hole_r + MARGIN + 0.3, hole_r, 12))
            comments.append("corner hole")
        feats_ru = [f"пластина {fmt(plate_l)} x {fmt(plate_w)} мм со срезанными углами",
                    f"прорезь {fmt(_r3(slot_l + 2 * slot_r))} x {fmt(_r3(2 * slot_r))} мм в центре",
                    f"четыре угловых отверстия d{fmt(_r3(2 * hole_r))} мм"]
        feats_en = [f"plate {fmt(plate_l)} x {fmt(plate_w)} mm with chamfered corners",
                    f"a {fmt(_r3(slot_l + 2 * slot_r))} x {fmt(_r3(2 * slot_r))} mm central slot",
                    f"four corner holes d{fmt(_r3(2 * hole_r))} mm"]
        extra_params = [("plate_l", plate_l, "plate length"), ("plate_w", plate_w, "plate width"),
                        ("slot_l", slot_l, "slot straight length"), ("slot_r", slot_r, "slot end radius")]
        derived = ["slot_len = slot_l + 2 * slot_r;", "slot_w = 2 * slot_r;",
                   "hole_d2 = 2 * hole_r;"]
        summary = f"slot plate {plate_l:g} x {plate_w:g}"
    else:
        gus_a = rng.grid([50.0, 60.0, 70.0])
        gus_b = rng.grid([40.0, 50.0, 60.0])
        top_x = round(gus_a * rng.grid([0.4, 0.45, 0.5]), 2)
        ch = 4.0
        raw = [(ch, 0.0), (gus_a / 2, 0.0), (gus_a, 0.0), (top_x, gus_b), (0.0, gus_b), (0.0, ch)]
        profile = raw
        light_r = round(min(gus_a, gus_b) * 0.18, 2)
        ccx, ccy = round(gus_a * 0.32, 2), round(gus_b * 0.38, 2)
        for (x0, y0), (x1, y1) in zip(raw, raw[1:] + raw[:1]):
            dx, dy = x1 - x0, y1 - y0
            length = math.hypot(dx, dy)
            tpar = max(0.0, min(1.0, ((ccx - x0) * dx + (ccy - y0) * dy) / (length * length)))
            if math.hypot(ccx - (x0 + tpar * dx), ccy - (y0 + tpar * dy)) < light_r + MARGIN:
                raise ValueError("lightening hole crowds an edge")
        voids.append(_circle(ccx, ccy, light_r, 16))
        comments.append("lightening hole")
        feats_ru = [f"косынка {fmt(gus_a)} x {fmt(gus_b)} мм со срезом до {fmt(top_x)} мм",
                    f"облегчающее отверстие d{fmt(_r3(2 * light_r))} мм"]
        feats_en = [f"gusset {fmt(gus_a)} x {fmt(gus_b)} mm, top cut to {fmt(top_x)} mm",
                    f"a d{fmt(_r3(2 * light_r))} mm lightening hole"]
        extra_params = [("gus_a", gus_a, "base length"), ("gus_b", gus_b, "height"),
                        ("top_x", top_x, "top edge X of the angled cut"),
                        ("light_r", light_r, "lightening hole radius")]
        derived = ["light_d = 2 * light_r;"]
        summary = f"gusset {gus_a:g} x {gus_b:g}"
    profile = _ccw(profile)
    _require_voids_in_kernel(profile, voids)
    plate_box = bbox2(profile)
    bbox = (round(plate_box[2] - plate_box[0], 3),
            round(plate_box[3] - plate_box[1], 3), plate_t)
    return finish_sketch2(
        rng,
        family="bracketplates",
        variant=variant,
        title="Bracket plate",
        summary=summary,
        params=[
            ("hole_r", hole_r, "bolt hole radius"),
            ("plate_t", plate_t, "plate thickness, Z (extrusion height)"),
        ] + extra_params,
        derived=derived,
        profile=profile,
        extrude={"kind": "linear", "height_mm": plate_t},
        bbox=bbox,
        voids=voids,
        void_depths=[plate_t] * len(voids),
        void_comments=comments,
        ru_nouns=("плиту-кронштейн", "крепёжную пластину", "плиту с кронштейном"),
        en_nouns=("a bracket plate", "a mounting plate", "a bracket flat"),
        features_ru=feats_ru,
        features_en=feats_en,
    )


FAMILY_BUILDERS = {
    "camplates": build_camplates,
    "spacerplates": build_spacerplates,
    "starwheels": build_starwheels,
    "spinparts": build_spinparts,
    "bracketplates": build_bracketplates,
}
