"""External-corpus import: facet-header canonicalization and bbox extraction."""

from __future__ import annotations

from pathlib import Path

from tools.import_external_scad import _clean_code, _target_bbox, import_domain_expansion, import_parts


def test_clean_code_replaces_foreign_facet_header() -> None:
    code = "// comment\n$fn = 72;\nsize = 10;\ncube([size, size, size]);\n"
    cleaned = _clean_code(code)
    assert cleaned.startswith("$fn = 32;\n")
    assert "$fn" not in cleaned.splitlines()[1]
    assert "cube([size, size, size]);" in cleaned
    assert "// comment" in cleaned


def test_clean_code_keeps_already_canonical_header_single() -> None:
    code = "$fn = 32;\ncube(1);\n"
    cleaned = _clean_code(code)
    assert cleaned == code
    assert cleaned.count("$fn") == 1


def test_target_bbox_validation() -> None:
    assert _target_bbox([10, 20, 30]) == (10.0, 20.0, 30.0)
    assert _target_bbox([10, 20]) is None
    assert _target_bbox([10, 0, 30]) is None
    assert _target_bbox(["a", "b", "c"]) is None
    assert _target_bbox([]) is None


def test_import_domain_expansion_roundtrip(tmp_path: Path) -> None:
    row = {
        "category": "enclosure_lid",
        "subtype": "test",
        "prompt_ru": "крышка",
        "prompt_en": "lid",
        "scad_code": "// lid\n$fn = 72;\ncube([10, 20, 5]);\n",
        "expected_bbox_mm": [10, 20, 5],
    }
    import json

    source = tmp_path / "domain.jsonl"
    source.write_text(json.dumps(row) + "\n", encoding="utf-8")
    samples = import_domain_expansion(source)
    assert len(samples) == 1
    sample = samples[0]
    assert sample.id == "ext_domain_00000"
    assert sample.layer == "voxel"
    assert sample.code.startswith("$fn = 32;\n")
    assert sample.verification.target_bbox == (10.0, 20.0, 5.0)
    assert sample.metadata["code_sha256"]
    assert sample.metadata["source"] == "domain_expansion_import"


def test_import_parts_skips_missing_bbox(tmp_path: Path) -> None:
    parts = tmp_path / "parts"
    parts.mkdir()
    (parts / "part_a.scad").write_text("$fn = 60;\ncube([4, 4, 4]);\n", encoding="utf-8")
    (parts / "manifest.jsonl").write_text(
        '{"file": "part_a.scad", "name": "block", "category": "test", '
        '"prompt_ru": "блок", "prompt_en": "", "expected_bbox_mm": []}\n',
        encoding="utf-8",
    )
    assert import_parts(parts) == []  # no bbox available, no OpenSCAD fill requested
