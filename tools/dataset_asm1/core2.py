"""Scene model for the asm1 corpus: modules, SE(3) nodes, render and audit.

Discipline from the request:

* one .scad file per scene, every part is a module, every node is called from
  ``assembly()`` with an explicit ``translate`` and ``rotate``;
* rotations are grid aligned - multiples of 45 degrees about one axis;
* no part touches another one, the clearance between any pair is at least
  0.2 mm (checked with ``manifold.min_gap``);
* the manifest carries the placements as ``t`` (mm) plus a w-last quaternion
  ``q`` = [x, y, z, w].

Local part bounds are kept next to the module source so the audit can rebuild
the expected world bounding box of every node and compare it with the mesh.
"""

from __future__ import annotations

import json
import math
import re
from dataclasses import dataclass, field
from typing import Any, Sequence

MAX_BYTES = 12000
ASSEMBLY_MARKER = "// --- assembly ---"
CLEARANCE_MM = 0.2
GRID_ANGLES = (0.0, 45.0, 90.0, 135.0, 180.0, 225.0, 270.0, 315.0)

FORBIDDEN = ("import(", "surface(", "text(", "children(", "rands(", "echo(")


# ---------------------------------------------------------------------------
# transforms
# ---------------------------------------------------------------------------


def euler_for(axis: str, angle: float) -> tuple[float, float, float]:
    if axis == "x":
        return (angle, 0.0, 0.0)
    if axis == "y":
        return (0.0, angle, 0.0)
    return (0.0, 0.0, angle)


def quat_for(axis: str, angle: float) -> tuple[float, float, float, float]:
    """w-last quaternion of a single axis rotation."""
    half = math.radians(angle) / 2.0
    sine = math.sin(half)
    if axis == "x":
        q = (sine, 0.0, 0.0, math.cos(half))
    elif axis == "y":
        q = (0.0, sine, 0.0, math.cos(half))
    else:
        q = (0.0, 0.0, sine, math.cos(half))
    return tuple(0.0 if abs(value) < 1e-12 else round(value, 9) for value in q)


def rotation_matrix(axis: str, angle: float):
    radians = math.radians(angle)
    cosine, sine = math.cos(radians), math.sin(radians)
    if axis == "x":
        return ((1, 0, 0), (0, cosine, -sine), (0, sine, cosine))
    if axis == "y":
        return ((cosine, 0, sine), (0, 1, 0), (-sine, 0, cosine))
    return ((cosine, -sine, 0), (sine, cosine, 0), (0, 0, 1))


def transform_bounds(bounds, axis: str, angle: float, t: Sequence[float]):
    x0, y0, z0, x1, y1, z1 = bounds
    matrix = rotation_matrix(axis, angle)
    xs, ys, zs = [], [], []
    for x in (x0, x1):
        for y in (y0, y1):
            for z in (z0, z1):
                rx = matrix[0][0] * x + matrix[0][1] * y + matrix[0][2] * z
                ry = matrix[1][0] * x + matrix[1][1] * y + matrix[1][2] * z
                rz = matrix[2][0] * x + matrix[2][1] * y + matrix[2][2] * z
                xs.append(rx + t[0])
                ys.append(ry + t[1])
                zs.append(rz + t[2])
    return (min(xs), min(ys), min(zs), max(xs), max(ys), max(zs))


def union_bounds(boxes):
    xs0 = min(box[0] for box in boxes)
    ys0 = min(box[1] for box in boxes)
    zs0 = min(box[2] for box in boxes)
    xs1 = max(box[3] for box in boxes)
    ys1 = max(box[4] for box in boxes)
    zs1 = max(box[5] for box in boxes)
    return (xs0, ys0, zs0, xs1, ys1, zs1)


def box_size(box) -> tuple[float, float, float]:
    return (round(box[3] - box[0], 3), round(box[4] - box[1], 3), round(box[5] - box[2], 3))


# ---------------------------------------------------------------------------
# scene
# ---------------------------------------------------------------------------


@dataclass
class Node:
    """One placed part: module source, local bounds, placement."""

    name: str
    source: str
    bounds: tuple[float, float, float, float, float, float]
    axis: str
    angle: float
    t: tuple[float, float, float]
    params: dict[str, float] = field(default_factory=dict)
    volume: float = 0.0

    @property
    def call(self) -> str:
        euler = euler_for(self.axis, self.angle)
        return (
            "translate([%s, %s, %s]) rotate([%s, %s, %s]) %s();"
            % (
                _num(self.t[0]),
                _num(self.t[1]),
                _num(self.t[2]),
                _num(euler[0]),
                _num(euler[1]),
                _num(euler[2]),
                self.name,
            )
        )

    @property
    def quat(self) -> tuple[float, float, float, float]:
        return quat_for(self.axis, self.angle)

    @property
    def world_bounds(self):
        return transform_bounds(self.bounds, self.axis, self.angle, self.t)


