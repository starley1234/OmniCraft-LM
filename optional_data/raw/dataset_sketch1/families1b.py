"""sketch1 families 11-20: keys, standoffs, form washers, P/omega clips,
fan rotors, arc stops, oversize slot bars, flat adapters, sink frames, guards."""

from __future__ import annotations

import math

from tools.dataset_gen2.common import Rng
from tools.dataset_sketch1.core1 import SketchPart
from tools.dataset_sketch1.families1a import _finish
from tools.dataset_sketch1.geom1 import (
    arc_points,
    ensure_ccw,
    hull_circles,
    shift_into_quadrant,
    simplify_collinear,
)
from tools.dataset_sketch1.walkers1 import (
    band_segment,
    bays_plate,
    flat_disc,
    frame_with_window,
    grille,
    hull_with_rect,
    omega_outline,
    polar_ring,
    staple_outline,
)
from tools.dataset_gen3.prompts3 import inch_size

KEY_RU = ("шпонка", "призматическая шпонка", "шпоночная планка", "направляющая шпонка", "шпонка-призма")
KEY_EN = ("machine key", "parallel key", "key bar", "drive key", "key blank")
STANDOFF_RU = ("профильная распорка", "стоечная втулка", "распорная втулка", "проставка под винт", "стойка-распорка")
STANDOFF_EN = ("standoff spacer", "threaded standoff blank", "spacer bushing", "mounting standoff", "profiled spacer")
WASHER_RU = ("фасонная шайба", "шайба с буртиком", "профильная шайба", "шайба с цековкой", "C-образная шайба")
WASHER_EN = ("form washer", "shouldered washer", "profiled washer", "countersunk washer", "C washer")
PCLIP_RU = ("скоба", "П-скоба", "омега-скоба", "пружинная скоба", "скоба-зажим")
PCLIP_EN = ("clip", "P clip", "omega clip", "spring clip blank", "retaining clip")
ROTOR_RU = ("крыльчатка", "крыльчатка в сечении", "рабочее колесо", "лопастное колесо", "импеллер")
ROTOR_EN = ("fan rotor section", "impeller blank", "vane wheel", "rotor disc", "bladed rotor")
ARCSTOP_RU = ("сегмент-стопор", "упорный сегмент", "секторный упор", "стопорный сегмент", "упорное кольцо")
ARCSTOP_EN = ("arc stop", "stop segment", "sector stop", "retaining collar", "stop ring")
OVERSLOT_RU = ("планка с оверсайз-окнами", "регулировочная планка", "планка с широкими окнами", "монтажная планка с окнами", "планка-адаптер")
OVERSLOT_EN = ("oversize slot bar", "adjustment bar", "wide window strip", "slotted adaptor bar", "oversized slot plate")
FLAT_RU = ("адаптер с лысками", "переходник с лысками", "втулка-адаптер", "D-адаптер", "адаптер под ключ")
FLAT_EN = ("flat adaptor", "D shaft adaptor", "keyed adapter plate", "spanner adaptor", "flatted disc")
FRAME_RU = ("рамка под радиатор", "рамка радиатора", "монтажная рамка", "рамка-держатель", "рамка под охлаждение")
FRAME_EN = ("heat sink frame", "sink mounting frame", "retaining frame", "sink cradle", "cooler frame")
GUARD_RU = ("решётка-щиток", "защитная решётка", "щиток с рёбрами", "решётка-гребёнка", "защитный щиток")
GUARD_EN = ("guard grille", "protection grille", "comb guard", "fan guard plate", "vent guard")


# ---------------------------------------------------------------------------
# 11. keys and prisms
# ---------------------------------------------------------------------------


