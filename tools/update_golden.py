"""Пересчитывает эталонные SHA-256 процедурных генераторов -> tests/golden_hashes.json.

ЗАПУСКАТЬ ТОЛЬКО ПРИ НАМЕРЕННОМ ИЗМЕНЕНИИ ГЕНЕРАТОРОВ.
Diff этого файла в git = аудит того, как изменился выхлоп генераторов.

    python tools/update_golden.py
"""

from __future__ import annotations

import hashlib
import json
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))  # иначе `python tools/update_golden.py` не видит пакет src

from src.data.generators.voxel_csg_gen import VoxelCSGGenerator
from src.data.generators.wire_truss_gen import WireTrussGenerator

GOLDEN_PATH = ROOT / "tests" / "golden_hashes.json"

SEED = 1234
INDICES = range(8)
FAMILIES = {  # имя -> класс генератора
    "voxel": VoxelCSGGenerator,
    "wire": WireTrussGenerator,
}


def main() -> None:
    payload: dict[str, object] = {"seed": SEED, "indices": list(INDICES), "families": {}}
    families: dict[str, list[dict[str, str]]] = {}
    for name, generator_cls in FAMILIES.items():
        generator = generator_cls(seed=SEED)
        entries = []
        for index in INDICES:
            sample = generator.generate(index)
            entries.append({
                "id": sample.id,
                "sha256": hashlib.sha256(sample.code.encode("utf-8")).hexdigest(),
            })
        families[name] = entries
    payload["families"] = families

    GOLDEN_PATH.write_text(
        json.dumps(payload, ensure_ascii=False, indent=2) + "\n", encoding="utf-8"
    )
    total = sum(len(entries) for entries in families.values())
    print(f"golden: {total} хэшей ({SEED=}) -> {GOLDEN_PATH.relative_to(ROOT)}")


if __name__ == "__main__":
    main()
