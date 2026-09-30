"""Build the asm1 corpus: one .scad scene per sample plus manifest.jsonl.

Each scene is checked locally before it is written: source rules, assembly
structure (one module per part, every part called once inside ``assembly()``),
per-part manifold check with the analytic volume, world transform prediction,
pairwise clearance >= 0.2 mm and a full STL round trip of the scene and of
every part.

Usage
-----
    python tools/dataset_asm1/build2.py --count 90
    python tools/dataset_asm1/build2.py --count 3 --out /tmp/asm1_smoke --no-stl
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

from tools.dataset_asm1.core2 import CLEARANCE_MM, Scene, check_scene
from tools.dataset_asm1.scenes2 import COVERAGE_NOTES, FAMILY_BUILDERS

DEFAULT_OUT = Path("optional_data/data/asm1")
MIN_PARTS = 2
MAX_PARTS = 6
MIN_AXIS_MM = 5.0
MAX_AXIS_MM = 250.0


def audit(scene: Scene, stl: bool) -> list[str]:
    result = check_scene(scene, stl=stl)
    problems = list(result.errors)
    if not MIN_PARTS <= len(scene.nodes) <= MAX_PARTS:
        problems.append(f"{len(scene.nodes)} parts, the request asks for {MIN_PARTS}-{MAX_PARTS}")
    for axis, value in zip("XYZ", scene.bbox):
        if value < MIN_AXIS_MM - 1e-6:
            problems.append(f"axis {axis} shorter than {MIN_AXIS_MM} mm: {value}")
        if value > MAX_AXIS_MM + 1e-6:
            problems.append(f"axis {axis} longer than {MAX_AXIS_MM} mm: {value}")
    if result.min_gap_mm < CLEARANCE_MM - 1e-4:
        problems.append(f"smallest clearance {result.min_gap_mm:.4f} mm")
    return problems


def build(count: int, out_dir: Path, stl: bool = True, quiet: bool = False) -> dict[str, object]:
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
    gaps: list[float] = []
    checks: list[dict[str, float]] = []

    for family, builder in FAMILY_BUILDERS.items():
        directory = out_dir / family
        directory.mkdir(parents=True, exist_ok=True)
        accepted = 0
        variants: set[str] = set()
        attempts = 0
        max_attempts = count * 4 + 30
        while accepted < count and attempts < max_attempts:
            index = attempts
            attempts += 1
            try:
                scene = builder(index)
            except Exception as exc:  # noqa: BLE001 - a template may refuse a draw
                rejects.append({"family": family, "index": str(index), "reason": f"{type(exc).__name__}: {exc}"})
                continue
            problems = audit(scene, stl)
            if problems:
                rejects.append({"family": family, "index": str(index), "reason": "; ".join(problems)})
                continue
            digest = hashlib.sha256(scene.code.encode("utf-8")).hexdigest()
            if digest in seen_sources:
                duplicates += 1
                continue
            if scene.prompt_ru in seen_ru or scene.prompt_en in seen_en:
                duplicate_prompts += 1
                continue
            seen_sources.add(digest)
            seen_ru.add(scene.prompt_ru)
            seen_en.add(scene.prompt_en)

            relative = f"{family}/scene_{accepted + 1:04d}.scad"
            path = out_dir / relative
            path.write_text(scene.code, encoding="utf-8")
            written.append(path)
            row = scene.manifest_row(relative)
            rows.append(row)
            result = check_scene(scene, stl=False)
            gaps.append(result.min_gap_mm)
            checks.append({"parts": float(len(scene.nodes))})
            variants.add(scene.variant)
            accepted += 1
        family_stats[family] = {
            "requested": count,
            "written": accepted,
            "variants": len(variants),
            "dir": family,
            "attempts": attempts,
        }
        if not quiet:
            print(f"{family:<15} {accepted}/{count} written, {len(variants)} variants, {attempts} attempts", flush=True)

    manifest_path = out_dir / "manifest.jsonl"
    manifest_path.write_text(
        "".join(json.dumps(row, ensure_ascii=False, sort_keys=True) + "\n" for row in rows),
        encoding="utf-8",
    )
    manifest_sha = hashlib.sha256(manifest_path.read_bytes()).hexdigest()
    checksum_lines = [f"{manifest_sha}  manifest.jsonl"]
    for path in sorted(written):
        digest = hashlib.sha256(path.read_bytes()).hexdigest()
        checksum_lines.append(f"{digest}  {path.relative_to(out_dir).as_posix()}")
    (out_dir / "SHA256SUMS.txt").write_text("\n".join(checksum_lines) + "\n", encoding="utf-8")

    elapsed = time.time() - started
    part_counts = [int(check["parts"]) for check in checks]
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
        "min_gap_mm": min(gaps) if gaps else 0.0,
        "mean_gap_mm": sum(gaps) / len(gaps) if gaps else 0.0,
        "parts_min": min(part_counts) if part_counts else 0,
        "parts_max": max(part_counts) if part_counts else 0,
        "stl_checked": len(rows) if stl else 0,
    }
    if not quiet:
        print(f"\n{len(rows)} scenes in {len(FAMILY_BUILDERS)} families, {elapsed:.1f} s")
        print(f"parts per scene {summary['parts_min']}..{summary['parts_max']}, clearance >= {summary['min_gap_mm']:.3f} mm")
        print(f"manifest.jsonl sha256 = {manifest_sha}")
        if duplicates or duplicate_prompts:
            print(f"skipped {duplicates} duplicate scenes, {duplicate_prompts} duplicate prompts")
        if rejects:
            print(f"rejected {len(rejects)} draws (first 5): {rejects[:5]}")
    return summary


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description="Generate the asm1 corpus")
    parser.add_argument("--count", type=int, default=90, help="scenes per family")
    parser.add_argument("--out", type=Path, default=DEFAULT_OUT)
    parser.add_argument("--no-stl", action="store_true", help="skip the STL round trip in the local gate")
    parser.add_argument("--quiet", action="store_true")
    parser.add_argument("--report", action="store_true", help="write GENERATION_REPORT.md next to the corpus")
    args = parser.parse_args(argv)

    summary = build(args.count, args.out, stl=not args.no_stl, quiet=args.quiet)
    if args.report:
        from tools.dataset_asm1.verify2 import audit_corpus
        from tools.dataset_gen2.report import write_report

        corpus_audit = audit_corpus(args.out)
        summary["audit"] = corpus_audit
        write_report(
            args.out,
            summary,
            title="asm1 corpus - generation report",
            corpus_label="optional_data/data/asm1",
            generator="`tools/dataset_asm1/` (`build2.py`, `scenes2.py`, `parts2.py`, `core2.py`)",
            coverage_notes=COVERAGE_NOTES,
            tool_dir="tools/dataset_asm1",
            build_script="build2.py",
            variant_tag="asm1",
            schema_fields="`assembly` (module + `t` + w-last `q` per part)",
            extra_bullets=[
                f"assembly gate: every scene re-evaluated with the manifold kernel, "
                f"{corpus_audit.get('parts_total', 0)} placed parts in {corpus_audit.get('rows', 0)} scenes, "
                f"smallest pairwise clearance {corpus_audit.get('min_gap', 0):.3f} mm "
                f"(the request asks for >= 0.2 mm)",
                f"transform audit: the `assembly` rows carry mm translations and w-last quaternions; "
                f"{corpus_audit.get('transform_rows', 0)} rows replayed, "
                f"{corpus_audit.get('transform_bad', 0)} mismatching the code",
                f"part volumes add up: worst |sum(parts) - scene| "
                f"{corpus_audit.get('max_volume_sum_error', 0):.2%} of the scene volume, so no two parts "
                "overlap and nothing is dropped; the build gate additionally compared every part with "
                "its designed solid (2 %) before writing it",
                f"prompt uniqueness: duplicate RU {corpus_audit.get('duplicate_ru', 0)}, "
                f"duplicate EN {corpus_audit.get('duplicate_en', 0)}",
            ],
        )
        if not args.quiet:
            print(f"report written to {args.out / 'GENERATION_REPORT.md'}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
