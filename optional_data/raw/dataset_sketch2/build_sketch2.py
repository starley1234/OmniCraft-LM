"""Build the sketch2 corpus (request 5, block S2).

Local gate per sample (``core2s.audit_sketch2`` + the shared checks):
manifold evaluation, one solid, bbox, analytic volume (extrusion minus the
void cuts / Pappus for revolves), profile rules, void rules and the place1
consistency law on both prompts.

Usage
-----
    python tools/dataset_sketch2/build_sketch2.py --count 230
    python tools/dataset_sketch2/build_sketch2.py --count 4 --out /tmp/sketch2_smoke
"""

from __future__ import annotations

import argparse
import sys
import time
from pathlib import Path

if __package__ in (None, ""):
    sys.path.insert(0, str(Path(__file__).resolve().parents[2]))

from tools.dataset_place1.check_consistency import check_row
from tools.dataset_sketch2.core2s import Sketch2Part, audit_sketch2
from tools.dataset_sketch2.families2s import FAMILY_BUILDERS
from tools.dataset_v5.kit import build_family_corpus, write_delivery

DEFAULT_OUT = Path("optional_data/data/sketch2")
CORPUS_DIR = "optional_data/data/sketch2"


def audit(part: Sketch2Part) -> list[str]:
    problems = list(audit_sketch2(part, stl=False))
    for axis, value in zip("XYZ", part.bbox):
        if value < 5.0 or value > 250.0:
            problems.append(f"axis {axis} = {value:.2f} mm outside 5..250")
    count = len(part.profile)
    if not (6 <= count <= 64):
        problems.append(f"profile has {count} points, allowed 6..64")
    for void in part.voids:
        if not (3 <= len(void) <= 64):
            problems.append(f"void has {len(void)} points")
    row = {"prompt_en": part.prompt_en, "prompt_ru": part.prompt_ru}
    for language in ("en", "ru"):
        report = check_row(row, part.code, prompt_lang=language)
        if not report.numbers_ok:
            problems.append(f"prompt[{language}] numbers not in code: {report.missing[:4]}")
    return problems


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--count", type=int, default=230, help="samples per family")
    parser.add_argument("--out", type=Path, default=DEFAULT_OUT)
    parser.add_argument("--quiet", action="store_true")
    args = parser.parse_args(argv)

    started = time.time()
    rows, written, family_stats, rejects = build_family_corpus(
        args.out,
        FAMILY_BUILDERS,
        audit=audit,
        render_code=lambda part: part.code,
        render_prompts=lambda part: (part.prompt_ru, part.prompt_en),
        manifest_row=lambda part, rel: {
            **part.manifest_row(rel),
            "validation_status": "pending_openscad_manifold",
        },
        file_stem="part",
        count_per_family=args.count,
        quiet=args.quiet,
    )
    manifest_sha = write_delivery(
        args.out,
        rows,
        written,
        corpus_dir=CORPUS_DIR if args.out == DEFAULT_OUT else str(args.out),
        verify_cmd="python tools/dataset_sketch2/verify_sketch2.py --parts-dir optional_data/data/sketch2",
    )
    elapsed = time.time() - started
    with_voids = sum(1 for row in rows if row.get("voids_profiles"))
    revolves = sum(1 for row in rows if row.get("extrude", {}).get("kind") == "rotate")
    print(
        f"\n{len(rows)} parts, {elapsed:.1f} s; {with_voids} with voids, {revolves} revolves, "
        f"rejects {len(rejects)}"
    )
    print(f"manifest.jsonl sha256 = {manifest_sha}")
    if rejects:
        print(f"first rejects: {rejects[:5]}")
    return 0 if rows else 1


if __name__ == "__main__":
    sys.exit(main())
