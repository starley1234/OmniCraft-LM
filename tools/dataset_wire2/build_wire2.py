"""Build the wire2 corpus (request 5, block W2).

Every scene passes the local gate before it is written:

* ``tools.dataset_gen2.common.check_part`` - header, size, forbidden
  constructs, manifold evaluation, single component, bbox match, graph
  connectivity / isolated nodes / zero-length edges;
* the wire2 budget: 6..32 nodes (the 32-vertex WireCanvas cap), member radii
  1.5..5 mm, every edge longer than 2r + 2 mm;
* the place1 consistency law (>= 97 % required, we gate at 100 %): every
  number in the RU and EN prompts is present in the code, checked with
  ``tools/dataset_place1/check_consistency.py``;
* graph <-> code agreement: the ``nodes`` array is re-evaluated from the
  emitted source and every member call is matched against the manifest graph.

Usage
-----
    python tools/dataset_wire2/build_wire2.py --count 260
    python tools/dataset_wire2/build_wire2.py --count 4 --out /tmp/wire2_smoke
"""

from __future__ import annotations

import argparse
import math
import sys
import time
from pathlib import Path

if __package__ in (None, ""):
    sys.path.insert(0, str(Path(__file__).resolve().parents[2]))

from tools.dataset_gen2.common import Part, check_part
from tools.dataset_place1.check_consistency import check_row
from tools.dataset_v5.kit import MAX_GRAPH_NODES, build_family_corpus, write_delivery
from tools.dataset_wire2.families2w import FAMILY_BUILDERS
from tools.dataset_wire2.verify_wire2 import graph_matches_code

DEFAULT_OUT = Path("optional_data/data/wire2")
CORPUS_DIR = "optional_data/data/wire2"
MIN_AXIS_MM = 5.0
MAX_AXIS_MM = 250.0
MIN_NODES = 6
MIN_MEMBER_R = 1.5
MAX_MEMBER_R = 5.0


def audit(part: Part) -> list[str]:
    problems = list(check_part(part).errors)
    graph = part.graph or {}
    nodes = graph.get("nodes") or []
    edges = graph.get("edges") or []
    member_r = float(graph.get("member_radius_mm") or 0.0)
    if not (MIN_NODES <= len(nodes) <= MAX_GRAPH_NODES):
        problems.append(f"{len(nodes)} nodes, allowed {MIN_NODES}..{MAX_GRAPH_NODES}")
    if not (MIN_MEMBER_R <= member_r <= MAX_MEMBER_R):
        problems.append(f"member radius {member_r} mm outside {MIN_MEMBER_R}..{MAX_MEMBER_R}")
    if len(nodes) != len(set(map(tuple, nodes))):
        problems.append("duplicate node coordinates")
    for i, j in edges:
        length = math.dist(nodes[i], nodes[j])
        if length <= 2.0 * member_r + 2.0:
            problems.append(f"edge {i}-{j} length {length:.2f} mm <= 2r + 2 mm")
            break
    for axis, value in zip("XYZ", part.bbox):
        if value < MIN_AXIS_MM or value > MAX_AXIS_MM:
            problems.append(f"axis {axis} = {value:.2f} mm outside {MIN_AXIS_MM}..{MAX_AXIS_MM}")
    if len(part.code.encode("utf-8")) > 12000:
        problems.append("source exceeds 12 kB")
    # graph <-> code agreement (independent of how the scene was generated)
    mismatch = graph_matches_code(part.code, graph)
    problems.extend(mismatch)
    # place1 law: prompt numbers live in the code
    row = {
        "prompt_en": part.prompt_en,
        "prompt_ru": part.prompt_ru,
    }
    for language in ("en", "ru"):
        report = check_row(row, part.code, prompt_lang=language)
        if not report.numbers_ok:
            missing = [str(number) for number in report.missing][:4]
            problems.append(f"prompt[{language}] numbers not in code: {missing}")
    return problems


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--count", type=int, default=260, help="scenes per family")
    parser.add_argument("--out", type=Path, default=DEFAULT_OUT)
    parser.add_argument("--quiet", action="store_true")
    args = parser.parse_args(argv)

    started = time.time()
    rows, written, family_stats, rejects = build_family_corpus(
        args.out,
        FAMILY_BUILDERS,
        audit=audit,
        render_code=lambda part: part.code,
        render_prompts=lambda part: (part.prompt_ru, part.prompt_en),
        manifest_row=lambda part, rel: {
            **part.manifest_row(rel),
            "id": f"wire2_{Path(rel).parent.name}_{Path(rel).stem.split('_')[-1]}",
            "validation_status": "pending_openscad_manifold",
        },
        file_stem="scene",
        count_per_family=args.count,
        quiet=args.quiet,
    )
    manifest_sha = write_delivery(
        args.out,
        rows,
        written,
        corpus_dir=CORPUS_DIR if args.out == DEFAULT_OUT else str(args.out),
        verify_cmd="python tools/dataset_wire2/verify_wire2.py --parts-dir optional_data/data/wire2",
    )
    elapsed = time.time() - started
    node_counts = [len(row["graph"]["nodes"]) for row in rows]
    edge_counts = [len(row["graph"]["edges"]) for row in rows]
    print(
        f"\n{len(rows)} scenes, {elapsed:.1f} s; nodes {min(node_counts)}..{max(node_counts)}, "
        f"edges {min(edge_counts)}..{max(edge_counts)}, rejects {len(rejects)}"
    )
    print(f"manifest.jsonl sha256 = {manifest_sha}")
    if rejects:
        print(f"first rejects: {rejects[:5]}")
    return 0 if rows else 1


if __name__ == "__main__":
    sys.exit(main())
