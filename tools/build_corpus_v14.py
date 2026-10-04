"""Build the v14 training corpus from the lightly-cleaned base (brief §1.3–§1.6).

Takes ``data/processed/combined_v14.jsonl`` (output of ``clean_corpus_v10.py
--cap-origin-frac 0.25``, all layers) and produces:

1. **Conv-pairs (main fix, §1.4).** For a stratified sample of unique code
   prototypes (voxel+wire) it writes explicit pairs "text WITHOUT any dimensions
   + code carrying the GT dimensions". At training the ``[SPECS]`` block is
   composed from ``verification.target_bbox`` (the normal path), so the only way
   to know the scale is to read the block. The legacy ``conv_*`` styles re-added
   the dimensions in the text (45 818/45 838 of them contained digits), which is
   exactly why conv never learned scale injection.
2. **Compactness (§1.6).** Comment lines/block comments/trailing comments are
   stripped from every program (comments do not affect geometry). That roughly
   halves the median code length, letting far more rows fit the 1000-token
   forward budget. ``metadata.code_sha256`` is recomputed; the recorded CAD
   evidence still applies because comments are non-functional.
3. **Sketch rows outside training splits (§1.5).** ``combined_v14.jsonl`` keeps
   every layer, but the LM split is rebuilt from the voxel+wire subset
   (``combined_v14_lm.jsonl``) so the non-trainable sketch/brep/assembly rows
   never enter ``splits_v14``.

The split is rebuilt with ``split_dataset.py`` (seed 1234, kind-and-dimension),
so conv rows share their prototype's group and cannot leak across partitions.
"""

from __future__ import annotations

import argparse
import copy
import hashlib
import json
import re
import subprocess
import sys
from collections import Counter, defaultdict
from pathlib import Path

REPO = Path(__file__).resolve().parents[1]
if str(REPO) not in sys.path:
    sys.path.insert(0, str(REPO))

TRAIN_LAYERS = ("voxel", "wire")

# Dimension tokens: an optional Ø/R prefix, a number, optional "a x b x c"
# chains, and an optional unit. Counts ("5 holes") are stripped too — the pair
# must carry no numeric scale at all.
_DIM = re.compile(
    r"(?<![A-Za-zА-Яа-я0-9])"
    r"(?:[Ø⌀ø]|[Rr]|[Dd]|[Mm])?\s*\d+(?:[.,]\d+)?"
    r"(?:\s*(?:x|х|×|\*|by|на)\s*\d+(?:[.,]\d+)?)*"
    r"\s*(?:мм|mm|cm|см|deg|°|\")?"
)
_LEADING_VERB = re.compile(
    r"^(?:Создай|Сделай|Смоделируй|Построй|Изготовь|Требуется|Нужен|Нужна|Нужно|"
    r"Мне нужен|Мне нужна|Собери|Сделайте|Придумай|"
    r"Create|Make|Build|Design|Model|Need|Required|I need|Can you (?:model|make|build))\s+",
    re.IGNORECASE,
)
_TRAILING_JUNK = re.compile(
    r"\s+(?:в|на|с|из|по|для|и|by|with|to|of|around|about|около|примерно)\s*$", re.IGNORECASE
)

RU_TEMPLATES = (
    "{desc}. Размеры возьми из блока [SPECS].",
    "Нужно: {desc}. Габарит — из спецификации.",
    "Сделай {desc}; точные размеры смотри в спецификации.",
    "{desc}. Масштаб задан в блоке [SPECS].",
)
EN_TEMPLATES = (
    "{desc}. Take the dimensions from the [SPECS] block.",
    "Need: {desc}. The size comes from the spec block.",
    "Make {desc}; the exact sizes are in [SPECS].",
    "{desc}. Scale is given in the [SPECS] block.",
)


def sha256_text(text: str) -> str:
    return hashlib.sha256(text.encode("utf-8")).hexdigest()


