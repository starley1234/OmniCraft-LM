"""Deterministic grouped train/validation/test split to limit near-duplicate leakage."""

from __future__ import annotations

import argparse
import hashlib
import json
import math
import sys
from collections import Counter, defaultdict
from pathlib import Path
from typing import Any

REPOSITORY_ROOT = Path(__file__).resolve().parents[1]
if str(REPOSITORY_ROOT) not in sys.path:
    sys.path.insert(0, str(REPOSITORY_ROOT))

from src.data.schema import CADSample, parse_jsonl, write_jsonl


def _group_key(sample: CADSample, strategy: str, bucket_size_mm: float) -> str:
    family = str(sample.metadata.get("kind", sample.metadata.get("source", sample.layer)))
    dimensions = sorted(sample.verification.target_bbox)
    bins = [int(math.floor(dimension / bucket_size_mm)) for dimension in dimensions]
    parts = [sample.layer]
    if strategy in ("kind", "kind-and-dimension"):
        parts.append(family)
    if strategy in ("dimension", "kind-and-dimension"):
        parts.append("bbox=" + ",".join(map(str, bins)))
    return "|".join(parts)


def _assignment(group_key: str, seed: int, train: float, validation: float) -> str:
    digest = hashlib.sha256(f"{seed}|{group_key}".encode("utf-8")).digest()
    bucket = int.from_bytes(digest[:8], byteorder="big") / (2**64)
    if bucket < train:
        return "train"
    if bucket < train + validation:
        return "validation"
    return "test"


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--input", type=Path, required=True, help="validated accepted JSONL")
    parser.add_argument("--output-dir", type=Path)
    parser.add_argument("--train-ratio", type=float, default=0.8)
    parser.add_argument("--validation-ratio", type=float, default=0.1)
    parser.add_argument("--test-ratio", type=float, default=0.1)
    parser.add_argument("--seed", type=int, default=1234)
    parser.add_argument("--bucket-size-mm", type=float, default=20.0)
    parser.add_argument(
        "--group-by",
        choices=("kind", "dimension", "kind-and-dimension"),
        default="kind-and-dimension",
    )
    parser.add_argument(
        "--include-unaccepted",
        action="store_true",
        help="unsafe for training; allow provisional records for exploratory analysis only",
    )
    return parser


def main() -> int:
    parser = build_parser()
    args = parser.parse_args()
    ratios = (args.train_ratio, args.validation_ratio, args.test_ratio)
    if any(not math.isfinite(value) or value < 0 for value in ratios) or not math.isclose(sum(ratios), 1.0, abs_tol=1e-8):
        parser.error("split ratios must be finite, non-negative, and sum to 1")
    if not math.isfinite(args.bucket_size_mm) or args.bucket_size_mm <= 0:
        parser.error("--bucket-size-mm must be finite and positive")
    if not args.input.is_file():
        parser.error(f"input JSONL does not exist: {args.input}")

    samples = parse_jsonl(args.input)
    if not args.include_unaccepted:
        unaccepted = [sample.id for sample in samples if not sample.verification.accepted]
        if unaccepted:
            parser.error(
                f"input contains {len(unaccepted)} unaccepted rows; validate first or use "
                "--include-unaccepted for exploratory use"
            )
    output_dir = args.output_dir or args.input.parent / (args.input.stem + ".splits")
    output_dir.mkdir(parents=True, exist_ok=True)

    groups: dict[str, list[CADSample]] = defaultdict(list)
    for sample in samples:
        key = _group_key(sample, args.group_by, args.bucket_size_mm)
        groups[key].append(sample)
    partitions: dict[str, list[CADSample]] = {"train": [], "validation": [], "test": []}
    group_assignments: dict[str, str] = {}
    for group_key in sorted(groups):
        split = _assignment(group_key, args.seed, args.train_ratio, args.validation_ratio)
        group_assignments[group_key] = split
        partitions[split].extend(groups[group_key])

    for split_name, split_samples in partitions.items():
        write_jsonl(output_dir / f"{split_name}.jsonl", split_samples)
    family_counts = Counter(str(sample.metadata.get("kind", sample.layer)) for sample in samples)
    manifest: dict[str, Any] = {
        "source": str(args.input.resolve()),
        "seed": args.seed,
        "group_by": args.group_by,
        "bucket_size_mm": args.bucket_size_mm,
        "ratios": {"train": args.train_ratio, "validation": args.validation_ratio, "test": args.test_ratio},
        "counts": {name: len(records) for name, records in partitions.items()},
        "group_counts": dict(Counter(group_assignments.values())),
        "family_counts": dict(family_counts),
        "groups": group_assignments,
        "include_unaccepted": args.include_unaccepted,
    }
    manifest_path = output_dir / "manifest.json"
    temporary = manifest_path.with_name(manifest_path.name + ".tmp")
    try:
        temporary.write_text(json.dumps(manifest, indent=2, ensure_ascii=False), encoding="utf-8")
        temporary.replace(manifest_path)
    finally:
        temporary.unlink(missing_ok=True)
    print(
        f"Wrote grouped split: train={len(partitions['train'])}, "
        f"validation={len(partitions['validation'])}, test={len(partitions['test'])} "
        f"({len(groups)} indivisible groups) to {output_dir}"
    )
    if not all(partitions.values()):
        print("[WARNING] at least one split is empty; add more parameter groups or change ratios/seed")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
