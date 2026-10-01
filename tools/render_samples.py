"""Выборочный визуальный контроль корпуса: рендер случайных строк в PNG.

Нужен, чтобы глазами убедиться, что геометрия соответствует формулировке
(математика по разнообразию — в tools/analyze_corpus.py).

    python tools/render_samples.py data/processed/combined_v8.jsonl --per-layer 2
"""
from __future__ import annotations

import argparse
import json
import random
import subprocess
import sys
from pathlib import Path

if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("path", type=Path)
    parser.add_argument("--per-layer", type=int, default=2)
    parser.add_argument("--seed", type=int, default=7)
    parser.add_argument("--out", type=Path, default=Path("runs/corpus_check"))
    args = parser.parse_args()

    rows = [json.loads(line) for line in args.path.open(encoding="utf-8") if line.strip()]
    args.out.mkdir(parents=True, exist_ok=True)
    rng = random.Random(args.seed)

    layers = sorted({row.get("layer", "?") for row in rows})
    for layer in layers:
        subset = [r for r in rows if r.get("layer") == layer]
        for index, row in enumerate(rng.sample(subset, min(args.per_layer, len(subset)))):
            scad = args.out / f"{layer}_{index}.scad"
            scad.write_text(row["code"], encoding="utf-8")
            png = scad.with_suffix(".png")
            subprocess.run(
                ["openscad", "-o", str(png), "--imgsize=420,340", "--colorscheme=Metallic",
                 "--viewall", "--autocenter", str(scad)],
                capture_output=True, timeout=300, check=False,
            )
            prompt = next(iter((row.get("prompts") or {}).values()), "")
            bbox = (row.get("verification") or {}).get("target_bbox")
            print(f"{png.name}  bbox={bbox}  {prompt[:100]}")
    print(f"PNG в {args.out}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