def _num(value: float) -> str:
    text = f"{value:.3f}".rstrip("0").rstrip(".")
    return text if text not in ("", "-0") else "0"


@dataclass
class Scene:
    family: str
    variant: str
    code: str
    bbox: tuple[float, float, float]
    params: dict[str, float]
    prompt_ru: str
    prompt_en: str
    nodes: list[Node]

    def manifest_row(self, file_name: str) -> dict[str, Any]:
        return {
            "file": file_name,
            "family": self.family,
            "prompt_ru": self.prompt_ru,
            "prompt_en": self.prompt_en,
            "expected_bbox_mm": [round(value, 3) for value in self.bbox],
            "parameters": {key: round(value, 3) for key, value in self.params.items()},
            "graph": None,
            "assembly": [
                {"module": node.name, "t": [round(value, 3) for value in node.t], "q": [round(value, 6) for value in node.quat]}
                for node in self.nodes
            ],
        }


# ---------------------------------------------------------------------------
# audit
# ---------------------------------------------------------------------------


@dataclass
class SceneCheck:
    ok: bool
    errors: list[str] = field(default_factory=list)
    component_count: int = 0
    min_gap_mm: float = 0.0
    measured_bbox: tuple[float, float, float] | None = None
    relative_error: tuple[float, float, float] = (0.0, 0.0, 0.0)


def node_code(scene: Scene, node: Node) -> str:
    """The whole file with a single node kept - used to STL each part alone."""
    header: list[str] = []
    for line in scene.code.splitlines():
        if line.strip() == ASSEMBLY_MARKER:
            break
        header.append(line)
    return "\n".join(header).rstrip() + "\n\n" + node.call + "\n"


def parse_assembly(code: str) -> list[dict]:
    calls = []
    for match in re.finditer(
        r"translate\(\[([^\]]+)\]\)\s*rotate\(\[([^\]]+)\]\)\s*(\w+)\(\);", code
    ):
        t = [float(value) for value in match.group(1).split(",")]
        euler = [float(value) for value in match.group(2).split(",")]
        calls.append({"t": t, "euler": euler, "module": match.group(3)})
    return calls


