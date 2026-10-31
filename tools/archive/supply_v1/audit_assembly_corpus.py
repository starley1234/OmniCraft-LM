"""Assembly-corpus acceptance: each declared part must be one watertight solid.

Scenes are multi-part by design, so the single-component policy does not apply.
Per scene we compile with OpenSCAD (manifold), split the STL, and require:
* every connected component is watertight;
* the component count equals the declared part count in ``metadata.assembly``.

    python tools/audit_assembly_corpus.py --input data/processed/asm1_candidates.jsonl --workers 12
"""

from __future__ import annotations

import argparse
import json
import sys
import tempfile
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path

REPOSITORY_ROOT = Path(__file__).resolve().parents[1]
if str(REPOSITORY_ROOT) not in sys.path:
    sys.path.insert(0, str(REPOSITORY_ROOT))

from src.data.schema import CADSample, parse_jsonl
from src.env.openscad_runner import OpenSCADRunner


def audit_scene(sample: CADSample, runner: OpenSCADRunner) -> dict:
    import subprocess

    import trimesh

    expected_parts = len(sample.metadata.get("assembly", []))
    with tempfile.TemporaryDirectory(prefix="omnicraft-asm-") as temporary:
        directory = Path(temporary)
        scad = directory / "scene.scad"
        stl = directory / "scene.stl"
        scad.write_text(sample.code, encoding="utf-8")
        completed = subprocess.run(
            [runner.executable, "--backend=manifold", "-o", str(stl), str(scad)],
            capture_output=True,
            text=True,
            timeout=120,
            check=False,
        )
        if completed.returncode != 0 or not stl.is_file():
            return {"id": sample.id, "ok": False, "why": "compile failed"}
        mesh = trimesh.load(str(stl), force="mesh", process=True)
    components = list(mesh.split(only_watertight=False))
    n = len(components)
    non_watertight = sum(0 if c.is_watertight else 1 for c in components)
    ok = n == expected_parts and non_watertight == 0 and n > 0
    why = "" if ok else f"parts {n}/{expected_parts}, non-watertight {non_watertight}"
    return {"id": sample.id, "ok": ok, "components": n, "expected": expected_parts, "why": why}


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--input", type=Path, required=True)
    parser.add_argument("--workers", type=int, default=12)
    args = parser.parse_args()
    samples = parse_jsonl(args.input)
    runner = OpenSCADRunner()
    rows = []
    with ThreadPoolExecutor(max_workers=args.workers) as pool:
        for i, row in enumerate(pool.map(lambda s: audit_scene(s, runner), samples)):
            rows.append(row)
            if (i + 1) % 100 == 0:
                print(f"  audited {i + 1}/{len(samples)}", flush=True)
    ok = [r for r in rows if r["ok"]]
    bad = [r for r in rows if not r["ok"]]
    print(f"assembly audit: {len(ok)} OK / {len(bad)} failed of {len(rows)}")
    for r in bad[:10]:
        print(f"  FAIL {r['id']}: {r['why']}")
    out = args.input.with_name(args.input.stem + ".assembly_audit.jsonl")
    with out.open("w", encoding="utf-8", newline="\n") as stream:
        for r in rows:
            stream.write(json.dumps(r) + "\n")
    print(f"report: {out}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
