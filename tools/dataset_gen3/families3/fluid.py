"""gen3: cardan crosses, UCP-style bearing blocks, ducts and faired channels.

Both duct families are built as hull chains: a list of station profiles is
hulled pairwise, which produces the smooth bend / fairing without any revolve
or sweep.  The inner (void) chain is strictly inside the outer one and sticks
out 5 mm past both ports, so the port faces are cut cleanly.
"""

from __future__ import annotations

import math

from tools.dataset_gen2.common import Part, Rng, ScadBuilder, fmt
from tools.dataset_gen2.prompts import en_count, ru_count
from tools.dataset_gen3.prompts3 import finish_part3, inch_size
from tools.dataset_gen3.toolkit import bolt_circle, cyl, num



CROSS_RU = ("карданный крест", "крестовина кардана", "крест карданного шарнира", "крестовина с шипами")
CROSS_EN = ("cardan cross", "universal joint spider", "cardan joint cross", "trunnion cross")
BLOCK_RU = ("корпус подшипника", "опора вала типа UCP", "подшипниковый узел", "корпус с постелью под вал")
BLOCK_EN = ("bearing block housing", "UCP style pillow block", "pillow block housing", "split bearing housing")
DUCT_RU = ("воздуховод", "патрубок с плавным изгибом", "гнутый воздуховод", "вентиляционный отвод")
DUCT_EN = ("air duct", "smooth bend duct", "bent duct elbow", "ventilation duct run")
CHAN_RU = ("канал с обтекателями", "обтекаемый канал", "канал воздухозаборника", "короб с обтекаемым концом")
CHAN_EN = ("faired channel", "streamlined channel", "intake fairing duct", "faired duct cover")


def _hull_profiles(profiles: list[str]) -> str:
    """Hull chain over arbitrary 2D profiles (strings)."""
    blocks = []
    for first, second in zip(profiles, profiles[1:]):
        blocks.append("hull() {")
        blocks.append("  " + first)
        blocks.append("  " + second)
        blocks.append("}")
    return "\n".join(blocks)


def _circle(x: float, y: float, r: float) -> str:
    return "translate([%s, %s]) circle(r = %s);" % (num(x, 3), num(y, 3), num(r, 3))


def _hull_circles(stations: list[tuple[float, float, float]]) -> str:
    """2D hull chain of circles: [(x, y, r), ...]."""
    blocks = []
    for first, second in zip(stations, stations[1:]):
        blocks.append("hull() {")
        blocks.append("  translate([%s, %s]) circle(r = %s);" % (num(first[0], 3), num(first[1], 3), num(first[2], 3)))
        blocks.append("  translate([%s, %s]) circle(r = %s);" % (num(second[0], 3), num(second[1], 3), num(second[2], 3)))
        blocks.append("}")
    return "\n".join(blocks)


def _hull_boxes(stations: list[tuple[float, float, float, float]], p: float = 0.4) -> str:
    """3D hull chain of boxes: [(x, width, height, z0), ...] along +x."""
    blocks = []
    for first, second in zip(stations, stations[1:]):
        blocks.append("hull() {")
        for x, w, h, z0 in (first, second):
            blocks.append(
                "  translate([%s, %s, %s]) cube([%s, %s, %s]);"
                % (num(x, 3), num(-w / 2, 3), num(z0, 3), num(p, 3), num(w, 3), num(h, 3))
            )
        blocks.append("}")
    return "\n".join(blocks)


def _arc(centre: tuple[float, float], radius: float, start_deg: float, end_deg: float, count: int) -> list[tuple[float, float]]:
    points = []
    for index in range(count):
        angle = math.radians(start_deg + (end_deg - start_deg) * index / (count - 1))
        points.append((centre[0] + radius * math.cos(angle), centre[1] + radius * math.sin(angle)))
    return points


