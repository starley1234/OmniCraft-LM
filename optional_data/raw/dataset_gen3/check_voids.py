"""Extra audit: the hollow features are really cut.

A shell can pass every mesh test and still be solid where the prompt promises a
bore - a cutter that misses its target is silent.  This script re-loads the
written samples, casts the centre of the part against the mesh and asserts that
the axial point is *void* for the families whose prompt promises a central bore
(threaded cap, thumb screw, gear hub, worm wheel, belt roller, cam, pipe clamp,
cardan hub).

Usage
-----
    python tools/dataset_gen3/check_voids.py --parts-dir optional_data/data/gen3
    python tools/dataset_gen3/check_voids.py --parts-dir /tmp/gen3_smoke4 --per-family 3
"""

from __future__ import annotations

import argparse
import io
import json
import sys
from pathlib import Path

if __package__ in (None, ""):
    sys.path.insert(0, str(Path(__file__).resolve().parents[2]))

# families whose prompt promises a bore on the Z axis through the part centre
AXIAL_BORE_FAMILIES = (
    "threadcaps",
    "thumbscrews",
    "ringgears",
    "herringbones",
    "wormwheels",
    "beltrollers",
    "cams",
    "pipeclamps",
    "cardans",
)


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--parts-dir", type=Path, default=Path("optional_data/data/gen3"))
    parser.add_argument("--per-family", type=int, default=5, help="samples per family")
    args = parser.parse_args(argv)

    import trimesh

    from tools.dataset_gen2.stlcheck import stl_bytes
    from tools.dataset_gen2.miniscad import evaluate_3d

    rows = [
        json.loads(line)
        for line in (args.parts_dir / "manifest.jsonl").read_text(encoding="utf-8").splitlines()
        if line.strip()
    ]
    per_family: dict[str, int] = {}
    checked = 0
    missing: list[str] = []
    for row in rows:
        family = str(row["family"])
        if family not in AXIAL_BORE_FAMILIES:
            continue
        seen = per_family.get(family, 0)
        if seen >= args.per_family:
            continue
        per_family[family] = seen + 1
        source = (args.parts_dir / str(row["file"])).read_text(encoding="utf-8")
        height = float(row["expected_bbox_mm"][2])
        probe = [0.0, 0.0, round(height / 2, 3)]
        mesh = trimesh.load(
            io.BytesIO(stl_bytes(evaluate_3d(source))), file_type="stl", force="mesh", process=True
        )
        checked += 1
        if bool(mesh.contains([probe])[0]):
            missing.append(f"{row['file']}: solid at the axial probe {probe}")

    print(f"axial bore probes: {checked} samples in {len(per_family)} families")
    if missing:
        print(f"{len(missing)} samples are solid where a bore is promised:")
        for line in missing[:8]:
            print(f"   - {line}")
    else:
        print("every probe point is void, so the bores are really cut")
    return 1 if missing else 0


if __name__ == "__main__":
    raise SystemExit(main())
