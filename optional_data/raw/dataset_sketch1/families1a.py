"""sketch1 families 1-10: cams, levers, hooks, eyes, window plates, pawls,
eccentrics, sprockets, racks and T-slot rails."""

from __future__ import annotations

import math

from tools.dataset_gen2.common import Rng
from tools.dataset_sketch1.core1 import SketchPart, finish_sketch
from tools.dataset_sketch1.geom1 import (
    arc_points,
    bbox2,
    hull_circles,
    line_points,
    shift_into_quadrant,
    simplify_collinear,
)
from tools.dataset_sketch1.walkers1 import (
    band_segment,
    beaked_block,
    bays_plate,
    comb_teeth,
    flat_disc,
    fork_outline,
    hull_with_rect,
    omega_outline,
    polar_ring,
    spike_on_hull,
    thick_outline,
)

MESH = "\n"
CAM_RU = ("кулачок", "плоский кулачок", "кулачковый диск", "кулачок с бобышкой", "дисковый кулачок")
CAM_EN = ("flat cam", "cam disc", "profile cam plate", "disk cam", "cam wheel")
LEVER_RU = ("рычаг", "коромысло", "качалка", "рычаг с бобышками", "двуплечий рычаг")
LEVER_EN = ("lever", "rocker arm", "bell crank", "two arm lever", "rocker plate")
HOOK_RU = ("крюк", "крюк-подвес", "грузовой крюк", "крючок с зевом", "крюк с проушиной")
HOOK_EN = ("hook", "suspension hook", "cargo hook", "open hook plate", "hook with an eye")
EYE_RU = ("проушина", "вилка-проушина", "серьга", "проушина с зевом", "рым-проушина")
EYE_EN = ("clevis lug", "eye lug", "fork end", "mounting eye", "shackle lug")
WINDOW_RU = ("пластина с окнами", "планка с карманами", "панель с фигурными окнами", "кронштейн с окнами", "пластина с пазами")
WINDOW_EN = ("window plate", "pocket plate", "slotted bracket plate", "plate with windows", "bayed plate")
PAWL_RU = ("собачка", "стопорная собачка", "храповая собачка", "собачка с клювом", "защёлка-собачка")
PAWL_EN = ("pawl", "ratchet pawl", "detent pawl", "locking pawl", "pawl lever")
ECC_RU = ("эксцентрик", "эксцентриковая шайба", "эксцентриковый диск", "кулачок-эксцентрик", "эксцентрик с лыской")
ECC_EN = ("eccentric disc", "eccentric washer", "offset cam disc", "eccentric plate", "eccentric blank")
SPROCKET_RU = ("звёздочка", "звёздочка под цепь", "цепная звёздочка", "звёздочка с бобышкой", "приводная звёздочка")
SPROCKET_EN = ("chain sprocket", "sprocket wheel", "sprocket blank", "chain wheel", "drive sprocket")
RACK_RU = ("рейка", "зубчатая рейка", "реечная планка", "рейка модульная", "зубчатая планка")
RACK_EN = ("gear rack", "toothed rack", "rack bar", "module rack", "rack strip")
TSLOT_RU = ("направляющая с Т-пазом", "профиль с Т-пазом", "рельс с Т-пазом", "Т-образная направляющая", "профильная направляющая")
TSLOT_EN = ("T-slot rail", "T-slot profile", "aluminium profile section", "T-slot bar", "guide rail section")


def _finish(rng, family, variant, title, summary, profile, extrude, params, ru_nouns, en_nouns, features_ru, features_en, units=None):
    profile = simplify_collinear(profile)
    from tools.dataset_sketch1.geom1 import is_simple

    if not is_simple(profile):
        raise ValueError(f"{family}[{variant}]: outline is not a simple polygon")
    x0, y0, x1, y1 = bbox2(profile)
    if extrude["kind"] == "linear":
        bbox = (round(x1 - x0, 3), round(y1 - y0, 3), round(float(extrude["height_mm"]), 3))
    else:
        bbox = (round(2 * x1, 3), round(2 * x1, 3), round(y1 - y0, 3))
    return finish_sketch(
        rng,
        family=family,
        variant=variant,
        title=title,
        summary=summary,
        profile=profile,
        extrude=extrude,
        bbox=bbox,
        params=params,
        ru_nouns=ru_nouns,
        en_nouns=en_nouns,
        features_ru=features_ru,
        features_en=features_en,
        units=units,
    )


