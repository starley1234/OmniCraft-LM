"""Small atomic JSON cache for expensive geometry-validation runs."""

from __future__ import annotations

import hashlib
import json
import threading
from pathlib import Path
from typing import Any

from src.data.schema import CADSample
from src.data.validation import SampleValidationReport


class ValidationCache:
    """Cache reports by full sample content, backend version, and policy fingerprint."""

    FORMAT_VERSION = 1

    def __init__(self, path: Path, fingerprint: str) -> None:
        self.path = Path(path)
        self.fingerprint = fingerprint
        self._lock = threading.RLock()
        self._entries: dict[str, dict[str, Any]] = {}
        self.load_warning: str | None = None
        self._load()

    def key_for(self, sample: CADSample) -> str:
        payload = self.fingerprint + "\0" + sample.model_dump_json()
        return hashlib.sha256(payload.encode("utf-8")).hexdigest()

    def get(self, sample: CADSample) -> SampleValidationReport | None:
        key = self.key_for(sample)
        with self._lock:
            entry = self._entries.get(key)
            if entry is None:
                return None
            try:
                cached_sample = CADSample.model_validate(entry["sample"])
                return SampleValidationReport(
                    sample=cached_sample,
                    accepted=bool(entry["accepted"]),
                    status=str(entry["status"]),
                    errors=list(entry.get("errors", [])),
                    warnings=list(entry.get("warnings", [])),
                )
            except Exception:
                self._entries.pop(key, None)
                return None

    def put(self, source: CADSample, report: SampleValidationReport) -> None:
        key = self.key_for(source)
        with self._lock:
            self._entries[key] = {
                "sample": report.sample.model_dump(mode="json"),
                "accepted": report.accepted,
                "status": report.status,
                "errors": report.errors,
                "warnings": report.warnings,
            }

    def save(self) -> None:
        self.path.parent.mkdir(parents=True, exist_ok=True)
        temporary = self.path.with_name(self.path.name + ".tmp")
        payload = {
            "format_version": self.FORMAT_VERSION,
            "fingerprint": self.fingerprint,
            "entries": self._entries,
        }
        with self._lock:
            try:
                temporary.write_text(json.dumps(payload, ensure_ascii=False), encoding="utf-8")
                temporary.replace(self.path)
            finally:
                temporary.unlink(missing_ok=True)

    def _load(self) -> None:
        if not self.path.exists():
            return
        try:
            payload = json.loads(self.path.read_text(encoding="utf-8"))
            if payload.get("format_version") != self.FORMAT_VERSION:
                self.load_warning = "validation cache format changed; starting a fresh cache"
                return
            if payload.get("fingerprint") != self.fingerprint:
                self.load_warning = "validation backend or policy changed; starting a fresh cache"
                return
            entries = payload.get("entries", {})
            if isinstance(entries, dict):
                self._entries = entries
        except (OSError, json.JSONDecodeError, AttributeError, TypeError) as exc:
            self.load_warning = f"could not read validation cache: {exc}"
