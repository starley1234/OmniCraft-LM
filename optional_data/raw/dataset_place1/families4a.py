"""``place1`` families, part A: corner plates, bolt circles, perforated panels,
rib frames and hole rows.

Every builder follows the same recipe:

1. pick the parameters from the prompt-visible set (count, feature size, offset,
   pitch — nothing else drives a feature position);
2. write those parameters into the header, and *derive* the feature coordinates
   from them into named variables plus a literal ``feature_centers`` array;
3. cut the geometry with exactly that array, so prompt, array and solid cannot
   drift apart;
4. hand back geometric probes: an ``empty`` cube in every declared hole and a
   ``solid`` cube where a wrong layout would have drilled one.
"""

from __future__ import annotations

import math

from tools.dataset_gen2.common import Rng
from tools.dataset_place1 import prompts4 as P
from tools.dataset_place1.common4 import (
    centre_expressions,
    hole_probes,
    tolerance_note,
    hole_with_allowance,
    inch_or_round,
    mirror_centres,
    solid_probe,
)
from tools.dataset_place1.core4 import CodePlan, PlacePart, Probe, feature_lines, make_part

NOUN_RU = {
    "cornerplates": "профильную пластину",
    "boltcircles": "фланец",
    "perfpanels": "перфорированную панель",
    "ribframes": "рамку с рёбрами",
    "ventrows": "планку с отверстиями",
}
NOUN_EN = {
    "cornerplates": "profile plate",
    "boltcircles": "flange",
    "perfpanels": "perforated panel",
    "ribframes": "rib frame",
    "ventrows": "hole bar",
}


# ---------------------------------------------------------------------------
# 1. corner plates - 4 / 6 / 8 corner holes (and "three of the four corners")
# ---------------------------------------------------------------------------

