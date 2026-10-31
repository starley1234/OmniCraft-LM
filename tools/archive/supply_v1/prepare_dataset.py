"""Generate canonical JSONL training records without requiring CAD binaries."""

from __future__ import annotations

import argparse
import sys
from pathlib import Path

# Support both ``python -m tools.prepare_dataset`` and direct script execution.
REPOSITORY_ROOT = Path(__file__).resolve().parents[1]
if str(REPOSITORY_ROOT) not in sys.path:
    sys.path.insert(0, str(REPOSITORY_ROOT))

from src.data.generators.voxel_csg_gen import VoxelCSGGenerator
from src.data.generators.wire_truss_gen import WireTrussGenerator
from src.data.schema import CADSample, write_jsonl


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", type=Path, default=Path("data/processed/generated.jsonl"))
    parser.add_argument("--voxel-count", type=int, default=100)
    parser.add_argument("--wire-count", type=int, default=100)
    parser.add_argument("--seed", type=int, default=1234)
    return parser


def main() -> None:
    args = build_parser().parse_args()
    samples: list[CADSample] = [
        *VoxelCSGGenerator(args.seed).generate_many(args.voxel_count),
        *WireTrussGenerator(args.seed + 1).generate_many(args.wire_count),
    ]
    write_jsonl(args.output, samples)
    print(f"Wrote {len(samples)} generated candidates (not yet CAD-validated) to {args.output}")


if __name__ == "__main__":
    main()
