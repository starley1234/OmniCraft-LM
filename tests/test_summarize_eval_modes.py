"""Сводка eval-режимов ``[SPECS]`` (``tools/summarize_eval_modes.py``), без torch."""

from __future__ import annotations

import json
import sys
from pathlib import Path

TOOLS = Path(__file__).resolve().parents[1] / "tools"
if str(TOOLS) not in sys.path:
    sys.path.insert(0, str(TOOLS))

import summarize_eval_modes as sem  # noqa: E402


def write_run(directory: Path, tag: str, mode: str, rows: list[dict]) -> Path:
    path = directory / f"{tag}_{mode}.jsonl"
    path.write_text("".join(json.dumps(r, ensure_ascii=False) + "\n" for r in rows), encoding="utf-8")
    return path


def row(rid: str, *, compiled: bool, actual: list[float] | None, expected: list[float]) -> dict:
    record = {"id": rid, "expected_bbox_mm": expected, "compiled": compiled, "actual_bbox": actual}
    if compiled and actual is not None:
        record["bbox_relative_error"] = max(abs(a - e) / e for a, e in zip(actual, expected))
        record["is_watertight"] = True
    return record


def test_parse_name_splits_tag_and_mode() -> None:
    assert sem.parse_name(Path("conv_gt_wire_mined.jsonl")) == ("conv_gt_wire", "mined")
    assert sem.parse_name(Path("heldout_eval_none.jsonl")) == ("heldout_eval", "none")
    assert sem.parse_name(Path("heldout_eval_auto.jsonl")) == ("heldout_eval", "auto")


def test_summarize_counts_hits_and_scale_ratio() -> None:
    rows = [
        row("a", compiled=True, actual=[100, 100, 10], expected=[100, 100, 10]),
        row("b", compiled=True, actual=[200, 100, 10], expected=[100, 100, 10]),
        row("c", compiled=False, actual=None, expected=[100, 100, 10]),
    ]
    stats = sem.summarize(rows)
    assert stats["total"] == 3
    assert stats["compiled"] == 2
    assert stats["bbox_scored"] == 2
    assert stats["bbox_hits"] == 1
    assert stats["bbox_median"] == 0.5
    assert stats["ratio_median"] == 1.5


def test_block_helps_when_auto_beats_none(tmp_path: Path) -> None:
    good = [row("a", compiled=True, actual=[100, 100, 10], expected=[100, 100, 10])]
    bad = [row("a", compiled=True, actual=[200, 100, 10], expected=[100, 100, 10])]
    write_run(tmp_path, "heldout_eval", "auto", good)
    write_run(tmp_path, "heldout_eval", "none", bad)
    report = sem.build_report(tmp_path, 0.15)
    assert "| auto | 1 | 1 | 1 | 1/1 |" in report
    assert "| none | 1 | 1 | 1 | 0/1 |" in report
    assert "auto - none по попаданиям в габарит: +1** → блок помогает" in report


def test_block_is_neutral_when_modes_match(tmp_path: Path) -> None:
    same = [row("a", compiled=True, actual=[100, 100, 10], expected=[100, 100, 10])]
    write_run(tmp_path, "heldout_eval", "auto", same)
    write_run(tmp_path, "heldout_eval", "none", same)
    report = sem.build_report(tmp_path, 0.15)
    assert "блок не влияет" in report


def test_miner_cost_is_reported(tmp_path: Path) -> None:
    good = [row("a", compiled=True, actual=[100, 100, 10], expected=[100, 100, 10])]
    bad = [row("a", compiled=True, actual=[100, 100, 30], expected=[100, 100, 10])]
    write_run(tmp_path, "conv_gt_wire", "auto", good)
    write_run(tmp_path, "conv_gt_wire", "mined", bad)
    report = sem.build_report(tmp_path, 0.15)
    assert "цена ошибки минера (mined - auto): -1" in report


def test_rows_without_expected_are_not_scored(tmp_path: Path) -> None:
    rows = [{"id": "x", "compiled": True, "actual_bbox": [10, 10, 10], "expected_bbox_mm": None}]
    write_run(tmp_path, "conv_gt_wire", "none", rows)
    report = sem.build_report(tmp_path, 0.15)
    assert "| none | 1 | 1 | 0 | 0/0 | — | — |" in report
