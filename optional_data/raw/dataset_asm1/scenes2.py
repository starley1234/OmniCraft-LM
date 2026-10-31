"""Scene templates for the asm1 corpus: 10 families, 2-6 parts each.

Every template draws a few grid dimensions, builds each part as its own
argument-less module, and places the parts with explicit ``translate`` and
``rotate`` calls inside ``assembly()``.  The placement arithmetic below is
deliberate: every mating pair is built with a known design gap (``GAP`` axially,
``FIT`` diametrically) so the audit's ``min_gap`` check has both a floor and a
margin.
"""

from __future__ import annotations

import math
from dataclasses import dataclass, field

from tools.dataset_asm1 import parts2 as P
from tools.dataset_asm1.core2 import ASSEMBLY_MARKER, Node, Scene, box_size, union_bounds
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
    "Сделай сборочную модель:",
    "Собери узел для проверки компоновки:",
    "Смоделируй узел:",
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
)
EN_TAIL_FIXED = (
    "The parts must not intersect, keep the fits loose.",
    "Assemble with clearance, no overlapping parts.",
    "No interference fits: leave a gap between the parts.",
    "One module per part, no parts may touch.",
)


def _round(value: float, digits: int = 2) -> float:
    return round(value + 0.0, digits)


@dataclass
class Builder:
    """Collects the nodes of one scene and renders it."""

    family: str
    variant: str
    title: str
    nodes: list[Node] = field(default_factory=list)
    ru_features: list[str] = field(default_factory=list)
    en_features: list[str] = field(default_factory=list)

    def add(self, spec: P.PartSpec, axis: str = "z", angle: float = 0.0, t=(0.0, 0.0, 0.0)) -> P.PartSpec:
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
        self.ru_features.append(spec.ru)
        self.en_features.append(spec.en)
        return spec

    def finish(self, rng: Rng, noun_ru: str, noun_en: str, summary: str = "") -> Scene:
        box = union_bounds([node.world_bounds for node in self.nodes])
        bbox = box_size(box)
        code = render_scene(self.title, summary, [node.source for node in self.nodes], [node.call for node in self.nodes])
        parameters: dict[str, float] = {"parts": float(len(self.nodes))}
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


def render_scene(title: str, summary: str, modules: list[str], calls: list[str]) -> str:
    body = ["$fn = 32;", ""]
    body.append("// " + "-" * 72)
    body.append(f"// {title}" + (f": {summary}" if summary else ""))
    body.append("// Every part is its own module, assembly() places them once.")
    body.append("// " + "-" * 72)
    for index, source in enumerate(modules):
        body.append("")
        body.append(f"// --- part {index + 1} ---")
        body.append(source.strip("\n"))
    body.append("")
    body.append(ASSEMBLY_MARKER)
    body.append("module assembly() {")
    for call in calls:
        body.append(f"  {call}")
    body.append("}")
    body.append("")
    body.append("assembly();")
    return "\n".join(body).rstrip() + "\n"


# ---------------------------------------------------------------------------
# fastener helpers
# ---------------------------------------------------------------------------

NUT_TABLE = {6.0: 10.0, 8.0: 13.0, 10.0: 17.0, 12.0: 19.0}


def fastener(rng: Rng, shank_d: float) -> dict[str, float]:
    """Head, hole and nut sizes that go with a shank diameter."""
    return {
        "shank_d": shank_d,
        "head_d": round(shank_d + 6.0, 2),
        "head_h": round(0.7 * shank_d, 2),
        "hole_d": round(shank_d + FIT, 2),
        "nut_af": NUT_TABLE.get(shank_d, round(shank_d * 1.7, 1)),
        "nut_h": round(0.8 * shank_d, 2),
        "washer_od": round(shank_d + 8.0, 2),
    }


# ---------------------------------------------------------------------------
# 1. bolted plate
# ---------------------------------------------------------------------------


