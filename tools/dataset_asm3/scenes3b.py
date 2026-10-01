"""Scene templates for the asm3 corpus (delivery no. 6): 5 machine-like families.

* ``vise``         - machine vise: bed plate, two jaws, screw, collar, handle;
* ``cclamp``       - C clamp: spine plate, two brackets (one module called
  twice), vertical screw, washer, nut, tommy bar;
* ``pumpstack``    - pump stack: plate, housing cup, gasket ring, rod, cover
  with a four-bolt circle, top collar;
* ``indexingjig``  - indexing jig: plate, locator block, clevis-and-tongue
  index arm on a pin, lock nut, two guide bushings;
* ``lamparm``      - lamp arm: plate, column, clevis head, arm link on a pin,
  washer, lock nut, shade bracket.

All parts come from asm1's parts2 library (asm2 audit discipline: GAP on
every mating face, FIT diametral clearance in every hole, 45 degree grid
angles, one module per distinct part, repeats allowed).
"""

from __future__ import annotations

from tools.dataset_asm1 import parts2 as P
from tools.dataset_asm1.parts2 import disc_volume
from tools.dataset_asm2.scenes2b import Builder, FIT, GAP


def pin3(name: str, diameter: float, length: float, head_d: float, head_h: float):
    """parts2.pin, with the analytic volume corrected for the 1 mm head overlap."""
    spec = P.pin(name, diameter, length, head_d, head_h)
    spec.volume = (
        disc_volume(diameter, length)
        + disc_volume(head_d, head_h + 1.0)
        - disc_volume(diameter, 1.0)
    )
    return spec
from tools.dataset_asm2.core2b import Scene
from tools.dataset_gen2.common import Rng

# ---------------------------------------------------------------------------
# 1. vise
# ---------------------------------------------------------------------------


def build_vise(index: int) -> Scene:
    rng = Rng("asm3_vise", index)
    variant = rng.choice(("compact", "wide", "long"))
    plate_l = rng.grid([100.0, 110.0, 120.0]) if variant != "compact" else rng.grid([90.0, 100.0])
    plate_w = rng.grid([60.0, 70.0, 80.0])
    plate_t = rng.grid([8.0, 10.0, 12.0])
    screw_d = rng.grid([8.0, 10.0, 12.0])
    jaw_l = rng.grid([24.0, 28.0])
    jaw_w = rng.grid([36.0, 40.0, 44.0])
    jaw_h = rng.grid([30.0, 34.0, 38.0])
    jaw_gap = rng.grid([22.0, 25.0, 28.0])
    handle_d = rng.grid([8.0, 10.0])
    handle_h = rng.grid([26.0, 30.0, 34.0])
    collar_od = round(screw_d + 10.0, 2)
    collar_h = rng.grid([8.0, 10.0])
    washer_od = round(collar_od + 2.0, 2)

    jaw_bore = round(screw_d + FIT, 2)
    jaw_z = round(plate_t + GAP, 3)
    screw_z = round(jaw_z + jaw_h / 2, 3)
    # screw: tail behind the moving jaw, tip inside the fixed jaw bore
    tail_x = round(-jaw_gap - jaw_l / 2 - 16.0, 3)
    tip_x = round(jaw_gap + jaw_l / 2 - 4.0, 3)
    screw_l = round(tip_x - tail_x, 2)
    screw_cx = round((tail_x + tip_x) / 2, 3)
    collar_x = round(tail_x + 5.0, 3)
    washer_x = round(collar_x - GAP - 1.6, 3)
    handle_x = round(tail_x - GAP - handle_d / 2, 3)

    builder = Builder("vise", variant, "Machine vise")
    builder.add(P.plate("vise_bed", plate_l, plate_w, plate_t,
                        ru_note=f"станина {P.num(plate_l)} x {P.num(plate_w)} x {P.num(plate_t)} мм",
                        en_note=f"bed plate {P.num(plate_l)} x {P.num(plate_w)} x {P.num(plate_t)} mm"))
    jaw_args = dict(length=jaw_l, width=jaw_w, height=jaw_h, bore=jaw_bore, bore_z=jaw_h / 2)
    builder.add(P.block("vise_jaw", **jaw_args,
                        ru_note=f"губка {P.num(jaw_l)} x {P.num(jaw_w)} x {P.num(jaw_h)} мм с расточкой d{P.num(jaw_bore)}",
                        en_note=f"jaw {P.num(jaw_l)} x {P.num(jaw_w)} x {P.num(jaw_h)} mm bored d{P.num(jaw_bore)}"),
                t=(jaw_gap, 0.0, jaw_z))
    builder.add(P.block("vise_jaw", **jaw_args), t=(-jaw_gap, 0.0, jaw_z), feature=False)
    builder.add(P.shaft("vise_screw", screw_d, screw_l), axis="y", angle=90.0,
                t=(screw_cx, 0.0, screw_z))
    builder.add(P.collar("screw_collar", collar_od, jaw_bore, collar_h, 3.5),
                axis="y", angle=90.0, t=(collar_x, 0.0, screw_z))
    builder.add(P.washer("screw_washer", washer_od, jaw_bore, 1.6),
                axis="y", angle=90.0, t=(washer_x, 0.0, screw_z))
    builder.add(P.post("vise_handle", handle_d, handle_h), axis="x", angle=90.0,
                t=(handle_x, 0.0, round(screw_z + handle_h / 2, 3)))
    builder.note(
        f"Ходовой винт d{P.num(screw_d)} проходит через обе губки с зазором, рукоятка d{P.num(handle_d)} стоит у хвостовика",
        f"the d{P.num(screw_d)} screw runs loose through both jaws, the d{P.num(handle_d)} handle stands at the tail",
    )
    return builder.finish(
        rng,
        "станочные тиски с ходовым винтом и рукояткой",
        "a machine vise with a lead screw and a handle",
        f"screw d{screw_d:g}, jaws {jaw_l:g} x {jaw_h:g} mm",
    )


