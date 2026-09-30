"""Outline walkers shared by the sketch1 families.

Every walker returns a counter clockwise, simple ring of points in millimetres.
The shapes are the ones the request lists: comb/rack teeth, bays and keyhole
windows, band segments with a lug, flat discs, clevis forks, staples, frames,
grilles and spikes on a convex hull.
"""

from __future__ import annotations

import math

from tools.dataset_sketch1.geom1 import (
    Walk,
    arc_points,
    bbox2,
    dedupe,
    ensure_ccw,
    hull_points,
    simplify_collinear,
)


def _direction(angle_deg: float) -> tuple[float, float]:
    radians = math.radians(angle_deg)
    return math.cos(radians), math.sin(radians)


# ---------------------------------------------------------------------------
# rectangular plates with bays / windows
# ---------------------------------------------------------------------------


def bays_plate(
    x0: float,
    y0: float,
    x1: float,
    y1: float,
    bay_centres,
    *,
    side: str = "top",
    depth: float,
    pocket_w: float,
    neck_w: float,
    neck_d: float,
    corner: float = 0.0,
):
    """Plate with open bays along one edge (windows / pockets / oversize slots).

    Each bay is a keyhole: a narrow neck at the surface opens into a wider
    pocket deeper in the material.  The bays are open, which is what makes the
    whole part a single polygon.
    """
    walk = Walk()
    height = y1 - y0
    if side == "top":
        if corner > 0:
            walk.arc(x0 + corner, y0 + corner, corner, 180, 270, 3)
            walk.line((x0 + corner, y0), (x1 - corner, y0), 2)
            walk.arc(x1 - corner, y0 + corner, corner, 270, 360, 3)
            walk.line((x1, y0 + corner), (x1, y1 - corner), 2)
        else:
            walk.add((x0, y0), (x1, y0), (x1, y1))
        walk.add((x1, y1))  # top right corner, the bays start from here
        keyhole = neck_d > 0.5 and neck_w < pocket_w - 0.5
        for centre in sorted(bay_centres, reverse=True):
            if keyhole:
                walk.add(
                    (centre + neck_w / 2, y1),
                    (centre + neck_w / 2, y1 - neck_d),
                    (centre + pocket_w / 2, y1 - neck_d),
                    (centre + pocket_w / 2, y1 - depth),
                    (centre - pocket_w / 2, y1 - depth),
                    (centre - pocket_w / 2, y1 - neck_d),
                    (centre - neck_w / 2, y1 - neck_d),
                    (centre - neck_w / 2, y1),
                )
            else:
                walk.add(
                    (centre + pocket_w / 2, y1),
                    (centre + pocket_w / 2, y1 - depth),
                    (centre - pocket_w / 2, y1 - depth),
                    (centre - pocket_w / 2, y1),
                )
        walk.add((x0, y1))
    else:  # side == "bottom", used for slotted bars
        if corner > 0:
            walk.arc(x1 - corner, y1 - corner, corner, 0, 90, 3)
            walk.line((x1 - corner, y1), (x0 + corner, y1), 2)
            walk.arc(x0 + corner, y1 - corner, corner, 90, 180, 3)
            walk.line((x0, y1 - corner), (x0, y0 + corner), 2)
        else:
            walk.add((x1, y1), (x0, y1), (x0, y0))
        for centre in sorted(bay_centres):
            walk.add(
                (centre - neck_w / 2, y0),
                (centre - neck_w / 2, y0 + neck_d),
                (centre - pocket_w / 2, y0 + neck_d),
                (centre - pocket_w / 2, y0 + depth),
                (centre + pocket_w / 2, y0 + depth),
                (centre + pocket_w / 2, y0 + neck_d),
                (centre + neck_w / 2, y0 + neck_d),
                (centre + neck_w / 2, y0),
            )
        walk.add((x1, y0))
    del height
    return walk.result()


def comb_teeth(
    length: float,
    base_h: float,
    teeth: int,
    tip_h: float,
    tip_w: float,
    margin: float,
):
    """Rack / comb: a base bar with trapezoid teeth along the top edge."""
    walk = Walk()
    pitch = (length - 2 * margin) / teeth
    root_w = max(tip_w + 1.0, pitch * 0.45)
    del root_w
    walk.add((0.0, 0.0), (length, 0.0), (length, base_h))
    for index in reversed(range(teeth)):
        centre = margin + pitch * (index + 0.5)
        walk.add(
            (centre + tip_w / 2, base_h),
            (centre + tip_w / 2 * 0.6, base_h + tip_h),
            (centre - tip_w / 2 * 0.6, base_h + tip_h),
            (centre - tip_w / 2, base_h),
        )
    walk.add((0.0, base_h))
    return walk.result()


