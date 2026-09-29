"""Zero-point checkpointing: a rollback anchor recorded before any training.

The zero point captures the deterministic initial state of every trainable
module in the spatial stack (one directory per layer, one fp32 ``.pt`` file per
submodule) plus a manifest with SHA-256 hashes of each file, the RNG seed, the
git commit, and the frozen backbone identity.

Rollback contract:
- Reload the spatial stack from this directory (``load_zero_point`` verifies
  hashes first, then loads with ``strict=True``).
- LoRA adapters are NOT stored: PEFT initializes ``lora_B`` to zeros, so a
  fresh adapter created with the manifest seed reproduces the initial
  (gradient-identity) state exactly. Recreate adapters, then resume.
"""

from __future__ import annotations

import hashlib
import json
import subprocess
from dataclasses import dataclass
from datetime import datetime, timezone
from pathlib import Path

import torch

from src.training.spatial_stack import SpatialStack

ZERO_POINT_DIR_NAME = "zero_point"
MANIFEST_NAME = "manifest.json"
SUBMODULE_NAMES = ("scale_mlp", "in_projector", "canvas", "out_projector")


@dataclass(frozen=True, slots=True)
class ZeroPointManifest:
    path: Path
    payload: dict

    @property
    def seed(self) -> int:
        return int(self.payload["seed"])

    @property
    def layers(self) -> tuple[str, ...]:
        return tuple(self.payload["layers"])


def _sha256_file(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as stream:
        for chunk in iter(lambda: stream.read(1 << 20), b""):
            digest.update(chunk)
    return digest.hexdigest()


def _git_commit() -> str:
    try:
        completed = subprocess.run(
            ["git", "rev-parse", "HEAD"], capture_output=True, text=True, timeout=10, check=False
        )
        if completed.returncode == 0:
            return completed.stdout.strip()
    except (OSError, subprocess.TimeoutExpired):
        pass
    return "unknown"


def _backbone_metadata(name: str | None, revision: str | None) -> dict[str, str]:
    return {"name": name or "unknown", "revision": revision or "unknown"}


def build_stack_with_seed(seed: int, layers: tuple[str, ...] | None = None) -> SpatialStack:
    """Create a fresh fp32 CPU stack with deterministic initialization order."""
    torch.manual_seed(seed)
    return SpatialStack(layers=layers)


def save_zero_point(
    directory: Path,
    seed: int,
    layers: tuple[str, ...] | None = None,
    *,
    backbone_name: str | None = None,
    backbone_revision: str | None = None,
    lora_config: dict | None = None,
    force: bool = False,
) -> ZeroPointManifest:
    """Freeze the initial trainable state; refuses to overwrite without ``force``."""
    directory = Path(directory)
    manifest_path = directory / MANIFEST_NAME
    if manifest_path.exists() and not force:
        raise FileExistsError(f"zero point already exists at {directory}; pass force=True to overwrite")
    stack = build_stack_with_seed(seed, layers)
    records: dict[str, dict[str, str]] = {}
    for layer in stack.layers:
        bundle = stack.bundles[layer]
        for submodule_name in SUBMODULE_NAMES:
            submodule = getattr(bundle, submodule_name)
            relative = Path(layer) / f"{submodule_name}.pt"
            target = directory / relative
            target.parent.mkdir(parents=True, exist_ok=True)
            state = {key: value.detach().cpu().float() for key, value in submodule.state_dict().items()}
            torch.save(state, target)
            records[str(relative).replace("\\", "/")] = {"sha256": _sha256_file(target)}
    payload = {
        "format": 1,
        "created_utc": datetime.now(timezone.utc).isoformat(),
        "git_commit": _git_commit(),
        "torch_version": torch.__version__,
        "seed": int(seed),
        "layers": list(stack.layers),
        "modules": records,
        "backbone": _backbone_metadata(backbone_name, backbone_revision),
        "lora": dict(lora_config)
        if lora_config
        else {"rank": 16, "alpha": 32, "target_modules": ["q_proj", "k_proj", "v_proj", "o_proj"]},
        "lora_note": "Adapters are recreated from `seed`, not stored: lora_B starts at zero, "
        "so a fresh PEFT adapter is the gradient-identity rollback state.",
    }
    temporary = manifest_path.with_suffix(manifest_path.suffix + ".tmp")
    try:
        temporary.write_text(json.dumps(payload, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")
        temporary.replace(manifest_path)
    finally:
        temporary.unlink(missing_ok=True)
    return ZeroPointManifest(directory, payload)


def load_manifest(directory: Path) -> ZeroPointManifest:
    manifest_path = Path(directory) / MANIFEST_NAME
    if not manifest_path.is_file():
        raise FileNotFoundError(f"no zero-point manifest at {manifest_path}")
    payload = json.loads(manifest_path.read_text(encoding="utf-8"))
    if payload.get("format") != 1:
        raise ValueError(f"unsupported zero-point format: {payload.get('format')!r}")
    return ZeroPointManifest(Path(directory), payload)


def verify_zero_point(directory: Path) -> list[str]:
    """Return a list of integrity violations; an empty list means the anchor is intact."""
    manifest = load_manifest(directory)
    violations: list[str] = []
    for relative, record in manifest.payload["modules"].items():
        target = Path(directory) / relative
        if not target.is_file():
            violations.append(f"missing module file {relative}")
            continue
        actual = _sha256_file(target)
        if actual != record["sha256"]:
            violations.append(f"sha256 mismatch for {relative}: {record['sha256']} != {actual}")
    return violations


def load_zero_point(stack: SpatialStack, directory: Path, *, verify: bool = True) -> ZeroPointManifest:
    """Restore a stack to the recorded initial state (strict, hash-verified).

    The stack may hold a subset of the anchored layers; every layer it does
    hold must be present in the anchor.
    """
    manifest = load_manifest(directory)
    if verify:
        violations = verify_zero_point(directory)
        if violations:
            raise RuntimeError("zero point is corrupted: " + "; ".join(violations))
    anchored = set(manifest.payload["layers"])
    missing = [layer for layer in stack.layers if layer not in anchored]
    if missing:
        raise ValueError(
            f"stack layers {tuple(missing)} are not present in the zero point {manifest.payload['layers']}"
        )
    for layer in stack.layers:
        bundle = stack.bundles[layer]
        for submodule_name in SUBMODULE_NAMES:
            relative = Path(layer) / f"{submodule_name}.pt"
            state = torch.load(Path(directory) / relative, map_location="cpu", weights_only=True)
            getattr(bundle, submodule_name).load_state_dict(state, strict=True)
    return manifest