def _polar_cam(base: float, lift: float, variant: str, count: int, boss_extra: float, boss_centre: float, boss_half: float):
    points = []
    for index in range(count):
        t = index / count
        if variant == "rise_dwell":
            if t < 0.35:
                u = t / 0.35
                radius = base + lift * (u - math.sin(2 * math.pi * u) / (2 * math.pi))
            elif t < 0.5:
                radius = base + lift
            elif t < 0.85:
                u = (t - 0.5) / 0.35
                radius = base + lift * (1.0 - (u - math.sin(2 * math.pi * u) / (2 * math.pi)))
            else:
                radius = base
        elif variant == "harmonic":
            radius = base + lift * (0.5 - 0.5 * math.cos(2 * math.pi * t))
        else:  # dwell_arc
            if t < 0.25:
                u = t / 0.25
                radius = base + lift * u * u * (3 - 2 * u)
            elif t < 0.55:
                radius = base + lift
            elif t < 0.8:
                u = (t - 0.55) / 0.25
                radius = base + lift * (1.0 - u * u * (3 - 2 * u))
            else:
                radius = base
        if boss_extra > 0:
            delta = ((index * 360.0 / count) - boss_centre + 180.0) % 360.0 - 180.0
            if abs(delta) < boss_half:
                radius += boss_extra * 0.5 * (1 + math.cos(math.pi * delta / boss_half))
        angle = math.radians(index * 360.0 / count)
        points.append((radius * math.cos(angle), radius * math.sin(angle)))
    return points


def build_camdiscs(index: int) -> SketchPart:
    rng = Rng("sketch1_camdiscs", index)
    variant = rng.choice(("rise_dwell", "harmonic", "dwell_arc", "rise_dwell"))
    base = rng.grid([11.0, 13.0, 15.0, 17.0, 20.0])
    lift = rng.grid([4.0, 6.0, 8.0, 10.0, 12.0])
    count = rng.choice([20, 22, 24, 26, 28, 30, 32])
    height = rng.grid([6.0, 8.0, 10.0, 12.0, 14.0])
    boss_extra = rng.choice([0.0, 0.0, 3.0, 4.5])
    boss_centre = rng.grid([0.0, 45.0, 90.0, 135.0, 180.0, 225.0, 270.0, 315.0])
    boss_half = 30.0
    profile = _polar_cam(base, lift, variant, count, boss_extra, boss_centre, boss_half)
    profile = simplify_collinear(profile)
    profile = shift_into_quadrant(profile, 0.0, 0.0)
    params = {
        "base_r": base,
        "lift": lift,
        "points": float(len(profile)),
        "thickness": height,
        "boss": boss_extra,
    }
    return _finish(
        rng,
        "camdiscs",
        variant,
        "Cam disc",
        f"base radius {base} mm, lift {lift} mm, {len(profile)} profile points",
        profile,
        {"kind": "linear", "height_mm": height},
        params,
        CAM_RU,
        CAM_EN,
        [
            f"базовый радиус {base:g} мм, подъём {lift:g} мм",
            f"толщина {height:g} мм по всей плите",
            "профиль с плавным подъёмом и возвратом",
        ]
        + ([f"сбоку бобышка +{boss_extra:g} мм под толкатель"] if boss_extra else []),
        [
            f"base radius {base:g} mm with a {lift:g} mm lift",
            f"{height:g} mm thick plate",
            "smooth rise and return so the follower never jams",
        ]
        + ([f"a boss standing {boss_extra:g} mm proud of the base circle"] if boss_extra else []),
    )