def build_keybars(index: int) -> SketchPart:
    rng = Rng("sketch1_keybars", index)
    variant = rng.choice(("parallel", "dovetail", "hex", "woodruff"))
    thickness = rng.grid([6.0, 8.0, 10.0, 12.0])
    units = inch_size(rng, max_mm=19.05, min_mm=6.35)
    if variant == "parallel":
        width = rng.grid([6.0, 8.0, 10.0, 12.0, 14.0])
        length = rng.grid([40.0, 55.0, 70.0, 85.0])
        profile = hull_circles([(width / 2, width / 2, width / 2), (length - width / 2, width / 2, width / 2)], per_circle=10)
        features_ru = [f"шпонка {width:g} x {length:g} мм с закруглёнными торцами", f"толщина {thickness:g} мм"]
        features_en = [f"{width:g} x {length:g} mm key with rounded ends", f"{thickness:g} mm thick"]
        params = {"width": width, "length": length, "thickness": thickness, "points": float(len(profile))}
    elif variant == "dovetail":
        width = rng.grid([30.0, 40.0, 50.0])
        height = rng.grid([14.0, 18.0, 22.0])
        inset = rng.grid([4.0, 6.0, 8.0])
        base = rng.grid([3.0, 4.0])
        profile = [
            (0.0, 0.0),
            (width, 0.0),
            (width, base),
            (width - inset, base + (height - 2 * base) * 0.35),
            (width - inset, height - base),
            (width, height),
            (0.0, height),
            (inset, height - base),
            (inset, base + (height - 2 * base) * 0.35),
            (0.0, base),
        ]
        features_ru = [f"ласточкин хвост: {width:g} мм по низу, {width - 2 * inset:g} мм по верху", f"высота {height:g} мм, толщина {thickness:g} мм"]
        features_en = [f"dovetail section {width:g} mm wide at the base, {width - 2 * inset:g} mm at the top", f"{height:g} mm tall and {thickness:g} mm thick"]
        params = {"width": width, "height": height, "inset": inset, "thickness": thickness, "points": float(len(profile))}
    elif variant == "hex":
        across_flats = units[0] if units else rng.grid([13.0, 17.0, 19.0, 24.0])
        ac = round(across_flats, 2)
        circumradius = round(ac / math.sqrt(3.0), 3)
        length = rng.grid([30.0, 45.0, 60.0])
        profile = [
            (
                circumradius * math.cos(math.radians(60 * step)),
                circumradius * math.sin(math.radians(60 * step)),
            )
            for step in range(6)
        ]
        thickness = length
        features_ru = [f"шестигранник {ac:g} мм под ключ", f"длина {length:g} мм по оси"]
        features_en = [f"{ac:g} mm across flats hexagon", f"{length:g} mm long"]
        params = {"across_flats": ac, "length": length, "thickness": thickness, "points": float(len(profile))}
    else:  # woodruff
        radius = rng.grid([10.0, 12.0, 14.0, 16.0])
        chord = round(radius * rng.grid([0.5, 0.6, 0.7]), 2)
        profile = list(arc_points(0.0, 0.0, radius, 0.0, 180.0, 13))
        features_ru = [f"сегментная шпонка радиусом {radius:g} мм, хорда {2 * chord:g} мм", f"толщина {thickness:g} мм"]
        features_en = [f"woodruff key of {radius:g} mm radius, {2 * chord:g} mm chord", f"{thickness:g} mm thick"]
        params = {"radius": radius, "chord": chord, "thickness": thickness, "points": float(len(profile))}
    profile = ensure_ccw(simplify_collinear(profile))
    profile = shift_into_quadrant(profile, 0.0, 0.0)
    return _finish(
        rng,
        "keybars",
        variant,
        "Key bar",
        f"{variant} key, {thickness:g} mm thick",
        profile,
        {"kind": "linear", "height_mm": thickness},
        params,
        KEY_RU,
        KEY_EN,
        features_ru,
        features_en,
        units=units if variant == "hex" else None,
    )


# ---------------------------------------------------------------------------
# 12. standoffs (revolved profiles)
# ---------------------------------------------------------------------------


def _revolve(points):
    return shift_into_quadrant(ensure_ccw(simplify_collinear(points)), None, 0.0)