def build_boltplate(index: int) -> Scene:
    rng = Rng("asm1_boltplate", index)
    variant = rng.choice(("pair", "pair", "pair", "trio"))
    plate_l = rng.grid([90.0, 110.0, 130.0, 150.0, 170.0])
    plate_w = rng.grid([60.0, 70.0, 80.0])
    thickness = rng.grid([6.0, 8.0, 10.0, 12.0])
    shank_d = rng.grid([6.0, 8.0, 10.0])
    kit = fastener(rng, shank_d)
    head_d, hole_d = kit["head_d"], kit["hole_d"]

    if variant == "trio":
        hx = round(max(head_d + 6.0, plate_l * 0.3), 2)
        hx = min(hx, plate_l / 2 - (head_d / 2 + 3.0))
        centres = [(-hx, 0.0), (0.0, 0.0), (hx, 0.0)]
        part_count = 3
    else:
        hx = round(max(head_d + 6.0, plate_l * 0.28), 2)
        hx = min(hx, plate_l / 2 - (head_d / 2 + 3.0))
        centres = [(-hx, 0.0), (hx, 0.0)]
        part_count = 2

    builder = Builder("boltplate", variant, "Bolted plate")
    plate = P.plate(
        "plate",
        plate_l,
        plate_w,
        thickness,
        holes=centres,
        hole_d=hole_d,
        ru_note=f"плита {P.num(plate_l)} x {P.num(plate_w)} x {P.num(thickness)} мм с {len(centres)} отверстиями d{P.num(hole_d)}",
        en_note=f"plate {P.num(plate_l)} x {P.num(plate_w)} x {P.num(thickness)} mm with {len(centres)} d{P.num(hole_d)} holes",
    )
    builder.add(plate)
    for position, (x, y) in enumerate(centres, start=1):
        name = f"bolt{position}" if part_count > 1 else "bolt"
        spec = P.bolt(name, shank_d, thickness + 14.0, head_d, kit["head_h"])
        builder.add(spec, t=(x, y, thickness + GAP))
    if variant != "trio":
        for position, (x, y) in enumerate(centres, start=1):
            spec = P.hexnut(f"nut{position}", kit["nut_af"], kit["nut_h"], hole_d)
            builder.add(spec, t=(x, y, -GAP - kit["nut_h"]))
    return builder.finish(
        rng,
        "плита с болтами",
        "bolted plate",
        f"{plate_l:g} x {plate_w:g} x {thickness:g} mm plate, {len(centres)} fasteners",
    )


# ---------------------------------------------------------------------------
# 2. bearing housing
# ---------------------------------------------------------------------------


def build_shaftbearings(index: int) -> Scene:
    rng = Rng("asm1_shaftbearings", index)
    variant = rng.choice(("stack", "stack", "deephousing"))
    shaft_d = rng.grid([10.0, 12.0, 15.0, 16.0, 20.0])
    cup_od = rng.grid([60.0, 70.0, 80.0])
    wall = rng.choice((5.0, 6.0))
    base = rng.grid([8.0, 10.0, 12.0])
    bearing_w = rng.grid([10.0, 12.0])
    cup_bore = cup_od - 2 * wall
    bearing_od = round(cup_bore - FIT, 2)
    height = round(max(base + bearing_w + 6.0, rng.grid([45.0, 55.0, 65.0])), 2)
    centre_hole = round(shaft_d + FIT, 2)

    builder = Builder("shaftbearings", variant, "Bearing housing")
    builder.add(P.cup("housing", cup_od, wall, height, base, centre_hole))
    bearing1_z = round(base + GAP, 3)
    bearing2_z = round(height + GAP, 3)
    builder.add(P.ring("bearing_lower", bearing_od, centre_hole, bearing_w, "подшипник", "bearing"), t=(0, 0, bearing1_z))
    builder.add(P.ring("bearing_upper", bearing_od, centre_hole, bearing_w, "подшипник", "bearing"), t=(0, 0, bearing2_z))
    spacer_od = round(bearing_od - 6.0, 2)
    spacer_h = rng.grid([8.0, 10.0, 12.0])
    spacer_z = round(bearing2_z + bearing_w + GAP, 3)
    builder.add(P.ring("spacer", spacer_od, centre_hole, spacer_h, "распорное кольцо", "spacer ring"), t=(0, 0, spacer_z))
    shaft_bottom = round(base * 0.5, 2)
    shaft_top = round(spacer_z + spacer_h + 12.0, 2)
    shaft_l = round(shaft_top - shaft_bottom, 2)
    builder.add(P.shaft("shaft", shaft_d, shaft_l), t=(0, 0, round((shaft_bottom + shaft_top) / 2, 3)))
    return builder.finish(
        rng,
        "корпус с подшипниками и валом",
        "bearing housing with a shaft",
        f"housing d{cup_od:g}, two bearings and a shaft",
    )


