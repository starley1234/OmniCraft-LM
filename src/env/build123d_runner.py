"""Optional Build123d execution seam for B-Rep and STEP workflows."""

from __future__ import annotations

from src.env.cad_interface import CADRunnerBase, VerificationResult


class Build123dRunner(CADRunnerBase):
    """Placeholder with a stable interface; Build123d remains an optional extra."""

    def compile(self, code: str) -> VerificationResult:
        try:
            import build123d  # noqa: F401
        except ImportError as exc:
            raise RuntimeError("Build123d is optional and is not installed in this environment") from exc
        return VerificationResult(
            False, None, None, None, None,
            "Build123d code execution is intentionally not enabled by the initial runtime scaffold",
            backend="build123d",
        )
