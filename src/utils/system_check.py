"""Environment diagnostics for CPU-first setup and optional CUDA/CAD runtimes."""

from __future__ import annotations

import importlib
import os
import shutil
import subprocess
import tempfile
from dataclasses import dataclass
from pathlib import Path


@dataclass(frozen=True, slots=True)
class CheckResult:
    status: str
    name: str
    details: str


def _probe_manifold_backend(openscad: str) -> CheckResult:
    """Compile a minimal solid with ``--backend=manifold`` to prove the CLI works."""
    source = "$fn = 32;\ncube([1.0, 1.0, 1.0]);\n"
    try:
        with tempfile.TemporaryDirectory(prefix="omnicraft-check-") as workspace:
            directory = Path(workspace)
            scad_path = directory / "probe.scad"
            stl_path = directory / "probe.stl"
            scad_path.write_text(source, encoding="utf-8")
            completed = subprocess.run(
                [openscad, "--backend=manifold", "-o", str(stl_path), str(scad_path)],
                capture_output=True,
                text=True,
                timeout=30,
                check=False,
            )
            if completed.returncode == 0 and stl_path.is_file() and stl_path.stat().st_size > 0:
                return CheckResult("OK", "Manifold backend", "compiled a probe solid to STL")
            message = (completed.stderr or completed.stdout or "no STL produced").strip().splitlines()
            return CheckResult(
                "WARNING",
                "Manifold backend",
                f"probe compile failed (exit {completed.returncode}): {message[0] if message else 'unknown'}",
            )
    except Exception as exc:
        return CheckResult("WARNING", "Manifold backend", f"probe compile could not run: {exc}")


def run_checks() -> list[CheckResult]:
    checks: list[CheckResult] = []
    try:
        import torch

        if torch.cuda.is_available():
            properties = torch.cuda.get_device_properties(0)
            memory_gib = properties.total_memory / (1024**3)
            checks.append(CheckResult("OK", "CUDA", f"{properties.name}, {memory_gib:.2f} GiB VRAM"))
            capability = torch.cuda.get_device_capability(0)
            sm_name = f"sm_{capability[0]}{capability[1]}"
            if capability == (12, 0):
                checks.append(CheckResult("OK", "Compute capability", f"{sm_name} (Blackwell) matches the RTX 5060 Ti target"))
            else:
                checks.append(CheckResult("WARNING", "Compute capability", f"{sm_name}; the architecture targets sm_120"))
            if torch.cuda.is_bf16_supported():
                checks.append(CheckResult("OK", "bfloat16", "native bf16 kernels available on this device"))
            else:
                checks.append(CheckResult("WARNING", "bfloat16", "device lacks native bf16 support"))
        else:
            checks.append(CheckResult("WARNING", "CUDA", "not available; CPU execution selected"))
        checks.append(CheckResult("OK", "PyTorch", f"imported version {torch.__version__}"))
    except Exception as exc:
        checks.append(CheckResult("MISSING", "PyTorch", f"import failed: {exc}"))

    offline_vars = {"HF_HUB_OFFLINE": "1", "TRANSFORMERS_OFFLINE": "1"}
    unset = [name for name, expected in offline_vars.items() if os.environ.get(name) != expected]
    if unset:
        checks.append(CheckResult("WARNING", "Offline mode", f"{', '.join(unset)} not set to '1'; backbone weights must be pre-staged"))
    else:
        checks.append(CheckResult("OK", "Offline mode", "HF_HUB_OFFLINE=1 and TRANSFORMERS_OFFLINE=1"))

    openscad = shutil.which("openscad")
    if openscad is None:
        checks.append(CheckResult("WARNING", "OpenSCAD", "not found in PATH; MockRunner remains available"))
    else:
        try:
            completed = subprocess.run(
                [openscad, "--version"], capture_output=True, text=True, timeout=10, check=False
            )
            version = (completed.stdout or completed.stderr).strip().splitlines()
            text = version[0] if version else f"exit code {completed.returncode}"
            status = "OK" if completed.returncode == 0 else "WARNING"
            checks.append(CheckResult(status, "OpenSCAD", text))
        except Exception as exc:
            checks.append(CheckResult("WARNING", "OpenSCAD", f"could not query version: {exc}"))
        checks.append(_probe_manifold_backend(openscad))

    try:
        import trimesh

        checks.append(CheckResult("OK", "Trimesh", f"imported version {trimesh.__version__}"))
    except Exception as exc:
        checks.append(CheckResult("WARNING", "Trimesh", f"STL verification unavailable: {exc}"))

    modules = (
        "src.model.latent_bridge",
        "src.model.voxel_canvas",
        "src.model.wire_canvas",
        "src.model.sketch_canvas",
        "src.model.brep_canvas",
        "src.model.assembly_canvas",
        "src.model.hook_manager",
        "src.env.mock_runner",
        "src.data.schema",
        "src.data.validation",
        "src.data.validation_cache",
    )
    failures: list[str] = []
    for module_name in modules:
        try:
            importlib.import_module(module_name)
        except Exception as exc:
            failures.append(f"{module_name}: {exc}")
    if failures:
        checks.append(CheckResult("MISSING", "Architecture imports", "; ".join(failures)))
    else:
        checks.append(CheckResult("OK", "Architecture imports", f"{len(modules)} modules imported"))
    return checks


def format_report(checks: list[CheckResult] | None = None) -> str:
    results = checks if checks is not None else run_checks()
    return "OmniCraft-LM system check\n" + "\n".join(
        f"[{item.status}] {item.name}: {item.details}" for item in results
    )


def main() -> None:
    print(format_report())


if __name__ == "__main__":
    main()
