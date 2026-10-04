"""Environment diagnostics for CPU-first setup and optional CUDA/CAD runtimes."""

from __future__ import annotations

import argparse
import importlib
import os
import shutil
import subprocess
import sys
from dataclasses import dataclass


@dataclass(frozen=True, slots=True)
class CheckResult:
    status: str
    name: str
    details: str


# A real (if small) part, not a bare cube: a plate with a through bore exercises the
# CSG/difference path the eval pipeline actually depends on.
TRIAL_PART_SOURCE = (
    "$fn = 32;\n"
    "// system_check environment probe: 40x40x10 plate with a 12 mm bore\n"
    "difference() {\n"
    "  cube([40, 40, 10], center = true);\n"
    "  cylinder(h = 12, d = 12, center = true);\n"
    "}\n"
)


def _tmpdir_hint() -> str:
    """Explain the snap/AppImage private-/tmp trap that used to fake model failure."""
    if sys.platform.startswith("linux"):
        return (
            " In WSL/Linux export TMPDIR=$HOME/omnicraft/tmp before eval/train: a confined"
            " (snap) OpenSCAD writes the STL into its private /tmp and the file never appears"
            " where the caller looks. This is a CAD-runtime fault, not a model fault."
        )
    return ""


def probe_openscad_trial(
    executable: str | None = None,
    *,
    runner: object | None = None,
    timeout_seconds: float = 60.0,
) -> CheckResult:
    """Compile a simple part through the same runner eval uses; MISSING if no STL.

    ``run_checks`` passes the resolved ``openscad`` path. Tests inject ``runner`` (an
    object with a ``compile(code) -> VerificationResult`` method) to avoid a real CLI.
    """
    if runner is None:
        try:
            from src.env.openscad_runner import OpenSCADRunner

            if executable is None:
                executable = shutil.which("openscad")
            if executable is None:
                return CheckResult(
                    "MISSING",
                    "OpenSCAD compile",
                    "openscad not found in PATH; install OpenSCAD with the manifold backend." + _tmpdir_hint(),
                )
            runner = OpenSCADRunner(executable=executable, backend="manifold", timeout_seconds=timeout_seconds)
        except Exception as exc:  # noqa: BLE001 - diagnostic must never raise
            return CheckResult(
                "MISSING", "OpenSCAD compile", f"eval compiler unavailable: {exc}.{_tmpdir_hint()}"
            )
    try:
        result = runner.compile(TRIAL_PART_SOURCE)  # type: ignore[attr-defined]
    except Exception as exc:  # noqa: BLE001 - diagnostic must never raise
        return CheckResult("MISSING", "OpenSCAD compile", f"trial compile raised: {exc}.{_tmpdir_hint()}")
    if result is None or result.error is not None or result.bbox is None:
        detail = getattr(result, "error", None) or "OpenSCAD produced no STL for the trial part"
        return CheckResult(
            "MISSING",
            "OpenSCAD compile",
            f"{detail}. The eval CAD environment is broken, NOT a model-quality signal.{_tmpdir_hint()}",
        )
    bbox_text = "x".join(f"{value:g}" for value in result.bbox)
    return CheckResult(
        "OK", "OpenSCAD compile", f"simple trial part -> STL via {result.backend} (bbox {bbox_text})"
    )


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
    # Compile a real simple part through the same runner eval uses. No STL here means
    # the CAD environment is broken -> [MISSING] -> preflight exit 3, instead of the
    # failure masquerading as "the model cannot do anything".
    checks.append(probe_openscad_trial(openscad))

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


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description="OmniCraft-LM environment diagnostics")
    parser.add_argument(
        "--openscad-only",
        action="store_true",
        help="run only the real OpenSCAD compile trial (the eval-environment guard); "
        "non-zero exit if no STL is produced",
    )
    args = parser.parse_args(argv)
    if args.openscad_only:
        result = probe_openscad_trial(shutil.which("openscad"))
        print(f"[{result.status}] {result.name}: {result.details}")
        return 0 if result.status != "MISSING" else 1
    print(format_report())
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