# ---------------------------------------------------------------------------
# 3. bolted bracket
# ---------------------------------------------------------------------------


def build_bracketbolts(index: int) -> Scene:
    rng = Rng("asm1_bracketbolts", index)
    variant = rng.choice(("single_bolt", "two_bolts", "two_bolts"))
    base_l = rng.grid([80.0, 100.0, 120.0])
    base_w = rng.grid([50.0, 60.0, 70.0])
    thickness = rng.grid([8.0, 10.0])
    leg_h = rng.grid([60.0, 75.0, 90.0])
    shank_d = rng.grid([6.0, 8.0, 10.0])
    kit = fastener(rng, shank_d)
    hole_d = kit["hole_d"]
    leg_t = round(thickness + 4.0, 2)

    z1 = round(max(thickness + hole_d / 2 + 4.0, rng.grid([28.0, 32.0, 36.0])), 2)
    z1 = min(z1, leg_h - hole_d / 2 - 4.0)
    heights = [z1]
    if variant == "two_bolts":
        z2 = round(z1 + max(hole_d + 8.0, kit["head_d"] + 4.0), 2)
        if z2 <= leg_h - hole_d / 2 - 4.0:
            heights.append(z2)

    washer_t = 2.0
    nut_h = kit["nut_h"]
    shank_l = round(leg_t + GAP + washer_t + GAP + nut_h * 0.7 + 4.0, 2)
    with_nut = variant == "single_bolt"

    builder = Builder("bracketbolts", variant, "Bolted bracket")
    builder.add(
        P.bracket(
            "bracket",
            base_l,
            base_w,
            thickness,
            leg_h,
            leg_t,
            hole_d,
            heights,
            ru_note=f"уголок {P.num(base_l)} x {P.num(base_w)} мм, основание {P.num(thickness)} мм, полка {P.num(leg_h)} x {P.num(leg_t)} мм",
            en_note=f"L bracket {P.num(base_l)} x {P.num(base_w)} mm, {P.num(thickness)} mm base, {P.num(leg_h)} x {P.num(leg_t)} mm leg",
        )
    )
    for position, hole_z in enumerate(heights, start=1):
        suffix = "" if len(heights) == 1 else str(position)
        builder.add(
            P.bolt(f"bolt{suffix}", shank_d, shank_l, kit["head_d"], kit["head_h"]),
            axis="y",
            angle=90.0,
            t=(round(base_l / 2 + GAP, 3), 0.0, hole_z),
        )
        washer_x = round(base_l / 2 - leg_t - GAP - washer_t, 3)
        builder.add(
            P.washer(f"washer{suffix}", round(kit["head_d"] + 2.0, 2), hole_d, washer_t),
            axis="y",
            angle=90.0,
            t=(washer_x, 0.0, hole_z),
        )
        if with_nut:
            nut_x = round(base_l / 2 - leg_t - GAP - washer_t - GAP - nut_h, 3)
            builder.add(
                P.hexnut(f"nut{suffix}", kit["nut_af"], nut_h, hole_d),
                axis="y",
                angle=90.0,
                t=(nut_x, 0.0, hole_z),
            )
    return builder.finish(
        rng,
        "уголок с болтами",
        "bolted bracket",
        f"{base_l:g} x {base_w:g} mm bracket with {len(heights)} bolt joints",
    )


# ---------------------------------------------------------------------------
# 4. flange stack
# ---------------------------------------------------------------------------


