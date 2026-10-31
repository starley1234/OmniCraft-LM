"""Применяет вердикты проверяющего агента к корпусу: выкидывает строки `bad` по `id`.

Вход — `verdict_template.csv`, который сгенерировал `tools/render_family_previews.py`
(колонки `id`, `verdict`, `reason`, ...), где `verdict` заполнен как `ok`/`bad`.
Выход — отфильтрованный JSONL с сохранением исходных байт строк + отчёт.

    python tools/filter_corpus_by_verdict.py \
        --verdict data/previews/families_v9/verdict_template.csv \
        --input   data/processed/combined_v9_fixed.jsonl \
        --out     data/processed/combined_v9_fixed.cleaned.jsonl

Политика: строка удаляется, если её `id` помечен `bad` (или любым значением из
`--bad`, без учёта регистра). Строки, которых нет в вердикте, по умолчанию
сохраняются (`--drop-unlisted` инвертирует). Конфликт вердиктов по одному id
трактуется консервативно — как `bad`.
"""
from __future__ import annotations

import argparse
import csv
import json
import sys
from collections import Counter, defaultdict
from pathlib import Path

if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")

DEFAULT_BAD = "bad,fail,no,false,0,reject"


def load_verdicts(path: Path, bad_values: set[str]) -> tuple[dict[str, str], dict[str, str], list[str]]:
    """Возвращает (решения id->raw_verdict, причины id->reason, предупреждения)."""
    decisions: dict[str, str] = {}
    reasons: dict[str, str] = {}
    warnings: list[str] = []
    with path.open(encoding="utf-8-sig", newline="") as handle:
        reader = csv.DictReader(handle)
        if "id" not in (reader.fieldnames or []):
            raise ValueError(f"{path}: нет колонки 'id' (есть: {reader.fieldnames})")
        for line_number, row in enumerate(reader, start=2):
            sample_id = (row.get("id") or "").strip()
            if not sample_id:
                continue
            verdict = (row.get("verdict") or "").strip().lower()
            is_bad = verdict in bad_values
            if sample_id in decisions and decisions[sample_id] != ("bad" if is_bad else "ok"):
                warnings.append(f"{path}:{line_number}: конфликт вердиктов для {sample_id!r} → bad")
                decisions[sample_id] = "bad"
                reasons[sample_id] = "conflict"
                continue
            decisions[sample_id] = "bad" if is_bad else "ok"
            if is_bad:
                reasons[sample_id] = (row.get("reason") or "").strip()
    return decisions, reasons, warnings


def family_of(row: dict) -> str:
    metadata = row.get("metadata") or {}
    return str(metadata.get("origin") or metadata.get("kind") or "?")


def apply_filter(
    corpus: Path,
    out_path: Path,
    decisions: dict[str, str],
    drop_unlisted: bool,
) -> dict:
    total = kept = removed = 0
    missing_id = 0
    removed_by_family: Counter[str] = Counter()
    unlisted_by_family: Counter[str] = Counter()
    removed_ids: list[str] = []

    temporary = out_path.with_name(out_path.name + ".tmp")
    out_path.parent.mkdir(parents=True, exist_ok=True)
    try:
        with corpus.open(encoding="utf-8-sig", newline="") as source, \
                temporary.open("w", encoding="utf-8", newline="") as sink:
            for line in source:
                if not line.strip():
                    continue
                total += 1
                row = json.loads(line)
                sample_id = row.get("id")
                if not sample_id:
                    missing_id += 1
                decision = decisions.get(sample_id)
                if decision is None:
                    unlisted_by_family[family_of(row)] += 1
                    drop = drop_unlisted
                else:
                    drop = decision == "bad"
                if drop:
                    removed += 1
                    removed_by_family[family_of(row)] += 1
                    if sample_id:
                        removed_ids.append(sample_id)
                else:
                    kept += 1
                    sink.write(line if line.endswith("\n") else line + "\n")
        temporary.replace(out_path)
    finally:
        temporary.unlink(missing_ok=True)

    return {
        "input": str(corpus),
        "output": str(out_path),
        "total": total,
        "kept": kept,
        "removed": removed,
        "rows_without_id": missing_id,
        "drop_unlisted": drop_unlisted,
        "removed_by_family": dict(removed_by_family.most_common()),
        "unlisted_by_family": dict(unlisted_by_family.most_common()),
        "removed_ids": removed_ids,
    }


