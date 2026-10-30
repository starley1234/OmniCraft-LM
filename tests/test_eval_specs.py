"""``[SPECS]`` mode selection for evaluation (``src/runtime/eval_specs.py``).

No GPU, weights or OpenSCAD: the helpers only mine text and compose blocks.
"""

from __future__ import annotations

import pytest

from src.runtime.eval_specs import SPECS_MODES, expected_bbox, specs_for_row
from src.runtime.specs_hook import _default_topology, extract_specs_from_text

WIRE_PROMPT = "ферма Пратта 300x40x80 мм из круглых стержней"


def test_modes_are_documented_set() -> None:
    assert SPECS_MODES == ("auto", "mined", "none")


def test_auto_uses_oracle_bbox_when_present() -> None:
    row = {"id": "r", "prompt": WIRE_PROMPT, "expected_bbox_mm": [120, 60, 30]}
    specs, bbox = specs_for_row(row, layer="wire", mode="auto")
    assert specs is not None
    assert bbox == (120.0, 60.0, 30.0)
    assert specs.bbox == bbox
    assert "bbox: [120, 60, 30]" in specs.render()


def test_auto_falls_back_to_miner_without_oracle() -> None:
    row = {"id": "r", "prompt": WIRE_PROMPT}
    mined = extract_specs_from_text(WIRE_PROMPT, canvas_hint="wire")
    specs, bbox = specs_for_row(row, layer="wire", mode="auto")
    assert specs is not None
    assert bbox == mined.bbox


def test_mined_ignores_oracle() -> None:
    row = {"id": "r", "prompt": WIRE_PROMPT, "expected_bbox_mm": [120, 60, 30]}
    mined = extract_specs_from_text(WIRE_PROMPT, canvas_hint="wire")
    specs, bbox = specs_for_row(row, layer="wire", mode="mined")
    assert specs is not None
    assert bbox == mined.bbox
    assert bbox != (120.0, 60.0, 30.0)


def test_none_renders_no_block_but_keeps_canvas_scale() -> None:
    row = {"id": "r", "prompt": WIRE_PROMPT, "expected_bbox_mm": [120, 60, 30]}
    mined = extract_specs_from_text(WIRE_PROMPT, canvas_hint="wire")
    specs, bbox = specs_for_row(row, layer="wire", mode="none")
    assert specs is None
    assert bbox == mined.bbox


def test_block_matches_executed_canvas() -> None:
    for layer in ("voxel", "wire"):
        specs, _ = specs_for_row({"prompt": WIRE_PROMPT}, layer=layer, mode="auto")
        assert specs is not None
        assert specs.canvas == layer
        assert specs.topology == _default_topology(layer)


@pytest.mark.parametrize(
    "raw",
    [None, [], [1, 2], [1, 2, 3, 4], [0, 10, 10], [-5, 10, 10], ["a", "b", "c"], "10x10x10"],
)
def test_expected_bbox_rejects_unusable_values(raw: object) -> None:
    assert expected_bbox({"expected_bbox_mm": raw}) is None


def test_expected_bbox_accepts_three_positive_numbers() -> None:
    assert expected_bbox({"expected_bbox_mm": [96, 96.5, "10"]}) == (96.0, 96.5, 10.0)


def test_unknown_mode_is_rejected() -> None:
    with pytest.raises(ValueError):
        specs_for_row({"prompt": WIRE_PROMPT}, layer="wire", mode="oracle")
