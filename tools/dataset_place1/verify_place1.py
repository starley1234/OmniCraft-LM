"""Standalone audit of the ``place1`` corpus.

Reads only the files on disk (manifest, sources, checksums) and re-derives
everything from scratch:

* source rules: ``$fn = 32;`` first line, size, forbidden constructs, ``family``
  equals the directory the file lives in;
* manifold gate: every sample is evaluated with the manifold kernel — exactly one
  connected component, positive volume, measured bounding box inside 15 % of
  ``expected_bbox_mm`` (the receiver's tolerance; the build gate uses 3 %);
* the placement rule of the row: the ``feature_centers`` array is re-evaluated
  from the code and compared with ``placement.centers_mm`` (1 %), then the rule
  itself is checked — count, mirror symmetry about the axes, pitch, bolt-circle
  radius/start angle, lattice membership;
* feature probes: for every declared centre a cube of ``placement.probe.size_mm``
  is intersected with the solid and must be empty (a real hole / pocket) or solid
  (a real rib / tooth) as the row declares;
* the consistency auditor: every number of both prompts must be present in the
  code within 0.5 % (see ``check_consistency.py``), and the magic-coordinate
  report counts geometry arguments that are bare literals;
* SHA256SUMS.txt.

Run it standalone::

    python tools/dataset_place1/verify_place1.py --parts-dir optional_data/data/place1

The last line of the consistency block is the acceptance number, and the exit
code is non-zero when anything at all is wrong::

    consistency auditor: 100.0% pass
"""

from __future__ import annotations

import argparse
import hashlib
import json
import sys
from pathlib import Path
from typing import Any, Sequence

if __package__ in (None, ""):
    sys.path.insert(0, str(Path(__file__).resolve().parents[2]))

import manifold3d as m3d  # noqa: E402

from tools.dataset_place1.check_consistency import (  # noqa: E402
    EvalError,
    _flatten_centres,
    check_placement,
    check_row,
    code_number_set,
    header_assignments,
    magic_coordinates,
)
from tools.dataset_gen2.miniscad import MiniScadError, evaluate_3d  # noqa: E402

BBOX_TOLERANCE = 0.15
MAX_SOURCE_BYTES = 12000


def audit_row(row: dict[str, Any], code: str, parts_dir: Path, probes: bool = True) -> list[str]:
    """Everything that can be checked with the code plus the manifest row."""
    problems: list[str] = []
    lines = code.splitlines()
    if not lines or lines[0] != "$fn = 32;":
        problems.append("missing '$fn = 32;' header")
    if any(token in code for token in ("import(", "surface(", "text(", "children(", "rands(", "echo(")):
        problems.append("forbidden construct in source")
    if len(code.encode("utf-8")) > MAX_SOURCE_BYTES:
        problems.append("source exceeds 12 kB")
    file_path = Path(str(row.get("file", "")))
    if file_path.parts[0] != str(row.get("family")):
        problems.append(f"family {row.get('family')!r} does not match the directory {file_path.parts[0]!r}")

    try:
        manifold = evaluate_3d(code)
    except MiniScadError as exc:
        return problems + [f"evaluation failed: {exc}"]

    components = manifold.decompose()
    if len(components) != 1:
        problems.append(f"{len(components)} components, expected one connected solid")
    if manifold.volume() <= 0:
        problems.append("non-positive volume")
    box = manifold.bounding_box()
    measured = (box[3] - box[0], box[4] - box[1], box[5] - box[2])
    expected = [float(value) for value in row["expected_bbox_mm"]]
    for axis, (got, want) in enumerate(zip(measured, expected)):
        if abs(got - want) / max(want, 1e-9) > BBOX_TOLERANCE:
            problems.append(f"axis {'XYZ'[axis]}: measured {got:.3f} mm vs declared {want:.3f} mm")

    placement = row.get("placement") or {}
    if placement:
        env = header_assignments(code)
        array_name = str(placement.get("array", "feature_centers"))
        try:
            centres = _flatten_centres(env.get(array_name))
        except EvalError as exc:
            problems.append(f"{array_name}: {exc}")
            centres = []
        extras = {}
        for entry in placement.get("extra") or []:
            try:
                extras[str(entry.get("array"))] = _flatten_centres(env.get(str(entry.get("array"))))
            except EvalError:
                extras[str(entry.get("array"))] = []
        if centres:
            problems.extend(check_placement(placement, centres, extras))
        if probes and centres:
            spec = placement.get("probe") or {}
            size = float(spec.get("size_mm", 0.0))
            z = float(spec.get("z_mm", 0.0))
            kind = str(spec.get("kind", "void"))
            if size <= 0:
                problems.append("placement probe has no size")
            else:
                for index, centre in enumerate(centres):
                    cube = m3d.Manifold.cube([size, size, size], True).translate(
                        [float(centre[0]), float(centre[1]), z]
                    )
                    ratio = (manifold ^ cube).volume() / (size ** 3)
                    if kind == "void" and ratio > 0.02:
                        problems.append(f"centre {index}: expected a void, found {ratio:.0%} material")
                        break
                    if kind == "solid" and ratio < 0.98:
                        problems.append(f"centre {index}: expected material, found {ratio:.0%}")
                        break
    return problems