# ---------------------------------------------------------------------------
# 2. cclamp
# ---------------------------------------------------------------------------


def build_cclamp(index: int) -> Scene:
    rng = Rng("asm3_cclamp", index)
    variant = rng.choice(("light", "heavy"))
    arm_l = rng.grid([60.0, 70.0, 80.0])
    arm_w = rng.grid([28.0, 30.0, 34.0])
    arm_t = rng.grid([8.0, 10.0])
    throat = rng.grid([40.0, 45.0, 50.0])
    screw_d = rng.grid([8.0, 10.0])
    handle_d = rng.grid([6.0, 8.0])
    handle_l = rng.grid([36.0, 40.0, 44.0])
    nut_af = round(screw_d + 5.0, 2)
    nut_h = rng.grid([6.0, 7.0])
    washer_od = round(nut_af + 3.0, 2)
    spine_t = rng.grid([10.0, 12.0])
    spine_l = round(throat + arm_t + 8.0, 2)

    hole_d = round(screw_d + FIT, 2)
    x_h = round(arm_l / 2 - 10.0, 3)          # screw axis, 10 mm from the arm tip
    spine_x = round(-arm_l / 2 - GAP - spine_t, 3)
    screw_bottom = round(-nut_h - 0.5, 3)      # tail ends inside the nut
    screw_top = round(throat + arm_t + GAP + 6.0, 3)
    screw_l = round(screw_top - screw_bottom, 2)
    screw_cz = round((screw_bottom + screw_top) / 2, 3)
    washer_z = round(-GAP - 1.6, 3)
    nut_z = round(washer_z - GAP - nut_h, 3)

    builder = Builder("cclamp", variant, "C clamp")
    arm_args = dict(length=arm_l, width=arm_w, thickness=arm_t,
                    holes=[(x_h, 0.0)], hole_d=hole_d)
    builder.add(P.plate("clamp_arm", **arm_args,
                        ru_note=f"губка {P.num(arm_l)} x {P.num(arm_w)} x {P.num(arm_t)} мм с отверстием d{P.num(hole_d)}",
                        en_note=f"jaw plate {P.num(arm_l)} x {P.num(arm_w)} x {P.num(arm_t)} mm with a d{P.num(hole_d)} hole"),
                t=(0.0, 0.0, 0.0))
    builder.add(P.plate("clamp_arm", **arm_args), t=(0.0, 0.0, throat), feature=False)
    builder.add(P.plate("clamp_spine", spine_l, arm_w, spine_t,
                        ru_note=f"спинка {P.num(spine_l)} x {P.num(arm_w)} x {P.num(spine_t)} мм",
                        en_note=f"spine {P.num(spine_l)} x {P.num(arm_w)} x {P.num(spine_t)} mm"),
                axis="y", angle=90.0, t=(spine_x, 0.0, round(spine_l / 2 - 4.0, 3)))
    builder.add(P.shaft("clamp_screw", screw_d, screw_l), t=(x_h, 0.0, screw_cz))
    builder.add(P.washer("clamp_washer", washer_od, hole_d, 1.6),
                t=(x_h, 0.0, washer_z))
    builder.add(P.hexnut("clamp_nut", nut_af, nut_h, hole_d),
                t=(x_h, 0.0, nut_z))
    builder.add(P.shaft("tommy_bar", handle_d, handle_l), axis="y", angle=90.0,
                t=(x_h, 0.0, round(screw_top + GAP + handle_d / 2, 3)))
    builder.note(
        f"Винт d{P.num(screw_d)} длиной {P.num(screw_l)} мм, зев {P.num(throat)} мм, вороток d{P.num(handle_d)}",
        f"d{P.num(screw_d)} screw, {P.num(screw_l)} mm long, {P.num(throat)} mm throat, d{P.num(handle_d)} tommy bar",
    )
    return builder.finish(
        rng,
        "stрубцину с винтом и воротком",
        "a C clamp with a screw and a tommy bar",
        f"throat {throat:g} mm, screw d{screw_d:g}",
    )


