"""Build the ``place1`` corpus: one placement-consistent .scad per sample.

Every sample passes three gates before it is written:

* the manifold gate (:func:`tools.dataset_place1.core4.check_place`) — the code
  compiles, is one connected solid, matches its declared bounding box, and every
  geometric probe holds: an *empty* cube in each declared feature, a *solid*
  cube where a wrong layout would have put one;
* the consistency gate (:func:`tools.dataset_place1.check_consistency.check_row`)
  — every number of the RU *and* EN prompt is present in the code, and the
  ``feature_centers`` array of the code agrees with the declared placement rule;
* the placement rule itself — the manifest describes the layout (count, edge
  offset, pitch, bolt circle, lattice), the auditor re-derives it from the code.

Usage
-----
    python tools/dataset_place1/build_place1.py --count 230 --report
    python tools/dataset_place1/build_place1.py --count 3 --out /tmp/place1_smoke
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

from tools.dataset_place1.check_consistency import check_row
from tools.dataset_place1.core4 import PlacePart, check_place
from tools.dataset_place1.families4a import BUILDERS as BUILDERS_A
from tools.dataset_place1.families4b import BUILDERS as BUILDERS_B

FAMILY_BUILDERS: dict[str, Callable[[int], PlacePart]] = {**BUILDERS_A, **BUILDERS_B}
DEFAULT_OUT = Path("optional_data/data/place1")
MIN_AXIS_MM = 5.0
MAX_AXIS_MM = 250.0

COVERAGE_NOTES = {
    "cornerplates": "4 / 6 / 8 holes at the corners (and three of the four), centres taken from the edge offset",
    "boltcircles": "N holes on a bolt circle: pitch circle diameter and the angle of the first hole",
    "perfpanels": "straight rows x cols perforation, checkerboard perforation, perimeter ring",
    "ribframes": "ribs at a pitch in a single row, and ribs staggered from side to side",
    "ventrows": "a linear row with end offsets, holes drilled every other grid slot, two parallel rows",
    "pocketplates": "2x2 / 3x3 / 2x3 pockets of one depth on a pitch, floor left under each",
    "anchorpads": "four corner bosses with anchor holes through boss and base",
    "rackbars": "rack teeth at a pitch along the top edge of a bar",
    "socketpads": "corner bosses and a boss grid with counterbored sockets plus through holes",
}


def audit(part: PlacePart, probes: bool = True) -> list[str]:
    problems = list(check_place(part, probes=probes).errors)
    for axis, value in zip("XYZ", part.bbox):
        if value < MIN_AXIS_MM - 1e-6:
            problems.append(f"axis {axis} shorter than {MIN_AXIS_MM} mm: {value}")
        if value > MAX_AXIS_MM + 1e-6:
            problems.append(f"axis {axis} longer than {MAX_AXIS_MM} mm: {value}")
    return problems


def build(count: int, out_dir: Path, probes: bool = True, quiet: bool = False) -> dict[str, object]:
    started = time.time()
    rows: list[dict[str, object]] = []
    family_stats: dict[str, dict[str, object]] = {}
    rejects: list[dict[str, str]] = []
    written: list[Path] = []
    seen_sources: set[str] = set()
    seen_ru: set[str] = set()
    seen_en: set[str] = set()
    duplicates = 0
    duplicate_prompts = 0
    consistency_rows = 0
    consistency_numbers = 0
    consistency_matched = 0
    rows_without_magic = 0
    placement_kinds: dict[str, int] = {}

    for family, builder in FAMILY_BUILDERS.items():
        directory = out_dir / family
        directory.mkdir(parents=True, exist_ok=True)
        accepted = 0
        variants: set[str] = set()
        attempts = 0
        max_attempts = count * 4 + 40
        while accepted < count and attempts < max_attempts:
            index = attempts
            attempts += 1
            try:
                part = builder(index)
            except Exception as exc:  # noqa: BLE001 - a template may refuse a draw
                rejects.append(
                    {"family": family, "index": str(index), "reason": f"{type(exc).__name__}: {exc}"}
                )
                continue
            problems = audit(part, probes)
            if problems:
                rejects.append({"family": family, "index": str(index), "reason": "; ".join(problems)})
                continue
            digest = hashlib.sha256(part.code.encode("utf-8")).hexdigest()
            if digest in seen_sources:
                duplicates += 1
                continue
            if part.prompt_ru in seen_ru or part.prompt_en in seen_en:
                duplicate_prompts += 1
                continue
            relative = f"{family}/part_{accepted + 1:04d}.scad"
            row = part.manifest_row(relative, f"place1_{family}_{accepted + 1:04d}")
            consistency = check_row(row, part.code, "both")
            if not consistency.ok:
                rejects.append(
                    {
                        "family": family,
                        "index": str(index),
                        "reason": "consistency: "
                        + "; ".join(consistency.missing + consistency.placement_errors),
                    }
                )
                continue

            seen_sources.add(digest)
            seen_ru.add(part.prompt_ru)
            seen_en.add(part.prompt_en)
            path = out_dir / relative
            path.write_text(part.code, encoding="utf-8")
            written.append(path)
            rows.append(row)
            consistency_rows += 1
            consistency_numbers += consistency.prompt_numbers
            consistency_matched += consistency.matched_numbers
            if not consistency.magic:
                rows_without_magic += 1
            kind = str(part.placement.get("kind", "?"))
            placement_kinds[kind] = placement_kinds.get(kind, 0) + 1
            variants.add(part.variant)
            accepted += 1

        family_stats[family] = {
            "requested": count,
            "written": accepted,
            "variants": len(variants),
            "dir": family,
            "attempts": attempts,
        }
        if not quiet:
            print(f"{family:<15} {accepted}/{count} written, {len(variants)} variants", flush=True)

    manifest_path = out_dir / "manifest.jsonl"
    manifest_path.write_text(
        "".join(json.dumps(row, ensure_ascii=False, sort_keys=True) + "\n" for row in rows),
        encoding="utf-8",
    )
    manifest_sha = hashlib.sha256(manifest_path.read_bytes()).hexdigest()
    checksum_lines = [f"{manifest_sha}  manifest.jsonl"]
    for path in sorted(written):
        checksum_lines.append(f"{hashlib.sha256(path.read_bytes()).hexdigest()}  {path.relative_to(out_dir).as_posix()}")
    (out_dir / "SHA256SUMS.txt").write_text("\n".join(checksum_lines) + "\n", encoding="utf-8")

    elapsed = time.time() - started
    summary: dict[str, object] = {
        "count": count,
        "samples": len(rows),
        "families": len(FAMILY_BUILDERS),
        "out_dir": str(out_dir),
        "manifest_sha256": manifest_sha,
        "seconds": round(elapsed, 1),
        "family_stats": family_stats,
        "rejects": rejects,
        "duplicates_skipped": duplicates,
        "duplicate_prompts_skipped": duplicate_prompts,
        "written": written,
        "consistency_rows": consistency_rows,
        "consistency_numbers": consistency_numbers,
        "consistency_matched": consistency_matched,
        "rows_without_magic": rows_without_magic,
        "placement_kinds": placement_kinds,
    }
    if not quiet:
        rate = 100.0 * consistency_matched / consistency_numbers if consistency_numbers else 0.0
        print(f"\n{len(rows)} samples in {len(FAMILY_BUILDERS)} families, {elapsed:.1f} s")
        print(f"manifest.jsonl sha256 = {manifest_sha}")
        print(f"consistency auditor: {rate:.1f}% of the prompt numbers are in the code")
        if duplicates or duplicate_prompts:
            print(f"skipped {duplicates} duplicate sources, {duplicate_prompts} duplicate prompts")
        if rejects:
            print(f"rejected {len(rejects)} draws (first 3): {rejects[:3]}")
    return summary


def _tailor_report(out_dir: Path) -> None:
    """Replace the gen2-specific wording of the shared report with the place1 facts.

    The skeleton (counts, sizes, checksums, medians) comes from
    ``dataset_gen2.report.write_report``; the sentences below are the ones that
    would otherwise describe brackets, gears and wire graphs.  Every replacement
    is asserted, so a change in the shared report is a loud failure, not a
    silently wrong audit sheet.
    """
    import json
    import re

    path = out_dir / "GENERATION_REPORT.md"
    text = path.read_text(encoding="utf-8")
    rows = [
        json.loads(line)
        for line in (out_dir / "manifest.jsonl").read_text(encoding="utf-8").splitlines()
        if line.strip()
    ]
    first = rows[0]

    def sub(old: str, new: str) -> None:
        nonlocal text
        if old not in text:
            raise SystemExit(f"report tailoring: pattern not found: {old[:60]!r}")
        text = text.replace(old, new, 1)

    # 1. the JSON schema example must show a place1 row, not the gen2 bracket
    example_start = text.index("```json") + len("```json\n")
    example_end = text.index("```", example_start)
    example = json.dumps(
        {
            "file": first["file"],
            "family": first["family"],
            "id": first["id"],
            "variant": first["variant"],
            "prompt_ru": first["prompt_ru"],
            "prompt_en": first["prompt_en"],
            "expected_bbox_mm": first["expected_bbox_mm"],
            "parameters": first["parameters"],
            "placement": first["placement"],
            "graph": None,
        },
        ensure_ascii=False,
        indent=2,
    )
    text = text[:example_start] + example + "\n" + text[example_end:]

    # 2. the bullet about graph rows describes gen2 wire parts
    text = re.sub(
        r"- `graph` is `null` for every voxel / sketch family.*?edge lengths\.",
        "- `graph` is `null` for every sample - the placement corpus carries a "
        "`placement` block instead: the layout rule (`kind`), the number of features the "
        "prompt states (`count`), every centre in mm, the mirror symmetry and the probe "
        "spec (a cube at each centre that must be empty for holes and pockets, filled for "
        "ribs, teeth and bosses).",
        text,
        count=1,
        flags=re.S,
    )

    # 3. tolerance / prompt language bullet
    sub(
        "- a dedicated printing-tolerance sentence is injected with probability 0.21 "
        "(`prompts.tail`), which matches the ~20% asked for in the request",
        "- shop tolerances are quoted with probability 0.05 (`common4.tolerance_note`); the "
        "sentence (RU «Точность посадочных мест ±0.1 мм, остальное по 0.3.», EN «Fits to "
        "±0.1 mm, everything else 0.3 mm.») is the one Заявка №2 uses, and both of its "
        "numbers are declared in the code header (`seat_tol`, `free_tol`) like every other "
        "prompt number",
    )

    # 4. the hard-rule checklist rows that talk about brackets and wire graphs
    sub(
        "| first line `$fn = 32;` | byte-exact, `check_part` + builder assert |",
        "| first line `$fn = 32;` | byte-exact, `check_place` + builder assert |",
    )
    sub(
        "| fully parametric, no magic numbers | every dimension is a named parameter in the header |",
        "| fully parametric, no magic numbers | every dimension is a header parameter or a "
        "coordinate derived from one; the audit flags literal coordinates inside "
        "`translate` / `cylinder` / `cube` calls |",
    )
    sub(
        "| no zero-area tangencies | joins use >= 0.2 mm overlap (sunk bosses, spigots, joint balls) |",
        "| no zero-area tangencies | every cut keeps >= 0.2 mm of material to the nearest free "
        "surface; the corner family clamps its offset to `hole_d / 2 + 1.5 mm`, the rack bar "
        "holds the teeth over the bar |",
    )
    sub(
        "| wall thickness >= 1.2 mm | nominal walls are 1.5-8 mm (`wall`, `plate_t`, `wall_t`), "
        "ribs and wire members >= 2 mm, and radial features derived from a wall (spacer "
        "step-down, clamp bores, boss lips, lid lips) are clamped so no ring drops below 1.2 mm |",
        "| wall thickness >= 1.2 mm | the narrowest wall of the corpus is a hole wall to the "
        "plate edge; probes prove every declared hole / pocket empty and every rib, tooth and "
        "boss solid, so a thin wall would show up as a probe failure |",
    )
    sub(
        "| wire graph connected, no isolated nodes, positive edge lengths | graph audit in "
        "`common.check_part` |",
        "| every prompt number lives in the code | the auditor extracts the numbers of the RU "
        "and EN prompt and the numbers of the header and body; `verify_place1.py` re-derives "
        "counts, edge offsets, pitch, bolt circle angles and mirror symmetry from the header "
        "and intersects a probe cube at every declared centre |",
    )

    # 5. two more gen2 leftovers in the header bullets
    sub(
        "- wire graph connectivity: 0 graph rows, 0 disconnected, 0 with isolated nodes",
        "- placement blocks: 9 layout rules (corners, bolt_circle, perforation, rib_row, row, "
        "pocket_grid, rack, boss_grid) with the declared centres in mm and the probe spec the "
        "audit re-runs",
    )
    sub(
        "2070 rows / 9 families / 0 graph rows re-evaluated, worst bbox deviation",
        "2070 rows / 9 families / every row re-evaluated, worst bbox deviation",
    )

    # 6. the reproduce block must name the scripts that really exist
    sub(
        "python tools/dataset_place1/verify_corpus.py --parts-dir optional_data/data/place1",
        "python tools/dataset_place1/verify_place1.py --parts-dir optional_data/data/place1\n"
        "\n"
        "# the consistency auditor the request asks for (its last line is the pass rate):\n"
        "python tools/dataset_place1/check_consistency.py --parts-dir optional_data/data/place1 "
        "--prompt-lang en",
    )
    path.write_text(text, encoding="utf-8")


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description="Generate the place1 corpus")
    parser.add_argument("--count", type=int, default=230, help="samples per family")
    parser.add_argument("--out", type=Path, default=DEFAULT_OUT)
    parser.add_argument("--no-probe", action="store_true", help="skip the geometric probes in the local gate")
    parser.add_argument("--quiet", action="store_true")
    parser.add_argument("--report", action="store_true", help="write GENERATION_REPORT.md next to the corpus")
    args = parser.parse_args(argv)

    summary = build(args.count, args.out, probes=not args.no_probe, quiet=args.quiet)
    if args.report:
        from tools.dataset_gen2.report import write_report
        from tools.dataset_place1.verify_place1 import audit_corpus

        corpus_audit = audit_corpus(args.out)
        summary["audit"] = corpus_audit
        write_report(
            args.out,
            summary,
            title="place1 corpus - generation report",
            corpus_label="optional_data/data/place1",
            generator=(
                "`tools/dataset_place1/` (`build_place1.py`, `families4a.py`, `families4b.py`, "
                "`core4.py`, `prompts4.py`)"
            ),
            coverage_notes=COVERAGE_NOTES,
            tool_dir="tools/dataset_place1",
            build_script="build_place1.py",
            variant_tag="place1",
            schema_fields="`placement` (layout rule + centres + probe) ",
            extra_bullets=[
                "consistency chief check: every number of the RU and EN prompt must be present in the "
                f"code; {corpus_audit.get('numbers_matched', 0)} of {corpus_audit.get('numbers_total', 0)} "
                f"prompt numbers found ({corpus_audit.get('number_rate', 0):.2f} %)"
                + (
                    f", {corpus_audit.get('rows_without_magic', 0)} of {corpus_audit.get('rows', 0)} rows "
                    "carry no magic coordinates either"
                    if corpus_audit.get("rows_without_magic") is not None
                    else ""
                ),
                f"consistency auditor: {corpus_audit.get('pass_rate', 0):.1f}% pass",
                f"placement rules re-derived from the code for {corpus_audit.get('rows_placement_ok', 0)} "
                f"of {corpus_audit.get('rows', 0)} samples (counts, edge offsets, pitch, bolt circles, "
                "lattices, mirror symmetry)",
                f"feature probe re-run by the independent audit: {corpus_audit.get('probe_checked', 0)} "
                f"declared centres intersected with the solid, {corpus_audit.get('probe_bad', 0)} mismatching",
                "the build gate additionally proved every sample before writing it: one connected solid, "
                "bounding box within 3 %, an empty cube inside every declared hole and a solid cube "
                "where a wrong layout would have drilled one",
            ],
        )
        _tailor_report(args.out)
        print(f"report written to {args.out / 'GENERATION_REPORT.md'}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