def build_cornerplates(index: int) -> PlacePart:
    rng = Rng("place1_cornerplates", index)
    variant = rng.choice(("four", "six", "eight", "four", "three"))
    count = {"four": 4, "six": 6, "eight": 8, "three": 3}[variant]
    plate_l = rng.grid([70.0, 90.0, 110.0, 130.0, 160.0, 190.0])
    plate_w = rng.grid([45.0, 60.0, 75.0, 90.0])
    thickness = rng.grid([5.0, 6.0, 8.0, 10.0, 12.0])
    edge, inch = inch_or_round(
        rng, [8.0, 10.0, 12.0, 15.0, 20.0], chance=0.2, max_mm=min(plate_l, plate_w) / 2 - 12.0
    )
    edge = round(min(edge, min(plate_l, plate_w) / 2 - 12.0), 3)

    plan = CodePlan(
        f"Corner plate {plate_l:g} x {plate_w:g} x {thickness:g}",
        f"{count} holes, centres taken from the edge offset",
    )
    plan.param("plate", [plate_l, plate_w, thickness], "overall size (x, y, z)")
    tolerance_note(rng, plan)
    plan.param("holes", float(count), "number of holes the drawing asks for")
    hole_d, allow_ru, allow_en = hole_with_allowance(rng, plan, [4.5, 5.5, 6.6, 8.4, 10.5])
    # every hole keeps a real wall to the plate edge
    edge_min = round(hole_d / 2.0 + 1.5, 3)
    edge_max = round(min(plate_l, plate_w) / 2.0 - 12.0, 3)
    edge = round(min(max(edge, edge_min), edge_max), 3)
    inch = P.inch_for(edge)
    plan.param("edge", edge, "hole centre offset from the plate edge")
    corner_x = round(plate_l / 2.0 - edge, 3)
    corner_y = round(plate_w / 2.0 - edge, 3)
    plan.derived("corner_x", "plate[0] / 2 - edge", corner_x, "corner hole X")
    plan.derived("corner_y", "plate[1] / 2 - edge", corner_y, "corner hole Y")

    if variant == "four":
        centres = mirror_centres(corner_x, corner_y)
        symmetry = "mirror_xy"
        expressions = ["[corner_x, corner_y]", "[-corner_x, corner_y]",
                       "[-corner_x, -corner_y]", "[corner_x, -corner_y]"]
    elif variant == "six":
        centres = mirror_centres(corner_x, corner_y) + [[0.0, corner_y], [0.0, -corner_y]]
        symmetry = "mirror_xy"
        expressions = ["[corner_x, corner_y]", "[-corner_x, corner_y]",
                       "[-corner_x, -corner_y]", "[corner_x, -corner_y]",
                       "[0, corner_y]", "[0, -corner_y]"]
    elif variant == "eight":
        centres = mirror_centres(corner_x, corner_y) + [
            [0.0, corner_y], [0.0, -corner_y], [corner_x, 0.0], [-corner_x, 0.0]
        ]
        symmetry = "mirror_xy"
        expressions = ["[corner_x, corner_y]", "[-corner_x, corner_y]",
                       "[-corner_x, -corner_y]", "[corner_x, -corner_y]",
                       "[0, corner_y]", "[0, -corner_y]", "[corner_x, 0]", "[-corner_x, 0]"]
    else:  # three of the four corners
        centres = [[corner_x, corner_y], [-corner_x, corner_y], [-corner_x, -corner_y]]
        symmetry = "none"
        expressions = ["[corner_x, corner_y]", "[-corner_x, corner_y]", "[-corner_x, -corner_y]"]

    plan.derived(
        "feature_centers",
        "[\n" + feature_lines(expressions) + "\n]",
        None,
        "hole centres the loop below drills",
    )

    body = """// plate outline, every hole drilled through with the same cutters
difference() {
  cube(plate, center = true);
  for (centre = feature_centers)
    translate([centre[0], centre[1], 0])
      cylinder(d = hole_d, h = plate[2] + 2, center = true);
}"""

    probe_spec = {
        "kind": "void",
        "size_mm": round(min(hole_d * 0.5, thickness * 0.5, 3.0), 3),
        "z_mm": 0.0,
    }
    probes: list[Probe] = hole_probes(centres, hole_d, z=0.0, thickness=thickness)
    probes.append(solid_probe((0.0, 0.0, 0.0), min(hole_d, thickness) * 0.5, "plate centre"))
    edge_probe = min(hole_d, thickness) * 0.5
    if variant == "four":
        probes.append(solid_probe((corner_x, 0.0, 0.0), edge_probe, "mid edge X is solid"))
        probes.append(solid_probe((0.0, corner_y, 0.0), edge_probe, "mid edge Y is solid"))
    elif variant == "three":
        probes.append(solid_probe((corner_x, -corner_y, 0.0), edge_probe, "fourth corner is solid"))

    if variant == "three":
        ru_place = (
            f"{P.ru_count(count, 'отверстие', 'отверстия', 'отверстий')} ø{P.pnum(hole_d)} "
            f"в трёх углах из четырёх, отступ {P.pnum(edge)} мм от кромки"
        )
        en_place = (
            f"{count} holes Ø{P.pnum(hole_d)} mm in three of the four corners, "
            f"{P.pnum(edge)} mm in from the edge"
        )
    else:
        ru_place = P.corners_ru(rng, count, hole_d, edge, inch).rstrip(".")
        en_place = P.corners_en(rng, count, hole_d, edge, inch).rstrip(".")
    ru_features = [ru_place + ", отверстия сквозные."]
    en_features = [en_place + "; the holes go right through the plate."]
    if allow_ru:
        ru_features.append(allow_ru)
        en_features.append(allow_en)

    return make_part(
        family="cornerplates",
        variant=variant,
        rng=rng,
        plan=plan,
        body=body,
        bbox=(plate_l, plate_w, thickness),
        params={
            "plate_l": plate_l, "plate_w": plate_w, "thickness": thickness,
            "holes": float(count), "hole_d": hole_d, "edge": edge,
        },
        placement={
            "kind": "corners",
            "array": "feature_centers",
            "count": count,
            "centers_mm": [[round(x, 3), round(y, 3)] for x, y in centres],
            "symmetry": symmetry,
            "fields": {"edge_mm": edge, "hole_d_mm": hole_d},
            "probe": probe_spec,
        },
        probes=probes,
        ru_noun=NOUN_RU["cornerplates"],
        en_noun=NOUN_EN["cornerplates"],
        ru_features=ru_features,
        en_features=en_features,
        tolerance=rng.chance(0.2),
    )


# ---------------------------------------------------------------------------
# 2. flanges - N holes on a bolt circle, with a start angle
# ---------------------------------------------------------------------------