# ---------------------------------------------------------------------------
# 3. pumpstack
# ---------------------------------------------------------------------------


def build_pumpstack(index: int) -> Scene:
    rng = Rng("asm3_pumpstack", index)
    variant = rng.choice(("compact", "tall"))
    plate_s = rng.grid([90.0, 100.0, 110.0])
    plate_t = rng.grid([8.0, 10.0, 12.0])
    cup_od = rng.grid([55.0, 60.0, 65.0])
    wall = rng.grid([5.0, 6.0])
    cup_h = rng.grid([40.0, 45.0, 50.0]) if variant == "compact" else rng.grid([55.0, 60.0])
    base_f = rng.grid([6.0, 8.0])
    rod_d = rng.grid([10.0, 12.0, 14.0])
    cover_t = rng.grid([8.0, 10.0])
    collar_od = round(rod_d + 8.0, 2)
    collar_h = rng.grid([8.0, 10.0])
    bolt_shank = rng.grid([5.0, 6.0])
    bolt_head_d = round(bolt_shank + 6.0, 2)
    bolt_head_h = rng.grid([4.0, 5.0])

    rod_bore = round(rod_d + FIT, 2)
    ring_od = round(cup_od - 2 * wall - FIT, 2)
    ring_h = rng.grid([3.0, 4.0])
    cup_z = round(plate_t + GAP, 3)
    ring_z = round(cup_z + base_f + GAP, 3)
    cover_z = round(cup_z + cup_h + GAP, 3)
    rod_bottom = round(cup_z + 1.0, 3)
    rod_top = round(cover_z + cover_t + 12.0, 3)
    rod_l = round(rod_top - rod_bottom, 2)
    rod_cz = round((rod_bottom + rod_top) / 2, 3)
    collar_z = round(cover_z + cover_t + 3.0, 3)
    bolt_r = round(cup_od / 2 - wall / 2 - 3.0, 2)
    bolt_z = round(cover_z + cover_t + GAP, 3)
    bolt_hole = round(bolt_shank + FIT, 2)

    builder = Builder("pumpstack", variant, "Pump stack")
    holes = [(round(bolt_r * 0.70710678, 3), round(bolt_r * 0.70710678, 3)),
             (round(-bolt_r * 0.70710678, 3), round(bolt_r * 0.70710678, 3)),
             (round(-bolt_r * 0.70710678, 3), round(-bolt_r * 0.70710678, 3)),
             (round(bolt_r * 0.70710678, 3), round(-bolt_r * 0.70710678, 3))]
    builder.add(P.plate("pump_base", plate_s, plate_s, plate_t, holes=holes, hole_d=bolt_hole,
                        ru_note=f"основание {P.num(plate_s)} x {P.num(plate_s)} x {P.num(plate_t)} мм с четырьмя отверстиями d{P.num(bolt_hole)}",
                        en_note=f"base {P.num(plate_s)} x {P.num(plate_s)} x {P.num(plate_t)} mm with four d{P.num(bolt_hole)} holes"))
    builder.add(P.cup("pump_housing", cup_od, wall, cup_h, base_f, rod_bore),
                t=(0.0, 0.0, cup_z))
    builder.add(P.ring("pump_gasket", ring_od, rod_bore, ring_h,
                       "прокладка", "gasket ring"),
                t=(0.0, 0.0, ring_z))
    builder.add(P.cover("pump_cover", cup_od, cover_t, holes, bolt_hole, rod_bore,
                        ru_note=f"крышка d{P.num(cup_od)} толщиной {P.num(cover_t)} мм, центральное отверстие d{P.num(rod_bore)}",
                        en_note=f"cover d{P.num(cup_od)}, {P.num(cover_t)} mm thick, d{P.num(rod_bore)} centre bore"),
                t=(0.0, 0.0, cover_z))
    builder.add(P.shaft("pump_rod", rod_d, rod_l), t=(0.0, 0.0, rod_cz))
    builder.add(P.collar("rod_collar", collar_od, rod_bore, collar_h, 3.5),
                t=(0.0, 0.0, collar_z))
    for i, (hx, hy) in enumerate(holes):
        builder.add(
            P.bolt("cover_bolt", bolt_shank, cover_t, bolt_head_d, bolt_head_h),
            t=(hx, hy, bolt_z),
            feature=(i == 0),
        )
    builder.note(
        f"Шток d{P.num(rod_d)} проходит через прокладку и крышку с зазором, четыре болта d{P.num(bolt_shank)} по окружности d{P.num(round(2 * bolt_r, 2))}",
        f"the d{P.num(rod_d)} rod runs loose through the gasket and cover, four d{P.num(bolt_shank)} bolts on a d{P.num(round(2 * bolt_r, 2))} circle",
    )
    return builder.finish(
        rng,
        "насосный узел: стакан, шток и крышка на четырёх болтах",
        "a pump stack: housing cup, rod and a four-bolt cover",
        f"housing d{cup_od:g} x {cup_h:g} mm, rod d{rod_d:g}",
    )


