"""Guard tests: a broken CAD runtime must read as [MISSING], not as model failure."""

from __future__ import annotations

import pytest

from src.env.cad_interface import VerificationResult
from src.utils import system_check
from src.utils.system_check import CheckResult, main, probe_openscad_trial


class _FakeRunner:
    """Test double with the same ``compile`` contract as OpenSCADRunner."""

    def __init__(self, result: VerificationResult | None = None, error: Exception | None = None) -> None:
        self.result = result
        self.error = error
        self.seen_code: str | None = None

    def compile(self, code: str) -> VerificationResult:
        self.seen_code = code
        if self.error is not None:
            raise self.error
        assert self.result is not None
        return self.result


def _compiled() -> VerificationResult:
    return VerificationResult(
        is_watertight=True,
        bbox=(40.0, 40.0, 10.0),
        volume=14822.0,
        euler_characteristic=2,
        components_count=1,
        error=None,
        backend="openscad-manifold",
        validation_status="openscad_manifold",
    )


def test_trial_part_is_a_real_canonical_openscad_solid() -> None:
    assert system_check.TRIAL_PART_SOURCE.startswith("$fn = 32;\n")
    assert "difference()" in system_check.TRIAL_PART_SOURCE


def test_probe_ok_when_runner_produces_stl() -> None:
    runner = _FakeRunner(result=_compiled())
    result = probe_openscad_trial(runner=runner)
    assert result.status == "OK"
    assert "40x40x10" in result.details
    assert runner.seen_code == system_check.TRIAL_PART_SOURCE


def test_probe_missing_when_no_stl() -> None:
    runner = _FakeRunner(
        result=VerificationResult(
            is_watertight=False,
            bbox=None,
            volume=None,
            euler_characteristic=None,
            components_count=None,
            error="OpenSCAD produced no STL",
        )
    )
    result = probe_openscad_trial(runner=runner)
    assert result.status == "MISSING"
    assert "STL" in result.details
    assert "NOT a model-quality signal" in result.details


def test_probe_missing_when_runner_raises() -> None:
    result = probe_openscad_trial(runner=_FakeRunner(error=RuntimeError("boom")))
    assert result.status == "MISSING"
    assert "boom" in result.details


def test_probe_missing_when_openscad_absent(monkeypatch: pytest.MonkeyPatch) -> None:
    monkeypatch.setattr(system_check.shutil, "which", lambda _name: None)
    result = probe_openscad_trial()
    assert result.status == "MISSING"
    assert "not found in PATH" in result.details


def test_tmpdir_hint_appears_on_linux(monkeypatch: pytest.MonkeyPatch) -> None:
    monkeypatch.setattr(system_check.sys, "platform", "linux")
    result = probe_openscad_trial(runner=_FakeRunner(error=RuntimeError("no STL")))
    assert "TMPDIR" in result.details


def test_openscad_only_cli_exit_codes(monkeypatch: pytest.MonkeyPatch) -> None:
    monkeypatch.setattr(
        system_check, "probe_openscad_trial", lambda *a, **k: CheckResult("OK", "OpenSCAD compile", "ok")
    )
    assert main(["--openscad-only"]) == 0

    monkeypatch.setattr(
        system_check,
        "probe_openscad_trial",
        lambda *a, **k: CheckResult("MISSING", "OpenSCAD compile", "no STL"),
    )
    assert main(["--openscad-only"]) == 1
