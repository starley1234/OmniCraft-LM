"""Independent re-audit of the wire2 corpus straight from the files on disk.

This verifier trusts nothing that the generator claimed.  For every row of
``manifest.jsonl`` it:

1. checks the SHA256SUMS list;
2. re-reads the .scad source: ``$fn = 32;`` header, size limit, forbidden
   constructs;
3. re-evaluates the source with the manifold kernel: single watertight solid,
   bounding box vs the manifest (<= 3 %), positive volume;
4. re-audits the graph: 6..32 nodes, connected from node 0, no isolated
   nodes, every edge longer than 2r + 2 mm, member radius 1.5..5 mm;
5. replays the code: the ``nodes`` array is evaluated from the source itself
   and compared with the manifest graph, and the set of ``member``/``run``
   calls must equal the set of graph edges (no phantom or missing members);
6. re-runs the place1 consistency law on both prompts (every number lives in
   the code).

Exit code 0 only when every row passes everything.

    python tools/dataset_wire2/verify_wire2.py --parts-dir optional_data/data/wire2
"""

from __future__ import annotations

import argparse
import hashlib
import json
import math
import re
import sys
from pathlib import Path
from typing import Any

if __package__ in (None, ""):
    sys.path.insert(0, str(Path(__file__).resolve().parents[2]))

FORBIDDEN = ("import(", "surface(", "text(", "children(", "rands(", "echo(", "minkowski(")
MEMBER_CALL_RE = re.compile(r"\b(?:member|run)\(\s*nodes\[(\d+)\],\s*nodes\[(\d+)\],\s*(\w+)\s*\);")


def nodes_from_code(code: str) -> list[Any]:
    """Evaluate the top-level assignments of the source and return ``nodes``."""
    from tools.dataset_gen2.miniscad import Evaluator, Parser, tokenize

    evaluator = Evaluator(code)
    program = Parser(tokenize(code)).parse_program()
    for statement in program:
        kind = statement[0]
        if kind == "assign":
            _, name, expression = statement
            evaluator.global_scope.variables[name] = evaluator.eval_expression(
                expression, evaluator.global_scope
            )
        elif kind in ("module", "function"):
            evaluator.define(statement)
    nodes = evaluator.global_scope.variables.get("nodes")
    if nodes is None:
        raise ValueError("the source does not define a nodes array")
    return nodes


def graph_matches_code(code: str, graph: dict[str, Any]) -> list[str]:
    """Manifest graph vs the code: node coordinates and the edge set."""
    problems: list[str] = []
    manifest_nodes = graph.get("nodes") or []
    manifest_edges = {frozenset((int(a), int(b))) for a, b in graph.get("edges") or []}
    try:
        code_nodes = nodes_from_code(code)
    except Exception as exc:  # noqa: BLE001
        return [f"cannot evaluate the nodes array from the code: {exc}"]
    if len(code_nodes) != len(manifest_nodes):
        problems.append(f"code has {len(code_nodes)} nodes, manifest {len(manifest_nodes)}")
        return problems
    for index, (code_node, manifest_node) in enumerate(zip(code_nodes, manifest_nodes)):
        if any(abs(float(a) - float(b)) > 5e-4 for a, b in zip(code_node, manifest_node)):
            problems.append(
                f"node {index}: code {[round(float(v), 4) for v in code_node]} vs "
                f"manifest {manifest_node}"
            )
    code_edges = {
        frozenset((int(a), int(b))) for a, b, _ in MEMBER_CALL_RE.findall(code)
    }
    if code_edges != manifest_edges:
        missing = manifest_edges - code_edges
        phantom = code_edges - manifest_edges
        problems.append(
            f"edge set mismatch: {len(missing)} manifest edges without a member call, "
            f"{len(phantom)} member calls without a graph edge"
        )
    return problems


