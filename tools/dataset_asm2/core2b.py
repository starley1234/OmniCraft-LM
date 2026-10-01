"""Scene audit for the asm2 corpus - asm1's core2 forked for repeated modules.

asm2 scenes may call one module several times (a bolt circle, four corner
posts, two wheels), so the strict 1:1 module/instance match of asm1's
``check_scene`` is replaced by:

* every module is defined exactly once, argument-less;
* the set of defined modules equals the set of instance names in the manifest;
* the ordered ``translate/rotate`` calls inside ``assembly()`` match the
  manifest placements one by one (repeats included).

Everything else - grid angles, per-part solids, declared world bounds, the
0.2 mm pairwise clearance and the STL checks - is enforced exactly like asm1.

Scenes also carry ``color([...])`` on every instance call: each placed part
gets its own colour, which the evaluator ignores geometrically.
"""

from __future__ import annotations

import re
from dataclasses import dataclass

from tools.dataset_asm1.core2 import (
    ASSEMBLY_MARKER,
    CLEARANCE_MM,
    GRID_ANGLES,
    MAX_BYTES,
    FORBIDDEN,
    Node,
    Scene,
    SceneCheck,
    box_size,
    euler_for,
    node_code,
    parse_assembly,
    quat_for,
    scene_summary,
    transform_bounds,
    union_bounds,
)

__all__ = [
    "ASSEMBLY_MARKER",
    "CLEARANCE_MM",
    "GRID_ANGLES",
    "Node",
    "PALETTE",
    "Scene",
    "SceneCheck",
    "box_size",
    "check_scene2",
    "euler_for",
    "node_code",
    "parse_assembly",
    "quat_for",
    "render_scene2",
    "scene_summary",
    "transform_bounds",
    "union_bounds",
]

PALETTE = (
    (0.80, 0.24, 0.20),
    (0.20, 0.45, 0.75),
    (0.25, 0.62, 0.32),
    (0.92, 0.70, 0.18),
    (0.58, 0.35, 0.70),
    (0.16, 0.66, 0.66),
    (0.85, 0.48, 0.18),
    (0.55, 0.60, 0.65),
    (0.75, 0.30, 0.55),
    (0.42, 0.52, 0.28),
)


def render_scene2(title: str, summary: str, modules: list[str], calls: list[str]) -> str:
    """Like asm1's render_scene, but every call gets its own color()."""
    body = ["$fn = 32;", ""]
    body.append("// " + "-" * 72)
    body.append(f"// {title}" + (f": {summary}" if summary else ""))
    body.append("// Every part is its own module, assembly() places every instance.")
    body.append("// " + "-" * 72)
    seen: list[str] = []
    for source in modules:
        name = re.match(r"module (\w+)\(\)", source).group(1)
        if name in seen:
            continue
        seen.append(name)
        body.append("")
        body.append(f"// --- part {len(seen)} ---")
        body.append(source.strip("\n"))
    body.append("")
    body.append(ASSEMBLY_MARKER)
    body.append("module assembly() {")
    for index, call in enumerate(calls):
        r, g, b = PALETTE[index % len(PALETTE)]
        body.append(f"  color([{r:.2f}, {g:.2f}, {b:.2f}]) {call}")
    body.append("}")
    body.append("")
    body.append("assembly();")
    return "\n".join(body).rstrip() + "\n"


def check_scene2(scene: Scene, max_relative_error: float = 0.03, stl: bool = True) -> SceneCheck:
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

    module_names = [
        name
        for name in re.findall(r"^module (\w+)\(\)", scene.code, flags=re.MULTILINE)
        if name != "assembly"
    ]
    expected_names = [node.name for node in scene.nodes]
    if "assembly" in expected_names:
        errors.append("a part may not be called assembly")
    if len(set(module_names)) != len(module_names):
        errors.append("a module is defined more than once")
    if set(module_names) != set(expected_names):
        errors.append(f"modules {sorted(set(module_names))} do not match the manifest {sorted(set(expected_names))}")

    calls = parse_assembly(scene.code)
    if len(calls) != len(scene.nodes):
        errors.append(f"{len(calls)} calls in assembly() vs {len(scene.nodes)} instances")
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
        errors.append(f"{len(parts)} components for {len(scene.nodes)} instances - parts touch each other")

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

    # per instance: one solid, matching the declared transform, declared volume
    meshes = []
    for index, node in enumerate(scene.nodes):
        try:
            mesh = evaluate_3d(node_code(scene, node))
        except Exception as exc:  # noqa: BLE001
            errors.append(f"{node.name}[{index}]: per-part evaluation failed: {exc}")
            continue
        if len(mesh.decompose()) != 1:
            errors.append(f"{node.name}[{index}]: the module is not a single solid")
        if node.volume > 0.0:
            measured_volume = float(mesh.volume())
            error = abs(measured_volume - node.volume) / node.volume
            if error > 0.02:
                errors.append(
                    f"{node.name}[{index}]: mesh volume {measured_volume:.1f} mm3 vs designed "
                    f"{node.volume:.1f} mm3 ({error:.2%}) - a cutter missed or cut too much"
                )
        node_box = mesh.bounding_box()
        expected = node.world_bounds
        for axis_index in range(3):
            if abs(node_box[axis_index] - expected[axis_index]) > 0.05 or abs(
                node_box[axis_index + 3] - expected[axis_index + 3]
            ) > 0.05:
                errors.append(
                    f"{node.name}[{index}]: placed bounds {[round(v, 2) for v in node_box]} vs "
                    f"expected {[round(v, 2) for v in expected]}"
                )
                break
        meshes.append((node, mesh))

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
        for index, node in enumerate(scene.nodes):
            try:
                info = check_source(node_code(scene, node))
            except Exception as exc:  # noqa: BLE001
                errors.append(f"{node.name}[{index}]: per-part STL crashed: {exc}")
                continue
            if is_bad(info):
                errors.append(
                    f"{node.name}[{index}]: STL watertight {info['watertight']}, components "
                    f"{info['components']}, degenerate {info['degenerate']}"
                )

    result.errors = errors
    result.ok = not errors
    return result
