"""Диагностика обучающего корпуса: разнообразие кода/промптов, покрытие масштабов, длины.

Отвечает на вопрос «чему физически может научиться модель на этих строках».
Работает только по файлу JSONL (CADSample-схема), ничего не генерирует и не правит.

    python tools/analyze_corpus.py data/processed/combined_v6.jsonl
    python tools/analyze_corpus.py <файл> --layer wire --examples 5
"""
from __future__ import annotations

import argparse
import collections
import hashlib
import json
import re
import statistics
import sys
from pathlib import Path

if hasattr(sys.stdout, "reconfigure"):  # Windows-консоль по умолчанию cp1251
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")

NUMBER = re.compile(r"-?\d+(?:\.\d+)?")
WORD = re.compile(r"[A-Za-zА-Яа-яЁё]+")


def skeleton(code: str) -> str:
    """Код без чисел и имён переменных: остаётся «форма» программы."""
    body = NUMBER.sub("#", code)
    body = re.sub(r"\s+", " ", body).strip()
    return hashlib.sha1(body.encode("utf-8")).hexdigest()[:12]


def prompt_shape(text: str) -> str:
    """Промпт без чисел: остаётся формулировка-шаблон."""
    return re.sub(r"\s+", " ", NUMBER.sub("#", text)).strip().lower()


def load(path: Path, layer: str | None) -> list[dict]:
    rows = []
    with path.open(encoding="utf-8") as handle:
        for line in handle:
            line = line.strip()
            if not line:
                continue
            row = json.loads(line)
            if layer and row.get("layer") != layer:
                continue
            rows.append(row)
    return rows


def prompts_of(row: dict) -> list[str]:
    value = row.get("prompts") or {}
    if isinstance(value, str):
        return [value]
    return [v for v in value.values() if isinstance(v, str) and v.strip()]


def report(rows: list[dict], examples: int) -> dict:
    by_layer: dict[str, list[dict]] = collections.defaultdict(list)
    for row in rows:
        by_layer[row.get("layer", "?")].append(row)

    out: dict = {"total": len(rows), "layers": {}}
    for layer, items in sorted(by_layer.items()):
        codes = [r.get("code", "") for r in items]
        skels = collections.Counter(skeleton(c) for c in codes)
        shapes = collections.Counter()
        langs = collections.Counter()
        words = collections.Counter()
        for row in items:
            value = row.get("prompts") or {}
            if isinstance(value, dict):
                langs.update(k for k, v in value.items() if isinstance(v, str) and v.strip())
            for text in prompts_of(row):
                shapes[prompt_shape(text)] += 1
                words.update(w.lower() for w in WORD.findall(text))
        kinds = collections.Counter((r.get("metadata") or {}).get("kind", "?") for r in items)
        lengths = sorted(len(c) for c in codes)
        bboxes = [
            (r.get("verification") or {}).get("target_bbox")
            for r in items
            if (r.get("verification") or {}).get("target_bbox")
        ]
        dims = [v for bb in bboxes for v in bb if isinstance(v, (int, float))]

        prompt_total = sum(shapes.values())
        out["layers"][layer] = {
            "rows": len(items),
            "code_skeletons": len(skels),
            "code_skeleton_top_share": round(skels.most_common(1)[0][1] / len(items), 3) if skels else 0,
            "rows_per_skeleton": round(len(items) / max(len(skels), 1), 1),
            "prompt_shapes": len(shapes),
            "prompt_shape_top_share": round(shapes.most_common(1)[0][1] / prompt_total, 3) if shapes else 0,
            "prompt_langs": dict(langs),
            "prompt_vocab": len(words),
            "kinds": dict(kinds.most_common(12)),
            "code_chars": {
                "median": lengths[len(lengths) // 2] if lengths else 0,
                "p95": lengths[int(0.95 * (len(lengths) - 1))] if lengths else 0,
                "max": lengths[-1] if lengths else 0,
            },
            "bbox_mm": {
                "min": round(min(dims), 1) if dims else None,
                "median": round(statistics.median(dims), 1) if dims else None,
                "max": round(max(dims), 1) if dims else None,
                "decades": sorted({len(str(int(v))) for v in dims}) if dims else [],
            },
            "top_skeleton_examples": [
                {"sha": sha, "rows": n, "share": round(n / len(items), 3)}
                for sha, n in skels.most_common(examples)
            ],
            "top_prompt_shapes": [
                {"shape": s[:110], "rows": n} for s, n in shapes.most_common(examples)
            ],
        }
    return out


def verdict(data: dict) -> list[str]:
    lines = []
    for layer, info in data["layers"].items():
        flags = []
        if info["rows_per_skeleton"] > 20:
            flags.append(f"код однообразен ({info['rows_per_skeleton']} строк на скелет)")
        if info["code_skeleton_top_share"] > 0.2:
            flags.append(f"один скелет покрывает {info['code_skeleton_top_share']:.0%}")
        if info["prompt_shapes"] < info["rows"] / 20:
            flags.append(f"формулировок мало ({info['prompt_shapes']} на {info['rows']} строк)")
        if info["prompt_vocab"] < 400:
            flags.append(f"словарь промптов бедный ({info['prompt_vocab']} слов)")
        lines.append(f"  {layer}: " + ("; ".join(flags) if flags else "разнообразие в норме"))
    return lines


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("path", type=Path)
    parser.add_argument("--layer", default=None)
    parser.add_argument("--examples", type=int, default=5)
    parser.add_argument("--json", action="store_true")
    args = parser.parse_args()

    rows = load(args.path, args.layer)
    if not rows:
        print(f"[EMPTY] {args.path} — нет строк (layer={args.layer})")
        return 4
    data = report(rows, args.examples)
    if args.json:
        print(json.dumps(data, ensure_ascii=False, indent=2))
        return 0

    print(f"=== {args.path}  строк: {data['total']}")
    for layer, info in data["layers"].items():
        print(f"\n[{layer}] rows={info['rows']}")
        print(f"  скелетов кода: {info['code_skeletons']} "
              f"({info['rows_per_skeleton']} строк/скелет, топ-1 = {info['code_skeleton_top_share']:.1%})")
        print(f"  формулировок:  {info['prompt_shapes']} "
              f"(топ-1 = {info['prompt_shape_top_share']:.1%}), словарь {info['prompt_vocab']}, "
              f"языки {info['prompt_langs']}")
        print(f"  длина кода:    median {info['code_chars']['median']}, p95 {info['code_chars']['p95']}, "
              f"max {info['code_chars']['max']} симв.")
        print(f"  bbox, мм:      {info['bbox_mm']['min']} .. {info['bbox_mm']['max']} "
              f"(median {info['bbox_mm']['median']}, порядков {info['bbox_mm']['decades']})")
        print(f"  kinds:         {info['kinds']}")
        for item in info["top_prompt_shapes"]:
            print(f"    {item['rows']:>6}×  {item['shape']}")
    print("\nвердикт:")
    for line in verdict(data):
        print(line)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