def audit_row(row: dict[str, Any], code: str) -> list[str]:
    from tools.dataset_gen2.miniscad import MiniScadError, evaluate_3d
    from tools.dataset_place1.check_consistency import check_row

    problems: list[str] = []
    lines = code.splitlines()
    if not lines or lines[0] != "$fn = 32;":
        problems.append("missing '$fn = 32;' header")
    for token in FORBIDDEN:
        if token in code:
            problems.append(f"forbidden construct {token}")
    if len(code.encode("utf-8")) > 12000:
        problems.append("source larger than 12 kB")
    graph = row.get("graph") or {}
    nodes = graph.get("nodes") or []
    edges = graph.get("edges") or []
    member_r = float(graph.get("member_radius_mm") or 0.0)
    if not (6 <= len(nodes) <= 32):
        problems.append(f"{len(nodes)} nodes, allowed 6..32")
    if not (1.5 <= member_r <= 5.0):
        problems.append(f"member_radius_mm {member_r} outside 1.5..5")
    degree = [0] * len(nodes)
    adjacency: dict[int, set[int]] = {index: set() for index in range(len(nodes))}
    for edge in edges:
        start, end = int(edge[0]), int(edge[1])
        if not (0 <= start < len(nodes) and 0 <= end < len(nodes)):
            problems.append("edge references a missing node")
            continue
        degree[start] += 1
        degree[end] += 1
        adjacency[start].add(end)
        adjacency[end].add(start)
        if math.dist(nodes[start], nodes[end]) <= 2.0 * member_r + 2.0:
            problems.append(f"edge {start}-{end} is not longer than 2r + 2 mm")
    if any(value == 0 for value in degree):
        problems.append("graph has isolated nodes")
    if nodes:
        seen = {0}
        stack = [0]
        while stack:
            current = stack.pop()
            for neighbour in adjacency[current]:
                if neighbour not in seen:
                    seen.add(neighbour)
                    stack.append(neighbour)
        if len(seen) != len(nodes):
            problems.append("graph is not connected from node 0")
    problems.extend(graph_matches_code(code, graph))
    try:
        manifold = evaluate_3d(code)
    except MiniScadError as exc:
        problems.append(f"evaluation failed: {exc}")
        return problems
    components = manifold.decompose()
    if len(components) != 1:
        problems.append(f"{len(components)} components, expected 1")
    if manifold.volume() <= 0:
        problems.append("non-positive volume")
    box = manifold.bounding_box()
    measured = (box[3] - box[0], box[4] - box[1], box[5] - box[2])
    declared = row.get("expected_bbox_mm") or [0, 0, 0]
    for axis, have, want in zip("XYZ", measured, declared):
        if want <= 0 or abs(have - want) / want > 0.03:
            problems.append(f"axis {axis}: measured {have:.3f} vs declared {want}")
        if have < 5.0 or have > 250.0:
            problems.append(f"axis {axis} = {have:.2f} mm outside 5..250")
    report_en = check_row(row, code, prompt_lang="en")
    report_ru = check_row(row, code, prompt_lang="ru")
    if not report_en.numbers_ok:
        problems.append(f"prompt[en] numbers missing in code: {report_en.missing[:4]}")
    if not report_ru.numbers_ok:
        problems.append(f"prompt[ru] numbers missing in code: {report_ru.missing[:4]}")
    return problems


def audit_corpus(parts_dir: Path, limit: int | None = None) -> dict[str, Any]:
    manifest = [
        json.loads(line)
        for line in (parts_dir / "manifest.jsonl").read_text(encoding="utf-8").splitlines()
        if line.strip()
    ]
    if limit:
        manifest = manifest[:limit]
    bad_rows: list[dict[str, Any]] = []
    hashes: dict[str, str] = {}
    sums_path = parts_dir / "SHA256SUMS.txt"
    hash_bad = 0
    if sums_path.is_file():
        for line in sums_path.read_text(encoding="utf-8").splitlines():
            digest, _, relative = line.partition("  ")
            hashes[relative.strip()] = digest.strip()
    node_counts: list[int] = []
    edge_counts: list[int] = []
    for row in manifest:
        path = parts_dir / str(row["file"])
        code = path.read_text(encoding="utf-8")
        expected = hashes.get(str(row["file"]))
        if expected is not None:
            actual = hashlib.sha256(path.read_bytes()).hexdigest()
            if actual != expected and actual != hashlib.sha256(
                path.read_bytes().replace(b"\r\n", b"\n")
            ).hexdigest():
                hash_bad += 1
                bad_rows.append({"file": str(row["file"]), "problems": ["sha256 mismatch"]})
                continue
        problems = audit_row(row, code)
        if problems:
            bad_rows.append({"file": str(row["file"]), "problems": problems[:6]})
        node_counts.append(len(row.get("graph", {}).get("nodes") or []))
        edge_counts.append(len(row.get("graph", {}).get("edges") or []))
    families = sorted({str(row.get("family", "?")) for row in manifest})
    duplicate_ru = len(manifest) - len({row["prompt_ru"] for row in manifest})
    duplicate_en = len(manifest) - len({row["prompt_en"] for row in manifest})
    return {
        "rows": len(manifest),
        "families": families,
        "hash_bad": hash_bad,
        "bad_rows": bad_rows,
        "nodes_min": min(node_counts) if node_counts else 0,
        "nodes_max": max(node_counts) if node_counts else 0,
        "edges_min": min(edge_counts) if edge_counts else 0,
        "edges_max": max(edge_counts) if edge_counts else 0,
        "duplicate_ru": duplicate_ru,
        "duplicate_en": duplicate_en,
    }


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--parts-dir", type=Path, default=Path("optional_data/data/wire2"))
    parser.add_argument("--limit", type=int, default=None)
    parser.add_argument("--json", action="store_true")
    args = parser.parse_args(argv)
    report = audit_corpus(args.parts_dir, args.limit)
    if args.json:
        print(json.dumps(report, ensure_ascii=False, indent=2))
    else:
        print(
            f"{report['rows']} rows | families: {', '.join(report['families'])} | "
            f"nodes {report['nodes_min']}..{report['nodes_max']} | "
            f"edges {report['edges_min']}..{report['edges_max']} | "
            f"sha256 bad {report['hash_bad']} | duplicate ru/en {report['duplicate_ru']}/{report['duplicate_en']}"
        )
        for entry in report["bad_rows"][:10]:
            print(f"  BAD {entry['file']}: {entry['problems']}")
    print(f"problems: {len(report['bad_rows'])} rows failed")
    return 1 if report["bad_rows"] or report["hash_bad"] else 0


if __name__ == "__main__":
    sys.exit(main())
