"""Чистка корпуса от кандидатов ре-аудита [SPECS]: шаги 1–5 брифа одним прогоном.

Строго по шагам:
  1. бэкапы `combined_v9_fixed.jsonl` → `combined_v9_fixed.backup.jsonl` и
     `splits_v9_fixed/` → `splits_v9_fixed.backup/` (sha256 сверка);
  2. вердикт-CSV из `candidates.csv` (все id = bad) в формате
     `tools/filter_corpus_by_verdict.py` (колонки id,verdict,reason);
  3. фильтр корпуса (исходник НЕ перезаписывается: выход — новый файл);
  4. пересборка сплита (`tools/split_dataset.py`, тот же seed/политика,
     что у splits_v9_fixed) → `splits_v10`;
  5. проверки (0 пересечений id с candidates.csv; арифметика строк; дельта
     train/val/test; полнота сплита) и отчёт `DELETION_REPORT.md`.

Инструмент stdlib-only (ни torch, ни pydantic не импортируются): тяжёлые
файлы читаются потоково. `--dry-run` считает шаги 2–3 без записи чего-либо
помимо отчёта в runs/. Повторный запуск без `--yes` безопасен: существующие
бэкапы и входы не затираются, прогон прерывается.

    python tools/clean_corpus_v10.py [--dry-run] [--yes]

Скрипт НЕ трогает `src/training/*`, `tools/train_spatial.py`, `wsl_train*.sh`
и held-out наборы; обучение перезапускает владелец.
"""
from __future__ import annotations

import argparse
import csv
import hashlib
import json
import shutil
import subprocess
import sys
from collections import Counter
from datetime import date
from pathlib import Path

REPO = Path(__file__).resolve().parents[1]
if str(REPO) not in sys.path:
    sys.path.insert(0, str(REPO))


class StepError(RuntimeError):
    pass


# ------------------------------------------------------------------ helpers

