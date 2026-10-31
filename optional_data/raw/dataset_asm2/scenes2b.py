"""Scene templates for the asm2 corpus (request 5, block A2): 6 families.

Livelier layouts than asm1, and three of them deliberately call one module
several times (a bolt circle, four corner posts, two wheels) - which is why
the audit lives in :mod:`tools.dataset_asm2.core2b`.

Clearance discipline as in asm1: ``GAP`` axially between mating faces,
``FIT`` diametrically in every clearance hole, so the audit's ``min_gap``
check always sees both a floor and a margin.
"""

from __future__ import annotations

import math
from dataclasses import dataclass, field

from tools.dataset_asm1 import parts2 as P
from tools.dataset_asm2 import parts2b as P2
from tools.dataset_asm2.core2b import Node, Scene, box_size, render_scene2, union_bounds
from tools.dataset_gen2.common import Rng
from tools.dataset_gen2.prompts import dim_phrase_en, dim_phrase_ru
from tools.dataset_gen3.prompts3 import tail3

GAP = 0.25  # design clearance between mating faces, mm
FIT = 0.8  # diametral clearance of a clearance hole, mm (0.4 mm radial)

RU_OPENERS = (
    "Собери узел:",
    "Собери узел по эскизу:",
    "Сделай сборку:",
    "Нужна сборка:",
    "Собери модель узла:",
    "Смоделируй узел:",
    "Собери узел для проверки компоновки:",
    "Смоделируй сборочную сцену:",
)
EN_OPENERS = (
    "Build the assembly:",
    "Model this assembly:",
    "Put the assembly together:",
    "Draw the assembly:",
    "Build this sub-assembly:",
    "Model the scene:",
    "Assemble the parts:",
    "Make an assembly model:",
)
RU_TAIL_FIXED = (
    "Детали не пересекаются, посадки свободные.",
    "Детали встают с зазором, без пересечений.",
    "Собирай без натяга: между деталями зазор.",
    "Каждая деталь отдельным модулем, сборка без пересечений.",
    "Повторяющиеся детали вызывай одним модулем несколько раз.",
)
EN_TAIL_FIXED = (
    "The parts must not intersect, keep the fits loose.",
    "Assemble with clearance, no overlapping parts.",
    "No interference fits: leave a gap between the parts.",
    "One module per part, no parts may touch.",
    "Repeated parts are one module called several times.",
)


@dataclass
class Builder:
    """Collects the instances of one scene and renders it with colors."""

    family: str
    variant: str
    title: str
    nodes: list[Node] = field(default_factory=list)
    ru_features: list[str] = field(default_factory=list)
    en_features: list[str] = field(default_factory=list)

    def add(
        self,
        spec: P.PartSpec,
        axis: str = "z",
        angle: float = 0.0,
        t=(0.0, 0.0, 0.0),
        feature: bool = True,
    ) -> P.PartSpec:
        self.nodes.append(
            Node(
                name=spec.name,
                source=spec.source,
                bounds=spec.bounds,
                axis=axis,
                angle=angle,
                t=(round(t[0], 3), round(t[1], 3), round(t[2], 3)),
                params=dict(spec.params),
                volume=float(spec.volume),
            )
        )
        if feature:
            self.ru_features.append(spec.ru)
            self.en_features.append(spec.en)
        return spec

    def note(self, ru: str, en: str) -> None:
        self.ru_features.append(ru)
        self.en_features.append(en)

    def finish(self, rng: Rng, noun_ru: str, noun_en: str, summary: str = "") -> Scene:
        box = union_bounds([node.world_bounds for node in self.nodes])
        bbox = box_size(box)
        modules: list[str] = []
        seen: set[str] = set()
        for node in self.nodes:
            if node.name in seen:
                continue
            seen.add(node.name)
            modules.append(node.source)
        code = render_scene2(self.title, summary, modules, [node.call for node in self.nodes])
        parameters: dict[str, float] = {"instances": float(len(self.nodes)), "modules": float(len(seen))}
        for node in self.nodes:
            for key, value in node.params.items():
                parameters[f"{node.name}_{key}"] = float(value)

        ru_parts = [feature[0].upper() + feature[1:] + "." for feature in self.ru_features]
        en_parts = [feature[0].upper() + feature[1:] + "." for feature in self.en_features]
        ru_tail, en_tail, _flags = tail3(rng)
        if not ru_tail:
            ru_tail = rng.choice(RU_TAIL_FIXED)
            en_tail = rng.choice(EN_TAIL_FIXED)
        ru = " ".join(
            [f"{rng.choice(RU_OPENERS)} {noun_ru}, {dim_phrase_ru(rng, bbox)}."] + ru_parts + [ru_tail]
        )
        en = " ".join(
            [f"{rng.choice(EN_OPENERS)} {noun_en}, {dim_phrase_en(rng, bbox)}."] + en_parts + [en_tail]
        )
        return Scene(
            family=self.family,
            variant=self.variant,
            code=code,
            bbox=bbox,
            params=parameters,
            prompt_ru=ru,
            prompt_en=en,
            nodes=list(self.nodes),
        )


