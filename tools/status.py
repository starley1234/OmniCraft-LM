"""One-screen project status board. Read-only, <5s, safe to run anytime.

    python tools/status.py            # человекочитаемо
    python tools/status.py --json     # машиночитаемо для автоматики
"""

from __future__ import annotations

import argparse
import json
import subprocess
from collections import Counter
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]


def _count_jsonl(path: Path) -> int | None:
    if not path.is_file():
        return None
    with path.open("rb") as stream:
        return sum(chunk.count(b"\n") for chunk in iter(lambda: stream.read(1 << 20), b""))


def _layers_histogram(path: Path) -> dict[str, int] | None:
    """Cheap layer histogram: looks only at the "layer" field per line."""
    if not path.is_file():
        return None
    counts: Counter[str] = Counter()
    with path.open("r", encoding="utf-8") as stream:
        for line in stream:
            if '"layer"' not in line:
                continue
            try:
                counts[json.loads(line).get("layer", "?")] += 1
            except json.JSONDecodeError:
                counts["?"] += 1
    return dict(counts)


def _git(args: list[str]) -> str:
    try:
        result = subprocess.run(["git", *args], capture_output=True, text=True, timeout=10, check=False, cwd=ROOT)
        return result.stdout.strip() if result.returncode == 0 else "?"
    except Exception:
        return "?"


def collect() -> dict:
    status: dict = {"checks": []}

    # --- data ---------------------------------------------------------------
    splits = ROOT / "data/processed/splits_v6"
    combined = ROOT / "data/processed/combined_v6.jsonl"
    status["corpus"] = {
        "combined_v6": _count_jsonl(combined),
        "layers": _layers_histogram(combined),
        "train": _count_jsonl(splits / "train.jsonl"),
        "validation": _count_jsonl(splits / "validation.jsonl"),
        "test": _count_jsonl(splits / "test.jsonl"),
        "voxel_grids": _count_jsonl(ROOT / "data/processed/voxel_grids.jsonl"),
    }

    # --- checkpoints ---------------------------------------------------------
    zero = ROOT / "checkpoints/zero_point/manifest.jsonl" if False else ROOT / "checkpoints/zero_point/manifest.json"
    zero_ok = zero.is_file()
    layers = {}
    for layer in ("voxel", "wire", "sketch", "brep", "assembly"):
        state_file = ROOT / "checkpoints" / layer / "trainer_state.json"
        if state_file.is_file():
            state = json.loads(state_file.read_text(encoding="utf-8"))
            layers[layer] = {"step": state.get("step"), "last_loss": (state.get("history_tail") or [{}])[-1].get("lm_loss")}
    status["checkpoints"] = {
        "zero_point": "present" if zero_ok else "MISSING",
        "trained": layers,
    }

    # --- environment (fast probes only) -------------------------------------
    env: dict = {}
    try:
        import torch

        env["torch"] = torch.__version__
        env["cuda"] = bool(torch.cuda.is_available())
        if env["cuda"]:
            properties = torch.cuda.get_device_properties(0)
            env["gpu"] = properties.name
            env["vram_gb"] = round(properties.total_memory / 1024**3, 1)
    except Exception as exc:
        env["torch"] = f"missing: {exc}"
    openscad = subprocess.run(
        ["powershell", "-NoProfile", "-Command", "(Get-Command openscad -ErrorAction SilentlyContinue).Source"]
        if sys_platform_windows()
        else ["bash", "-lc", "command -v openscad || true"],
        capture_output=True,
        text=True,
        timeout=15,
        check=False,
    )
    env["openscad"] = "present" if openscad.stdout.strip() else "MISSING"
    status["environment"] = env

    # --- processes ------------------------------------------------------------
    procs = _running_addresses()
    status["processes"] = procs

    # --- git ------------------------------------------------------------------
    status["git"] = {
        "branch": _git(["branch", "--show-current"]),
        "uncommitted": _git(["status", "--porcelain"]).count("\n") + 1 if _git(["status", "--porcelain"]) else 0,
        "ahead": _git(["rev-list", "--count", "@{u}..HEAD"]) if _git(["rev-parse", "@{u}"]) != "?" else "?",
    }
    return status


def sys_platform_windows() -> bool:
    import sys

    return sys.platform.startswith("win")


def _running_addresses() -> dict[str, bool]:
    """Which of our long-running jobs are alive (Windows + WSL aware)."""
    out = {"train_spatial": False, "build_voxel_grids": False, "demo_server": False, "wsl_train_chain": False, "evaluate_generation": False, "orchestrator": False}
    if sys_platform_windows():
        probe = subprocess.run(
            ["powershell", "-NoProfile", "-Command",
             "Get-CimInstance Win32_Process -Filter \"Name='python.exe'\" | ForEach-Object { $_.CommandLine }"],
            capture_output=True, text=True, timeout=20, check=False,
        )
        text = probe.stdout or ""
        for key in ("train_spatial", "demo_server"):
            out[key] = key in text
        wsl_probe = subprocess.run(
            ["wsl", "-d", "Ubuntu", "--", "bash", "-lc",
             "pgrep -af '[t]rain_spatial|[b]uild_voxel_grids|[w]sl_train_chain|[w]sl_retrain|[e]valuate_generation' || true"],
            capture_output=True, text=True, timeout=30, check=False,
        )
        wsl_text = wsl_probe.stdout or ""
        for key in ("train_spatial", "build_voxel_grids", "wsl_train_chain", "evaluate_generation"):
            if key in wsl_text:
                out[key] = True
        if "wsl_retrain_v4" in wsl_text:
            out["orchestrator"] = True
    else:
        probe = subprocess.run(["bash", "-c", "pgrep -af '[t]rain_spatial|[b]uild_voxel_grids|[w]sl_train_chain|[e]valuate_generation' || true"],
                               capture_output=True, text=True, timeout=15, check=False)
        text = probe.stdout or ""
        for key in out:
            out[key] = any(token in text for token in {key, key.replace("_", "-")})
    return out


def render(status: dict) -> str:
    c = status["corpus"]
    cp = status["checkpoints"]
    env = status["environment"]
    rows = [
        "=== OmniCraft-LM status board ===",
        f"GPU: {env.get('gpu', 'n/a')} ({env.get('vram_gb', '?')} GB) | torch {env.get('torch')} | cuda={env.get('cuda')} | openscad={env.get('openscad')}",
        f"Corpus v6: {c.get('combined_v6')} (split {c.get('train')}/{c.get('validation')}/{c.get('test')}), layers={c.get('layers')}",
        f"Voxel grids: {c.get('voxel_grids')}",
        f"Zero point: {cp.get('zero_point')}",
        "Trained: " + (", ".join(f"{k}@{v['step']}(lm={v['last_loss']})" for k, v in cp["trained"].items()) or "none"),
        "Processes: " + (", ".join(k for k, v in status["processes"].items() if v) or "idle"),
        f"Git: {status['git']['branch']}, ahead {status['git']['ahead']}, dirty files {status['git']['uncommitted']}",
    ]
    return "\n".join(rows)


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--json", action="store_true")
    args = parser.parse_args()
    status = collect()
    if args.json:
        print(json.dumps(status, ensure_ascii=False, indent=1))
    else:
        print(render(status))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
