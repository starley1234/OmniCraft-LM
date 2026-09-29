"""OpenSCAD manifold CLI runner; all optional runtime dependencies are lazy."""

from __future__ import annotations

import math
import shutil
import subprocess
import tempfile
from pathlib import Path

from src.env.cad_interface import CADRunnerBase, VerificationResult


class CADExecutableNotFound(FileNotFoundError):
    """Raised when the configured OpenSCAD executable is unavailable."""


class OpenSCADRunner(CADRunnerBase):
    def __init__(
        self,
        executable: str = "openscad",
        backend: str = "manifold",
        timeout_seconds: float = 120.0,
    ) -> None:
        if backend != "manifold":
            raise ValueError("OmniCraft-LM requires OpenSCAD --backend=manifold")
        if not math.isfinite(timeout_seconds) or timeout_seconds <= 0:
            raise ValueError("timeout_seconds must be finite and positive")
        self.executable_name = executable
        self.executable = shutil.which(executable)
        self.backend = backend
        self.timeout_seconds = timeout_seconds
        self.version = "unknown"
        if self.executable is None:
            raise CADExecutableNotFound(
                f"OpenSCAD executable {executable!r} was not found in PATH; use MockRunner for CPU-only work"
            )
        try:
            version_result = subprocess.run(
                [self.executable, "--version"], capture_output=True, text=True, timeout=10, check=False
            )
            version_lines = (version_result.stdout or version_result.stderr).strip().splitlines()
            if version_result.returncode == 0 and version_lines:
                self.version = version_lines[0]
        except (OSError, subprocess.TimeoutExpired):
            pass

    def compile(self, code: str) -> VerificationResult:
        if not code.startswith("$fn = 32;\n"):
            return VerificationResult(False, None, None, None, None,
                                      'source must start with "$fn = 32;\\n"', backend="openscad", validation_status="rejected")
        try:
            import trimesh
        except ImportError as exc:
            raise RuntimeError("OpenSCAD mesh verification requires trimesh; install requirements.txt") from exc

        with tempfile.TemporaryDirectory(prefix="omnicraft-cad-") as temporary_directory:
            workspace = Path(temporary_directory)
            scad_path = workspace / "design.scad"
            stl_path = workspace / "design.stl"
            scad_path.write_text(code, encoding="utf-8")
            command = [
                self.executable or self.executable_name,
                f"--backend={self.backend}",
                "-o",
                str(stl_path),
                str(scad_path),
            ]
            try:
                completed = subprocess.run(
                    command,
                    capture_output=True,
                    text=True,
                    timeout=self.timeout_seconds,
                    check=False,
                )
            except subprocess.TimeoutExpired:
                return VerificationResult(False, None, None, None, None,
                                          f"OpenSCAD timed out after {self.timeout_seconds:g}s", backend="openscad", validation_status="rejected")
            if completed.returncode != 0 or not stl_path.exists():
                message = (completed.stderr or completed.stdout or "OpenSCAD produced no STL").strip()
                return VerificationResult(
                    False, None, None, None, None, message, backend="openscad", validation_status="rejected"
                )
            try:
                # Weld duplicated STL triangle vertices so watertightness and Euler
                # characteristic are computed on the actual indexed mesh topology.
                # This processes connectivity; it does not fill holes or repair the solid.
                mesh = trimesh.load(stl_path, force="mesh", process=True)
                if isinstance(mesh, trimesh.Scene):
                    geometries = list(mesh.geometry.values())
                    if not geometries:
                        raise ValueError("STL scene contains no geometry")
                    mesh = trimesh.util.concatenate(geometries)
                bounds = mesh.bounds
                bbox = tuple(float(value) for value in (bounds[1] - bounds[0]))
                components = list(mesh.split(only_watertight=False))
                if not components or mesh.faces.shape[0] == 0:
                    return VerificationResult(
                        False, None, None, None, 0, "STL contains no mesh components",
                        backend="openscad", validation_status="rejected"
                    )
                return VerificationResult(
                    is_watertight=bool(mesh.is_watertight),
                    bbox=bbox,  # type: ignore[arg-type]
                    volume=float(mesh.volume),
                    euler_characteristic=int(mesh.euler_number),
                    components_count=len(components),
                    error=None,
                    backend="openscad-manifold",
                    validation_status="openscad_manifold",
                )
            except Exception as exc:  # mesh loaders can raise several backend-specific exceptions
                return VerificationResult(False, None, None, None, None,
                                          f"failed to parse generated STL: {exc}", backend="openscad", validation_status="rejected")
