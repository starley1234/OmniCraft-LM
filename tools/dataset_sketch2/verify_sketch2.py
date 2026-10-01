"""Independent re-audit of the sketch2 corpus straight from the files on disk.

For every manifest row this verifier re-runs, trusting nothing from the build:
SHA-256, header/forbidden constructs, manifold evaluation (one solid, bbox,
analytic volume), profile/void rules (Shoelace sign, simplicity, containment,
wall floors) and the place1 consistency law on both prompts.

    python tools/dataset_sketch2/verify_sketch2.py --parts-dir optional_data/data/sketch2
"""

from __future__ import annotations

import argparse
import hashlib
import json
import math
import sys
from pathlib import Path
from typing import Any

if __package__ in (None, ""):
    sys.path.insert(0, str(Path(__file__).resolve().parents[2]))

from tools.dataset_gen2.miniscad import MiniScadError, evaluate_3d
from tools.dataset_place1.check_consistency import check_row
from tools.dataset_sketch1.geom1 import area, bbox2, centroid_x, is_simple, signed_area
from tools.dataset_sketch2.core2s import (
    FORBIDDEN,
    _distance_to_ring,
    _is_simple_ring,
    convex_clip_area,
    point_in_polygon,
)


def audit_row(row: dict[str, Any], code: str) -> list[str]:
    problems: list[str] = []
    lines = code.splitlines()
    if not lines or lines[0] != "$fn = 32;":
        problems.append("missing '$fn = 32;' header")
    for token in FORBIDDEN:
        if token in code:
            problems.append(f"forbidden construct {token}")
    if len(code.encode("utf-8")) > 12000:
        problems.append("source larger than 12 kB")

    profile = [tuple(point) for point in row.get("profile") or []]
    extrude = row.get("extrude") or {}
    kind = str(extrude.get("kind"))
    if not (6 <= len(profile) <= 64):
        problems.append(f"profile has {len(profile)} points, allowed 6..64")
    if not is_simple(profile):
        problems.append("profile is not a simple polygon")
    if signed_area(profile) <= 0:
        problems.append("profile is not counter clockwise")
    if any(x < -1e-9 or y < -1e-9 for x, y in profile):
        problems.append("profile has a negative coordinate")
    voids = [[tuple(p) for p in ring] for ring in row.get("voids_profiles") or []]
    depths = row.get("void_depth_mm") or []
    if voids and len(depths) != len(voids):
        problems.append("voids_profiles and void_depth_mm disagree in length")
    outer_box = bbox2(profile)
    for index, void in enumerate(voids):
        if not _is_simple_ring(void):
            problems.append(f"void {index} is not simple")
        box = bbox2(void)
        enclosed = (box[0] >= outer_box[0] - 1e-9 and box[1] >= outer_box[1] - 1e-9
                    and box[2] <= outer_box[2] + 1e-9 and box[3] <= outer_box[3] + 1e-9)
        if enclosed:
            for point in void:
                if not point_in_polygon(point, profile):
                    problems.append(f"void {index} leaves the profile")
                    break
                if _distance_to_ring(point, profile) < 1.2:
                    problems.append(f"void {index} comes within 1.2 mm of the boundary")
                    break
        if index < len(depths):
            depth = float(depths[index])
            if depth <= 0:
                problems.append(f"void {index} depth is not positive")
            elif kind == "linear" and depth > float(extrude.get("height_mm", 0)) + 1e-9:
                problems.append(f"void {index} is deeper than the extrusion")

    try:
        mesh = evaluate_3d(code)
    except MiniScadError as exc:
        problems.append(f"evaluation failed: {exc}")
        return problems
    if len(mesh.decompose()) != 1:
        problems.append(f"{len(mesh.decompose())} components, expected 1")
    volume = float(mesh.volume())
    if volume <= 0:
        problems.append("non-positive volume")
    box = mesh.bounding_box()
    measured = (box[3] - box[0], box[4] - box[1], box[5] - box[2])
    declared = row.get("expected_bbox_mm") or [0, 0, 0]
    for axis, have, want in zip("XYZ", measured, declared):
        if want <= 0 or abs(have - want) / want > 0.03:
            problems.append(f"axis {axis}: measured {have:.3f} vs declared {want}")
        if have < 5.0 or have > 250.0:
            problems.append(f"axis {axis} = {have:.2f} mm outside 5..250")
    if kind == "linear":
        height = float(extrude.get("height_mm", 0))
        expected = area(profile) * height
        for void, depth in zip(voids, depths):
            expected -= convex_clip_area(void, profile) * min(float(depth), height)
        if expected > 0 and abs(volume - expected) / expected > 0.015:
            problems.append(f"volume {volume:.1f} mm3 vs analytic {expected:.1f} mm3")
    elif kind == "rotate":
        expected = area(profile) * 2.0 * math.pi * centroid_x(profile)
        if expected > 0 and abs(volume - expected) / expected > 0.02:
            problems.append(f"revolved volume {volume:.1f} mm3 vs Pappus {expected:.1f} mm3")
    else:
        problems.append(f"unknown extrude kind {kind!r}")
    for language in ("en", "ru"):
        report = check_row(row, code, prompt_lang=language)
        if not report.numbers_ok:
            problems.append(f"prompt[{language}] numbers missing in code: {report.missing[:4]}")
    return problems