def build_cardans(index: int) -> Part:
    """Cardan cross: four trunnions with stepped journals around a hub."""
    rng = Rng("gen3_cardans", index)
    variant = rng.choice(("plain", "plain", "keyed"))
    units = inch_size(rng, max_mm=14.0, min_mm=8.0)
    journal_d = units[0] if units else rng.grid([8.0, 10.0, 12.0, 14.0])
    arm_len = rng.grid([26.0, 30.0, 34.0, 38.0])
    hub_d = round(journal_d + rng.grid([6.0, 8.0, 10.0]), 2)
    hub_h = round(journal_d * rng.choice((1.2, 1.4, 1.6)), 2)
    step_r = round(journal_d * 0.34, 2)  # where the trunnion steps down to the journal
    step_d = round(journal_d - rng.grid([2.5, 3.0, 3.5]), 2)
    bore_d = round(max(4.0, journal_d * rng.choice((0.4, 0.5))), 2)
    flat_d = round(rng.grid([1.0, 1.2, 1.5]), 2)
    flat_len = round(arm_len * 0.28, 2)
    total_h = max(hub_h, journal_d, step_d)

    builder = ScadBuilder("Cardan cross", f"{fmt(2 * arm_len)} mm span, {fmt(journal_d)} mm trunnions")
    builder.param("journal_d", journal_d, "trunnion diameter")
    builder.param("arm_len", arm_len, "trunnion length from the centre")
    builder.param("step_r", step_r, "step position from the centre")
    builder.param("step_d", step_d, "journal diameter after the step")
    builder.param("hub_d", hub_d, "hub diameter")
    builder.param("hub_h", hub_h, "hub height")
    builder.param("bore_d", bore_d, "hub bore")
    if variant == "keyed":
        builder.param("flat_d", flat_d, "depth of the journal flat")
        builder.param("flat_len", flat_len, "length of the journal flat")

    lines = [
        "difference() {",
        "  union() {",
        "    /* hub along the joint axis */",
        "    cylinder(h = hub_h, d = hub_d, center = true);",
        "    for (a = [0 : 90 : 270]) rotate([0, 0, a]) {",
        "      /* trunnion, sunk into the hub */",
        "      translate([hub_d / 4, 0, 0]) rotate([0, 90, 0])"
        " cylinder(h = step_r + 2, d = journal_d);",
        "      /* stepped journal out to the tip */",
        "      translate([step_r - 0.5, 0, 0]) rotate([0, 90, 0])"
        " cylinder(h = arm_len + 0.5 - step_r, d = step_d);",
        "    }",
        "  }",
        "  /* lubrication bore through the hub, 2.5 mm clear on both sides */",
        "  translate([0, 0, -hub_h / 2 - 2.5]) cylinder(h = hub_h + 5, d = bore_d);",
    ]
    if variant == "keyed":
        lines.append("  /* machined flat on each journal tip */")
        lines.append("  for (a = [0 : 90 : 270]) rotate([0, 0, a]) {")
        lines.append(
            "    translate([arm_len - flat_len, -step_d, step_d / 2 - flat_d])"
            " cube([flat_len + 0.5, 2 * step_d, flat_d + 2.5]);"
        )
        lines.append("  }")
    lines.append("}")
    builder.section("\n".join(lines))
    code = builder.render()

    bbox = (float(2 * arm_len), float(2 * arm_len), float(total_h))
    features_ru = [
        f"{ru_count(4, 'шип', 'шипа', 'шипов')} диаметром {fmt(journal_d)} мм и длиной {fmt(arm_len)} мм от центра",
        f"ступенчатый шип: с {fmt(step_r)} мм диаметр переходит на {fmt(step_d)} мм",
        f"ступица {fmt(hub_d)} мм с осевым отверстием {fmt(bore_d)} мм",
    ]
    features_en = [
        f"{en_count(4)} trunnions, {fmt(journal_d)} mm diameter, {fmt(arm_len)} mm from the centre",
        f"each trunnion steps from {fmt(journal_d)} mm down to {fmt(step_d)} mm at {fmt(step_r)} mm",
        f"a {fmt(hub_d)} mm hub with a {fmt(bore_d)} mm axial bore",
    ]
    if variant == "keyed":
        features_ru.append(f"лыска {fmt(flat_d)} мм на конце каждого шипа")
        features_en.append(f"a {fmt(flat_d)} mm flat machined on every journal tip")
    return finish_part3(
        rng,
        family="cardans",
        variant=variant,
        code=code,
        bbox=bbox,
        params={"span": 2 * arm_len, "journal_d": journal_d, "wall": step_d, "height": total_h},
        ru_nouns=CROSS_RU,
        en_nouns=CROSS_EN,
        features_ru=features_ru,
        features_en=features_en,
        units=units,
    )