# ---------------------------------------------------------------------------
# 1. shaft station: shaft + two bearings + housing cup + cover
# ---------------------------------------------------------------------------


def build_shaftstation(index: int) -> Scene:
    rng = Rng("asm2_shaftstation", index)
    variant = rng.choice(("compact", "tall", "wide"))
    shaft_d = rng.grid([8.0, 10.0, 12.0])
    wall = rng.grid([5.0, 6.0]) if variant == "wide" else rng.grid([4.0, 5.0])
    cup_od = round(shaft_d + 4 * wall + FIT + 2.0, 2)
    base = rng.grid([5.0, 6.0, 8.0])
    bearing_h = rng.grid([8.0, 10.0, 12.0])
    spacing = rng.grid([8.0, 10.0]) if variant == "compact" else rng.grid([16.0, 20.0, 24.0])
    cover_t = rng.grid([5.0, 6.0, 8.0])
    protrude = rng.grid([6.0, 8.0, 10.0])

    bearing_od = round(cup_od - 2 * wall - FIT, 2)
    bearing_bore = round(shaft_d + FIT, 2)
    lo_z = base + GAP
    hi_z = lo_z + bearing_h + spacing
    cup_h = round(hi_z + bearing_h + GAP + 1.0, 2)
    cover_z = cup_h + GAP
    shaft_bottom = lo_z
    shaft_top = cover_z + cover_t + protrude
    shaft_l = round(shaft_top - shaft_bottom, 2)
    cover_od = round(cup_od + rng.grid([0.0, 6.0, 8.0]), 2)

    builder = Builder("shaftstation", variant, "Shaft station")
    builder.add(
        P.cup("housing_cup", cup_od, wall, cup_h, base, bearing_bore),
        t=(0.0, 0.0, 0.0),
    )
    builder.add(
        P.ring("bearing_lower", bearing_od, bearing_bore, bearing_h, "нижний подшипник", "lower bearing"),
        t=(0.0, 0.0, round(lo_z, 3)),
    )
    builder.add(
        P.ring("bearing_upper", bearing_od, bearing_bore, bearing_h, "верхний подшипник", "upper bearing"),
        t=(0.0, 0.0, round(hi_z, 3)),
    )
    builder.add(
        P.shaft("station_shaft", shaft_d, shaft_l),
        t=(0.0, 0.0, round((shaft_bottom + shaft_top) / 2, 3)),
    )
    builder.add(
        P.cover(
            "station_cover",
            cover_od,
            cover_t,
            holes=[],
            hole_d=0.0,
            bore=bearing_bore,
            ru_note=f"крышка d{P.num(cover_od)} толщиной {P.num(cover_t)} мм с центральным отверстием d{P.num(bearing_bore)}",
            en_note=f"cover d{P.num(cover_od)}, {P.num(cover_t)} mm thick, d{P.num(bearing_bore)} centre bore",
        ),
        t=(0.0, 0.0, round(cover_z, 3)),
    )
    builder.note(
        f"Зазор между подшипниками {P.num(spacing)} мм, подшипники стоят в стакане с зазором",
        f"Bearing span {P.num(spacing)} mm, both bearings sit loose in the cup",
    )
    return builder.finish(
        rng,
        "вал на двух подшипниках в стакане с крышкой",
        "a shaft on two bearings inside a cup with a cover",
        f"cup d{cup_od:g} x {cup_h:g} mm, shaft d{shaft_d:g}",
    )


