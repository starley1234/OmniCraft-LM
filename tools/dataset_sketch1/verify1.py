"""Standalone audit of a sketch1 corpus on disk (no OpenSCAD needed).

For every manifest row it re-reads the .scad file, re-parses the profile array,
checks that the manifest profile and the code agree, recomputes the area and
the perimeter from the profile, re-evaluates the mesh with the manifold kernel
and compares volume against the profile (area x height for a linear extrusion,
the Pappus theorem for a revolve).  It also verifies SHA256SUMS.txt and that
the RU and EN prompts are unique across the corpus.

    python tools/dataset_sketch1/verify1.py --parts-dir optional_data/data/sketch1
"""

from __future__ import annotations

import argparse
import hashlib
import json
import math
import sys
from pathlib import Path

if __package__ in (None, ""):
    sys.path.insert(0, str(Path(__file__).resolve().parents[2]))

from tools.dataset_sketch1.core1 import BBOX_TOLERANCE, SketchPart, parse_profile
from tools.dataset_sketch1.geom1 import area, centroid_x, perimeter, validate_profile

BBOX_RECEIVER_TOLERANCE = 0.15


def _row_to_part(row: dict, parts_dir: Path) -> SketchPart:
    return SketchPart(
        family=str(row["family"]),
        variant="verify",
        code=(parts_dir / str(row["file"])).read_text(encoding="utf-8"),
        bbox=tuple(float(value) for value in row["expected_bbox_mm"]),
        params={key: float(value) for key, value in (row.get("parameters") or {}).items()},
        prompt_ru=str(row.get("prompt_ru", "")),
        prompt_en=str(row.get("prompt_en", "")),
        profile=[(float(point[0]), float(point[1])) for point in row.get("profile", [])],
        extrude=dict(row.get("extrude") or {}),
    )