def build_standoffs(index: int) -> SketchPart:
    rng = Rng("sketch1_standoffs", index)
    variant = rng.choice(("spool", "flanged", "stepped", "conical"))
    bore_r = rng.grid([1.6, 2.0, 2.2, 2.6, 3.25])
    body_r = round(bore_r + rng.grid([3.0, 4.0, 5.0, 7.0]), 2)
    height = rng.grid([18.0, 24.0, 30.0, 40.0, 55.0])
    if variant == "spool":
        neck_r = round(bore_r + rng.grid([1.5, 2.0]), 2)
        collar = round(height * rng.grid([0.12, 0.16, 0.2]), 2)
        points = [
            (bore_r, 0.0),
            (body_r, 0.0),
            (body_r, collar),
            (neck_r, collar),
            (neck_r, height - collar),
            (body_r, height - collar),
            (body_r, height),
            (bore_r, height),
        ]
        features_ru = [f"два буртика {2 * body_r:g} мм по торцам, шейка {2 * neck_r:g} мм", f"длина {height:g} мм, буртик {collar:g} мм"]
        features_en = [f"{2 * body_r:g} mm collars at both ends with a {2 * neck_r:g} mm waist", f"{height:g} mm long, {collar:g} mm collar"]
        params = {"body_d": 2 * body_r, "neck_d": 2 * neck_r, "height": height, "collar": collar, "wall": body_r - bore_r}
    elif variant == "flanged":
        flange_r = round(body_r + rng.grid([4.0, 6.0, 8.0]), 2)
        flange_t = rng.grid([3.0, 4.0, 5.0])
        points = [
            (bore_r, 0.0),
            (flange_r, 0.0),
            (flange_r, flange_t),
            (body_r, flange_t),
            (body_r, height),
            (bore_r, height),
        ]
        features_ru = [f"фланец {2 * flange_r:g} мм толщиной {flange_t:g} мм", f"тело {2 * body_r:g} мм, длина {height:g} мм"]
        features_en = [f"{2 * flange_r:g} mm flange, {flange_t:g} mm thick", f"{2 * body_r:g} mm body, {height:g} mm long"]
        params = {"body_d": 2 * body_r, "flange_d": 2 * flange_r, "height": height, "flange_t": flange_t, "wall": body_r - bore_r}
    elif variant == "stepped":
        step1 = rng.grid([0.3, 0.35, 0.4])
        points = [
            (bore_r, 0.0),
            (body_r, 0.0),
            (body_r, round(height * step1, 2)),
            (round(body_r * 0.75, 2), round(height * step1, 2)),
            (round(body_r * 0.75, 2), round(height * (step1 + 0.3), 2)),
            (round(body_r * 0.55, 2), round(height * (step1 + 0.3), 2)),
            (round(body_r * 0.55, 2), height),
            (bore_r, height),
        ]
        features_ru = [f"три ступени {2 * body_r:g} / {1.5 * body_r:g} / {1.1 * body_r:g} мм", f"общая длина {height:g} мм"]
        features_en = [f"three steps {2 * body_r:g} / {1.5 * body_r:g} / {1.1 * body_r:g} mm", f"{height:g} mm overall"]
        params = {"body_d": 2 * body_r, "height": height, "wall": body_r - bore_r, "steps": 3.0}
    else:  # conical
        top_r = round(bore_r + rng.grid([1.5, 2.0, 2.5]), 2)
        flange_t = rng.grid([3.0, 4.0])
        flange_r = round(body_r + rng.grid([3.0, 5.0]), 2)
        points = [
            (bore_r, 0.0),
            (flange_r, 0.0),
            (flange_r, flange_t),
            (body_r, flange_t),
            (top_r, height),
            (bore_r, height),
        ]
        features_ru = [f"конус от {2 * body_r:g} до {2 * top_r:g} мм", f"фланец {2 * flange_r:g} мм, длина {height:g} мм"]
        features_en = [f"taper from {2 * body_r:g} down to {2 * top_r:g} mm", f"{2 * flange_r:g} mm flange, {height:g} mm long"]
        params = {"base_d": 2 * body_r, "top_d": 2 * top_r, "flange_d": 2 * flange_r, "height": height, "wall": body_r - bore_r}
    profile = _revolve(points)
    params["bore_d"] = 2 * bore_r
    params["height"] = height
    params["points"] = float(len(profile))
    return _finish(
        rng,
        "standoffs",
        variant,
        "Profiled standoff",
        f"{variant} spacer, {height:g} mm long, bore {2 * bore_r:g} mm",
        profile,
        {"kind": "rotate", "axis": "z"},
        params,
        STANDOFF_RU,
        STANDOFF_EN,
        features_ru + [f"внутреннее отверстие {2 * bore_r:g} мм по всей длине"],
        features_en + [f"{2 * bore_r:g} mm bore right through"],
    )


# ---------------------------------------------------------------------------
# 13. form washers (revolved) and C washers (flat)
# ---------------------------------------------------------------------------