def build_leverarms(index: int) -> SketchPart:
    rng = Rng("sketch1_leverarms", index)
    variant = rng.choice(("rocker", "bellcrank", "offset", "rocker"))
    thickness = rng.grid([5.0, 6.0, 8.0, 10.0, 12.0])
    r1 = rng.grid([5.0, 6.0, 7.0, 8.0])
    r2 = rng.grid([4.0, 5.0, 6.0, 7.0])
    arm = rng.grid([35.0, 45.0, 55.0, 65.0, 75.0])
    if variant == "rocker":
        circles = [(r1, r1, r1), (r1 + arm, r1, r2)]
    elif variant == "bellcrank":
        circles = [(r1, r1, r1), (r1 + arm, r1, r2), (r1, r1 + arm * rng.grid([0.6, 0.8]), r2)]
    else:
        r3 = rng.grid([4.0, 5.0, 6.0])
        circles = [(r1, r1, r1), (r1 + arm, r1, r2), (r1 + 2 * arm * 0.8, r1, r3)]
    profile = hull_circles(circles, per_circle=10)
    profile = shift_into_quadrant(profile, 0.0, 0.0)
    span = max(bbox2(profile)[2] - bbox2(profile)[0], bbox2(profile)[3] - bbox2(profile)[1])
    params = {"arm": arm, "boss_a": 2 * r1, "boss_b": 2 * r2, "thickness": thickness, "points": float(len(profile))}
    return _finish(
        rng,
        "leverarms",
        variant,
        "Lever arm",
        f"two bosses {2 * r1:g} and {2 * r2:g} mm, {arm:g} mm between centres",
        profile,
        {"kind": "linear", "height_mm": thickness},
        params,
        LEVER_RU,
        LEVER_EN,
        [
            f"бобышки {2 * r1:g} и {2 * r2:g} мм, оси на расстоянии {arm:g} мм",
            f"толщина {thickness:g} мм",
            f"плавный контур снаружи, габарит {span:g} мм",
        ],
        [
            f"{2 * r1:g} and {2 * r2:g} mm bosses, {arm:g} mm between centres",
            f"{thickness:g} mm thick",
            f"smooth outer outline, {span:g} mm overall",
        ],
    )


def build_hookplates(index: int) -> SketchPart:
    rng = Rng("sketch1_hookplates", index)
    variant = rng.choice(("j_hook", "deep_curl", "j_hook", "shallow"))
    curl_r = rng.grid([14.0, 18.0, 22.0, 26.0, 30.0])
    half_w = rng.grid([3.0, 3.5, 4.0, 4.5, 5.0])
    sweep = {"j_hook": 205.0, "deep_curl": 245.0, "shallow": 170.0}[variant]
    shank = rng.grid([18.0, 26.0, 34.0, 42.0])
    thickness = rng.grid([6.0, 8.0, 10.0, 12.0])
    centre = (curl_r + half_w, curl_r + half_w)
    start = 90.0
    path = list(arc_points(centre[0], centre[1], curl_r, start, start + sweep, 11))
    tangent = math.radians(start + sweep + 90.0)
    path.append(
        (
            path[-1][0] + shank * math.cos(tangent),
            path[-1][1] + shank * math.sin(tangent),
        )
    )
    profile = thick_outline(path, half_w, 3)
    profile = shift_into_quadrant(profile, 0.0, 0.0)
    x0, y0, x1, y1 = bbox2(profile)
    params = {
        "curl_r": curl_r,
        "thickness_band": 2 * half_w,
        "shank": shank,
        "sweep_deg": sweep,
        "thickness": thickness,
        "points": float(len(profile)),
    }
    return _finish(
        rng,
        "hookplates",
        variant,
        "Hook plate",
        f"curl radius {curl_r:g} mm over {sweep:g} degrees, {2 * half_w:g} mm thick band",
        profile,
        {"kind": "linear", "height_mm": thickness},
        params,
        HOOK_RU,
        HOOK_EN,
        [
            f"зев радиусом {curl_r:g} мм, дуга {sweep:g} градусов",
            f"лента шириной {2 * half_w:g} мм и хвостовик длиной {shank:g} мм",
            f"толщина {thickness:g} мм",
        ],
        [
            f"{curl_r:g} mm curl over {sweep:g} degrees",
            f"{2 * half_w:g} mm thick band with a {shank:g} mm shank",
            f"{thickness:g} mm thick",
        ],
    )


