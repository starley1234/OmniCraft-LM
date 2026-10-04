"""End-to-end for tools/clean_corpus_v10.py on a synthetic mini-corpus (no torch needed)."""

from __future__ import annotations

import csv
import hashlib
import json
import os
import subprocess
import sys
from pathlib import Path

REPO = Path(__file__).resolve().parents[1]
TOOL = REPO / "tools" / "clean_corpus_v10.py"
SPLITTER = REPO / "tools" / "split_dataset.py"

FAMILIES = ("flanges", "para1", "trusses")


def _row(index: int) -> dict:
    family = FAMILIES[index % len(FAMILIES)]
    x, y, z = 30 + 3 * index, 40 + 3 * index, 10 + index
    code = f"$fn = 32;\ncube([{x}, {y}, {z}]);\n"
    return {
        "id": f"test_{index:03d}",
        "layer": "voxel",
        "prompts": {"en": f"{family} sample number {index}, {x} by {y} by {z} mm"},
        "images": [],
        "code": code,
        "verification": {
            "target_bbox": [float(x), float(y), float(z)],
            "actual_bbox": [float(x), float(y), float(z)],
            "bbox_relative_error": 0.0,
            "volume_mm3": float(x * y * z),
            "euler_characteristic": 2,
            "holes_count": 0,
            "is_watertight": True,
            "components_count": 1,
            "validation_status": "openscad_manifold",
            "validation_backend": "openscad-manifold",
            "accepted": True,
            "validation_error": None,
        },
        "auxiliary_ground_truth": {"nodes": [], "edges": []},
        "metadata": {
            "origin": family,
            "kind": family,
            "code_sha256": hashlib.sha256(code.encode("utf-8")).hexdigest(),
            "validation_runtime": {
                "backend": "openscad-manifold",
                "openscad_version": "2025.12.17",
                "max_bbox_relative_error": 0.15,
                "max_volume_relative_error": 0.2,
            },
        },
    }


def _write_jsonl(path: Path, rows: list[dict]) -> None:
    with path.open("w", encoding="utf-8", newline="\n") as stream:
        for row in rows:
            stream.write(json.dumps(row, ensure_ascii=False) + "\n")


def _setup(tmp_path: Path) -> dict:
    rows = [_row(index) for index in range(16)]
    corpus = tmp_path / "combined_v9_fixed.jsonl"
    _write_jsonl(corpus, rows)
    old_splits = tmp_path / "splits_v9_fixed"
    subprocess.run(
        [sys.executable, str(SPLITTER), "--input", str(corpus), "--output-dir", str(old_splits),
         "--seed", "7", "--train-ratio", "1.0", "--validation-ratio", "0.0", "--test-ratio", "0.0"],
        check=True, capture_output=True, text=True, encoding="utf-8", errors="replace", cwd=REPO,
    )
    # 5 bad ids in-corpus, one duplicate line (must dedup), one ghost id (must not crash)
    bad = rows[0], rows[3], rows[7], rows[11], rows[14]
    with (tmp_path / "candidates.csv").open("w", encoding="utf-8", newline="") as stream:
        writer = csv.writer(stream)
        writer.writerow(["id", "origin", "style", "stated_bbox", "target_bbox", "rel_err"])
        for row in bad:
            writer.writerow([row["id"], row["metadata"]["origin"], "conv_ru",
                             "[100.0, 100.0, 100.0]", json.dumps(row["verification"]["target_bbox"]), "1.67"])
        writer.writerow([rows[3]["id"], "para1", "free_en", "[20, 20, 5]", "[90, 90, 9]", "7.71"])
        writer.writerow(["ghost_999", "para1", "en", "[1, 1, 1]", "[2, 2, 2]", "1.0"])
    return {
        "corpus": corpus, "splits": old_splits, "candidates": tmp_path / "candidates.csv",
        "bad_ids": [row["id"] for row in bad],
    }


def _run(env: dict, tmp_path: Path, extra: list[str] = ()) -> subprocess.CompletedProcess:
    return subprocess.run(
        [sys.executable, str(TOOL),
         "--candidates", str(env["candidates"]),
         "--corpus", str(env["corpus"]),
         "--splits", str(env["splits"]),
         "--verdict", str(tmp_path / "verdicts.csv"),
         "--out-corpus", str(tmp_path / "combined_v10.jsonl"),
         "--new-splits", str(tmp_path / "splits_v10"),
         "--report", str(tmp_path / "DELETION_REPORT.md"),
         "--seed", "7", "--train-ratio", "1.0", "--validation-ratio", "0.0", "--test-ratio", "0.0",
         *extra],
        capture_output=True, text=True, encoding="utf-8", errors="replace",
        env={**os.environ, "PYTHONIOENCODING": "utf-8"}, cwd=REPO,
    )


def _ids(path: Path) -> list[str]:
    return [json.loads(line)["id"] for line in path.open(encoding="utf-8") if line.strip()]


def test_dry_run_writes_nothing_but_report(tmp_path: Path) -> None:
    env = _setup(tmp_path)
    result = _run(env, tmp_path, ["--dry-run"])
    assert result.returncode == 0, result.stdout + result.stderr
    assert not (tmp_path / "combined_v10.jsonl").exists()
    assert not (tmp_path / "splits_v10").exists()
    assert not (tmp_path / "combined_v9_fixed.backup.jsonl").exists()
    report = (tmp_path / "DELETION_REPORT.md").read_text(encoding="utf-8")
    assert "DRY RUN" in report and "5" in report


def test_clean_corpus_end_to_end(tmp_path: Path) -> None:
    env = _setup(tmp_path)
    result = _run(env, tmp_path)
    assert result.returncode == 0, result.stdout + result.stderr

    # шаг 1: бэкапы
    assert (tmp_path / "combined_v9_fixed.backup.jsonl").read_bytes() == env["corpus"].read_bytes()
    assert (tmp_path / "splits_v9_fixed.backup" / "train.jsonl").is_file()

    # шаг 2: вердикт-CSV = все кандидаты bad, дедуп дубликата
    with (tmp_path / "verdicts.csv").open(encoding="utf-8", newline="") as stream:
        verdicts = list(csv.DictReader(stream))
    assert len(verdicts) == 6 and all(row["verdict"] == "bad" for row in verdicts)
    assert [row["id"] for row in verdicts].count(env["bad_ids"][0]) == 1

    # шаг 3: новый корпус меньше ровно на 5, исходник нетронут
    assert _ids(env["corpus"]).count("ghost_999") == 0
    kept = _ids(tmp_path / "combined_v10.jsonl")
    assert len(kept) == 11 and not set(env["bad_ids"]) & set(kept)

    # шаг 4/5: сплит без кандидатов, дельта train совпадает, отчёт зелёный
    train_ids = _ids(tmp_path / "splits_v10" / "train.jsonl")
    assert len(train_ids) == 11 and not set(env["bad_ids"]) & set(train_ids)
    report = (tmp_path / "DELETION_REPORT.md").read_text(encoding="utf-8")
    assert "удалено строк: **5**" in report and "- [ ]" not in report
    for family in FAMILIES:
        assert family in report  # таблица «по семействам»


def test_rerun_without_yes_is_refused(tmp_path: Path) -> None:
    env = _setup(tmp_path)
    assert _run(env, tmp_path).returncode == 0
    second = _run(env, tmp_path)
    assert second.returncode != 0
    assert "бэкап" in (second.stdout + second.stderr).lower()
    # данные не испорчены повторной попыткой
    assert len(_ids(tmp_path / "combined_v10.jsonl")) == 11