def strip_comments(code: str) -> str:
    """Drop full-line //, /* */ blocks, and trailing // comments (quotes guarded)."""
    out: list[str] = []
    in_block = False
    for line in code.split("\n"):
        stripped = line.strip()
        if in_block:
            if "*/" in stripped:
                in_block = False
            continue
        if stripped.startswith("/*"):
            if "*/" not in stripped:
                in_block = True
            continue
        if stripped.startswith("//"):
            continue
        marker = line.find("//")
        if marker != -1 and '"' not in line[:marker] and "'" not in line[:marker]:
            line = line[:marker].rstrip()
        if line.strip():
            out.append(line)
    text = "\n".join(out).strip()
    if not text.startswith("$fn = 32;"):
        text = "$fn = 32;\n" + text
    return text + "\n"


def strip_dimensions(text: str) -> str:
    cleaned = _DIM.sub(" ", text)
    # guarantee: no digit may survive, even attached (d40, M3, NEMA17...)
    cleaned = re.sub(r"[DdMmRr]\s*\d+(?:[.,]\d+)?", " ", cleaned)
    cleaned = re.sub(r"\d+(?:[.,]\d+)?", " ", cleaned)
    cleaned = re.sub(r"\s+", " ", cleaned)
    cleaned = _TRAILING_JUNK.sub("", cleaned)
    cleaned = re.sub(r"\s*\?+\s*$", "", cleaned)
    cleaned = re.sub(r"\s+([,.;:])", r"\1", cleaned)
    cleaned = re.sub(r"([,;:])\s*([,;:])+", r"\1", cleaned)
    cleaned = _LEADING_VERB.sub("", cleaned)
    cleaned = re.sub(r"^(?:a|an|the)\s+", "", cleaned, flags=re.IGNORECASE)
    cleaned = re.sub(r"\s+", " ", cleaned).strip(" ,.;:-–—?")
    if re.search(r"\d", cleaned):  # pragma: no cover - defensive; must never fire
        cleaned = re.sub(r"\d+", " ", cleaned)
        cleaned = re.sub(r"\s+", " ", cleaned).strip(" ,.;:-–—?")
    return cleaned