def grille(
    width: float,
    height: float,
    base_h: float,
    slats: int,
    slat_w: float,
    rail: float,
    slat_h: float,
):
    """Guard grille: a frame with a row of slats standing on a base bar."""
    walk = Walk()
    usable = width - 2 * rail
    clear = min(3.0, usable * 0.05)
    pitch = (usable - slat_w - 2 * clear) / (slats - 1) if slats > 1 else 0.0
    walk.add((0.0, 0.0), (width, 0.0), (width, height), (width - rail, height), (width - rail, base_h))
    for index in reversed(range(slats)):
        centre = rail + clear + slat_w / 2 + pitch * index
        walk.add(
            (centre + slat_w / 2, base_h),
            (centre + slat_w / 2, base_h + slat_h),
            (centre - slat_w / 2, base_h + slat_h),
            (centre - slat_w / 2, base_h),
        )
    walk.add((rail, base_h), (rail, height), (0.0, height))
    return walk.result()


def frame_with_window(width: float, height: float, wall: float, base_t: float, corner: float = 0.0):
    """Pi shaped frame: a solid base and two uprights around an open window."""
    walk = Walk()
    window_w = width - 2 * wall
    if corner > 0:
        walk.arc(corner, corner, corner, 180, 270, 3)
        walk.line((corner, 0.0), (width - corner, 0.0), 2)
        walk.arc(width - corner, corner, corner, 270, 360, 3)
    else:
        walk.add((0.0, 0.0), (width, 0.0))
    walk.add((width, height), (wall + window_w, height), (wall + window_w, base_t), (wall, base_t), (wall, height), (0.0, height))
    return walk.result()


# ---------------------------------------------------------------------------
# rings and bands
# ---------------------------------------------------------------------------


def band_segment(
    centre,
    r_out: float,
    r_in: float,
    a0: float,
    a1: float,
    *,
    inner_points: int = 6,
    outer_points: int = 8,
    lug_h: float = 0.0,
    lug_span: float = 0.0,
):
    """Annular sector, optionally with a raised lug on its outer rim."""
    cx, cy = centre
    walk = Walk()
    for point in arc_points(cx, cy, r_in, a0, a1, inner_points):
        walk.add(point)
    walk.add((cx + r_out * math.cos(math.radians(a1)), cy + r_out * math.sin(math.radians(a1))))
    outer = arc_points(cx, cy, r_out, a0, a1, outer_points)
    if lug_h > 0 and lug_span > 0:
        split = a0 + lug_span
        tail = [point for point in arc_points(cx, cy, r_out, split, a1, outer_points) if a1 - split > 1.0]
        for point in reversed(tail):
            walk.add(point)
        walk.add(
            (
                cx + (r_out + lug_h) * math.cos(math.radians(split)),
                cy + (r_out + lug_h) * math.sin(math.radians(split)),
            )
        )
        for point in reversed(arc_points(cx, cy, r_out + lug_h, a0, split, 3)):
            walk.add(point)
    else:
        for point in reversed(outer):
            walk.add(point)
    return walk.result()


def polar_ring(radii, phase: float = 0.0):
    """Ring sampled by angle: radii is a list of (angle, radius) with rising angles."""
    points = []
    for angle, radius in radii:
        radians = math.radians(angle + phase)
        points.append((radius * math.cos(radians), radius * math.sin(radians)))
    return ensure_ccw(dedupe(points))


def thick_outline(path, half_width: float, cap_points: int = 3):
    from tools.dataset_sketch1.geom1 import thick_path

    return ensure_ccw(thick_path(path, half_width, cap_points))


# ---------------------------------------------------------------------------
# convex hulls with features
# ---------------------------------------------------------------------------


