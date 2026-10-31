"""Receiver-simulation STL gate.

The receiving side compiles the .scad with the OpenSCAD CLI and then runs
``trimesh.load(stl, force="mesh", process=True)`` + ``mesh.split()`` +
``mesh.is_watertight`` (see ``src/env/openscad_runner.py``).  This module walks
the same path without the CLI: build the Manifold the OpenSCAD manifold backend
would build, export a binary STL, and run exactly those trimesh calls.  It is
what caught the two defect classes of the previous delivery:

* ``rotate_extrude`` of a profile that touches the axis (15 shafts without a
  boolean left the degenerate mesh untouched),
* hairline wedges where a cutter's end plane grazes a sloped face
  (``lbrackets/part_0062``).

    python tools/dataset_gen2/stlcheck.py optional_data/data/gen2/shafts
"""

from __future__ import annotations

import io
import struct
import sys
from pathlib import Path

if __package__ in (None, ""):
    sys.path.insert(0, str(Path(__file__).resolve().parents[2]))

import numpy as np

# float32 STL, so results are compared the way the receiver sees them
DEGENERATE_AREA = 1e-9


def stl_bytes(mesh) -> bytes:
    """Binary STL of a manifold, exactly like OpenSCAD writes it."""
    solid = mesh.to_mesh()
    verts = np.asarray(solid.vert_properties, dtype=np.float64)[:, :3]
    tris = np.asarray(solid.tri_verts, dtype=np.int64)
    buffer = io.BytesIO()
    buffer.write(b"corpus stl".ljust(80, b"\0"))
    buffer.write(struct.pack("<I", len(tris)))
    for tri in tris:
        a, b, c = verts[tri[0]], verts[tri[1]], verts[tri[2]]
        normal = np.cross(b - a, c - a)
        length = float(np.linalg.norm(normal))
        normal = normal / length if length > 1e-12 else np.zeros(3)
        buffer.write(struct.pack("<3f", *normal))
        for point in (a, b, c):
            buffer.write(struct.pack("<3f", *point))
        buffer.write(struct.pack("<H", 0))
    return buffer.getvalue()


def trimesh_report(data: bytes) -> dict:
    """The four numbers the receiver's validator reports for a sample."""
    import trimesh

    loaded = trimesh.load(io.BytesIO(data), file_type="stl", force="mesh", process=True)
    if isinstance(loaded, trimesh.Scene):
        loaded = trimesh.util.concatenate(list(loaded.geometry.values()))
    parts = list(loaded.split(only_watertight=False))
    degenerate = 0
    if len(loaded.faces):
        corners = loaded.vertices[loaded.faces]
        area = 0.5 * np.linalg.norm(
            np.cross(corners[:, 1] - corners[:, 0], corners[:, 2] - corners[:, 0]), axis=1
        )
        degenerate = int((area < DEGENERATE_AREA).sum())
    return {
        "watertight": bool(loaded.is_watertight),
        "components": len(parts),
        "euler": int(loaded.euler_number),
        "faces": int(loaded.faces.shape[0]),
        "degenerate": degenerate,
    }


def check_source(source: str) -> dict:
    from tools.dataset_gen2.miniscad import evaluate_3d

    return trimesh_report(stl_bytes(evaluate_3d(source)))


def check_file(path: Path) -> dict:
    return check_source(Path(path).read_text(encoding="utf-8"))


def is_bad(info: dict) -> bool:
    """True when the receiver would reject the sample."""
    return bool(info["components"] != 1 or not info["watertight"] or info["degenerate"])


def main(argv: list[str] | None = None) -> int:
    targets = argv if argv is not None else sys.argv[1:]
    targets = targets or ["optional_data/data/gen2"]
    bad_total = 0
    checked = 0
    for target in targets:
        root = Path(target)
        files = sorted(root.glob("*.scad")) if root.is_dir() else [root]
        bad: list[tuple[str, dict]] = []
        for path in files:
            checked += 1
            info = check_file(path)
            if is_bad(info):
                bad.append((path.name, info))
        print(f"{target}: {len(files) - len(bad)}/{len(files)} watertight, single component, no slivers")
        for name, info in bad[:8]:
            print(f"   - {name}: {info}")
        bad_total += len(bad)
    print(f"checked {checked} files, {bad_total} bad")
    return 1 if bad_total else 0


if __name__ == "__main__":
    sys.exit(main())
