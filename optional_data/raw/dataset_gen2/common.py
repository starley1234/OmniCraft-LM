"""Shared infrastructure for the gen2 OpenSCAD corpus generator.

Design goals (see ``optional_data/data/gen2/ADDED.md``):

* every sample is *parametric* OpenSCAD in the requested style: ``$fn = 32;``
  first line, all sizes as named variables in the header, repeated features in
  loops, reused geometry in modules;
* every sample is verified before it is written: the emitted source is executed
  by :mod:`tools.dataset_gen2.miniscad` (the Manifold kernel OpenSCAD itself
  uses with ``--backend=manifold``) and its mesh must be a single watertight
  solid whose bounding box matches the declared ``expected_bbox_mm``;
* prompts are composed from large phrase banks so that no two samples of a
  family share the same wording.
"""

from __future__ import annotations

import hashlib
import math
import random
from dataclasses import dataclass, field
from typing import Any, Callable, Iterable, Sequence

# ---------------------------------------------------------------------------
# number / string formatting
# ---------------------------------------------------------------------------


def fmt(value: float, digits: int = 2) -> str:
    """Format a number the way an engineer would write it in OpenSCAD."""
    if not math.isfinite(value):
        raise ValueError(f"non-finite value in generated code: {value!r}")
    text = f"{value:.{digits}f}"
    if "." in text:  # only trailing *decimals* may be dropped
        text = text.rstrip("0").rstrip(".")
    if text in ("-0", ""):
        text = "0"
    return text


def mm(value: float) -> str:
    return fmt(value)


def align(declarations: Sequence[tuple[str, float, str]], comment_column: int = 26) -> str:
    """Render ``name = value;  // comment`` lines aligned into a column."""
    lines = []
    for name, value, comment in declarations:
        left = f"{name} = {fmt(value)};"
        padding = " " * max(2, comment_column - len(left))
        lines.append(f"{left}{padding}// {comment}".rstrip())
    return "\n".join(lines)


# ---------------------------------------------------------------------------
# part description
# ---------------------------------------------------------------------------


@dataclass
class Part:
    """One dataset sample: source code plus everything the manifest needs."""

    family: str
    variant: str
    code: str
    bbox: tuple[float, float, float]
    params: dict[str, float]
    prompt_ru: str
    prompt_en: str
    graph: dict[str, Any] | None = None
    notes: str = ""
    tags: tuple[str, ...] = ()

    def with_graph(self, graph: dict[str, Any] | None) -> "Part":
        """Attach the wire ground truth (nodes/edges) used by truss-like families."""
        self.graph = graph
        return self

    @property
    def sha256(self) -> str:
        return hashlib.sha256(self.code.encode("utf-8")).hexdigest()

    def manifest_row(self, file_name: str) -> dict[str, Any]:
        return {
            "file": file_name,
            "family": self.family,
            "prompt_ru": self.prompt_ru,
            "prompt_en": self.prompt_en,
            "expected_bbox_mm": [round(value, 3) for value in self.bbox],
            "parameters": {key: round(value, 3) for key, value in self.params.items()},
            "graph": self.graph,
        }


class ScadBuilder:
    """Assemble an OpenSCAD file: header, parameter block, then geometry."""

    def __init__(self, title: str, summary: str = "") -> None:
        self.title = title
        self.summary = summary
        self.declarations: list[tuple[str, float, str]] = []
        self.sections: list[str] = []
        self.extra_assignments: list[str] = []

    def param(self, name: str, value: float, comment: str) -> str:
        if any(existing == name for existing, _, _ in self.declarations):
            raise ValueError(f"duplicate parameter {name!r} in {self.title}")
        self.declarations.append((name, float(value), comment))
        return name

    def assignment(self, line: str) -> None:
        """Append a derived (non-scalar) assignment to the parameter block."""
        self.extra_assignments.append(line)

    def section(self, code: str) -> None:
        self.sections.append(code.strip("\n"))

    def render(self) -> str:
        body: list[str] = ["$fn = 32;", ""]
        banner = f"// {self.title}" + (f": {self.summary}" if self.summary else "")
        body.append("-" * max(len(banner.rstrip()), 1))
        body[-1] = "// " + "-" * 70
        body.append(banner)
        body.append("// " + "-" * 70)
        body.append("")
        body.append("// --- parameters (mm) ---")
        body.append(align(self.declarations))
        if self.extra_assignments:
            body.append("")
            body.extend(self.extra_assignments)
        for section in self.sections:
            body.append("")
            body.append(section)
        text = "\n".join(body).rstrip() + "\n"
        return text


# ---------------------------------------------------------------------------
# random helpers
# ---------------------------------------------------------------------------


