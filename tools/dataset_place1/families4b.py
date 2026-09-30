"""``place1`` families, part B: pocket plates, anchor pads, racks and socket pads.

Same recipe as part A: the prompt numbers become header variables, the feature
coordinates are derived from them into ``feature_centers``, and the cut is driven
by that array alone.
"""

from __future__ import annotations

from tools.dataset_gen2.common import Rng
from tools.dataset_place1 import prompts4 as P
from tools.dataset_place1.common4 import (
    hole_probes,
    tolerance_note,
    hole_with_allowance,
    inch_or_round,
    solid_probe,
)
from tools.dataset_place1.core4 import CodePlan, PlacePart, Probe, feature_lines, make_part

NOUN_RU = {
    "pocketplates": "плиту с карманами",
    "anchorpads": "стойку с анкерными площадками",
    "rackbars": "зубчатую рейку",
    "socketpads": "плиту с гнёздами под крепёж",
}
NOUN_EN = {
    "pocketplates": "pocket plate",
    "anchorpads": "anchor pad plate",
    "rackbars": "toothed rack",
    "socketpads": "socket pad plate",
}


# ---------------------------------------------------------------------------
# 6. pocket plates - a 2x2 / 3x3 pocket grid, pockets of one depth
# ---------------------------------------------------------------------------