def build_eyelugs(index: int) -> SketchPart:
    rng = Rng("sketch1_eyelugs", index)
    variant = rng.choice(("clevis", "ring_tail", "clevis", "ring_tail"))
    thickness = rng.grid([6.0, 8.0, 10.0, 12.0])
    if variant == "clevis":
        base_w = rng.grid([28.0, 34.0, 40.0, 46.0])
        base_h = rng.grid([8.0, 10.0, 12.0, 14.0])
        prong_h = rng.grid([22.0, 28.0, 34.0, 40.0])
        slot_w = rng.grid([8.0, 10.0, 12.0, 14.0, 16.0])
        # keep the cheeks thick enough for a stable fillet walk
        slot_w = min(slot_w, base_w - 12.0)
        # the fillets have to fit inside the cheek between the outer face and the slot
        cheek = (base_w - slot_w) / 2.0
        corner = round(max(1.0, min(rng.grid([2.0, 3.0, 4.0]), (slot_w - 2.0) / 2.0, cheek / 2.0 - 0.5)), 2)
        profile = fork_outline(base_w, base_h, prong_h, slot_w, corner)
        features_ru = [
            f"вилка с зевом {slot_w:g} мм между щеками",
            f"щеки высотой {prong_h:g} мм, основание {base_w:g} x {base_h:g} мм",
            f"толщина {thickness:g} мм",
        ]
        features_en = [
            f"{slot_w:g} mm slot between the prongs",
            f"{prong_h:g} mm prongs on a {base_w:g} x {base_h:g} mm base",
            f"{thickness:g} mm thick",
        ]
        params = {"base_w": base_w, "prong_h": prong_h, "slot_w": slot_w, "thickness": thickness, "points": float(len(profile))}
    else:
        ring_r = rng.grid([10.0, 12.0, 14.0, 16.0, 18.0])
        half_w = rng.grid([3.0, 3.5, 4.0, 4.5])
        tail = rng.grid([14.0, 20.0, 26.0, 32.0])
        sweep = rng.grid([230.0, 240.0, 250.0, 260.0])
        start = rng.grid([40.0, 55.0, 70.0, 85.0])
        centre = (ring_r + half_w, ring_r + half_w)
        path = list(
            arc_points(centre[0], centre[1], ring_r, start, start + sweep, 13)
        )
        tip_angle = math.radians(start + sweep + 90.0)
        path.append(
            (
                path[-1][0] + tail * math.cos(tip_angle),
                path[-1][1] + tail * math.sin(tip_angle),
            )
        )
        profile = thick_outline(path, half_w, 3)
        features_ru = [
            f"открытое кольцо радиусом {ring_r:g} мм с раствором {360.0 - sweep:g} градусов",
            f"хвостовик длиной {tail:g} мм продолжает дугу по касательной",
            f"тело {2 * half_w:g} мм, толщина {thickness:g} мм",
        ]
        features_en = [
            f"open ring of {ring_r:g} mm radius with a {360.0 - sweep:g} degree opening",
            f"a {tail:g} mm tail continuing the arc along its tangent",
            f"{2 * half_w:g} mm thick band, {thickness:g} mm deep",
        ]
        params = {"ring_r": ring_r, "tail": tail, "body": 2 * half_w, "sweep_deg": sweep, "thickness": thickness, "points": float(len(profile))}
    profile = shift_into_quadrant(profile, 0.0, 0.0)
    return _finish(
        rng,
        "eyelugs",
        variant,
        "Eye lug",
        f"{variant}, {thickness:g} mm thick",
        profile,
        {"kind": "linear", "height_mm": thickness},
        params,
        EYE_RU,
        EYE_EN,
        features_ru,
        features_en,
    )