# ---------------------------------------------------------------------------
# 2. motor + bracket plate + two pulleys + flat belt
# ---------------------------------------------------------------------------


def build_motorbelt(index: int) -> Scene:
    rng = Rng("asm2_motorbelt", index)
    variant = rng.choice(("short_span", "long_span", "wide_belt"))
    pulley_od = rng.grid([40.0, 50.0, 60.0])
    belt_t = rng.grid([3.0, 4.0])
    belt_w = rng.grid([10.0, 12.0]) if variant == "wide_belt" else rng.grid([8.0, 10.0])
    span = rng.grid([70.0, 80.0]) if variant == "short_span" else rng.grid([100.0, 110.0, 120.0])
    shaft_d = rng.grid([8.0, 10.0])
    plate_t = rng.grid([8.0, 10.0])

    r_in = round(pulley_od / 2 + 0.4, 2)
    r_out = round(r_in + belt_t, 2)
    pulley_h = round(belt_w + 4.5, 2)  # 2 mm flanges + belt + 2 x 0.25 mm axial gap
    hub_d = round(pulley_od * 0.5, 1)
    bore = round(shaft_d + FIT, 2)

    motor_l = rng.grid([45.0, 50.0, 60.0])
    motor_w = rng.grid([42.0, 48.0])
    motor_h = rng.grid([40.0, 45.0, 50.0])
    boss_l = 6.0
    boss_d = round(pulley_od * 0.35, 1)

    # x layout: motor axis at x = 0, driven pulley at x = span
    motor_z0 = plate_t + GAP
    motor_tz = round(motor_z0 + motor_l / 2, 3)  # motor stands on end, boss up (+Z)
    boss_top = motor_z0 + motor_l + boss_l
    pulley_z0 = round(boss_top + GAP, 3)
    belt_z0 = round(pulley_z0 + 2.0 + GAP, 3)
    post_side = round(pulley_od * 0.5, 1)

    plate_l = round(span + 2 * motor_h + 12.0, 2)  # covers the lying motor at -X
    plate_w = round(max(motor_w, pulley_od) + 30.0, 2)
    plate_cx = round(span / 2, 3)  # plate centred between the two axes
    post_base = round(plate_t + GAP, 3)
    post_h = round(pulley_z0 - GAP - post_base, 2)
    if plate_l > 240.0:
        raise ValueError("bracket plate over 240 mm")

    builder = Builder("motorbelt", variant, "Motor belt drive")
    builder.add(
        P.plate(
            "base_plate",
            plate_l,
            plate_w,
            plate_t,
            ru_note=f"плита-кронштейн {P.num(plate_l)} x {P.num(plate_w)} x {P.num(plate_t)} мм",
            en_note=f"bracket plate {P.num(plate_l)} x {P.num(plate_w)} x {P.num(plate_t)} mm",
        ),
        t=(plate_cx, 0.0, 0.0),
    )
    builder.add(
        P2.motor_body("motor", motor_l, motor_w, motor_h, boss_l, boss_d),
        axis="y",
        angle=270.0,
        t=(0.0, 0.0, motor_tz),
    )
    builder.add(
        P.shaft("drive_shaft", shaft_d, round(pulley_h - 1.0, 2)),
        t=(0.0, 0.0, round(pulley_z0 + 0.5 + (pulley_h - 1.0) / 2, 3)),
    )
    builder.add(
        P.pulley("pulley_drive", pulley_od, bore, pulley_h, 2.0, hub_d),
        t=(0.0, 0.0, pulley_z0),
    )
    builder.add(
        P2.box_post("idler_post", post_side, post_h),
        t=(span, 0.0, post_base),
    )
    builder.add(
        P.shaft("driven_shaft", shaft_d, round(pulley_h - 1.0, 2)),
        t=(span, 0.0, round(pulley_z0 + 0.5 + (pulley_h - 1.0) / 2, 3)),
    )
    builder.add(
        P.pulley("pulley_driven", pulley_od, bore, pulley_h, 2.0, hub_d),
        t=(span, 0.0, pulley_z0),
    )
    builder.add(
        P2.racetrack_belt("drive_belt", r_out, belt_t, span, belt_w),
        t=(0.0, 0.0, belt_z0),
    )
    builder.note(
        f"Межосевое расстояние {P.num(span)} мм, ремень огибает оба шкива",
        f"Centre distance {P.num(span)} mm, the belt wraps both pulleys",
    )
    return builder.finish(
        rng,
        "ремённая передача: мотор на кронштейне, два шкива и плоский ремень",
        "a belt drive: motor on a bracket, two pulleys and a flat belt",
        f"span {span:g} mm, pulleys d{pulley_od:g}, belt {belt_w:g} mm wide",
    )