def audit_corpus(parts_dir: Path, limit: int | None = None) -> dict:
    from tools.dataset_gen2.miniscad import evaluate_3d

    manifest_path = parts_dir / "manifest.jsonl"
    if not manifest_path.is_file():
        return {"error": f"missing {manifest_path}", "problems": ["missing manifest"]}
    rows = [
        json.loads(line)
        for line in manifest_path.read_text(encoding="utf-8").splitlines()
        if line.strip()
    ]
    if limit is not None:
        rows = rows[:limit]

    problems: list[str] = []
    family_counts: dict[str, int] = {}
    kinds: dict[str, int] = {}
    max_bbox_error = 0.0
    max_volume_error = 0.0
    point_counts: list[int] = []
    ru_seen: dict[str, str] = {}
    en_seen: dict[str, str] = {}
    duplicate_ru = 0
    duplicate_en = 0
    total_area = 0.0
    total_perimeter = 0.0

    for row in rows:
        name = str(row.get("file", ""))
        path = parts_dir / name
        family = str(row.get("family", ""))
        family_counts[family] = family_counts.get(family, 0) + 1
        if not path.is_file():
            problems.append(f"{name}: missing file")
            continue
        part = _row_to_part(row, parts_dir)
        code = part.code

        if not code.startswith("$fn = 32;\n"):
            problems.append(f"{name}: first line is not '$fn = 32;'")
        if len(code.encode("utf-8")) > 12000:
            problems.append(f"{name}: source larger than 12 kB")
        if path.parent.name != family:
            problems.append(f"{name}: family {family!r} does not match the directory")
        linear = code.count("linear_extrude(")
        rotate = code.count("rotate_extrude(")
        if linear + rotate != 1:
            problems.append(f"{name}: {linear + rotate} extrusions instead of one")
        kind = str(part.extrude.get("kind", "?"))
        kinds[kind] = kinds.get(kind, 0) + 1
        if kind == "rotate" and rotate != 1:
            problems.append(f"{name}: manifest says rotate, code has rotate_extrude x{rotate}")
        if kind == "linear" and linear != 1:
            problems.append(f"{name}: manifest says linear, code has linear_extrude x{linear}")

        parsed = parse_profile(code)
        if parsed is None:
            problems.append(f"{name}: profile array not found in the code")
            continue
        if [(round(x, 3), round(y, 3)) for x, y in parsed] != part.profile:
            problems.append(f"{name}: manifest profile differs from the code array")
        for line in validate_profile(part.profile, kind=kind):
            problems.append(f"{name}: {line}")
        point_counts.append(len(part.profile))

        profile_area = area(part.profile)
        total_area += profile_area
        total_perimeter += perimeter(part.profile)

        try:
            mesh = evaluate_3d(code)
        except Exception as exc:  # noqa: BLE001
            problems.append(f"{name}: evaluation failed: {exc}")
            continue
        if len(mesh.decompose()) != 1:
            problems.append(f"{name}: not a single connected solid")
        box = mesh.bounding_box()
        measured = (box[3] - box[0], box[4] - box[1], box[5] - box[2])
        for axis, want, have in zip("XYZ", part.bbox, measured):
            if want <= 0:
                problems.append(f"{name}: axis {axis} target is not positive")
                continue
            error = abs(have - want) / want
            max_bbox_error = max(max_bbox_error, error)
            if error > BBOX_RECEIVER_TOLERANCE:
                problems.append(
                    f"{name}: axis {axis} measured {have:.2f} vs declared {want:.2f} mm ({error:.1%})"
                )
            if have < 5.0 or have > 250.0:
                problems.append(f"{name}: axis {axis} is {have:.2f} mm, outside 5-250 mm")
        volume = float(mesh.volume())
        if kind == "linear":
            expected = profile_area * float(part.extrude["height_mm"])
            tolerance = 0.02
        else:
            expected = profile_area * 2.0 * math.pi * centroid_x(part.profile)
            tolerance = 0.025
        if expected > 0:
            error = abs(volume - expected) / expected
            max_volume_error = max(max_volume_error, error)
            if error > tolerance:
                problems.append(
                    f"{name}: volume {volume:.1f} mm3 vs profile {expected:.1f} mm3 ({error:.1%})"
                )

        ru = str(row.get("prompt_ru", ""))
        en = str(row.get("prompt_en", ""))
        if ru in ru_seen:
            duplicate_ru += 1
            problems.append(f"{name}: duplicate RU prompt (also {ru_seen[ru]})")
        else:
            ru_seen[ru] = name
        if en in en_seen:
            duplicate_en += 1
            problems.append(f"{name}: duplicate EN prompt (also {en_seen[en]})")
        else:
            en_seen[en] = name

    checksums_ok = True
    checksum_path = parts_dir / "SHA256SUMS.txt"
    if checksum_path.is_file():
        for line in checksum_path.read_text(encoding="utf-8").splitlines():
            if not line.strip():
                continue
            digest, _, relative = line.partition("  ")
            target = parts_dir / relative
            if not target.is_file() or hashlib.sha256(target.read_bytes()).hexdigest() != digest:
                checksums_ok = False
                problems.append(f"{relative}: sha256 mismatch")
    else:
        checksums_ok = False
        problems.append("SHA256SUMS.txt is missing")

    return {
        "rows": len(rows),
        "families": len(family_counts),
        "wire_rows": 0,
        "kinds": kinds,
        "points_min": min(point_counts) if point_counts else 0,
        "points_max": max(point_counts) if point_counts else 0,
        "mean_profile_area": total_area / len(rows) if rows else 0.0,
        "mean_profile_perimeter": total_perimeter / len(rows) if rows else 0.0,
        "max_bbox_error": max_bbox_error,
        "bbox_tolerance": BBOX_RECEIVER_TOLERANCE,
        "max_volume_error": max_volume_error,
        "duplicate_ru": duplicate_ru,
        "duplicate_en": duplicate_en,
        "checksums_ok": checksums_ok,
        "problems": problems,
    }


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--parts-dir", type=Path, default=Path("optional_data/data/sketch1"))
    parser.add_argument("--limit", type=int, default=None)
    args = parser.parse_args(argv)

    summary = audit_corpus(args.parts_dir, limit=args.limit)
    if "error" in summary:
        print(summary["error"])
        return 2
    print(f"rows            : {summary['rows']}")
    print(f"families        : {summary['families']}")
    print(f"extrusions      : {summary['kinds']}")
    print(f"profile points  : {summary['points_min']}..{summary['points_max']}")
    print(f"profile means   : area {summary['mean_profile_area']:.0f} mm2, perimeter {summary['mean_profile_perimeter']:.0f} mm")
    print(f"max bbox error  : {summary['max_bbox_error']:.4%} (allowance {summary['bbox_tolerance']:.0%})")
    print(f"max volume error: {summary['max_volume_error']:.4%} (profile vs mesh)")
    print(f"prompt dupes    : RU {summary['duplicate_ru']}, EN {summary['duplicate_en']}")
    print(f"sha256 list     : {'ok' if summary['checksums_ok'] else 'MISMATCH'}")
    print(f"problems        : {'none' if not summary['problems'] else len(summary['problems'])}")
    for line in summary["problems"][:10]:
        print(f"   - {line}")
    return 0 if not summary["problems"] else 1


if __name__ == "__main__":
    raise SystemExit(main())