def spike_on_hull(ring, direction_deg: float, base_frac: float, height: float):
    """Add a beak to a convex ring by pushing one of its *long* edges out.

    Only edges at least 5 mm long are candidates - the point-sampled caps of a
    hull of circles are made of tiny chords, and a beak sitting on one of those
    collapses into a sliver.  If no edge qualifies the ring comes back
    unchanged, which keeps the outline simple instead of corrupt.
    """
    count = len(ring)
    cx = sum(point[0] for point in ring) / count
    cy = sum(point[1] for point in ring) / count
    dx, dy = _direction(direction_deg)
    best_index = -1
    best_score = -1e18
    for index in range(count):
        a, b = ring[index], ring[(index + 1) % count]
        length = math.hypot(b[0] - a[0], b[1] - a[1])
        if length < 5.0:
            continue
        mx, my = (a[0] + b[0]) / 2, (a[1] + b[1]) / 2
        score = ((mx - cx) * dx + (my - cy) * dy) + length * 0.05
        if score > best_score:
            best_score = score
            best_index = index
    if best_index < 0:
        return ensure_ccw(list(ring))
    a = ring[best_index]
    b = ring[(best_index + 1) % count]
    length = math.hypot(b[0] - a[0], b[1] - a[1])
    half = max(1.2, min(length * base_frac, 4.0))
    ux, uy = (b[0] - a[0]) / length, (b[1] - a[1]) / length
    mx, my = (a[0] + b[0]) / 2, (a[1] + b[1]) / 2
    nx, ny = -dy, dx
    if nx * (mx - cx) + ny * (my - cy) < 0:
        nx, ny = -nx, -ny
    tip = (mx + nx * height, my + ny * height)
    points = list(ring)
    points.insert(best_index + 1, (mx - ux * half, my - uy * half))
    points.insert(best_index + 2, tip)
    points.insert(best_index + 3, (mx + ux * half, my + uy * half))
    return ensure_ccw(simplify_collinear(points))


def beaked_block(
    x0: float,
    y0: float,
    x1: float,
    y1: float,
    corner: float,
    *,
    side: str,
    beak_base: float,
    beak_h: float,
    per_corner: int = 3,
):
    """Rounded rectangle with a triangular beak on the top or right edge."""
    walk = Walk()
    walk.arc(x0 + corner, y0 + corner, corner, 180, 270, per_corner)
    walk.line((x0 + corner, y0), (x1 - corner, y0), 2)
    walk.arc(x1 - corner, y0 + corner, corner, 270, 360, per_corner)
    if side == "right":
        mid = (y0 + y1) / 2
        half = min(beak_base / 2, (y1 - y0) / 2 - corner - 1.0)
        walk.line((x1, y0 + corner), (x1, round(mid - half, 4)), 2)
        walk.add((x1 + beak_h, mid))
        walk.line((x1, round(mid + half, 4)), (x1, y1 - corner), 2)
    else:
        walk.line((x1, y0 + corner), (x1, y1 - corner), 2)
    walk.arc(x1 - corner, y1 - corner, corner, 0, 90, per_corner)
    if side == "top":
        mid = (x0 + x1) / 2
        half = min(beak_base / 2, (x1 - x0) / 2 - corner - 1.0)
        walk.line((x1 - corner, y1), (round(mid + half, 4), y1), 2)
        walk.add((mid, y1 + beak_h))
        walk.line((round(mid - half, 4), y1), (x0 + corner, y1), 2)
    else:
        walk.line((x1 - corner, y1), (x0 + corner, y1), 2)
    walk.arc(x0 + corner, y1 - corner, corner, 90, 180, per_corner)
    walk.line((x0, y1 - corner), (x0, y0 + corner), 2)
    return walk.result()


def fork_outline(
    base_w: float,
    base_h: float,
    prong_h: float,
    slot_w: float,
    corner: float,
    per_corner: int = 3,
):
    """Clevis fork: a base with two prongs and an open slot between them.

    Walking counter clockwise: up the right side, left along the right prong,
    down into the slot, west along the slot floor, up the left prong, back along
    the base.  The four corners of the slot are rounded; the two reentrant ones
    take their fillet arc from the void side.
    """
    walk = Walk()
    arm = (base_w - slot_w) / 2
    inner_r = base_w - arm
    # base, outer corners
    walk.arc(corner, corner, corner, 180, 270, per_corner)
    walk.line((corner, 0.0), (base_w - corner, 0.0), 2)
    walk.arc(base_w - corner, corner, corner, 270, 360, per_corner)
    # right side of the right prong
    walk.line((base_w, corner), (base_w, prong_h - corner), 2)
    walk.arc(base_w - corner, prong_h - corner, corner, 0, 90, per_corner)
    # top of the right prong, then its inner corner
    walk.line((base_w - corner, prong_h), (inner_r + corner, prong_h), 2)
    walk.arc(inner_r + corner, prong_h - corner, corner, 90, 180, per_corner)
    # down the inner side into the slot
    walk.line((inner_r, prong_h - corner), (inner_r, base_h + corner), 2)
    walk.arc_back(inner_r - corner, base_h + corner, corner, 0, -90, per_corner)
    # slot floor
    walk.line((inner_r - corner, base_h), (arm + corner, base_h), 2)
    walk.arc_back(arm + corner, base_h + corner, corner, 270, 180, per_corner)
    # up the left prong
    walk.line((arm, base_h + corner), (arm, prong_h - corner), 2)
    walk.arc(arm - corner, prong_h - corner, corner, 0, 90, per_corner)
    walk.line((arm - corner, prong_h), (corner, prong_h), 2)
    walk.arc(corner, prong_h - corner, corner, 90, 180, per_corner)
    walk.line((0.0, prong_h - corner), (0.0, corner), 2)
    return walk.result()