def build_bearingblocks(index: int) -> Part:
    """UCP-style pillow block: base plate, hull foot, round housing and bore."""
    rng = Rng("gen3_bearingblocks", index)
    variant = rng.choice(("plain", "plain", "seated", "grooved"))
    base_w = rng.grid([80.0, 90.0, 100.0])
    base_d = rng.grid([52.0, 60.0, 68.0])
    base_t = rng.grid([8.0, 10.0, 12.0])
    units = inch_size(rng, max_mm=32.0, min_mm=18.0)
    bore_d = units[0] if units else rng.grid([20.0, 25.0, 30.0, 35.0])
    wall = rng.grid([6.0, 7.0, 8.0])
    house_r = round(bore_d / 2 + wall, 2)
    house_len = round(base_d * rng.choice((0.66, 0.72, 0.78)), 2)
    axis_z = round(base_t + house_r - 1.0, 2)
    foot_h = 2.5
    foot_w = round(2 * house_r, 2)
    foot_len = round(max(house_len - 10.0, house_len * 0.6), 2)
    holes_d = rng.grid([9.0, 11.0, 13.0])
    hole_x = round(max(base_w / 2 - rng.grid([12.0, 14.0, 16.0]), house_r + 6.0), 2)
    seat_d = rng.grid([8.0, 10.0, 12.0])
    seat_wall = round(min(wall - 2.5, rng.grid([3.0, 4.0])), 2)
    groove_w = rng.grid([2.4, 3.0, 3.6])
    total_h = round(axis_z + house_r, 2)

    builder = ScadBuilder(
        "Bearing block",
        f"{fmt(base_w)} x {fmt(base_d)} mm base, {fmt(bore_d)} mm bore at {fmt(axis_z)} mm",
    )
    builder.param("base_w", base_w, "base width")
    builder.param("base_d", base_d, "base depth")
    builder.param("base_t", base_t, "base thickness")
    builder.param("bore_d", bore_d, "shaft / bearing bore")
    builder.param("house_r", house_r, "housing outer radius")
    builder.param("house_len", house_len, "housing length along the shaft")
    builder.param("foot_w", foot_w, "foot width under the housing")
    builder.param("foot_len", foot_len, "foot length along the shaft")
    builder.param("axis_z", axis_z, "bore axis height above the base")
    builder.param("holes_d", holes_d, "mounting holes")
    builder.param("hole_x", hole_x, "mounting hole spacing")

    lines = [
        "difference() {",
        "  union() {",
        "    /* base plate with its underside on z = 0 */",
    "    translate([0, 0, base_t / 2]) cube([base_w, base_d, base_t], center = true);",
        "    /* hull foot: a straight web blending into the round housing */",
        "    hull() {",
        "      translate([0, 0, base_t - 0.5]) cube([foot_w, foot_len, 1.6], center = true);",
        "      translate([0, 0, axis_z]) rotate([-90, 0, 0])"
        " cylinder(h = house_len, d = 2 * house_r, center = true);",
        "    }",
        "  }",
        "  /* bore through the housing, 2.5 mm clear on both sides */",
        "  translate([0, 0, axis_z]) rotate([-90, 0, 0])"
        " cylinder(h = house_len + 5, d = bore_d, center = true);",
    ]
    if variant == "seated":
        builder.param("seat_d", seat_d, "bearing seat depth")
        builder.param("seat_wall", seat_wall, "seat wall thickness")
        lines.append("  /* bearing seats, recessed into both ends of the housing */")
        lines.append("  for (sy = [-1, 1]) {")
        lines.append(
            "    translate([0, sy * (house_len / 2 - seat_d + 2.5), axis_z]) rotate([-90, 0, 0])"
            " cylinder(h = seat_d + 5, d = bore_d + 2 * seat_wall);"
        )
        lines.append("  }")
    if variant == "grooved":
        builder.param("groove_w", groove_w, "oil groove width")
        lines.append("  /* oil groove from the top of the housing into the bore */")
        lines.append(
            "  translate([-groove_w / 2, -house_len / 2 - 2.5,"
            " axis_z + bore_d * 0.17]) cube([groove_w, house_len + 5, house_r + 5]);"
        )
    lines.append("  /* mounting holes through the base plate */")
    lines.append("  for (hx = [" + num(-hole_x, 3) + ", " + num(hole_x, 3) + "]) {")
    lines.append("    for (hy = [" + num(-base_d / 4, 3) + ", " + num(base_d / 4, 3) + "]) {")
    lines.append("      translate([hx, hy, -2.5]) cylinder(h = base_t + 5, d = holes_d);")
    lines.append("    }")
    lines.append("  }")
    lines.append("}")
    builder.section("\n".join(lines))
    code = builder.render()

    bbox = (float(base_w), float(max(base_d, house_len)), float(total_h))
    features_ru = [
        f"расточка {fmt(bore_d)} мм с осью на высоте {fmt(axis_z)} мм",
        f"корпус {fmt(2 * house_r)} мм, стенка под вал {fmt(wall)} мм",
        f"{ru_count(4, 'отверстие', 'отверстия', 'отверстий')} {fmt(holes_d)} мм с шагом {fmt(2 * hole_x)} мм",
    ]
    features_en = [
        f"a {fmt(bore_d)} mm bore with its axis {fmt(axis_z)} mm above the base",
        f"a {fmt(2 * house_r)} mm housing with {fmt(wall)} mm walls around the bore",
        f"{en_count(4)} {fmt(holes_d)} mm mounting holes on a {fmt(2 * hole_x)} mm spacing",
    ]
    if variant == "seated":
        features_ru.append(f"посадочный поясок диаметром {fmt(bore_d + 2 * seat_wall)} мм и глубиной {fmt(seat_d)} мм")
        features_en.append(f"a seat spigot {fmt(bore_d + 2 * seat_wall)} mm across and {fmt(seat_d)} mm deep")
    if variant == "grooved":
        features_ru.append(f"масляная канавка {fmt(groove_w)} мм сверху корпуса")
        features_en.append(f"a {fmt(groove_w)} mm oil groove cut through the housing top")
    return finish_part3(
        rng,
        family="bearingblocks",
        variant=variant,
        code=code,
        bbox=bbox,
        params={"base_w": base_w, "bore_d": bore_d, "wall": wall, "height": total_h},
        ru_nouns=BLOCK_RU,
        en_nouns=BLOCK_EN,
        features_ru=features_ru,
        features_en=features_en,
        units=units,
    )


