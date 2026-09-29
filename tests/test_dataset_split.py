from __future__ import annotations

import subprocess
import sys
from pathlib import Path

from src.data.generators.voxel_csg_gen import VoxelCSGGenerator
from src.data.schema import parse_jsonl, write_jsonl
from src.data.validation import DatasetValidator, ValidationPolicy
from tools.split_dataset import _assignment, _group_key


def test_group_assignment_is_stable_and_same_group_cannot_leak() -> None:
    samples = list(VoxelCSGGenerator(seed=71).generate_many(30))
    key = _group_key(samples[0], "kind-and-dimension", 20.0)
    assigned = _assignment(key, seed=55, train=0.8, validation=0.1)
    assert assigned == _assignment(key, seed=55, train=0.8, validation=0.1)
    same_group = [sample for sample in samples if _group_key(sample, "kind-and-dimension", 20.0) == key]
    assert same_group
    assert all(
        _assignment(_group_key(sample, "kind-and-dimension", 20.0), 55, 0.8, 0.1) == assigned
        for sample in same_group
    )


def test_split_tool_writes_every_accepted_row_once(tmp_path: Path) -> None:
    generator = VoxelCSGGenerator(seed=88)
    validator = DatasetValidator(policy=ValidationPolicy(accept_exact_analytic=True))
    samples = [validator.validate(sample).sample for sample in generator.generate_many(36)]
    assert all(sample.verification.accepted for sample in samples)
    source = tmp_path / "accepted.jsonl"
    output = tmp_path / "splits"
    write_jsonl(source, samples)

    repository = Path(__file__).resolve().parents[1]
    result = subprocess.run(
        [
            sys.executable,
            str(repository / "tools" / "split_dataset.py"),
            "--input", str(source),
            "--output-dir", str(output),
            "--seed", "10",
            "--group-by", "kind-and-dimension",
        ],
        cwd=repository,
        capture_output=True,
        text=True,
        check=True,
    )
    assert "Wrote grouped split" in result.stdout
    partition_by_group: dict[str, str] = {}
    observed_ids: set[str] = set()
    for split_name in ("train", "validation", "test"):
        for sample in parse_jsonl(output / f"{split_name}.jsonl"):
            observed_ids.add(sample.id)
            group_key = _group_key(sample, "kind-and-dimension", 20.0)
            previous = partition_by_group.setdefault(group_key, split_name)
            assert previous == split_name
    assert observed_ids == {sample.id for sample in samples}
    assert (output / "manifest.json").is_file()