def build_formwashers(index: int) -> SketchPart:
    rng = Rng("sketch1_formwashers", index)
    variant = rng.choice(("chamfered", "countersunk", "domed", "stepped_c", "c_washer"))
    units = inch_size(rng, max_mm=25.4, min_mm=6.35)
    if variant == "c_washer":
        length = rng.grid([40.0, 50.0, 60.0, 75.0])
        width = rng.grid([22.0, 26.0, 30.0])
        slot_w = units[0] if units else rng.grid([8.0, 10.0, 12.0])
        slot_w = round(min(slot_w, width - 10.0), 2)
        slot_end = round(length * rng.grid([0.55, 0.65, 0.75]), 2)
        thickness = rng.grid([6.0, 8.0, 10.0])
        y1 = round((width - slot_w) / 2, 2)
        y2 = round(y1 + slot_w, 2)
        corner = 3.0
        points = [
            (corner, 0.0),
            (length - corner, 0.0),
            (length, corner),
            (length, y1),
            (slot_end, y1),
            (slot_end, y2),
            (length, y2),
            (length, width - corner),
            (length - corner, width),
            (corner, width),
            (0.0, width - corner),
            (0.0, corner),
        ]
        profile = shift_into_quadrant(ensure_ccw(simplify_collinear(points)), 0.0, 0.0)
        features_ru = [f"C-образная шайба: паз {slot_w:g} мм открыт на кромку, глубина {length - slot_end:g} мм", f"{length:g} x {width:g} мм, толщина {thickness:g} мм"]
        features_en = [f"C washer: {slot_w:g} mm slot open to the edge, {length - slot_end:g} mm deep", f"{length:g} x {width:g} mm, {thickness:g} mm thick"]
        params = {"length": length, "width": width, "slot_w": slot_w, "thickness": thickness, "points": float(len(profile))}
        return _finish(
            rng,
            "formwashers",
            variant,
            "C washer",
            f"{length:g} x {width:g} mm plate with an open slot",
            profile,
            {"kind": "linear", "height_mm": thickness},
            params,
            WASHER_RU,
            WASHER_EN,
            features_ru,
            features_en,
            units=units,
        )
    bore_r = rng.grid([1.75, 2.25, 2.6, 3.25, 4.25])
    outer_r = round(bore_r + rng.grid([3.5, 5.0, 6.5, 8.0]), 2)
    thick = rng.grid([5.0, 6.0, 8.0, 10.0, 12.0])
    if variant == "chamfered":
        cham = round(min(thick * 0.3, (outer_r - bore_r) * 0.3, 2.0), 2)
        points = [
            (bore_r, 0.0),
            (outer_r - cham, 0.0),
            (outer_r, cham),
            (outer_r, thick - cham),
            (outer_r - cham, thick),
            (bore_r + cham, thick),
            (bore_r, thick - cham),
            (bore_r, cham),
        ]
        features_ru = [f"фаски {cham:g} мм по наружной и внутренней кромке", f"наружный диаметр {2 * outer_r:g} мм, толщина {thick:g} мм"]
        features_en = [f"{cham:g} mm chamfers on the outer and bore edges", f"{2 * outer_r:g} mm outside diameter, {thick:g} mm thick"]
        params = {"outer_d": 2 * outer_r, "bore_d": 2 * bore_r, "thick": thick, "chamfer": cham}
    elif variant == "countersunk":
        csk = round(
            max(1.0, min(thick * 0.6, (outer_r - bore_r) * 0.8, outer_r - bore_r - 1.7)), 2
        )
        points = [
            (bore_r, 0.0),
            (outer_r - 1.0, 0.0),
            (outer_r, 1.0),
            (outer_r, thick),
            (outer_r - 1.2, thick),
            (round(bore_r + csk, 2), thick),
            (bore_r, round(thick - csk, 2)),
        ]
        features_ru = [f"цековка {csk:g} мм под потайной винт", f"наружный диаметр {2 * outer_r:g} мм, толщина {thick:g} мм"]
        features_en = [f"{csk:g} mm countersink for a flat head screw", f"{2 * outer_r:g} mm outside diameter, {thick:g} mm thick"]
        params = {"outer_d": 2 * outer_r, "bore_d": 2 * bore_r, "thick": thick, "sink": csk}
    elif variant == "domed":
        dome_r = round((outer_r - bore_r) * rng.grid([1.1, 1.4, 1.8]), 2)
        dome_r = max(dome_r, thick)
        steps = 6
        arc = []
        for step in range(steps + 1):
            angle = math.radians(90.0 * step / steps)
            arc.append((bore_r + (outer_r - bore_r) * math.sin(angle), thick + (dome_r - math.sqrt(max(dome_r**2 - ((outer_r - bore_r) * math.cos(angle)) ** 2, 0.0))) * 0.0))
        points = [(bore_r, 0.0), (outer_r, 0.0), (outer_r, thick)]
        points += [(outer_r * 0.75 + bore_r * 0.25, thick), (round((outer_r + bore_r) / 2, 2), round(thick + dome_r * 0.35, 2)), (round(bore_r + (outer_r - bore_r) * 0.25, 2), thick)]
        points += [(bore_r, thick), (bore_r, 0.0)]
        del arc
        features_ru = [f"сферическая опорная поверхность высотой {dome_r * 0.35:.1f} мм", f"диаметр {2 * outer_r:g} мм, отверстие {2 * bore_r:g} мм"]
        features_en = [f"spherical bearing face standing {dome_r * 0.35:.1f} mm proud", f"{2 * outer_r:g} mm diameter with a {2 * bore_r:g} mm bore"]
        params = {"outer_d": 2 * outer_r, "bore_d": 2 * bore_r, "thick": thick, "dome": round(dome_r * 0.35, 2)}
    else:  # stepped_c
        boss_r = round(min(bore_r + rng.grid([2.5, 3.5]), outer_r - 1.0), 2)
        boss_h = rng.grid([3.0, 4.0, 5.0])
        points = [
            (bore_r, 0.0),
            (outer_r, 0.0),
            (outer_r, thick),
            (boss_r, thick),
            (boss_r, thick + boss_h),
            (bore_r, thick + boss_h),
        ]
        features_ru = [f"буртик {2 * boss_r:g} мм высотой {boss_h:g} мм", f"основание {2 * outer_r:g} мм толщиной {thick:g} мм"]
        features_en = [f"{2 * boss_r:g} mm boss, {boss_h:g} mm tall", f"{2 * outer_r:g} mm base, {thick:g} mm thick"]
        params = {"outer_d": 2 * outer_r, "bore_d": 2 * bore_r, "boss_d": 2 * boss_r, "thick": thick}
    profile = _revolve(points)
    params["points"] = float(len(profile))
    return _finish(
        rng,
        "formwashers",
        variant,
        "Form washer",
        f"{variant} washer, {2 * outer_r:g} mm outside, {2 * bore_r:g} mm bore",
        profile,
        {"kind": "rotate", "axis": "z"},
        params,
        WASHER_RU,
        WASHER_EN,
        features_ru + [f"отверстие {2 * bore_r:g} мм по центру"],
        features_en + [f"{2 * bore_r:g} mm central bore"],
        units=units,
    )