def build_boltcircles(index: int) -> PlacePart:
    rng = Rng("place1_boltcircles", index)
    variant = rng.choice(("plain", "hub", "plain"))
    flange_d = rng.grid([50.0, 60.0, 70.0, 85.0, 100.0, 120.0])
    thickness = rng.grid([6.0, 8.0, 10.0, 12.0, 15.0])
    count = rng.choice((4, 5, 6, 8, 10, 12))
    start_deg = rng.choice((0.0, 15.0, 22.5, 30.0, 45.0, 60.0, 90.0))
    hole_d = rng.grid([3.4, 4.5, 5.5, 6.6, 8.4])
    # keep a real rim outside the bolt holes: wall >= hole_d + 3 mm
    pcd = round(min(flange_d * rng.grid([0.62, 0.66, 0.7, 0.74]), flange_d - 2.0 * (hole_d + 3.0)), 3)
    bore_cap = pcd - hole_d - 8.0
    bore_d = min(rng.grid([12.0, 15.0, 20.0, 25.0, 30.0, 38.0]), bore_cap)
    if bore_d < 8.0:  # keep a sane bore for the small flanges
        bore_d = max(8.0, round(bore_cap, 3))
    hub_d = round(bore_d + rng.grid([8.0, 10.0, 12.0]), 3)
    hub_h = rng.grid([6.0, 8.0, 10.0, 12.0]) if variant == "hub" else 0.0
    total_h = thickness + hub_h

    plan = CodePlan(
        f"Flange Ø{flange_d:g} x {thickness:g}",
        f"{count} holes on a Ø{pcd:g} bolt circle, bolted joints",
    )
    plan.param("flange_d", flange_d, "outside diameter of the flange")
    tolerance_note(rng, plan)
    plan.param("thickness", thickness, "flange thickness")
    plan.param("holes", float(count), "number of bolt holes")
    plan.param("pcd", pcd, "bolt circle diameter")
    plan.param("start_deg", start_deg, "angle of the first hole, from +X")
    plan.param("hole_d", hole_d, "bolt hole diameter")
    plan.param("bore_d", bore_d, "central through bore")
    plan.param("hub_d", hub_d, "hub outside diameter")
    plan.param("hub_h", hub_h, "hub height above the flange face (0 = no hub)")
    plan.derived("height", "thickness + hub_h", round(total_h, 3), "overall height of the part")
    plan.derived("pcd_r", "pcd / 2", round(pcd / 2.0, 3), "bolt circle radius")
    plan.derived("hole_step", "360 / holes", round(360.0 / count, 3), "angular pitch")

    centres = []
    expressions = []
    for step in range(count):
        angle = start_deg + step * 360.0 / count
        x = round(pcd / 2.0 * math.cos(math.radians(angle)), 3)
        y = round(pcd / 2.0 * math.sin(math.radians(angle)), 3)
        centres.append([x, y])
        expressions.append(
            f"[pcd_r * cos(start_deg + {step} * hole_step), pcd_r * sin(start_deg + {step} * hole_step)]"
        )
    plan.derived(
        "feature_centers",
        "[\n" + feature_lines(expressions) + "\n]",
        None,
        "bolt hole centres on the pitch circle",
    )

    hub_block = ""
    if variant == "hub":
        hub_block = "\n    cylinder(d = hub_d, h = height);  // hub, overlapped into the flange"
    body = f"""// flange disc, every hole and the bore cut straight through
difference() {{
  union() {{
    cylinder(d = flange_d, h = thickness);{hub_block}
  }}
  translate([0, 0, -1]) cylinder(d = bore_d, h = height + 2);  // bore, through
  for (centre = feature_centers)
    translate([centre[0], centre[1], -1]) cylinder(d = hole_d, h = thickness + 2);
}}"""

    probe_spec = {
        "kind": "void",
        "size_mm": round(min(hole_d * 0.5, thickness * 0.5, 3.0), 3),
        "z_mm": round(thickness / 2.0, 3),
    }
    probes = hole_probes(centres, hole_d, z=thickness / 2.0, thickness=thickness)
    probes.append(
        Probe((0.0, 0.0, total_h / 2.0), "empty", min(bore_d * 0.5, thickness * 0.6), "central bore")
    )
    probe_angle = math.radians(start_deg + 180.0 / count)
    mid_r = (pcd / 2.0 + flange_d / 2.0) / 2.0
    web = (flange_d / 2.0 - pcd / 2.0 - hole_d / 2.0)
    if web > 1.2:
        probes.append(
            solid_probe(
                (mid_r * math.cos(probe_angle), mid_r * math.sin(probe_angle), thickness / 2.0),
                min(2.0, web / 2.0, thickness / 3.0),
                "web between bolt holes and rim",
            )
        )
    if variant == "hub":
        probes.append(
            solid_probe(
                ((bore_d / 2.0 + hub_d / 2.0) / 2.0, 0.0, thickness + hub_h / 2.0),
                min((hub_d - bore_d) / 4.0, hub_h / 2.0),
                "hub wall",
            )
        )

    ru_features = [
        P.bolt_circle_ru(rng, count, hole_d, pcd, start_deg).rstrip("."),
        f"центральное отверстие ø{P.pnum(bore_d)} сквозное",
    ]
    en_features = [
        P.bolt_circle_en(rng, count, hole_d, pcd, start_deg).rstrip("."),
        f"the Ø{P.pnum(bore_d)} mm centre bore goes all the way through",
    ]
    if variant == "hub":
        ru_features.append(f"сверху ступица ø{P.pnum(hub_d)} мм высотой {P.pnum(hub_h)} мм")
        en_features.append(f"a Ø{P.pnum(hub_d)} x {P.pnum(hub_h)} mm hub stands on the flange face")

    return make_part(
        family="boltcircles",
        variant=variant,
        rng=rng,
        plan=plan,
        body=body,
        bbox=(flange_d, flange_d, total_h),
        params={
            "flange_d": flange_d, "thickness": thickness, "holes": float(count),
            "pcd": pcd, "start_deg": start_deg, "hole_d": hole_d, "bore_d": bore_d,
            "hub_d": hub_d, "hub_h": hub_h,
        },
        placement={
            "kind": "bolt_circle",
            "array": "feature_centers",
            "count": count,
            "centers_mm": centres,
            "symmetry": "rotational",
            "fields": {"pcd_mm": pcd, "start_deg": start_deg, "hole_d_mm": hole_d},
            "probe": probe_spec,
        },
        probes=probes,
        ru_noun=NOUN_RU["boltcircles"],
        en_noun=NOUN_EN["boltcircles"],
        ru_features=ru_features,
        en_features=en_features,
        tolerance=rng.chance(0.2),
    )


