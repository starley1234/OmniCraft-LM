"""Scene templates for the asm4 corpus (delivery no. 7): 5 machine-like families.

* ``motorstation`` - motor on a base plate driving a pillow-block shaft with
  a flanged pulley, collar and washer on the shaft;
* ``beltloop``     - flat belt drive: two bushed shafts with pulleys tied by
  a racetrack belt loop;
* ``pressfixture`` - arbor press: frame plate on box posts, guide ring,
  screw, washer, nut and a press collar over the anvil block;
* ``rockerlink``   - fork rocker: axle through a fork carrying a swing block
  and a roller ring, clevis-and-tongue link on top with a pinned joint;
* ``hingeflap``    - comb hinge: two interleaved leaves, a pin and a flap
  plate hanging off one leaf.

asm2 audit discipline: GAP on every mating face, FIT diametral clearance in
every hole, 45 degree grid angles, one module per distinct part, repeats OK.
"""

from __future__ import annotations

from tools.dataset_asm1 import parts2 as P
from tools.dataset_asm2 import parts2b as P2
from tools.dataset_asm2.scenes2b import Builder, FIT, GAP
from tools.dataset_asm2.core2b import Scene
from tools.dataset_gen2.common import Rng

from tools.dataset_asm3.scenes3b import pin3

# ---------------------------------------------------------------------------
# 1. motorstation
# ---------------------------------------------------------------------------


def build_motorstation(index: int) -> Scene:
    rng = Rng("asm4_motorstation", index)
    variant = rng.choice(("compact", "long"))
    plate_l = rng.grid([150.0, 160.0, 170.0, 180.0])
    plate_w = rng.grid([70.0, 80.0])
    plate_t = rng.grid([10.0, 12.0])
    motor_l = rng.grid([50.0, 60.0]) if variant == "compact" else rng.grid([60.0, 70.0])
    motor_w = rng.grid([42.0, 46.0])
    motor_h = rng.grid([42.0, 46.0, 50.0])
    boss_l = rng.grid([6.0, 8.0])
    boss_d = rng.grid([22.0, 26.0])
    shaft_d = rng.grid([8.0, 10.0])
    pillow_l = rng.grid([28.0, 32.0])
    pillow_w = rng.grid([36.0, 40.0])
    pulley_h = rng.grid([18.0, 20.0, 22.0])
    od_choices = [od for od in (40.0, 46.0, 52.0) if od <= motor_h - 2]
    if not od_choices:
        raise ValueError("no pulley fits the motor height")
    pulley_od = rng.choice(od_choices)
    flange_h = rng.grid([3.0, 4.0])
    collar_od = round(shaft_d + 12.0, 2)
    collar_h = rng.grid([8.0, 10.0])
    washer_od = round(collar_od + 3.0, 2)
    if pulley_h < 2 * flange_h + 6:
        raise ValueError("pulley too small for its flanges")

    shaft_bore = round(shaft_d + FIT, 2)
    motor_x = round(-plate_l / 2 + 6.0 + motor_l / 2, 3)
    motor_z = round(plate_t + GAP, 3)
    shaft_z = round(motor_z + motor_h / 2, 3)
    boss_end = round(motor_x + motor_l / 2 + boss_l, 3)
    tail_x = round(boss_end + GAP, 3)
    pillow_h = round(motor_h / 2 + shaft_bore / 2 + 4.0, 2)
    pillow_face = round(tail_x + 5.0 + collar_h + GAP + 6.0, 3)
    pillow_x = round(pillow_face + pillow_l / 2, 3)
    pul_x = round(pillow_x + pillow_l / 2 + GAP, 3)
    tip_x = round(pul_x + pulley_h - 2.0, 3)
    screw_l = round(tip_x - tail_x, 2)
    screw_cx = round((tail_x + tip_x) / 2, 3)
    collar_x = round(tail_x + 5.0, 3)
    washer_x = round(collar_x - GAP - 1.6, 3)
    if tip_x > plate_l / 2 - 4.0 or motor_w > plate_w - 8 or pulley_od > plate_w - 8:
        raise ValueError("station does not fit the plate")
    hub_d = round(shaft_bore + 8.0, 2)

    builder = Builder("motorstation", variant, "Motor drive station")
    builder.add(P.plate("station_bed", plate_l, plate_w, plate_t,
                        ru_note=f"основание {P.num(plate_l)} x {P.num(plate_w)} x {P.num(plate_t)} мм",
                        en_note=f"bed plate {P.num(plate_l)} x {P.num(plate_w)} x {P.num(plate_t)} mm"))
    builder.add(P2.motor_body("drive_motor", motor_l, motor_w, motor_h, boss_l, boss_d),
                t=(motor_x, 0.0, motor_z))
    builder.add(P.block("pillow_block", pillow_l, pillow_w, pillow_h, shaft_bore, motor_h / 2),
                t=(pillow_x, 0.0, motor_z))
    builder.add(P.shaft("drive_shaft", shaft_d, screw_l), axis="y", angle=90.0,
                t=(screw_cx, 0.0, shaft_z))
    builder.add(P.collar("shaft_collar", collar_od, shaft_bore, collar_h, 3.5),
                axis="y", angle=90.0, t=(collar_x, 0.0, shaft_z))
    builder.add(P.washer("collar_washer", washer_od, shaft_bore, 1.6),
                axis="y", angle=90.0, t=(washer_x, 0.0, shaft_z))
    builder.add(P.pulley("drive_pulley", pulley_od, shaft_bore, pulley_h, flange_h, hub_d),
                axis="y", angle=90.0, t=(pul_x, 0.0, shaft_z))
    builder.note(
        f"Вал d{P.num(shaft_d)} идёт от бурта мотора через корпус d{P.num(shaft_bore)} к шкиву d{P.num(pulley_od)}",
        f"the d{P.num(shaft_d)} shaft runs from the motor boss through the d{P.num(shaft_bore)} pillow bore into the d{P.num(pulley_od)} pulley",
    )
    return builder.finish(
        rng,
        "моторную станцию с ременным приводом на подушке",
        "a pillow-block motor drive station",
        f"motor {motor_l:g} x {motor_h:g} mm, shaft d{shaft_d:g}, pulley d{pulley_od:g}",
    )


