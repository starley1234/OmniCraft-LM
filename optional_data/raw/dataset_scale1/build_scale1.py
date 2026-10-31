"""Build the scale1 corpus (request no. 6 leftover: scale disciplines).

Local gate per sample: gen2's ``check_part`` (manifold evaluation, single
solid, declared bbox), the family axis rules (micro 5-20 mm, large 200-250 mm
on the long axis) and the place1 consistency law on both prompts.

Usage
-----
    python tools/dataset_scale1/build_scale1.py --count 200
    python tools/dataset_scale1/build_scale1.py --count 4 --out /tmp/scale1_smoke
"""

from __future__ import annotations

import argparse
import sys
import time
from pathlib import Path

if __package__ in (None, ""):
    sys.path.insert(0, str(Path(__file__).resolve().parents[2]))

from tools.dataset_gen2.common import Part, check_part
from tools.dataset_place1.check_consistency import check_row
from tools.dataset_scale1.families1x import FAMILY_BUILDERS
from tools.dataset_v5.kit import build_family_corpus, write_delivery

DEFAULT_OUT = Path("optional_data/data/scale1")
CORPUS_DIR = "optional_data/data/scale1"


def axis_rules(family: str, bbox: tuple[float, float, float]) -> list[str]:
    problems: list[str] = []
    for axis, value in zip("XYZ", bbox):
        if value < 5.0 or value > 250.0:
            problems.append(f"axis {axis} = {value:.2f} mm outside 5..250")
    if family == "microfeatures" and max(bbox) > 20.0 + 1e-6:
        problems.append(f"micro part is {max(bbox):.2f} mm, allowed up to 20")
    if family == "largestruc" and max(bbox) < 200.0 - 1e-6:
        problems.append(f"large structure peaks at {max(bbox):.2f} mm, expected >= 200")
    return problems


def audit(part: Part) -> list[str]:
    result = check_part(part)
    problems = list(result.errors)
    problems.extend(axis_rules(part.family, part.bbox))
    row = {"prompt_en": part.prompt_en, "prompt_ru": part.prompt_ru}
    for language in ("en", "ru"):
        report = check_row(row, part.code, prompt_lang=language)
        if not report.numbers_ok:
            problems.append(f"prompt[{language}] numbers not in code: {report.missing[:4]}")
    return problems


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--count", type=int, default=200, help="samples per family")
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
        verify_cmd="python tools/dataset_scale1/verify_scale1.py --parts-dir optional_data/data/scale1",
    )
    elapsed = time.time() - started
    print(f"\n{len(rows)} parts, {elapsed:.1f} s; rejects {len(rejects)}")
    print(f"manifest.jsonl sha256 = {manifest_sha}")
    if rejects:
        print(f"first rejects: {rejects[:5]}")
    return 0 if rows else 1


if __name__ == "__main__":
    sys.exit(main())