# ---------------------------------------------------------------------------
# 3. flange + gasket + cover + N bolts on a circle (one bolt module, N calls)
# ---------------------------------------------------------------------------

RU_COUNTS = {4: "четыре", 8: "восемь"}
EN_COUNTS = {4: "four", 8: "eight"}


def build_flangebolt(index: int) -> Scene:
    rng = Rng("asm2_flangebolt", index)
    count = int(rng.choice((4.0, 8.0)))
    variant = "four_bolt" if count == 4 else "eight_bolt"
    flange_od = rng.grid([80.0, 100.0, 120.0])
    flange_h = rng.grid([8.0, 10.0, 12.0])
    bore = rng.grid([30.0, 40.0, 50.0])
    gasket_t = rng.grid([1.5, 2.0])
    cover_t = rng.grid([8.0, 10.0, 12.0])
    shank_d = rng.grid([6.0, 8.0, 10.0])
    head_d = round(shank_d + 6.0, 2)
    head_h = round(0.7 * shank_d, 2)
    hole_d = round(shank_d + FIT, 2)

    max_r = flange_od / 2 - head_d / 2 - 1.5
    min_r = bore / 2 + FIT / 2 + head_d / 2 + 0.3
    min_r = max(min_r, (head_d + 0.2) / (2 * math.sin(math.pi / count)) + head_d / 2)
    if min_r > max_r:
        raise ValueError("no bolt circle fits this flange")
    radius = round(min_r + (max_r - min_r) * rng.uniform(0.2, 0.8), 2)

    gasket_z = flange_h + GAP
    cover_z = round(gasket_z + gasket_t + GAP, 3)
    bolt_z = round(cover_z + cover_t + GAP, 3)
    shank_l = round(cover_t - 0.5, 2)

    builder = Builder("flangebolt", variant, "Bolted flange stack")
    builder.add(
        P.ring("flange_base", flange_od, bore, flange_h, "нижний фланец", "bottom flange"),
        t=(0.0, 0.0, 0.0),
    )
    builder.add(
        P.ring(
            "gasket",
            round(flange_od - 4.0, 2),
            round(bore + FIT, 2),
            gasket_t,
            "прокладка",
            "gasket",
        ),
        t=(0.0, 0.0, round(gasket_z, 3)),
    )
    holes = []
    for step in range(count):
        angle = math.radians(360.0 * step / count)
        holes.append((round(radius * math.cos(angle), 3), round(radius * math.sin(angle), 3)))
    builder.add(
        P.cover(
            "flange_cover",
            flange_od,
            cover_t,
            holes=holes,
            hole_d=hole_d,
            bore=round(bore + FIT, 2),
            ru_note=(
                f"крышка d{P.num(flange_od)} толщиной {P.num(cover_t)} мм с центральным отверстием "
                f"d{P.num(round(bore + FIT, 2))} и {RU_COUNTS[count]} отверстиями d{P.num(hole_d)} "
                f"по окружности радиусом {P.num(radius)} мм"
            ),
            en_note=(
                f"cover d{P.num(flange_od)}, {P.num(cover_t)} mm thick, d{P.num(round(bore + FIT, 2))} "
                f"centre bore and {EN_COUNTS[count]} d{P.num(hole_d)} holes on a {P.num(radius)} mm "
                f"radius circle"
            ),
        ),
        t=(0.0, 0.0, cover_z),
    )
    for step in range(count):
        angle = math.radians(360.0 * step / count)
        x = round(radius * math.cos(angle), 3)
        y = round(radius * math.sin(angle), 3)
        builder.add(
            P.bolt("flange_bolt", shank_d, shank_l, head_d, head_h),
            t=(x, y, bolt_z),
            feature=step == 0,
        )
    builder.note(
        f"{RU_COUNTS[count].capitalize()} болта d{P.num(shank_d)} стоят по окружности радиусом {P.num(radius)} мм, один модуль на все",
        f"{EN_COUNTS[count].capitalize()} d{P.num(shank_d)} bolts on a {P.num(radius)} mm radius circle, one shared module",
    )
    return builder.finish(
        rng,
        "фланцевый пакет: фланец, прокладка, крышка и болты по окружности",
        "a flange stack: flange, gasket, cover and a bolt circle",
        f"flange d{flange_od:g}, {count} bolts d{shank_d:g} on r{radius:g}",
    )


