"""Build 16^3 occupancy ground truth for voxel-layer samples (aux loss GT).

Для каждой воксельной строки корпуса: компиляция OpenSCAD с backend=manifold
(тот же раннер, что у валидатора) -> STL -> вокселизация 16x16x16 через
``mesh.contains``. Занятость пакуется в биты (4096 бит = 512 Б), кодируется
base64 и пишется сайдкаром JSONL, который трейнер джойнит по id записи.

Ключевой приём — **дедупликация по `metadata.code_sha256`**: корпус v8 содержит
42 637 воксельных строк, но только ~6.7 тыс. уникальных программ (перефразировки
и стили делят один и тот же код). Компилируется каждая программа ровно один раз,
а строка сайдкара пишется для *каждого* id с этим кодом — иначе aux-лосс молча
обнуляется на 97% батчей (разбор v8, STATUS.md).

    python tools/build_voxel_grids.py \
        --input data/processed/splits_v8/train.jsonl \
                data/processed/splits_v8/validation.jsonl \
        --output data/processed/voxel_grids.jsonl --workers 14

Инструмент инкрементальный: уже покрытые id пропускаются, сетки известных sha
переиспользуются. ``--coverage-only`` считает покрытие без компиляции.

Требуется ``rtree`` (pip install rtree) для trimesh.contains.
"""

from __future__ import annotations

import argparse
import base64
import hashlib
import json
import sys
from concurrent.futures import ProcessPoolExecutor
from pathlib import Path

REPOSITORY_ROOT = Path(__file__).resolve().parents[1]
if str(REPOSITORY_ROOT) not in sys.path:
    sys.path.insert(0, str(REPOSITORY_ROOT))

import numpy as np

from src.env.openscad_runner import OpenSCADRunner

GRID = 16


def sample_grid(code: str, runner: OpenSCADRunner) -> dict | None:
    """Compile -> contains() probe -> packed occupancy record, or None."""
    import tempfile

    import trimesh

    with tempfile.TemporaryDirectory(prefix="omnicraft-vox-") as temporary:
        directory = Path(temporary)
        scad = directory / "m.scad"
        stl = directory / "m.stl"
        scad.write_text(code, encoding="utf-8")
        import subprocess

        completed = subprocess.run(
            [runner.executable, f"--backend={runner.backend}", "-o", str(stl), str(scad)],
            capture_output=True,
            timeout=runner.timeout_seconds,
            check=False,
        )
        if completed.returncode != 0 or not stl.is_file():
            return None
        mesh = trimesh.load(str(stl), force="mesh", process=True)
    if not mesh.is_watertight:
        return None
    bounds = mesh.bounds
    span = bounds[1] - bounds[0]
    if np.any(span <= 0):
        return None
    axes = [np.linspace(lo + 0.5 * s / GRID, hi - 0.5 * s / GRID, GRID) for lo, hi, s in zip(bounds[0], bounds[1], span)]
    zz, yy, xx = np.meshgrid(axes[2], axes[1], axes[0], indexing="ij")
    centers = np.stack([xx.ravel(), yy.ravel(), zz.ravel()], axis=1)
    try:
        occupied = mesh.contains(centers)
    except Exception as exc:
        raise RuntimeError("trimesh.contains needs rtree; pip install rtree") from exc
    grid = occupied.reshape(GRID, GRID, GRID)
    packed = np.packbits(grid.astype(np.uint8).ravel()).tobytes()
    return {
        "grid_b64": base64.b64encode(packed).decode("ascii"),
        "mesh_bbox": [float(v) for v in span],
    }


_RUNNER: OpenSCADRunner | None = None


def _worker(task: tuple[str, str]) -> tuple[str, dict | None]:
    """Процессный воркер: trimesh/rtree держат GIL, поэтому не потоки.

    На потоках 16-ядерная машина выдавала ~25 программ/мин при load average 8;
    процессы грузят все ядра.
    """
    global _RUNNER
    if _RUNNER is None:
        _RUNNER = OpenSCADRunner()
    key, code = task
    try:
        return key, sample_grid(code, _RUNNER)
    except Exception:
        return key, None


def code_key(record: dict) -> str:
    """Стабильный ключ программы: code_sha256 из метаданных либо хэш самого кода."""
    metadata = record.get("metadata") or {}
    sha = metadata.get("code_sha256")
    if isinstance(sha, str) and sha:
        return sha
    return hashlib.sha256(record["code"].encode("utf-8")).hexdigest()


