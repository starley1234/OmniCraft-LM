"""Build the para1 corpus: five prompt registers for 800 source parts.

The corpus adds *no code*: every row points at a part that is already in
``optional_data/data/gen2`` or ``optional_data/data/gen3`` through ``code_ref``.
What it adds is paraphrase - five registers per source part, composed from the
facts of that part (the feature sentences of its own prompt plus its manifest
envelope and parameters), so nothing in a paraphrase can contradict the code it
points at.

Usage
-----
    python tools/dataset_para1/build_para1.py --count 800
    python tools/dataset_para1/build_para1.py --count 20 --out /tmp/para1_smoke
"""

from __future__ import annotations

import argparse
import hashlib
import json
import re
import sys
import time
from datetime import datetime, timezone
from pathlib import Path

if __package__ in (None, ""):
    sys.path.insert(0, str(Path(__file__).resolve().parents[2]))

from tools.dataset_gen2.common import Rng
from tools.dataset_para1.registers import REGISTERS, compose

DEFAULT_OUT = Path("optional_data/data/para1")
DATA_ROOT = Path("optional_data/data")
CORPORA = ("gen2", "gen3")
INDEX_RE = re.compile(r"(\d+)")


def load_sources(data_root: Path) -> list[dict]:
    sources: list[dict] = []
    for corpus in CORPORA:
        manifest = data_root / corpus / "manifest.jsonl"
        if not manifest.is_file():
            raise SystemExit(f"missing {manifest} - generate the {corpus} corpus first")
        for line in manifest.read_text(encoding="utf-8").splitlines():
            if not line.strip():
                continue
            row = json.loads(line)
            file_name = str(row["file"])
            match = INDEX_RE.search(file_name)
            number = match.group(1) if match else "0000"
            sources.append(
                {
                    "source_id": f"{corpus}_{row['family']}_{int(number):04d}",
                    "corpus": corpus,
                    "family": str(row["family"]),
                    "file": file_name,
                    "code_ref": f"{corpus}/{file_name}",
                    "expected_bbox_mm": [float(value) for value in row["expected_bbox_mm"]],
                    "parameters": row.get("parameters") or {},
                    "prompt_ru": str(row.get("prompt_ru", "")),
                    "prompt_en": str(row.get("prompt_en", "")),
                }
            )
    return sources


def pick_sources(sources: list[dict], count: int, seed: str = "para1_pick") -> list[dict]:
    """Uniform per family: round robin over (corpus, family) buckets."""
    buckets: dict[str, list[dict]] = {}
    for source in sources:
        buckets.setdefault(f"{source['corpus']}/{source['family']}", []).append(source)
    order = sorted(buckets)
    rng = Rng(seed, 0)
    for key in order:
        buckets[key] = rng.shuffled(buckets[key])
    picked: list[dict] = []
    cursor = {key: 0 for key in order}
    while len(picked) < count:
        progressed = False
        for key in order:
            if len(picked) >= count:
                break
            index = cursor[key]
            if index < len(buckets[key]):
                picked.append(buckets[key][index])
                cursor[key] = index + 1
                progressed = True
        if not progressed:
            break
    return picked