def build_pocketplates(index: int) -> PlacePart:
    rng = Rng("place1_pocketplates", index)
    variant = rng.choice(("2x2", "3x3", "2x3", "3x3"))
    rows, cols = {"2x2": (2, 2), "3x3": (3, 3), "2x3": (2, 3)}[variant]
    thickness = rng.grid([12.0, 15.0, 18.0, 20.0, 25.0])
    floor_t = rng.grid([2.0, 3.0, 4.0, 5.0])
    pocket = rng.grid([14.0, 18.0, 22.0, 26.0, 30.0])
    web = rng.grid([4.0, 5.0, 6.0, 8.0])
    pitch_x = round(pocket + web, 3)
    pitch_y = round(pocket + web, 3)
    span_x = round((cols - 1) * pitch_x, 3)
    span_y = round((rows - 1) * pitch_y, 3)
    plate_l = round(span_x + pocket + 6.0, 3)
    plate_w = round(span_y + pocket + 6.0, 3)
    depth = round(thickness - floor_t, 3)

    plan = CodePlan(
        f"Pocket plate {plate_l:g} x {plate_w:g} x {thickness:g}",
        f"{rows} x {cols} pockets {pocket:g} mm square, {depth:g} mm deep",
    )
    plan.param("thickness", thickness, "plate thickness")
    tolerance_note(rng, plan)
    plan.param("floor_t", floor_t, "material left under each pocket")
    plan.param("pocket", pocket, "pocket side length")
    plan.param("pitch_x", pitch_x, "pocket pitch along X")
    plan.param("pitch_y", pitch_y, "pocket pitch along Y")
    plan.param("cols", float(cols), "pockets per row")
    plan.param("rows", float(rows), "rows of pockets")
    plan.derived("depth", "thickness - floor_t", depth, "pocket depth, down to the floor")
    plan.derived("span_x", "(cols - 1) * pitch_x", span_x, "distance between outer pockets")
    plan.derived("span_y", "(rows - 1) * pitch_y", span_y, "distance between outer pocket rows")
    plan.derived("origin_x", "-span_x / 2", round(-span_x / 2.0, 3), "X of the first pocket")
    plan.derived("origin_y", "-span_y / 2", round(-span_y / 2.0, 3), "Y of the first pocket")
    plan.derived(
        "plate",
        "[span_x + pocket + 6, span_y + pocket + 6, thickness]",
        (plate_l, plate_w, thickness),
        "overall size: pockets plus 3 mm of wall on each side",
    )

    centres = [
        [round(-span_x / 2.0 + i * pitch_x, 3), round(-span_y / 2.0 + j * pitch_y, 3)]
        for j in range(rows)
        for i in range(cols)
    ]
    expressions = [
        f"[origin_x + {i} * pitch_x, origin_y + {j} * pitch_y]"
        for j in range(rows)
        for i in range(cols)
    ]
    plan.derived(
        "feature_centers",
        "[\n" + feature_lines(expressions) + "\n]",
        None,
        "pocket centres, used verbatim by the cutter loop",
    )

    body = """// plate outline, then one pocket per centre in feature_centers
difference() {
  cube(plate, center = true);
  for (centre = feature_centers)
    translate([centre[0] - pocket / 2, centre[1] - pocket / 2, plate[2] / 2 - depth])
      cube([pocket, pocket, depth + 1]);  // centred on the declared pocket centre
}"""

    probe_spec = {
        "kind": "void",
        "size_mm": round(min(pocket / 3.0, depth / 3.0, 3.0), 3),
        "z_mm": round(thickness / 2.0 - depth / 2.0, 3),
    }
    probes: list[Probe] = [
        Probe(
            (centre[0], centre[1], round(thickness / 2.0 - depth / 2.0, 3)),
            "empty",
            min(pocket / 3.0, depth / 3.0, 3.0),
            f"pocket {i}",
        )
        for i, centre in enumerate(centres)
    ]
    probes.append(
        Probe(
            (centres[0][0], centres[0][1], round(-thickness / 2.0 + floor_t / 2.0, 3)),
            "solid",
            min(floor_t / 2.0, pocket / 3.0),
            "floor under a pocket",
        )
    )
    gap_x = round(centres[0][0] + pitch_x / 2.0, 3)
    probes.append(
        solid_probe((gap_x, centres[0][1], 0.0), min(web / 3.0, 3.0), "web between pockets")
    )

    ru_features = [
        P.pockets_ru(rng, rows, cols, pocket, depth, pitch_x, pitch_y).rstrip("."),
        f"под карманами остаётся дно {P.pnum(floor_t)} мм",
    ]
    en_features = [
        P.pockets_en(rng, rows, cols, pocket, depth, pitch_x, pitch_y).rstrip("."),
        f"a {P.pnum(floor_t)} mm floor stays under every pocket",
    ]

    return make_part(
        family="pocketplates",
        variant=variant,
        rng=rng,
        plan=plan,
        body=body,
        bbox=(plate_l, plate_w, thickness),
        params={
            "plate_l": plate_l, "plate_w": plate_w, "thickness": thickness, "floor_t": floor_t,
            "pocket": pocket, "pitch_x": pitch_x, "pitch_y": pitch_y, "depth": depth,
            "rows": float(rows), "cols": float(cols),
        },
        placement={
            "kind": "pocket_grid",
            "array": "feature_centers",
            "count": len(centres),
            "centers_mm": centres,
            "symmetry": "mirror_xy",
            "fields": {
                "pitch_x_mm": pitch_x, "pitch_y_mm": pitch_y, "depth_mm": depth,
                "origin_x_mm": round(-span_x / 2.0, 3), "origin_y_mm": round(-span_y / 2.0, 3),
            },
            "probe": probe_spec,
        },
        probes=probes,
        ru_noun=NOUN_RU["pocketplates"],
        en_noun=NOUN_EN["pocketplates"],
        ru_features=ru_features,
        en_features=en_features,
        tolerance=rng.chance(0.2),
    )


# ---------------------------------------------------------------------------
# 7. anchor pads - a base plate with corner bosses and anchor holes
# ---------------------------------------------------------------------------

