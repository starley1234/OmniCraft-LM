"""Checkpoint snapshot tool: copies a layer, records sha256s, refuses overwrite."""

from __future__ import annotations

import json
import subprocess
import sys
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[1]
TOOL = REPO_ROOT / "tools" / "snapshot_checkpoint.py"


def _run(tmp_path: Path, *extra: str) -> subprocess.CompletedProcess:
    (tmp_path / "voxel").mkdir(exist_ok=True)
    (tmp_path / "voxel" / "model.safetensors").write_bytes(b"\x01\x02\x03" * 10)
    return subprocess.run([sys.executable, str(TOOL), "--checkpoints-dir", str(tmp_path),
                           "--layers", "voxel,wire", *extra],
                          capture_output=True, text=True)


def test_snapshot_copies_and_hashes(tmp_path: Path) -> None:
    result = _run(tmp_path, "--tag", "pre_test")
    assert result.returncode == 0, result.stderr
    snap = tmp_path / "_pre_pre_test" / "voxel"
    assert (snap / "model.safetensors").read_bytes() == (tmp_path / "voxel" / "model.safetensors").read_bytes()
    manifest = json.loads((snap / "SNAPSHOT.json").read_text(encoding="utf-8"))
    entry = manifest["files"][0]
    assert entry["path"] == "model.safetensors" and entry["bytes"] == 30
    import hashlib
    assert entry["sha256"] == hashlib.sha256(b"\x01\x02\x03" * 10).hexdigest()
    assert "wire: absent" in result.stdout


def test_snapshot_refuses_overwrite(tmp_path: Path) -> None:
    assert _run(tmp_path, "--tag", "pre_test").returncode == 0
    second = _run(tmp_path, "--tag", "pre_test")
    assert second.returncode != 0
    assert "refusing to overwrite" in second.stderr + second.stdout