def build_windowplates(index: int) -> SketchPart:
    rng = Rng("sketch1_windowplates", index)
    variant = rng.choice(("keyhole", "rect", "keyhole"))
    length = rng.grid([70.0, 90.0, 110.0, 130.0])
    width = rng.grid([35.0, 45.0, 55.0, 65.0])
    thickness = rng.grid([6.0, 8.0, 10.0, 12.0])
    bays = rng.choice([1, 2, 2, 3])
    pocket_w = round(length / (bays + 1) * 0.62, 2)
    neck_w = round(min(pocket_w - 4.0, rng.grid([8.0, 10.0, 12.0])), 2)
    depth = rng.grid([18.0, 22.0, 26.0, 30.0])
    depth = min(depth, width - 8.0)
    neck_d = rng.grid([4.0, 6.0]) if variant == "keyhole" else 0.0
    centres = [round(length / (bays + 1) * (step + 1), 2) for step in range(bays)]
    profile = bays_plate(
        0.0,
        0.0,
        length,
        width,
        centres,
        side="top",
        depth=depth,
        pocket_w=pocket_w,
        neck_w=neck_w,
        neck_d=neck_d,
        corner=3.0,
    )
    profile = shift_into_quadrant(profile, 0.0, 0.0)
    shape_ru = "с узким горлом" if variant == "keyhole" else "прямоугольные"
    shape_en = "with a narrow neck" if variant == "keyhole" else "rectangular"
    params = {
        "length": length,
        "width": width,
        "bays": float(bays),
        "pocket_w": pocket_w,
        "depth": depth,
        "thickness": thickness,
        "points": float(len(profile)),
    }
    return _finish(
        rng,
        "windowplates",
        variant,
        "Window plate",
        f"{length:g} x {width:g} mm, {bays} open windows",
        profile,
        {"kind": "linear", "height_mm": thickness},
        params,
        WINDOW_RU,
        WINDOW_EN,
        [
            f"{bays} окна {shape_ru} шириной {pocket_w:g} мм на глубину {depth:g} мм",
            f"перемычка между окнами не тоньше 4 мм",
            f"плита {length:g} x {width:g} мм толщиной {thickness:g} мм",
        ],
        [
            f"{bays} open windows {shape_en}, {pocket_w:g} mm wide and {depth:g} mm deep",
            "no web thinner than 4 mm between the windows",
            f"{length:g} x {width:g} mm plate, {thickness:g} mm thick",
        ],
    )


def build_pawls(index: int) -> SketchPart:
    rng = Rng("sketch1_pawls", index)
    variant = rng.choice(("beak_up", "beak_side", "beak_up"))
    thickness = rng.grid([5.0, 6.0, 8.0, 10.0])
    body_l = rng.grid([30.0, 38.0, 46.0, 54.0])
    body_h = rng.grid([14.0, 18.0, 22.0, 26.0])
    corner = rng.grid([3.0, 4.0, 5.0])
    beak_base = rng.grid([10.0, 14.0, 18.0])
    beak_h = rng.grid([5.0, 7.0, 9.0, 11.0])
    side = "top" if variant == "beak_up" else "right"
    profile = beaked_block(0.0, 0.0, body_l, body_h, corner, side=side, beak_base=beak_base, beak_h=beak_h)
    profile = shift_into_quadrant(profile, 0.0, 0.0)
    params = {
        "body": body_l,
        "body_h": body_h,
        "beak_base": beak_base,
        "beak_h": beak_h,
        "thickness": thickness,
        "points": float(len(profile)),
    }
    beak_ru = "сверху" if side == "top" else "с правого торца"
    beak_en = "on the top edge" if side == "top" else "on the right end"
    return _finish(
        rng,
        "pawls",
        variant,
        "Ratchet pawl",
        f"{body_l:g} x {body_h:g} mm body, beak {beak_h:g} mm {beak_ru}",
        profile,
        {"kind": "linear", "height_mm": thickness},
        params,
        PAWL_RU,
        PAWL_EN,
        [
            f"корпус {body_l:g} x {body_h:g} мм со скруглениями {corner:g} мм",
            f"клюв {beak_base:g} мм по основанию и {beak_h:g} мм вылетом {beak_ru}",
            f"толщина {thickness:g} мм",
        ],
        [
            f"{body_l:g} x {body_h:g} mm body with {corner:g} mm corners",
            f"a beak {beak_base:g} mm at the base, {beak_h:g} mm proud, {beak_en}",
            f"{thickness:g} mm thick",
        ],
    )


