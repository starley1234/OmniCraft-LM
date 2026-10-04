"""Repak of scraped scad → schema-valid candidate rows (stdlib+pydantic, no torch)."""

from __future__ import annotations

import json
import subprocess

sys_path_note = None
import sys
import tarfile
from pathlib import Path

REPO = Path(__file__).resolve().parents[1]
TOOL = REPO / "tools" / "repak_scad_scrape.py"

GOOD = """$fn=12;
/* [Main] */
// Flanged coupling with set-screw bosses
bore_d = 20; // bore diameter
length = 60; // overall length
/* [End] */
difference() {
  cube([40, 40, length]);
  translate([20, 20, -1]) cylinder(h=length + 2, d=bore_d);
}
"""
TITLE_ONLY = "// Motor mount bracket, 60 mm wide\nmodule m() { cube([60, 20, 8]); }\nm();\n"
NO_PROMPT = "cube([5, 5, 5]);\n" + "// pad\n" * 40
DUP = GOOD  # копия в другом файле того же репо
NO_GEOMETRY = "// Helper library of widget math, shared by many prints here\n" \
              "function f(x)=x+1;\nfunction g(y)=y*2;\n"
LIB_ONLY = ("// A shared library of widget shapes meant to be reused\n"
            "module widget(w=10) { cube([w, w, w]); }\n" + "\n" * 30)

FILES = {
    "adam__parts/flange_coupling.scad": GOOD,
    "adam__parts/flange_coupling_v2.scad": DUP,
    "adam__parts/bracket.scad": TITLE_ONLY,
    "eve__misc/anon_block.scad": NO_PROMPT,
    "eve__misc/math_lib.scad": NO_GEOMETRY,
    "eve__misc/widgets_lib.scad": LIB_ONLY,
}


def _build_tree(tmp_path: Path) -> Path:
    root = tmp_path / "scrape"
    for rel, text in FILES.items():
        path = root / rel
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_text(text, encoding="utf-8")
    index = tmp_path / "index.csv"
    with index.open("w", encoding="utf-8", newline="") as stream:
        stream.write("sha1_12,path,bytes,customizer_block,uses_library,repo_license\n")
        stream.write("a,adam__parts/flange_coupling.scad,10,1,0,MIT\n")
    return root


def _run(args: list[str]) -> subprocess.CompletedProcess:
    return subprocess.run([sys.executable, str(TOOL), *args], capture_output=True, text=True, cwd=REPO)


def _rows(path: Path) -> list[dict]:
    return [json.loads(line) for line in path.read_text(encoding="utf-8").splitlines() if line.strip()]


def test_repack_dir_mode_filters_and_stamps(tmp_path: Path) -> None:
    root = _build_tree(tmp_path)
    out = tmp_path / "candidates.jsonl"
    result = _run(["--in", str(root), "--index", str(tmp_path / "index.csv"),
                   "--out", str(out), "--measure", "off"])
    assert result.returncode == 0, result.stdout + result.stderr
    rows = _rows(out)
    ids = {row["id"] for row in rows}
    assert len(rows) == 3 and len(ids) == 3, "good + title-only + synth; dup/no-geom/no-call отсеяны"
    assert all(row["layer"] == "voxel" for row in rows)

    by_grade = {row["metadata"]["prompt_grade"] for row in rows}
    assert by_grade == {"customizer", "title_comment", "synth_code"}
    synth = next(r for r in rows if r["metadata"]["prompt_grade"] == "synth_code")
    assert "cube" in synth["prompts"]["en"] and "anon block" in synth["prompts"]["en"]
    assert "pad" not in synth["prompts"]["en"], "комменты-заглушки в промпт не попадают"

    good = next(r for r in rows if r["metadata"]["prompt_grade"] == "customizer")
    assert good["code"].startswith("$fn = 32;\n")
    assert "bore_d" in good["prompts"]["en"] and "length" in good["prompts"]["en"]
    assert good["verification"]["accepted"] is False
    assert good["metadata"]["provisional_target"] is True
    assert good["metadata"]["license"] == "MIT"
    assert "flange_coupling.scad" in good["metadata"]["path"]

    report = out.with_name(out.stem + ".report.md")
    assert report.is_file()
    text = report.read_text(encoding="utf-8")
    for reason in ("duplicate_code", "no_geometry_op", "no_top_level_call"):
        assert reason in text

    # предупреждение о плейсхолдерах обязательно
    assert "PROVISIONAL" in text or "плейсхолдер" in result.stderr


