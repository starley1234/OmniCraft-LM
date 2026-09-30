"""2D profile geometry for the sketch1 corpus.

Everything here works on plain ``[(x, y), ...]`` lists in millimetres and keeps
the invariants the request asks for:

* one closed polygon, 6-40 points,
* simple (no self intersections, no repeated points, no zero length edges),
* counter clockwise winding,
* coordinates >= 0 (they are shifted into the first quadrant at the end).

The builders walk an outline through :class:`Walk`, which makes the point order
explicit and readable next to the drawing.
"""

from __future__ import annotations

import math

MIN_POINTS = 6
MAX_POINTS = 40
EPS = 1e-9


# ---------------------------------------------------------------------------
# measurements
# ---------------------------------------------------------------------------


def signed_area(points: list[tuple[float, float]]) -> float:
    """Shoelace area; positive for a counter clockwise ring."""
    total = 0.0
    count = len(points)
    for index in range(count):
        x0, y0 = points[index]
        x1, y1 = points[(index + 1) % count]
        total += x0 * y1 - x1 * y0
    return total / 2.0


def area(points: list[tuple[float, float]]) -> float:
    return abs(signed_area(points))


def perimeter(points: list[tuple[float, float]]) -> float:
    total = 0.0
    count = len(points)
    for index in range(count):
        x0, y0 = points[index]
        x1, y1 = points[(index + 1) % count]
        total += math.hypot(x1 - x0, y1 - y0)
    return total


def centroid_x(points: list[tuple[float, float]]) -> float:
    """x of the area centroid - used for the Pappus volume of a revolve."""
    cross_sum = 0.0
    x_sum = 0.0
    count = len(points)
    for index in range(count):
        x0, y0 = points[index]
        x1, y1 = points[(index + 1) % count]
        cross = x0 * y1 - x1 * y0
        cross_sum += cross
        x_sum += (x0 + x1) * cross
    if abs(cross_sum) < EPS:
        return 0.0
    return x_sum / (3.0 * cross_sum)


def bbox2(points: list[tuple[float, float]]) -> tuple[float, float, float, float]:
    xs = [point[0] for point in points]
    ys = [point[1] for point in points]
    return min(xs), min(ys), max(xs), max(ys)


def dedupe(points: list[tuple[float, float]], tolerance: float = 1e-6) -> list[tuple[float, float]]:
    """Drop repeated points, including the wrap-around duplicate."""
    cleaned: list[tuple[float, float]] = []
    for point in points:
        if not cleaned or math.dist(cleaned[-1], point) > tolerance:
            cleaned.append(point)
    if len(cleaned) > 1 and math.dist(cleaned[0], cleaned[-1]) <= tolerance:
        cleaned.pop()
    return cleaned


def simplify_collinear(
    points: list[tuple[float, float]], tolerance: float = 1e-4
) -> list[tuple[float, float]]:
    """Remove vertices that sit on the straight line between their neighbours."""
    points = dedupe(points)
    changed = True
    while changed and len(points) > MIN_POINTS:
        changed = False
        result: list[tuple[float, float]] = []
        count = len(points)
        for index in range(count):
            previous = points[index - 1]
            current = points[index]
            following = points[(index + 1) % count]
            ax, ay = current[0] - previous[0], current[1] - previous[1]
            bx, by = following[0] - current[0], following[1] - current[1]
            cross = abs(ax * by - ay * bx)
            if cross <= tolerance and (ax * bx + ay * by) >= 0.0:
                changed = True  # current point is redundant
                continue
            result.append(current)
        points = result
    return points


def ensure_ccw(points: list[tuple[float, float]]) -> list[tuple[float, float]]:
    return points if signed_area(points) > 0 else list(reversed(points))


def shift_into_quadrant(
    points: list[tuple[float, float]], min_x: float | None = 0.0, min_y: float = 0.0
) -> list[tuple[float, float]]:
    """Translate the profile so that it starts at the given corner.

    ``min_x=None`` keeps the x coordinates untouched (used for the profiles that
    are revolved, where x is the radius and must stay clear of the axis).
    """
    x0, y0, _, _ = bbox2(points)
    dx = -x0 + min_x if min_x is not None else 0.0
    dy = -y0 + min_y
    return [(round(x + dx, 3), round(y + dy, 3)) for x, y in points]


# ---------------------------------------------------------------------------
# simplicity
# ---------------------------------------------------------------------------


def _orientation(a, b, c) -> float:
    return (b[0] - a[0]) * (c[1] - a[1]) - (b[1] - a[1]) * (c[0] - a[0])


def _on_segment(a, b, c, tolerance: float = 1e-9) -> bool:
    """True when c lies on the closed segment a-b (assumes collinear)."""
    return (
        min(a[0], b[0]) - tolerance <= c[0] <= max(a[0], b[0]) + tolerance
        and min(a[1], b[1]) - tolerance <= c[1] <= max(a[1], b[1]) + tolerance
    )