# ---------------------------------------------------------------------------
# 2. beltloop
# ---------------------------------------------------------------------------


def build_beltloop(index: int) -> Scene:
    rng = Rng("asm4_beltloop", index)
    variant = rng.choice(("short", "long"))
    span = rng.grid([70.0, 80.0, 90.0]) if variant == "short" else rng.grid([90.0, 100.0, 110.0])
    plate_t = rng.grid([10.0, 12.0])
    pulley_od = rng.grid([44.0, 50.0, 56.0])
    pulley_h = rng.grid([20.0, 22.0, 24.0])
    flange_h = rng.grid([3.0, 4.0])
    belt_t = rng.grid([2.0, 2.5, 3.0])
    shaft_d = rng.grid([8.0, 10.0])
    bush_od = rng.grid([18.0, 20.0])
    bush_h = rng.grid([18.0, 20.0, 22.0])
    flange_d = round(bush_od + 8.0, 2)
    flange_h2 = 3.0
    shaft_bore = round(shaft_d + FIT, 2)
    hub_d = round(shaft_bore + 8.0, 2)
    belt_r_out = round(pulley_od / 2 + GAP + belt_t, 3)
    belt_w = round(pulley_h - 2 * flange_h - 0.4, 2)
    plate_l = round(span + 2 * belt_r_out + 12.0, 2)
    plate_w = round(2 * belt_r_out + 16.0, 2)
    if plate_l > 250.0 or plate_w > 250.0 or span < flange_d + 10.0:
        raise ValueError("loop does not fit the plate")

    bush_z = round(plate_t + GAP, 3)
    pulley_z = round(bush_z + flange_h2 + bush_h + GAP, 3)
    belt_z = round(pulley_z + flange_h + 0.2, 3)
    shaft_l = round(flange_h2 + bush_h + GAP + pulley_h + 6.0, 2)
    shaft_cz = round(bush_z + shaft_l / 2, 3)

    builder = Builder("beltloop", variant, "Flat belt drive loop")
    builder.add(P.plate("loop_bed", plate_l, plate_w, plate_t,
                        ru_note=f"основание {P.num(plate_l)} x {P.num(plate_w)} x {P.num(plate_t)} мм",
                        en_note=f"bed plate {P.num(plate_l)} x {P.num(plate_w)} x {P.num(plate_t)} mm"))
    bush_args = dict(outer_d=bush_od, bore=shaft_bore, height=bush_h,
                     flange_d=flange_d, flange_h=flange_h2)
    builder.add(P.bushing("belt_bush_a", **bush_args), t=(-span / 2, 0.0, bush_z))
    builder.add(P.bushing("belt_bush_b", **bush_args), t=(span / 2, 0.0, bush_z), feature=False)
    shaft_args = dict(diameter=shaft_d, length=shaft_l)
    builder.add(P.shaft("belt_shaft_a", **shaft_args), t=(-span / 2, 0.0, shaft_cz))
    builder.add(P.shaft("belt_shaft_b", **shaft_args), t=(span / 2, 0.0, shaft_cz), feature=False)
    pulley_args = dict(outer_d=pulley_od, bore=shaft_bore, height=pulley_h,
                       flange_h=flange_h, hub_d=hub_d)
    builder.add(P.pulley("belt_pulley_a", **pulley_args), t=(-span / 2, 0.0, pulley_z))
    builder.add(P.pulley("belt_pulley_b", **pulley_args), t=(span / 2, 0.0, pulley_z), feature=False)
    builder.add(P2.racetrack_belt("drive_belt", belt_r_out, belt_t, span, belt_w),
                t=(-span / 2, 0.0, belt_z))
    builder.note(
        f"Плоский ремень толщиной {P.num(belt_t)} мм охватывает два шкива d{P.num(pulley_od)} на базе {P.num(span)} мм",
        f"the {P.num(belt_t)} mm flat belt wraps two d{P.num(pulley_od)} pulleys on a {P.num(span)} mm centre distance",
    )
    return builder.finish(
        rng,
        "плоскоременную передачу на двух валах",
        "a flat belt drive between two shafts",
        f"span {span:g} mm, pulleys d{pulley_od:g}, belt {belt_t:g} mm thick",
    )


