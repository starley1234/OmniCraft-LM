"""Parametric OpenSCAD generator for boxes, enclosures, adapters, and flanges."""

from __future__ import annotations

import hashlib
import math
import random
from typing import Iterator

from src.data.schema import AuxiliaryGroundTruth, CADSample, SampleVerification

FACET_HEADER = "$fn = 32;\n"


def _fmt(value: float) -> str:
    return f"{value:.2f}".rstrip("0").rstrip(".")


class VoxelCSGGenerator:
    """Seeded generator; every sample carries an auditable analytic descriptor."""

    def __init__(self, seed: int = 0) -> None:
        self.seed = seed

    def generate(self, index: int = 0) -> CADSample:
        if index < 0:
            raise ValueError("index must be non-negative")
        rng = random.Random(f"omnicraft-voxel-csg-v1:{self.seed}:{index}")
        kind = rng.choice(("enclosure", "box", "adapter", "flange"))
        holes = 0
        generator_parameters: dict[str, float | int] = {}
        if kind in ("enclosure", "box"):
            x, y, z = (rng.randint(24, 100) for _ in range(3))
            wall = max(2, min(x, y, z) // rng.randint(8, 14))
            generator_parameters = {"x_mm": x, "y_mm": y, "z_mm": z, "wall_mm": wall}
            bbox = (float(x), float(y), float(z))
            # The cutter reaches the top face. Its intersection with the outer
            # solid is (x-2w)*(y-2w)*(z-w), giving an exact analytic volume.
            inner_volume = float((x - 2 * wall) * (y - 2 * wall) * (z - wall))
            volume = float(x * y * z) - inner_volume
            body = (
                f"difference() {{\n  cube([{x}, {y}, {z}]);\n"
                f"  translate([{wall}, {wall}, {wall}]) cube([{x - 2 * wall}, {y - 2 * wall}, {z}]);\n}}"
            )
            prompt = (
                f"Open-top hollow enclosure, {x} by {y} by {z} mm with {wall} mm walls"
                if kind == "enclosure"
                else f"Open-top rectangular box, {x} by {y} by {z} mm with {wall} mm walls"
            )
            euler = 2
        elif kind == "adapter":
            diameter = rng.randint(24, 90)
            height = rng.randint(12, 55)
            bore = rng.randint(max(5, diameter // 5), max(6, diameter // 2))
            generator_parameters = {"outer_diameter_mm": diameter, "bore_diameter_mm": bore, "height_mm": height}
            bbox = (float(diameter), float(diameter), float(height))
            volume = math.pi * height * (diameter**2 - bore**2) / 4.0
            body = (
                f"difference() {{\n  cylinder(h={height}, d={diameter});\n"
                f"  translate([0, 0, -1]) cylinder(h={height + 2}, d={bore});\n}}"
            )
            prompt = f"Cylindrical through-bore adapter, {diameter} mm outer diameter, {bore} mm bore, {height} mm high"
            holes = 1
            euler = 0
        else:
            diameter = rng.randint(35, 100)
            height = rng.randint(6, 20)
            bore = rng.randint(6, diameter // 3)
            bolt_circle = diameter * 0.72
            hole_diameter = 5.0
            generator_parameters = {
                "outer_diameter_mm": diameter,
                "bore_diameter_mm": bore,
                "height_mm": height,
                "bolt_circle_mm": bolt_circle,
                "bolt_hole_diameter_mm": hole_diameter,
            }
            bbox = (float(diameter), float(diameter), float(height))
            volume = math.pi * height * (
                diameter**2 - bore**2 - 4.0 * hole_diameter**2
            ) / 4.0
            body = (
                f"difference() {{\n  cylinder(h={height}, d={diameter});\n"
                f"  translate([0, 0, -1]) cylinder(h={height + 2}, d={bore});\n"
                f"  for (i = [0:3]) rotate([0, 0, i * 90]) translate([{_fmt(bolt_circle / 2)}, 0, -1])\n"
                f"    cylinder(h={height + 2}, d={_fmt(hole_diameter)});\n}}"
            )
            prompt = f"Circular flange, {diameter} mm outer diameter, {height} mm thick, central bore and four bolt holes"
            holes = 5
            euler = 2 - 2 * holes

        code = FACET_HEADER + f"// target_bbox: {_fmt(bbox[0])}, {_fmt(bbox[1])}, {_fmt(bbox[2])}\n" + body + "\n"
        digest = hashlib.sha256(code.encode("utf-8")).hexdigest()
        analytic_geometry = {
            "kind": kind,
            "exact": True,
            "bbox": list(bbox),
            "volume_mm3": volume,
            "is_watertight": True,
            "euler_characteristic": euler,
            "components_count": 1,
            "holes_count": holes,
        }
        return CADSample(
            id=f"voxel_csg_{self.seed:06d}_{index:06d}",
            layer="voxel",
            prompts={"en": prompt},
            code=code,
            verification=SampleVerification(target_bbox=bbox),
            auxiliary_ground_truth=AuxiliaryGroundTruth(),
            metadata={
                "source": "voxel_csg_gen",
                "generator_version": 1,
                "generator_seed": self.seed,
                "generator_index": index,
                "kind": kind,
                "generator_parameters": generator_parameters,
                "code_sha256": digest,
                "analytic_geometry": analytic_geometry,
            },
        )

    def generate_many(self, count: int) -> Iterator[CADSample]:
        if count < 0:
            raise ValueError("count must be non-negative")
        for index in range(count):
            yield self.generate(index)


def generate_voxel_csg(count: int, seed: int = 0) -> list[CADSample]:
    return list(VoxelCSGGenerator(seed).generate_many(count))