def segments_cross(a, b, c, d, tolerance: float = 1e-12) -> bool:
    """True when the closed segments a-b and c-d share at least one point."""
    d1 = _orientation(c, d, a)
    d2 = _orientation(c, d, b)
    d3 = _orientation(a, b, c)
    d4 = _orientation(a, b, d)
    if ((d1 > tolerance) != (d2 > tolerance)) and ((d3 > tolerance) != (d4 > tolerance)):
        return True
    if abs(d1) <= tolerance and _on_segment(c, d, a):
        return True
    if abs(d2) <= tolerance and _on_segment(c, d, b):
        return True
    if abs(d3) <= tolerance and _on_segment(a, b, c):
        return True
    if abs(d4) <= tolerance and _on_segment(a, b, d):
        return True
    return False


def is_simple(points: list[tuple[float, float]]) -> bool:
    """No repeated points, no zero length edges, no crossings or touches."""
    count = len(points)
    if count < MIN_POINTS:
        return False
    for index in range(count):
        if math.dist(points[index], points[(index + 1) % count]) < 1e-6:
            return False
    for i in range(count):
        for j in range(i + 1, count):
            if j == i or (j - i) % count in (1, count - 1):
                continue  # neighbouring edges share an endpoint by design
            if segments_cross(points[i], points[(i + 1) % count], points[j], points[(j + 1) % count]):
                return False
    return True


def validate_profile(points, *, kind: str, min_axis: float = 5.0, max_axis: float = 250.0) -> list[str]:
    """Static profile rules from the request, plus the sketch1 extras."""
    problems: list[str] = []
    count = len(points)
    if count < MIN_POINTS:
        problems.append(f"profile has {count} points, fewer than {MIN_POINTS}")
    if count > MAX_POINTS:
        problems.append(f"profile has {count} points, more than {MAX_POINTS}")
    if any(x < -1e-9 or y < -1e-9 for x, y in points):
        problems.append("profile has a negative coordinate")
    if not is_simple(points):
        problems.append("profile is not a simple polygon")
    if signed_area(points) <= 0:
        problems.append("profile is not counter clockwise")
    if area(points) <= 1e-6:
        problems.append("profile has no area")
    if kind == "rotate":
        if min(x for x, _ in points) < 0.5:
            problems.append("revolved profile reaches the axis (x < 0.5)")
    else:
        x0, y0, x1, y1 = bbox2(points)
        for name, value in (("x", x1 - x0), ("y", y1 - y0)):
            if value < min_axis:
                problems.append(f"profile {name} span is {value:.2f} mm, below {min_axis} mm")
    return problems


# ---------------------------------------------------------------------------
# primitives
# ---------------------------------------------------------------------------


def arc_points(cx: float, cy: float, radius: float, a0: float, a1: float, count: int):
    """``count`` points from angle a0 to a1 (degrees), counter clockwise."""
    if a1 < a0:
        a1 += 360.0
    if count < 2:
        count = 2
    step = (a1 - a0) / (count - 1)
    points = []
    for index in range(count):
        angle = math.radians(a0 + step * index)
        points.append((cx + radius * math.cos(angle), cy + radius * math.sin(angle)))
    return points


def line_points(a, b, count: int):
    """``count`` points from a to b, both ends included."""
    if count < 2:
        return [tuple(a), tuple(b)]
    return [
        (a[0] + (b[0] - a[0]) * index / (count - 1), a[1] + (b[1] - a[1]) * index / (count - 1))
        for index in range(count)
    ]


def hull_points(points):
    """Monotone chain convex hull (counter clockwise)."""
    unique = sorted({(round(x, 6), round(y, 6)) for x, y in points})
    if len(unique) <= 2:
        return unique

    def build(sequence):
        chain = []
        for point in sequence:
            while len(chain) >= 2 and _orientation(chain[-2], chain[-1], point) <= 1e-9:
                chain.pop()
            chain.append(point)
        return chain

    lower = build(unique)
    upper = build(reversed(unique))
    return lower[:-1] + upper[:-1]


def hull_circles(circles, per_circle: int = 12, phase: float = 0.0):
    """Convex outline of a set of disks: used for levers, lugs, keys, eccentrics."""
    samples = []
    for index, (cx, cy, radius) in enumerate(circles):
        offset = phase + 360.0 * index / (per_circle * 3.0)
        for point in arc_points(cx, cy, radius, offset, offset + 360.0, per_circle + 1)[:-1]:
            samples.append(point)
    ring = hull_points(samples)
    return simplify_collinear(ring)


def rounded_rect(x0: float, y0: float, x1: float, y1: float, radius: float, per_corner: int = 3):
    """Counter clockwise rounded rectangle, corners included."""
    radius = min(radius, (x1 - x0) / 2.0, (y1 - y0) / 2.0)
    points = []
    points += line_points((x0 + radius, y0), (x1 - radius, y0), 2)
    points += arc_points(x1 - radius, y0 + radius, radius, 270, 360, per_corner)
    points += line_points((x1, y0 + radius), (x1, y1 - radius), 2)[1:]
    points += arc_points(x1 - radius, y1 - radius, radius, 0, 90, per_corner)
    points += line_points((x1 - radius, y1), (x0 + radius, y1), 2)[1:]
    points += arc_points(x0 + radius, y1 - radius, radius, 90, 180, per_corner)
    points += line_points((x0, y1 - radius), (x0, y0 + radius), 2)[1:]
    points += arc_points(x0 + radius, y0 + radius, radius, 180, 270, per_corner)[1:]
    return dedupe(points)