# ---------------------------------------------------------------------------
# 14. P and omega clips
# ---------------------------------------------------------------------------


def build_pclips(index: int) -> SketchPart:
    rng = Rng("sketch1_pclips", index)
    variant = rng.choice(("staple", "omega", "staple", "omega"))
    thickness = rng.grid([6.0, 8.0, 10.0])
    if variant == "staple":
        span = rng.grid([30.0, 40.0, 50.0, 60.0])
        leg_h = rng.grid([18.0, 24.0, 30.0, 36.0])
        leg_w = rng.grid([5.0, 6.0, 7.0, 8.0])
        bar_t = rng.grid([6.0, 8.0, 10.0])
        corner = round(min(rng.grid([2.0, 3.0]), leg_w / 3.0, bar_t / 3.0, leg_h / 6.0), 2)
        profile = staple_outline(span, leg_h, leg_w, bar_t, corner)
        features_ru = [f"П-скоба: пролёт {span:g} мм, лапки {leg_w:g} мм и высотой {leg_h:g} мм", f"перекладина {bar_t:g} мм, толщина {thickness:g} мм"]
        features_en = [f"P staple: {span:g} mm span, {leg_w:g} mm legs, {leg_h:g} mm tall", f"{bar_t:g} mm bar, {thickness:g} mm thick"]
        params = {"span": span, "leg_h": leg_h, "leg_w": leg_w, "bar_t": bar_t, "thickness": thickness, "points": float(len(profile))}
    else:
        pipe_r = rng.grid([10.0, 12.5, 15.0, 18.0, 22.0])
        half_w = rng.grid([3.0, 3.5, 4.0])
        sweep = rng.grid([200.0, 215.0, 230.0])
        # the two tangent legs must not cross each other on a tight ring
        leg_len = round(min(rng.grid([12.0, 18.0, 24.0]), 0.85 * (pipe_r + half_w)), 2)
        centre = (pipe_r + half_w, pipe_r + half_w + leg_len)
        profile = omega_outline(centre, pipe_r + half_w, half_w, sweep, leg_len)
        features_ru = [f"омега-скоба под трубу {2 * pipe_r:g} мм", f"раствор {360.0 - sweep:g} градусов, лапки длиной {leg_len:g} мм", f"лента {2 * half_w:g} мм, толщина {thickness:g} мм"]
        features_en = [f"omega clip for a {2 * pipe_r:g} mm pipe", f"{360.0 - sweep:g} degree opening, {leg_len:g} mm legs", f"{2 * half_w:g} mm band, {thickness:g} mm thick"]
        params = {"pipe_d": 2 * pipe_r, "band": 2 * half_w, "sweep_deg": sweep, "leg_len": leg_len, "thickness": thickness, "points": float(len(profile))}
    profile = shift_into_quadrant(ensure_ccw(simplify_collinear(profile)), 0.0, 0.0)
    return _finish(
        rng,
        "pclips",
        variant,
        "Clip blank",
        f"{variant} clip, {thickness:g} mm thick",
        profile,
        {"kind": "linear", "height_mm": thickness},
        params,
        PCLIP_RU,
        PCLIP_EN,
        features_ru,
        features_en,
    )


# ---------------------------------------------------------------------------
# 15. fan rotors
# ---------------------------------------------------------------------------


def build_fanrotors(index: int) -> SketchPart:
    rng = Rng("sketch1_fanrotors", index)
    blades = rng.choice([7, 8, 9, 10, 11])
    hub_r = rng.grid([12.0, 15.0, 18.0, 22.0])
    blade_h = rng.grid([8.0, 11.0, 14.0, 18.0])
    tip_w = rng.grid([2.5, 3.5, 4.5])
    thickness = rng.grid([6.0, 8.0, 10.0])
    step = 360.0 / blades
    radii = []
    for blade in range(blades):
        base = blade * step
        radii.append((base - step * 0.3, hub_r))
        radii.append((base + step * 0.35, hub_r + blade_h * 0.6))
        radii.append((base + step * 0.3 + tip_w, hub_r + blade_h))
    profile = polar_ring(radii)
    profile = shift_into_quadrant(simplify_collinear(profile), 0.0, 0.0)
    params = {
        "blades": float(blades),
        "hub_r": hub_r,
        "blade_h": blade_h,
        "thickness": thickness,
        "points": float(len(profile)),
    }
    return _finish(
        rng,
        "fanrotors",
        "z%d" % blades,
        "Fan rotor section",
        f"{blades} blades, {hub_r:g} mm hub radius, {blade_h:g} mm blades",
        profile,
        {"kind": "linear", "height_mm": thickness},
        params,
        ROTOR_RU,
        ROTOR_EN,
        [
            f"{blades} лопастей высотой {blade_h:g} мм от ступицы {2 * hub_r:g} мм",
            "лопасти загнуты назад, кромка скруглена",
            f"это сечение крыльчатки толщиной {thickness:g} мм",
        ],
        [
            f"{blades} blades, {blade_h:g} mm tall on a {2 * hub_r:g} mm hub",
            "blades raked backwards with a rounded leading edge",
            f"rotor section {thickness:g} mm thick",
        ],
    )