def write_report(report: dict, json_path: Path, md_path: Path, reasons: dict[str, str], warnings: list[str]) -> None:
    json_path.parent.mkdir(parents=True, exist_ok=True)
    json_path.write_text(json.dumps({**report, "warnings": warnings}, ensure_ascii=False, indent=2), encoding="utf-8")

    with md_path.open("w", encoding="utf-8", newline="\n") as handle:
        handle.write("# Отчёт чистки корпуса по вердиктам\n\n")
        handle.write(f"- вход: `{report['input']}`\n")
        handle.write(f"- выход: `{report['output']}`\n")
        handle.write(f"- было строк: {report['total']} · осталось: {report['kept']} · удалено: {report['removed']}\n")
        handle.write(f"- строк без `id`: {report['rows_without_id']} · политика для неразмеченных: "
                     f"{'удалять' if report['drop_unlisted'] else 'сохранять'}\n")
        if warnings:
            handle.write(f"- предупреждений: {len(warnings)}\n")
        handle.write("\n## Удалено по семействам\n\n")
        if report["removed_by_family"]:
            handle.write("| семейство | удалено |\n|---|---:|\n")
            for family, count in report["removed_by_family"].items():
                handle.write(f"| {family} | {count} |\n")
        else:
            handle.write("_ничего не удалено_\n")
        handle.write("\n## Удалённые id\n\n")
        for sample_id in report["removed_ids"]:
            reason = reasons.get(sample_id, "")
            handle.write(f"- `{sample_id}`" + (f" — {reason}" if reason else "") + "\n")


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("--verdict", type=Path, required=True, help="CSV с колонками id,verdict[,reason]")
    parser.add_argument("--input", type=Path, required=True, help="исходный корпус JSONL")
    parser.add_argument("--out", type=Path, required=True, help="отфильтрованный JSONL")
    parser.add_argument("--report", type=Path, default=None, help="JSON-отчёт (по умолчанию <out>.report.json)")
    parser.add_argument("--report-md", type=Path, default=None, help="Markdown-отчёт (по умолчанию <out>.report.md)")
    parser.add_argument("--bad", default=DEFAULT_BAD, help="значения verdict, считающиеся плохими (через запятую)")
    parser.add_argument("--drop-unlisted", action="store_true", help="удалять строки, которых не было в вердикте")
    parser.add_argument("--dry-run", action="store_true", help="не писать выход, только показать отчёт")
    args = parser.parse_args()

    bad_values = {v.strip().lower() for v in args.bad.split(",") if v.strip()}
    for path in (args.verdict, args.input):
        if not path.exists():
            print(f"[MISSING] {path} не найден")
            return 4

    try:
        decisions, reasons, warnings = load_verdicts(args.verdict, bad_values)
    except ValueError as exc:
        print(f"[USAGE] {exc}")
        return 2
    for warning in warnings:
        print(f"[WARN] {warning}")

    marked_bad = sum(1 for value in decisions.values() if value == "bad")
    print(f"вердиктов: {len(decisions)} (bad: {marked_bad}) из {args.verdict}")
    if marked_bad == 0:
        print("[WARN] ни одного bad — фильтр ничего не удалит (проверьте колонку verdict)")

    report = apply_filter(args.input, args.out, decisions, args.drop_unlisted)
    json_path = args.report or args.out.with_suffix(args.out.suffix + ".report.json")
    md_path = args.report_md or args.out.with_suffix(args.out.suffix + ".report.md")
    write_report(report, json_path, md_path, reasons, warnings)

    if args.dry_run:
        report["output"] = "(dry-run: не записан)"
        json_path.write_text(json.dumps({**report, "warnings": warnings}, ensure_ascii=False, indent=2), encoding="utf-8")

    print(f"было {report['total']} → осталось {report['kept']}, удалено {report['removed']}")
    if report["removed_by_family"]:
        top = ", ".join(f"{k}={v}" for k, v in list(report["removed_by_family"].items())[:8])
        print(f"удалено по семействам: {top}")
    print(f"отчёт: {json_path}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
