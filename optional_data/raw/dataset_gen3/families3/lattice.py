"""gen3 lattice work: hexagonal cell panels and slotted panels with variable pitch."""

from __future__ import annotations

import math

from tools.dataset_gen2.common import Part, Rng, ScadBuilder, fmt
from tools.dataset_gen2.prompts import en_count, ru_count
from tools.dataset_gen3.prompts3 import finish_part3
from tools.dataset_gen3.toolkit import num

HEX_RU = ("гексагональная решётка", "панель с сотами", "сотовая панель", "решётка с шестиугольными ячейками")
HEX_EN = ("hex cell lattice", "honeycomb panel", "hexagonal grid panel", "hex cell plate")
SLOT_RU = ("перфорированная панель", "панель с переменным шагом прорезей", "решётчатая панель с прорезями", "панель с щелями")
SLOT_EN = ("slotted panel", "variable pitch slotted plate", "slotted grille panel", "vent panel with slots")


def build_hexlattices(index: int) -> Part:
    """Honeycomb panel: point-up hexagons cut through a plate, optional tray rim."""
    rng = Rng("gen3_hexlattices", index)
    variant = rng.choice(("flat", "flat", "tray"))
    cell_r = rng.grid([5.0, 6.0, 7.0, 8.0])
    web = rng.grid([1.6, 2.0, 2.4, 3.0])
    pitch = round(cell_r * math.sqrt(3) + web, 3)
    columns = rng.integer(4, 8)
    rows = rng.integer(3, 6)
    thick = rng.grid([5.0, 6.0, 8.0, 10.0])
    rim_h = round(thick + rng.grid([4.0, 6.0, 8.0]), 2)
    rim_t = rng.grid([3.0, 4.0, 5.0])
    mount_d = rng.grid([4.4, 5.4])
    border = rng.grid([4.0, 5.0, 6.0])
    border = max(border, mount_d + 3.0)
    if variant == "tray":
        border = max(border, rim_t + 2.0)
    total_h = rim_h if variant == "tray" else thick

    centres = []
    for row in range(rows):
        for column in range(columns):
            x = column * pitch + (pitch / 2 if row % 2 else 0.0)
            y = row * pitch * math.sqrt(3) / 2
            centres.append((x, y))
    half_x = cell_r * math.sqrt(3) / 2
    x_min = min(x for x, _ in centres) - half_x
    x_max = max(x for x, _ in centres) + half_x
    y_min = min(y for _, y in centres) - cell_r
    y_max = max(y for _, y in centres) + cell_r
    panel_w = round(x_max - x_min + 2 * border, 2)
    panel_d = round(y_max - y_min + 2 * border, 2)
    shift_x = round(border - x_min, 3)
    shift_y = round(border - y_min, 3)
    hole_off = round(border / 2, 2)
    corner_holes = [
        (hole_off, hole_off),
        (round(panel_w - hole_off, 2), hole_off),
        (hole_off, round(panel_d - hole_off, 2)),
        (round(panel_w - hole_off, 2), round(panel_d - hole_off, 2)),
    ]

    builder = ScadBuilder(
        "Honeycomb panel",
        f"{fmt(panel_w)} x {fmt(panel_d)} mm, {len(centres)} cells of {fmt(2 * cell_r)} mm",
    )
    builder.param("panel_w", panel_w, "panel width")
    builder.param("panel_d", panel_d, "panel depth")
    builder.param("thick", thick, "panel thickness")
    builder.param("cell_r", cell_r, "hex cell circumradius")
    builder.param("pitch", pitch, "hex cell pitch (centre to centre)")
    builder.param("web", web, "web between the cells")
    builder.param("columns", float(columns), "columns of cells")
    builder.param("rows", float(rows), "rows of cells")
    builder.param("cell_count", float(len(centres)), "total cells")
    builder.param("shift_x", shift_x, "first cell offset in x")
    builder.param("shift_y", shift_y, "first cell offset in y")
    builder.param("mount_d", mount_d, "corner mounting holes")
    builder.param("hole_off", hole_off, "mounting hole offset from the corners")
    if variant == "tray":
        builder.param("rim_h", rim_h, "rim height")
        builder.param("rim_t", rim_t, "rim wall thickness")

    lines = [
        "difference() {",
        "  union() {",
        "    cube([panel_w, panel_d, thick]);",
    ]
    if variant == "tray":
        lines.append("    /* rim around the panel, sunk 1 mm into the plate */")
        lines.append("    translate([0, 0, thick - 1]) difference() {")
        lines.append("      cube([panel_w, panel_d, rim_h - thick + 1]);")
        lines.append(
            "      translate([rim_t, rim_t, -2.5]) cube([panel_w - 2 * rim_t, panel_d - 2 * rim_t, rim_h - thick + 6]);"
        )
        lines.append("    }")
    lines.append("  }")
    lines.append("  /* hexagonal cells, point-up, cut right through the plate */")
    lines.append("  for (row = [0 : rows - 1]) {")
    lines.append("    for (col = [0 : columns - 1]) {")
    lines.append(
        "      translate([shift_x + col * pitch + (row % 2) * pitch / 2,"
        " shift_y + row * pitch * " + num(round(math.sqrt(3) / 2, 6), 6) + ", -2.5])"
        " rotate([0, 0, 30]) cylinder(h = thick + 5, d = 2 * cell_r, $fn = 6);"
    )
    lines.append("    }")
    lines.append("  }")
    lines.append("  /* corner mounting holes, clear of the outer cell web */")
    for hx, hy in corner_holes:
        lines.append(
            "  translate([%s, %s, -2.5]) cylinder(h = thick + 5, d = mount_d);" % (num(hx, 3), num(hy, 3))
        )
    lines.append("}")
    builder.section("\n".join(lines))
    code = builder.render()

    bbox = (float(panel_w), float(panel_d), float(total_h))
    features_ru = [
        f"{ru_count(len(centres), 'шестиугольная ячейка', 'шестиугольные ячейки', 'шестиугольных ячеек')} "
        f"с шагом {fmt(pitch)} мм и перемычкой {fmt(web)} мм",
        f"плита {fmt(thick)} мм, размер ячейки {fmt(2 * cell_r)} мм",
        f"{ru_count(4, 'крепёжное отверстие', 'крепёжных отверстия', 'крепёжных отверстий')} {fmt(mount_d)} мм по углам",
    ]
    features_en = [
        f"{en_count(len(centres))} hexagonal cells on a {fmt(pitch)} mm pitch with {fmt(web)} mm webs",
        f"a {fmt(thick)} mm plate with {fmt(2 * cell_r)} mm cells",
        f"{en_count(4)} {fmt(mount_d)} mm mounting holes in the corners",
    ]
    if variant == "tray":
        features_ru.append(f"бортик {fmt(rim_h)} мм высотой {fmt(rim_t)} мм толщиной")
        features_en.append(f"a {fmt(rim_h)} mm rim, {fmt(rim_t)} mm thick")
    return finish_part3(
        rng,
        family="hexlattices",
        variant=variant,
        code=code,
        bbox=bbox,
        params={"panel_w": panel_w, "panel_d": panel_d, "height": total_h, "web": web, "cell_r": cell_r},
        ru_nouns=HEX_RU,
        en_nouns=HEX_EN,
        features_ru=features_ru,
        features_en=features_en,
    )