def build_airducts(index: int) -> Part:
    """Air ducts as 2D hull chains: a 90 degree elbow, an S-bend or a tee.

    Round ports would round themselves off, so every port carries a flat flange
    plate (a rotated square in the 2D chain) whose front face is exactly the
    port plane, with the bolt holes drilled along the duct axis.
    """
    rng = Rng("gen3_ducts", index)
    variant = rng.choice(("elbow", "elbow", "sbend", "tee"))
    bend_r = rng.grid([30.0, 38.0, 46.0, 54.0])
    duct_r = rng.grid([10.0, 12.0, 14.0, 17.0])
    wall = rng.grid([2.5, 3.0, 3.5, 4.0])
    height = rng.grid([26.0, 32.0, 38.0, 44.0])
    bolt_d = float(rng.choice((4.4, 5.4)))
    collar_extra = round(bolt_d + 4.5, 2)
    collar_t = rng.grid([6.0, 7.0, 8.0])
    inner_r = round(duct_r - wall, 2)
    port_r = round(duct_r + collar_extra, 2)
    bolt_offset = round(port_r - bolt_d / 2 - 2.5, 2)

    if variant == "elbow":
        points = _arc((0.0, bend_r), bend_r, -90.0, 0.0, 8)
        branch_r = 0.0
        branch_len = 0.0
    elif variant == "sbend":
        straight = rng.grid([30.0, 40.0, 50.0])
        first = _arc((straight, 0.0), bend_r, 180.0, 90.0, 5)
        second = _arc((straight + bend_r, bend_r + bend_r), bend_r, -90.0, 0.0, 5)
        points = first + second[1:]
        branch_r = 0.0
        branch_len = 0.0
    else:
        run = rng.grid([110.0, 130.0, 150.0])
        points = [(0.0, 0.0), (run, 0.0)]
        branch_r = round(duct_r * float(rng.choice((0.75, 0.85))), 2)
        branch_len = rng.grid([50.0, 60.0, 70.0])

    start, end = points[0], points[-1]
    u_start = _unit(start, points[1])
    u_end = _unit(end, points[-2])
    interior = points[1:-1]
    if variant == "tee":
        interior = [(points[-1][0] * 0.3, 0.0), (points[-1][0] * 0.7, 0.0)]
    mid = interior[len(interior) // 2] if interior else start

    builder = ScadBuilder(
        "Air duct",
        f"{fmt(2 * duct_r)} mm duct, {fmt(wall)} mm wall, {fmt(height)} mm across",
    )
    builder.param("duct_r", duct_r, "duct core radius")
    builder.param("duct_d", round(2 * duct_r, 2), "duct core diameter")
    builder.param("wall", wall, "duct wall thickness")
    builder.param("height", height, "duct width (extrusion height)")
    builder.param("port_r", port_r, "port flange half width")
    builder.param("port_d", round(2 * port_r, 2), "port flange width")
    builder.param("port_t", collar_t, "port flange thickness")
    builder.param("bolt_d", bolt_d, "port bolt holes")
    builder.param("bolt_offset", bolt_offset, "bolt hole offset from the port axis")
    if variant == "tee":
        builder.param("branch_r", branch_r, "branch core radius")
        builder.param("branch_d", round(2 * branch_r, 2), "branch core diameter")
        builder.param("branch_len", branch_len, "branch length from the run axis")

    corner_points: list[tuple[float, float]] = []
    extra_circles: list[tuple[float, float, float]] = []

    def port_profile(anchor, u_out, r_tube, inward_extra: float = 3.0):
        """Flange plate at the port plane plus the first tube station."""
        inward = (-u_out[0], -u_out[1])
        deg = math.degrees(math.atan2(-inward[0], inward[1]))
        perp = (-inward[1], inward[0])
        plate_corners = [
            (anchor[0] + side * perp[0], anchor[1] + side * perp[1])
            for side in (-port_r, port_r)
        ] + [
            (anchor[0] + collar_t * inward[0] + side * perp[0], anchor[1] + collar_t * inward[1] + side * perp[1])
            for side in (port_r, -port_r)
        ]
        corner_points.extend(plate_corners)
        plate = "polygon([%s]);" % ", ".join(
            "[%s, %s]" % (num(x, 3), num(y, 3)) for x, y in plate_corners
        )
        tube = (
            anchor[0] + (collar_t + inward_extra) * inward[0],
            anchor[1] + (collar_t + inward_extra) * inward[1],
            r_tube,
        )
        return plate, tube, deg, inward

    plate_start, tube_start, deg_start, inward_start = port_profile(start, u_start, duct_r)
    plate_end, tube_end, deg_end, inward_end = port_profile(end, u_end, duct_r)

    outer_circles = [tube_start] + [(x, y, duct_r) for x, y in interior] + [tube_end]
    outer_profiles = [plate_start] + [_circle(*station) for station in outer_circles] + [plate_end]

    inner_profiles = [_circle(start[0] + 5 * u_start[0], start[1] + 5 * u_start[1], inner_r)]
    inner_profiles += [_circle(x, y, inner_r) for x, y in interior]
    inner_profiles += [_circle(end[0] + 5 * u_end[0], end[1] + 5 * u_end[1], inner_r)]

    lines = [
        "difference() {",
        "  /* outer hull chain: tube with a flat flange plate at every port */",
        "  linear_extrude(height = " + num(height, 3) + ") {",
        _indent(_hull_profiles(outer_profiles), 4),
    ]
    if variant == "tee":
        branch_out = (-u_end[0], -u_end[1])
        plate_branch, tube_branch, deg_branch, inward_branch = port_profile(
            (mid[0], branch_len), (0.0, 1.0), branch_r, inward_extra=2.0
        )
        branch_circles = [(mid[0], 0.0, branch_r), (mid[0], branch_len * 0.55, branch_r), tube_branch]
        extra_circles.extend(branch_circles)
        branch_profiles = [_circle(*station) for station in branch_circles] + [plate_branch]
        lines.append(_indent(_hull_profiles(branch_profiles), 4))
    lines.append("  }")
    lines.append("  /* air passage: the same chain inset by the wall, 5 mm proud of the ports */")
    lines.append("  translate([0, 0, " + num(wall, 3) + "]) linear_extrude(height = "
                 + num(round(height - 2 * wall, 3), 3) + ") {")
    lines.append(_indent(_hull_profiles(inner_profiles), 4))
    if variant == "tee":
        branch_inner = [
            _circle(mid[0], 0.0, round(branch_r - wall, 2)),
            _circle(mid[0], branch_len * 0.55, round(branch_r - wall, 2)),
            _circle(mid[0], branch_len + 5.0, round(branch_r - wall, 2)),
        ]
        lines.append(_indent(_hull_profiles(branch_inner), 4))
    lines.append("  }")
    port_list = [(start, deg_start, inward_start), (end, deg_end, inward_end)]
    if variant == "tee":
        port_list.append(((mid[0], branch_len), deg_branch, inward_branch))
    for (px, py), deg, inward in port_list:
        for side in (-bolt_offset, bolt_offset):
            lines.append(
                "  translate([%s, %s]) rotate([0, 0, %s]) translate([%s, -2.5]) rotate([-90, 0, 0])"
                " cylinder(h = %s, d = %s);"
                % (num(px, 3), num(py, 3), num(deg, 2), num(side, 3), num(collar_t + 5, 3), num(bolt_d, 3))
            )
    lines.append("}")
    builder.section("\n".join(lines))
    code = builder.render()

    all_circles = outer_circles + extra_circles
    extreme_x: list[float] = [value for x, _, r in all_circles for value in (x - r, x + r)]
    extreme_y: list[float] = [value for _, y, r in all_circles for value in (y - r, y + r)]
    extreme_x += [x for x, _ in corner_points]
    extreme_y += [y for _, y in corner_points]
    bbox = (
        float(round(max(extreme_x) - min(extreme_x), 2)),
        float(round(max(extreme_y) - min(extreme_y), 2)),
        float(height),
    )

    features_ru = [
        f"стенка {fmt(wall)} мм, проход {fmt(2 * inner_r)} мм",
        f"фланцы {fmt(2 * port_r)} мм со стороной {fmt(2 * port_r)} мм и толщиной {fmt(collar_t)} мм",
        f"{ru_count(2, 'болтовое отверстие', 'болтовых отверстия', 'болтовых отверстий')} {fmt(bolt_d)} мм в каждом фланце",
    ]
    features_en = [
        f"{fmt(wall)} mm walls around a {fmt(2 * inner_r)} mm passage",
        f"a {fmt(2 * port_r)} mm square port flange, {fmt(collar_t)} mm thick",
        f"{en_count(2)} {fmt(bolt_d)} mm bolt holes in every flange",
    ]
    if variant == "elbow":
        features_ru.append(f"плавный изгиб 90 градусов радиусом {fmt(bend_r)} мм")
        features_en.append(f"a smooth 90 degree bend of {fmt(bend_r)} mm radius")
    elif variant == "sbend":
        features_ru.append(f"S-образный изгиб из двух дуг по {fmt(bend_r)} мм")
        features_en.append(f"an S-bend built from two {fmt(bend_r)} mm arcs")
    else:
        features_ru.append(f"боковой отвод {fmt(2 * branch_r)} мм посередине трассы")
        features_en.append(f"a {fmt(2 * branch_r)} mm side branch at mid run")
    return finish_part3(
        rng,
        family="airducts",
        variant=variant,
        code=code,
        bbox=bbox,
        params={"duct_d": round(2 * duct_r, 2), "wall": wall, "height": height, "bend_r": bend_r},
        ru_nouns=DUCT_RU,
        en_nouns=DUCT_EN,
        features_ru=features_ru,
        features_en=features_en,
    )


def _stations(profiles: list[str]) -> list[tuple[float, float, float]]:
    """Recover (x, y, r) from the circle profiles an outer chain was built from."""
    found: list[tuple[float, float, float]] = []
    for profile in profiles:
        text = profile.strip()
        if text.startswith("translate([") and "circle(r =" in text:
            head = text.split("circle(r =")[0]
            numbers = head[head.index("[") + 1 : head.index("]")].split(",")
            radius = float(text.split("circle(r =")[1].rstrip(";").rstrip(")").strip())
            found.append((float(numbers[0]), float(numbers[1]), radius))
    return found


def _unit(a: tuple[float, float], b: tuple[float, float]) -> tuple[float, float]:
    dx, dy = a[0] - b[0], a[1] - b[1]
    length = math.hypot(dx, dy) or 1.0
    return dx / length, dy / length


def _indent(text: str, spaces: int) -> str:
    pad = " " * spaces
    return "\n".join(pad + line if line else line for line in text.split("\n"))


def build_fairings(index: int) -> Part:
    """Faired rectangular channel: hull chain of boxes that tapers at both ends."""
    rng = Rng("gen3_fairings", index)
    variant = rng.choice(("plain", "plain", "ribbed"))
    length = rng.grid([140.0, 160.0, 180.0, 200.0])
    width = rng.grid([40.0, 46.0, 52.0, 58.0])
    height = rng.grid([26.0, 30.0, 36.0, 42.0])
    wall = rng.grid([3.0, 3.5, 4.0])
    floor_t = rng.grid([3.0, 4.0])
    taper = rng.choice((0.6, 0.65, 0.7))
    end_w = round(width * taper, 2)
    end_h = round(height * taper, 2)
    tip_wall = 1.6
    inner_w = round(width - 2 * wall, 2)
    inner_h = round(height - floor_t - wall, 2)
    inner_end_w = round(end_w - 2 * tip_wall, 2)
    inner_end_h = round(end_h - floor_t - tip_wall, 2)
    fair_len = round(length * 0.09, 2)
    ribs = rng.integer(3, 5)
    rib_t = rng.grid([2.4, 3.0])
    rib_h = rng.grid([3.0, 4.0])

    stations_x = [0.0, fair_len, length / 2, length - fair_len, length]
    shoulder = 1.0 if variant == "ribbed" else 0.35
    outer = [
        (stations_x[0], end_w, end_h, 0.0),
        (stations_x[1], round(end_w + (width - end_w) * shoulder, 2), round(end_h + (height - end_h) * shoulder, 2), 0.0),
        (stations_x[2], width, height, 0.0),
        (stations_x[3], round(end_w + (width - end_w) * shoulder, 2), round(end_h + (height - end_h) * shoulder, 2), 0.0),
        (stations_x[4], end_w, end_h, 0.0),
    ]
    inner = [
        (stations_x[0] - 5.0, inner_end_w, inner_end_h, floor_t),
        (stations_x[1] - 5.0, round(inner_end_w + (inner_w - inner_end_w) * 0.35, 2), round(inner_end_h + (inner_h - inner_end_h) * 0.35, 2), floor_t),
        (stations_x[2] - 5.0, inner_w, inner_h, floor_t),
        (stations_x[3] - 5.0, round(inner_end_w + (inner_w - inner_end_w) * 0.35, 2), round(inner_end_h + (inner_h - inner_end_h) * 0.35, 2), floor_t),
        (stations_x[4] + 5.0, inner_end_w, inner_end_h, floor_t),
    ]
    shift = 5.0 if variant == "ribbed" else 5.0

    builder = ScadBuilder(
        "Faired channel",
        f"{fmt(length)} x {fmt(width)} x {fmt(height)} mm, {fmt(wall)} mm walls, faired ends",
    )
    builder.param("length", length, "channel length")
    builder.param("width", width, "channel width at mid length")
    builder.param("height", height, "channel height at mid length")
    builder.param("wall", wall, "side wall thickness")
    builder.param("floor_t", floor_t, "floor thickness")
    builder.param("end_w", end_w, "faired end width")
    builder.param("end_h", end_h, "faired end height")
    if variant == "ribbed":
        builder.param("ribs", float(ribs), "stiffening ribs on the top")
        builder.param("rib_t", rib_t, "rib thickness")
        builder.param("rib_h", rib_h, "rib height")

    lines = ["difference() {", "  union() {", _indent(_hull_boxes(outer), 4)]
    if variant == "ribbed":
        lines.append("    /* stiffening ribs across the flat top, sunk 0.8 mm into it */")
        lines.append("    for (i = [1 : ribs]) {")
        lines.append(
            "      translate([" + num(fair_len, 3) + " + i * (length - 2 * " + num(fair_len, 3)
            + ") / (ribs + 1) - rib_t / 2, -width / 2, height - 0.8])"
            " cube([rib_t, width, rib_h + 0.8]);"
        )
        lines.append("    }")
    lines.append("  }")
    lines.append("  /* cavity, 5 mm proud of both ends so the ports are cut clean */")
    lines.append(_indent(_hull_boxes(inner), 2))
    lines.append("}")
    builder.section("\n".join(lines))
    code = builder.render()

    bbox = (float(length + 0.4), float(width), float(height + (rib_h if variant == "ribbed" else 0.0)))
    features_ru = [
        f"стенки {fmt(wall)} мм, дно {fmt(floor_t)} мм, внутренний проход {fmt(inner_w)} x {fmt(inner_h)} мм",
        f"обтекаемые концы: с {fmt(width)} x {fmt(height)} до {fmt(end_w)} x {fmt(end_h)} мм",
    ]
    features_en = [
        f"{fmt(wall)} mm walls on a {fmt(floor_t)} mm floor, {fmt(inner_w)} x {fmt(inner_h)} mm passage",
        f"faired ends tapering from {fmt(width)} x {fmt(height)} mm to {fmt(end_w)} x {fmt(end_h)} mm",
    ]
    if variant == "ribbed":
        features_ru.append(f"{ru_count(ribs, 'ребро', 'ребра', 'рёбер')} жёсткости высотой {fmt(rib_h)} мм сверху")
        features_en.append(f"{en_count(ribs)} stiffening ribs, {fmt(rib_h)} mm tall, along the top")
    return finish_part3(
        rng,
        family="fairings",
        variant=variant,
        code=code,
        bbox=bbox,
        params={"length": length, "width": width, "height": height, "wall": wall},
        ru_nouns=CHAN_RU,
        en_nouns=CHAN_EN,
        features_ru=features_ru,
        features_en=features_en,
    )
