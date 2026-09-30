"""Golden-тесты детерминизма процедурных генераторов (seedодержимое зафиксировано).

Если `test_matches_golden_file` падает — выхлоп генератора изменился:
  * изменение НЕ намеренное -> чини генератор, хэш это поймал;
  * изменение намеренное   -> python tools/update_golden.py и рассмотри diff
    tests/golden_hashes.json в коммите (это и есть аудит изменения).
"""

from __future__ import annotations

import hashlib
import json
from pathlib import Path

import pytest

from src.data.generators.voxel_csg_gen import VoxelCSGGenerator
from src.data.generators.wire_truss_gen import WireTrussGenerator

GOLDEN_PATH = Path(__file__).resolve().parent / "golden_hashes.json"

FAMILIES = {
    "voxel": VoxelCSGGenerator,
    "wire": WireTrussGenerator,
}


def _generate_all(seed: int, indices: range) -> dict[str, list[dict[str, str]]]:
    result: dict[str, list[dict[str, str]]] = {}
    for name, generator_cls in FAMILIES.items():
        generator = generator_cls(seed=seed)
        result[name] = [
            {
                "id": sample.id,
                "sha256": hashlib.sha256(sample.code.encode("utf-8")).hexdigest(),
                "code": sample.code,
            }
            for sample in (generator.generate(i) for i in indices)
        ]
    return result


def test_every_code_starts_with_facet_header() -> None:
    for entries in _generate_all(seed=1234, indices=range(8)).values():
        for entry in entries:
            assert entry["code"].startswith("$fn = 32;\n"), f"{entry['id']}: нет заголовка $fn = 32;"


def test_deterministic_within_process() -> None:
    first = _generate_all(seed=7, indices=range(4))
    second = _generate_all(seed=7, indices=range(4))
    for name in FAMILIES:
        for a, b in zip(first[name], second[name]):
            assert a["sha256"] == b["sha256"], f"{name}/{a['id']}: генерация не детерминирована"


def test_matches_golden_file() -> None:
    if not GOLDEN_PATH.is_file():
        pytest.fail("нет tests/golden_hashes.json — создай: python tools/update_golden.py")
    golden = json.loads(GOLDEN_PATH.read_text(encoding="utf-8"))
    current = _generate_all(seed=golden["seed"], indices=range(len(golden["indices"])))
    for name, golden_entries in golden["families"].items():
        current_hashes = [entry["sha256"] for entry in current[name]]
        golden_hashes = [entry["sha256"] for entry in golden_entries]
        assert current_hashes == golden_hashes, (
            f"{name}: выхлоп отличается от эталона. Намеренное изменение? "
            "Тогда: python tools/update_golden.py"
        )


def test_different_indices_give_different_parts() -> None:
    for entries in _generate_all(seed=1234, indices=range(8)).values():
        hashes = [entry["sha256"] for entry in entries]
        assert len(set(hashes)) == len(hashes), "разные индексы дали одинаковые детали"