# ---------------------------------------------------------------------------
# 3. pressfixture
# ---------------------------------------------------------------------------


def build_pressfixture(index: int) -> Scene:
    rng = Rng("asm4_pressfixture", index)
    variant = rng.choice(("light", "heavy"))
    plate_l = rng.grid([110.0, 120.0, 130.0])
    plate_w = rng.grid([80.0, 90.0])
    plate_t = rng.grid([10.0, 12.0])
    post_side = rng.grid([16.0, 18.0, 20.0])
    post_h = rng.grid([60.0, 70.0, 80.0])
    frame_t = rng.grid([10.0, 12.0])
    screw_d = rng.grid([10.0, 12.0]) if variant == "heavy" else rng.grid([8.0, 10.0])
    ring_od = 0.0  # chosen below, once screw_d is known
    ring_h = rng.grid([14.0, 16.0])
    nut_af = round(screw_d + 6.0, 2)
    nut_h = rng.grid([8.0, 9.0])
    washer_od = round(nut_af + 4.0, 2)
    anvil_l = rng.grid([40.0, 44.0])
    anvil_w = rng.grid([40.0, 44.0])
    anvil_h = rng.grid([20.0, 24.0])
    press_od = round(screw_d + 22.0, 2)
    press_h = rng.grid([14.0, 16.0])
    work_gap = rng.grid([12.0, 14.0, 16.0])
    ring_choices = [od for od in (32.0, 34.0, 36.0, 38.0) if od >= screw_d + 24.0]
    if not ring_choices:
        raise ValueError("no ring seat for the screw")
    ring_od = rng.choice(ring_choices)
    post_x = round(plate_l / 2 - post_side / 2 - 6.0, 3)
    post_y = round(plate_w / 2 - post_side / 2 - 6.0, 3)
    win_x = round(screw_d + 16.0, 2)
    win_y = round(screw_d + 16.0, 2)
    if win_x > ring_od - 8.0:
        raise ValueError("window breaks the ring seat")
    if post_x - post_side / 2 < win_x / 2 + 4.0:
        raise ValueError("posts crowd the frame window")

    screw_bore = round(screw_d + FIT, 2)
    post_z = round(plate_t + GAP, 3)
    frame_z = round(post_z + post_h + GAP, 3)
    frame_top = round(frame_z + frame_t, 3)
    ring_z = round(frame_top + GAP, 3)
    ring_top = round(ring_z + ring_h, 3)
    washer_z = round(ring_top + GAP, 3)
    nut_z = round(washer_z + 1.6 + GAP, 3)
    anvil_z = round(plate_t + GAP, 3)
    press_z = round(anvil_z + anvil_h + work_gap, 3)
    screw_z0 = round(press_z + 2.0, 3)
    screw_top = round(nut_z + nut_h - 2.0, 3)
    screw_l = round(screw_top - screw_z0, 2)
    screw_cz = round((screw_z0 + screw_top) / 2, 3)
    if screw_l < 30.0:
        raise ValueError("press screw too short")

    builder = Builder("pressfixture", variant, "Arbor press fixture")
    builder.add(P.plate("press_bed", plate_l, plate_w, plate_t,
                        ru_note=f"основание {P.num(plate_l)} x {P.num(plate_w)} x {P.num(plate_t)} мм",
                        en_note=f"bed plate {P.num(plate_l)} x {P.num(plate_w)} x {P.num(plate_t)} mm"))
    builder.add(P.block("anvil_block", anvil_l, anvil_w, anvil_h, 12.0, anvil_h / 2),
                t=(0.0, 0.0, anvil_z))
    post_args = dict(side=post_side, height=post_h)
    builder.add(P2.box_post("press_post_a", **post_args), t=(post_x, post_y, post_z))
    builder.add(P2.box_post("press_post_b", **post_args), t=(post_x, -post_y, post_z), feature=False)
    builder.add(P2.box_post("press_post_c", **post_args), t=(-post_x, post_y, post_z), feature=False)
    builder.add(P2.box_post("press_post_d", **post_args), t=(-post_x, -post_y, post_z), feature=False)
    sockets = [(post_x, post_y), (post_x, -post_y), (-post_x, post_y), (-post_x, -post_y)]
    builder.add(P.frame_plate("press_frame", plate_l - 8.0, plate_w - 8.0, frame_t,
                              (win_x, win_y), sockets, round(post_side + FIT, 2), 5.0),
                t=(0.0, 0.0, frame_z))
    builder.add(P.ring("guide_ring", ring_od, screw_bore, ring_h,
                       "направляющее кольцо", "guide ring"),
                t=(0.0, 0.0, ring_z))
    builder.add(P.shaft("press_screw", screw_d, screw_l), t=(0.0, 0.0, screw_cz))
    builder.add(P.collar("press_head", press_od, screw_bore, press_h, 4.0),
                t=(0.0, 0.0, press_z))
    builder.add(P.washer("nut_washer", washer_od, screw_bore, 1.6),
                t=(0.0, 0.0, washer_z))
    builder.add(P.hexnut("press_nut", nut_af, nut_h, screw_bore),
                t=(0.0, 0.0, nut_z))
    builder.note(
        f"Винт d{P.num(screw_d)} идёт через кольцо d{P.num(ring_od)} к нажимной шайбе d{P.num(press_od)}, зазор под заготовку {P.num(work_gap)} мм",
        f"the d{P.num(screw_d)} screw runs through the d{P.num(ring_od)} ring onto the d{P.num(press_od)} press head, work gap {P.num(work_gap)} mm",
    )
    return builder.finish(
        rng,
        "прессовую оснастку с направляющим кольцом",
        "an arbor press fixture with a guide ring",
        f"screw d{screw_d:g}, posts {post_h:g} mm, gap {work_gap:g} mm",
    )