def polar_profile(radii, phase: float = 0.0):
    """Ring from a list of (angle_deg, radius) pairs, angles strictly increasing.

    Every edge stays inside its own angular wedge, so the ring cannot cross
    itself as long as the radii are positive and the wedge gaps are below 180
    degrees - the construction the cams, sprockets and rotors rely on.
    """
    points = []
    for angle, radius in radii:
        radians = math.radians(angle + phase)
        points.append((radius * math.cos(radians), radius * math.sin(radians)))
    return dedupe(points)


def thick_path(path, half_width: float, cap_points: int = 5):
    """Outline of a stroked open path (hooks, omega clips, curls).

    The path is a polyline; both sides are offset by ``half_width`` and the ends
    get round caps.  Keep ``half_width`` below ~0.45 of the path's smallest
    radius of curvature and the outline stays simple.
    """
    count = len(path)
    if count < 2:
        return []
    directions = []
    for index in range(count - 1):
        dx = path[index + 1][0] - path[index][0]
        dy = path[index + 1][1] - path[index][1]
        length = math.hypot(dx, dy) or 1.0
        directions.append((dx / length, dy / length))

    def normal(index, sign):
        dx, dy = directions[index]
        return (sign * -dy, sign * dx)

    left = []
    for index in range(count):
        offsets = []
        if index > 0:
            offsets.append(normal(index - 1, 1.0))
        if index < count - 1:
            offsets.append(normal(index, 1.0))
        if len(offsets) == 1:
            direction = offsets[0]
        else:
            mx = offsets[0][0] + offsets[1][0]
            my = offsets[0][1] + offsets[1][1]
            length = math.hypot(mx, my)
            if length < 1e-9:
                direction = offsets[0]
            else:
                cosine = (offsets[0][0] * offsets[1][0] + offsets[0][1] * offsets[1][1]) / (
                    math.hypot(*offsets[0]) * math.hypot(*offsets[1])
                )
                scale = min(1.0 / max(cosine, 0.35), 2.4) / length
                # scale keeps the miter from shooting off on sharp corners
                direction = (mx * scale, my * scale)
        left.append((path[index][0] + half_width * direction[0], path[index][1] + half_width * direction[1]))

    outline = list(left)
    end = path[-1]
    before_end = left[-1]
    start_angle = math.degrees(math.atan2(before_end[1] - end[1], before_end[0] - end[0]))
    outline += arc_points(end[0], end[1], half_width, start_angle, start_angle - 180.0, cap_points)[1:]
    outline += [
        (2 * path[index][0] - left[index][0], 2 * path[index][1] - left[index][1])
        for index in reversed(range(count))
    ]
    start = path[0]
    after_start = outline[-1]
    start_angle = math.degrees(math.atan2(after_start[1] - start[1], after_start[0] - start[0]))
    outline += arc_points(start[0], start[1], half_width, start_angle, start_angle - 180.0, cap_points)[1:-1]
    return dedupe(outline)


def polygon_literal(points, digits: int = 3) -> str:
    """Render the profile the way it appears in the .scad header."""
    def number(value: float) -> str:
        text = f"{value:.{digits}f}".rstrip("0").rstrip(".")
        return text if text not in ("", "-0") else "0"

    return "[" + ", ".join(f"[{number(x)}, {number(y)}]" for x, y in points) + "]"


# ---------------------------------------------------------------------------
# walking helper
# ---------------------------------------------------------------------------


class Walk:
    """Collect an outline segment by segment, then hand back a clean ring."""

    def __init__(self) -> None:
        self.points: list[tuple[float, float]] = []

    def add(self, *points) -> "Walk":
        for point in points:
            self.points.append((float(point[0]), float(point[1])))
        return self

    def line(self, a, b, count: int = 2) -> "Walk":
        self.points += line_points(a, b, count)
        return self

    def arc(self, cx, cy, radius, a0, a1, count: int) -> "Walk":
        self.points += arc_points(cx, cy, radius, a0, a1, count)
        return self

    def arc_back(self, cx, cy, radius, a0, a1, count: int) -> "Walk":
        """Same arc, walked clockwise (needed for convex fillets on the way back)."""
        self.points += list(reversed(arc_points(cx, cy, radius, a1, a0, count)))
        return self

    def ring(self, points) -> "Walk":
        self.points += list(points)
        return self

    def result(self, simplify: bool = True) -> list[tuple[float, float]]:
        points = dedupe(self.points)
        if simplify:
            points = simplify_collinear(points)
        return ensure_ccw(points)