def build_slottedpanels(index: int) -> Part:
    """Slotted panel: parallel slots whose pitch and length vary across the plate."""
    rng = Rng("gen3_slottedpanels", index)
    variant = rng.choice(("pitch", "pitch", "length", "grille"))
    panel_w = rng.grid([120.0, 150.0, 180.0, 200.0])
    panel_d = rng.grid([70.0, 80.0, 90.0, 100.0])
    thick = rng.grid([5.0, 6.0, 8.0])
    slot_w = rng.grid([5.0, 6.0, 7.0])
    pitch0 = round(slot_w + rng.grid([4.0, 5.0, 6.0]), 2)
    pitch_step = rng.grid([1.2, 1.8, 2.4])
    margin = rng.grid([8.0, 10.0, 12.0])
    rim_h = round(thick + rng.grid([5.0, 7.0]), 2)
    rim_t = rng.grid([3.0, 4.0])
    mount_d = rng.grid([5.4, 6.6])
    mount_x = round(panel_w / 2 - rng.grid([12.0, 15.0]), 2)
    margin = max(margin, round(mount_d + 3.0, 2))

    rows: list[tuple[float, float, float]] = []
    y = margin + slot_w / 2
    row_index = 0
    while y + slot_w / 2 <= panel_d - margin + 1e-6 and len(rows) < 20:
        if variant == "pitch":
            pitch = round(pitch0 + row_index * pitch_step, 2)
        elif variant == "length":
            pitch = pitch0
        else:
            pitch = round(pitch0 + (pitch_step if row_index % 2 else 0.0), 2)
        if y + slot_w / 2 > panel_d - margin + 1e-6:
            break
        if variant == "length":
            length = round((panel_w - 2 * margin) * (0.4 + 0.12 * min(row_index, 5)), 2)
        elif variant == "grille":
            length = round(panel_w - 2 * margin, 2)
        else:
            length = round((panel_w - 2 * margin) * (0.7 + 0.05 * min(row_index, 4)), 2)
        length = min(length, panel_w - 2 * margin)
        rows.append((round(y, 2), pitch, length))
        y += pitch
        row_index += 1
    max_length = max(length for _, _, length in rows)
    if variant == "length":
        rows = [(y, pitch, round(min(length, max_length), 2)) for y, pitch, length in rows]
    total_h = rim_h if variant in ("pitch", "length") and rng.chance(0.5) else thick
    with_rim = total_h > thick

    builder = ScadBuilder(
        "Slotted panel",
        f"{fmt(panel_w)} x {fmt(panel_d)} mm, {ru_count(len(rows), 'ряд', 'ряда', 'рядов')} of slots",
    )
    builder.param("panel_w", panel_w, "panel width")
    builder.param("panel_d", panel_d, "panel depth")
    builder.param("thick", thick, "panel thickness")
    builder.param("slot_w", slot_w, "slot width")
    builder.param("pitch0", pitch0, "first row pitch")
    builder.param("pitch_step", pitch_step, "pitch increase per row")
    builder.param("margin", margin, "margin around the slot field")
    builder.param("rows", float(len(rows)), "number of slot rows")
    builder.param("mount_d", mount_d, "mounting holes")
    builder.param("mount_x", mount_x, "mounting hole offset")
    if with_rim:
        builder.param("rim_h", rim_h, "rim height")
        builder.param("rim_t", rim_t, "rim wall thickness")

    lines = [
        "difference() {",
        "  union() {",
        "    cube([panel_w, panel_d, thick]);",
    ]
    if with_rim:
        lines.append("    translate([0, 0, thick - 1]) difference() {")
        lines.append("      cube([panel_w, panel_d, rim_h - thick + 1]);")
        lines.append(
            "      translate([rim_t, rim_t, -2.5]) cube([panel_w - 2 * rim_t, panel_d - 2 * rim_t, rim_h - thick + 6]);"
        )
        lines.append("    }")
    lines.append("  }")
    lines.append("  /* slot rows: stadium shaped cutters, 2.5 mm clear of both faces */")
    for row_index, (y, pitch, length) in enumerate(rows):
        x0 = round((panel_w - length) / 2, 2)
        x1 = round(x0 + length, 2)
        lines.append("  /* row " + str(row_index) + ": pitch " + num(pitch, 3) + ", length " + num(length, 3) + " */")
        lines.append("  hull() {")
        lines.append(
            "    translate([%s, %s, -2.5]) cylinder(h = thick + 5, d = slot_w);" % (num(x0, 3), num(y, 3))
        )
        lines.append(
            "    translate([%s, %s, -2.5]) cylinder(h = thick + 5, d = slot_w);" % (num(x1, 3), num(y, 3))
        )
        lines.append("  }")
    hole_h = (rim_h if with_rim else thick) + 5
    for hx in (-mount_x, mount_x):
        for hy in (round(margin / 2, 2), round(panel_d - margin / 2, 2)):
            lines.append(
                "  translate([%s, %s, -2.5]) cylinder(h = %s, d = mount_d);"
                % (num(panel_w / 2 + hx, 3), num(hy, 3), num(hole_h, 3))
            )
    lines.append("}")
    builder.section("\n".join(lines))
    code = builder.render()

    bbox = (float(panel_w), float(panel_d), float(total_h))
    features_ru = [
        f"{ru_count(len(rows), 'ряд прорезей', 'ряда прорезей', 'рядов прорезей')} шириной {fmt(slot_w)} мм",
        f"шаг от {fmt(pitch0)} мм с увеличением {fmt(pitch_step)} мм на ряд",
        f"{ru_count(4, 'крепёжное отверстие', 'крепёжных отверстия', 'крепёжных отверстий')} {fmt(mount_d)} мм по углам",
    ]
    features_en = [
        f"{en_count(len(rows))} rows of {fmt(slot_w)} mm slots",
        f"pitch starts at {fmt(pitch0)} mm and opens by {fmt(pitch_step)} mm per row",
        f"{en_count(4)} {fmt(mount_d)} mm mounting holes in the corners",
    ]
    if with_rim:
        features_ru.append(f"бортик {fmt(rim_h)} мм")
        features_en.append(f"a {fmt(rim_h)} mm rim")
    return finish_part3(
        rng,
        family="slottedpanels",
        variant=variant,
        code=code,
        bbox=bbox,
        params={"panel_w": panel_w, "panel_d": panel_d, "height": total_h, "wall": slot_w, "pitch": pitch0},
        ru_nouns=SLOT_RU,
        en_nouns=SLOT_EN,
        features_ru=features_ru,
        features_en=features_en,
    )
