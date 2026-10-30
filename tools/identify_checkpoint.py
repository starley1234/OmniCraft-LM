"""Опознать чекпойнт: какие веса лежат в каталоге слоя и с чем они совпадают.

Появился после E7-a (`docs/E7A_V15_CHECKPOINT_LOSS.md`): снимок «v15_s1600»
оказался копией v14, потому что снимался с Windows-зеркала. Быстрая проверка
«это точно те веса?» — по sha256 из `trainer_state.json` и по совпадению
compiled-флагов eval-файлов.

    python tools/identify_checkpoint.py --layer wire
    python tools/identify_checkpoint.py --layer wire --eval data/processed/eval_wire.jsonl
"""

from __future__ import annotations

import argparse
import hashlib
import json
from pathlib import Path

LAYER_FILES = ("canvas.pt", "in_projector.pt", "out_projector.pt", "scale_mlp.pt")


def sha256(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def describe(layer_dir: Path) -> dict:
    state_path = layer_dir / "trainer_state.json"
    step = None
    if state_path.is_file():
        step = json.loads(state_path.read_text(encoding="utf-8")).get("step")
    return {
        "dir": layer_dir,
        "step": step,
        "hashes": {name: sha256(layer_dir / name) for name in LAYER_FILES if (layer_dir / name).is_file()},
        "adapter": (
            sha256(layer_dir / "lora" / "lora_wire" / "adapter_model.safetensors")
            if (layer_dir / "lora" / "lora_wire" / "adapter_model.safetensors").is_file()
            else None
        ),
    }


def find_layer_dirs(checkpoints: Path, layer: str) -> list[Path]:
    """Каталог слоя в checkpoints/ и во всех снимках checkpoints/_*/*."""
    found = [checkpoints / layer] if (checkpoints / layer).is_dir() else []
    for candidate in sorted(checkpoints.glob(f"_*/{layer}")):
        if candidate.is_dir():
            found.append(candidate)
    return found


def load_flags(path: Path) -> dict[str, bool]:
    flags = {}
    for line in path.read_text(encoding="utf-8").splitlines():
        if line.strip():
            row = json.loads(line)
            flags[row["id"]] = bool(row.get("compiled"))
    return flags


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--layer", default="wire")
    parser.add_argument("--checkpoints", type=Path, default=Path("checkpoints"))
    parser.add_argument("--eval", type=Path, default=None, help="эталонный eval-файл (compiled-флаги)")
    parser.add_argument("--archive-dir", type=Path, default=Path("data/processed"))
    args = parser.parse_args()

    entries = [describe(path) for path in find_layer_dirs(args.checkpoints, args.layer)]
    if not entries:
        raise SystemExit(f"no {args.layer!r} layer dirs under {args.checkpoints}")
    for entry in entries:
        print(f"{entry['dir']}: step={entry['step']}")
        for name, digest in entry["hashes"].items():
            print(f"    {name}: {digest[:16]}")
        if entry["adapter"]:
            print(f"    lora adapter: {entry['adapter'][:16]}")

    reference = entries[0]
    identical = [
        str(entry["dir"]) for entry in entries[1:]
        if entry["hashes"] == reference["hashes"] and entry["adapter"] == reference["adapter"]
    ]
    if identical:
        print(f"\n[!] байт-в-байт совпадают с {reference['dir']}: {', '.join(identical)}")

    if args.eval is not None:
        today = load_flags(args.eval)
        print(f"\nсовпадение compiled-флагов с {args.eval}:")
        for path in sorted(args.archive_dir.glob(f"eval_{args.layer}*.jsonl")):
            other = load_flags(path)
            shared = set(other) & set(today)
            agree = sum(1 for key in shared if other[key] == today[key])
            print(f"    {path.name}: compiled={sum(other.values())} "
                  f"agree={agree}/{len(shared)}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