def build_flangelayers(index: int) -> Scene:
    rng = Rng("asm1_flangelayers", index)
    variant = rng.choice(("four_holes", "six_holes", "six_holes"))
    outer_d = rng.grid([110.0, 130.0, 150.0, 170.0])
    flange_t = rng.grid([12.0, 14.0, 16.0])
    cover_t = rng.grid([8.0, 10.0])
    gasket_t = 3.0
    bolt_d = rng.grid([8.0, 10.0, 12.0])
    kit = fastener(rng, bolt_d)
    hole_d, nut_af, nut_h = kit["hole_d"], kit["nut_af"], kit["nut_h"]
    head_d, head_h = kit["head_d"], kit["head_h"]
    # the bolt circle has to sit in the wall: keep 4 mm of metal on both sides
    bore_high = outer_d - 2.0 * hole_d - 16.0
    bore = round(max(25.0, min(rng.grid([50.0, 60.0, 80.0]), bore_high)), 2)
    pcd = round((bore + outer_d) / 2, 2)
    count = 4 if variant == "four_holes" else 6
    if pcd * math.sin(math.pi / count) < hole_d + 6.0:
        count = 4
    positions = [
        (round(pcd / 2 * math.cos(2 * math.pi * slot / count), 3), round(pcd / 2 * math.sin(2 * math.pi * slot / count), 3))
        for slot in range(count)
    ]
    bolt_position = positions[0]

    gasket_z = round(flange_t + GAP, 3)
    cover_z = round(gasket_z + gasket_t + GAP, 3)
    cover_top = round(cover_z + cover_t, 3)
    shank_l = round(cover_top + GAP + 24.0, 2)

    builder = Builder("flangelayers", variant, "Flange with gasket and cover")
    builder.add(
        P.cover(
            "flange",
            outer_d,
            flange_t,
            positions,
            hole_d,
            bore,
            ru_note=f"фланец d{P.num(outer_d)} x {P.num(flange_t)} мм, отверстие d{P.num(bore)}, {count} отверстий d{P.num(hole_d)} по окружности {P.num(pcd)} мм",
            en_note=f"flange d{P.num(outer_d)} x {P.num(flange_t)} mm, d{P.num(bore)} bore, {count} d{P.num(hole_d)} holes on a {P.num(pcd)} mm circle",
        )
    )
    builder.add(
        P.cover(
            "gasket",
            outer_d,
            gasket_t,
            positions,
            hole_d,
            bore,
            ru_note=f"прокладка d{P.num(outer_d)} x {P.num(gasket_t)} мм с тем же рисунком отверстий",
            en_note=f"gasket d{P.num(outer_d)} x {P.num(gasket_t)} mm with the same hole pattern",
        ),
        t=(0, 0, gasket_z),
    )
    builder.add(
        P.cover(
            "cover",
            outer_d,
            cover_t,
            positions,
            hole_d,
            bore,
            ru_note=f"крышка d{P.num(outer_d)} x {P.num(cover_t)} мм с {count} отверстиями d{P.num(hole_d)}",
            en_note=f"cover d{P.num(outer_d)} x {P.num(cover_t)} mm with {count} d{P.num(hole_d)} holes",
        ),
        t=(0, 0, cover_z),
    )
    builder.add(
        P.bolt("bolt", bolt_d, shank_l, head_d, head_h),
        t=(bolt_position[0], bolt_position[1], round(cover_top + GAP, 3)),
    )
    builder.add(
        P.hexnut("nut", nut_af, nut_h, hole_d),
        t=(bolt_position[0], bolt_position[1], round(-GAP - nut_h, 3)),
    )
    return builder.finish(
        rng,
        "фланцевое соединение с прокладкой",
        "flange joint with a gasket",
        f"d{outer_d:g} flange stack, {count} bolt holes",
    )


# ---------------------------------------------------------------------------
# 5. frame with posts
# ---------------------------------------------------------------------------