# ---------------------------------------------------------------------------
# 4. rockerlink
# ---------------------------------------------------------------------------


def build_rockerlink(index: int) -> Scene:
    rng = Rng("asm4_rockerlink", index)
    variant = rng.choice(("low", "high"))
    plate_l = rng.grid([110.0, 120.0])
    plate_w = rng.grid([70.0, 80.0])
    plate_t = rng.grid([10.0, 12.0])
    leg_l = rng.grid([40.0, 44.0])
    leg_t = rng.grid([10.0, 12.0])
    gap_y = rng.grid([26.0, 30.0])
    fork_h = rng.grid([40.0, 46.0]) if variant == "high" else rng.grid([34.0, 38.0])
    bridge_t = rng.grid([8.0, 10.0])
    axle_d = rng.grid([8.0, 10.0])
    arm_l = rng.grid([30.0, 34.0])
    arm_w = rng.grid([18.0, 20.0])
    arm_h = rng.grid([24.0, 26.0])
    ring_od = rng.grid([20.0, 22.0])
    ring_h = rng.grid([8.0, 10.0])
    pin_d = rng.grid([8.0, 10.0])
    pin_l = rng.grid([36.0, 38.0, 40.0])
    nut_af = round(pin_d + 5.0, 2)
    nut_h = rng.grid([6.0, 7.0])
    axle_bore = round(axle_d + FIT, 2)
    pin_bore = round(pin_d + FIT, 2)
    axle_z = round(fork_h * 0.6, 3)
    y_out = round(gap_y / 2 + leg_t, 3)
    if arm_w > gap_y - 2 * GAP - 0.5 or ring_od > gap_y - 2 * GAP - 0.5:
        raise ValueError("swing parts crowd the fork gap")
    if axle_z < arm_h / 2 + GAP:
        raise ValueError("arm drops below the fork floor")
    if axle_z + arm_h / 2 > fork_h - GAP:
        raise ValueError("arm hits the bridge")

    fork_z = round(plate_t + GAP, 3)
    axle_abs = round(fork_z + axle_z, 3)
    arm_z = round(axle_abs - arm_h / 2, 3)
    ring_x = round(arm_l / 2 + GAP, 3)
    extr = round(1.6 + GAP + nut_h + 1.0, 3)
    axle_l = round(2 * (y_out + extr), 2)
    clevis_l = round(arm_l - 4.0, 2)
    clevis_h = rng.grid([30.0, 32.0, 34.0])
    base_t = rng.grid([8.0, 10.0])
    eye_t = rng.grid([8.0, 10.0])
    eye_l = round(arm_l + 8.0, 2)
    eye_h = rng.grid([20.0, 22.0])
    slot_w = round(eye_t + 0.8, 2)
    clevis_z = round(fork_z + fork_h + bridge_t + GAP, 3)
    eye_z = round(clevis_z + base_t + GAP, 3)
    pin_z = round(eye_z + eye_h / 2, 3)
    pin_cz = round(pin_z - clevis_z, 3)
    if pin_cz + pin_bore / 2 > clevis_h - 1.5:
        raise ValueError("pin hole breaks the clevis top")
    washer_y = round(pin_l / 2 + GAP + 1.6, 3)
    nut_y = round(pin_l / 2 + GAP + 1.6 + GAP + nut_h, 3)
    if plate_l < leg_l + 30.0 or plate_w < 2 * y_out + 16.0:
        raise ValueError("fork does not fit the plate")

    builder = Builder("rockerlink", variant, "Fork rocker linkage")
    builder.add(P.plate("rocker_bed", plate_l, plate_w, plate_t,
                        ru_note=f"плита {P.num(plate_l)} x {P.num(plate_w)} x {P.num(plate_t)} мм",
                        en_note=f"base plate {P.num(plate_l)} x {P.num(plate_w)} x {P.num(plate_t)} mm"))
    builder.add(P2.fork("rocker_fork", leg_l, leg_t, gap_y, fork_h, bridge_t, axle_bore, axle_z),
                t=(0.0, 0.0, fork_z))
    builder.add(P.block("rocker_arm", arm_l, arm_w, arm_h, axle_bore, arm_h / 2),
                t=(0.0, 0.0, arm_z))
    builder.add(P.ring("rocker_roller", ring_od, axle_bore, ring_h,
                       "ролик", "roller"),
                axis="y", angle=90.0, t=(ring_x, 0.0, axle_abs))
    builder.add(P.shaft("rocker_axle", axle_d, axle_l), axis="y", angle=90.0,
                t=(0.0, 0.0, axle_abs))
    builder.add(P.washer("axle_washer", round(nut_af + 3.0, 2), axle_bore, 1.6),
                axis="x", angle=90.0, t=(0.0, y_out + GAP + 1.6, axle_abs))
    builder.add(P.hexnut("axle_nut", nut_af, nut_h, axle_bore),
                axis="x", angle=90.0, t=(0.0, y_out + GAP + 1.6 + GAP + nut_h, axle_abs))
    builder.add(P.clevis("link_fork", clevis_l, 30.0, clevis_h, slot_w, pin_bore, pin_cz, base_t),
                t=(0.0, 0.0, clevis_z))
    builder.add(P.eye_plate("link_arm", eye_l, eye_t, eye_h, pin_bore),
                t=(0.0, 0.0, eye_z))
    builder.add(pin3("link_pin", pin_d, pin_l, round(pin_d + 4.0, 2), 3.0),
                axis="z", angle=90.0, t=(0.0, 0.0, pin_z))
    builder.add(P.washer("pin_washer", round(nut_af + 3.0, 2), pin_bore, 1.6),
                axis="x", angle=90.0, t=(0.0, washer_y, pin_z), feature=False)
    builder.add(P.hexnut("lock_nut", nut_af, nut_h, pin_bore),
                axis="x", angle=90.0, t=(0.0, nut_y, pin_z), feature=False)
    builder.note(
        f"Ось d{P.num(axle_d)} несёт качающийся блок и ролик d{P.num(ring_od)}, проушина соединена пальцем d{P.num(pin_d)}",
        f"the d{P.num(axle_d)} axle carries the swing block and the d{P.num(ring_od)} roller, the tongue is pinned with the d{P.num(pin_d)} pin",
    )
    return builder.finish(
        rng,
        "кулисный механизм с вилкой и пальцем",
        "a fork rocker linkage with a pinned arm",
        f"fork {fork_h:g} mm, axle d{axle_d:g}, pin d{pin_d:g}",
    )