def test_repack_tar_mode_deterministic_and_schema(tmp_path: Path) -> None:
    root = _build_tree(tmp_path)
    tar = tmp_path / "files.tar.gz"
    with tarfile.open(tar, "w:gz") as archive:
        for rel in FILES:
            archive.add(root / rel, arcname=rel)
    out1 = tmp_path / "c1.jsonl"
    out2 = tmp_path / "c2.jsonl"
    for out in (out1, out2):
        result = _run(["--in", str(tar), "--out", str(out), "--measure", "off"])
        assert result.returncode == 0, result.stdout + result.stderr
    assert out1.read_bytes() == out2.read_bytes()

    pydantic = pytest_importorskip()
    if pydantic:
        if str(REPO) not in sys.path:
            sys.path.insert(0, str(REPO))
        from src.data.schema import CADSample
        for row in _rows(out1):
            CADSample.model_validate(row)  # конвейер-parse_jsonl проглотит эти строки


def test_repack_skips_external_libs_by_default(tmp_path: Path) -> None:
    root = tmp_path / "scrape"
    (root / "bosl__project").mkdir(parents=True)
    (root / "bosl__project/with_bosl.scad").write_text(
        "// Bracket made with BOSL2 helpers\ninclude <BOSL2/std.scad>\n"
        "cube([20, 20, 5]);\n", encoding="utf-8")
    out = tmp_path / "libgated.jsonl"
    result = _run(["--in", str(root), "--out", str(out), "--measure", "off"])
    assert result.returncode == 0
    assert _rows(out) == []
    text = out.with_name(out.stem + ".report.md").read_text(encoding="utf-8")
    assert "external_lib" in text
    out2 = tmp_path / "allowed.jsonl"
    result = _run(["--in", str(root), "--out", str(out2), "--measure", "off",
                   "--allow-external-libs"])
    assert len(_rows(out2)) == 1
    assert _rows(out2)[0]["metadata"]["needs_libs"] == ["std.scad"]


def test_repack_no_synth_flag(tmp_path: Path) -> None:
    root = _build_tree(tmp_path)
    out = tmp_path / "nosynth.jsonl"
    result = _run(["--in", str(root), "--out", str(out), "--measure", "off", "--no-synth-prompt"])
    assert result.returncode == 0
    assert len(_rows(out)) == 2  # good + title-only, как в строгом режиме
    text = out.with_name(out.stem + ".report.md").read_text(encoding="utf-8")
    assert "no_description" in text


def test_repack_refuses_overwrite(tmp_path: Path) -> None:
    root = _build_tree(tmp_path)
    out = tmp_path / "candidates.jsonl"
    assert _run(["--in", str(root), "--out", str(out), "--measure", "off"]).returncode == 0
    second = _run(["--in", str(root), "--out", str(out), "--measure", "off"])
    assert second.returncode == 4 and "overwrite" in (second.stdout + second.stderr).lower()


def test_repack_limit_and_per_repo(tmp_path: Path) -> None:
    root = tmp_path / "scrape"
    for i in range(5):
        path = root / f"x__repo/f{i}.scad"
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_text(f"// Cap check item {i}, a small plate with a corner fillet\n"
                        f"cube([10 + {i}, 20, 30]);\n", encoding="utf-8")
    out = tmp_path / "capped.jsonl"
    result = _run(["--in", str(root), "--out", str(out), "--measure", "off", "--per-repo", "2"])
    assert result.returncode == 0
    assert len(_rows(out)) == 2
    out2 = tmp_path / "limited.jsonl"
    result = _run(["--in", str(root), "--out", str(out2),
                   "--measure", "off", "--limit", "1"])
    assert result.returncode == 0
    assert len(_rows(out2)) == 1


def pytest_importorskip():
    try:
        import pydantic  # noqa: F401
        return True
    except ImportError:
        return False
