"""Сборка обучающего корпуса v8 из v6+аугментации с чисткой и аннотацией качества.

Чинит две болезни, найденные разбором v6/v7 (см. STATUS.md):

1. **Неинформативные формулировки.** 61 716 промпт-строк вида «сделай деталь NxNxN мм»
   привязаны к сотням разных геометрий. Одна фраза -> много ответов = модель учится
   игнорировать текст и печатать самый частый скелет. Такие стили вырезаются.
2. **Доминирование одного скелета.** В wire 93.7% строк — один и тот же каркас фермы.
   Вводится потолок строк на скелет кода: корпус перестаёт быть «одной деталью в N копиях».

Каждая строка результата получает `metadata.quality` — вердикт, посчитанный один раз:
    {"score": 0..1, "flags": [...], "skeleton": "<sha12>", "skeleton_rows": N,
     "prompt_styles": [...], "dropped_styles": [...], "builder": "v8"}
Это и есть «комментарий в корпусе»: к повторной проверке возвращаться не нужно,
фильтровать можно прямо по полю (`quality.score`, `quality.flags`).

    python tools/build_corpus_v8.py                      # дефолтные пути и пороги
    python tools/build_corpus_v8.py --dry-run            # только отчёт, без записи
"""
from __future__ import annotations

import argparse
import collections
import hashlib
import json
import re
import sys
from pathlib import Path

if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")

NUMBER = re.compile(r"-?\d+(?:\.\d+)?")

# Явно заявленный в тексте габарит: «габариты 40x50x90», «overall 40 x 50 x 90».
STATED_BBOX = re.compile(
    r"(?:габарит\w*|размер\w*|overall|outer dimensions|size)\D{0,20}?"
    r"(\d+(?:\.\d+)?)\s*(?:x|х|×|by|на)\s*(\d+(?:\.\d+)?)\s*(?:x|х|×|by|на)\s*(\d+(?:\.\d+)?)",
    re.IGNORECASE,
)


def states_wrong_bbox(text: str, bbox: list[float], tolerance: float = 0.15) -> bool:
    """Промпт называет габарит, которого у детали нет (ложь про масштаб).

    Такие строки учат модель, что названный размер не связан с геометрией, —
    прямая причина ошибок bbox в 3–24 раза на held-out (разбор v7).
    """
    match = STATED_BBOX.search(text)
    if not match or len(bbox) != 3:
        return False
    stated = sorted(float(v) for v in match.groups())
    actual = sorted(float(v) for v in bbox)
    return max(abs(a - b) / max(b, 1e-6) for a, b in zip(stated, actual)) > tolerance

# Потолок строк на один скелет кода: ниже — корпус теряет объём, выше — возвращается
# доминирование. Подобрано так, чтобы truss перестал быть 94% слоя wire.
SKELETON_CAP = {"voxel": 400, "wire": 250, "sketch": 200}
DEFAULT_CAP = 300


def skeleton(code: str) -> str:
    return hashlib.sha1(re.sub(r"\s+", " ", NUMBER.sub("#", code)).strip().encode("utf-8")).hexdigest()[:12]


def prompt_shape(text: str) -> str:
    return re.sub(r"\s+", " ", NUMBER.sub("#", text)).strip().lower()


