"""Build corpus v9 by appending OpenSCAD-accepted deliveries 5-7 to v8.

Only ``*.validation.accepted.jsonl`` inputs are admitted. Assembly corpora are
not included: their multi-component audit is not the canonical accepted-record
contract used by the current trainer.
"""
from __future__ import annotations

import argparse
import collections
import json
import sys
from pathlib import Path

REPOSITORY_ROOT = Path(__file__).resolve().parents[1]
if str(REPOSITORY_ROOT) not in sys.path:
    sys.path.insert(0, str(REPOSITORY_ROOT))

from src.data.schema import CADSample, parse_jsonl, write_jsonl

DEFAULT_ADDITIONS = (
    "wire2",
    "sketch2",
    "scale1",
    "sketch3",
    "wire3",
    "solid2",
    "sketch4",
    "wire4",
    "solid3",
)


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--base", type=Path, default=Path("data/processed/combined_v8.jsonl"))
    parser.add_argument("--output", type=Path, default=Path("data/processed/combined_v9.jsonl"))
    parser.add_argument("--report", type=Path, default=Path("data/processed/combined_v9.report.json"))
    parser.add_argument("--add", type=Path, nargs="*")
    args = parser.parse_args()

    additions = args.add or [
        Path(f"data/processed/{name}_candidates.validation.accepted.jsonl")
        for name in DEFAULT_ADDITIONS
    ]
    missing = [path for path in (args.base, *additions) if not path.is_file()]
    if missing:
        parser.error("missing input files: " + ", ".join(map(str, missing)))
    bad_names = [path for path in additions if not path.name.endswith(".validation.accepted.jsonl")]
    if bad_names:
        parser.error("additions must be canonical *.validation.accepted.jsonl files")

    rows: list[CADSample] = []
    seen: set[str] = set()
    source_counts: dict[str, int] = {}
    for path in (args.base, *additions):
        incoming = parse_jsonl(path)
        if path != args.base:
            unaccepted = [sample.id for sample in incoming if not sample.verification.accepted]
            if unaccepted:
                raise ValueError(f"{path} contains {len(unaccepted)} unaccepted rows")
        duplicates = [sample.id for sample in incoming if sample.id in seen]
        if duplicates:
            raise ValueError(f"{path} contains ids already present in corpus: {duplicates[:5]}")
        seen.update(sample.id for sample in incoming)
        rows.extend(incoming)
        source_counts[str(path)] = len(incoming)

    write_jsonl(args.output, rows)
    layers = collections.Counter(sample.layer for sample in rows)
    report = {
        "base": str(args.base),
        "output": str(args.output),
        "rows": len(rows),
        "sources": source_counts,
        "layers": dict(sorted(layers.items())),
        "assemblies_included": False,
    }
    args.report.write_text(json.dumps(report, ensure_ascii=False, indent=2), encoding="utf-8")
    print(json.dumps(report, ensure_ascii=False, indent=2))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
