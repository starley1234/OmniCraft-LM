from __future__ import annotations

from pathlib import Path

import pytest

from src.data.dataset import CADJsonlDataset
from src.data.generators.wire_truss_gen import WireTrussGenerator
from src.data.schema import write_jsonl
from src.model.latent_bridge import ScaleMLP


def test_dataset_builds_log_scale_and_padded_auxiliary_batch(tmp_path: Path) -> None:
    records = list(WireTrussGenerator(seed=5).generate_many(2))
    path = tmp_path / "records.jsonl"
    write_jsonl(path, records)
    dataset = CADJsonlDataset(
        path, max_prompt_tokens=200, max_code_tokens=1000, require_accepted=False
    )
    batch = dataset.collate_fn([dataset[0], dataset[1]])
    assert batch["input_ids"].shape[0] == 2
    assert batch["scale_embedding"].shape == (2, 3)
    assert batch["auxiliary_targets"]["nodes"].shape == (2, 8, 3)
    encoded = ScaleMLP().forward_log_bbox(batch["scale_embedding"])
    assert encoded.shape == (2, 128)


class _StubTokenizer:
    """Минимальный токенизатор с EOS: проверяем контракт меток, не настоящий словарь."""

    pad_token_id = 0
    eos_token_id = 99

    def __call__(self, text: str, **kwargs):
        ids = [ord(ch) % 50 + 1 for ch in text][: kwargs.get("max_length") or None]
        return {"input_ids": ids or [1]}


def test_code_labels_end_with_eos(tmp_path: Path) -> None:
    """Без EOS в метках модель не учится останавливаться и зацикливается на инференсе."""
    path = tmp_path / "records.jsonl"
    write_jsonl(path, list(WireTrussGenerator(seed=5).generate_many(1)))
    dataset = CADJsonlDataset(
        path, tokenizer=_StubTokenizer(), max_prompt_tokens=64,
        max_code_tokens=128, require_accepted=False,
    )
    item = dataset[0]
    assert int(item["labels"][-1]) == _StubTokenizer.eos_token_id
    assert item["labels"].shape[0] <= 128
    assert int(item["input_ids"][-1]) != _StubTokenizer.eos_token_id  # промпт не завершаем


def test_prompt_style_rotation_uses_every_style(tmp_path: Path) -> None:
    """v6/v7 учились только на prompts['en']; ротация обязана показывать все стили."""
    records = list(WireTrussGenerator(seed=5).generate_many(1))
    records[0].prompts = {"en": "a truss", "ru": "ферма", "conv_en": "hey, a truss?"}
    path = tmp_path / "styles.jsonl"
    write_jsonl(path, records)
    dataset = CADJsonlDataset(path, require_accepted=False)
    seen = set()
    for epoch in range(3):
        dataset.set_epoch(epoch)
        seen.add(dataset._pick_prompt(dataset.samples[0], 0))
    assert seen == {"a truss", "ферма", "hey, a truss?"}


def test_training_dataset_refuses_unaccepted_candidates_by_default(tmp_path: Path) -> None:
    path = tmp_path / "candidates.jsonl"
    write_jsonl(path, list(WireTrussGenerator(seed=6).generate_many(1)))
    with pytest.raises(ValueError, match="unaccepted records"):
        CADJsonlDataset(path)