# ---------------------------------------------------------------------------
# 5. hingeflap
# ---------------------------------------------------------------------------


def build_hingeflap(index: int) -> Scene:
    rng = Rng("asm4_hingeflap", index)
    variant = rng.choice(("two_tooth", "three_tooth"))
    plate_l = rng.grid([110.0, 120.0, 130.0])
    plate_w = rng.grid([70.0, 80.0])
    plate_t = rng.grid([10.0, 12.0])
    riser_t = rng.grid([6.0, 8.0])
    tw = rng.grid([10.0, 12.0])
    gx = 2.2
    n_teeth = 2 if variant == "two_tooth" else 3
    step = tw + gx
    margin = 3.0
    leaf_l = round(2 * margin + (2 * n_teeth) * tw + (2 * n_teeth - 1) * gx, 2)
    leaf_w = rng.grid([20.0, 22.0, 24.0])
    leaf_t = rng.grid([10.0, 12.0])
    lug = rng.grid([8.0, 10.0])
    pin_d = rng.grid([5.0, 6.0])
    nut_af = round(pin_d + 5.0, 2)
    nut_h = rng.grid([6.0, 7.0])
    washer_od = round(nut_af + 3.0, 2)
    flap_l = round(leaf_l - 6.0, 2)
    flap_w = rng.grid([40.0, 46.0, 52.0])
    flap_t = rng.grid([6.0, 8.0])
    pin_bore = round(pin_d + FIT, 2)
    riser_l = round(leaf_l + 8.0, 2)
    riser_w = round(2 * leaf_w + 4.0, 2)
    if plate_w < riser_w + 8 or plate_l < riser_l + 12:
        raise ValueError("hinge does not fit the plate")
    if riser_t + leaf_t / 2 - washer_od / 2 < GAP:
        raise ValueError("pin hardware crowds the bed")

    slots_a = []
    slots_b = []
    x_start = -leaf_l / 2 + margin
    for k in range(n_teeth):
        x0 = x_start + 2 * k * step
        slots_a.append((round(x0, 2), round(x0 + tw, 2)))
        x1 = x_start + (2 * k + 1) * step
        slots_b.append((round(x1, 2), round(x1 + tw, 2)))
    pin_l = round(leaf_l + 2 * nut_h + 8.0, 2)
    riser_z = round(plate_t + GAP, 3)
    riser_top = round(riser_z + riser_t, 3)
    z_leaf = round(riser_top + GAP + leaf_t / 2, 3)
    washer_x = round(pin_l / 2 + GAP, 3)
    nut_x = round(pin_l / 2 + GAP + 1.6 + GAP, 3)

    builder = Builder("hingeflap", variant, "Comb hinge with flap")
    builder.add(P.plate("hinge_bed", plate_l, plate_w, plate_t,
                        ru_note=f"плита {P.num(plate_l)} x {P.num(plate_w)} x {P.num(plate_t)} мм",
                        en_note=f"mounting plate {P.num(plate_l)} x {P.num(plate_w)} x {P.num(plate_t)} mm"))
    builder.add(P.plate("hinge_riser", riser_l, riser_w, riser_t,
                        ru_note=f"подставка {P.num(riser_l)} x {P.num(riser_w)} x {P.num(riser_t)} мм",
                        en_note=f"riser {P.num(riser_l)} x {P.num(riser_w)} x {P.num(riser_t)} mm"),
                t=(0.0, 0.0, riser_z))
    builder.add(P2.hinge_half("hinge_leaf_a", leaf_l, leaf_w, leaf_t, lug, pin_bore,
                              slots_a, +1, "петлевая пластина A", "hinge leaf A"),
                t=(0.0, 0.0, z_leaf))
    builder.add(P2.hinge_half("hinge_leaf_b", leaf_l, leaf_w, leaf_t, lug, pin_bore,
                              slots_b, -1, "петлевая пластина B", "hinge leaf B"),
                t=(0.0, 0.0, z_leaf))
    builder.add(P.plate("hinge_flap", flap_l, flap_w, flap_t,
                        ru_note=f"створка {P.num(flap_l)} x {P.num(flap_w)} x {P.num(flap_t)} мм",
                        en_note=f"flap {P.num(flap_l)} x {P.num(flap_w)} x {P.num(flap_t)} mm"),
                axis="x", angle=90.0,
                t=(0.0, round(-leaf_w - GAP, 3),
                   round(riser_top + GAP + flap_w / 2, 3)))
    builder.add(pin3("hinge_pin", pin_d, pin_l, round(pin_d + 4.0, 2), 3.0),
                t=(0.0, 0.0, z_leaf))
    builder.add(P.washer("pin_washer", washer_od, pin_bore, 1.6),
                axis="y", angle=90.0, t=(washer_x, 0.0, z_leaf))
    builder.add(P.hexnut("pin_nut", nut_af, nut_h, pin_bore),
                axis="y", angle=90.0, t=(nut_x, 0.0, z_leaf))
    builder.note(
        f"Зубья пластин входят в пазы друг друга, палец d{P.num(pin_d)} стянут гайкой d{P.num(nut_af)}",
        f"the leaf teeth interleave, the d{P.num(pin_d)} pin is locked by the d{P.num(nut_af)} nut",
    )
    return builder.finish(
        rng,
        "гребёнчатую петлю со створкой",
        "a comb hinge with a swinging flap",
        f"leaf {leaf_l:g} x {leaf_w:g} mm, pin d{pin_d:g}, flap {flap_w:g} mm",
    )


FAMILY_BUILDERS = {
    "motorstation": build_motorstation,
    "beltloop": build_beltloop,
    "pressfixture": build_pressfixture,
    "rockerlink": build_rockerlink,
    "hingeflap": build_hingeflap,
}
