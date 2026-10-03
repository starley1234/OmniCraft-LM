"""Ре-аудит корпуса исправленным минером `[SPECS]`: где промпт противоречит target_bbox.

Найденный в расследовании класс дефектов (para1-перефразировки с размерами от чужой
детали, части импортов, где код не повторяет заявленные фичи) ловится автоматически
там, где в тексте ЕСТЬ разбираемые размеры: сравниваем `verification.target_bbox` с
тем, что извлекает `src/runtime.specs_hook._mine_bbox` по каждому стилю промпта.
Строки без разбираемых размеров в отчёт не попадают — их судит только vision-аудит
(render_family_previews → verdict_template.csv).

Инструмент ничего не меняет: пишет candidates-CSV + сводку; фильтрация — решением
оператора (или `tools/filter_corpus_by_verdict.py`, если собрать из candidates
полный вердиктный CSV).

    python tools/reaudit_specs_corpus.py \
        --input data/processed/combined_v9_fixed.jsonl \
        --out runs/reaudit_specs \
        --tolerance 0.15 [--limit N] [--styles-all]

Совместим и с манифестом превью (--input data/previews/families_v9/manifest.jsonl,
там поля `prompt`/`target_bbox`/`family` плоские) — годится как smoke-прогон.
"""
from __future__ import annotations

import argparse
import csv
import hashlib
import json
import logging
import sys
from collections import Counter
from pathlib import Path

REPOSITORY_ROOT = Path(__file__).resolve().parents[1]
if str(REPOSITORY_ROOT) not in sys.path:
    sys.path.insert(0, str(REPOSITORY_ROOT))

logging.getLogger("omnicraft.specs").setLevel(logging.ERROR)
from src.runtime.specs_hook import _mine_bbox  # noqa: E402


def _rel_err(a: tuple[float, float, float], target) -> float | None:
    try:
        t = [float(v) for v in target]
    except (TypeError, ValueError):
        return None
    if len(t) != 3 or any(v <= 0 for v in t):
        return None
    return max(abs(x - y) / y for x, y in zip(a, t))


def row_prompts(row: dict) -> list[tuple[str, str]]:
    prompts = row.get("prompts")
    if isinstance(prompts, dict):
        out = [(style, text) for style, text in prompts.items() if isinstance(text, str) and text.strip()]
        if out:
            return out
    if isinstance(prompts, str) and prompts.strip():
        return [("prompt", prompts)]
    prompt = row.get("prompt")
    return [("prompt", prompt)] if isinstance(prompt, str) and prompt.strip() else []


def trained_style(row: dict, pairs: list[tuple[str, str]]) -> tuple[str, str] | None:
    """The style trainer.build_sequence actually feeds this row (sha1-of-id rotation)."""
    if not pairs:
        return None
    keys = dict(pairs)
    if len(keys) == 1:
        return pairs[0]
    digest = hashlib.sha1(str(row.get("id", "")).encode("utf-8")).digest()
    selected = sorted(keys)[digest[0] % len(keys)]
    return selected, keys[selected]


def row_target(row: dict):
    verification = row.get("verification")
    if isinstance(verification, dict):
        return verification.get("target_bbox")
    return row.get("target_bbox")


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("--input", type=Path, required=True)
    parser.add_argument("--out", type=Path, default=Path("runs/reaudit_specs"))
    parser.add_argument("--tolerance", type=float, default=0.15)
    parser.add_argument("--limit", type=int, default=0, help="проверить только первые N строк")
    parser.add_argument("--styles-all", action="store_true",
                        help="считать bad по любому стилю (по умолчанию — по первому, "
                             "т.к. ротация трейнера детерминирована по id)")
    args = parser.parse_args()

    if not args.input.is_file():
        print(f"[MISSING] {args.input} — корпус вне git, запускать на машине владельца")
        return 3
    args.out.mkdir(parents=True, exist_ok=True)
    candidates_path = args.out / "candidates.csv"
    stats_path = args.out / "summary.json"

    checked = stated = flagged = malformed = 0
    by_origin: Counter[str] = Counter()
    with args.input.open(encoding="utf-8") as handle, candidates_path.open(
        "w", encoding="utf-8", newline=""
    ) as out_handle:
        writer = csv.writer(out_handle)
        writer.writerow(["id", "origin", "style", "stated_bbox", "target_bbox", "rel_err"])
        for line_no, line in enumerate(handle):
            line = line.strip()
            if not line:
                continue
            if args.limit and line_no >= args.limit:
                break
            try:
                row = json.loads(line)
            except json.JSONDecodeError:
                malformed += 1
                continue
            target = row_target(row)
            if target is None:
                continue
            checked += 1
            pairs = row_prompts(row)
            if not pairs:
                continue
            if args.styles_all:
                considered = pairs
            else:
                chosen = trained_style(row, pairs)
                considered = [chosen] if chosen else []
            hits = []
            for style, text in considered:
                bbox, source = _mine_bbox(text)
                if source == "default":
                    continue  # текст ничего не заявляет — не evidence
                stated += 1
                err = _rel_err(bbox, target)
                if err is not None and err > args.tolerance:
                    hits.append((style, bbox, err))
            if hits:
                flagged += 1
                origin = str((row.get("metadata") or {}).get("origin") or row.get("family") or "?")
                by_origin[origin] += 1
                for style, bbox, err in (hits if args.styles_all else hits[:1]):
                    writer.writerow([
                        row.get("id", f"line_{line_no}"), origin, style,
                        [round(v, 3) for v in bbox], [round(float(v), 3) for v in target],
                        round(err, 3),
                    ])

    summary = {
        "input": str(args.input), "tolerance": args.tolerance,
        "rows_checked": checked, "prompts_with_stated_dims": stated,
        "rows_flagged": flagged, "malformed_lines": malformed,
        "top_origins": dict(by_origin.most_common(30)),
    }
    stats_path.write_text(json.dumps(summary, ensure_ascii=False, indent=2), encoding="utf-8")
    for key, value in summary.items():
        if key != "top_origins":
            print(f"{key:24s} {value}")
    print(f"\ntop origins по числу противоречий (> {args.tolerance:.0%}):")
    for origin, count in list(by_origin.most_common(30)):
        print(f"  {count:6d}  {origin}")
    print(f"\ncandidates → {candidates_path}\nsummary  → {stats_path}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