class Rng:
    """Deterministic random source for one sample."""

    def __init__(self, family: str, index: int, seed: int = 20260929) -> None:
        self.random = random.Random(f"omnicraft-gen2-{family}-{seed}-{index}")

    def choice(self, items: Sequence[Any]) -> Any:
        return self.random.choice(list(items))

    def sample(self, items: Sequence[Any], count: int) -> list[Any]:
        items = list(items)
        return self.random.sample(items, min(count, len(items)))

    def uniform(self, low: float, high: float, digits: int = 2) -> float:
        return round(self.random.uniform(low, high), digits)

    def grid(self, values: Sequence[float]) -> float:
        return float(self.random.choice(list(values)))

    def integer(self, low: int, high: int) -> int:
        return self.random.randint(low, high)

    def chance(self, probability: float) -> bool:
        return self.random.random() < probability

    def shuffled(self, items: Sequence[Any]) -> list[Any]:
        items = list(items)
        self.random.shuffle(items)
        return items


def hole_for_thread(rng: Rng) -> tuple[str, float, float, float]:
    """Thread clearance hole diameter, head diameter and head height."""
    table = [
        ("M3", 3.4, 6.0, 1.9),
        ("M4", 4.5, 8.0, 2.4),
        ("M5", 5.5, 9.5, 2.9),
        ("M6", 6.6, 11.0, 3.4),
        ("M8", 9.0, 14.5, 4.4),
    ]
    thread, hole_d, head_d, head_h = rng.choice(table)
    return thread, hole_d, head_d, head_h


def bolt_circle(count: int) -> list[float]:
    return [index * 360.0 / count for index in range(count)]


def polar_xy(radius: float, angle_deg: float) -> tuple[float, float]:
    radians = math.radians(angle_deg)
    return radius * math.cos(radians), radius * math.sin(radians)


# ---------------------------------------------------------------------------
# validation
# ---------------------------------------------------------------------------


@dataclass
class CheckResult:
    ok: bool
    errors: list[str] = field(default_factory=list)
    measured_bbox: tuple[float, float, float] | None = None
    volume: float = 0.0
    components: int = 0
    genus: int = 0
    relative_error: tuple[float, float, float] = (0.0, 0.0, 0.0)


def check_part(part: Part, max_relative_error: float = 0.03) -> CheckResult:
    """Execute the emitted OpenSCAD with the manifold kernel and audit it."""
    from tools.dataset_gen2.miniscad import MiniScadError, evaluate_3d

    errors: list[str] = []
    lines = part.code.splitlines()
    if not lines or lines[0] != "$fn = 32;":
        errors.append("missing '$fn = 32;' header")
    if any(token in part.code for token in ("import(", "surface(", "text(", "children(", "rands(", "echo(")):
        errors.append("forbidden construct in source")
    if len(part.code.encode("utf-8")) > 12000:
        errors.append("source exceeds 12 kB")
    if any(bad in part.code for bad in ("nan", "undef", "-0.0;")):
        errors.append("suspicious token in source")
    if part.graph is not None:
        nodes = part.graph.get("nodes") or []
        edges = part.graph.get("edges") or []
        if not nodes:
            errors.append("wire sample without graph nodes")
        elif not edges:
            errors.append("wire sample without graph edges")
        else:
            degree = [0] * len(nodes)
            adjacency: dict[int, set[int]] = {index: set() for index in range(len(nodes))}
            for edge in edges:
                start, end = int(edge[0]), int(edge[1])
                if not (0 <= start < len(nodes) and 0 <= end < len(nodes)):
                    errors.append("graph edge references a missing node")
                    continue
                if math.dist(nodes[start], nodes[end]) <= 1e-9:
                    errors.append("graph edge has zero length")
                degree[start] += 1
                degree[end] += 1
                adjacency[start].add(end)
                adjacency[end].add(start)
            if any(value == 0 for value in degree):
                errors.append("graph has isolated nodes")
            seen = {0}
            stack = [0]
            while stack:
                current = stack.pop()
                for neighbour in adjacency[current]:
                    if neighbour not in seen:
                        seen.add(neighbour)
                        stack.append(neighbour)
            if len(seen) != len(nodes):
                errors.append("graph is not connected")
    try:
        manifold = evaluate_3d(part.code)
    except MiniScadError as exc:
        return CheckResult(False, errors + [f"evaluation failed: {exc}"])

    box = manifold.bounding_box()
    measured = (box[3] - box[0], box[4] - box[1], box[5] - box[2])
    components = manifold.decompose()
    relative = tuple(
        abs(measured[index] - part.bbox[index]) / max(part.bbox[index], 1e-9) for index in range(3)
    )
    if len(components) != 1:
        errors.append(f"expected a single connected solid, got {len(components)}")
    if any(error > max_relative_error for error in relative):
        errors.append(
            "bounding box mismatch: measured "
            f"{tuple(round(value, 3) for value in measured)} vs declared "
            f"{tuple(round(value, 3) for value in part.bbox)}"
        )
    if manifold.volume() <= 0:
        errors.append("non-positive volume")
    result = CheckResult(
        not errors,
        errors,
        measured,
        manifold.volume(),
        len(components),
        manifold.genus(),
        relative,  # type: ignore[arg-type]
    )
    return result


