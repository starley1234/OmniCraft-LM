"""Build the v15 training corpus: v14 LM subset + accepted wire-family rows.

Rationale (STATUS.md, задача [A]): v14 прошёл приёмку по voxel, но wire-compile
застрял на 16/42 — в корпусе слишком мало и слишком однообразных каркасов.
`src/data/generators/wire_families_gen.py` даёт шесть новых семейств; принятые
настоящим OpenSCAD строки доливаются к LM-подмножеству v14, после чего сплит
пересобирается тем же `split_dataset.py` (seed 1234, kind-and-dimension).

Вход по умолчанию:
  data/processed/combined_v14_lm.jsonl
  data/processed/wire_families_v15.validation.accepted.jsonl
Выход:
  data/processed/combined_v15_lm.jsonl, data/processed/splits_v15/
"""

from __future__ import annotations

import argparse
import json
import subprocess
import sys
from collections import Counter
from pathlib import Path

REPO = Path(__file__).resolve().parents[1]


def iter_rows(path: Path):
    with path.open("r", encoding="utf-8") as handle:
        for line in handle:
            line = line.strip()
            if line:
                yield json.loads(line)


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("--base", type=Path, default=REPO / "data/processed/combined_v14_lm.jsonl")
    parser.add_argument(
        "--wire-accepted",
        type=Path,
        default=REPO / "data/processed/wire_families_v15.validation.accepted.jsonl",
    )
    parser.add_argument("--output", type=Path, default=REPO / "data/processed/combined_v15_lm.jsonl")
    parser.add_argument("--split-dir", type=Path, default=REPO / "data/processed/splits_v15")
    parser.add_argument("--report", type=Path, default=REPO / "runs/corpus_v15/V15_CORPUS_REPORT.md")
    parser.add_argument("--seed", type=int, default=1234)
    parser.add_argument("--skip-split", action="store_true")
    args = parser.parse_args(argv)

    for path in (args.base, args.wire_accepted):
        if not path.is_file():
            print(f"[v15] missing input: {path}")
            return 4

    seen: set[str] = set()
    layers: Counter[str] = Counter()
    families: Counter[str] = Counter()
    added = 0
    base_rows = 0

    temp = args.output.with_name(args.output.name + ".tmp")
    args.output.parent.mkdir(parents=True, exist_ok=True)
    with temp.open("w", encoding="utf-8") as out:
        for row in iter_rows(args.base):
            seen.add(row["id"])
            layers[row.get("layer", "?")] += 1
            base_rows += 1
            out.write(json.dumps(row, ensure_ascii=False) + "\n")
        for row in iter_rows(args.wire_accepted):
            if row["id"] in seen:
                continue
            seen.add(row["id"])
            layers[row.get("layer", "?")] += 1
            families[str(row.get("metadata", {}).get("kind", "?"))] += 1
            added += 1
            out.write(json.dumps(row, ensure_ascii=False) + "\n")
    temp.replace(args.output)

    total = base_rows + added
    print(f"[v15] base {base_rows} + wire families {added} = {total}")
    print(f"[v15] layers: {dict(sorted(layers.items()))}")
    print(f"[v15] new wire families: {dict(sorted(families.items()))}")

    if not args.skip_split:
        args.split_dir.mkdir(parents=True, exist_ok=True)
        cmd = [
            sys.executable, str(REPO / "tools/split_dataset.py"),
            "--input", str(args.output), "--output-dir", str(args.split_dir),
            "--seed", str(args.seed), "--group-by", "kind-and-dimension",
        ]
        print("$ " + " ".join(cmd))
        subprocess.run(cmd, check=True)

    args.report.parent.mkdir(parents=True, exist_ok=True)
    lines = [
        "# Корпус v15 — отчёт сборки",
        "",
        f"- база (v14 LM): **{base_rows}**",
        f"- добавлено wire-семейств (OpenSCAD-accepted): **{added}**",
        f"- итого: **{total}**",
        f"- по слоям: `{dict(sorted(layers.items()))}`",
        f"- по семействам: `{dict(sorted(families.items()))}`",
        f"- сплит: `{args.split_dir}` (seed {args.seed}, kind-and-dimension)",
    ]
    args.report.write_text("\n".join(lines) + "\n", encoding="utf-8")
    print(f"[v15] report -> {args.report}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