# ---------------------------------------------------------------------------
# 3. perforated panels - straight grid, checkerboard, perimeter ring
# ---------------------------------------------------------------------------

def build_perfpanels(index: int) -> PlacePart:
    rng = Rng("place1_perfpanels", index)
    variant = rng.choice(("grid", "checker", "frame", "grid"))
    panel_l = rng.grid([90.0, 120.0, 150.0, 180.0, 210.0])
    panel_w = rng.grid([50.0, 70.0, 90.0, 110.0])
    thickness = rng.grid([5.0, 6.0, 8.0, 10.0])
    hole_d = rng.grid([4.5, 5.5, 6.6, 8.4])
    pitch_x = max(rng.grid([18.0, 20.0, 25.0, 30.0]), hole_d + 4.0)
    pitch_y = max(rng.grid([16.0, 20.0, 25.0]), hole_d + 4.0)

    # the row/column counts follow from the panel, the pitch and the edge
    # allowance - they are derived in the code, never typed in twice.  The pitch
    # is first capped so that at least three rows and three columns always fit.
    margin = hole_d / 2.0 + 2.0
    pitch_x = min(pitch_x, round((panel_l - 2.0 * margin) / 3.0, 3))
    pitch_y = min(pitch_y, round((panel_w - 2.0 * margin) / 3.0, 3))
    pitch_x = max(pitch_x, hole_d + 4.0)
    pitch_y = max(pitch_y, hole_d + 4.0)
    extra = pitch_x / 2.0 if variant == "checker" else 0.0
    # math.floor(a / b) is bit-for-bit what the OpenSCAD `floor(a / b)` in the
    # derived block computes; Python's // rounds differently on exact multiples
    # (59.4 / 19.8), which would desynchronise the manifest from the geometry.
    cols = math.floor((panel_l - 2.0 * margin - extra) / pitch_x) + 1
    rows = math.floor((panel_w - 2.0 * margin) / pitch_y) + 1
    span_x = round((cols - 1) * pitch_x + extra, 3)
    span_y = round((rows - 1) * pitch_y, 3)
    offset = round(pitch_x / 2.0, 3)

    plan = CodePlan(
        f"Perforated panel {panel_l:g} x {panel_w:g} x {thickness:g}",
        f"{rows} x {cols} Ø{hole_d:g} holes, {variant} layout",
    )
    plan.param("panel", [panel_l, panel_w, thickness], "overall size (x, y, z)")
    tolerance_note(rng, plan)
    plan.param("hole_d", hole_d, "hole diameter")
    plan.param("pitch_x", pitch_x, "hole pitch along X")
    plan.param("pitch_y", pitch_y, "hole pitch along Y")
    plan.derived("margin", "hole_d / 2 + 2", round(margin, 3), "clearance from the panel edge")
    if variant == "checker":
        plan.derived("row_offset", "pitch_x / 2", offset, "shift of every other row")
        plan.derived(
            "cols",
            "floor((panel[0] - 2 * margin - row_offset) / pitch_x) + 1",
            float(cols),
            "how many columns fit in X",
        )
    else:
        plan.derived(
            "cols", "floor((panel[0] - 2 * margin) / pitch_x) + 1", float(cols), "how many columns fit in X"
        )
    plan.derived(
        "rows", "floor((panel[1] - 2 * margin) / pitch_y) + 1", float(rows), "how many rows fit in Y"
    )
    plan.derived("span_x", "(cols - 1) * pitch_x + " + ("row_offset" if variant == "checker" else "0"),
                 span_x, "width of the field")
    plan.derived("span_y", "(rows - 1) * pitch_y", span_y, "height of the field")
    plan.derived("origin_x", "-span_x / 2", round(-span_x / 2.0, 3), "X of the first hole")
    plan.derived("origin_y", "-span_y / 2", round(-span_y / 2.0, 3), "Y of the first row")

    indices: list[tuple[int, int]] = []
    if variant == "grid":
        indices = [(i, j) for j in range(rows) for i in range(cols)]
        symmetry = "mirror_xy"
    elif variant == "checker":
        indices = [(i, j) for j in range(rows) for i in range(cols)]
        symmetry = "none"
    else:
        indices = sorted(
            {(i, j) for j in range(rows) for i in range(cols)}
            - {(i, j) for j in range(1, rows - 1) for i in range(1, cols - 1)}
        )
        symmetry = "mirror_xy"

    centres: list[list[float]] = []
    expressions: list[str] = []
    for i, j in indices:
        shift = offset if (variant == "checker" and j % 2) else 0.0
        x = round(-span_x / 2.0 + shift + i * pitch_x, 3)
        y = round(-span_y / 2.0 + j * pitch_y, 3)
        centres.append([x, y])
        shift_term = " + row_offset" if shift else ""
        expressions.append(f"[origin_x{shift_term} + {i} * pitch_x, origin_y + {j} * pitch_y]")

    total = len(centres)
    if variant == "frame":
        plan.derived("holes", "2 * cols + 2 * (rows - 2)", float(total), "holes around the frame")
    else:
        plan.derived("holes", "rows * cols", float(total), "holes in total")
    plan.derived(
        "feature_centers",
        "[\n" + feature_lines(expressions) + "\n]",
        None,
        "hole centres, used verbatim by the cutter loop",
    )

    body = """// panel outline, every hole through
difference() {
  cube(panel, center = true);
  for (centre = feature_centers)
    translate([centre[0], centre[1], 0])
      cylinder(d = hole_d, h = panel[2] + 2, center = true);
}"""

    probe_spec = {
        "kind": "void",
        "size_mm": round(min(hole_d * 0.5, thickness * 0.5, 3.0), 3),
        "z_mm": 0.0,
    }
    probes = hole_probes(centres, hole_d, z=0.0, thickness=thickness)
    cell_x = round(centres[0][0] + pitch_x / 2.0, 3)
    cell_y = round(centres[0][1] + pitch_y / 2.0, 3)
    probes.append(
        solid_probe((cell_x, cell_y, 0.0),
                    min((pitch_x - hole_d) / 3.0, (pitch_y - hole_d) / 3.0, 3.0),
                    "material between four holes")
    )
    if variant == "frame":
        probes.append(
            solid_probe((0.0, 0.0, 0.0), min((pitch_x - hole_d) / 3.0, 3.0), "panel centre is solid")
        )

    fields = {
        "pitch_x_mm": pitch_x, "pitch_y_mm": pitch_y,
        "origin_x_mm": round(-span_x / 2.0, 3), "origin_y_mm": round(-span_y / 2.0, 3),
    }
    if variant == "checker":
        fields["row_offset_mm"] = offset
    ru_features = []
    en_features = []
    if variant == "grid":
        ru_features.append(P.field_ru(rng, rows, cols, hole_d, pitch_x, pitch_y).rstrip("."))
        en_features.append(P.field_en(rng, rows, cols, hole_d, pitch_x, pitch_y).rstrip("."))
    elif variant == "checker":
        ru_features.append(P.staggered_ru(rng, rows, cols, hole_d, pitch_x, pitch_y, offset).rstrip("."))
        en_features.append(P.staggered_en(rng, rows, cols, hole_d, pitch_x, pitch_y, offset).rstrip("."))
    else:
        ru_features.append(P.frame_ru(rng, total, hole_d, pitch_x, pitch_y).rstrip("."))
        en_features.append(P.frame_en(rng, total, hole_d, pitch_x, pitch_y).rstrip("."))
    ru_features.append("поле по центру панели, отверстия сквозные")
    en_features.append("the field is centred on the panel, holes through")

    return make_part(
        family="perfpanels",
        variant=variant,
        rng=rng,
        plan=plan,
        body=body,
        bbox=(panel_l, panel_w, thickness),
        params={
            "panel_l": panel_l, "panel_w": panel_w, "thickness": thickness, "hole_d": hole_d,
            "pitch_x": pitch_x, "pitch_y": pitch_y, "rows": float(rows), "cols": float(cols),
            "holes": float(total),
        },
        placement={
            "kind": "perforation",
            "array": "feature_centers",
            "count": total,
            "centers_mm": centres,
            "symmetry": symmetry,
            "fields": fields,
            "probe": probe_spec,
        },
        probes=probes,
        ru_noun=NOUN_RU["perfpanels"],
        en_noun=NOUN_EN["perfpanels"],
        ru_features=ru_features,
        en_features=en_features,
        tolerance=rng.chance(0.2),
    )


