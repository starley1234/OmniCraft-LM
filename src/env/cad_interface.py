"""Stable interface for optional geometry compilation and verification."""

from __future__ import annotations

from abc import ABC, abstractmethod
from dataclasses import dataclass
from pathlib import Path


@dataclass(frozen=True, slots=True)
class VerificationResult:
    is_watertight: bool
    bbox: tuple[float, float, float] | None
    volume: float | None
    euler_characteristic: int | None
    components_count: int | None
    error: str | None = None
    backend: str = "unknown"
    validation_status: str = "unknown"


class CADRunnerBase(ABC):
    """Backend-neutral CAD code compiler and mesh verifier."""

    @abstractmethod
    def compile(self, code: str) -> VerificationResult:
        """Compile source code and return geometry verification metrics."""
        raise NotImplementedError

    def compile_file(self, source_path: Path) -> VerificationResult:
        """Compile source text from a filesystem path."""
        return self.compile(source_path.read_text(encoding="utf-8"))
