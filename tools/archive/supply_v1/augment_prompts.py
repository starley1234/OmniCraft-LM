"""Multiply prompt styles of an accepted corpus without touching geometry.

Each output row reuses the parent's code/verification and carries a fresh
``{id}__{style}`` prompt variant rendered by
:mod:`src.data.generators.prompt_augment` (deterministic per seed+id+style).
Every emitted row is checked against ``CADSample`` before writing, so the
result is a drop-in corpus for split/train.

    python tools/augment_prompts.py \
        --input data/processed/combined_v6.jsonl \
        --output data/processed/combined_v6_aug.jsonl --seed 1234
"""

from __future__ import annotations

import argparse
import collections
import io
import json
import sys
from pathlib import Path

REPOSITORY_ROOT = Path(__file__).resolve().parents[1]
if str(REPOSITORY_ROOT) not in sys.path:
    sys.path.insert(0, str(REPOSITORY_ROOT))

from src.data.generators.prompt_augment import AUGMENT_STYLES, augment_corpus
from src.data.schema import CADSample


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--input", type=Path, required=True, help="source corpus JSONL")
    parser.add_argument("--output", type=Path, required=True, help="augmented corpus JSONL")
    parser.add_argument("--seed", type=int, default=1234)
    parser.add_argument("--styles", nargs="+", default=list(AUGMENT_STYLES),
                        choices=sorted(AUGMENT_STYLES))
    parser.add_argument("--drop-original", action="store_true",
                        help="emit only augmented rows (default: keep originals)")
    parser.add_argument("--limit", type=int, default=None, help="process first N source rows")
    return parser


def main() -> int:
    args = build_parser().parse_args()
    rows_in = rows_out = 0
    per_style: collections.Counter[str] = collections.Counter()
    seen_ids: set[str] = set()

    args.output.parent.mkdir(parents=True, exist_ok=True)
    with io.open(args.input, encoding="utf-8") as src, io.open(
        args.output, "w", encoding="utf-8", newline="\n"
    ) as dst:
        def source_rows():
            for line in src:
                if line.strip():
                    yield json.loads(line)

        stream = source_rows()
        if args.limit:
            head = []
            for row in stream:
                if len(head) >= args.limit:
                    break
                head.append(row)
            stream = iter(head)

        for row in augment_corpus(stream, args.seed, args.styles,
                                  keep_original=not args.drop_original):
            validated = CADSample.model_validate(row)
            if validated.id in seen_ids:
                raise SystemExit(f"duplicate id after augmentation: {validated.id}")
            seen_ids.add(validated.id)
            style = row.get("metadata", {}).get("prompt_style")
            if style:
                per_style[style] += 1
            else:
                rows_in += 1
            dst.write(json.dumps(validated.model_dump(mode="json"), ensure_ascii=False) + "\n")
            rows_out += 1

    print(f"input rows: {rows_in}")
    print(f"output rows: {rows_out}")
    for style, count in sorted(per_style.items()):
        print(f"  +{style}: {count}")
    print(f"written: {args.output}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