def build_eccentrics(index: int) -> SketchPart:
    rng = Rng("sketch1_eccentrics", index)
    variant = rng.choice(("egg", "step", "double_d", "egg"))
    thickness = rng.grid([6.0, 8.0, 10.0, 12.0])
    if variant == "double_d":
        radius = rng.grid([14.0, 17.0, 20.0, 24.0])
        flat = round(radius * rng.grid([0.7, 0.75, 0.8]), 2)
        profile = flat_disc(radius, flat, flats=2, samples=12)
        features_ru = [
            f"диск радиусом {radius:g} мм с двумя лысками на {flat:g} мм",
            "лыски под ключ, обход контура против часовой стрелки",
            f"толщина {thickness:g} мм",
        ]
        features_en = [
            f"{radius:g} mm disc with two flats {flat:g} mm apart",
            "flats for a spanner",
            f"{thickness:g} mm thick",
        ]
        params = {"radius": radius, "flat": flat, "thickness": thickness, "points": float(len(profile))}
    else:
        r_big = rng.grid([16.0, 19.0, 22.0, 26.0])
        r_small = rng.grid([9.0, 11.0, 13.0])
        offset = rng.grid([4.0, 6.0, 8.0]) if variant == "egg" else rng.grid([10.0, 12.0, 14.0])
        circles = [(r_big, r_big, r_big), (r_big + offset, r_big, r_small)]
        profile = hull_circles(circles, per_circle=12)
        features_ru = [
            f"большой радиус {r_big:g} мм, малый {r_small:g} мм, оси разнесены на {offset:g} мм",
            "плавный эксцентричный контур без ступенек",
            f"толщина {thickness:g} мм",
        ]
        features_en = [
            f"{r_big:g} mm main radius against {r_small:g} mm, centres {offset:g} mm apart",
            "smooth eccentric outline",
            f"{thickness:g} mm thick",
        ]
        params = {"radius_a": r_big, "radius_b": r_small, "offset": offset, "thickness": thickness, "points": float(len(profile))}
    profile = shift_into_quadrant(profile, 0.0, 0.0)
    return _finish(
        rng,
        "eccentrics",
        variant,
        "Eccentric disc",
        f"{variant}, {thickness:g} mm thick",
        profile,
        {"kind": "linear", "height_mm": thickness},
        params,
        ECC_RU,
        ECC_EN,
        features_ru,
        features_en,
    )


def build_sprockets(index: int) -> SketchPart:
    rng = Rng("sketch1_sprockets", index)
    teeth = rng.choice([8, 9, 10, 11, 12, 14, 16])
    r_root = rng.grid([14.0, 18.0, 22.0, 26.0, 30.0])
    tooth_h = rng.grid([4.0, 5.0, 6.0, 8.0])
    lean = rng.grid([0.12, 0.18, 0.24])
    thickness = rng.grid([6.0, 8.0, 10.0])
    step = 360.0 / teeth
    radii = []
    for tooth in range(teeth):
        base = tooth * step
        radii.append((base - step * 0.28, r_root))
        radii.append((base + step * lean, r_root + tooth_h))
    profile = polar_ring(radii)
    profile = shift_into_quadrant(profile, 0.0, 0.0)
    x0, y0, x1, y1 = bbox2(profile)
    params = {
        "teeth": float(teeth),
        "root_r": r_root,
        "tooth_h": tooth_h,
        "thickness": thickness,
        "points": float(len(profile)),
    }
    return _finish(
        rng,
        "sprockets",
        f"z{teeth}",
        "Chain sprocket",
        f"{teeth} teeth, {r_root:g} mm root radius",
        profile,
        {"kind": "linear", "height_mm": thickness},
        params,
        SPROCKET_RU,
        SPROCKET_EN,
        [
            f"{teeth} зубьев под цепь, окружность впадин {2 * r_root:g} мм",
            f"высота зуба {tooth_h:g} мм, зуб поднутряется назад",
            f"толщина {thickness:g} мм",
        ],
        [
            f"{teeth} teeth, {2 * r_root:g} mm root circle",
            f"{tooth_h:g} mm tall teeth with a back rake",
            f"{thickness:g} mm thick",
        ],
    )


def build_rackbars(index: int) -> SketchPart:
    rng = Rng("sketch1_rackbars", index)
    variant = rng.choice(("module", "module", "coarse"))
    length = rng.grid([80.0, 110.0, 140.0, 170.0, 200.0])
    base_h = rng.grid([8.0, 10.0, 12.0, 14.0])
    teeth = rng.choice([6, 7, 8, 9])
    margin = rng.grid([6.0, 8.0, 10.0])
    tip_h = rng.grid([5.0, 6.0, 8.0]) if variant == "module" else rng.grid([9.0, 11.0])
    tip_w = rng.grid([3.0, 4.0, 5.0])
    thickness = rng.grid([8.0, 10.0, 12.0, 14.0])
    profile = comb_teeth(length, base_h, teeth, tip_h, tip_w, margin)
    profile = shift_into_quadrant(profile, 0.0, 0.0)
    pitch = round((length - 2 * margin) / teeth, 2)
    params = {
        "length": length,
        "base_h": base_h,
        "teeth": float(teeth),
        "pitch": pitch,
        "tip_h": tip_h,
        "thickness": thickness,
        "points": float(len(profile)),
    }
    return _finish(
        rng,
        "rackbars",
        variant,
        "Gear rack",
        f"{teeth} teeth on a {length:g} mm bar, pitch {pitch:g} mm",
        profile,
        {"kind": "linear", "height_mm": thickness},
        params,
        RACK_RU,
        RACK_EN,
        [
            f"{teeth} зубьев с шагом {pitch:g} мм по верхней кромке",
            f"высота зуба {tip_h:g} мм, основание {base_h:g} мм",
            f"толщина {thickness:g} мм, длина {length:g} мм",
        ],
        [
            f"{teeth} teeth at {pitch:g} mm pitch along the top edge",
            f"{tip_h:g} mm tall teeth on a {base_h:g} mm base",
            f"{length:g} mm long and {thickness:g} mm thick",
        ],
    )


