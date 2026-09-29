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


def test_training_dataset_refuses_unaccepted_candidates_by_default(tmp_path: Path) -> None:
    path = tmp_path / "candidates.jsonl"
    write_jsonl(path, list(WireTrussGenerator(seed=6).generate_many(1)))
    with pytest.raises(ValueError, match="unaccepted records"):
        CADJsonlDataset(path)