# ---------------------------------------------------------------------------
# 4. rib frames - ribs at a pitch, optionally staggered
# ---------------------------------------------------------------------------

def build_ribframes(index: int) -> PlacePart:
    rng = Rng("place1_ribframes", index)
    variant = rng.choice(("row", "row", "staggered"))
    frame_l = rng.grid([120.0, 150.0, 180.0, 220.0])
    frame_w = rng.grid([60.0, 80.0, 100.0])
    base_t = rng.grid([4.0, 5.0, 6.0, 8.0])
    rail_w = round(rng.grid([6.0, 8.0, 10.0]), 3)
    rib_t = round(rng.grid([3.0, 4.0, 5.0, 6.0]), 3)
    rib_h = rng.grid([10.0, 15.0, 20.0, 25.0])
    count = rng.integer(4, 9)
    pitch = rng.grid([18.0, 20.0, 25.0, 30.0])
    inner_w = frame_w - 2.0 * rail_w
    # ribs must fit between the rails with clearance
    while (count - 1) * pitch + rib_t > frame_l - 2.0 * rail_w - 8.0:
        count -= 1
    ragged = variant == "staggered"

    plan = CodePlan(
        f"Rib frame {frame_l:g} x {frame_w:g} x {base_t + rib_h:g}",
        f"{count} ribs at {pitch:g} mm pitch" + (", staggered" if ragged else ""),
    )
    plan.param("frame", [frame_l, frame_w, base_t], "base plate size (x, y, z)")
    tolerance_note(rng, plan)
    plan.param("rail_w", rail_w, "side rail width")
    plan.param("ribs", float(count), "number of ribs")
    plan.param("rib_t", rib_t, "rib thickness")
    plan.param("rib_h", rib_h, "rib height above the base plate")
    plan.param("pitch", pitch, "pitch between rib centres")
    span = (count - 1) * pitch
    origin_x = round(-span / 2.0, 3)
    plan.derived("span", "(ribs - 1) * pitch", round(span, 3), "distance between the outer ribs")
    plan.derived("origin_x", "-span / 2", origin_x, "X of the first rib")
    if ragged:
        # half-length ribs, alternating between the two rails; they overlap the
        # rail by 1 mm and stop 0.5 mm short of the centre line, so neighbouring
        # ribs never touch each other
        rib_len = round(frame_w / 2.0 - rail_w + 0.5, 3)
        rib_y = round(0.5 + rib_len / 2.0, 3)
        plan.derived("rib_len", "frame[1] / 2 - rail_w + 0.5", rib_len, "length of a staggered rib")
        plan.derived("rib_y", "0.5 + rib_len / 2", rib_y, "Y of a staggered rib centre")
        plan.derived("row_offset", "2 * rib_y", round(2.0 * rib_y, 3), "distance between the two rows")
        centres = [
            [round(origin_x + step * pitch, 3), rib_y if step % 2 == 0 else -rib_y]
            for step in range(count)
        ]
        expressions = [
            f"[origin_x + {step} * pitch, {'rib_y' if step % 2 == 0 else '-rib_y'}]"
            for step in range(count)
        ]
        spacing = pitch
    else:
        plan.derived("rib_len", "frame[1] - 2 * rail_w + 2", round(frame_w - 2.0 * rail_w + 2.0, 3),
                     "rib length, 1 mm into each rail")
        centres = [[round(origin_x + step * pitch, 3), 0.0] for step in range(count)]
        expressions = [f"[origin_x + {step} * pitch, 0]" for step in range(count)]
        spacing = pitch

    plan.derived(
        "feature_centers",
        "[\n" + feature_lines(expressions) + "\n]",
        None,
        "rib centre line, drives the rib loop",
    )

    body = """// base plate, two side rails, then the ribs read straight off feature_centers
union() {
  translate([-frame[0] / 2, -frame[1] / 2, 0]) cube(frame);
  translate([-frame[0] / 2, -frame[1] / 2, 0]) cube([frame[0], rail_w, frame[2] + rib_h]);
  translate([-frame[0] / 2, frame[1] / 2 - rail_w, 0]) cube([frame[0], rail_w, frame[2] + rib_h]);
  for (centre = feature_centers)
    translate([centre[0] - rib_t / 2, centre[1] - rib_len / 2, frame[2] - 1])
      cube([rib_t, rib_len, rib_h + 1]);
}"""

    z_rib = base_t + rib_h / 2.0
    probe_spec = {
        "kind": "solid",
        "size_mm": round(min(rib_t / 2.0, rib_h / 3.0, 2.0), 3),
        "z_mm": round(z_rib, 3),
    }
    probes: list[Probe] = [
        Probe((centre[0], centre[1], z_rib), "solid", min(rib_t / 2.0, rib_h / 3.0, 2.0), f"rib {i}")
        for i, centre in enumerate(centres)
    ]
    gap_probe_z = base_t + rib_h / 2.0
    for first, second in zip(centres, centres[1:]):
        if first[0] == second[0]:
            continue
        gap_x = round((first[0] + second[0]) / 2.0, 3)
        gap_size = min(abs(second[0] - first[0] - rib_t) / 3.0, rib_h / 3.0)
        if gap_size > 0.3:
            probes.append(Probe((gap_x, 0.0, gap_probe_z), "empty", gap_size, "gap between ribs"))
    for side in (1.0, -1.0):
        probes.append(
            solid_probe(
                (frame_l / 2.0 - rail_w / 2.0, side * (frame_w / 2.0 - rail_w / 2.0), z_rib),
                min(rail_w / 3.0, rib_h / 3.0),
                "side rail",
            )
        )
    probes.append(
        solid_probe((0.0, 0.0, base_t / 2.0), min(base_t / 3.0, 2.0), "base plate is solid")
    )

    row_offset = round(2.0 * (0.5 + (frame_w / 2.0 - rail_w + 0.5) / 2.0), 3) if ragged else 0.0
    ru_features = [P.ribs_ru(rng, count, rib_t, pitch, ragged, row_offset, rib_h).rstrip(".")]
    en_features = [P.ribs_en(rng, count, rib_t, pitch, ragged, row_offset, rib_h).rstrip(".")]
    ru_features.append(
        f"основание {P.pnum(base_t)} мм, боковые рейки шириной {P.pnum(rail_w)} мм"
    )
    en_features.append(f"{P.pnum(base_t)} mm base plate with {P.pnum(rail_w)} mm side rails")

    bbox = (frame_l, frame_w, base_t + rib_h)
    return make_part(
        family="ribframes",
        variant=variant,
        rng=rng,
        plan=plan,
        body=body,
        bbox=bbox,
        params={
            "frame_l": frame_l, "frame_w": frame_w, "base_t": base_t, "rail_w": rail_w,
            "ribs": float(count), "rib_t": rib_t, "rib_h": rib_h, "pitch": pitch,
            "row_offset": row_offset,
        },
        placement={
            "kind": "rib_row",
            "array": "feature_centers",
            "count": len(centres),
            "centers_mm": centres,
            # a staggered set alternates sides, so it is not mirror symmetric
            "symmetry": "mirror_y" if not ragged else "none",
            "fields": {"pitch_mm": spacing, "rib_t_mm": rib_t, "ribs_mm": float(count)},
            "probe": probe_spec,
        },
        probes=probes,
        ru_noun=NOUN_RU["ribframes"],
        en_noun=NOUN_EN["ribframes"],
        ru_features=ru_features,
        en_features=en_features,
        tolerance=rng.chance(0.2),
    )