def build_anchorpads(index: int) -> PlacePart:
    rng = Rng("place1_anchorpads", index)
    plate_l = rng.grid([80.0, 100.0, 120.0, 150.0, 180.0])
    plate_w = rng.grid([60.0, 80.0, 100.0, 120.0])
    base_t = rng.grid([6.0, 8.0, 10.0, 12.0])
    boss_h = rng.grid([4.0, 6.0, 8.0, 10.0])
    boss_d = rng.grid([22.0, 26.0, 30.0, 36.0])
    # the boss has to fit on the plate with a wall to spare, so the edge offset
    # is clamped into the range the boss diameter allows
    boss_margin = boss_d / 2.0 + 3.0
    plate_l = max(plate_l, 2.0 * (boss_d + 6.0))
    plate_w = max(plate_w, 2.0 * (boss_d + 6.0))
    edge, inch = inch_or_round(rng, [12.0, 15.0, 18.0, 20.0], chance=0.2, max_mm=40.0)
    edge = round(min(max(edge, boss_margin), min(plate_l, plate_w) / 2 - boss_margin), 3)
    plan = CodePlan(
        f"Anchor pads {plate_l:g} x {plate_w:g} x {base_t + boss_h:g}",
        "four corner bosses with anchor holes",
    )
    plan.param("plate", [plate_l, plate_w, base_t], "base plate size (x, y, z)")
    tolerance_note(rng, plan)
    plan.param("pads", 4.0, "boss count, one per corner")
    plan.param("edge", edge, "boss centre offset from the plate edge")
    plan.param("boss_d", boss_d, "boss diameter")
    plan.param("boss_h", boss_h, "boss height above the base plate")
    hole_d, allow_ru, allow_en = hole_with_allowance(rng, plan, [5.5, 6.6, 8.4, 10.5])
    plan.derived("height", "plate[2] + boss_h", round(base_t + boss_h, 3), "overall height of the part")
    corner_x = round(plate_l / 2.0 - edge, 3)
    corner_y = round(plate_w / 2.0 - edge, 3)
    plan.derived("corner_x", "plate[0] / 2 - edge", corner_x, "boss centre X")
    plan.derived("corner_y", "plate[1] / 2 - edge", corner_y, "boss centre Y")
    plan.derived(
        "feature_centers",
        "[\n" + feature_lines(
            ["[corner_x, corner_y]", "[-corner_x, corner_y]",
             "[-corner_x, -corner_y]", "[corner_x, -corner_y]"]
        ) + "\n]",
        None,
        "boss centres, anchor holes are drilled there",
    )

    body = """// base plate, four bosses standing on it, anchor holes all the way through
difference() {
  union() {
    cube(plate, center = true);
    for (centre = feature_centers)
      translate([centre[0], centre[1], plate[2] / 2 - 1])
        cylinder(d = boss_d, h = boss_h + 1);
  }
  for (centre = feature_centers)
    translate([centre[0], centre[1], -height])
      cylinder(d = hole_d, h = 2 * height + 2);  // through boss and plate
}"""

    centres = [[corner_x, corner_y], [-corner_x, corner_y], [-corner_x, -corner_y], [corner_x, -corner_y]]
    probe_spec = {
        "kind": "void",
        "size_mm": round(min(hole_d * 0.5, boss_h * 0.5, 2.0), 3),
        "z_mm": round(base_t / 2.0 + boss_h / 2.0, 3),
    }
    probes: list[Probe] = [
        Probe((x, y, round(base_t / 2.0 + boss_h / 2.0, 3)), "empty",
              min(hole_d * 0.6, boss_h * 0.6, 2.0), f"anchor hole {i}")
        for i, (x, y) in enumerate(centres)
    ]
    rim_r = min((hole_d / 2.0 + boss_d / 2.0) / 2.0, edge / 2.0)
    probes.append(
        solid_probe((corner_x + rim_r, corner_y, round(base_t / 2.0 + boss_h / 2.0, 3)),
                    min((boss_d - hole_d) / 4.0, boss_h / 2.0, 2.0), "boss wall")
    )
    probes.append(
        solid_probe((0.0, 0.0, 0.0), min(base_t / 3.0, 2.0), "base plate centre is solid")
    )

    ru_features = [
        P.bosses_ru(rng, 4, boss_d, hole_d, edge, boss_h).rstrip("."),
        "отверстия сквозные — через площадку и основание",
    ]
    en_features = [
        P.bosses_en(rng, 4, boss_d, hole_d, edge, boss_h).rstrip("."),
        "the anchor holes go through both the boss and the base plate",
    ]
    if allow_ru:
        ru_features.append(allow_ru)
        en_features.append(allow_en)

    return make_part(
        family="anchorpads",
        variant="corners",
        rng=rng,
        plan=plan,
        body=body,
        bbox=(plate_l, plate_w, base_t + boss_h),
        params={
            "plate_l": plate_l, "plate_w": plate_w, "base_t": base_t, "boss_d": boss_d,
            "boss_h": boss_h, "hole_d": hole_d, "edge": edge,
        },
        placement={
            "kind": "corners",
            "array": "feature_centers",
            "count": 4,
            "centers_mm": [[round(x, 3), round(y, 3)] for x, y in centres],
            "symmetry": "mirror_xy",
            "fields": {"edge_mm": edge, "hole_d_mm": hole_d, "boss_d_mm": boss_d},
            "probe": probe_spec,
        },
        probes=probes,
        ru_noun=NOUN_RU["anchorpads"],
        en_noun=NOUN_EN["anchorpads"],
        ru_features=ru_features,
        en_features=en_features,
        tolerance=rng.chance(0.2),
    )