def build_frameposts(index: int) -> Scene:
    rng = Rng("asm1_frameposts", index)
    variant = rng.choice(("four_posts", "four_posts", "wide"))
    length = rng.grid([140.0, 160.0, 180.0, 200.0])
    width = rng.grid([100.0, 120.0, 140.0])
    thickness = rng.grid([10.0, 12.0, 14.0])
    post_d = rng.grid([12.0, 16.0, 20.0])
    socket_d = round(post_d + FIT, 2)
    socket_depth = round(min(rng.grid([6.0, 8.0]), thickness - 3.0), 2)
    post_h = rng.grid([40.0, 60.0, 80.0, 100.0])
    window_x_grid = [60.0, 80.0, 100.0] if variant != "wide" else [110.0, 130.0]
    window_x = round(max(30.0, min(rng.grid(window_x_grid), length - 2 * (post_d + 12.0) - 20.0)), 2)
    window_y = round(max(24.0, min(rng.grid([40.0, 50.0, 60.0]), width - 2 * (post_d + 12.0) - 20.0)), 2)

    sx = round(length / 2 - (post_d / 2 + 8.0), 3)
    sy = round(width / 2 - (post_d / 2 + 8.0), 3)
    sockets = [(-sx, -sy), (sx, -sy), (-sx, sy), (sx, sy)]

    builder = Builder("frameposts", variant, "Frame with four posts")
    builder.add(
        P.frame_plate(
            "base_frame",
            length,
            width,
            thickness,
            (window_x, window_y),
            sockets,
            socket_d,
            socket_depth,
            ru_note=f"рамное основание {P.num(length)} x {P.num(width)} x {P.num(thickness)} мм с окном {P.num(window_x)} x {P.num(window_y)} мм",
            en_note=f"frame base {P.num(length)} x {P.num(width)} x {P.num(thickness)} mm with a {P.num(window_x)} x {P.num(window_y)} mm window",
        )
    )
    post_z = round(thickness - socket_depth + GAP, 3)
    for position, (x, y) in enumerate(sockets, start=1):
        builder.add(P.post(f"post{position}", post_d, post_h), t=(x, y, post_z))
    return builder.finish(
        rng,
        "рамное основание со стойками",
        "frame base with posts",
        f"{length:g} x {width:g} mm frame, four d{post_d:g} posts",
    )


# ---------------------------------------------------------------------------
# 6. pulley on a shaft between two bearings blocks
# ---------------------------------------------------------------------------


def build_pulleybelt(index: int) -> Scene:
    rng = Rng("asm1_pulleybelt", index)
    variant = rng.choice(("belt", "belt", "narrow_belt"))
    block_l = 40.0
    block_w = rng.grid([50.0, 60.0, 70.0])
    block_h = rng.grid([56.0, 66.0, 76.0])
    shaft_d = rng.grid([12.0, 15.0, 16.0, 20.0])
    bore = round(shaft_d + FIT, 2)
    bore_z = round(block_h * 0.6, 2)
    pulley_h = rng.grid([24.0, 28.0, 32.0])
    flange_h = rng.choice((5.0, 6.0))
    hub_d = round(shaft_d + rng.grid([10.0, 14.0, 18.0]), 2)
    pulley_od = round(min(rng.grid([60.0, 70.0, 80.0]), 2 * bore_z - 1.0), 2)
    belt_w = round(pulley_h - 2 * flange_h - 2 * GAP, 2)
    belt_id = round(hub_d + 2 * GAP, 2)
    belt_od = round(min(hub_d + (8.0 if variant != "narrow_belt" else 5.0), pulley_od - 2 * GAP), 2)

    pulley_x = round(block_l / 2 + GAP, 3)
    block2_x = round(pulley_x + pulley_h + GAP + block_l / 2, 3)
    belt_x = round(pulley_x + flange_h + GAP, 3)
    shaft_start = round(-block_l / 2 - 12.0, 2)
    shaft_end = round(block2_x + block_l / 2 + 12.0, 2)
    shaft_l = round(shaft_end - shaft_start, 2)

    builder = Builder("pulleybelt", variant, "Pulley assembly")
    for position, t_x in enumerate((0.0, block2_x), start=1):
        builder.add(
            P.block(
                f"support{position}",
                block_l,
                block_w,
                block_h,
                bore,
                bore_z,
                ru_note=f"стойка {P.num(block_l)} x {P.num(block_w)} x {P.num(block_h)} мм с расточкой d{P.num(bore)} по оси X на высоте {P.num(bore_z)} мм",
                en_note=f"support {P.num(block_l)} x {P.num(block_w)} x {P.num(block_h)} mm bored d{P.num(bore)} along X at {P.num(bore_z)} mm",
            ),
            t=(t_x, 0.0, 0.0),
        )
    builder.add(
        P.shaft("shaft", shaft_d, shaft_l),
        axis="y",
        angle=90.0,
        t=(round((shaft_start + shaft_end) / 2, 3), 0.0, bore_z),
    )
    builder.add(
        P.pulley("pulley", pulley_od, bore, pulley_h, flange_h, hub_d),
        axis="y",
        angle=90.0,
        t=(pulley_x, 0.0, bore_z),
    )
    builder.add(
        P.belt("belt", belt_id, belt_od, belt_w),
        axis="y",
        angle=90.0,
        t=(belt_x, 0.0, bore_z),
    )
    return builder.finish(
        rng,
        "шкив на валу между двумя стойками",
        "pulley on a shaft between two supports",
        f"d{pulley_od:g} pulley with a belt, shaft d{shaft_d:g}",
    )