# ---------------------------------------------------------------------------
# 4. frame cube: base frame + four posts (one module) + top frame
# ---------------------------------------------------------------------------


def build_framecube(index: int) -> Scene:
    rng = Rng("asm2_framecube", index)
    square = rng.random.random() < 0.5 if hasattr(rng, "random") else rng.uniform(0.0, 1.0) < 0.5
    variant = "square_posts" if square else "round_posts"
    base_l = rng.grid([120.0, 140.0, 160.0])
    base_w = rng.grid([90.0, 100.0, 120.0])
    base_t = rng.grid([12.0, 14.0, 16.0])
    top_t = rng.grid([10.0, 12.0])
    post_h = rng.grid([50.0, 60.0, 80.0, 100.0])
    margin = rng.grid([12.0, 14.0, 16.0])

    if square:
        post_side = rng.grid([12.0, 14.0, 16.0])
        socket_d = round(post_side * math.sqrt(2.0) + FIT, 2)
    else:
        post_side = rng.grid([12.0, 14.0, 16.0])
        socket_d = round(post_side + FIT, 2)
    socket_depth = round(base_t / 2, 2)
    sx = round(base_l / 2 - margin, 3)
    sy = round(base_w / 2 - margin, 3)
    if sx - socket_d / 2 < 1.2 or sy - socket_d / 2 < 1.2:
        raise ValueError("socket breaks the frame wall")
    win_x = round(2 * (sx - socket_d / 2 - 2.0), 2)
    win_y = round(2 * (sy - socket_d / 2 - 2.0), 2)
    if win_x < 20.0 or win_y < 20.0:
        raise ValueError("window too small")

    corners = [(-sx, -sy), (sx, -sy), (-sx, sy), (sx, sy)]
    post_z0 = round(base_t - socket_depth + GAP, 3)
    top_z0 = round(post_z0 + post_h + GAP, 3)
    top_l = round(base_l - rng.grid([0.0, 10.0]), 2)
    top_w = round(base_w - rng.grid([0.0, 10.0]), 2)
    top_win_x = round(min(win_x, 2 * (sx - 3.0)), 2)
    top_win_y = round(min(win_y, 2 * (sy - 3.0)), 2)
    if top_l / 2 < sx + 1.2 or top_w / 2 < sy + 1.2:
        raise ValueError("top frame does not cover the posts")

    builder = Builder("framecube", variant, "Frame cube")
    builder.add(
        P.frame_plate(
            "base_frame",
            base_l,
            base_w,
            base_t,
            (win_x, win_y),
            corners,
            socket_d,
            socket_depth,
            ru_note=(
                f"нижняя рама {P.num(base_l)} x {P.num(base_w)} x {P.num(base_t)} мм с окном "
                f"{P.num(win_x)} x {P.num(win_y)} мм и гнёздами d{P.num(socket_d)} глубиной {P.num(socket_depth)} мм"
            ),
            en_note=(
                f"base frame {P.num(base_l)} x {P.num(base_w)} x {P.num(base_t)} mm, window "
                f"{P.num(win_x)} x {P.num(win_y)} mm, d{P.num(socket_d)} sockets {P.num(socket_depth)} mm deep"
            ),
        ),
        t=(0.0, 0.0, 0.0),
    )
    post_name = "corner_post"
    for position, (x, y) in enumerate(corners):
        if square:
            spec = P2.box_post(post_name, post_side, post_h)
        else:
            spec = P.post(post_name, post_side, post_h)
        builder.add(spec, t=(x, y, post_z0), feature=position == 0)
    builder.add(
        P.frame_plate(
            "top_frame",
            top_l,
            top_w,
            top_t,
            (top_win_x, top_win_y),
            [],
            0.0,
            0.0,
            ru_note=(
                f"верхняя рама {P.num(top_l)} x {P.num(top_w)} x {P.num(top_t)} мм "
                f"с окном {P.num(top_win_x)} x {P.num(top_win_y)} мм"
            ),
            en_note=(
                f"top frame {P.num(top_l)} x {P.num(top_w)} x {P.num(top_t)} mm "
                f"with a {P.num(top_win_x)} x {P.num(top_win_y)} mm window"
            ),
        ),
        t=(0.0, 0.0, top_z0),
    )
    builder.note(
        "Стойки входят в гнёзда с зазором, верхняя рама ложится на стойки сверху",
        "The posts drop into the sockets with clearance, the top frame rests on them",
    )
    return builder.finish(
        rng,
        "рамный куб: основание, стойки и верхняя рама",
        "a frame cube: base, corner posts and a top frame",
        f"base {base_l:g} x {base_w:g} mm, posts {post_h:g} mm tall",
    )