# ---------------------------------------------------------------------------
# 8. rack bars - teeth at a pitch along the top edge
# ---------------------------------------------------------------------------

def build_rackbars(index: int) -> PlacePart:
    rng = Rng("place1_rackbars", index)
    count = rng.integer(6, 14)
    pitch = rng.grid([8.0, 10.0, 12.0, 15.0])
    tooth_h = round(rng.grid([5.0, 6.0, 8.0]), 3)
    crest_w = round(pitch * rng.grid([0.35, 0.4, 0.45]), 3)
    root_w = round(pitch * rng.grid([0.7, 0.75, 0.8]), 3)
    bar_w = rng.grid([16.0, 20.0, 25.0, 30.0])
    bar_h = rng.grid([8.0, 10.0, 12.0, 15.0])

    plan = CodePlan(
        f"Toothed rack, {count} teeth",
        f"{pitch:g} mm pitch, {tooth_h:g} mm teeth",
    )
    plan.param("bar_w", bar_w, "bar width (Y)")
    tolerance_note(rng, plan)
    plan.param("bar_h", bar_h, "bar height (Z)")
    plan.param("teeth", float(count), "number of teeth")
    plan.param("pitch", pitch, "tooth pitch")
    plan.param("tooth_h", tooth_h, "tooth height above the bar")
    plan.param("root_w", root_w, "tooth width at the root")
    plan.param("crest_w", crest_w, "tooth width at the crest")
    span = round((count - 1) * pitch, 3)
    bar_l = round(span + root_w + 8.0, 3)
    plan.derived("span", "(teeth - 1) * pitch", span, "distance between the outer teeth")
    plan.derived("bar_l", "span + root_w + 8", bar_l, "bar length: teeth plus 4 mm at each end")
    plan.derived("tooth_x", "-span / 2", round(-span / 2.0, 3), "X of the first tooth")
    plan.derived("height", "bar_h + tooth_h", round(bar_h + tooth_h, 3), "overall height")

    expressions = [f"[tooth_x + {step} * pitch, -bar_w / 2]" for step in range(count)]
    centres = [[round(-span / 2.0 + step * pitch, 3), round(-bar_w / 2.0, 3)] for step in range(count)]
    plan.derived(
        "feature_centers",
        "[\n" + feature_lines(expressions) + "\n]",
        None,
        "tooth centre line, drives the tooth loop",
    )

    body = """// bar with a rack of teeth, one extruded trapezoium per centre
module rack_tooth() {
  linear_extrude(height = bar_w)
    polygon(points = [
      [0, 0],
      [root_w, 0],
      [root_w / 2 + crest_w / 2, tooth_h + 1],
      [root_w / 2 - crest_w / 2, tooth_h + 1]
    ]);
}

union() {
  translate([-bar_l / 2, -bar_w, 0]) cube([bar_l, bar_w, bar_h]);
  for (centre = feature_centers)
    translate([centre[0] - root_w / 2, 0, bar_h - 1]) rotate([90, 0, 0]) rack_tooth();
}"""

    probe_spec = {
        "kind": "solid",
        "size_mm": round(min(crest_w / 2.0, tooth_h / 3.0, 2.0), 3),
        "z_mm": round(bar_h + tooth_h / 2.0, 3),
    }
    probes: list[Probe] = []
    for i, centre in enumerate(centres):
        probes.append(
            Probe((centre[0], -bar_w / 2.0, round(bar_h + tooth_h / 2.0, 3)), "solid",
                  min(crest_w / 2.0, tooth_h / 3.0, 2.0), f"tooth {i}")
        )
        if i + 1 < count:
            gap_x = round(centre[0] + pitch / 2.0, 3)
            gap_size = min((pitch - root_w) / 3.0, tooth_h / 3.0, 2.0)
            if gap_size > 0.3:
                probes.append(
                    Probe((gap_x, -bar_w / 2.0, round(bar_h + tooth_h / 2.0, 3)), "empty", gap_size,
                          "gap between teeth")
                )
    probes.append(
        solid_probe((round(-bar_l / 2.0 + 2.0, 3), -bar_w / 2.0, bar_h / 2.0),
                    min(1.0, bar_h / 4.0), "bar end is plain")
    )

    ru_features = [P.rack_ru(rng, count, pitch, tooth_h, crest_w, bar_h).rstrip(".")]
    en_features = [P.rack_en(rng, count, pitch, tooth_h, crest_w, bar_h).rstrip(".")]
    ru_features.append(
        f"зубья стоят на планке {P.pnum(bar_h)} мм высотой и {P.pnum(bar_w)} мм шириной"
    )
    en_features.append(
        f"the teeth stand on a {P.pnum(bar_h)} mm high, {P.pnum(bar_w)} mm wide bar"
    )

    bbox = (bar_l, bar_w, round(bar_h + tooth_h, 3))
    return make_part(
        family="rackbars",
        variant="rack",
        rng=rng,
        plan=plan,
        body=body,
        bbox=bbox,
        params={
            "bar_l": bar_l, "bar_w": bar_w, "bar_h": bar_h, "teeth": float(count), "pitch": pitch,
            "tooth_h": tooth_h, "root_w": root_w, "crest_w": crest_w,
        },
        placement={
            "kind": "rack",
            "array": "feature_centers",
            "count": count,
            "centers_mm": centres,
            "symmetry": "mirror_y",
            "fields": {"pitch_mm": pitch, "tooth_h_mm": tooth_h, "crest_w_mm": crest_w},
            "probe": probe_spec,
        },
        probes=probes,
        ru_noun=NOUN_RU["rackbars"],
        en_noun=NOUN_EN["rackbars"],
        ru_features=ru_features,
        en_features=en_features,
        tolerance=rng.chance(0.2),
    )


