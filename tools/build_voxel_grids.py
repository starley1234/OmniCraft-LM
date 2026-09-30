"""Build 16^3 occupancy ground truth for voxel-layer samples (aux loss GT).

For every accepted voxel sample: compile the OpenSCAD code with the manifold
backend (the same runner as the dataset validator), then probe centrers of a
16x16x16 grid spanning the mesh bbox with ``mesh.contains``. Occupancies are
packed as bits (4096 bits = 512 B) and base64-encoded into a sidecar JSONL
joined to the training set by record id. Already-present ids are skipped, so
the tool is incremental.

    python tools/build_voxel_grids.py \
        --input data/processed/combined_v4.jsonl \
        --output data/processed/voxel_grids.jsonl --workers 12

Requires ``rtree`` (pip install rtree) for trimesh.spatial contains queries.
"""

from __future__ import annotations

import argparse
import base64
import json
import sys
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path

REPOSITORY_ROOT = Path(__file__).resolve().parents[1]
if str(REPOSITORY_ROOT) not in sys.path:
    sys.path.insert(0, str(REPOSITORY_ROOT))

import numpy as np

from src.data.schema import CADSample, parse_jsonl
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


def load_existing_ids(path: Path) -> set[str]:
    if not path.is_file():
        return set()
    return {
        json.loads(line)["id"]
        for line in path.read_text(encoding="utf-8").splitlines()
        if line.strip()
    }


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--input", type=Path, required=True)
    parser.add_argument("--output", type=Path, default=Path("data/processed/voxel_grids.jsonl"))
    parser.add_argument("--workers", type=int, default=12)
    args = parser.parse_args()

    samples = [s for s in parse_jsonl(args.input) if s.layer == "voxel"]
    existing = load_existing_ids(args.output)
    todo = [s for s in samples if s.id not in existing]

    # Content-addressed reuse: a paraphrase row shares the code (and the grid)
    # of its source record; don't recompile identical sources.
    existing_grid_by_id: dict[str, str] = {}
    if args.output.is_file():
        for line in args.output.read_text(encoding="utf-8").splitlines():
            if line.strip():
                row = json.loads(line)
                existing_grid_by_id[row["id"]] = row["grid_b64"]
    all_known = [s for s in parse_jsonl(args.input) if s.id in existing_grid_by_id]
    grid_by_code_sha: dict[str, str] = {}
    for s in all_known:
        sha = s.metadata.get("code_sha256")
        if sha:
            grid_by_code_sha[sha] = existing_grid_by_id[s.id]

    print(f"voxel samples: {len(samples)}, cached: {len(existing)}, to compile: pending…")
    runner = OpenSCADRunner()

    def work(sample: CADSample) -> dict | None:
        record = sample_grid(sample.code, runner)
        if record is None:
            return None
        return {"id": sample.id, **record}

    written = reused = failed = skipped_dupes = 0
    with args.output.open("a", encoding="utf-8", newline="\n") as out:
        todo_now: list[CADSample] = []
        for sample in todo:
            sha = sample.metadata.get("code_sha256")
            if sha and sha in grid_by_code_sha:
                # row carries only the id->grid join; mesh_bbox belongs to the source record
                out.write(json.dumps({"id": sample.id, "grid_b64": grid_by_code_sha[sha]}, ensure_ascii=False) + "\n")
                reused += 1
            else:
                todo_now.append(sample)
        skipped_dupes = reused
        print(f"reused by code sha: {reused}; compiling: {len(todo_now)}", flush=True)
        with ThreadPoolExecutor(max_workers=args.workers, thread_name_prefix="voxelize") as pool:
            for record in pool.map(work, todo_now):
                if record is None:
                    failed += 1
                    continue
                out.write(json.dumps(record, ensure_ascii=False) + "\n")
                written += 1
                if written % 500 == 0:
                    print(f"  built {written}, failed {failed}", flush=True)
    print(f"done: {written} written, {skipped_dupes} reused, {failed} failed -> {args.output}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
