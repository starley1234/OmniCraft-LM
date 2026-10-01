"""Independent re-audit of the scale1 corpus straight from the files on disk.

Re-runs per row: SHA-256, header/forbidden constructs, manifold evaluation
(one solid, bbox vs ``expected_bbox_mm``), the family axis rules and the
place1 consistency law on both prompts.

    python tools/dataset_scale1/verify_scale1.py --parts-dir optional_data/data/scale1
"""

from __future__ import annotations

import argparse
import hashlib
import json
import sys
from pathlib import Path
from typing import Any

if __package__ in (None, ""):
    sys.path.insert(0, str(Path(__file__).resolve().parents[2]))

from tools.dataset_gen2.miniscad import MiniScadError, evaluate_3d
from tools.dataset_place1.check_consistency import check_row
from tools.dataset_scale1.build_scale1 import axis_rules

FORBIDDEN = ("import(", "surface(", "text(", "children(", "rands(", "echo(")


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
    declared = [float(value) for value in row.get("expected_bbox_mm") or [0, 0, 0]]
    problems.extend(axis_rules(str(row.get("family", "")), tuple(declared)))
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
    for axis, have, want in zip("XYZ", measured, declared):
        if want <= 0 or abs(have - want) / want > 0.03:
            problems.append(f"axis {axis}: measured {have:.3f} vs declared {want}")
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
        problems = audit_row(row, raw.decode("utf-8"))
        if problems:
            bad_rows.append({"file": str(row["file"]), "problems": problems[:6]})
    families = sorted({str(row.get("family", "?")) for row in manifest})
    return {
        "rows": len(manifest),
        "families": families,
        "hash_bad": hash_bad,
        "bad_rows": bad_rows,
        "duplicate_ru": len(manifest) - len({row["prompt_ru"] for row in manifest}),
        "duplicate_en": len(manifest) - len({row["prompt_en"] for row in manifest}),
    }


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--parts-dir", type=Path, default=Path("optional_data/data/scale1"))
    parser.add_argument("--limit", type=int, default=None)
    parser.add_argument("--json", action="store_true")
    args = parser.parse_args(argv)
    report = audit_corpus(args.parts_dir, args.limit)
    if args.json:
        print(json.dumps(report, ensure_ascii=False, indent=2))
    else:
        print(
            f"{report['rows']} rows | families: {', '.join(report['families'])} | "
            f"sha256 bad {report['hash_bad']} | duplicates {report['duplicate_ru']}/{report['duplicate_en']}"
        )
        for entry in report["bad_rows"][:10]:
            print(f"  BAD {entry['file']}: {entry['problems']}")
    print(f"problems: {len(report['bad_rows'])} rows failed")
    return 1 if report["bad_rows"] or report["hash_bad"] else 0


if __name__ == "__main__":
    sys.exit(main())