def build(count: int, out_dir: Path, quiet: bool = False) -> dict[str, object]:
    started = time.time()
    data_root = DEFAULT_OUT.parent
    sources = pick_sources(load_sources(data_root), count)
    rows: list[dict] = []
    source_index: list[dict] = []
    seen_ru: set[str] = set()
    seen_en: set[str] = set()
    unique_retries = 0
    original_copies = 0

    for position, source in enumerate(sources, start=1):
        source_index.append(
            {
                "source_id": source["source_id"],
                "corpus": source["corpus"],
                "family": source["family"],
                "code_ref": source["code_ref"],
                "expected_bbox_mm": source["expected_bbox_mm"],
            }
        )
        for register in REGISTERS:
            row = None
            for attempt in range(48):
                rng = Rng(f"para1_{register}", position * 17 + attempt)
                ru, en = compose(source, source["corpus"], register, rng, variant=attempt)
                if ru in seen_ru or en in seen_en:
                    unique_retries += 1
                    continue
                row = {
                    "id": f"para1_{position:04d}_{register}",
                    "source_id": source["source_id"],
                    "corpus": source["corpus"],
                    "family": source["family"],
                    "register": register,
                    "lang": "en" if register == "technical_en" else "ru",
                    "prompt_ru": ru,
                    "prompt_en": en,
                    "expected_bbox_mm": source["expected_bbox_mm"],
                    "code_ref": source["code_ref"],
                }
                break
            if row is None:
                raise SystemExit(f"could not make a unique paraphrase for {source['source_id']} / {register}")
            if row["prompt_ru"] == source["prompt_ru"] or row["prompt_en"] == source["prompt_en"]:
                original_copies += 1
            seen_ru.add(row["prompt_ru"])
            seen_en.add(row["prompt_en"])
            rows.append(row)
        if not quiet and position % 100 == 0:
            print(f"{position}/{len(sources)} sources paraphrased", flush=True)

    out_dir.mkdir(parents=True, exist_ok=True)
    manifest_path = out_dir / "manifest.jsonl"
    manifest_path.write_text(
        "".join(json.dumps(row, ensure_ascii=False, sort_keys=True) + "\n" for row in rows),
        encoding="utf-8",
    )
    (out_dir / "source_index.json").write_text(
        json.dumps(source_index, ensure_ascii=False, indent=1) + "\n", encoding="utf-8"
    )
    manifest_sha = hashlib.sha256(manifest_path.read_bytes()).hexdigest()
    checksum_lines = [f"{manifest_sha}  manifest.jsonl"]
    for name in ("source_index.json",):
        digest = hashlib.sha256((out_dir / name).read_bytes()).hexdigest()
        checksum_lines.append(f"{digest}  {name}")
    (out_dir / "SHA256SUMS.txt").write_text("\n".join(checksum_lines) + "\n", encoding="utf-8")

    elapsed = time.time() - started
    per_family: dict[str, int] = {}
    per_register: dict[str, int] = {}
    for row in rows:
        per_family[row["family"]] = per_family.get(row["family"], 0) + 1
        per_register[row["register"]] = per_register.get(row["register"], 0) + 1
    ru_lengths = [len(row["prompt_ru"]) for row in rows]
    en_lengths = [len(row["prompt_en"]) for row in rows]
    summary: dict[str, object] = {
        "count": count,
        "samples": len(rows),
        "sources": len(sources),
        "registers": list(REGISTERS),
        "families": len(per_family),
        "per_family": per_family,
        "per_register": per_register,
        "manifest_sha256": manifest_sha,
        "seconds": round(elapsed, 1),
        "unique_retries": unique_retries,
        "original_copies": original_copies,
        "max_ru_chars": max(ru_lengths) if ru_lengths else 0,
        "max_en_chars": max(en_lengths) if en_lengths else 0,
        "mean_ru_chars": round(sum(ru_lengths) / len(ru_lengths), 1) if ru_lengths else 0.0,
        "mean_en_chars": round(sum(en_lengths) / len(en_lengths), 1) if en_lengths else 0.0,
        "out_dir": str(out_dir),
    }
    if not quiet:
        print(f"\n{len(rows)} rows over {len(sources)} source parts and {len(REGISTERS)} registers, {elapsed:.1f} s")
        print(f"families {len(per_family)}, rows per register {per_register}")
        print(f"prompts: RU up to {summary['max_ru_chars']} chars, EN up to {summary['max_en_chars']} chars")
        print(f"manifest.jsonl sha256 = {manifest_sha}")
    return summary


