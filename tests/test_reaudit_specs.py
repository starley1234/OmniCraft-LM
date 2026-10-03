"""Re-audit tool: trained-style selection mirrors trainer.prompt_text_for; flat/manifest rows."""

from __future__ import annotations

import hashlib

from tools.reaudit_specs_corpus import _rel_err, row_prompts, trained_style


def test_trained_style_is_deterministic_and_matches_trainer_formula() -> None:
    styles = {"en": "A", "free_ru": "B", "conv_en": "C", "conv_ru": "D"}
    row = {"id": "gen2_00718__free_en", "prompts": styles}
    digest = hashlib.sha1(row["id"].encode("utf-8")).digest()
    expected = sorted(styles)[digest[0] % 4]
    for _ in range(3):
        style, text = trained_style(row, row_prompts(row))
        assert style == expected and text == styles[expected]


def test_single_prompt_and_flat_manifest_rows() -> None:
    pairs = row_prompts({"id": "x", "prompts": {"en": "только один"}})
    assert pairs == [("en", "только один")] and trained_style({"id": "x", "prompts": {"en": "только один"}}, pairs) == pairs[0]
    flat = row_prompts({"prompt": "кубик 30 мм"})
    assert flat == [("prompt", "кубик 30 мм")]
    assert trained_style({"id": "y"}, []) is None


def test_rel_err_guards() -> None:
    assert _rel_err((100.0, 100.0, 100.0), [96, 96, 10]) > 0.15
    assert _rel_err((96.0, 96.0, 10.0), [96, 96, 10]) == 0.0
    assert _rel_err((1.0, 1.0, 1.0), [0, 5, 5]) is None
    assert _rel_err((1.0, 1.0, 1.0), ["x", "y", "z"]) is None