def audit_corpus(parts_dir: Path, limit: int | None = None) -> dict[str, Any]:
    manifest = [
        json.loads(line)
        for line in (parts_dir / "manifest.jsonl").read_text(encoding="utf-8").splitlines()
        if line.strip()
    ]
    if limit:
        manifest = manifest[:limit]
    hashes: dict[str, str] = {}
    sums_path = parts_dir / "SHA256SUMS.txt"
    if sums_path.is_file():
        for line in sums_path.read_text(encoding="utf-8").splitlines():
            digest, _, relative = line.partition("  ")
            hashes[relative.strip()] = digest.strip()
    bad_rows: list[dict[str, Any]] = []
    hash_bad = 0
    points_stat: list[int] = []
    for row in manifest:
        path = parts_dir / str(row["file"])
        raw = path.read_bytes()
        expected = hashes.get(str(row["file"]))
        if expected is not None:
            actual = hashlib.sha256(raw).hexdigest()
            if actual != expected and hashlib.sha256(raw.replace(b"\r\n", b"\n")).hexdigest() != expected:
                hash_bad += 1
                bad_rows.append({"file": str(row["file"]), "problems": ["sha256 mismatch"]})
                continue
        code = raw.decode("utf-8")
        problems = audit_row(row, code)
        if problems:
            bad_rows.append({"file": str(row["file"]), "problems": problems[:6]})
        points_stat.append(len(row.get("profile") or []))
    families = sorted({str(row.get("family", "?")) for row in manifest})
    return {
        "rows": len(manifest),
        "families": families,
        "hash_bad": hash_bad,
        "bad_rows": bad_rows,
        "points_min": min(points_stat) if points_stat else 0,
        "points_max": max(points_stat) if points_stat else 0,
        "void_rows": sum(1 for row in manifest if row.get("voids_profiles")),
        "revolve_rows": sum(1 for row in manifest if (row.get("extrude") or {}).get("kind") == "rotate"),
        "duplicate_ru": len(manifest) - len({row["prompt_ru"] for row in manifest}),
        "duplicate_en": len(manifest) - len({row["prompt_en"] for row in manifest}),
    }


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--parts-dir", type=Path, default=Path("optional_data/data/sketch2"))
    parser.add_argument("--limit", type=int, default=None)
    parser.add_argument("--json", action="store_true")
    args = parser.parse_args(argv)
    report = audit_corpus(args.parts_dir, args.limit)
    if args.json:
        print(json.dumps(report, ensure_ascii=False, indent=2))
    else:
        print(
            f"{report['rows']} rows | families: {', '.join(report['families'])} | "
            f"profile points {report['points_min']}..{report['points_max']} | "
            f"voids {report['void_rows']} | revolves {report['revolve_rows']} | "
            f"sha256 bad {report['hash_bad']} | duplicates {report['duplicate_ru']}/{report['duplicate_en']}"
        )
        for entry in report["bad_rows"][:10]:
            print(f"  BAD {entry['file']}: {entry['problems']}")
    print(f"problems: {len(report['bad_rows'])} rows failed")
    return 1 if report["bad_rows"] or report["hash_bad"] else 0


if __name__ == "__main__":
    sys.exit(main())
