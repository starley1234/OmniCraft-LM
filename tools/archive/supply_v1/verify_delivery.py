"""Integrity check for externally delivered corpora: SHA256SUMS + manifest stats.

    python tools/verify_delivery.py optional_data/data/gen2
"""

from __future__ import annotations

import argparse
import hashlib
import json
from pathlib import Path


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("delivery_dir", type=Path)
    args = parser.parse_args()
    root: Path = args.delivery_dir
    if not root.is_dir():
        raise SystemExit(f"not a directory: {root}")

    bad = 0
    eol_only = 0
    sums = root / "SHA256SUMS.txt"
    if sums.is_file():
        for line in sums.read_text(encoding="utf-8").splitlines():
            parts = line.split("  ", 1) if "  " in line else line.split(None, 1)
            if len(parts) != 2:
                continue
            expected, relative = parts[0].strip(), parts[1].strip()
            target = root / relative
            if not target.exists():
                bad += 1
                print(f"MISSING {relative}")
                continue
            raw = target.read_bytes()
            if hashlib.sha256(raw).hexdigest() == expected:
                continue
            # Windows checkouts convert text to CRLF; accept when only EOL differs.
            if hashlib.sha256(raw.replace(b"\r\n", b"\n")).hexdigest() == expected:
                eol_only += 1
                continue
            bad += 1
            print(f"BAD HASH {relative}")
        print(
            f"sha256: {len(sums.read_text(encoding='utf-8').splitlines())} entries, "
            f"{bad} bad, {eol_only} eol-only (CRLF checkout)"
        )
    else:
        print("[warn] no SHA256SUMS.txt")

    manifest_path = root / "manifest.jsonl"
    manifest = [
        json.loads(line)
        for line in manifest_path.read_text(encoding="utf-8").splitlines()
        if line.strip()
    ]
    families = sorted({str(row.get("family", row.get("category", "?"))) for row in manifest})
    with_graph = sum(1 for row in manifest if row.get("graph"))
    seen_codes: set[str] = set()
    for row in manifest:
        if not row.get("file"):
            continue  # reference-only corpora (e.g. paraphrase packs) ship no code
        code_path = root / str(row["file"])
        if code_path.is_file():
            seen_codes.add(hashlib.sha256(code_path.read_bytes()).hexdigest())
    print(f"manifest: {len(manifest)} rows | families: {len(families)} | graphs: {with_graph}")
    print(f"unique code blobs: {len(seen_codes)} (of {len(manifest)})")
    print("families:", ", ".join(families))
    return 1 if bad else 0


if __name__ == "__main__":
    raise SystemExit(main())
