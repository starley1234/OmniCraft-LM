"""Build the gen3 corpus: one .scad per sample plus manifest.jsonl.

Every sample is evaluated with the manifold kernel *and* round-tripped through
the receiver-simulation STL gate before it is written, so nothing that fails
the local audit (header, size, single component, bounding box, 5-250 mm, wire
graph, watertight STL) ever reaches ``optional_data/data/gen3``.

Usage
-----
    python tools/dataset_gen3/build3.py --count 100
    python tools/dataset_gen3/build3.py --count 4 --out /tmp/gen3_smoke
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
    # allow "python tools/dataset_gen3/build3.py" from the repo root
    sys.path.insert(0, str(Path(__file__).resolve().parents[2]))

from tools.dataset_gen2.common import Part, check_part
from tools.dataset_gen2.stlcheck import check_source, is_bad
from tools.dataset_gen3.families3 import fluid, gears3, lattice, marine, mech, mech2, sketch3, wire3

DEFAULT_OUT = Path("optional_data/data/gen3")
MIN_AXIS_MM = 5.0
MAX_AXIS_MM = 250.0

# family name -> builder.  The name lands in the manifest and becomes the
# subdirectory, so it stays a single latin word and never repeats a gen2 family.
FAMILY_BUILDERS: dict[str, Callable[[int], Part]] = {
    # threads, gears, mechanisms
    "threads": mech.build_threads,
    "threadcaps": mech.build_threadcaps,
    "thumbscrews": mech.build_thumbscrews,
    "ringgears": gears3.build_ringgears,
    "herringbones": gears3.build_herringbones,
    "wormwheels": gears3.build_wormwheels,
    "snapfits": mech2.build_snapfits,
    "livinghinges": mech2.build_livinghinges,
    "heatsinks": mech2.build_heatsinks,
    "cardans": fluid.build_cardans,
    "bearingblocks": fluid.build_bearingblocks,
    "airducts": fluid.build_airducts,
    "fairings": fluid.build_fairings,
    # marine and lattice hardware
    "springclamps": marine.build_springclamps,
    "pipeclamps": marine.build_pipeclamps,
    "cleats": marine.build_cleats,
    "hexlattices": lattice.build_hexlattices,
    "slottedpanels": lattice.build_slottedpanels,
    # sketch profile families
    "cams": sketch3.build_cams,
    "levers": sketch3.build_levers,
    "hooks": sketch3.build_hooks,
    "beltrollers": sketch3.build_beltrollers,
    # wire families (manifest rows carry a node/edge graph)
    "archtrusses": wire3.build_archtrusses,
    "steptowers": wire3.build_steptowers,
    "chassisframes": wire3.build_chassisframes,
    "scissorgrids": wire3.build_scissorgrids,
}

# one line per family for the report table
COVERAGE_NOTES: dict[str, str] = {
    "threads": "metric studs and hex bolts with annular pitch ridges, chamfered tip, plain shank",
    "threadcaps": "caps with an internal thread, closed top, knurled rim or collar",
    "thumbscrews": "lobed grip outline extruded, threaded bore through grip and boss",
    "ringgears": "rim with two tooth bands of different module, webbed ring, lightening holes",
    "herringbones": "two opposite twisted extrusion halves of one tooth outline, hub and keyway",
    "wormwheels": "strongly twisted rim, hub with keyway and a set screw hole",
    "snapfits": "two or four flexible arms ending in undercut hooks with a lead-in ramp",
    "livinghinges": "two plates joined by a 1 mm web, screw bosses and screw holes",
    "heatsinks": "plate fins or a pin array on a base, corner fixing holes, optional flange",
    "cardans": "four stepped trunnions around a hub with an axial lubrication bore",
    "bearingblocks": "UCP-style base, hull foot, round housing, bore, seat and oil groove",
    "airducts": "hull chain of a 90 degree elbow, an S-bend or a tee, flat port flanges, bolts",
    "fairings": "box hull chain tapering to faired ends, hollow passage, optional top ribs",
    "springclamps": "C-band clip with a snap opening, optional mounting tab with a hole",
    "pipeclamps": "ring with a hinge knuckle and pin on one end and a bolt lug on the other",
    "cleats": "boat cleat (base, post, tapered horn) and deck eye strap variants",
    "hexlattices": "point-up hexagon cells cut through a plate, corner holes, optional rim",
    "slottedpanels": "stadium slots whose pitch and length change row by row, rim and holes",
    "cams": "polar r(theta) profile with a smooth lift, hub, bore and keyway",
    "levers": "smooth convex outline through two or three bosses, bores and an adjustment slot",
    "hooks": "boss, shank and a circular curl built from three overlapping outlines",
    "beltrollers": "revolved profile: crowned barrel, guide groove or flanges, bore through",
    "archtrusses": "bridge truss with a parabolic, segmental or cambered top chord (graph)",
    "steptowers": "tiered tower: tapered legs, a ring per level and face crosses (graph)",
    "chassisframes": "rails, cross members, floor brace, corner posts and face crosses (graph)",
    "scissorgrids": "3x3 / 4x4 diamond lattice with an X per cell and boundary chords (graph)",
}


def graph_audit(rows: list[dict]) -> dict[str, int]:
    """Connectivity of every wire graph in the manifest (same rules as verify_corpus)."""
    wire_rows = 0
    disconnected = 0
    isolated = 0
    for row in rows:
        graph = row.get("graph")
        if not graph:
            continue
        wire_rows += 1
        nodes = graph.get("nodes") or []
        edges = graph.get("edges") or []
        adjacency: dict[int, set[int]] = {index: set() for index in range(len(nodes))}
        degree = [0] * len(nodes)
        for edge in edges:
            start, end = int(edge[0]), int(edge[1])
            adjacency[start].add(end)
            adjacency[end].add(start)
            degree[start] += 1
            degree[end] += 1
        if any(value == 0 for value in degree):
            isolated += 1
        seen, stack = {0}, [0]
        while stack:
            current = stack.pop()
            for neighbour in adjacency[current]:
                if neighbour not in seen:
                    seen.add(neighbour)
                    stack.append(neighbour)
        if len(seen) != len(nodes):
            disconnected += 1
    return {
        "wire_rows": wire_rows,
        "disconnected_graphs": disconnected,
        "graphs_with_isolated_nodes": isolated,
    }


def audit(part: Part) -> list[str]:
    """Local audit: static rules, manifold evaluation and the STL gate."""
    result = check_part(part)
    problems = list(result.errors)
    for axis in part.bbox:
        if axis < MIN_AXIS_MM - 1e-6:
            problems.append(f"axis shorter than {MIN_AXIS_MM} mm: {axis}")
        if axis > MAX_AXIS_MM + 1e-6:
            problems.append(f"axis longer than {MAX_AXIS_MM} mm: {axis}")
    if problems:
        return problems
    info = check_source(part.code)
    if is_bad(info):
        problems.append(
            "stl gate: watertight "
            f"{info['watertight']}, components {info['components']}, degenerate {info['degenerate']}"
        )
    return problems


def build(count: int, out_dir: Path, quiet: bool = False, families: list[str] | None = None) -> dict[str, object]:
    """Generate ``count`` samples per family and write the corpus."""
    started = time.time()
    manifest_rows: list[dict[str, object]] = []
    family_stats: dict[str, dict[str, object]] = {}
    rejects: list[dict[str, str]] = []
    written: list[Path] = []
    seen_sources: set[str] = set()
    duplicates = 0

    selected = {name: builder for name, builder in FAMILY_BUILDERS.items() if not families or name in families}
    for family, builder in selected.items():
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
    summary: dict[str, object] = {
        "count": count,
        "samples": len(manifest_rows),
        "families": len(selected),
        "out_dir": str(out_dir),
        "manifest_sha256": checksums,
        "seconds": round(elapsed, 1),
        "family_stats": family_stats,
        "rejects": rejects,
        "duplicates_skipped": duplicates,
        "written": written,
        "audit": graph_audit(manifest_rows),
    }
    if not quiet:
        print(f"\n{len(manifest_rows)} samples in {len(selected)} families, {elapsed:.1f} s")
        print(f"manifest.jsonl sha256 = {checksums}")
        if duplicates:
            print(f"skipped {duplicates} duplicate draws (identical source bytes)")
        if rejects:
            print(f"rejected {len(rejects)} samples (first 5): {rejects[:5]}")
    return summary


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description="Generate the gen3 OpenSCAD corpus")
    parser.add_argument("--count", type=int, default=100, help="samples per family")
    parser.add_argument("--out", type=Path, default=DEFAULT_OUT, help="output directory")
    parser.add_argument("--quiet", action="store_true", help="only print the final summary")
    parser.add_argument("--families", default="", help="comma separated subset of families")
    parser.add_argument("--report", action="store_true", help="write GENERATION_REPORT.md next to the corpus")
    args = parser.parse_args(argv)

    families = [name for name in args.families.split(",") if name]
    summary = build(args.count, args.out, quiet=args.quiet, families=families or None)
    if args.report:
        from tools.dataset_gen2.report import write_report
        from tools.dataset_gen2.verify_corpus import audit_corpus

        # re-audit the files that are actually on disk and put those numbers in
        # the report, so the report can never claim more than the corpus does
        summary["audit"] = audit_corpus(args.out, stl=True)
        write_report(
            args.out,
            summary,
            title="gen3 corpus - generation report",
            corpus_label="optional_data/data/gen3/",
            generator="`tools/dataset_gen3/` (`build3.py`, `families3/*.py`)",
            coverage_notes=COVERAGE_NOTES,
            tool_dir="tools/dataset_gen3",
            build_script="build3.py",
            variant_tag="gen3",
        )
        if not args.quiet:
            print(f"report written to {args.out / 'GENERATION_REPORT.md'}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
