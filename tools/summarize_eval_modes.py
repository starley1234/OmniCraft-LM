"""Сводка eval-прогонов по режимам ``[SPECS]`` (JSONL -> markdown-таблица).

Читает файлы ``<tag>_<mode>.jsonl``, которые пишет
``tools/evaluate_generation.py --specs-mode auto|mined|none`` (см. также
``tools/wsl_diag_wire_scale.sh``), и печатает сравнение по наборам:

* compile / watertight — механика;
* bbox ≤15 % и медиана относительной ошибки — габарит;
* медианный коэффициент «факт / эталон» — систематический недо/перебор масштаба
  (у wire-слоя ожидается >1 при игнорировании блока).

    python tools/summarize_eval_modes.py data/processed/diag_wire_scale
    python tools/summarize_eval_modes.py data/processed/diag_wire_scale --out runs/diag_wire_scale/REPORT.md
"""

from __future__ import annotations

import argparse
import json
import statistics
import sys
from pathlib import Path


def load(path: Path) -> list[dict]:
    rows = []
    for line in path.read_text(encoding="utf-8").splitlines():
        if line.strip():
            rows.append(json.loads(line))
    return rows


def _expected(row: dict) -> list[float] | None:
    raw = row.get("expected_bbox_mm")
    if isinstance(raw, list) and len(raw) == 3:
        try:
            values = [float(v) for v in raw]
        except (TypeError, ValueError):
            return None
        return values if all(v > 0 for v in values) else None
    return None


def _scale_ratio(row: dict) -> float | None:
    """max(actual/expected) over axes — 1.0 means the size is right."""
    expected = _expected(row)
    actual = row.get("actual_bbox")
    if not expected or not isinstance(actual, list) or len(actual) != 3:
        return None
    try:
        return max(float(a) / e for a, e in zip(actual, expected))
    except (TypeError, ValueError, ZeroDivisionError):
        return None


def summarize(rows: list[dict], tolerance: float = 0.15) -> dict:
    total = len(rows)
    compiled = [row for row in rows if row.get("compiled")]
    errors = [row["bbox_relative_error"] for row in compiled if row.get("bbox_relative_error") is not None]
    hits = sum(1 for err in errors if err <= tolerance)
    ratios = [r for r in (_scale_ratio(row) for row in compiled) if r is not None]
    return {
        "total": total,
        "compiled": len(compiled),
        "watertight": sum(1 for row in compiled if row.get("is_watertight")),
        "bbox_scored": len(errors),
        "bbox_hits": hits,
        "bbox_median": statistics.median(errors) if errors else None,
        "ratio_median": statistics.median(ratios) if ratios else None,
        "errors": errors,
    }


def fmt(value: float | None, digits: int = 3) -> str:
    return "—" if value is None else f"{value:.{digits}f}"


def parse_name(path: Path) -> tuple[str, str]:
    """``conv_gt_wire_mined.jsonl`` -> (``conv_gt_wire``, ``mined``)."""
    stem = path.stem
    for mode in ("mined", "none", "auto"):
        if stem.endswith(f"_{mode}"):
            return stem[: -len(mode) - 1], mode
    return stem, "auto"


def build_report(directory: Path, tolerance: float) -> str:
    runs: dict[str, dict[str, list[dict]]] = {}
    for path in sorted(directory.glob("*.jsonl")):
        tag, mode = parse_name(path)
        runs.setdefault(tag, {})[mode] = load(path)
    if not runs:
        raise SystemExit(f"no *.jsonl in {directory}")

    order = {mode: index for index, mode in enumerate(("auto", "mined", "none"))}
    lines = [
        "# Сводка режимов [SPECS]",
        "",
        f"Каталог: `{directory}` · порог габарита {tolerance:.0%}",
        "",
    ]
    for tag in sorted(runs):
        modes = sorted(runs[tag], key=lambda mode: order.get(mode, 99))
        lines.append(f"## {tag}")
        lines.append("")
        lines.append("| режим | строк | compile | watertight | bbox <=15% | медиана err | медиана факт/эталон |")
        lines.append("|---|---|---|---|---|---|---|")
        stats = {}
        for mode in modes:
            data = summarize(runs[tag][mode], tolerance)
            stats[mode] = data
            lines.append(
                f"| {mode} | {data['total']} | {data['compiled']} | {data['watertight']} | "
                f"{data['bbox_hits']}/{data['bbox_scored']} | {fmt(data['bbox_median'])} | "
                f"{fmt(data['ratio_median'], 2)} |"
            )
        lines.append("")
        if "auto" in stats and "none" in stats:
            delta = stats["auto"]["bbox_hits"] - stats["none"]["bbox_hits"]
            verdict = (
                "блок помогает" if delta > 0 else
                "блок не влияет" if delta == 0 else
                "блок мешает"
            )
            lines.append(
                f"**auto - none по попаданиям в габарит: {delta:+d}** → {verdict} "
                f"(compile: {stats['auto']['compiled'] - stats['none']['compiled']:+d})."
            )
            lines.append("")
        if "auto" in stats and "mined" in stats:
            delta = stats["mined"]["bbox_hits"] - stats["auto"]["bbox_hits"]
            lines.append(f"**цена ошибки минера (mined - auto): {delta:+d} попаданий в габарит.**")
            lines.append("")
    return "\n".join(lines) + "\n"


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("directory", type=Path, help="каталог с <tag>_<mode>.jsonl")
    parser.add_argument("--out", type=Path, default=None, help="куда записать markdown")
    parser.add_argument("--bbox-tolerance", type=float, default=0.15)
    args = parser.parse_args()
    report = build_report(args.directory, args.bbox_tolerance)
    # cp1251-консоль Windows не умеет часть символов: пишем utf-8 с заменой.
    if hasattr(sys.stdout, "reconfigure"):
        sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    sys.stdout.write(report)
    if args.out is not None:
        args.out.parent.mkdir(parents=True, exist_ok=True)
        args.out.write_text(report, encoding="utf-8", newline="\n")
        print(f"report: {args.out}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
