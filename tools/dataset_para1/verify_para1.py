"""Standalone audit of the para1 corpus.

Checks, without touching the corpora it points at beyond reading their
manifests:

* the row count, five registers per source and one ``code_ref`` per source;
* every ``code_ref`` resolves to a file that really exists under
  ``optional_data/data/``, and carries the envelope of the source row;
* RU prompts unique, EN prompts unique, and no paraphrase is a copy of the
  source prompt;
* register style rules: chat rows are short, tolerance rows mention a fit or a
  tolerance, the English register is ASCII, the formal register is long enough
  to read as a request;
* ``SHA256SUMS.txt``.

    python tools/dataset_para1/verify_para1.py --parts-dir optional_data/data/para1
"""

from __future__ import annotations

import argparse
import hashlib
import json
import re
import sys
from pathlib import Path

if __package__ in (None, ""):
    sys.path.insert(0, str(Path(__file__).resolve().parents[2]))

from tools.dataset_para1.registers import FAMILY_NOUNS, REGISTERS

ALLOWED_SYMBOLS = set("±°Ø⌀×–—²³'\u2032")
CHAT_MAX_CHARS = 260
FORMAL_MIN_CHARS = 120
TOLERANCE_MARKERS = ("зазор", "допуск", "посадк", "h7", "h8", "±", "+0.", "натяг")

DATA_ROOT = Path("optional_data/data")


def _cyrillic(text: str) -> int:
    return sum(1 for char in text if "а" <= char.lower() <= "я")