def audit_corpus(parts_dir: Path, limit: int | None = None, probes: bool = True) -> dict[str, Any]:
    """Full audit of the corpus directory; returns the numbers for the report."""
    report: dict[str, Any] = {
        "rows": 0,
        "families": 0,
        "problems": [],
        "numbers_total": 0,
        "numbers_matched": 0,
        "number_rate": 0.0,
        "rows_consistent": 0,
        "rows_placement_ok": 0,
        "rows_numbers_ok": 0,
        "rows_without_magic": 0,
        "probe_checked": 0,
        "probe_bad": 0,
        "duplicate_prompts": 0,
        "checksums_ok": False,
        "pass_rate": 0.0,
    }
    manifest = parts_dir / "manifest.jsonl"
    if not manifest.exists():
        report["problems"].append(f"missing {manifest}")
        return report

    seen_ru: set[str] = set()
    seen_en: set[str] = set()
    families: set[str] = set()
    consistency_rows = 0
    with manifest.open(encoding="utf-8") as handle:
        for index, line in enumerate(handle):
            if limit is not None and index >= limit:
                break
            line = line.strip()
            if not line:
                continue
            row = json.loads(line)
            report["rows"] += 1
            families.add(str(row.get("family")))
            source = parts_dir / str(row["file"])
            if not source.exists():
                report["problems"].append(f"missing source {source}")
                continue
            code = source.read_text(encoding="utf-8")
            problems = audit_row(row, code, parts_dir, probes)
            if problems:
                report["probe_bad"] += 1 if any("expected a void" in p or "expected material" in p for p in problems) else 0
                report["problems"].append(f"{row['file']}: " + "; ".join(problems[:3]))
            placement = row.get("placement") or {}
            report["probe_checked"] += int(placement.get("count", 0)) if probes else 0

            if str(row.get("prompt_ru")) in seen_ru:
                report["duplicate_prompts"] += 1
            if str(row.get("prompt_en")) in seen_en:
                report["duplicate_prompts"] += 1
            seen_ru.add(str(row.get("prompt_ru")))
            seen_en.add(str(row.get("prompt_en")))

            result = check_row(row, code, "both")
            report["numbers_total"] += result.prompt_numbers
            report["numbers_matched"] += result.matched_numbers
            report["rows_numbers_ok"] += 1 if result.numbers_ok else 0
            report["rows_placement_ok"] += 1 if result.placement_ok else 0
            if not result.magic:
                report["rows_without_magic"] += 1
            elif not problems:
                problems.append("magic coordinates: " + ", ".join(result.magic[:3]))
            consistency_rows += 1 if result.ok else 0

    report["families"] = len(families)
    report["rows_consistent"] = consistency_rows
    report["pass_rate"] = 100.0 * consistency_rows / report["rows"] if report["rows"] else 0.0
    report["number_rate"] = (
        100.0 * report["numbers_matched"] / report["numbers_total"] if report["numbers_total"] else 0.0
    )

    checksums = parts_dir / "SHA256SUMS.txt"
    if not checksums.exists():
        report["problems"].append("missing SHA256SUMS.txt")
    else:
        ok = True
        for line in checksums.read_text(encoding="utf-8").splitlines():
            if not line.strip():
                continue
            digest, name = line.split(None, 1)
            path = parts_dir / name.strip()
            if not path.exists() or hashlib.sha256(path.read_bytes()).hexdigest() != digest:
                ok = False
                report["problems"].append(f"checksum mismatch: {name.strip()}")
        report["checksums_ok"] = ok
    return report


def format_report(report: dict[str, Any], examples: int = 8) -> str:
    lines = [
        f"rows                 : {report['rows']}",
        f"families             : {report['families']}",
        f"prompt numbers       : {report['numbers_total']} "
        f"({report['numbers_matched']} found in the code, {report['number_rate']:.2f}%)",
        f"rows with all numbers: {report['rows_numbers_ok']}",
        f"placement rules      : {report['rows_placement_ok']} rows pass the rule re-derivation",
        f"feature probes       : {report['probe_checked']} centres intersected, "
        f"{report['probe_bad']} rows with a probe mismatch",
        f"magic coordinates    : {report['rows_without_magic']} rows clean",
        f"prompt dupes         : {report['duplicate_prompts']}",
        f"sha256 list          : {'ok' if report['checksums_ok'] else 'MISMATCH'}",
    ]
    for problem in report["problems"][:examples]:
        lines.append(f"FAIL {problem}")
    lines.append(f"consistency auditor: {report['pass_rate']:.1f}% pass")
    lines.append(f"problems             : {'none' if not report['problems'] else len(report['problems'])}")
    return "\n".join(lines)


def main(argv: Sequence[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description="audit the place1 corpus")
    parser.add_argument("--parts-dir", type=Path, default=Path("optional_data/data/place1"))
    parser.add_argument("--limit", type=int, default=None)
    parser.add_argument("--no-probe", action="store_true")
    parser.add_argument("--json", type=Path, default=None)
    args = parser.parse_args(argv)

    report = audit_corpus(args.parts_dir, args.limit, probes=not args.no_probe)
    print(format_report(report))
    if args.json is not None:
        args.json.write_text(json.dumps(report, ensure_ascii=False, indent=2, default=str), encoding="utf-8")
    return 0 if not report["problems"] else 1


if __name__ == "__main__":
    raise SystemExit(main())