def check_scene(scene: Scene, max_relative_error: float = 0.03, stl: bool = True) -> SceneCheck:
    from tools.dataset_gen2.miniscad import evaluate_3d

    errors: list[str] = []
    lines = scene.code.splitlines()
    if not lines or lines[0] != "$fn = 32;":
        errors.append("first line is not '$fn = 32;'")
    if len(scene.code.encode("utf-8")) > MAX_BYTES:
        errors.append(f"source is larger than {MAX_BYTES} bytes")
    for token in FORBIDDEN:
        if token in scene.code:
            errors.append(f"forbidden construct {token!r}")
    if scene.code.count("assembly();") != 1:
        errors.append("the scene must call assembly() exactly once")
    module_names = [name for name in re.findall(r"^module (\w+)\(\)", scene.code, flags=re.MULTILINE) if name != "assembly"]
    expected_names = [node.name for node in scene.nodes]
    if "assembly" in expected_names:
        errors.append("a part may not be called assembly")
    if sorted(module_names) != sorted(expected_names):
        errors.append(f"modules {module_names} do not match the manifest {expected_names}")
    calls = parse_assembly(scene.code)
    if len(calls) != len(scene.nodes):
        errors.append(f"{len(calls)} calls in assembly() vs {len(scene.nodes)} parts")
    else:
        for call, node in zip(calls, scene.nodes):
            if call["module"] != node.name:
                errors.append(f"call order mismatch: {call['module']} vs {node.name}")
            if any(abs(a - b) > 1e-9 for a, b in zip(call["t"], node.t)):
                errors.append(f"{node.name}: translation in the code differs from the manifest")
            euler = euler_for(node.axis, node.angle)
            if any(abs(a - b) > 1e-9 for a, b in zip(call["euler"], euler)):
                errors.append(f"{node.name}: rotation in the code differs from the manifest")
    for node in scene.nodes:
        if node.axis not in ("x", "y", "z"):
            errors.append(f"{node.name}: rotation axis {node.axis!r} is not grid aligned")
        if min(abs(node.angle - value) for value in GRID_ANGLES) > 1e-6:
            errors.append(f"{node.name}: angle {node.angle} is not a multiple of 45 degrees")

    result = SceneCheck(ok=False)
    if errors:
        result.errors = errors
        return result

    from tools.dataset_gen2.stlcheck import is_bad

    try:
        whole = evaluate_3d(scene.code)
    except Exception as exc:  # noqa: BLE001
        result.errors = [f"evaluation failed: {exc}"]
        return result
    parts = whole.decompose()
    result.component_count = len(parts)
    if len(parts) != len(scene.nodes):
        errors.append(f"{len(parts)} components for {len(scene.nodes)} parts - parts touch each other")

    box = whole.bounding_box()
    measured = (box[3] - box[0], box[4] - box[1], box[5] - box[2])
    result.measured_bbox = measured
    result.relative_error = tuple(
        abs(have - want) / want if want else 0.0 for want, have in zip(scene.bbox, measured)
    )
    for axis, want, have in zip("XYZ", scene.bbox, measured):
        if want <= 0:
            errors.append(f"axis {axis} target is not positive")
            continue
        if abs(have - want) / want > max_relative_error:
            errors.append(f"axis {axis}: measured {have:.3f} vs declared {want:.3f} mm")
        if have < 5.0 or have > 250.0:
            errors.append(f"axis {axis} is {have:.2f} mm, outside 5-250 mm")

    # per part: one solid, matching the declared transform, watertight STL
    meshes = []
    for node in scene.nodes:
        try:
            mesh = evaluate_3d(node_code(scene, node))
        except Exception as exc:  # noqa: BLE001
            errors.append(f"{node.name}: per-part evaluation failed: {exc}")
            continue
        if len(mesh.decompose()) != 1:
            errors.append(f"{node.name}: the module is not a single solid")
        if node.volume > 0.0:
            measured_volume = float(mesh.volume())
            error = abs(measured_volume - node.volume) / node.volume
            if error > 0.02:
                errors.append(
                    f"{node.name}: mesh volume {measured_volume:.1f} mm3 vs designed "
                    f"{node.volume:.1f} mm3 ({error:.2%}) - a cutter missed or cut too much"
                )
        node_box = mesh.bounding_box()
        expected = node.world_bounds
        for index in range(3):
            if abs(node_box[index] - expected[index]) > 0.05 or abs(node_box[index + 3] - expected[index + 3]) > 0.05:
                errors.append(
                    f"{node.name}: placed bounds {[round(v, 2) for v in node_box]} vs expected "
                    f"{[round(v, 2) for v in expected]}"
                )
                break
        meshes.append((node, mesh))

    # pairwise clearance
    minimum = None
    for index in range(len(meshes)):
        for other in range(index + 1, len(meshes)):
            gap = float(meshes[index][1].min_gap(meshes[other][1], 5.0))
            minimum = gap if minimum is None else min(minimum, gap)
            if gap < CLEARANCE_MM - 1e-4:
                errors.append(
                    f"{meshes[index][0].name} / {meshes[other][0].name}: clearance {gap:.4f} mm "
                    f"< {CLEARANCE_MM} mm"
                )
    result.min_gap_mm = minimum if minimum is not None else 0.0

    if stl:
        from tools.dataset_gen2.stlcheck import check_source

        try:
            info = check_source(scene.code)
            if not info["watertight"] or info["components"] != len(scene.nodes) or info["degenerate"]:
                errors.append(
                    f"scene STL: watertight {info['watertight']}, components {info['components']} "
                    f"(expected {len(scene.nodes)}), degenerate {info['degenerate']}"
                )
        except Exception as exc:  # noqa: BLE001
            errors.append(f"scene STL crashed: {exc}")
        for node in scene.nodes:
            try:
                info = check_source(node_code(scene, node))
            except Exception as exc:  # noqa: BLE001
                errors.append(f"{node.name}: per-part STL crashed: {exc}")
                continue
            if is_bad(info):
                errors.append(
                    f"{node.name}: STL watertight {info['watertight']}, components "
                    f"{info['components']}, degenerate {info['degenerate']}"
                )

    result.errors = errors
    result.ok = not errors
    return result


def scene_summary(scene: Scene) -> str:
    kinds = ", ".join(f"{node.name}@{node.axis}{int(node.angle)}" for node in scene.nodes)
    return f"{len(scene.nodes)} parts ({kinds})"


__all__ = [
    "ASSEMBLY_MARKER",
    "CLEARANCE_MM",
    "GRID_ANGLES",
    "Node",
    "Scene",
    "SceneCheck",
    "box_size",
    "check_scene",
    "euler_for",
    "node_code",
    "parse_assembly",
    "quat_for",
    "render_scene",
    "scene_summary",
    "transform_bounds",
    "union_bounds",
]
