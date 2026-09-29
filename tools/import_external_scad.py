"""Import external OpenSCAD corpora (optional_data/) into the canonical JSONL schema.

Canonicalization rules (ARCHITECTURE.md / AGENTS.md invariants):
- every record's ``code`` starts with exactly ``"$fn = 32;\n"``; any existing
  ``$fn`` assignment is rewritten to 32 so the facet resolution invariant holds;
- comments are preserved; geometry below the header is untouched;
- ``target_bbox`` comes from the corpus' ``expected_bbox_mm`` when present.

The imported rows are *candidates*: run them through ``tools/validate_dataset.py``
(--backend openscad) before training. They carry no ``analytic_geometry``
provenance, so acceptance is decided purely by the compiled manifold mesh.

    python tools/import_external_scad.py \
        --domain-expansion optional_data/data/domain_expansion.jsonl \
        --parts-dir optional_data/data/parts \
        --output data/processed/external_candidates.jsonl
"""

from __future__ import annotations

import argparse
import hashlib
import json
import re
import sys
from pathlib import Path

REPOSITORY_ROOT = Path(__file__).resolve().parents[1]
if str(REPOSITORY_ROOT) not in sys.path:
    sys.path.insert(0, str(REPOSITORY_ROOT))

from src.data.schema import CADSample, SampleVerification, write_jsonl

_HEADER = "$fn = 32;"
_FN_ASSIGNMENT = re.compile(r"^\s*\$fn\s*=\s*[0-9]+\s*;\s*$", re.MULTILINE)


def _clean_code(code: str) -> str:
    """Strip existing ``$fn = N;`` lines and prepend the canonical header."""
    body = _FN_ASSIGNMENT.sub("", code)
    body = body.lstrip()
    return f"{_HEADER}\n{body}"


def _target_bbox(raw: object) -> tuple[float, float, float] | None:
    if not isinstance(raw, (list, tuple)) or len(raw) != 3:
        return None
    try:
        values = tuple(float(value) for value in raw)
    except (TypeError, ValueError):
        return None
    if any(value <= 0 for value in values):
        return None
    return values  # type: ignore[return-value]


def _make_sample(
    *,
    record_id: str,
    prompts: dict[str, str],
    code: str,
    target_bbox: tuple[float, float, float] | None,
    source: str,
    origin: str,
) -> CADSample | None:
    code = _clean_code(code)
    if target_bbox is None:
        # Cannot train scale injection without a target box; skip the record.
        return None
    return CADSample(
        id=record_id,
        layer="voxel",
        prompts={k: v for k, v in prompts.items() if v},
        code=code,
        verification=SampleVerification(target_bbox=target_bbox),
        metadata={
            "source": source,
            "origin": origin,
            "code_sha256": hashlib.sha256(code.encode("utf-8")).hexdigest(),
        },
    )


def import_domain_expansion(path: Path) -> list[CADSample]:
    samples: list[CADSample] = []
    for index, line in enumerate(path.read_text(encoding="utf-8").splitlines()):
        if not line.strip():
            continue
        row = json.loads(line)
        sample = _make_sample(
            record_id=f"ext_domain_{index:05d}",
            prompts={"ru": str(row.get("prompt_ru", "")), "en": str(row.get("prompt_en", ""))},
            code=str(row["scad_code"]),
            target_bbox=_target_bbox(row.get("expected_bbox_mm")),
            source="domain_expansion_import",
            origin=f"{row.get('category', '?')}/{row.get('subtype', '?')}",
        )
        if sample is not None and sample.prompts:
            samples.append(sample)
    return samples


def import_parts(parts_dir: Path, *, fill_bbox_with_openscad: bool = False, workers: int = 1) -> list[CADSample]:
    manifest_path = parts_dir / "manifest.jsonl"
    manifest = [json.loads(line) for line in manifest_path.read_text(encoding="utf-8").splitlines() if line.strip()]

    compiled_bbox: dict[str, tuple[float, float, float]] = {}
    needed = [
        (index, entry)
        for index, entry in enumerate(manifest)
        if _target_bbox(entry.get("expected_bbox_mm")) is None
        and (parts_dir / str(entry["file"])).is_file()
    ]
    if needed and fill_bbox_with_openscad:
        from concurrent.futures import ThreadPoolExecutor

        from src.env.openscad_runner import CADExecutableNotFound, OpenSCADRunner

        try:
            runner = OpenSCADRunner()
        except CADExecutableNotFound as exc:
            raise SystemExit(str(exc)) from exc

        def measure(item: tuple[int, dict]) -> tuple[str, tuple[float, float, float] | None]:
            index, entry = item
            code = _clean_code((parts_dir / str(entry["file"])).read_text(encoding="utf-8"))
            result = runner.compile(code)
            return str(entry["file"]), result.bbox if result.error is None else None

        iterator = map(measure, needed) if workers == 1 else ThreadPoolExecutor(
            max_workers=workers, thread_name_prefix="bbox-fill"
        ).map(measure, needed)
        misses = 0
        for file_name, bbox in iterator:
            if bbox is None:
                misses += 1
                continue
            compiled_bbox[file_name] = bbox
        if misses:
            print(f"parts: {misses} files failed the pre-import bbox measurement")

    samples: list[CADSample] = []
    for index, entry in enumerate(manifest):
        scad_path = parts_dir / str(entry["file"])
        if not scad_path.is_file():
            continue
        target = _target_bbox(entry.get("expected_bbox_mm")) or compiled_bbox.get(str(entry["file"]))
        sample = _make_sample(
            record_id=f"ext_part_{index:05d}",
            prompts={
                "ru": str(entry.get("prompt_ru", "")),
                "en": str(entry.get("prompt_en", "") or entry.get("name", "")),
            },
            code=scad_path.read_text(encoding="utf-8"),
            target_bbox=target,
            source="parts_import",
            origin=str(entry.get("category", "?")),
        )
        if sample is not None and sample.prompts:
            samples.append(sample)
    return samples


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--domain-expansion", type=Path, default=None)
    parser.add_argument("--parts-dir", type=Path, default=None)
    parser.add_argument("--output", type=Path, default=Path("data/processed/external_candidates.jsonl"))
    parser.add_argument(
        "--fill-bbox-with-openscad",
        action="store_true",
        help="measure missing target bboxes by compiling the part with OpenSCAD first",
    )
    parser.add_argument("--workers", type=int, default=8)
    return parser


def main() -> int:
    args = build_parser().parse_args()
    if args.domain_expansion is None and args.parts_dir is None:
        raise SystemExit("provide --domain-expansion and/or --parts-dir")
    samples: list[CADSample] = []
    if args.domain_expansion is not None:
        imported = import_domain_expansion(args.domain_expansion)
        print(f"domain_expansion: {len(imported)} records")
        samples.extend(imported)
    if args.parts_dir is not None:
        imported = import_parts(
            args.parts_dir, fill_bbox_with_openscad=args.fill_bbox_with_openscad, workers=args.workers
        )
        print(f"parts: {len(imported)} records")
        samples.extend(imported)
    if not samples:
        raise SystemExit("nothing imported (check inputs and expected_bbox_mm availability)")
    write_jsonl(args.output, samples)
    print(f"Wrote {len(samples)} external candidates to {args.output}")
    print("Next: python tools/validate_dataset.py --input", args.output, "--backend openscad --workers 12")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