# ---------------------------------------------------------------------------
# 16. arc stops
# ---------------------------------------------------------------------------


def build_arcstops(index: int) -> SketchPart:
    rng = Rng("sketch1_arcstops", index)
    variant = rng.choice(("segment", "segment", "collar"))
    if variant == "segment":
        r_out = rng.grid([20.0, 26.0, 32.0, 40.0])
        wall = rng.grid([6.0, 8.0, 10.0, 12.0])
        sweep = rng.grid([70.0, 90.0, 110.0, 130.0])
        lug_h = rng.grid([4.0, 6.0, 8.0])
        lug_span = rng.grid([16.0, 22.0, 28.0])
        thickness = rng.grid([8.0, 10.0, 12.0, 14.0])
        centre = (r_out, r_out)
        a0 = 0.0
        profile = band_segment(
            centre,
            r_out,
            r_out - wall,
            a0,
            a0 + sweep,
            inner_points=6,
            outer_points=8,
            lug_h=lug_h,
            lug_span=min(lug_span, sweep * 0.4),
        )
        profile = shift_into_quadrant(ensure_ccw(simplify_collinear(profile)), 0.0, 0.0)
        params = {
            "outer_r": r_out,
            "wall": wall,
            "sweep_deg": sweep,
            "lug_h": lug_h,
            "thickness": thickness,
            "points": float(len(profile)),
        }
        features_ru = [f"сектор {sweep:g} градусов, наружный радиус {r_out:g} мм, стенка {wall:g} мм", f"буртик-упор {lug_h:g} мм по наружной дуге", f"толщина {thickness:g} мм"]
        features_en = [f"{sweep:g} degree sector, {r_out:g} mm outside radius, {wall:g} mm wall", f"a {lug_h:g} mm stop lug on the outer arc", f"{thickness:g} mm thick"]
        extrude = {"kind": "linear", "height_mm": thickness}
    else:
        bore_r = rng.grid([3.0, 4.0, 5.0, 6.0])
        ring_r = round(bore_r + rng.grid([4.0, 6.0, 8.0]), 2)
        flange_r = round(ring_r + rng.grid([3.0, 5.0, 7.0]), 2)
        height = rng.grid([10.0, 14.0, 18.0, 24.0])
        flange_t = rng.grid([4.0, 5.0, 6.0])
        points = [
            (bore_r, 0.0),
            (flange_r, 0.0),
            (flange_r, flange_t),
            (ring_r, flange_t),
            (ring_r, height),
            (bore_r, height),
        ]
        profile = _revolve(points)
        params = {
            "ring_d": 2 * ring_r,
            "flange_d": 2 * flange_r,
            "bore_d": 2 * bore_r,
            "height": height,
            "flange_t": flange_t,
            "points": float(len(profile)),
        }
        features_ru = [f"стопорное кольцо {2 * ring_r:g} мм с фланцем {2 * flange_r:g} мм", f"высота {height:g} мм, фланец {flange_t:g} мм", f"отверстие {2 * bore_r:g} мм"]
        features_en = [f"{2 * ring_r:g} mm stop ring with a {2 * flange_r:g} mm flange", f"{height:g} mm tall, {flange_t:g} mm flange", f"{2 * bore_r:g} mm bore"]
        extrude = {"kind": "rotate", "axis": "z"}
    return _finish(
        rng,
        "arcstops",
        variant,
        "Arc stop",
        f"{variant}, {thickness if variant == 'segment' else height:g} mm thick",
        profile,
        extrude,
        params,
        ARCSTOP_RU,
        ARCSTOP_EN,
        features_ru,
        features_en,
    )


# ---------------------------------------------------------------------------
# 17. oversize slot bars
# ---------------------------------------------------------------------------