# ---------------------------------------------------------------------------
# 4. indexingjig
# ---------------------------------------------------------------------------


def build_indexingjig(index: int) -> Scene:
    rng = Rng("asm3_indexingjig", index)
    variant = rng.choice(("left_stop", "right_stop"))
    plate_l = rng.grid([100.0, 110.0, 120.0])
    plate_w = rng.grid([60.0, 70.0])
    plate_t = rng.grid([8.0, 10.0, 12.0])
    block_l = rng.grid([36.0, 40.0, 44.0])
    block_w = rng.grid([36.0, 40.0])
    block_h = rng.grid([26.0, 30.0])
    eye_t = rng.grid([8.0, 10.0])
    eye_l = rng.grid([46.0, 50.0, 56.0])
    eye_h = rng.grid([22.0, 24.0])
    pin_d = rng.grid([8.0, 10.0])
    pin_l = rng.grid([34.0, 36.0, 38.0])
    pin_head_d = round(pin_d + 4.0, 2)
    bush_od = rng.grid([16.0, 18.0])
    bush_h = rng.grid([18.0, 20.0, 22.0])
    nut_af = round(pin_d + 5.0, 2)
    nut_h = rng.grid([6.0, 7.0])

    pin_bore = round(pin_d + FIT, 2)
    slot_w = round(eye_t + 2 * 0.4, 2)
    clevis_l = round(eye_l * 0.55, 2)
    clevis_h = rng.grid([28.0, 30.0])
    base_t = rng.grid([8.0, 10.0])
    side = -1.0 if variant == "left_stop" else 1.0
    block_x = round(side * plate_l * 0.22, 3)
    block_z = round(plate_t + GAP, 3)
    clevis_z = round(block_z + block_h + GAP, 3)
    eye_z = round(clevis_z + base_t + GAP, 3)
    pin_z = round(eye_z + eye_h / 2, 3)
    pin_cz = round(pin_z - clevis_z, 3)  # pin hole height inside the clevis
    if pin_cz + pin_bore / 2 > clevis_h - 1.5:
        raise ValueError("pin hole breaks the clevis top")
    nut_y = round(pin_l / 2 + GAP + 1.6 + GAP + nut_h, 3)
    washer_y = round(pin_l / 2 + GAP + 1.6, 3)
    bush_x = round(-side * plate_l * 0.3, 3)
    bush_z = round(plate_t + GAP, 3)

    builder = Builder("indexingjig", variant, "Indexing jig")
    builder.add(P.plate("jig_plate", plate_l, plate_w, plate_t,
                        ru_note=f"плита {P.num(plate_l)} x {P.num(plate_w)} x {P.num(plate_t)} мм",
                        en_note=f"plate {P.num(plate_l)} x {P.num(plate_w)} x {P.num(plate_t)} mm"))
    builder.add(P.block("locator_block", block_l, block_w, block_h, 10.0, block_h / 2),
                t=(block_x, 0.0, block_z))
    builder.add(P.clevis("index_fork", clevis_l, 30.0, clevis_h, slot_w, pin_bore, pin_cz, base_t),
                t=(block_x, 0.0, clevis_z))
    builder.add(P.eye_plate("index_arm", eye_l, eye_t, eye_h, pin_bore),
                t=(block_x, 0.0, eye_z))
    builder.add(pin3("index_pin", pin_d, pin_l, pin_head_d, 3.0),
                axis="z", angle=90.0, t=(block_x, 0.0, pin_z))
    builder.add(P.washer("pin_washer", round(nut_af + 3.0, 2), pin_bore, 1.6),
                axis="x", angle=90.0, t=(block_x, washer_y, pin_z))
    builder.add(P.hexnut("lock_nut", nut_af, nut_h, pin_bore),
                axis="x", angle=90.0, t=(block_x, nut_y, pin_z))
    bush_args = dict(outer_d=bush_od, bore=pin_bore, height=bush_h,
                     flange_d=round(bush_od + 6.0, 2), flange_h=3.0)
    bush_y = round(plate_w * 0.28, 3)
    if 2 * bush_y < bush_od + 6.0 + 0.5:
        raise ValueError("bushing flanges collide")
    builder.add(P.bushing("guide_bush_a", **bush_args), t=(bush_x, -bush_y, bush_z))
    builder.add(P.bushing("guide_bush_b", **bush_args),
                t=(bush_x, bush_y, bush_z), feature=False)
    builder.note(
        f"Палец d{P.num(pin_d)} фиксирует проушину в вилке, гайка d{P.num(nut_af)} затягивается от руки",
        f"the d{P.num(pin_d)} pin locks the tongue in the fork, the d{P.num(nut_af)} nut tightens by hand",
    )
    return builder.finish(
        rng,
        "сверлильно-делительный кондуктор с индексным рычагом",
        "an indexing jig with a tongue-and-fork arm",
        f"plate {plate_l:g} x {plate_w:g} mm, pin d{pin_d:g}",
    )