# ---------------------------------------------------------------------------
# 7. standoff columns
# ---------------------------------------------------------------------------


def build_spacercolumns(index: int) -> Scene:
    rng = Rng("asm1_spacercolumns", index)
    variant = rng.choice(("pair", "pair", "single"))
    plate_l = rng.grid([100.0, 120.0, 140.0])
    plate_w = rng.grid([60.0, 70.0, 80.0])
    thickness = rng.grid([6.0, 8.0, 10.0])
    shank_d = rng.grid([6.0, 8.0, 10.0])
    kit = fastener(rng, shank_d)
    hole_d, head_d, head_h = kit["hole_d"], kit["head_d"], kit["head_h"]
    spacer_od = round(shank_d + rng.grid([14.0, 18.0, 22.0]), 2)
    spacer_h = rng.grid([12.0, 16.0, 20.0, 24.0])
    hx = round(min(plate_l / 2 - (spacer_od / 2 + 4.0), max(spacer_od + 8.0, plate_l * 0.32)), 2)
    centres = [(-hx, 0.0)] if variant == "single" else [(-hx, 0.0), (hx, 0.0)]
    spacer_z = round(thickness + GAP, 3)
    bolt_z = round(spacer_z + spacer_h + GAP, 3)
    shank_l = round(thickness + GAP + spacer_h + 8.0, 2)

    builder = Builder("spacercolumns", variant, "Standoff columns")
    builder.add(
        P.plate(
            "base_plate",
            plate_l,
            plate_w,
            thickness,
            holes=centres,
            hole_d=hole_d,
            ru_note=f"основание {P.num(plate_l)} x {P.num(plate_w)} x {P.num(thickness)} мм с {len(centres)} отверстиями d{P.num(hole_d)}",
            en_note=f"base plate {P.num(plate_l)} x {P.num(plate_w)} x {P.num(thickness)} mm with {len(centres)} d{P.num(hole_d)} holes",
        )
    )
    for position, (x, y) in enumerate(centres, start=1):
        suffix = "" if len(centres) == 1 else str(position)
        builder.add(
            P.ring(f"spacer{suffix}", spacer_od, hole_d, spacer_h, "проставка", "standoff spacer"),
            t=(x, y, spacer_z),
        )
        builder.add(
            P.bolt(f"bolt{suffix}", shank_d, shank_l, head_d, head_h),
            t=(x, y, bolt_z),
        )
    return builder.finish(
        rng,
        "проставки на основании",
        "standoffs on a base plate",
        f"{len(centres)} d{spacer_od:g} standoffs, bolts d{shank_d:g}",
    )


# ---------------------------------------------------------------------------
# 8. shaft with rings and collars
# ---------------------------------------------------------------------------


