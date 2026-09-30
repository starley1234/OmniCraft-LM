"""Voxel-grid GT sanity: occupancy of known solids (skipped without OpenSCAD/rtree)."""

from __future__ import annotations

import base64
import shutil

import numpy as np
import pytest

from tools.build_voxel_grids import sample_grid

pytestmark = pytest.mark.skipif(
    shutil.which("openscad") is None, reason="OpenSCAD is not installed"
)


def _decode(record: dict) -> np.ndarray:
    packed = base64.b64decode(record["grid_b64"])
    return np.unpackbits(np.frombuffer(packed, dtype=np.uint8), count=16**3).reshape(16, 16, 16)


def test_solid_cube_fills_all_cells() -> None:
    try:
        from src.env.openscad_runner import OpenSCADRunner

        record = sample_grid("$fn = 32;\ncube([10, 20, 30]);\n", OpenSCADRunner())
    except Exception as exc:  # rtree missing etc.
        pytest.skip(f"grid probing unavailable: {exc}")
    assert record is not None
    grid = _decode(record)
    assert grid.sum() == 16**3


def test_center_hole_punches_middle_cells_only() -> None:
    from src.env.openscad_runner import OpenSCADRunner

    record = sample_grid(
        "$fn = 32;\ndifference() { cube([10, 10, 30]); "
        "translate([5, 5, -1]) cylinder(h=32, d=4); }\n",
        OpenSCADRunner(),
    )
    assert record is not None
    grid = _decode(record)
    # Grid axes are packed (z, y, x). The through-hole runs along z at x=y=5.
    assert grid[0, 0, 0] == 1  # a corner far from the hole stays solid
    assert grid[8, 8, 8] == 0  # cube centre is inside the hole
    assert grid[:, 8, 8].sum() == 0  # the whole z-column at the hole is empty
    # while a z-column one quarter out from the centre stays fully solid
    assert grid[:, 2, 2].sum() == 16
    assert grid.sum() < 16**3