# ---------------------------------------------------------------------------
# 5. lamparm
# ---------------------------------------------------------------------------


def build_lamparm(index: int) -> Scene:
    rng = Rng("asm3_lamparm", index)
    variant = rng.choice(("short_arm", "long_arm"))
    plate_s = rng.grid([80.0, 90.0])
    plate_t = rng.grid([8.0, 10.0])
    column_d = rng.grid([14.0, 16.0])
    column_h = rng.grid([50.0, 60.0, 70.0])
    eye_t = rng.grid([8.0, 10.0])
    eye_l = rng.grid([60.0, 70.0, 80.0]) if variant == "long_arm" else rng.grid([46.0, 54.0])
    eye_h = rng.grid([22.0, 24.0])
    pin_d = rng.grid([8.0, 10.0])
    pin_l = rng.grid([34.0, 36.0, 38.0])
    pin_head_d = round(pin_d + 4.0, 2)
    bracket_b = rng.grid([30.0, 34.0])
    bracket_leg = rng.grid([22.0, 26.0])
    nut_af = round(pin_d + 5.0, 2)
    nut_h = rng.grid([6.0, 7.0])

    pin_bore = round(pin_d + FIT, 2)
    slot_w = round(eye_t + 2 * 0.4, 2)
    clevis_l = round(eye_l * 0.45, 2)
    clevis_w = 30.0
    clevis_h = rng.grid([28.0, 30.0])
    base_t = rng.grid([8.0, 10.0])
    column_z = round(plate_t + GAP, 3)
    clevis_z = round(column_z + column_h + GAP, 3)
    eye_z = round(clevis_z + base_t + GAP, 3)
    pin_z = round(eye_z + eye_h / 2, 3)
    pin_cz = round(pin_z - clevis_z, 3)
    if pin_cz + pin_bore / 2 > clevis_h - 1.5:
        raise ValueError("pin hole breaks the clevis top")
    eye_x = 0.0
    arm_tip = round(eye_l / 2, 3)
    bracket_x = round(arm_tip + GAP + bracket_b / 2, 3)
    bracket_z = round(eye_z + eye_h + GAP, 3)
    nut_y = round(pin_l / 2 + GAP + 1.6 + GAP + nut_h, 3)
    washer_y = round(pin_l / 2 + GAP + 1.6, 3)

    builder = Builder("lamparm", variant, "Lamp arm")
    builder.add(P.plate("lamp_base", plate_s, plate_s, plate_t,
                        ru_note=f"основание {P.num(plate_s)} x {P.num(plate_s)} x {P.num(plate_t)} мм",
                        en_note=f"base plate {P.num(plate_s)} x {P.num(plate_s)} x {P.num(plate_t)} mm"))
    builder.add(P.post("lamp_column", column_d, column_h), t=(0.0, 0.0, column_z))
    builder.add(P.clevis("head_fork", clevis_l, clevis_w, clevis_h, slot_w, pin_bore, pin_cz, base_t),
                t=(0.0, 0.0, clevis_z))
    builder.add(P.eye_plate("lamp_arm", eye_l, eye_t, eye_h, pin_bore),
                t=(eye_x, 0.0, eye_z))
    builder.add(pin3("arm_pin", pin_d, pin_l, pin_head_d, 3.0),
                axis="z", angle=90.0, t=(0.0, 0.0, pin_z))
    builder.add(P.washer("arm_washer", round(nut_af + 3.0, 2), pin_bore, 1.6),
                axis="x", angle=90.0, t=(0.0, washer_y, pin_z))
    builder.add(P.hexnut("arm_nut", nut_af, nut_h, pin_bore),
                axis="x", angle=90.0, t=(0.0, nut_y, pin_z))
    builder.add(P.bracket("shade_bracket", bracket_b, bracket_b, 6.0, bracket_leg, 6.0, 8.0, [bracket_leg * 0.6],
                          ru_note=f"кронштейн абажура {P.num(bracket_b)} x {P.num(bracket_b)} мм с полкой {P.num(bracket_leg)} мм",
                          en_note=f"shade bracket {P.num(bracket_b)} x {P.num(bracket_b)} mm with a {P.num(bracket_leg)} mm leg"),
                t=(bracket_x, 0.0, bracket_z))
    builder.note(
        f"Рукав d{P.num(eye_t)} мм длиной {P.num(eye_l)} мм качается на пальце d{P.num(pin_d)}, кронштейн абажура на конце",
        f"the {P.num(eye_t)} mm arm, {P.num(eye_l)} mm long, pivots on the d{P.num(pin_d)} pin, shade bracket at the tip",
    )
    return builder.finish(
        rng,
        "настольную лампу на колонне с качающимся рычагом",
        "a column lamp with a pivoting arm",
        f"column d{column_d:g} x {column_h:g} mm, arm {eye_l:g} mm",
    )


FAMILY_BUILDERS = {
    "vise": build_vise,
    "cclamp": build_cclamp,
    "pumpstack": build_pumpstack,
    "indexingjig": build_indexingjig,
    "lamparm": build_lamparm,
}