def build_shaftcollars(index: int) -> Scene:
    rng = Rng("asm1_shaftcollars", index)
    variant = rng.choice(("collar_ends", "collar_ends", "collar_middle"))
    shaft_d = rng.grid([15.0, 16.0, 20.0, 25.0])
    bore = round(shaft_d + FIT, 2)
    spacer_od = round(shaft_d + rng.grid([16.0, 20.0, 24.0]), 2)
    spacer_h = rng.grid([10.0, 12.0, 14.0])
    collar_od = round(spacer_od + rng.grid([6.0, 10.0]), 2)
    collar_h = rng.grid([12.0, 16.0])
    set_screw_d = rng.choice((5.0, 6.0))
    stack_x = round(-40.0, 3)
    spans: list[tuple[str, float, float]] = []
    cursor = stack_x
    if variant == "collar_ends":
        spans.append(("collar_a", cursor, collar_h))
        cursor = round(cursor + collar_h + GAP, 3)
    for slot in range(2):
        spans.append((f"spacer_{'ab'[slot]}", cursor, spacer_h))
        cursor = round(cursor + spacer_h + GAP, 3)
    if variant == "collar_ends":
        spans.append(("collar_b", cursor, collar_h))
        cursor = round(cursor + collar_h + GAP, 3)
    else:
        spans.append(("collar_a", cursor, collar_h))
        cursor = round(cursor + collar_h + GAP, 3)
    stack_end = round(cursor - GAP, 3)
    shaft_start = round(stack_x - 14.0, 2)
    shaft_end = round(stack_end + 14.0, 2)
    shaft_l = round(shaft_end - shaft_start, 2)
    bore_z = 0.0

    builder = Builder("shaftcollars", variant, "Shaft with rings and collars")
    builder.add(
        P.shaft("shaft", shaft_d, shaft_l),
        axis="y",
        angle=90.0,
        t=(round((shaft_start + shaft_end) / 2, 3), 0.0, bore_z),
    )
    for name, x, height in spans:
        if name.startswith("collar"):
            builder.add(
                P.collar(name, collar_od, bore, height, set_screw_d),
                axis="y",
                angle=90.0,
                t=(x, 0.0, bore_z),
            )
        else:
            builder.add(
                P.ring(name, spacer_od, bore, height, "проставка", "spacer ring"),
                axis="y",
                angle=90.0,
                t=(x, 0.0, bore_z),
            )
    return builder.finish(
        rng,
        "вал с проставками и кольцами",
        "shaft with spacers and collars",
        f"d{shaft_d:g} shaft, {len(spans)} rings",
    )


# ---------------------------------------------------------------------------
# 9. clevis joint
# ---------------------------------------------------------------------------


def build_clevispin(index: int) -> Scene:
    rng = Rng("asm1_clevispin", index)
    variant = rng.choice(("pinned", "pinned", "pinned_washer"))
    length = rng.grid([50.0, 60.0, 70.0, 80.0])
    width = rng.grid([50.0, 60.0, 70.0])
    height = rng.grid([55.0, 65.0, 75.0])
    base_t = rng.choice((10.0, 12.0))
    slot_w = rng.grid([14.0, 16.0, 18.0])
    pin_d = rng.grid([8.0, 10.0, 12.0])
    pin_hole = round(pin_d + FIT, 2)
    head_d = round(pin_d + 6.0, 2)
    head_h = rng.choice((5.0, 6.0))
    prong_t = round((width - slot_w) / 2, 2)
    eye_t = round(slot_w - 2 * GAP, 2)
    available = height - base_t
    eye_h = round(
        max(
            pin_hole + 8.0,
            min(rng.grid([28.0, 34.0, 40.0]), 2 * (available - GAP - pin_hole / 2 - 4.0)),
        ),
        2,
    )
    eye_len = round(length + rng.grid([20.0, 30.0, 40.0]), 2)
    pin_z = round(base_t + GAP + eye_h / 2, 2)
    pin_len = round(eye_len + 16.0, 2)

    builder = Builder("clevispin", variant, "Clevis joint")
    builder.add(
        P.clevis(
            "clevis",
            length,
            width,
            height,
            slot_w,
            pin_hole,
            pin_z,
            base_t,
            ru_note=f"вилка {P.num(length)} x {P.num(width)} x {P.num(height)} мм, зев {P.num(slot_w)} мм между щеками {P.num(prong_t)} мм, отверстие d{P.num(pin_hole)} по оси Y на высоте {P.num(pin_z)} мм",
            en_note=f"clevis {P.num(length)} x {P.num(width)} x {P.num(height)} mm, {P.num(slot_w)} mm slot between {P.num(prong_t)} mm cheeks, d{P.num(pin_hole)} cross hole on Y at {P.num(pin_z)} mm",
        )
    )
    builder.add(
        P.eye_plate("eye", eye_len, eye_t, eye_h, pin_hole),
        t=(0.0, 0.0, round(base_t + GAP, 3)),
    )
    builder.add(P.pin("pin", pin_d, pin_len, head_d, head_h), axis="z", angle=90.0, t=(0.0, 0.0, pin_z))
    if variant == "pinned_washer":
        builder.add(
            P.washer("retainer", round(head_d, 2), pin_hole, 2.0),
            axis="x",
            angle=90.0,
            # the washer is 2 mm thick, so it clears the pin end by GAP
            t=(0.0, round(pin_len / 2 + GAP + 2.0, 3), pin_z),
        )
    return builder.finish(
        rng,
        "вилка с проушиной на пальце",
        "clevis and eye joint",
        f"{length:g} mm clevis, pin d{pin_d:g}",
    )