# ---------------------------------------------------------------------------
# 5. hole bars - a row of holes, every other slot, or two rows
# ---------------------------------------------------------------------------

def build_ventrows(index: int) -> PlacePart:
    rng = Rng("place1_ventrows", index)
    variant = rng.choice(("row", "skip", "tworows"))
    count = rng.integer(4, 9)
    bar_w = rng.grid([20.0, 25.0, 30.0, 40.0])
    bar_t = rng.grid([5.0, 6.0, 8.0, 10.0])
    hole_d = rng.grid([4.5, 5.5, 6.6, 8.4])
    pitch = rng.grid([20.0, 25.0, 30.0, 35.0])
    edge, inch = inch_or_round(rng, [10.0, 12.0, 15.0, 20.0], chance=0.25, max_mm=30.0)
    if variant == "tworows":
        row_offset = round(rng.grid([12.0, 15.0, 18.0, 20.0]), 3)
        bar_w = max(bar_w, row_offset + 2.0 * (hole_d / 2.0 + 2.0))
        pitch = max(pitch, hole_d + 5.0)
    else:
        row_offset = 0.0
        bar_w = max(bar_w, 2.0 * (hole_d / 2.0 + 2.0))
    # keep the bar inside the 250 mm limit of the request
    while (count - 1) * pitch + 2.0 * edge > 240.0 and count > 4:
        count -= 1
    grid_pitch = round(pitch / 2.0, 3)

    plan = CodePlan(
        f"Hole bar, {count} x Ø{hole_d:g}",
        f"{variant} layout, {edge:g} mm edge offset",
    )
    plan.param("bar_w", bar_w, "bar width (Y)")
    tolerance_note(rng, plan)
    plan.param("bar_t", bar_t, "bar thickness (Z)")
    plan.param("holes", float(count), "holes per row")
    plan.param("hole_d", hole_d, "hole diameter")
    plan.param("edge", edge, "offset from the bar end to the first hole")
    if variant == "skip":
        plan.param("grid_pitch", grid_pitch, "grid the bar was laid out on")
        plan.derived("pitch", "grid_pitch * 2", pitch, "holes sit every other grid slot")
    else:
        plan.param("pitch", pitch, "pitch between neighbouring holes")
    if variant == "tworows":
        plan.param("row_offset", row_offset, "distance between the two rows")
    span = round((count - 1) * pitch, 3)
    bar_l = round(span + 2.0 * edge, 3)
    plan.derived("span", "(holes - 1) * pitch", span, "distance between the end holes")
    plan.derived("bar_l", "span + 2 * edge", bar_l, "overall bar length")
    plan.derived("start_x", "-bar_l / 2 + edge", round(-bar_l / 2.0 + edge, 3), "X of the first hole")

    # the arrays carry the real Y of each row, the geometry reads them as they are
    y_first = -row_offset / 2.0 if variant == "tworows" else 0.0
    y_second = row_offset / 2.0
    expressions = [
        f"[start_x + {step} * pitch, {'-row_offset / 2' if variant == 'tworows' else '0'}]"
        for step in range(count)
    ]
    centres = [
        [round(-bar_l / 2.0 + edge + step * pitch, 3), round(y_first, 3)] for step in range(count)
    ]
    plan.derived(
        "feature_centers",
        "[\n" + feature_lines(expressions) + "\n]",
        None,
        "hole centres of the first row",
    )
    extra: list[dict] = []
    if variant == "tworows":
        plan.derived(
            "row2_centers",
            "[\n" + feature_lines([f"[start_x + {step} * pitch, row_offset / 2]" for step in range(count)]) + "\n]",
            None,
            "hole centres of the second row",
        )
        extra = [
            {
                "array": "row2_centers",
                "count": count,
                "centers_mm": [
                    [round(-bar_l / 2.0 + edge + step * pitch, 3), round(y_second, 3)]
                    for step in range(count)
                ],
                "fields": {"pitch_mm": pitch},
            }
        ]

    if variant == "tworows":
        body = """// bar with two rows of holes, both read from their own centre arrays
difference() {
  translate([-bar_l / 2, -bar_w / 2, -bar_t / 2]) cube([bar_l, bar_w, bar_t]);
  for (centre = feature_centers)
    translate([centre[0], centre[1], 0])
      cylinder(d = hole_d, h = bar_t + 2, center = true);
  for (centre = row2_centers)
    translate([centre[0], centre[1], 0])
      cylinder(d = hole_d, h = bar_t + 2, center = true);
}"""
        probes = hole_probes(centres, hole_d, z=0.0, thickness=bar_t, label="row 1")
        probes += hole_probes(
            [[x, y_second] for x, _ in centres], hole_d, z=0.0, thickness=bar_t, label="row 2"
        )
        probes.append(
            solid_probe(
                (round(centres[0][0] + pitch / 2.0, 3), 0.0, 0.0),
                min((pitch - hole_d) / 3.0, row_offset / 4.0, 3.0),
                "material between the two rows",
            )
        )
    else:
        body = """// bar with one row of holes, drilled from feature_centers
difference() {
  translate([-bar_l / 2, -bar_w / 2, -bar_t / 2]) cube([bar_l, bar_w, bar_t]);
  for (centre = feature_centers)
    translate([centre[0], centre[1], 0])
      cylinder(d = hole_d, h = bar_t + 2, center = true);
}"""
        probes = hole_probes(centres, hole_d, z=0.0, thickness=bar_t)
        probes.append(
            solid_probe(
                (round(centres[0][0] + pitch / 2.0, 3), 0.0, 0.0),
                min((pitch - hole_d) / 3.0, (bar_w - hole_d) / 3.0, 3.0),
                "material between the holes",
            )
        )
        probes.append(
            solid_probe((0.0, round(bar_w / 2.0 - 1.5, 3), 0.0), min(1.0, bar_t / 3.0), "bar edge is solid")
        )

    if variant == "row":
        ru_features = [P.row_ru(rng, count, hole_d, pitch, edge).rstrip(".")]
        en_features = [P.row_en(rng, count, hole_d, pitch, edge).rstrip(".")]
    elif variant == "skip":
        ru_features = [P.skip_row_ru(rng, count, hole_d, pitch, grid_pitch, edge).rstrip(".")]
        en_features = [P.skip_row_en(rng, count, hole_d, pitch, grid_pitch, edge).rstrip(".")]
    else:
        ru_features = [P.two_rows_ru(rng, count, hole_d, pitch, row_offset, edge).rstrip(".")]
        en_features = [P.two_rows_en(rng, count, hole_d, pitch, row_offset, edge).rstrip(".")]
    if inch:
        ru_features.append(f"первое отверстие в {P.pnum(edge)} мм от торца{P.inch_note_ru(inch)}")
        en_features.append(f"the first hole sits {P.pnum(edge)} mm from the end{P.inch_note_en(inch)}")
    ru_features.append("отверстия сквозные, по оси симметрии планки")
    en_features.append("holes through the bar, on the bar centre line")

    probe_spec = {
        "kind": "void",
        "size_mm": round(min(hole_d * 0.5, bar_t * 0.5, 3.0), 3),
        "z_mm": 0.0,
    }
    bbox = (bar_l, bar_w, bar_t)
    return make_part(
        family="ventrows",
        variant=variant,
        rng=rng,
        plan=plan,
        body=body,
        bbox=bbox,
        params={
            "bar_l": bar_l, "bar_w": bar_w, "bar_t": bar_t, "holes": float(count),
            "hole_d": hole_d, "pitch": pitch, "edge": edge, "row_offset": row_offset,
            "grid_pitch": grid_pitch,
        },
        placement={
            "kind": "row",
            "array": "feature_centers",
            "count": count,
            "centers_mm": centres,
            "symmetry": "mirror_y",
            "fields": {"pitch_mm": pitch, "edge_mm": edge, "hole_d_mm": hole_d},
            "probe": probe_spec,
            "extra": extra,
        },
        probes=probes,
        ru_noun=NOUN_RU["ventrows"],
        en_noun=NOUN_EN["ventrows"],
        ru_features=ru_features,
        en_features=en_features,
        tolerance=rng.chance(0.2),
    )


BUILDERS = {
    "cornerplates": build_cornerplates,
    "boltcircles": build_boltcircles,
    "perfpanels": build_perfpanels,
    "ribframes": build_ribframes,
    "ventrows": build_ventrows,
}