def staple_outline(span: float, leg_h: float, leg_w: float, bar_t: float, corner: float, per_corner: int = 3):
    """U / Pi staple: two legs joined by a bar, drawn as one polygon."""
    walk = Walk()
    inner_top = leg_h - bar_t
    walk.arc(corner, corner, corner, 180, 270, per_corner)
    walk.line((corner, 0.0), (leg_w - corner, 0.0), 2)
    walk.arc(leg_w - corner, corner, corner, 270, 360, per_corner)
    walk.line((leg_w, corner), (leg_w, inner_top - corner), 2)
    walk.arc(leg_w - corner, inner_top - corner, corner, 0, 90, per_corner)
    walk.line((leg_w - corner, inner_top), (span - leg_w + corner, inner_top), 2)
    walk.arc(span - leg_w + corner, inner_top - corner, corner, 90, 180, per_corner)
    walk.line((span - leg_w, inner_top - corner), (span - leg_w, corner), 2)
    walk.arc(span - leg_w + corner, corner, corner, 180, 270, per_corner)
    walk.line((span - leg_w + corner, 0.0), (span - corner, 0.0), 2)
    walk.arc(span - corner, corner, corner, 270, 360, per_corner)
    walk.line((span, corner), (span, leg_h - corner), 2)
    walk.arc(span - corner, leg_h - corner, corner, 0, 90, per_corner)
    walk.line((span - corner, leg_h), (corner, leg_h), 2)
    walk.arc(corner, leg_h - corner, corner, 90, 180, per_corner)
    walk.line((0.0, leg_h - corner), (0.0, corner), 2)
    return walk.result()


def omega_outline(centre, r_mid: float, half_w: float, sweep: float, leg_len: float, path_points: int = 11):
    """Omega clamp: a C ring whose two ends continue as straight tangent legs.

    Built explicitly (outer arc -> leg tip -> square cap -> inner arc -> leg
    tip) instead of by offsetting a centreline: an offset of a path with two
    free ends folds over itself as soon as the legs get long.
    """
    cx, cy = centre
    start = 180.0 - (sweep - 180.0) / 2.0
    end = start + sweep
    outer = list(arc_points(cx, cy, r_mid + half_w, start, end, path_points))
    inner = list(arc_points(cx, cy, r_mid - half_w, start, end, path_points))
    dex, dey = _direction(end + 90.0)
    dsx, dsy = _direction(start - 90.0)
    points = list(outer)
    points.append((outer[-1][0] + dex * leg_len, outer[-1][1] + dey * leg_len))
    points.append((inner[-1][0] + dex * leg_len, inner[-1][1] + dey * leg_len))
    points += list(reversed(inner))
    points.append((inner[0][0] + dsx * leg_len, inner[0][1] + dsy * leg_len))
    points.append((outer[0][0] + dsx * leg_len, outer[0][1] + dsy * leg_len))
    return ensure_ccw(points)


def flat_disc(radius: float, flat_offset: float, *, flats: int = 2, samples: int = 10):
    """Disc with one or two machined flats (D shape / double D adapter)."""
    points = []
    if flats == 2:
        corner_angle = math.degrees(math.asin(min(0.999, flat_offset / radius)))
        points += arc_points(0.0, 0.0, radius, corner_angle, 180.0 - corner_angle, samples)
        points += arc_points(0.0, 0.0, radius, 180.0 + corner_angle, 360.0 - corner_angle, samples)
    else:
        points += arc_points(0.0, 0.0, radius, -60.0, 240.0, samples * 2)
    return ensure_ccw(dedupe(points))


def hull_with_rect(circles, rect_corners, per_circle: int = 10):
    samples = []
    for index, (cx, cy, radius) in enumerate(circles):
        offset = 360.0 * index / (per_circle * 3.0)
        samples += arc_points(cx, cy, radius, offset, offset + 360.0, per_circle + 1)[:-1]
    samples += list(rect_corners)
    return ensure_ccw(simplify_collinear(hull_points(samples)))


def x_span(points) -> float:
    x0, _, x1, _ = bbox2(points)
    return x1 - x0


def y_span(points) -> float:
    _, y0, _, y1 = bbox2(points)
    return y1 - y0