def write_report(out_dir: Path, summary: dict, audit: dict) -> Path:
    lines: list[str] = []
    add = lines.append
    add("# para1 corpus - generation report")
    add("")
    add(
        "This file is the audit sheet for `optional_data/data/para1`: it lists exactly what was "
        "added, how it was produced and how to re-verify it. This corpus adds **no code**: each row "
        "points at a part that already exists in `optional_data/data/gen2` or `optional_data/data/gen3` "
        "through `code_ref`, so there is no duplicated geometry anywhere in the repository."
    )
    add("")
    add(f"- generated: {datetime.now(timezone.utc).strftime('%Y-%m-%d %H:%M UTC')}")
    add(f"- rows: **{summary['samples']}** = {summary['sources']} source parts x {len(summary['registers'])} registers")
    add(f"- registers: {', '.join('`' + name + '`' for name in summary['registers'])}")
    add(f"- families covered: {summary['families']} (uniform per family, round robin over both corpora)")
    add(f"- `manifest.jsonl` sha256: `{summary['manifest_sha256']}`")
    add(
        "- generator: `tools/dataset_para1/` (`registers.py`, `build_para1.py`); facts are taken from "
        "the source part (its own prompt sentences, envelope and parameters), so a paraphrase cannot "
        "contradict the code it points at"
    )
    add(
        "- uniqueness: RU prompts unique, EN prompts unique "
        f"({summary['unique_retries']} draws re-rolled to keep it that way); "
        f"a paraphrase identical to the source prompt would have been a copy: {summary['original_copies']}"
    )
    add(
        f"- prompt sizes: RU mean {summary['mean_ru_chars']} / max {summary['max_ru_chars']} chars, "
        f"EN mean {summary['mean_en_chars']} / max {summary['max_en_chars']} chars"
    )
    add(
        f"- independent re-audit (`tools/dataset_para1/verify_para1.py`): {audit.get('rows')} rows, "
        f"{audit.get('sources')} sources, {audit.get('registers')} registers, "
        f"every `code_ref` resolved: {audit.get('refs_ok')}, "
        f"envelope cross-check against the source manifest: {audit.get('bbox_ok')}, "
        f"SHA-256 list {'verified' if audit.get('checksums_ok') else 'MISMATCH'}, "
        f"{len(audit.get('problems', []))} problems"
    )
    for line in audit.get("notes", []):
        add(f"- {line}")
    add(
        "- the corpus lives under `optional_data/`, which this repository ignores, so the deliverable "
        "was committed with `git add -f optional_data/data/para1`"
    )
    add("")
    add("## What was added, file by file")
    add("")
    add("| path (inside `optional_data/data/para1`) | what it is | size |")
    add("| --- | --- | ---: |")
    manifest_size = (out_dir / "manifest.jsonl").stat().st_size
    add(
        f"| `manifest.jsonl` | {summary['samples']} rows: id, source_id, corpus, family, register, lang, "
        f"prompt_ru, prompt_en, expected_bbox_mm, code_ref | {manifest_size / 1024:.1f} KiB |"
    )
    add("| `source_index.json` | the 800 source parts: source_id, corpus, family, code_ref, envelope | |")
    add("| `SHA256SUMS.txt` | checksums of the two files above | |")
    add("| `GENERATION_REPORT.md` | this sheet | |")
    add("")
    add("## Registers")
    add("")
    add("| register | language | what it looks like |")
    add("| --- | --- | --- |")
    add("| `formal_ru` | RU | formal engineering request, envelope first, one feature sentence, formal closing |")
    add("| `shopslang_ru` | RU | shop floor slang, dimensions as \"где-то 120 на 80\" |")
    add("| `chat_ru` | RU | short chat message with the envelope and one key size |")
    add("| `tolerance_ru` | RU | fits and tolerances, imperial equivalents quoted when a parameter hits one |")
    add("| `technical_en` | EN | English technical request, envelope plus feature sentence |")
    add("")
    add("## Rows per family")
    add("")
    add("| family | rows |")
    add("| --- | ---: |")
    for family, value in sorted(summary["per_family"].items()):
        add(f"| `{family}` | {value} |")
    add("")
    add("## How to re-verify")
    add("")
    add("```bash")
    add("python tools/dataset_para1/verify_para1.py --parts-dir optional_data/data/para1")
    add("python tools/dataset_gen2/verify_corpus.py --parts-dir optional_data/data/gen2")
    add("python tools/dataset_gen3/...  # gen3 has no separate verifier: use dataset_gen2/verify_corpus.py")
    add("```")
    add("")
    add(
        "The verifier re-reads the manifest, resolves every `code_ref`, re-loads the referenced source "
        "manifest and compares envelopes, checks the five registers per source, prompt uniqueness and "
        "the register style rules (chat rows are short, tolerance rows carry a fit, English rows are ASCII)."
    )
    path = out_dir / "GENERATION_REPORT.md"
    path.write_text("\n".join(lines) + "\n", encoding="utf-8")
    return path


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description="Generate the para1 prompt corpus")
    parser.add_argument("--count", type=int, default=800, help="source parts to paraphrase")
    parser.add_argument("--out", type=Path, default=DEFAULT_OUT)
    parser.add_argument("--quiet", action="store_true")
    parser.add_argument("--report", action="store_true")
    args = parser.parse_args(argv)

    summary = build(args.count, args.out, quiet=args.quiet)
    if args.report:
        from tools.dataset_para1.verify_para1 import audit_corpus

        audit = audit_corpus(args.out)
        write_report(args.out, summary, audit)
        if not args.quiet:
            print(f"report written to {args.out / 'GENERATION_REPORT.md'}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