# ---------------------------------------------------------------------------
# 9. socket pads - corner bosses (or a boss grid) with counterbored sockets
# ---------------------------------------------------------------------------

def build_socketpads(index: int) -> PlacePart:
    rng = Rng("place1_socketpads", index)
    variant = rng.choice(("corners", "grid", "corners"))
    base_t = rng.grid([8.0, 10.0, 12.0, 15.0])
    boss_h = rng.grid([8.0, 10.0, 12.0, 15.0])
    boss_d = rng.grid([24.0, 28.0, 32.0, 38.0])
    socket_d = round(boss_d - 2.0 * rng.grid([3.0, 4.0, 5.0]), 3)
    socket_depth = round(min(boss_h - rng.grid([2.0, 3.0, 4.0]), boss_h - 2.0), 3)
    socket_depth = max(socket_depth, 3.0)
    # the screw clearance hole is much smaller than the socket: the floor keeps a
    # real annulus for the screw head to sit on
    hole_d = round(min(socket_d * rng.grid([0.3, 0.35, 0.4]), socket_d - 8.0), 3)
    hole_d = max(hole_d, 3.4)

    plan = CodePlan("Socket pad plate", "bosses with counterbored sockets for the screws")
    plan.param("base_t", base_t, "base plate thickness")
    tolerance_note(rng, plan)
    plan.param("boss_h", boss_h, "boss height above the base plate")
    plan.param("boss_d", boss_d, "boss diameter")
    plan.param("socket_d", socket_d, "socket diameter")
    plan.param("socket_depth", socket_depth, "socket depth from the boss face")
    plan.param("bolt_d", hole_d, "screw clearance hole through the socket floor")
    plan.derived("height", "base_t + boss_h", round(base_t + boss_h, 3), "overall height of the part")

    if variant == "corners":
        plate_l = rng.grid([90.0, 110.0, 130.0, 160.0])
        plate_w = rng.grid([70.0, 90.0, 110.0])
        boss_margin = boss_d / 2.0 + 3.0
        plate_l = max(plate_l, 2.0 * (boss_d + 6.0))
        plate_w = max(plate_w, 2.0 * (boss_d + 6.0))
        edge, inch = inch_or_round(rng, [16.0, 20.0, 22.0, 25.0], chance=0.2, max_mm=40.0)
        edge = round(min(max(edge, boss_margin), min(plate_l, plate_w) / 2 - boss_margin), 3)
        plan.param("plate", [plate_l, plate_w, base_t], "overall size (x, y, z)")
        plan.param("edge", edge, "boss centre offset from the plate edge")
        corners = rng.choice((4, 4, 4))
        plan.param("pads", float(corners), "boss count, one per corner")
        corner_x = round(plate_l / 2.0 - edge, 3)
        corner_y = round(plate_w / 2.0 - edge, 3)
        plan.derived("corner_x", "plate[0] / 2 - edge", corner_x, "boss centre X")
        plan.derived("corner_y", "plate[1] / 2 - edge", corner_y, "boss centre Y")
        centres = [[corner_x, corner_y], [-corner_x, corner_y], [-corner_x, -corner_y], [corner_x, -corner_y]]
        expressions = ["[corner_x, corner_y]", "[-corner_x, corner_y]",
                       "[-corner_x, -corner_y]", "[corner_x, -corner_y]"]
        plate = (plate_l, plate_w, round(base_t + boss_h, 3))
        symmetry = "mirror_xy"
        fields = {"edge_mm": edge, "socket_d_mm": socket_d, "socket_depth_mm": socket_depth}
        ru_features = [P.sockets_ru(rng, corners, boss_d, socket_d, socket_depth, edge).rstrip(".")]
        en_features = [P.sockets_en(rng, corners, boss_d, socket_d, socket_depth, edge).rstrip(".")]
    else:
        rows, cols = rng.choice(((2, 2), (2, 3), (3, 2)))
        pitch = round(boss_d + rng.grid([6.0, 8.0, 10.0]), 3)
        span_x = round((cols - 1) * pitch, 3)
        span_y = round((rows - 1) * pitch, 3)
        plate_l = round(span_x + boss_d + 8.0, 3)
        plate_w = round(span_y + boss_d + 8.0, 3)
        plan.param("rows", float(rows), "boss rows")
        plan.param("cols", float(cols), "bosses per row")
        plan.param("pitch", pitch, "boss pitch")
        plan.derived("plate", "[pitch * (cols - 1) + boss_d + 8, pitch * (rows - 1) + boss_d + 8, base_t]",
                     (plate_l, plate_w, base_t), "overall size (x, y, z)")
        plan.derived("span_x", "pitch * (cols - 1)", span_x, "distance between outer bosses")
        plan.derived("span_y", "pitch * (rows - 1)", span_y, "distance between boss rows")
        plan.derived("origin_x", "-span_x / 2", round(-span_x / 2.0, 3), "X of the first boss")
        plan.derived("origin_y", "-span_y / 2", round(-span_y / 2.0, 3), "Y of the first boss")
        centres = [
            [round(-span_x / 2.0 + i * pitch, 3), round(-span_y / 2.0 + j * pitch, 3)]
            for j in range(rows)
            for i in range(cols)
        ]
        expressions = [
            f"[origin_x + {i} * pitch, origin_y + {j} * pitch]"
            for j in range(rows)
            for i in range(cols)
        ]
        plate = (plate_l, plate_w, round(base_t + boss_h, 3))
        symmetry = "mirror_xy"
        fields = {"pitch_mm": pitch, "socket_d_mm": socket_d, "socket_depth_mm": socket_depth,
                  "origin_x_mm": round(-span_x / 2.0, 3), "origin_y_mm": round(-span_y / 2.0, 3)}
        ru_features = [
            f"{rows} x {cols} площадок ø{P.pnum(boss_d)} мм с шагом {P.pnum(pitch)} мм, "
            f"в каждой гнездо ø{P.pnum(socket_d)} мм глубиной {P.pnum(socket_depth)} мм",
            f"высота площадок {P.pnum(boss_h)} мм, сквозное отверстие ø{P.pnum(hole_d)} мм",
        ]
        en_features = [
            f"{rows} x {cols} bosses Ø{P.pnum(boss_d)} mm at {P.pnum(pitch)} mm pitch, each with a "
            f"Ø{P.pnum(socket_d)} x {P.pnum(socket_depth)} mm socket",
            f"the bosses stand {P.pnum(boss_h)} mm proud, with a Ø{P.pnum(hole_d)} mm through hole",
        ]

    plan.derived(
        "feature_centers",
        "[\n" + feature_lines(expressions) + "\n]",
        None,
        "boss centres: sockets, holes and the pads themselves are placed from here",
    )

    body = """// base plate, bosses on feature_centers, socket + through hole in each
difference() {
  union() {
    cube(plate, center = true);
    for (centre = feature_centers)
      translate([centre[0], centre[1], plate[2] / 2 - 1])
        cylinder(d = boss_d, h = boss_h + 1);
  }
  for (centre = feature_centers) {
    translate([centre[0], centre[1], plate[2] / 2 + boss_h - socket_depth])
      cylinder(d = socket_d, h = socket_depth + 1);
    translate([centre[0], centre[1], -height])
      cylinder(d = bolt_d, h = 2 * height + 2);  // through the socket floor
  }
}"""

    z_face = round(base_t / 2.0 + boss_h - socket_depth / 2.0, 3)
    probe_spec = {
        "kind": "void",
        "size_mm": round(min(socket_d * 0.4, socket_depth / 3.0, 3.0), 3),
        "z_mm": z_face,
    }
    probes: list[Probe] = [
        Probe((x, y, z_face), "empty", min(socket_d * 0.4, socket_depth / 3.0, 3.0), f"socket {i}")
        for i, (x, y) in enumerate(centres)
    ]
    # the floor probe sits in the annulus between the screw hole and the socket
    floor_r = (hole_d / 2.0 + socket_d / 2.0) / 2.0
    probes.append(
        solid_probe((round(centres[0][0] + floor_r, 3), centres[0][1],
                     round(base_t / 2.0 + (boss_h - socket_depth) / 2.0, 3)),
                    min((socket_d - hole_d) / 4.0, (boss_h - socket_depth) / 2.0, 2.0),
                    "socket floor")
    )
    wall_r = (socket_d / 2.0 + boss_d / 2.0) / 2.0
    probes.append(
        solid_probe((round(centres[0][0] + wall_r, 3), centres[0][1], z_face),
                    min((boss_d - socket_d) / 4.0, socket_depth / 3.0, 1.5), "socket wall")
    )

    return make_part(
        family="socketpads",
        variant=variant,
        rng=rng,
        plan=plan,
        body=body,
        bbox=plate,
        params={
            "plate_l": plate[0], "plate_w": plate[1], "base_t": base_t, "boss_h": boss_h,
            "boss_d": boss_d, "socket_d": socket_d, "socket_depth": socket_depth, "hole_d": hole_d,
        },
        placement={
            "kind": "boss_grid" if variant == "grid" else "corners",
            "array": "feature_centers",
            "count": len(centres),
            "centers_mm": centres,
            "symmetry": symmetry,
            "fields": fields,
            "probe": probe_spec,
        },
        probes=probes,
        ru_noun=NOUN_RU["socketpads"],
        en_noun=NOUN_EN["socketpads"],
        ru_features=ru_features,
        en_features=en_features,
        tolerance=rng.chance(0.2),
    )


BUILDERS = {
    "pocketplates": build_pocketplates,
    "anchorpads": build_anchorpads,
    "rackbars": build_rackbars,
    "socketpads": build_socketpads,
}