# ---------------------------------------------------------------------------
# 5. trolley: fork + two wheels (one module) + axle
# ---------------------------------------------------------------------------


def build_cartwheel(index: int) -> Scene:
    rng = Rng("asm2_cartwheel", index)
    variant = rng.choice(("small_wheels", "big_wheels", "tall_fork"))
    wheel_od = rng.grid([40.0, 50.0]) if variant != "big_wheels" else rng.grid([60.0, 70.0])
    wheel_t = rng.grid([10.0, 12.0])
    axle_d = rng.grid([8.0, 10.0, 12.0])
    leg_t = round(axle_d + FIT + 4.0, 2)  # 2 mm wall around the bore minimum
    leg_l = round(wheel_od + rng.grid([10.0, 16.0]), 2)
    gap_y = round(2 * wheel_t + 3 * GAP + rng.grid([1.0, 2.0]), 2)
    axle_z = round(wheel_od / 2 + rng.grid([8.0, 12.0, 16.0]), 2)
    height = round(axle_z + wheel_od / 2 + rng.grid([8.0, 12.0]), 2)
    if variant == "tall_fork":
        height = round(height + 20.0, 2)
    bridge_t = rng.grid([8.0, 10.0])
    axle_bore = round(axle_d + FIT, 2)
    if axle_z - axle_d / 2 < 1.2 or height - axle_z - axle_d / 2 < 1.2:
        raise ValueError("axle bore breaks the fork leg")
    axle_l = round(gap_y + 2 * leg_t - 2.0, 2)

    builder = Builder("cartwheel", variant, "Trolley wheel set")
    builder.add(
        P2.fork("trolley_fork", leg_l, leg_t, gap_y, height, bridge_t, axle_bore, axle_z),
        t=(0.0, 0.0, 0.0),
    )
    # wheels stand in the XZ plane, one behind the other along Y between the legs
    near_y = round(-gap_y / 2 + GAP + wheel_t, 3)  # local z spans [-wheel_t, 0] -> +Y
    far_y = round(gap_y / 2 - GAP, 3)
    for position, wheel_y in enumerate((near_y, far_y)):
        builder.add(
            P.ring(
                "trolley_wheel",
                wheel_od,
                axle_bore,
                wheel_t,
                "колесо тележки",
                "trolley wheel",
            ),
            axis="x",
            angle=90.0,
            t=(0.0, wheel_y, axle_z),
            feature=position == 0,
        )
    builder.add(
        P.shaft("trolley_axle", axle_d, axle_l),
        axis="x",
        angle=90.0,
        t=(0.0, 0.0, axle_z),
    )
    builder.note(
        f"Два колеса d{P.num(wheel_od)} сидят на общей оси d{P.num(axle_d)} между щёк вилки",
        f"Both d{P.num(wheel_od)} wheels share the d{P.num(axle_d)} axle between the fork legs",
    )
    return builder.finish(
        rng,
        "тележка: вилка, два колеса и ось",
        "a trolley: fork, two wheels and an axle",
        f"wheels d{wheel_od:g}, fork {height:g} mm tall",
    )


