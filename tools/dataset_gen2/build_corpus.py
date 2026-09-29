"""Build the gen2 corpus: one .scad per sample plus manifest.jsonl.

Every sample is evaluated with the manifold kernel before it is written, so
nothing that fails the local audit (header, size, single component, bounding
box, wire graph) ever reaches ``optional_data/data/gen2``.

Usage
-----
    python tools/dataset_gen2/build_corpus.py --count 80
    python tools/dataset_gen2/build_corpus.py --count 4 --out /tmp/gen2_smoke
"""

from __future__ import annotations

import argparse
import hashlib
import json
import sys
import time
from pathlib import Path
from typing import Callable

if __package__ in (None, ""):
    # allow "python tools/dataset_gen2/build_corpus.py" from the repo root
    sys.path.insert(0, str(Path(__file__).resolve().parents[2]))

from tools.dataset_gen2.common import Part, check_part
from tools.dataset_gen2.families import bearings, brackets, drive, joints, profiles, shells, wire

DEFAULT_OUT = Path("optional_data/data/gen2")
MIN_AXIS_MM = 5.0
MAX_AXIS_MM = 250.0

# family name -> builder.  The name is what lands in the manifest and becomes
# the subdirectory, so it stays a single latin word.
FAMILY_BUILDERS: dict[str, Callable[[int], Part]] = {
    # voxel / CSG families
    "lbrackets": brackets.build_brackets_l,
    "ubrackets": brackets.build_brackets_u,
    "zbrackets": brackets.build_brackets_z,
    "spurgears": drive.build_spur_gears,
    "helicalgears": drive.build_helical_gears,
    "racks": drive.build_gear_racks,
    "pulleys": drive.build_pulleys,
    "motormounts": drive.build_motor_mounts,
    "bearings": bearings.build_bearing_housings,
    "caps": bearings.build_retaining_caps,
    "spacers": bearings.build_spacers,
    "oldhams": bearings.build_oldham,
    "hinges": joints.build_hinges,
    "clips": joints.build_cable_clips,
    "ducts": joints.build_cable_ducts,
    "knobs": joints.build_knobs,
    "impellers": joints.build_impellers,
    "enclosures": shells.build_enclosures,
    "lids": shells.build_enclosure_lids,
    "bezels": shells.build_bezels,
    # wire / truss families (manifest rows carry a graph)
    "trusses": wire.build_trusses,
    "towers": wire.build_towers,
    "quadframes": wire.build_quad_frames,
    "ibeams": wire.build_i_beams,
    "pipes": wire.build_pipe_routes,
    # sketch profile families
    "shafts": profiles.build_stepped_shafts,
    "flanges": profiles.build_bolt_flanges,
    "handles": profiles.build_handles,
}


def audit(part: Part) -> list[str]:
    """Local gate before a sample is allowed into the corpus."""
    problems = list(check_part(part).errors)
    for axis, value in zip("XYZ", part.bbox):
        if value < MIN_AXIS_MM:
            problems.append(f"axis {axis} is {value:.2f} mm, below the {MIN_AXIS_MM} mm floor")
        if value > MAX_AXIS_MM:
            problems.append(f"axis {axis} is {value:.2f} mm, above the {MAX_AXIS_MM} mm ceiling")
    if len(part.code.encode("utf-8")) > 12000:
        problems.append("source exceeds 12 kB")
    if not part.code.startswith("$fn = 32;\n"):
        problems.append("first line must be exactly '$fn = 32;'")
    return problems


def build(count: int, out_dir: Path, quiet: bool = False) -> dict[str, object]:
    """Generate ``count`` samples per family and write the corpus."""
    started = time.time()
    manifest_rows: list[dict[str, object]] = []
    family_stats: dict[str, dict[str, object]] = {}
    rejects: list[dict[str, str]] = []
    written: list[Path] = []

    for family, builder in FAMILY_BUILDERS.items():
        directory = out_dir / family
        directory.mkdir(parents=True, exist_ok=True)
        accepted = 0
        variants: set[str] = set()
        attempts = 0
        max_attempts = count * 4 + 20
        while accepted < count and attempts < max_attempts:
            index = attempts
            attempts += 1
            part = builder(index)
            problems = audit(part)
            if problems:
                rejects.append({"family": family, "index": str(index), "reason": "; ".join(problems)})
                continue
            relative = f"{family}/part_{accepted + 1:04d}.scad"
            path = out_dir / relative
            path.write_text(part.code, encoding="utf-8")
            written.append(path)
            manifest_rows.append(part.manifest_row(relative))
            variants.add(part.variant)
            accepted += 1
        if accepted < count and not quiet:
            print(f"{family:<14} only {accepted} of {count} samples passed the audit", flush=True)
        family_stats[family] = {
            "requested": count,
            "written": accepted,
            "variants": len(variants),
            "dir": family,
            "attempts": attempts,
        }
        if not quiet:
            print(f"{family:<14} {accepted}/{count} written, {len(variants)} variants", flush=True)

    manifest_path = out_dir / "manifest.jsonl"
    manifest_path.write_text(
        "".join(json.dumps(row, ensure_ascii=False, sort_keys=True) + "\n" for row in manifest_rows),
        encoding="utf-8",
    )

    checksums = hashlib.sha256(manifest_path.read_bytes()).hexdigest()
    checksum_lines = [f"{checksums}  manifest.jsonl"]
    for path in sorted(written):
        digest = hashlib.sha256(path.read_bytes()).hexdigest()
        checksum_lines.append(f"{digest}  {path.relative_to(out_dir).as_posix()}")
    (out_dir / "SHA256SUMS.txt").write_text("\n".join(checksum_lines) + "\n", encoding="utf-8")

    elapsed = time.time() - started
    summary: dict[str, object] = {
        "count": count,
        "samples": len(manifest_rows),
        "families": len(FAMILY_BUILDERS),
        "out_dir": str(out_dir),
        "manifest_sha256": checksums,
        "seconds": round(elapsed, 1),
        "family_stats": family_stats,
        "rejects": rejects,
        "written": written,
    }
    if not quiet:
        print(f"\n{len(manifest_rows)} samples in {len(FAMILY_BUILDERS)} families, {elapsed:.1f} s")
        print(f"manifest.jsonl sha256 = {checksums}")
        if rejects:
            print(f"rejected {len(rejects)} samples (first 5): {rejects[:5]}")
    return summary


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description="Generate the gen2 OpenSCAD corpus")
    parser.add_argument("--count", type=int, default=80, help="samples per family")
    parser.add_argument("--out", type=Path, default=DEFAULT_OUT, help="output directory")
    parser.add_argument("--quiet", action="store_true", help="only print the final summary")
    parser.add_argument(
        "--report",
        action="store_true",
        help="write GENERATION_REPORT.md next to the corpus",
    )
    args = parser.parse_args(argv)

    summary = build(args.count, args.out, quiet=args.quiet)
    if args.report:
        from tools.dataset_gen2.report import write_report
        from tools.dataset_gen2.verify_corpus import audit_corpus

        # re-audit the files that are actually on disk and put those numbers in
        # the report, so the report can never claim more than the corpus does
        summary["audit"] = audit_corpus(args.out)
        write_report(args.out, summary)
        if not args.quiet:
            print(f"report written to {args.out / 'GENERATION_REPORT.md'}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