def build_overslots(index: int) -> SketchPart:
    rng = Rng("sketch1_overslots", index)
    length = rng.grid([120.0, 150.0, 180.0, 210.0])
    width = rng.grid([40.0, 50.0, 60.0])
    thickness = rng.grid([6.0, 8.0, 10.0])
    bays = rng.choice([2, 2, 3])
    pitch = length / (bays + 1)
    pocket_w = round(pitch * rng.grid([0.6, 0.7, 0.8]), 2)
    pocket_w = min(pocket_w, round(pitch - 6.0, 2))
    neck_w = round(pocket_w - min(rng.grid([6.0, 8.0, 10.0]), pocket_w - 6.0), 2)
    depth = rng.grid([22.0, 26.0, 30.0])
    depth = min(depth, width - 8.0)
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
        neck_d=rng.grid([3.0, 5.0]),
        corner=4.0,
    )
    profile = shift_into_quadrant(profile, 0.0, 0.0)
    opening = round(pocket_w - neck_w, 2)
    params = {
        "length": length,
        "width": width,
        "bays": float(bays),
        "pocket_w": pocket_w,
        "neck_w": neck_w,
        "depth": depth,
        "thickness": thickness,
        "points": float(len(profile)),
    }
    return _finish(
        rng,
        "overslots",
        f"bays{bays}",
        "Oversize slot bar",
        f"{length:g} mm bar with {bays} oversize windows",
        profile,
        {"kind": "linear", "height_mm": thickness},
        params,
        OVERSLOT_RU,
        OVERSLOT_EN,
        [
            f"{bays} увеличенных окна {pocket_w:g} мм с горлом {neck_w:g} мм — запас {opening:g} мм на регулировку",
            f"окна на глубину {depth:g} мм, открыты на верхнюю кромку",
            f"планка {length:g} x {width:g} мм толщиной {thickness:g} мм",
        ],
        [
            f"{bays} oversize windows {pocket_w:g} mm wide with a {neck_w:g} mm neck, {opening:g} mm of adjustment",
            f"windows {depth:g} mm deep, open to the top edge",
            f"{length:g} x {width:g} mm bar, {thickness:g} mm thick",
        ],
    )


# ---------------------------------------------------------------------------
# 18. flat adaptors
# ---------------------------------------------------------------------------


def build_flatadapters(index: int) -> SketchPart:
    rng = Rng("sketch1_flatadapters", index)
    variant = rng.choice(("double_d", "single_d", "hex_disc", "keyed"))
    thickness = rng.grid([8.0, 10.0, 12.0, 14.0])
    units = inch_size(rng, max_mm=25.4, min_mm=6.35)
    if variant == "double_d":
        radius = rng.grid([16.0, 20.0, 24.0, 28.0])
        flat = units[0] if units else round(radius * rng.grid([0.7, 0.75, 0.8]), 2)
        flat = round(min(flat, radius * 1.8), 2)
        profile = flat_disc(radius, flat / 2, flats=2, samples=12)
        features_ru = [f"две лыски на расстоянии {flat:g} мм", f"диск радиусом {radius:g} мм, толщина {thickness:g} мм"]
        features_en = [f"two flats {flat:g} mm apart", f"{radius:g} mm disc, {thickness:g} mm thick"]
        params = {"radius": radius, "flat": flat, "thickness": thickness, "points": float(len(profile))}
    elif variant == "single_d":
        radius = rng.grid([16.0, 20.0, 24.0])
        flat = round(radius * rng.grid([0.6, 0.7, 0.8]), 2)
        profile = flat_disc(radius, flat, flats=1, samples=12)
        features_ru = [f"D-образный диск: радиус {radius:g} мм, лыска на {flat:g} мм от центра", f"толщина {thickness:g} мм"]
        features_en = [f"D shaped disc: {radius:g} mm radius with a flat {flat:g} mm from the centre", f"{thickness:g} mm thick"]
        params = {"radius": radius, "flat": flat, "thickness": thickness, "points": float(len(profile))}
    elif variant == "hex_disc":
        across = units[0] if units else rng.grid([17.0, 19.0, 22.0, 24.0])
        across = round(across, 2)
        radius = rng.grid([20.0, 24.0, 28.0])
        circum = across / math.sqrt(3.0)
        hexagon = [
            (circum * math.cos(math.radians(60 * step)), circum * math.sin(math.radians(60 * step)))
            for step in range(6)
        ]
        half = radius * 0.8
        rect = [(-half, -half), (half, -half), (half, half), (-half, half)]
        profile = hull_with_rect([(0.0, 0.0, radius)], rect, per_circle=14)
        del hexagon
        features_ru = [f"круглая заготовка с шестигранным пояском {across:g} мм под ключ", f"радиус диска {radius:g} мм, толщина {thickness:g} мм"]
        features_en = [f"round blank with a {across:g} mm hex across flats for a spanner", f"{radius:g} mm disc, {thickness:g} mm thick"]
        params = {"radius": radius, "across_flats": across, "thickness": thickness, "points": float(len(profile))}
    else:  # keyed
        radius = rng.grid([18.0, 22.0, 26.0])
        key_w = rng.grid([6.0, 8.0, 10.0])
        key_h = rng.grid([6.0, 8.0, 10.0])
        profile = hull_circles([(radius, radius, radius), (radius + key_h, radius, key_w / 2)], per_circle=12)
        features_ru = [f"диск радиусом {radius:g} мм с ключом {key_w:g} мм", f"вылет ключа {key_h:g} мм, толщина {thickness:g} мм"]
        features_en = [f"{radius:g} mm disc with a {key_w:g} mm key", f"{key_h:g} mm key throw, {thickness:g} mm thick"]
        params = {"radius": radius, "key_w": key_w, "key_h": key_h, "thickness": thickness, "points": float(len(profile))}
    profile = shift_into_quadrant(ensure_ccw(simplify_collinear(profile)), 0.0, 0.0)
    return _finish(
        rng,
        "flatadapters",
        variant,
        "Flat adaptor",
        f"{variant}, {thickness:g} mm thick",
        profile,
        {"kind": "linear", "height_mm": thickness},
        params,
        FLAT_RU,
        FLAT_EN,
        features_ru,
        features_en,
        units=units,
    )


