"""Standalone audit of the asm2 corpus on disk (no OpenSCAD needed).

Repeated modules are legal in asm2 (bolt circles, corner posts, wheel pairs):
every module must be defined exactly once, and the manifest may instantiate it
several times.

This mirrors the checks the receiving team announced for the assembly block:

* every scene file re-read from disk, ``$fn = 32;`` first, under 12 kB;
* the ``assembly`` rows of the manifest replayed - module names, translations
  and w-last quaternions must match the ``translate``/``rotate`` calls in the
  code, and every rotation must be a multiple of 45 degrees about one axis;
* every placed part evaluated on its own (module + its own call): a single
  solid, and the placement quoted in the manifest rebuilds it;
* the scene re-evaluated with the manifold kernel: one connected component per
  part, world bounding box against ``expected_bbox_mm`` (15 % allowance), the
  pairwise clearance from ``min_gap`` >= 0.2 mm, and the sum of the part
  volumes against the scene volume (proves nothing overlaps and nothing is
  dropped);
* RU and EN prompt uniqueness, and the SHA-256 list.

    python tools/dataset_asm1/verify2.py --parts-dir optional_data/data/asm2
"""

from __future__ import annotations

import argparse
import hashlib
import json
import math
import sys
from pathlib import Path

if __package__ in (None, ""):
    sys.path.insert(0, str(Path(__file__).resolve().parents[2]))

import re

from tools.dataset_asm1.core2 import ASSEMBLY_MARKER, CLEARANCE_MM, GRID_ANGLES, MAX_BYTES, parse_assembly

BBOX_RECEIVER_TOLERANCE = 0.15
VOLUME_SUM_TOLERANCE = 0.005


def quat_matrix(q) -> tuple[tuple[float, float, float], ...]:
    x, y, z, w = q
    return (
        (1 - 2 * (y * y + z * z), 2 * (x * y - z * w), 2 * (x * z + y * w)),
        (2 * (x * y + z * w), 1 - 2 * (x * x + z * z), 2 * (y * z - x * w)),
        (2 * (x * z - y * w), 2 * (y * z + x * w), 1 - 2 * (x * x + y * y)),
    )


def _reference_matrix(axis: str, angle: float):
    radians = math.radians(angle)
    cosine, sine = round(math.cos(radians), 9), round(math.sin(radians), 9)
    if axis == "x":
        return ((1, 0, 0), (0, cosine, -sine), (0, sine, cosine))
    if axis == "y":
        return ((cosine, 0, sine), (0, 1, 0), (-sine, 0, cosine))
    return ((cosine, -sine, 0), (sine, cosine, 0), (0, 0, 1))


def nearest_grid_rotation(matrix) -> tuple[str, float, float]:
    """(axis, angle, worst matrix entry error) of the closest grid rotation."""
    best = ("z", 0.0, 1e9)
    for axis in ("x", "y", "z"):
        for angle in GRID_ANGLES:
            reference = _reference_matrix(axis, angle)
            error = max(abs(matrix[i][j] - reference[i][j]) for i in range(3) for j in range(3))
            if error < best[2]:
                best = (axis, angle, error)
    return best


def quat_for(axis: str, angle: float) -> tuple[float, float, float, float]:
    half = math.radians(angle) / 2.0
    sine = math.sin(half)
    if axis == "x":
        return (sine, 0.0, 0.0, math.cos(half))
    if axis == "y":
        return (0.0, sine, 0.0, math.cos(half))
    return (0.0, 0.0, sine, math.cos(half))


def _module_header(code: str) -> str:
    header: list[str] = []
    for line in code.splitlines():
        if line.strip() == ASSEMBLY_MARKER:
            break
        header.append(line)
    return "\n".join(header).rstrip()


def _num(value: float) -> str:
    text = f"{value:.3f}".rstrip("0").rstrip(".")
    return text if text not in ("", "-0") else "0"