def audit_corpus(parts_dir: Path, data_root: Path | None = None, limit: int | None = None) -> dict:
    data_root = data_root or DATA_ROOT
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

    source_rows: dict[str, list[dict]] = {}
    problems: list[str] = []
    ru_seen: dict[str, str] = {}
    en_seen: dict[str, str] = {}
    duplicate_ru = duplicate_en = 0
    original_copies = 0
    per_family: dict[str, int] = {}
    per_register: dict[str, int] = {}
    refs_ok = True
    bbox_ok = True
    style_bad = 0

    # the source manifests, keyed by corpus + file
    sources: dict[str, dict] = {}
    for corpus in ("gen2", "gen3"):
        manifest = data_root / corpus / "manifest.jsonl"
        if not manifest.is_file():
            problems.append(f"missing source manifest {manifest}")
            continue
        for line in manifest.read_text(encoding="utf-8").splitlines():
            if not line.strip():
                continue
            row = json.loads(line)
            match = re.search(r"(\d+)", str(row["file"]))
            number = match.group(1) if match else "0000"
            source_id = f"{corpus}_{row['family']}_{int(number):04d}"
            sources[source_id] = {
                "file": str(row["file"]),
                "bbox": [float(value) for value in row["expected_bbox_mm"]],
                "prompt_ru": str(row.get("prompt_ru", "")),
                "prompt_en": str(row.get("prompt_en", "")),
                "family": str(row["family"]),
            }

    for row in rows:
        name = str(row.get("id", "?"))
        source_id = str(row.get("source_id", ""))
        register = str(row.get("register", ""))
        source_rows.setdefault(source_id, []).append(row)
        per_family[str(row.get("family"))] = per_family.get(str(row.get("family")), 0) + 1
        per_register[register] = per_register.get(register, 0) + 1

        if register not in REGISTERS:
            problems.append(f"{name}: unknown register {register!r}")
        if "code" in row or "source" in row:
            problems.append(f"{name}: the row carries code - para1 must only reference it")
        code_ref = str(row.get("code_ref", ""))
        if not code_ref.startswith(("gen2/", "gen3/")):
            problems.append(f"{name}: code_ref {code_ref!r} is not inside gen2/ or gen3/")
        elif not (data_root / code_ref).is_file():
            refs_ok = False
            problems.append(f"{name}: code_ref {code_ref} does not exist")

        source = sources.get(source_id)
        if source is None:
            problems.append(f"{name}: source_id {source_id} is not in the gen2/gen3 manifests")
        else:
            family = str(row.get("family", ""))
            if family != source["family"]:
                problems.append(f"{name}: family {family!r} does not match the source {source['family']!r}")
            if f"{row.get('corpus')}/{source['file']}" != code_ref:
                problems.append(f"{name}: code_ref does not match the source file of {source_id}")
            if len(row.get("expected_bbox_mm", [])) != 3:
                problems.append(f"{name}: expected_bbox_mm is not a 3-vector")
            else:
                for axis, want, have in zip("XYZ", source["bbox"], [float(v) for v in row["expected_bbox_mm"]]):
                    if abs(want - have) > 1e-6:
                        bbox_ok = False
                        problems.append(f"{name}: axis {axis} {have} vs the source manifest {want}")

        ru = str(row.get("prompt_ru", ""))
        en = str(row.get("prompt_en", ""))
        if not ru or not en:
            problems.append(f"{name}: an empty prompt")
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
        if source and (ru == source["prompt_ru"] or en == source["prompt_en"]):
            original_copies += 1
            problems.append(f"{name}: the paraphrase is identical to the source prompt")

        if register == "chat_ru":
            if len(ru) > CHAT_MAX_CHARS:
                style_bad += 1
                problems.append(f"{name}: chat row is {len(ru)} chars, over {CHAT_MAX_CHARS}")
            if not any(char.isdigit() for char in ru):
                style_bad += 1
                problems.append(f"{name}: chat row carries no size")
        if register == "tolerance_ru":
            lowered = ru.lower()
            if not any(marker in lowered for marker in TOLERANCE_MARKERS):
                style_bad += 1
                problems.append(f"{name}: tolerance row has no fit or tolerance")
        if register == "formal_ru" and len(ru) < FORMAL_MIN_CHARS:
            style_bad += 1
            problems.append(f"{name}: formal row is only {len(ru)} chars")
        if register == "technical_en":
            if _cyrillic(en) > 0:
                style_bad += 1
                problems.append(f"{name}: the English register carries Cyrillic text")
            strays = {char for char in en if not char.isascii() and char not in ALLOWED_SYMBOLS}
            if strays:
                style_bad += 1
                problems.append(f"{name}: the English register has odd characters {sorted(strays)}")

    for source_id, group in source_rows.items():
        registers = sorted(str(row.get("register")) for row in group)
        if registers != sorted(REGISTERS):
            problems.append(f"{source_id}: registers {registers} instead of the five expected")

    unknown_nouns = sorted({str(row.get("family")) for row in rows} - set(FAMILY_NOUNS))
    if unknown_nouns:
        problems.append(f"families without a noun in registers.py: {unknown_nouns}")

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

    family_counts = sorted(per_family.values())
    uniform = ""
    if family_counts:
        uniform = f"{family_counts[0]}..{family_counts[-1]} rows per family"

    return {
        "rows": len(rows),
        "sources": len(source_rows),
        "registers": len(per_register),
        "per_family": per_family,
        "per_register": per_register,
        "uniform_families": uniform,
        "refs_ok": refs_ok,
        "bbox_ok": bbox_ok,
        "duplicate_ru": duplicate_ru,
        "duplicate_en": duplicate_en,
        "original_copies": original_copies,
        "style_bad": style_bad,
        "checksums_ok": checksums_ok,
        "problems": problems,
        "notes": [
            f"families: {len(per_family)} from two corpora, {uniform}",
            f"registers per source: {sorted(per_register.items())}",
            f"style gate: {style_bad} rows outside the register rules "
            f"(chat <= {CHAT_MAX_CHARS} chars with a size, tolerance row carries a fit, "
            f"formal >= {FORMAL_MIN_CHARS} chars, English register is Latin text with only "
            f"{''.join(sorted(ALLOWED_SYMBOLS))} allowed as symbols)",
        ],
    }


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--parts-dir", type=Path, default=Path("optional_data/data/para1"))
    parser.add_argument("--data-root", type=Path, default=DATA_ROOT)
    parser.add_argument("--limit", type=int, default=None)
    args = parser.parse_args(argv)

    summary = audit_corpus(args.parts_dir, data_root=args.data_root, limit=args.limit)
    if "error" in summary:
        print(summary["error"])
        return 2
    print(f"rows            : {summary['rows']}")
    print(f"source parts    : {summary['sources']}")
    print(f"registers       : {summary['registers']} -> {summary['per_register']}")
    print(f"families        : {len(summary['per_family'])} ({summary['uniform_families']})")
    print(f"code_ref check  : {'all resolve' if summary['refs_ok'] else 'MISSING FILES'}")
    print(f"envelope check  : {'matches the source manifests' if summary['bbox_ok'] else 'MISMATCH'}")
    print(f"prompt dupes    : RU {summary['duplicate_ru']}, EN {summary['duplicate_en']}")
    print(f"source copies   : {summary['original_copies']}")
    print(f"register style  : {summary['style_bad']} rows outside the rules")
    print(f"sha256 list     : {'ok' if summary['checksums_ok'] else 'MISMATCH'}")
    print(f"problems        : {'none' if not summary['problems'] else len(summary['problems'])}")
    for line in summary["problems"][:10]:
        print(f"   - {line}")
    return 0 if not summary["problems"] else 1


if __name__ == "__main__":
    raise SystemExit(main())