# ---------------------------------------------------------------------------
# 10. bushed housing
# ---------------------------------------------------------------------------


def build_bushingpress(index: int) -> Scene:
    rng = Rng("asm1_bushingpress", index)
    variant = rng.choice(("capped", "capped", "with_washer"))
    length = rng.grid([70.0, 80.0, 90.0])
    width = rng.grid([60.0, 70.0, 80.0])
    height = rng.grid([70.0, 80.0])
    bore_d = rng.grid([26.0, 30.0, 34.0])
    bore_z = round(height / 2, 2)
    shaft_d = rng.grid([15.0, 16.0, 20.0])
    bushing_od = round(bore_d - FIT, 2)
    bore = round(shaft_d + FIT, 2)
    bushing_h = round(length - 8.0, 2)
    flange_d = round(bore_d + 12.0, 2)
    flange_h = rng.choice((6.0, 8.0))
    cap_t = rng.grid([8.0, 10.0])
    cap_d = round(min(width, height) - 10.0, 2)

    bushing_x = round(-length / 2 - GAP - flange_h, 3)
    cap_x = round(length / 2 + GAP, 3)
    shaft_start = round(bushing_x - 16.0, 2)
    shaft_end = round(cap_x + cap_t + (GAP + 6.0 if variant == "with_washer" else 16.0), 2)
    shaft_l = round(shaft_end - shaft_start, 2)

    builder = Builder("bushingpress", variant, "Bushed housing")
    builder.add(P.block("housing", length, width, height, bore_d, bore_z))
    builder.add(
        P.bushing("bushing", bushing_od, bore, bushing_h, flange_d, flange_h),
        axis="y",
        angle=90.0,
        t=(bushing_x, 0.0, bore_z),
    )
    builder.add(
        P.shaft("shaft", shaft_d, shaft_l),
        axis="y",
        angle=90.0,
        t=(round((shaft_start + shaft_end) / 2, 3), 0.0, bore_z),
    )
    builder.add(
        P.cover("cover", cap_d, cap_t, [], 0.0, bore),
        axis="y",
        angle=90.0,
        t=(cap_x, 0.0, bore_z),
    )
    if variant == "with_washer":
        builder.add(
            P.washer("washer", round(shaft_d + 12.0, 2), bore, 2.0),
            axis="y",
            angle=90.0,
            t=(round(cap_x + cap_t + GAP, 3), 0.0, bore_z),
        )
    return builder.finish(
        rng,
        "корпус с втулкой и валом",
        "bushed housing with a shaft",
        f"{length:g} x {width:g} x {height:g} mm housing, bushing d{bushing_od:g}",
    )


FAMILY_BUILDERS = {
    "boltplate": build_boltplate,
    "shaftbearings": build_shaftbearings,
    "bracketbolts": build_bracketbolts,
    "flangelayers": build_flangelayers,
    "frameposts": build_frameposts,
    "pulleybelt": build_pulleybelt,
    "spacercolumns": build_spacercolumns,
    "shaftcollars": build_shaftcollars,
    "clevispin": build_clevispin,
    "bushingpress": build_bushingpress,
}

COVERAGE_NOTES = {
    "boltplate": "plate with 2-3 clearance holes, bolts through and nuts below",
    "shaftbearings": "housing cup, two bearings, a spacer ring and a shaft on the same axis",
    "bracketbolts": "L bracket with one or two horizontal bolt joints (washer, optional nut)",
    "flangelayers": "flange, gasket and cover with a common bolt pattern plus one fastener",
    "frameposts": "frame base with a window and four posts standing in clearance sockets",
    "pulleybelt": "two bored supports, a shaft, a flanged pulley and the belt in the groove",
    "spacercolumns": "base plate, one or two standoff spacers and the matching bolts",
    "shaftcollars": "shaft carrying spacer rings and set-screw collars, all turned 90 degrees",
    "clevispin": "clevis, eye lug in the slot and the pin through both, optional retainer",
    "bushingpress": "bored housing, flanged bushing, shaft through it and a bolted cover",
}
