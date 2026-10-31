"""Build the wire3 corpus - second wave of the wire canvas.

Reuses wire2's gate (``build_wire2.audit`` = check_part + graph budget +
graph<->code agreement + the place1 law on both prompts) and wire2's disk
verifier (``verify_wire2.py --parts-dir optional_data/data/wire3``).

Usage
-----
    python tools/dataset_wire3/build_wire3.py --count 250
    python tools/dataset_wire3/build_wire3.py --count 4 --out /tmp/wire3_smoke
"""

from __future__ import annotations

import argparse
import sys
import time
from pathlib import Path

if __package__ in (None, ""):
    sys.path.insert(0, str(Path(__file__).resolve().parents[2]))

from tools.dataset_v5.kit import build_family_corpus, write_delivery
from tools.dataset_wire2.build_wire2 import audit
from tools.dataset_wire3.families3w import FAMILY_BUILDERS

DEFAULT_OUT = Path("optional_data/data/wire3")
CORPUS_DIR = "optional_data/data/wire3"


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--count", type=int, default=250, help="scenes per family")
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
            "id": f"wire3_{Path(rel).parent.name}_{Path(rel).stem.split('_')[-1]}",
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
        verify_cmd="python tools/dataset_wire2/verify_wire2.py --parts-dir optional_data/data/wire3",
    )
    elapsed = time.time() - started
    node_counts = [len(row["graph"]["nodes"]) for row in rows]
    edge_counts = [len(row["graph"]["edges"]) for row in rows]
    print(
        f"\n{len(rows)} scenes, {elapsed:.1f} s; nodes {min(node_counts)}..{max(node_counts)}, "
        f"edges {min(edge_counts)}..{max(edge_counts)}; rejects {len(rejects)}"
    )
    print(f"manifest.jsonl sha256 = {manifest_sha}")
    if rejects:
        print(f"first rejects: {rejects[:5]}")
    return 0 if rows else 1


if __name__ == "__main__":
    sys.exit(main())
