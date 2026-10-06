#!/usr/bin/env python3
"""Snapshot a checkpoint layer before a chain may roll it back (v14 lesson from E6-a).

Chains that start with an unconditional ``--rollback-only`` silently destroy the
previous layer (that is how v11 became unattributable). Any wsl_* chain should
call this first:

    python tools/snapshot_checkpoint.py --layers voxel wire --tag pre_v15

It copies ``checkpoints/<layer>`` to ``checkpoints/_pre_<tag>/<layer>`` (never
overwriting an existing snapshot) and records a sha256 sidecar for every payload
file so future forensics can identify which weights a run really used.
"""

from __future__ import annotations

import argparse
import hashlib
import json
import shutil
import sys
from datetime import datetime, timezone
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[1]


def sha256_of(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as fh:
        for chunk in iter(lambda: fh.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def snapshot_layer(checkpoints_dir: Path, layer: str, tag: str) -> dict:
    src = checkpoints_dir / layer
    if not src.is_dir():
        return {"layer": layer, "status": "absent"}
    dest_root = checkpoints_dir / f"_pre_{tag}"
    dest = dest_root / layer
    if dest.exists():
        raise SystemExit(f"[snapshot] refusing to overwrite existing snapshot {dest}")
    files = sorted(p for p in src.rglob("*") if p.is_file())
    manifest = {
        "layer": layer,
        "tag": tag,
        "status": "copied",
        "taken_at": datetime.now(timezone.utc).isoformat(timespec="seconds"),
        "files": [
            {"path": str(p.relative_to(src)), "bytes": p.stat().st_size, "sha256": sha256_of(p)}
            for p in files
        ],
    }
    shutil.copytree(src, dest)
    (dest / "SNAPSHOT.json").write_text(json.dumps(manifest, indent=2) + "\n", encoding="utf-8")
    return manifest


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("--checkpoints-dir", type=Path, default=REPO_ROOT / "checkpoints")
    parser.add_argument("--layers", default="voxel", help="comma list of layer dirs to snapshot")
    parser.add_argument("--tag", required=True, help="snapshot tag, e.g. pre_v15")
    args = parser.parse_args(argv)

    layers = [s.strip() for s in args.layers.split(",") if s.strip()]
    if not args.checkpoints_dir.is_dir():
        print(f"[snapshot] no checkpoints dir at {args.checkpoints_dir}; nothing to do")
        return 0
    for layer in layers:
        manifest = snapshot_layer(args.checkpoints_dir, layer, args.tag)
        if manifest.get("status") == "absent":
            print(f"[snapshot] {layer}: absent")
        else:
            total = sum(f["bytes"] for f in manifest["files"])
            print(f"[snapshot] {layer}: {len(manifest['files'])} files, {total/1e6:.1f} MB "
                  f"-> checkpoints/_pre_{args.tag}/{layer} (+SNAPSHOT.json)")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
