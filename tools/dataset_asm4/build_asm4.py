"""Build the asm4 corpus (delivery no. 7): one .scad scene per sample.

Local gate per scene (``core2b.check_scene2``): source rules, argument-less
modules defined exactly once, ordered ``translate/rotate`` calls matching the
manifest placements (repeated modules allowed - bolt circles, corner posts,
wheel pairs), grid angles, per-instance solids with the analytic volume,
predicted world bounds, pairwise clearance >= 0.2 mm and the STL round trip.

Usage
-----
    python tools/dataset_asm4/build_asm4.py --count 130
    python tools/dataset_asm4/build_asm4.py --count 4 --out /tmp/asm4_smoke
"""

from __future__ import annotations

import argparse
import sys
import time
from pathlib import Path

if __package__ in (None, ""):
    sys.path.insert(0, str(Path(__file__).resolve().parents[2]))

from tools.dataset_asm2.core2b import CLEARANCE_MM, Scene, check_scene2
from tools.dataset_asm4.scenes4b import FAMILY_BUILDERS
from tools.dataset_v5.kit import build_family_corpus, write_delivery

DEFAULT_OUT = Path("optional_data/data/asm4")
CORPUS_DIR = "optional_data/data/asm4"
MIN_PARTS = 3
MAX_PARTS = 12
MIN_AXIS_MM = 5.0
MAX_AXIS_MM = 250.0


def audit(scene: Scene) -> list[str]:
    result = check_scene2(scene, stl=True)
    problems = list(result.errors)
    if not MIN_PARTS <= len(scene.nodes) <= MAX_PARTS:
        problems.append(f"{len(scene.nodes)} instances, expected {MIN_PARTS}-{MAX_PARTS}")
    for axis, value in zip("XYZ", scene.bbox):
        if value < MIN_AXIS_MM - 1e-6:
            problems.append(f"axis {axis} shorter than {MIN_AXIS_MM} mm: {value}")
        if value > MAX_AXIS_MM + 1e-6:
            problems.append(f"axis {axis} longer than {MAX_AXIS_MM} mm: {value}")
    if result.ok and result.min_gap_mm < CLEARANCE_MM - 1e-4:
        problems.append(f"smallest clearance {result.min_gap_mm:.4f} mm")
    return problems


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--count", type=int, default=130, help="scenes per family")
    parser.add_argument("--out", type=Path, default=DEFAULT_OUT)
    parser.add_argument("--quiet", action="store_true")
    args = parser.parse_args(argv)

    started = time.time()
    rows, written, family_stats, rejects = build_family_corpus(
        args.out,
        FAMILY_BUILDERS,
        audit=audit,
        render_code=lambda scene: scene.code,
        render_prompts=lambda scene: (scene.prompt_ru, scene.prompt_en),
        manifest_row=lambda scene, rel: {
            **scene.manifest_row(rel),
            "id": f"asm4_{Path(rel).parent.name}_{Path(rel).stem.split('_')[-1]}",
            "validation_status": "pending_openscad_manifold",
        },
        file_stem="scene",
        count_per_family=args.count,
        quiet=args.quiet,
    )
    manifest_sha = write_delivery(
        args.out,
        rows,
        written,
        corpus_dir=CORPUS_DIR if args.out == DEFAULT_OUT else str(args.out),
        verify_cmd="python tools/dataset_asm2/verify_asm2.py --parts-dir optional_data/data/asm4",
    )
    elapsed = time.time() - started
    instances = sum(len(row["assembly"]) for row in rows)
    repeats = sum(1 for row in rows if len({n["module"] for n in row["assembly"]}) < len(row["assembly"]))
    print(
        f"\n{len(rows)} scenes, {instances} placed instances, {elapsed:.1f} s; "
        f"{repeats} scenes use a repeated module; rejects {len(rejects)}"
    )
    print(f"manifest.jsonl sha256 = {manifest_sha}")
    if rejects:
        print(f"first rejects: {rejects[:5]}")
    return 0 if rows else 1


if __name__ == "__main__":
    sys.exit(main())