# ---------------------------------------------------------------------------
# 6. hinge: base leaf + moving leaf + pin, swung 0/45/90 degrees
# ---------------------------------------------------------------------------


def build_hinge(index: int) -> Scene:
    rng = Rng("asm2_hinge", index)
    angle = rng.choice((0.0, 45.0, 270.0))
    variant = {0.0: "closed", 45.0: "half_open", 270.0: "open"}[angle]
    length = rng.grid([60.0, 80.0, 100.0])
    base_w = rng.grid([30.0, 40.0, 50.0])
    leaf_w = rng.grid([30.0, 40.0, 50.0])
    pin_d = rng.grid([4.0, 5.0, 6.0])
    thickness = round(pin_d + 4.0, 2)  # 1.6 mm wall around the pin bore
    bore = round(pin_d + FIT, 2)
    lug = rng.grid([10.0, 12.0, 14.0])
    knuckle_r = lug
    knuckle_gap = 0.3
    knuckle_w = round((length - 6 * knuckle_gap) / 4, 2)
    if knuckle_w < 8.0:
        raise ValueError("knuckles too narrow")
    half = length / 2
    base_slots = [
        (-half, -half + knuckle_w),
        (-knuckle_w / 2, knuckle_w / 2),
        (half - knuckle_w, half),
    ]
    leaf_slots = [
        (-half + knuckle_w + knuckle_gap, -knuckle_w / 2 - knuckle_gap),
        (knuckle_w / 2 + knuckle_gap, half - knuckle_w - knuckle_gap),
    ]
    if leaf_slots[0][1] - leaf_slots[0][0] < 5.0:
        raise ValueError("leaf knuckles too narrow")
    # head inner face sits GAP outside the end tooth: parts2 heads span
    # [-Lp/2 - head_h, -Lp/2 + 1], so -Lp/2 + 1 = -L/2 - GAP
    pin_l = round(length + 2.0 * GAP + 2.0, 2)
    head_d = round(pin_d + 4.0, 2)
    head_h = 3.0

    builder = Builder("hinge", variant, "Butt hinge")
    builder.add(
        P2.hinge_half(
            "hinge_base",
            length,
            base_w,
            thickness,
            lug,
            bore,
            base_slots,
            +1,
            "нижняя створка петли",
            "hinge base leaf",
        ),
        t=(0.0, 0.0, knuckle_r),
    )
    builder.add(
        P2.hinge_half(
            "hinge_mover",
            length,
            leaf_w,
            thickness,
            lug,
            bore,
            leaf_slots,
            -1,
            "подвижная створка петли",
            "moving hinge leaf",
        ),
        axis="x",
        angle=angle,
        t=(0.0, 0.0, knuckle_r),
    )
    pin_spec = P.pin("hinge_pin", pin_d, pin_l, head_d, head_h)
    pin_spec.volume = (
        P.disc_area(pin_d) * (pin_l - 1.0) + P.disc_area(head_d) * (head_h + 1.0)
    )
    builder.add(pin_spec, t=(0.0, 0.0, knuckle_r))
    ru_angle = {0.0: "створки закрыты (0 градусов)", 45.0: "створка открыта на 45 градусов",
                270.0: "створка открыта на 90 градусов"}[angle]
    en_angle = {0.0: "leaves closed at 0 degrees", 45.0: "moving leaf swung 45 degrees open",
                270.0: "moving leaf swung 90 degrees open"}[angle]
    builder.note(ru_angle.capitalize(), en_angle.capitalize())
    return builder.finish(
        rng,
        "петля: две створки на общем пальце",
        "a butt hinge: two leaves on one pin",
        f"hinge {length:g} mm, leaf swung {angle:g} deg",
    )


FAMILY_BUILDERS = {
    "shaftstation": build_shaftstation,
    "motorbelt": build_motorbelt,
    "flangebolt": build_flangebolt,
    "framecube": build_framecube,
    "cartwheel": build_cartwheel,
    "hinge": build_hinge,
}
