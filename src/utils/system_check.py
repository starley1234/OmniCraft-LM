"""Environment diagnostics for CPU-first setup and optional CUDA/CAD runtimes."""

from __future__ import annotations

import importlib
import shutil
import subprocess
from dataclasses import dataclass


@dataclass(frozen=True, slots=True)
class CheckResult:
    status: str
    name: str
    details: str


def run_checks() -> list[CheckResult]:
    checks: list[CheckResult] = []
    try:
        import torch

        if torch.cuda.is_available():
            properties = torch.cuda.get_device_properties(0)
            memory_gib = properties.total_memory / (1024**3)
            checks.append(CheckResult("OK", "CUDA", f"{properties.name}, {memory_gib:.2f} GiB VRAM"))
        else:
            checks.append(CheckResult("WARNING", "CUDA", "not available; CPU execution selected"))
        checks.append(CheckResult("OK", "PyTorch", f"imported version {torch.__version__}"))
    except Exception as exc:
        checks.append(CheckResult("MISSING", "PyTorch", f"import failed: {exc}"))

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
            checks.append(CheckResult(status, "OpenSCAD", f"{text} (manifold backend requested by runner)"))
        except Exception as exc:
            checks.append(CheckResult("WARNING", "OpenSCAD", f"could not query version: {exc}"))

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