def compact_code_in_row(row: dict) -> None:
    old = row["code"]
    new = strip_comments(old)
    if new != old:
        row["code"] = new
    metadata = row.setdefault("metadata", {})
    metadata["code_sha256"] = sha256_text(row["code"])
    metadata["v14_compacted"] = new != old


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("--input", type=Path, default=REPO / "data/processed/combined_v14.jsonl")
    parser.add_argument("--output", type=Path, default=REPO / "data/processed/combined_v14.jsonl")
    parser.add_argument("--lm-output", type=Path, default=REPO / "data/processed/combined_v14_lm.jsonl")
    parser.add_argument("--split-dir", type=Path, default=REPO / "data/processed/splits_v14")
    parser.add_argument("--report", type=Path, default=REPO / "runs/reaudit_specs/v14/V14_CORPUS_REPORT.md")
    parser.add_argument("--target-protos", type=int, default=1500, help="unique prototypes to pair (x4 formulations)")
    parser.add_argument("--variants", type=int, default=2, help="formulations per language per prototype")
    parser.add_argument("--seed", type=int, default=1234)
    parser.add_argument("--no-compact", action="store_true", help="do not strip code comments")
    parser.add_argument("--sample", type=int, default=0, help="print N example pairs and exit")
    parser.add_argument("--skip-split", action="store_true")
    args = parser.parse_args(argv)

    if not args.input.is_file():
        print(f"[MISSING] input corpus: {args.input}", file=sys.stderr)
        return 4

    # ---- pass 1: prototypes = unique code_sha256 across trainable layers
    protos: dict[str, dict] = {}
    layer_counts: Counter = Counter()
    with args.input.open(encoding="utf-8") as stream:
        for line in stream:
            if not line.strip():
                continue
            row = json.loads(line)
            layer_counts[row["layer"]] += 1
            if row["layer"] not in TRAIN_LAYERS:
                continue
            metadata = row.get("metadata") or {}
            key = metadata.get("code_sha256") or sha256_text(row["code"])
            if key in protos:
                continue
            prompts = row.get("prompts") or {}
            base_ru = prompts.get("ru") or prompts.get("formal_ru") or ""
            base_en = prompts.get("en") or ""
            if not base_en:
                base_en = next((v for k, v in prompts.items() if k.startswith("en")), "")
            protos[key] = {
                "key": key,
                "layer": row["layer"],
                "base_id": row["id"].split("__")[0],
                "code": row["code"],
                "verification": row["verification"],
                "metadata": metadata,
                "aux": row.get("auxiliary_ground_truth") or {"nodes": [], "edges": []},
                "desc_ru": strip_dimensions(base_ru),
                "desc_en": strip_dimensions(base_en),
            }
    # prefer prototypes with a usable description in both languages
    usable = {k: v for k, v in protos.items() if len(v["desc_ru"]) >= 8 and len(v["desc_en"]) >= 8}
    pool = usable if len(usable) >= args.target_protos else protos
    print(f"prototypes: {len(protos)} (usable {len(usable)}), layers {dict(layer_counts)}")

    # ---- stratified round-robin by origin
    by_origin: dict[str, list[str]] = defaultdict(list)
    for key, proto in pool.items():
        by_origin[str((proto["metadata"] or {}).get("origin"))].append(key)
    for values in by_origin.values():
        values.sort()
    selected: list[str] = []
    origins_sorted = sorted(by_origin, key=lambda origin: (-len(by_origin[origin]), origin))
    while len(selected) < args.target_protos:
        progressed = False
        for origin in origins_sorted:
            values = by_origin[origin]
            if values:
                selected.append(values.pop())
                progressed = True
                if len(selected) >= args.target_protos:
                    break
        if not progressed:
            break

    if args.sample:
        fallback_ru, fallback_en = "деталь", "part"
        for key in selected[: args.sample]:
            proto = pool[key]
            print(f"--- {proto['base_id']} [{proto['layer']}] origin={proto['metadata'].get('origin')}")
            for template in RU_TEMPLATES[:2]:
                print("   RU:", template.format(desc=proto["desc_ru"] or fallback_ru))
            for template in EN_TEMPLATES[:2]:
                print("   EN:", template.format(desc=proto["desc_en"] or fallback_en))
        return 0

    # ---- build conv-pair rows
    generated: list[dict] = []
    per_origin = Counter()
    for proto_index, key in enumerate(selected):
        proto = pool[key]
        origin = str((proto["metadata"] or {}).get("origin"))
        per_origin[origin] += 1
        desc_ru = proto["desc_ru"] or "деталь"
        desc_en = proto["desc_en"] or "part"
        variants: list[tuple[str, str]] = []
        for index in range(args.variants):
            variants.append(("conv_ru", RU_TEMPLATES[index % len(RU_TEMPLATES)].format(desc=desc_ru)))
        for index in range(args.variants):
            variants.append(("conv_en", EN_TEMPLATES[index % len(EN_TEMPLATES)].format(desc=desc_en)))
        for index, (style, text) in enumerate(variants):
            row = {
                "id": f"{proto['base_id']}__v14nodims_{proto_index:05d}_{index}",
                "layer": proto["layer"],
                "prompts": {style: text},
                "images": [],
                "code": proto["code"],
                "verification": copy.deepcopy(proto["verification"]),
                "auxiliary_ground_truth": copy.deepcopy(proto["aux"]),
                "metadata": copy.deepcopy(proto["metadata"]),
            }
            metadata = row["metadata"]
            metadata["code_sha256"] = sha256_text(row["code"])
            metadata["origin"] = metadata.get("origin")
            metadata["v14_conv_pair"] = True
            metadata["quality"] = {
                "score": 1.0,
                "flags": ["v14_conv_pair", "no_dimensions_in_text"],
                "skeleton": "",
                "skeleton_rows": 1,
                "prompt_styles": [style],
                "dropped_styles": [],
                "builder": "v14",
            }
            generated.append(row)
    print(f"generated conv-pair rows: {len(generated)} from {len(selected)} prototypes")

    # ---- pass 2: transform base rows + append pairs; write corpus and LM subset
    temp_corpus = args.output.with_name(args.output.name + ".tmp")
    temp_lm = args.lm_output.with_name(args.lm_output.name + ".tmp")
    lengths_before: list[int] = []
    lengths_after: list[int] = []
    n_base = n_lm = 0
    with args.input.open(encoding="utf-8") as src, \
            temp_corpus.open("w", encoding="utf-8", newline="\n") as out_corpus, \
            temp_lm.open("w", encoding="utf-8", newline="\n") as out_lm:
        for line in src:
            if not line.strip():
                continue
            row = json.loads(line)
            lengths_before.append(len(row["code"]))
            if not args.no_compact:
                compact_code_in_row(row)
            lengths_after.append(len(row["code"]))
            out_corpus.write(json.dumps(row, ensure_ascii=False) + "\n")
            if row["layer"] in TRAIN_LAYERS:
                out_lm.write(json.dumps(row, ensure_ascii=False) + "\n")
                n_lm += 1
            n_base += 1
        for row in generated:
            lengths_before.append(len(row["code"]))
            if not args.no_compact:
                compact_code_in_row(row)
            lengths_after.append(len(row["code"]))
            out_corpus.write(json.dumps(row, ensure_ascii=False) + "\n")
            out_lm.write(json.dumps(row, ensure_ascii=False) + "\n")
            n_lm += 1
    temp_corpus.replace(args.output)
    temp_lm.replace(args.lm_output)
    total = n_base + len(generated)
    print(f"corpus: {total} rows (base {n_base} + pairs {len(generated)}); LM subset: {n_lm}")

    # ---- rebuild split from the trainable subset (§1.5)
    if not args.skip_split:
        args.split_dir.mkdir(parents=True, exist_ok=True)
        cmd = [
            sys.executable, str(REPO / "tools/split_dataset.py"),
            "--input", str(args.lm_output), "--output-dir", str(args.split_dir),
            "--seed", str(args.seed), "--group-by", "kind-and-dimension",
        ]
        print("$ " + " ".join(cmd))
        subprocess.run(cmd, check=True)

    def percentile(values: list[int], q: float) -> int:
        if not values:
            return 0
        ordered = sorted(values)
        return ordered[min(len(ordered) - 1, int(len(ordered) * q))]

    lines = [
        "# Корпус v14 — отчёт сборки",
        "",
        f"Инструмент: `tools/build_corpus_v14.py` · сид: {args.seed} · "
        f"компактность: {'off' if args.no_compact else 'on'}",
        "",
        "## Состав",
        "",
        "| что | строк |",
        "|---|---:|",
        f"| база (после лёгкой чистки) | {n_base} |",
        f"| conv-пары «текст без размеров» | {len(generated)} |",
        f"| **combined_v14** | **{total}** |",
        f"| combined_v14_lm (voxel+wire, вне сплита sketch/brep/assembly) | {n_lm} |",
        f"| sketch/brep/assembly исключены из LM-сплита | {total - n_lm} |",
        "",
        f"- прототипов спарено: {len(selected)} (voxel+wire), формулировок на прототип: {args.variants * 2}",
        f"- семейств затронуто: {len(per_origin)}",
        f"- p50 длины кода: {percentile(lengths_before, 0.5)} → {percentile(lengths_after, 0.5)} символов",
        f"- p99 длины кода: {percentile(lengths_before, 0.99)} → {percentile(lengths_after, 0.99)} символов",
        "",
        "## Слои базы",
        "",
        "| слой | строк |",
        "|---|---:|",
    ]
    for layer, count in layer_counts.most_common():
        lines.append(f"| {layer} | {count} |")
    lines += [
        "",
        "## Заметки",
        "",
        "- Conv-пары намеренно НЕ содержат ни одного размера в тексте: масштаб обязан",
        "  течь через `[SPECS]` (compose из `verification.target_bbox`). Легаси `conv_*`",
        "  добавляли размеры обратно в текст — это и было причиной conv 0/6.",
        "- Комментарии в коде не влияют на геометрию; `code_sha256` пересчитан, CAD-метрики",
        "  (`actual_bbox`, `volume_mm3`, `validation_runtime`) остаются валидными.",
        "- `splits_v14` собран из LM-подмножества: sketch/brep/assembly не попадают в обучение",
        "  (`src/model/spatial_stack.py`: слой необучаем).",
    ]
    args.report.parent.mkdir(parents=True, exist_ok=True)
    args.report.write_text("\n".join(lines) + "\n", encoding="utf-8")
    print(f"отчёт: {args.report}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
