"""Build the sketch4 corpus - second wave of the sketch canvas.

Reuses sketch2's gate (``build_sketch2.audit`` = core2s audit + axis + point
count + the place1 law on both prompts) and sketch2's disk verifier
(``verify_sketch2.py --parts-dir optional_data/data/sketch4``).

Usage
-----
    python tools/dataset_sketch4/build_sketch4.py --count 200
    python tools/dataset_sketch4/build_sketch4.py --count 4 --out /tmp/sketch4_smoke
"""

from __future__ import annotations

import argparse
import sys
import time
from pathlib import Path

if __package__ in (None, ""):
    sys.path.insert(0, str(Path(__file__).resolve().parents[2]))

from tools.dataset_sketch2.build_sketch2 import audit
from tools.dataset_sketch4.families4s import FAMILY_BUILDERS
from tools.dataset_v5.kit import build_family_corpus, write_delivery

DEFAULT_OUT = Path("optional_data/data/sketch4")
CORPUS_DIR = "optional_data/data/sketch4"


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--count", type=int, default=200, help="samples per family")
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
            "validation_status": "pending_openscad_manifold",
        },
        file_stem="part",
        count_per_family=args.count,
        quiet=args.quiet,
    )
    manifest_sha = write_delivery(
        args.out,
        rows,
        written,
        corpus_dir=CORPUS_DIR if args.out == DEFAULT_OUT else str(args.out),
        verify_cmd="python tools/dataset_sketch2/verify_sketch2.py --parts-dir optional_data/data/sketch4",
    )
    elapsed = time.time() - started
    with_voids = sum(1 for row in rows if row.get("voids_profiles"))
    print(f"\n{len(rows)} parts, {elapsed:.1f} s; {with_voids} with voids, rejects {len(rejects)}")
    print(f"manifest.jsonl sha256 = {manifest_sha}")
    if rejects:
        print(f"first rejects: {rejects[:5]}")
    return 0 if rows else 1


if __name__ == "__main__":
    sys.exit(main())
