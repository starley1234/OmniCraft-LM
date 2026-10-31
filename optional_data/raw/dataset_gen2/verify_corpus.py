"""Independent audit of a generated gen2 corpus.

``build_corpus.py`` runs the same checks while it generates; this script re-runs
them against the files that are actually on disk, so the receiving team can
verify the corpus without OpenSCAD and without the generator internals.

    python tools/dataset_gen2/verify_corpus.py --parts-dir optional_data/data/gen2
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

FORBIDDEN = ("import(", "surface(", "text(", "children(", "rands(", "echo(")
MAX_BYTES = 12000
BBOX_TOLERANCE = 0.15  # the receiver's allowance


def audit_corpus(parts_dir: Path, limit: int | None = None, stl: bool = False) -> dict:
    """Return the audit summary; ``problems`` is empty for a clean corpus.

    With ``stl=True`` every sample goes through the receiver-simulation STL
    gate as well (manifold -> binary STL -> trimesh), which is what catches
    degenerate slivers and multi-component meshes.
    """
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

    from tools.dataset_gen2.miniscad import evaluate_3d

    problems: list[str] = []
    family_counts: dict[str, int] = {}
    wire_rows = 0
    disconnected_graphs = 0
    graphs_with_isolated_nodes = 0
    stl_checked = 0
    stl_bad: list[str] = []
    max_bbox_error = 0.0
    for row in rows:
        name = str(row.get("file", ""))
        path = parts_dir / name
        family = str(row.get("family", ""))
        family_counts[family] = family_counts.get(family, 0) + 1
        if not path.is_file():
            problems.append(f"{name}: missing file")
            continue
        source = path.read_text(encoding="utf-8")
        if not source.startswith("$fn = 32;\n"):
            problems.append(f"{name}: first line is not '$fn = 32;'")
        if len(source.encode("utf-8")) > MAX_BYTES:
            problems.append(f"{name}: source larger than {MAX_BYTES} bytes")
        for token in FORBIDDEN:
            if token in source:
                problems.append(f"{name}: forbidden construct {token!r}")
        if path.parent.name != family:
            problems.append(f"{name}: family {family!r} does not match the directory")

        try:
            mesh = evaluate_3d(source)
        except Exception as exc:  # noqa: BLE001 - report whatever the evaluator says
            problems.append(f"{name}: evaluation failed: {exc}")
            continue
        parts = mesh.decompose()
        if len(parts) != 1:
            problems.append(f"{name}: {len(parts)} components instead of one")
        box = mesh.bounding_box()
        measured = (box[3] - box[0], box[4] - box[1], box[5] - box[2])
        target = row.get("expected_bbox_mm")
        if not isinstance(target, list) or len(target) != 3:
            problems.append(f"{name}: expected_bbox_mm is not a 3-vector")
            continue
        for axis, want, have in zip("XYZ", target, measured):
            if want <= 0:
                problems.append(f"{name}: axis {axis} target is not positive")
                continue
            error = abs(have - want) / want
            max_bbox_error = max(max_bbox_error, error)
            if error > BBOX_TOLERANCE:
                problems.append(
                    f"{name}: axis {axis} measured {have:.2f} mm vs target {want:.2f} mm "
                    f"({error:.1%} > {BBOX_TOLERANCE:.0%})"
                )
            if have < 5.0 or have > 250.0:
                problems.append(f"{name}: axis {axis} is {have:.2f} mm, outside 5-250 mm")

        if stl:
            from tools.dataset_gen2.stlcheck import check_source, is_bad

            stl_checked += 1
            try:
                if is_bad(check_source(source)):
                    stl_bad.append(name)
                    problems.append(f"{name}: STL round-trip is not watertight/single component")
            except Exception as exc:  # noqa: BLE001
                stl_bad.append(name)
                problems.append(f"{name}: STL round-trip failed: {exc}")

        graph = row.get("graph")
        if graph:
            wire_rows += 1
            nodes = [(float(n[0]), float(n[1]), float(n[2])) for n in graph.get("nodes", [])]
            edges = [(int(e[0]), int(e[1])) for e in graph.get("edges", [])]
            if not nodes or not edges:
                problems.append(f"{name}: wire row without nodes/edges")
                continue
            degree = [0] * len(nodes)
            adjacency: dict[int, set[int]] = {index: set() for index in range(len(nodes))}
            for start, end in edges:
                if not (0 <= start < len(nodes) and 0 <= end < len(nodes)):
                    problems.append(f"{name}: graph edge out of range")
                    continue
                if math.dist(nodes[start], nodes[end]) <= 1e-9:
                    problems.append(f"{name}: graph edge of zero length")
                degree[start] += 1
                degree[end] += 1
                adjacency[start].add(end)
                adjacency[end].add(start)
            if any(value == 0 for value in degree):
                graphs_with_isolated_nodes += 1
                problems.append(f"{name}: graph has isolated nodes")
            seen, stack = {0}, [0]
            while stack:
                current = stack.pop()
                for neighbour in adjacency[current]:
                    if neighbour not in seen:
                        seen.add(neighbour)
                        stack.append(neighbour)
            if len(seen) != len(nodes):
                disconnected_graphs += 1
                problems.append(f"{name}: graph is not connected")

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
                problems.append(f"{relative}: sha256 mismatch against SHA256SUMS.txt")
    else:
        checksums_ok = False
        problems.append("SHA256SUMS.txt is missing")

    return {
        "rows": len(rows),
        "families": len(family_counts),
        "wire_rows": wire_rows,
        "disconnected_graphs": disconnected_graphs,
        "graphs_with_isolated_nodes": graphs_with_isolated_nodes,
        "stl_checked": stl_checked,
        "stl_bad": stl_bad,
        "max_bbox_error": max_bbox_error,
        "bbox_tolerance": BBOX_TOLERANCE,
        "checksums_ok": checksums_ok,
        "problems": problems,
    }


def verify(parts_dir: Path, limit: int | None = None, quiet: bool = False, stl: bool = False) -> int:
    summary = audit_corpus(parts_dir, limit, stl)
    if "error" in summary:
        print(summary["error"])
        return 2
    problems = summary["problems"]
    if not quiet:
        print(f"rows            : {summary['rows']}")
        print(f"families        : {summary['families']}")
        print(f"wire rows       : {summary['wire_rows']}")
        print(
            f"max bbox error  : {summary['max_bbox_error']:.4%} "
            f"(allowance {summary['bbox_tolerance']:.0%})"
        )
        print(f"wire graphs     : {summary['wire_rows']} rows, "
              f"{summary['disconnected_graphs']} disconnected, "
              f"{summary['graphs_with_isolated_nodes']} with isolated nodes")
        if summary["stl_checked"]:
            print(f"STL round-trip  : {summary['stl_checked']} checked, "
                  f"{len(summary['stl_bad'])} bad (trimesh watertight/components)")
        print(f"sha256 list     : {'ok' if summary['checksums_ok'] else 'MISMATCH'}")
        if problems:
            print(f"problems        : {len(problems)}")
            for problem in problems[:20]:
                print(f"  - {problem}")
        else:
            print("problems        : none")
    return 1 if problems else 0


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description="Audit a generated gen2 corpus")
    parser.add_argument("--parts-dir", type=Path, default=Path("optional_data/data/gen2"))
    parser.add_argument("--limit", type=int, default=None, help="only check the first N rows")
    parser.add_argument("--stl", action="store_true", help="also run the receiver-simulation STL gate")
    parser.add_argument("--quiet", action="store_true")
    args = parser.parse_args(argv)
    return verify(args.parts_dir, args.limit, args.quiet, args.stl)


if __name__ == "__main__":
    sys.exit(main())