def read_rows(path: Path) -> list[dict]:
    with path.open(encoding="utf-8") as handle:
        return [json.loads(line) for line in handle if line.strip()]


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("--source", type=Path, default=Path("data/processed/combined_v6_augmented.jsonl"))
    parser.add_argument("--output", type=Path, default=Path("data/processed/combined_v8.jsonl"))
    parser.add_argument("--report", type=Path, default=Path("data/processed/combined_v8.report.json"))
    parser.add_argument("--max-geometries-per-shape", type=int, default=3,
                        help="формулировка, отвечающая большему числу разных геометрий, считается пустой")
    parser.add_argument("--min-styles", type=int, default=1,
                        help="строка без такого количества осмысленных формулировок выбрасывается")
    parser.add_argument("--dry-run", action="store_true")
    args = parser.parse_args()

    rows = read_rows(args.source)
    print(f"исходник: {args.source} — {len(rows)} строк")

    # --- проход 1: сколько разных геометрий отвечает на каждую формулировку
    shape_geometries: dict[tuple[str, str], set[str]] = collections.defaultdict(set)
    skeletons: list[str] = []
    for row in rows:
        sha = skeleton(row.get("code", ""))
        skeletons.append(sha)
        for text in (row.get("prompts") or {}).values():
            if isinstance(text, str) and text.strip():
                shape_geometries[(row.get("layer", "?"), prompt_shape(text))].add(sha)

    skeleton_rows = collections.Counter(skeletons)

    # --- проход 2: чистка строк
    kept: list[dict] = []
    per_skeleton: collections.Counter[str] = collections.Counter()
    stats = collections.Counter()
    dropped_styles = collections.Counter()
    for row, sha in zip(rows, skeletons):
        layer = row.get("layer", "?")
        prompts = {k: v for k, v in (row.get("prompts") or {}).items() if isinstance(v, str) and v.strip()}
        bbox = (row.get("verification") or {}).get("target_bbox") or []
        good, bad, lying = {}, [], []
        for style, text in prompts.items():
            if states_wrong_bbox(text, bbox):
                lying.append(style)
                dropped_styles[f"{style}:wrong_bbox"] += 1
            elif len(shape_geometries[(layer, prompt_shape(text))]) > args.max_geometries_per_shape:
                bad.append(style)
                dropped_styles[style] += 1
            else:
                good[style] = text
        if lying:
            stats["prompts_with_wrong_bbox"] += len(lying)
        if len(good) < args.min_styles:
            stats["drop_no_informative_prompt"] += 1
            continue
        cap = SKELETON_CAP.get(layer, DEFAULT_CAP)
        if per_skeleton[sha] >= cap:
            stats["drop_skeleton_cap"] += 1
            continue
        per_skeleton[sha] += 1

        row["prompts"] = good
        metadata = row.setdefault("metadata", {})
        metadata["quality"] = {
            "score": round(len(good) / max(len(prompts), 1), 2),
            "flags": (["prompt_styles_dropped"] if bad else [])
                     + (["wrong_bbox_prompts_dropped"] if lying else [])
                     + (["rare_geometry"] if skeleton_rows[sha] < 5 else [])
                     + (["mass_geometry"] if skeleton_rows[sha] > 2000 else []),
            "skeleton": sha,
            "skeleton_rows_source": skeleton_rows[sha],
            "prompt_styles": sorted(good),
            "dropped_styles": sorted(bad + lying),
            "builder": "v8",
        }
        kept.append(row)
        stats["kept"] += 1

    # --- отчёт
    by_layer = collections.Counter(r.get("layer", "?") for r in kept)
    top_share = {}
    for layer in by_layer:
        counts = collections.Counter(r["metadata"]["quality"]["skeleton"] for r in kept if r.get("layer") == layer)
        top_share[layer] = round(counts.most_common(1)[0][1] / by_layer[layer], 3)
    report = {
        "source": str(args.source),
        "source_rows": len(rows),
        "kept": stats["kept"],
        "dropped": {k: v for k, v in stats.items() if k != "kept"},
        "dropped_prompt_styles": dict(dropped_styles.most_common()),
        "layers": dict(by_layer),
        "top_skeleton_share": top_share,
        "skeleton_cap": SKELETON_CAP,
        "max_geometries_per_shape": args.max_geometries_per_shape,
    }
    print(json.dumps(report, ensure_ascii=False, indent=2))

    if args.dry_run:
        print("[dry-run] ничего не записано")
        return 0

    args.output.parent.mkdir(parents=True, exist_ok=True)
    with args.output.open("w", encoding="utf-8") as handle:
        for row in kept:
            handle.write(json.dumps(row, ensure_ascii=False) + "\n")
    args.report.write_text(json.dumps(report, ensure_ascii=False, indent=2), encoding="utf-8")
    print(f"записано: {args.output} ({stats['kept']} строк), отчёт: {args.report}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