# ---------------------------------------------------------------------------
# graph helpers (wire families)
# ---------------------------------------------------------------------------


class Graph:
    """Node/edge accumulator; nodes are printed exactly as used in the code."""

    def __init__(self) -> None:
        self.nodes: list[tuple[float, float, float]] = []
        self._index: dict[tuple[float, float, float], int] = {}
        self.edges: list[tuple[int, int]] = []

    def node(self, point: Sequence[float]) -> int:
        key = (round(float(point[0]), 6), round(float(point[1]), 6), round(float(point[2]), 6))
        if key not in self._index:
            self._index[key] = len(self.nodes)
            self.nodes.append(key)
        return self._index[key]

    def edge(self, start: Sequence[float], end: Sequence[float]) -> None:
        a = self.node(start)
        b = self.node(end)
        if a == b:
            return
        if (a, b) not in self.edges and (b, a) not in self.edges:
            self.edges.append((a, b))

    def as_json(self) -> dict[str, Any]:
        return {
            "nodes": [[round(value, 4) for value in node] for node in self.nodes],
            "edges": [[start, end] for start, end in self.edges],
        }

    def is_connected(self) -> bool:
        if not self.nodes:
            return False
        adjacency: dict[int, set[int]] = {index: set() for index in range(len(self.nodes))}
        for start, end in self.edges:
            adjacency[start].add(end)
            adjacency[end].add(start)
        seen = {0}
        stack = [0]
        while stack:
            current = stack.pop()
            for neighbour in adjacency[current]:
                if neighbour not in seen:
                    seen.add(neighbour)
                    stack.append(neighbour)
        return len(seen) == len(self.nodes)

    def has_isolated_nodes(self) -> bool:
        used: set[int] = set()
        for start, end in self.edges:
            used.add(start)
            used.add(end)
        return len(used) != len(self.nodes)

    def has_zero_length_edges(self) -> bool:
        for start, end in self.edges:
            a = self.nodes[start]
            b = self.nodes[end]
            if math.dist(a, b) < 1e-6:
                return True
        return False


# ---------------------------------------------------------------------------
# registry
# ---------------------------------------------------------------------------

FAMILIES: dict[str, tuple[str, Callable[[int], Part]]] = {}


def register(family: str, builder: Callable[[int], Part]) -> None:
    if family in FAMILIES:
        raise ValueError(f"family {family!r} registered twice")
    FAMILIES[family] = (family, builder)


def registered_families() -> Iterable[str]:
    return sorted(FAMILIES)


# ---------------------------------------------------------------------------
# geometry helpers shared by several families
# ---------------------------------------------------------------------------


def polar_points(count: int, radius: float, start: float = 0.0) -> list[tuple[float, float]]:
    return [polar_xy(radius, start + angle) for angle in bolt_circle(count)]


def involute_point(base_radius: float, pressure_angle: float, roll_angle: float) -> tuple[float, float]:
    """Unwrapped involute point (used for the gear flank polygon)."""
    tangent = math.tan(pressure_angle)
    return (
        base_radius * (math.cos(roll_angle) + roll_angle * math.sin(roll_angle)),
        base_radius * (math.sin(roll_angle) - roll_angle * math.cos(roll_angle)),
    )


def finish_part(
    rng: Rng,
    *,
    family: str,
    variant: str,
    code: str,
    bbox: tuple[float, float, float],
    params: dict[str, float],
    ru_nouns: tuple[str, ...],
    en_nouns: tuple[str, ...],
    features_ru: list[str],
    features_en: list[str],
    feature_count: tuple[int, int] = (2, 3),
) -> Part:
    """Shared tail: compose the RU/EN prompts and build the Part record."""
    from tools.dataset_gen2.prompts import build_prompt

    prompt_ru, prompt_en = build_prompt(
        rng,
        ru_nouns=ru_nouns,
        en_nouns=en_nouns,
        bbox=bbox,
        ru_feature_sentences=[s[0].upper() + s[1:] + "." for s in features_ru],
        en_feature_sentences=[s[0].upper() + s[1:] + "." for s in features_en],
        feature_count=rng.integer(feature_count[0], feature_count[1]),
    )
    return Part(
        family=family,
        variant=variant,
        code=code,
        bbox=bbox,
        params=params,
        prompt_ru=prompt_ru,
        prompt_en=prompt_en,
    )
