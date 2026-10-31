"""Build the sketch1 corpus: one .scad per sample plus manifest.jsonl.

Every sample is one flat profile plus exactly one extrusion, and the manifest
row carries the profile itself (the SketchCanvas ground truth) next to the
usual fields.  Nothing is written unless it passes the local audit: source
rules, the profile rules (simple, CCW, 6-40 points, coordinates >= 0), the
manifold evaluation, the single-component test and the STL round trip.

Usage
-----
    python tools/dataset_sketch1/build1.py --count 100
    python tools/dataset_sketch1/build1.py --count 4 --out /tmp/sketch1_smoke
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
    sys.path.insert(0, str(Path(__file__).resolve().parents[2]))

from tools.dataset_gen2.common import Part
from tools.dataset_sketch1.core1 import MAX_BYTES, SketchPart, check_sketch, profile_summary
from tools.dataset_sketch1.families1a import (
    build_camdiscs,
    build_eccentrics,
    build_eyelugs,
    build_hookplates,
    build_leverarms,
    build_pawls,
    build_rackbars,
    build_sprockets,
    build_tslots,
    build_windowplates,
)
from tools.dataset_sketch1.families1b import (
    build_arcstops,
    build_fanrotors,
    build_flatadapters,
    build_formwashers,
    build_guardgrids,
    build_keybars,
    build_overslots,
    build_pclips,
    build_sinkframes,
    build_standoffs,
)

DEFAULT_OUT = Path("optional_data/data/sketch1")
MIN_AXIS_MM = 5.0
MAX_AXIS_MM = 250.0

FAMILY_BUILDERS: dict[str, Callable[[int], SketchPart]] = {
    "camdiscs": build_camdiscs,
    "leverarms": build_leverarms,
    "hookplates": build_hookplates,
    "eyelugs": build_eyelugs,
    "windowplates": build_windowplates,
    "pawls": build_pawls,
    "eccentrics": build_eccentrics,
    "sprockets": build_sprockets,
    "rackbars": build_rackbars,
    "tslots": build_tslots,
    "keybars": build_keybars,
    "standoffs": build_standoffs,
    "formwashers": build_formwashers,
    "pclips": build_pclips,
    "fanrotors": build_fanrotors,
    "arcstops": build_arcstops,
    "overslots": build_overslots,
    "flatadapters": build_flatadapters,
    "sinkframes": build_sinkframes,
    "guardgrids": build_guardgrids,
}

COVERAGE_NOTES: dict[str, str] = {
    "camdiscs": "polar r(theta) cam profiles: rise-dwell, harmonic or dwell-arc, optional boss",
    "leverarms": "smooth outline through two or three bosses (rocker, bell crank, offset)",
    "hookplates": "J hook, deep curl or shallow mouth drawn as a stroked curve",
    "eyelugs": "clevis fork with an open slot, or an open C ring with a tangent tail",
    "windowplates": "plate with open keyhole or rectangular windows on one edge",
    "pawls": "rounded body with a triangular beak on the top edge or the end",
    "eccentrics": "egg and stepped eccentrics, double-D discs with two flats",
    "sprockets": "8-16 tooth chain sprocket, roots and teeth sampled by angle",
    "rackbars": "comb rack with trapezoid teeth along the top edge",
    "tslots": "T-slot rail section with one or two real T-slots",
    "keybars": "parallel, dovetail, hex and woodruff keys",
    "standoffs": "revolved spacers: spool, flanged, stepped, conical, all with a bore",
    "formwashers": "revolved washers (chamfered, countersunk, domed, shouldered) and C washers",
    "pclips": "Pi staple and omega clip outlines",
    "fanrotors": "fan rotor section: 7-11 backward raked blades on a hub",
    "arcstops": "annular sectors with a stop lug, and revolved stop collars",
    "overslots": "bars with oversize keyhole windows for adjustment",
    "flatadapters": "double-D, single-D, hex-disc and keyed adaptor plates",
    "sinkframes": "Pi shaped retaining frames for a heat sink",
    "guardgrids": "guard grilles: slats standing on a base bar between side rails",
}


def audit(part: SketchPart) -> list[str]:
    """Local gate: source + profile + mesh + STL round trip."""
    result = check_sketch(part, stl=True)
    problems = list(result.errors)
    for axis in part.bbox:
        if axis < MIN_AXIS_MM - 1e-6:
            problems.append(f"axis shorter than {MIN_AXIS_MM} mm: {axis}")
        if axis > MAX_AXIS_MM + 1e-6:
            problems.append(f"axis longer than {MAX_AXIS_MM} mm: {axis}")
    if len(part.code.encode("utf-8")) > MAX_BYTES:
        problems.append(f"source is larger than {MAX_BYTES} bytes")
    return problems


def build(count: int, out_dir: Path, quiet: bool = False) -> dict[str, object]:
    started = time.time()
    manifest_rows: list[dict[str, object]] = []
    family_stats: dict[str, dict[str, object]] = {}
    rejects: list[dict[str, str]] = []
    written: list[Path] = []
    seen_sources: set[str] = set()
    duplicates = 0

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
            try:
                part = builder(index)
            except Exception as exc:  # noqa: BLE001 - geometry generators can refuse a draw
                rejects.append({"family": family, "index": str(index), "reason": f"{type(exc).__name__}: {exc}"})
                continue
            problems = audit(part)
            if problems:
                rejects.append({"family": family, "index": str(index), "reason": "; ".join(problems)})
                continue
            digest = hashlib.sha256(part.code.encode("utf-8")).hexdigest()
            if digest in seen_sources:
                duplicates += 1
                continue
            seen_sources.add(digest)
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
    kinds: dict[str, int] = {}
    points: list[int] = []
    for row in manifest_rows:
        kind = str(row["extrude"]["kind"])
        kinds[kind] = kinds.get(kind, 0) + 1
        points.append(len(row["profile"]))
    summary: dict[str, object] = {
        "count": count,
        "samples": len(manifest_rows),
        "families": len(FAMILY_BUILDERS),
        "out_dir": str(out_dir),
        "manifest_sha256": checksums,
        "seconds": round(elapsed, 1),
        "family_stats": family_stats,
        "rejects": rejects,
        "duplicates_skipped": duplicates,
        "written": written,
        "kinds": kinds,
        "points_min": min(points) if points else 0,
        "points_max": max(points) if points else 0,
    }
    if not quiet:
        print(f"\n{len(manifest_rows)} samples in {len(FAMILY_BUILDERS)} families, {elapsed:.1f} s")
        print(f"kinds: {kinds}; profile points {summary['points_min']}..{summary['points_max']}")
        print(f"manifest.jsonl sha256 = {checksums}")
        if duplicates:
            print(f"skipped {duplicates} duplicate draws (identical source bytes)")
        if rejects:
            print(f"rejected {len(rejects)} samples (first 5): {rejects[:5]}")
    return summary


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description="Generate the sketch1 corpus")
    parser.add_argument("--count", type=int, default=100, help="samples per family")
    parser.add_argument("--out", type=Path, default=DEFAULT_OUT)
    parser.add_argument("--quiet", action="store_true")
    parser.add_argument("--report", action="store_true", help="write GENERATION_REPORT.md next to the corpus")
    args = parser.parse_args(argv)

    summary = build(args.count, args.out, quiet=args.quiet)
    if args.report:
        from tools.dataset_gen2.report import write_report
        from tools.dataset_sketch1.verify1 import audit_corpus

        audit = audit_corpus(args.out)
        summary["audit"] = audit
        write_report(
            args.out,
            summary,
            title="sketch1 corpus - generation report",
            corpus_label="optional_data/data/sketch1",
            generator="`tools/dataset_sketch1/` (`build1.py`, `families1a.py`, `families1b.py`, `geom1.py`)",
            coverage_notes=COVERAGE_NOTES,
            tool_dir="tools/dataset_sketch1",
            build_script="build1.py",
            variant_tag="sketch1",
            extra_bullets=[
                f"profile ground truth: {audit['points_min']}-{audit['points_max']} points per polygon, "
                f"mean area {audit['mean_profile_area']:.0f} mm2, mean perimeter "
                f"{audit['mean_profile_perimeter']:.0f} mm, all counter clockwise and simple",
                f"profile vs mesh agreement: worst volume deviation "
                f"{audit['max_volume_error']:.2%} (area x height for the linear extrusions, "
                "the Pappus theorem for the revolves)",
                f"prompt uniqueness: duplicate RU {audit['duplicate_ru']}, duplicate EN {audit['duplicate_en']}",
            ],
        )
        if not args.quiet:
            print(f"report written to {args.out / 'GENERATION_REPORT.md'}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