def scan_inputs(paths: list[Path]) -> tuple[dict[str, str], dict[str, str]]:
    """Стрим JSONL без pydantic (train.jsonl ~150 МБ).

    Возвращает (id -> ключ кода, ключ кода -> код).
    """
    key_by_id: dict[str, str] = {}
    code_by_key: dict[str, str] = {}
    for path in paths:
        with Path(path).open("r", encoding="utf-8") as stream:
            for line in stream:
                if not line.strip():
                    continue
                record = json.loads(line)
                if record.get("layer") != "voxel":
                    continue
                key = code_key(record)
                key_by_id[record["id"]] = key
                code_by_key.setdefault(key, record["code"])
    return key_by_id, code_by_key


def load_existing(path: Path) -> dict[str, str]:
    """id -> grid_b64 уже построенных строк сайдкара."""
    if not Path(path).is_file():
        return {}
    existing: dict[str, str] = {}
    with Path(path).open("r", encoding="utf-8") as stream:
        for line in stream:
            if line.strip():
                row = json.loads(line)
                existing[row["id"]] = row["grid_b64"]
    return existing


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--input", type=Path, nargs="+", required=True)
    parser.add_argument("--output", type=Path, default=Path("data/processed/voxel_grids.jsonl"))
    parser.add_argument("--workers", type=int, default=12)
    parser.add_argument("--limit", type=int, default=0, help="компилировать не более N новых программ (смоук)")
    parser.add_argument("--coverage-only", action="store_true", help="только отчёт о покрытии, без компиляции")
    args = parser.parse_args()

    key_by_id, code_by_key = scan_inputs(list(args.input))
    existing = load_existing(args.output)

    # Сетка известна для ключа, если она есть хотя бы у одного id с этим кодом.
    grid_by_key: dict[str, str] = {}
    for identifier, grid in existing.items():
        key = key_by_id.get(identifier)
        if key is not None:
            grid_by_key.setdefault(key, grid)

    missing_ids = [i for i in key_by_id if i not in existing]
    missing_keys = sorted({key_by_id[i] for i in missing_ids} - set(grid_by_key))
    covered = len(key_by_id) - len(missing_ids)
    print(
        f"voxel rows: {len(key_by_id)} | unique programs: {len(code_by_key)} | "
        f"covered rows: {covered} ({covered / max(len(key_by_id), 1):.1%}) | "
        f"to compile: {len(missing_keys)}",
        flush=True,
    )
    if args.coverage_only:
        return 0
    if args.limit:
        missing_keys = missing_keys[: args.limit]

    # id, ждущие строку сайдкара, сгруппированы по программе.
    ids_by_key: dict[str, list[str]] = {}
    for identifier in missing_ids:
        ids_by_key.setdefault(key_by_id[identifier], []).append(identifier)

    built = failed = written = 0
    with Path(args.output).open("a", encoding="utf-8", newline="\n") as out:

        def emit(key: str, grid: str, bbox: list[float] | None = None) -> int:
            count = 0
            for identifier in ids_by_key.get(key, ()):
                row: dict = {"id": identifier, "grid_b64": grid}
                if bbox is not None:
                    row["mesh_bbox"] = bbox
                out.write(json.dumps(row, ensure_ascii=False) + "\n")
                count += 1
            return count

        # Сетки, уже известные по другому id той же программы, — без компиляции.
        for key in sorted(set(ids_by_key) & set(grid_by_key)):
            written += emit(key, grid_by_key[key])
        out.flush()

        if missing_keys:
            tasks = [(key, code_by_key[key]) for key in missing_keys]
            with ProcessPoolExecutor(max_workers=args.workers) as pool:
                for key, record in pool.map(_worker, tasks, chunksize=4):
                    if record is None:
                        failed += 1
                        continue
                    built += 1
                    written += emit(key, record["grid_b64"], record["mesh_bbox"])
                    # Инкрементальная запись: обрыв не теряет часы компиляции,
                    # повторный запуск доберёт остаток.
                    if (built + failed) % 100 == 0:
                        out.flush()
                        print(
                            f"  compiled {built + failed}/{len(missing_keys)} "
                            f"(failed {failed}, rows {written})",
                            flush=True,
                        )

    total_covered = covered + written
    print(
        f"done: programs built {built}, failed {failed}; rows written {written}; "
        f"coverage {total_covered}/{len(key_by_id)} ({total_covered / max(len(key_by_id), 1):.1%}) -> {args.output}"
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
