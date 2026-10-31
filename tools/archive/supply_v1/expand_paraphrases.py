"""Expand a paraphrase pack (code_ref rows) into canonical training records.

Each para1 row points at an already-validated gen2/gen3 record by
``source_id``; expansion copies its code (already manifold-accepted) and
provenance verbatim while attaching the new prompt wording. Validation is not
re-run: the referenced code carried its CAD verdict already.

    python tools/expand_paraphrases.py \
        --pack optional_data/data/para1/manifest.jsonl \
        --references data/processed/gen2_candidates.validation.accepted.jsonl \
                     data/processed/gen3_candidates.validation.accepted.jsonl \
        --output data/processed/para1_expanded.jsonl
"""

from __future__ import annotations

import argparse
import json
import sys
from pathlib import Path

REPOSITORY_ROOT = Path(__file__).resolve().parents[1]
if str(REPOSITORY_ROOT) not in sys.path:
    sys.path.insert(0, str(REPOSITORY_ROOT))

from src.data.schema import CADSample, parse_jsonl, write_jsonl


def _resolve_source_id(source_id: str, pools: dict[str, dict[str, CADSample]]) -> CADSample | None:
    """'gen2_bearings_0039' -> pools['gen2']['gen2_00039']."""
    for corpus in ("gen2", "gen3"):
        if source_id.startswith(corpus + "_"):
            index_text = source_id.rsplit("_", 1)[-1]
            try:
                index = int(index_text)
            except ValueError:
                return None
            return pools.get(corpus, {}).get(f"{corpus}_{index:05d}")
    return None


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--pack", type=Path, required=True)
    parser.add_argument("--references", type=Path, nargs="+", required=True)
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()

    pools: dict[str, dict[str, CADSample]] = {}
    for reference in args.references:
        for sample in parse_jsonl(reference):
            corpus = "gen2" if sample.id.startswith("gen2_") else "gen3"
            pools.setdefault(corpus, {})[sample.id] = sample

    rows = [
        json.loads(line)
        for line in args.pack.read_text(encoding="utf-8").splitlines()
        if line.strip()
    ]
    expanded: list[CADSample] = []
    missing: list[str] = []
    for row in rows:
        source = _resolve_source_id(str(row["source_id"]), pools)
        if source is None:
            missing.append(str(row["source_id"]))
            continue
        verification = source.verification.model_copy(
            update={
                "validation_status": "openscad_manifold",
                "validation_backend": source.verification.validation_backend,
                "accepted": True,
            }
        )
        metadata = dict(source.metadata)
        metadata["source"] = "para1_paraphrase"
        metadata["paraphrase_of"] = source.id
        metadata["register"] = row.get("register")
        expanded.append(
            source.model_copy(
                update={
                    "id": str(row["id"]),
                    "prompts": {"ru": str(row["prompt_ru"]), "en": str(row["prompt_en"])},
                    "verification": verification,
                    "metadata": metadata,
                }
            )
        )
    if missing:
        print(f"[warning] unresolved source ids: {len(missing)} (e.g. {missing[:3]})")
    write_jsonl(args.output, expanded)
    print(f"expanded {len(expanded)} paraphrase rows -> {args.output}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