def build_tslots(index: int) -> SketchPart:
    """T-slot rail: a rectangular section with one or two real T-slots cut in."""
    rng = Rng("sketch1_tslots", index)
    variant = rng.choice(("single", "single", "double"))
    width = rng.grid([40.0, 50.0, 60.0, 70.0, 80.0])
    height = rng.grid([24.0, 30.0, 36.0, 42.0])
    neck_w = round(min(rng.grid([10.0, 12.0, 14.0, 16.0]), height - 8.0), 2)
    channel_h = round(min(neck_w + rng.grid([6.0, 8.0, 10.0]), height - 6.0), 2)
    neck_depth = round(min(rng.grid([5.0, 6.0, 7.0]), width / 4.0), 2)
    channel_end = round(neck_depth + rng.grid([10.0, 14.0, 18.0]), 2)
    if variant == "double":
        channel_end = min(channel_end, width / 2.0 - 4.0)
    else:
        channel_end = min(channel_end, width - 4.0)
    length = rng.grid([60.0, 80.0, 100.0, 120.0])
    centre = height / 2
    y1 = round(centre - neck_w / 2, 2)
    y2 = round(centre + neck_w / 2, 2)
    y3 = round(y1 - (channel_h - neck_w) / 2, 2)
    y4 = round(y2 + (channel_h - neck_w) / 2, 2)

    points = [(0.0, 0.0), (width, 0.0)]
    # right hand slot, walked upwards
    points += [
        (width, y1),
        (width - neck_depth, y1),
        (width - neck_depth, y3),
        (width - channel_end, y3),
        (width - channel_end, y4),
        (width - neck_depth, y4),
        (width - neck_depth, y2),
        (width, y2),
    ]
    points += [(width, height), (0.0, height)]
    if variant == "double":
        # left hand slot, walked downwards
        points += [
            (0.0, y2),
            (neck_depth, y2),
            (neck_depth, y4),
            (channel_end, y4),
            (channel_end, y3),
            (neck_depth, y3),
            (neck_depth, y1),
            (0.0, y1),
        ]
    profile = simplify_collinear(points)
    profile = shift_into_quadrant(profile, 0.0, 0.0)
    params = {
        "width": width,
        "height": height,
        "neck_w": neck_w,
        "channel_h": channel_h,
        "neck_depth": neck_depth,
        "channel_end": channel_end,
        "length": length,
        "points": float(len(profile)),
    }
    slots_ru = "Т-пазы с двух сторон" if variant == "double" else "Т-паз с одной стороны"
    slots_en = "T-slots on both sides" if variant == "double" else "a T-slot on one side"
    return _finish(
        rng,
        "tslots",
        variant,
        "T-slot rail",
        f"{width:g} x {height:g} mm section, {length:g} mm long",
        profile,
        {"kind": "linear", "height_mm": length},
        params,
        TSLOT_RU,
        TSLOT_EN,
        [
            f"{slots_ru}: горло {neck_w:g} мм, полость {channel_h:g} мм на глубину {channel_end:g} мм",
            f"сечение {width:g} x {height:g} мм",
            f"длина {length:g} мм",
        ],
        [
            f"{slots_en}: {neck_w:g} mm neck opening into a {channel_h:g} mm cavity, {channel_end:g} mm deep",
            f"{width:g} x {height:g} mm section",
            f"{length:g} mm long",
        ],
    )


__all__ = [name for name in globals() if name.startswith("build_")]