def _sha256(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as stream:
        for chunk in iter(lambda: stream.read(1 << 20), b""):
            digest.update(chunk)
    return digest.hexdigest()


def _count_lines(path: Path) -> int:
    total = 0
    with path.open(encoding="utf-8-sig", newline="") as stream:
        for line in stream:
            if line.strip():
                total += 1
    return total


def _iter_ids(path: Path) -> list[str]:
    ids: list[str] = []
    with path.open(encoding="utf-8", newline="") as stream:
        for line_number, line in enumerate(stream, start=1):
            if not line.strip():
                continue
            try:
                row = json.loads(line)
            except json.JSONDecodeError as exc:
                raise StepError(f"{path}:{line_number}: битая JSON-строка: {exc}") from exc
            sample_id = row.get("id")
            if not isinstance(sample_id, str) or not sample_id:
                raise StepError(f"{path}:{line_number}: строка без id")
            ids.append(sample_id)
    return ids


def _run(cmd: list[str]) -> str:
    print("$ " + " ".join(str(part) for part in cmd))
    result = subprocess.run(cmd, capture_output=True, text=True, encoding="utf-8", errors="replace")
    output = (result.stdout or "") + (result.stderr or "")
    tail = "\n".join(output.splitlines()[-12:])
    if result.returncode != 0:
        raise StepError(f"шаг завершился с rc={result.returncode}:\n{tail}")
    print(tail)
    return output


# ------------------------------------------------------------------ steps

def read_candidates(path: Path) -> tuple[list[dict[str, str]], int]:
    """candidates.csv ре-аудита → (дедуплицированные строки, число повторов id)."""
    with path.open(encoding="utf-8-sig", newline="") as stream:
        reader = csv.DictReader(stream)
        fields = reader.fieldnames or []
        if "id" not in fields:
            raise StepError(f"{path}: нет колонки 'id' (есть: {fields})")
        seen: set[str] = set()
        duplicates = 0
        rows: list[dict[str, str]] = []
        for row in reader:
            sample_id = (row.get("id") or "").strip()
            if not sample_id:
                continue
            if sample_id in seen:
                duplicates += 1
                continue
            seen.add(sample_id)
            rows.append({key: (value or "").strip() for key, value in row.items() if key})
    return rows, duplicates


def write_verdict_csv(candidates: list[dict[str, str]], out: Path) -> None:
    out.parent.mkdir(parents=True, exist_ok=True)
    with out.open("w", encoding="utf-8", newline="") as stream:
        writer = csv.writer(stream)
        writer.writerow(["id", "verdict", "reason"])
        for row in candidates:
            reason_bits = []
            for column, label in (("rel_err", "rel_err"), ("stated_bbox", "stated"), ("target_bbox", "target")):
                if row.get(column):
                    reason_bits.append(f"{label}={row[column]}")
            for column in ("origin", "style"):
                if row.get(column):
                    reason_bits.append(f"{column}={row[column]}")
            writer.writerow([row["id"], "bad", "; ".join(reason_bits)])


def backup_file(source: Path, target: Path, force: bool) -> None:
    if not source.is_file():
        raise StepError(f"нет исходника бэкапа: {source}")
    if target.exists():
        if not force:
            raise StepError(f"бэкап уже существует: {target} (перезапись — только с --yes)")
    shutil.copy2(source, target)
    if _sha256(source) != _sha256(target):
        raise StepError(f"sha256 бэкапа не совпадает с исходником: {target}")


def backup_dir(source: Path, target: Path, force: bool) -> None:
    if not source.is_dir():
        raise StepError(f"нет исходного каталога: {source}")
    if target.exists():
        if not force:
            raise StepError(f"бэкап уже существует: {target} (перезапись — только с --yes)")
        shutil.rmtree(target)
    shutil.copytree(source, target)
    src = sorted(p.name for p in source.iterdir())
    dst = sorted(p.name for p in target.iterdir())
    if src != dst:
        raise StepError(f"бэкап каталога неполон: {target} ({dst} != {src})")


def prepare_output(path: Path, force: bool, what: str) -> None:
    if path.exists():
        if not force:
            raise StepError(f"{what} уже существует: {path} (перезапись — только с --yes)")
        if path.is_dir():
            shutil.rmtree(path)
        else:
            path.unlink()


# ------------------------------------------------------------------ main

def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("--candidates", type=Path, default=REPO / "runs/reaudit_specs/candidates.csv")
    parser.add_argument("--corpus", type=Path, default=REPO / "data/processed/combined_v9_fixed.jsonl")
    parser.add_argument("--splits", type=Path, default=REPO / "data/processed/splits_v9_fixed")
    parser.add_argument("--verdict", type=Path, default=REPO / "data/processed/verdicts_reaudit_v10.csv")
    parser.add_argument("--out-corpus", type=Path, default=REPO / "data/processed/combined_v10.jsonl")
    parser.add_argument("--new-splits", type=Path, default=REPO / "data/processed/splits_v10")
    parser.add_argument("--report", type=Path, default=REPO / "runs/reaudit_specs/DELETION_REPORT.md")
    parser.add_argument("--filter-json", type=Path, default=None,
                        help="JSON-отчёт фильтра (по умолчанию <report>.filter.json)")
    parser.add_argument("--seed", type=int, default=1234, help="seed сплита (как у splits_v9_fixed)")
    parser.add_argument("--train-ratio", type=float, default=None, help="переопределить долю train (для тестов)")
    parser.add_argument("--validation-ratio", type=float, default=None)
    parser.add_argument("--test-ratio", type=float, default=None)
    parser.add_argument("--yes", action="store_true", help="разрешить перезапись бэкапов и входов")
    parser.add_argument("--dry-run", action="store_true", help="без записи: бэкапы/корпус/сплит не трогаем")
    return parser


def main(argv: list[str] | None = None) -> int:
    args = build_parser().parse_args(argv)
    if hasattr(sys.stdout, "reconfigure"):
        sys.stdout.reconfigure(encoding="utf-8", errors="replace")

    # пре-воходы
    for path, what in ((args.candidates, "кандидаты"), (args.corpus, "корпус"), (args.splits, "сплит")):
        if not path.exists():
            print(f"[MISSING] {what}: {path}", file=sys.stderr)
            return 4
    if args.out_corpus.resolve() == args.corpus.resolve():
        print("[USAGE] --out-corpus совпадает с --corpus: исходник перезаписывать нельзя", file=sys.stderr)
        return 2

    candidates, duplicate_rows = read_candidates(args.candidates)
    if not candidates:
        print("[ABORT] candidates.csv пуст — удалять нечего", file=sys.stderr)
        return 2
    candidate_ids = [row["id"] for row in candidates]
    corpus_ids = _iter_ids(args.corpus)
    corpus_id_set = set(corpus_ids)
    if len(corpus_ids) != len(corpus_id_set):
        print(f"[ABORT] в корпусе {len(corpus_ids)} строк, но id всего {len(corpus_id_set)} — дубликаты id",
              file=sys.stderr)
        return 2
    known = [sample_id for sample_id in candidate_ids if sample_id in corpus_id_set]
    unknown = len(candidate_ids) - len(known)

    old_counts = {"total": len(corpus_ids)}
    split_id_sets: dict[str, list[str]] = {}
    for name in ("train", "validation", "test"):
        split_file = args.splits / f"{name}.jsonl"
        split_id_sets[name] = _iter_ids(split_file) if split_file.is_file() else []
        old_counts[name] = len(split_id_sets[name])

    checks: list[tuple[str, bool, str]] = []
    # семейства удалённых — из самого candidates.csv (колонка origin), без чтения корпуса целиком
    removed_by_origin = Counter(row.get("origin", "?") for row in candidates if row["id"] in corpus_id_set)

    if args.dry_run:
        checks.append(("кандидаты: дедуп по id", True,
                       f"уникальных {len(candidate_ids)}, повторов отброшено {duplicate_rows}"))
        checks.append(("все id кандидатов есть в корпусе", unknown == 0,
                       f"известны {len(known)}, не найдено {unknown}"))
        print("[DRY-RUN] записи не производились")
        lines = ["# Отчёт чистки корпуса (DRY RUN) — " + date.today().isoformat(), "",
                 f"- кандидаты: `{args.candidates}` — уникальных id: {len(candidate_ids)}",
                 f"- корпус: `{args.corpus}` — строк: {old_counts['total']}",
                 f"- id кандидатов найдутся в корпусе: {len(known)} (не найдутся: {unknown})",
                 "", "## Удаление по семействам (ожидание)", "",
                 "| семейство | строк |", "|---|---:|"]
        for family, count in removed_by_origin.most_common():
            lines.append(f"| {family} | {count} |")
        args.report.parent.mkdir(parents=True, exist_ok=True)
        args.report.write_text("\n".join(lines) + "\n", encoding="utf-8")
        print(f"отчёт: {args.report}")
        return 0

    # --- шаг 1: бэкапы
    backup_corpus = args.corpus.with_name(args.corpus.stem + ".backup.jsonl")
    backup_splits = args.splits.with_name(args.splits.name + ".backup")
    backup_file(args.corpus, backup_corpus, args.yes)
    backup_dir(args.splits, backup_splits, args.yes)
    checks.append(("шаг 1: бэкапы созданы и сверены по sha256/copy", True,
                   f"{backup_corpus.name}; {backup_splits.name}/"))

    # --- шаг 2: вердикт-CSV
    prepare_output(args.verdict, args.yes, "вердикт-CSV")
    write_verdict_csv(candidates, args.verdict)
    checks.append(("шаг 2: вердикт-CSV собран (все bad)", True, str(args.verdict)))

    # --- шаг 3: фильтр
    prepare_output(args.out_corpus, args.yes, "новый корпус")
    filter_json = args.filter_json or args.report.with_name("clean_filter_report.json")
    prepare_output(filter_json, True, "отчёт фильтра")
    _run([sys.executable, str(REPO / "tools/filter_corpus_by_verdict.py"),
          "--verdict", str(args.verdict),
          "--input", str(args.corpus),
          "--out", str(args.out_corpus),
          "--report", str(filter_json),
          "--report-md", str(args.report.with_name("clean_filter_report.md"))])
    filter_report = json.loads(filter_json.read_text(encoding="utf-8"))
    removed = int(filter_report["removed"])
    checks.append(("шаг 3: фильтр удалил ровно множество кандидатов корпуса",
                   removed == len(known), f"removed={removed}, ожидалось={len(known)}"))
    checks.append(("шаг 3: арифметика фильтра", filter_report["total"] == filter_report["kept"] + removed,
                   f"{filter_report['total']} = {filter_report['kept']} + {removed}"))

    # --- шаг 4: сплит
    prepare_output(args.new_splits, args.yes, "новый сплит")
    split_cmd = [sys.executable, str(REPO / "tools/split_dataset.py"),
                 "--input", str(args.out_corpus),
                 "--output-dir", str(args.new_splits),
                 "--seed", str(args.seed),
                 "--group-by", "kind-and-dimension"]
    for flag, value in (("--train-ratio", args.train_ratio), ("--validation-ratio", args.validation_ratio),
                        ("--test-ratio", args.test_ratio)):
        if value is not None:
            split_cmd += [flag, str(value)]
    _run(split_cmd)

    # --- шаг 5: проверки
    new_ids = _iter_ids(args.out_corpus)
    new_split_sets = {}
    for name in ("train", "validation", "test"):
        split_file = args.new_splits / f"{name}.jsonl"
        new_split_sets[name] = set(_iter_ids(split_file)) if split_file.is_file() else set()
    candidate_id_set = set(candidate_ids)
    train_overlap = sorted(candidate_id_set & new_split_sets["train"])
    checks.append(("шаг 5: 0 пересечений id нового train.jsonl с candidates.csv", not train_overlap,
                   f"нарушений {len(train_overlap)}: {train_overlap[:5]}"))
    delta = old_counts["total"] - len(new_ids)
    checks.append(("шаг 5: строк ровно на удалённое число меньше", delta == removed,
                   f"{old_counts['total']} → {len(new_ids)} (Δ={delta}, removed={removed})"))
    for name in ("train", "validation", "test"):
        gone = len([sample_id for sample_id in split_id_sets[name] if sample_id in candidate_id_set])
        new_count = len(new_split_sets[name])
        old_count = old_counts[name]
        checks.append((f"шаг 5: {name}: −{gone} кандидатов, без потерь лишнего",
                       new_count == old_count - gone, f"{old_count} → {new_count} (ожидалось −{gone})"))
    split_total = sum(len(value) for value in new_split_sets.values())
    checks.append(("шаг 5: train+val+test == весь новый корпус", split_total == len(new_ids),
                   f"{split_total} vs {len(new_ids)}"))

    # --- отчёт
    lines = [
        "# Отчёт чистки корпуса по кандидатам ре-аудита [SPECS]",
        "",
        f"Дата: {date.today().isoformat()} · инструмент: `tools/clean_corpus_v10.py` · "
        f"режим: полная сборка",
        "",
        "## Было/стало",
        "",
        "| метрика | до | после |",
        "|---|---:|---:|",
        f"| корпус, строк | {old_counts['total']} | {len(new_ids)} |",
        f"| train | {old_counts['train']} | {len(new_split_sets['train'])} |",
        f"| validation | {old_counts['validation']} | {len(new_split_sets['validation'])} |",
        f"| test | {old_counts['test']} | {len(new_split_sets['test'])} |",
        "",
        f"- удалено строк: **{removed}** (кандидатов в csv: {len(candidate_ids)} unique; "
        f"вне корпуса не найдено: {unknown})",
        f"- вердикт-файл: `{args.verdict}` (все кандидаты помечены `bad`, дедуп по id)",
        f"- новый корпус: `{args.out_corpus}` · новый сплит: `{args.new_splits}`",
        f"- бэкапы: `{backup_corpus}` · `{backup_splits}/`",
        "",
        "## Удалено по семействам",
        "",
        "| семейство | удалено строк |",
        "|---|---:|",
    ]
    for family, count in Counter(filter_report.get("removed_by_family", {})).most_common():
        lines.append(f"| {family} | {count} |")
    lines += ["", "## Проверки", ""]
    all_ok = True
    for name, ok, detail in checks:
        all_ok &= ok
        lines.append(f"- [{'x' if ok else ' '}] {name} — {detail}")
    lines += [
        "",
        "## Заметки",
        "",
        "- Held-out-наборы (`optional_data/data/heldout_eval.jsonl`, 42 промпта) НЕ тронуты: "
        "чистка относится к обучающему корпусу; при желании переснимите базы eval отдельно.",
        "- Источник кандидатов — `tools/reaudit_specs_corpus.py`: минер не идеален на составных "
        "высотах/выводных Ø (бэклог §7 отчёта), т.е. часть удалённых строк могла быть исправна. "
        "Это осознанная цена брифа («все id = bad»); при точечном возврате семейств фильтруйте "
        "по `clean_filter_report.md` (список удалённых id) и `--verdict`-режимом.",
        f"- Полный список удалённых id с причинами: `{args.report.with_name('clean_filter_report.md')}` "
        f"и `{filter_json}`.",
        "- Обучение и сплиты на этой машине не запускались; чейн v12 перезапускает владелец.",
    ]
    args.report.parent.mkdir(parents=True, exist_ok=True)
    args.report.write_text("\n".join(lines) + "\n", encoding="utf-8")

    print(f"\nитог: удалено {removed} строк ({old_counts['total']} → {len(new_ids)}); "
          f"train {old_counts['train']} → {len(new_split_sets['train'])}")
    print(f"отчёт: {args.report}")
    if not all_ok:
        print("[FAIL] есть проваленные проверки — см. DELETION_REPORT.md", file=sys.stderr)
        return 1
    print("[OK] все проверки зелёные")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
