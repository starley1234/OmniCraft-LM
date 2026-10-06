#!/usr/bin/env python3
"""Generate wire-family training candidates (docs/TRAIN_BRIEF_v14.md §6 «задача A», v15).

Six structural families with analytic bboxes and <=32 canvas nodes; prompts carry
six styles including the dimension-free ``conv_*`` pair. Output is a candidates
file — it must go through ``omni validate`` (OpenSCAD on the GPU box) before it can
enter a combined corpus; nothing here touches data/processed/.

    python tools/gen_wire_families.py --count 4000 --seed 1234 --out data/processed/wire_families_candidates.jsonl
"""

from __future__ import annotations

import argparse
import sys
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[1]
if str(REPO_ROOT) not in sys.path:
    sys.path.insert(0, str(REPO_ROOT))

from src.data.generators.wire_families_gen import FAMILIES, WireFamiliesGenerator  # noqa: E402
from src.data.schema import write_jsonl  # noqa: E402


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("--count", type=int, default=1000, help="total samples, cycled over families")
    parser.add_argument("--seed", type=int, default=1234)
    parser.add_argument("--families", default=",".join(FAMILIES),
                        help="comma list subset of " + ",".join(FAMILIES))
    parser.add_argument("--out", type=Path, required=True)
    parser.add_argument("--dry-count", action="store_true", help="generate but write nothing")
    args = parser.parse_args(argv)

    families = tuple(f.strip() for f in args.families.split(",") if f.strip())
    generator = WireFamiliesGenerator(seed=args.seed, families=families)
    samples = list(generator.generate_many(args.count))
    if args.dry_count:
        print(f"would write {len(samples)} samples across {len(families)} families")
        return 0
    args.out.parent.mkdir(parents=True, exist_ok=True)
    write_jsonl(args.out, samples)
    per_family: dict[str, int] = {}
    for sample in samples:
        key = str(sample.metadata.get("kind", "?"))
        per_family[key] = per_family.get(key, 0) + 1
    summary = ", ".join(f"{k}: {v}" for k, v in sorted(per_family.items()))
    print(f"[wire-fam] wrote {len(samples)} candidates -> {args.out} ({summary})")
    print("[wire-fam] candidates only: run tools/omni.py validate --input <file> --out <clean> on a box with OpenSCAD")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
