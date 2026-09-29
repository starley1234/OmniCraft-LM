"""Seeded OpenSCAD generator for beams, trusses, and spatial frames."""

from __future__ import annotations

import hashlib
import random
from typing import Iterator

from src.data.generators.voxel_csg_gen import FACET_HEADER, _fmt
from src.data.schema import AuxiliaryGroundTruth, CADSample, SampleVerification


def _point(point: tuple[float, float, float]) -> str:
    return "[" + ", ".join(_fmt(value) for value in point) + "]"


class WireTrussGenerator:
    """Create a connected rectangular-prism truss with explicit outer bounds."""

    def __init__(self, seed: int = 0) -> None:
        self.seed = seed

    def generate(self, index: int = 0) -> CADSample:
        if index < 0:
            raise ValueError("index must be non-negative")
        rng = random.Random(f"omnicraft-wire-truss-v1:{self.seed}:{index}")
        inner_length = float(rng.randint(60, 180))
        inner_width = float(rng.randint(18, 55))
        inner_height = float(rng.randint(18, 55))
        radius = float(rng.randint(2, 5))
        target_bbox = (
            inner_length + 2.0 * radius,
            inner_width + 2.0 * radius,
            inner_height + 2.0 * radius,
        )
        # Offset the node skeleton by r so the hull(sphere,sphere) capsules occupy
        # [0,L]x[0,W]x[0,H], rather than protruding beyond the reported target box.
        nodes: list[tuple[float, float, float]] = [
            (x + radius, y + radius, z + radius)
            for z in (0.0, inner_height)
            for y in (0.0, inner_width)
            for x in (0.0, inner_length)
        ]
        edges = [
            (0, 1), (2, 3), (4, 5), (6, 7),
            (0, 2), (1, 3), (4, 6), (5, 7),
            (0, 4), (1, 5), (2, 6), (3, 7),
            (0, 7), (1, 6), (2, 5), (3, 4),
        ]
        lines = [
            FACET_HEADER.rstrip("\n"),
            f"// target_bbox: {_fmt(target_bbox[0])}, {_fmt(target_bbox[1])}, {_fmt(target_bbox[2])}",
            f"// connected truss with {len(nodes)} nodes and {len(edges)} members",
            "module strut(a, b, r) {",
            "  hull() {",
            "    translate(a) sphere(r=r);",
            "    translate(b) sphere(r=r);",
            "  }",
            "}",
            "union() {",
        ]
        for start, end in edges:
            lines.append(f"  strut({_point(nodes[start])}, {_point(nodes[end])}, {_fmt(radius)});")
        # These collars overlap the lower longitudinal struts and stay inside bounds.
        lines.append(
            f"  for (x = [{_fmt(radius)}, {_fmt(inner_length + radius)}]) "
            f"translate([x, {_fmt(radius)}, 0]) cylinder(h={_fmt(radius * 2)}, r={_fmt(radius)});"
        )
        lines.append("}")
        code = "\n".join(lines) + "\n"
        digest = hashlib.sha256(code.encode("utf-8")).hexdigest()
        prompt = (
            f"Rectangular spatial truss, outer dimensions "
            f"{target_bbox[0]:g} by {target_bbox[1]:g} by {target_bbox[2]:g} mm"
        )
        return CADSample(
            id=f"wire_truss_{self.seed:06d}_{index:06d}",
            layer="wire",
            prompts={"en": prompt},
            code=code,
            verification=SampleVerification(target_bbox=target_bbox),
            auxiliary_ground_truth=AuxiliaryGroundTruth(nodes=nodes, edges=edges),
            metadata={
                "source": "wire_truss_gen",
                "generator_version": 1,
                "generator_seed": self.seed,
                "generator_index": index,
                "kind": "truss",
                "generator_parameters": {
                    "skeleton_length_mm": inner_length,
                    "skeleton_width_mm": inner_width,
                    "skeleton_height_mm": inner_height,
                    "member_radius_mm": radius,
                },
                "code_sha256": digest,
                "analytic_geometry": {
                    "kind": "wire_truss",
                    "exact_bbox": True,
                    "bbox": list(target_bbox),
                    "volume_exact": False,
                    "graph_connected": True,
                    "member_radius_mm": radius,
                },
            },
        )

    def generate_many(self, count: int) -> Iterator[CADSample]:
        if count < 0:
            raise ValueError("count must be non-negative")
        for index in range(count):
            yield self.generate(index)


def generate_wire_trusses(count: int, seed: int = 0) -> list[CADSample]:
    return list(WireTrussGenerator(seed).generate_many(count))