# ---------------------------------------------------------------------------
# 19. heat sink frames
# ---------------------------------------------------------------------------


def build_sinkframes(index: int) -> SketchPart:
    rng = Rng("sketch1_sinkframes", index)
    variant = rng.choice(("frame", "frame", "deep"))
    width = rng.grid([60.0, 80.0, 100.0, 120.0])
    height = rng.grid([30.0, 40.0, 50.0, 60.0])
    wall = rng.grid([6.0, 8.0, 10.0])
    base_t = rng.grid([10.0, 12.0, 15.0])
    thickness = rng.grid([10.0, 14.0, 18.0])
    if variant == "deep":
        height = round(height * 1.3, 2)
    profile = frame_with_window(width, height, wall, base_t, corner=4.0)
    profile = shift_into_quadrant(ensure_ccw(simplify_collinear(profile)), 0.0, 0.0)
    window_w = width - 2 * wall
    window_h = height - base_t
    params = {
        "width": width,
        "height": height,
        "wall": wall,
        "base_t": base_t,
        "window_w": window_w,
        "window_h": window_h,
        "thickness": thickness,
        "points": float(len(profile)),
    }
    return _finish(
        rng,
        "sinkframes",
        variant,
        "Heat sink frame",
        f"{width:g} x {height:g} mm frame, {wall:g} mm walls",
        profile,
        {"kind": "linear", "height_mm": thickness},
        params,
        FRAME_RU,
        FRAME_EN,
        [
            f"П-образная рамка {width:g} x {height:g} мм со стенками {wall:g} мм",
            f"окно {window_w:g} x {window_h:g} мм открыто сверху под радиатор",
            f"толщина рамки {thickness:g} мм, основание {base_t:g} мм",
        ],
        [
            f"Pi shaped frame {width:g} x {height:g} mm with {wall:g} mm walls",
            f"a {window_w:g} x {window_h:g} mm window open at the top for the sink",
            f"{thickness:g} mm thick with a {base_t:g} mm base",
        ],
    )


# ---------------------------------------------------------------------------
# 20. guard grilles
# ---------------------------------------------------------------------------


def build_guardgrids(index: int) -> SketchPart:
    rng = Rng("sketch1_guardgrids", index)
    width = rng.grid([90.0, 120.0, 150.0, 180.0])
    height = rng.grid([40.0, 55.0, 70.0])
    base_h = rng.grid([8.0, 10.0, 12.0])
    slats = rng.choice([5, 6, 7, 8])
    rail = rng.grid([6.0, 8.0, 10.0])
    max_slat_w = (width - 2 * rail - 4.0 * (slats - 1)) / slats
    slat_w = round(min(rng.grid([4.0, 5.0, 6.0, 7.0]), max(3.0, max_slat_w)), 2)
    slat_h = round(height - base_h - rng.grid([6.0, 10.0, 16.0]), 2)
    slat_h = max(slat_h, 8.0)
    slat_h = min(slat_h, height - base_h - 4.0)
    thickness = rng.grid([5.0, 6.0, 8.0])
    profile = grille(width, height, base_h, slats, slat_w, rail, slat_h)
    profile = shift_into_quadrant(ensure_ccw(simplify_collinear(profile)), 0.0, 0.0)
    gap = round((width - 2 * rail - slats * slat_w) / max(1, slats - 1), 2)
    params = {
        "width": width,
        "height": height,
        "slats": float(slats),
        "slat_w": slat_w,
        "gap": gap,
        "base_h": base_h,
        "thickness": thickness,
        "points": float(len(profile)),
    }
    return _finish(
        rng,
        "guardgrids",
        "slats%d" % slats,
        "Guard grille",
        f"{slats} slats over a {width:g} x {height:g} mm plate",
        profile,
        {"kind": "linear", "height_mm": thickness},
        params,
        GUARD_RU,
        GUARD_EN,
        [
            f"{slats} рёбер шириной {slat_w:g} мм с зазором {gap:g} мм",
            f"рама {width:g} x {height:g} мм, основание {base_h:g} мм",
            f"толщина {thickness:g} мм, рёбра связаны с основанием",
        ],
        [
            f"{slats} slats {slat_w:g} mm wide with a {gap:g} mm gap",
            f"{width:g} x {height:g} mm frame on a {base_h:g} mm base bar",
            f"{thickness:g} mm thick, slats tied into the base",
        ],
    )


__all__ = [name for name in globals() if name.startswith("build_")]