def audit_corpus(parts_dir: Path, limit: int | None = None, stl: bool = False) -> dict:
    from tools.dataset_gen2.miniscad import evaluate_3d

    manifest_path = parts_dir / "manifest.jsonl"
    if not manifest_path.is_file():
        return {"error": f"missing {manifest_path}", "problems": ["missing manifest"]}
    rows = [
        json.loads(line)
        for line in manifest_path.read_text(encoding="utf-8").splitlines()
        if line.strip()
    ]
    if limit is not None:
        rows = rows[:limit]

    problems: list[str] = []
    family_counts: dict[str, int] = {}
    part_histogram: dict[int, int] = {}
    ru_seen: dict[str, str] = {}
    en_seen: dict[str, str] = {}
    duplicate_ru = duplicate_en = 0
    max_bbox_error = 0.0
    max_volume_sum_error = 0.0
    min_gap = None
    parts_total = 0
    transform_rows = 0
    transform_bad = 0
    stl_checked = 0
    stl_bad = 0

    for row in rows:
        name = str(row.get("file", ""))
        path = parts_dir / name
        family = str(row.get("family", ""))
        family_counts[family] = family_counts.get(family, 0) + 1
        if not path.is_file():
            problems.append(f"{name}: missing file")
            continue
        code = path.read_text(encoding="utf-8")
        if not code.startswith("$fn = 32;\n"):
            problems.append(f"{name}: first line is not '$fn = 32;'")
        if len(code.encode("utf-8")) > MAX_BYTES:
            problems.append(f"{name}: source larger than {MAX_BYTES} bytes")
        if path.parent.name != family:
            problems.append(f"{name}: family {family!r} does not match the directory")
        header = _module_header(code)

        assembly = row.get("assembly") or []
        parts_total += len(assembly)
        part_histogram[len(assembly)] = part_histogram.get(len(assembly), 0) + 1
        calls = parse_assembly(code)
        if len(calls) != len(assembly):
            problems.append(f"{name}: {len(calls)} calls in assembly() vs {len(assembly)} manifest rows")
        module_names = [
            match
            for match in re.findall(r"^module (\w+)\(\)", code, flags=re.MULTILINE)
            if match != "assembly"
        ]
        if len(set(module_names)) != len(module_names):
            problems.append(f"{name}: a module is defined more than once")
        instance_names = [str(entry["module"]) for entry in assembly]
        if set(module_names) != set(instance_names):
            problems.append(f"{name}: module definitions {sorted(set(module_names))} do not match "
                            f"the manifest instances {sorted(set(instance_names))}")
        if not 3 <= len(assembly) <= 12:
            problems.append(f"{name}: {len(assembly)} instances, expected 3-12")

        nodes = []
        for entry, call in zip(assembly, calls):
            if entry["module"] != call["module"]:
                problems.append(f"{name}: call order {call['module']} vs manifest {entry['module']}")
                continue
            if any(abs(float(a) - float(b)) > 1e-6 for a, b in zip(entry["t"], call["t"])):
                problems.append(f"{name}: {entry['module']} translation differs from the code")
            euler = [float(value) for value in call["euler"]]
            non_zero = [(axis, value) for axis, value in zip("xyz", euler) if abs(value) > 1e-9]
            if len(non_zero) > 1:
                problems.append(f"{name}: {entry['module']} rotates about more than one axis: {euler}")
                continue
            axis, angle = non_zero[0] if non_zero else ("z", 0.0)
            if abs(angle % 45.0) > 1e-6:
                problems.append(f"{name}: {entry['module']} angle {angle} is not a multiple of 45 degrees")
            transform_rows += 1
            expected_quat = quat_for(axis, angle)
            quaternion = [float(value) for value in entry["q"]]
            if any(abs(a - b) > 1e-6 for a, b in zip(expected_quat, quaternion)):
                transform_bad += 1
                problems.append(
                    f"{name}: {entry['module']} quaternion {quaternion} does not match rotate([{euler}])"
                )
            result = nearest_grid_rotation(quat_matrix(quaternion))
            if result[2] > 1e-6:
                problems.append(f"{name}: {entry['module']} quaternion is not a grid rotation")
            t = [float(value) for value in entry["t"]]
            call_code = (
                "translate([%s, %s, %s]) rotate([%s, %s, %s]) %s();"
                % (_num(t[0]), _num(t[1]), _num(t[2]), _num(euler[0]), _num(euler[1]), _num(euler[2]), entry["module"])
            )
            try:
                mesh = evaluate_3d(header + "\n\n" + call_code + "\n")
            except Exception as exc:  # noqa: BLE001
                problems.append(f"{name}: {entry['module']} failed on its own: {exc}")
                continue
            if len(mesh.decompose()) != 1:
                problems.append(f"{name}: {entry['module']} is not a single solid on its own")
            nodes.append((str(entry["module"]), mesh, call_code))
            if stl:
                from tools.dataset_gen2.stlcheck import check_source

                stl_checked += 1
                info = check_source(header + "\n\n" + call_code + "\n")
                if not info["watertight"] or info["degenerate"] or info["components"] != 1:
                    stl_bad += 1
                    problems.append(
                        f"{name}: {entry['module']} STL watertight {info['watertight']}, "
                        f"components {info['components']}, degenerate {info['degenerate']}"
                    )

        try:
            whole = evaluate_3d(code)
        except Exception as exc:  # noqa: BLE001
            problems.append(f"{name}: evaluation failed: {exc}")
            continue
        components = len(whole.decompose())
        if components != len(assembly):
            problems.append(f"{name}: {components} components for {len(assembly)} parts - parts touch")
        box = whole.bounding_box()
        measured = (box[3] - box[0], box[4] - box[1], box[5] - box[2])
        declared = [float(value) for value in row.get("expected_bbox_mm", [0, 0, 0])]
        for axis, want, have in zip("XYZ", declared, measured):
            if want <= 0:
                problems.append(f"{name}: axis {axis} target is not positive")
                continue
            error = abs(have - want) / want
            max_bbox_error = max(max_bbox_error, error)
            if error > BBOX_RECEIVER_TOLERANCE:
                problems.append(f"{name}: axis {axis} measured {have:.2f} vs declared {want:.2f} mm")

        if len(nodes) == len(assembly):
            gaps = []
            for index in range(len(nodes)):
                for other in range(index + 1, len(nodes)):
                    gap = float(nodes[index][1].min_gap(nodes[other][1], 5.0))
                    gaps.append(gap)
                    if gap < CLEARANCE_MM - 1e-4:
                        problems.append(
                            f"{name}: {nodes[index][0]}/{nodes[other][0]} clearance {gap:.4f} mm "
                            f"< {CLEARANCE_MM} mm"
                        )
            if gaps:
                worst = min(gaps)
                min_gap = worst if min_gap is None else min(min_gap, worst)
            part_volume = sum(float(mesh.volume()) for _, mesh, _ in nodes)
            whole_volume = float(whole.volume())
            if whole_volume > 0:
                error = abs(part_volume - whole_volume) / whole_volume
                max_volume_sum_error = max(max_volume_sum_error, error)
                if error > VOLUME_SUM_TOLERANCE:
                    problems.append(
                        f"{name}: sum of part volumes {part_volume:.1f} vs scene {whole_volume:.1f} mm3 "
                        f"({error:.2%}) - overlapping or dropped parts"
                    )

        ru = str(row.get("prompt_ru", ""))
        en = str(row.get("prompt_en", ""))
        if ru in ru_seen:
            duplicate_ru += 1
            problems.append(f"{name}: duplicate RU prompt (also {ru_seen[ru]})")
        else:
            ru_seen[ru] = name
        if en in en_seen:
            duplicate_en += 1
            problems.append(f"{name}: duplicate EN prompt (also {en_seen[en]})")
        else:
            en_seen[en] = name

    checksums_ok = True
    checksum_path = parts_dir / "SHA256SUMS.txt"
    if checksum_path.is_file():
        for line in checksum_path.read_text(encoding="utf-8").splitlines():
            if not line.strip():
                continue
            digest, _, relative = line.partition("  ")
            target = parts_dir / relative
            if not target.is_file() or hashlib.sha256(target.read_bytes()).hexdigest() != digest:
                checksums_ok = False
                problems.append(f"{relative}: sha256 mismatch")
    else:
        checksums_ok = False
        problems.append("SHA256SUMS.txt is missing")

    return {
        "rows": len(rows),
        "families": len(family_counts),
        "wire_rows": 0,
        "parts_total": parts_total,
        "part_histogram": {str(key): value for key, value in sorted(part_histogram.items())},
        "min_gap": min_gap or 0.0,
        "max_bbox_error": max_bbox_error,
        "bbox_tolerance": BBOX_RECEIVER_TOLERANCE,
        "max_volume_sum_error": max_volume_sum_error,
        "transform_rows": transform_rows,
        "transform_bad": transform_bad,
        "duplicate_ru": duplicate_ru,
        "duplicate_en": duplicate_en,
        "checksums_ok": checksums_ok,
        "stl_checked": stl_checked,
        "stl_bad": stl_bad,
        "problems": problems,
    }


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--parts-dir", type=Path, default=Path("optional_data/data/asm2"))
    parser.add_argument("--limit", type=int, default=None)
    parser.add_argument("--stl", action="store_true", help="also STL round-trip every placed part")
    args = parser.parse_args(argv)

    summary = audit_corpus(args.parts_dir, limit=args.limit, stl=args.stl)
    if "error" in summary:
        print(summary["error"])
        return 2
    print(f"rows            : {summary['rows']}")
    print(f"families        : {summary['families']}")
    print(f"placed parts    : {summary['parts_total']} ({summary['part_histogram']} scenes by part count)")
    print(f"smallest gap    : {summary['min_gap']:.4f} mm (request asks for >= {CLEARANCE_MM} mm)")
    print(f"max bbox error  : {summary['max_bbox_error']:.4%} (allowance {summary['bbox_tolerance']:.0%})")
    print(f"volume sum      : worst |parts - scene| {summary['max_volume_sum_error']:.4%}")
    print(f"transforms      : {summary['transform_rows']} replayed, {summary['transform_bad']} mismatching")
    print(f"prompt dupes    : RU {summary['duplicate_ru']}, EN {summary['duplicate_en']}")
    print(f"sha256 list     : {'ok' if summary['checksums_ok'] else 'MISMATCH'}")
    if args.stl:
        print(f"STL round trip  : {summary['stl_checked']} parts, {summary['stl_bad']} bad")
    print(f"problems        : {'none' if not summary['problems'] else len(summary['problems'])}")
    for line in summary["problems"][:10]:
        print(f"   - {line}")
    return 0 if not summary["problems"] else 1


if __name__ == "__main__":
    raise SystemExit(main())
