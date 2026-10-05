"""Seeded generators for six wire-layer families (v15 «задача A»: diversity, not paraphrases).

Each design is a connected frame of hull-of-spheres capsules (the idiom the v9/v14
corpus taught) with an analytically exact outer bbox: nodes are inset by the member
radius ``r`` so the capsule ends land on ``[0, extent]`` per axis, exactly like
``wire_truss_gen``. Aux ground truth carries the node skeleton and member list for
the wire canvas. Node count is kept <= 32 to match the canvas.

Families (kind): pratt/warren trusses, space frame, lattice tower, cable-stayed
span, gantry portals. Prompts come in six styles; the ``conv_*`` pair is
deliberately dimension-free so the model must read scale from the trusted
``[SPECS]`` block (the v14 voxel win, now for wire).
"""

from __future__ import annotations

import hashlib
import math
import random
from typing import Callable, Iterator

from src.data.generators.voxel_csg_gen import FACET_HEADER, _fmt
from src.data.generators.wire_truss_gen import _point
from src.data.schema import AuxiliaryGroundTruth, CADSample, SampleVerification

MAX_NODES = 32


def _edge_key(start: int, end: int) -> tuple[int, int]:
    return (start, end) if start < end else (end, start)


class EdgeSet:
    """Insertion-ordered edge set without self-loops/duplicates."""

    def __init__(self) -> None:
        self._seen: set[tuple[int, int]] = set()
        self.edges: list[tuple[int, int]] = []

    def add(self, start: int, end: int) -> None:
        if start == end:
            return
        key = _edge_key(start, end)
        if key in self._seen:
            return
        self._seen.add(key)
        self.edges.append((start, end))


def _pratt(rng: random.Random) -> tuple[list[tuple[float, float, float]], list[tuple[int, int]],
                                         tuple[float, float, float], dict]:
    bays = rng.randint(3, 6)
    bay_len = float(rng.randint(45, 90))
    height = float(rng.randint(30, 70))
    width = float(rng.randint(20, 45))
    r = float(rng.randint(2, 5))
    bottom = [(i * bay_len, 0.0, 0.0) for i in range(bays + 1)]
    top = [(i * bay_len, width, height) for i in range(bays + 1)]
    nodes = [(x + r, y + r, z + r) for x, y, z in bottom + top]
    e = EdgeSet()
    n = bays + 1
    for i in range(bays):
        e.add(i, i + 1)
        e.add(n + i, n + i + 1)
    for i in range(1, bays):  # verticals at interior stations
        e.add(i, n + i)
    mid = bays / 2
    for i in range(bays):  # diagonals down-to-center (Pratt rule)
        if i < mid - 0.5:
            e.add(n + i, i + 1)
        elif i > mid - 0.5:
            e.add(n + i + 1, i)
        elif bays % 2:
            e.add(n + i, i + 1)
    span = bays * bay_len
    bbox = (span + 2 * r, width + 2 * r, height + 2 * r)
    params = {"bays": bays, "bay_length_mm": bay_len, "depth_mm": height,
              "width_mm": width, "member_radius_mm": r}
    return nodes, e.edges, bbox, params


def _warren(rng: random.Random) -> tuple[list[tuple[float, float, float]], list[tuple[int, int]],
                                          tuple[float, float, float], dict]:
    bays = rng.randint(4, 8)
    bay_len = float(rng.randint(40, 80))
    height = float(rng.randint(28, 60))
    width = 0.0  # planar truss
    r = float(rng.randint(2, 5))
    bottom = [(i * bay_len, 0.0, 0.0) for i in range(bays + 1)]
    top = [((i + 0.5) * bay_len, 0.0, height) for i in range(bays)]
    nodes = [(x + r, y + r, z + r) for x, y, z in bottom + top]
    e = EdgeSet()
    n = bays + 1
    for i in range(bays):
        e.add(i, i + 1)
    for i in range(bays - 1):
        e.add(n + i, n + i + 1)
    for i in range(bays):  # zigzag web
        e.add(i, n + i)
        e.add(i + 1, n + i)
    bbox = (bays * bay_len + 2 * r, 2 * r, height + 2 * r)
    params = {"bays": bays, "bay_length_mm": bay_len, "depth_mm": height, "member_radius_mm": r}
    return nodes, e.edges, bbox, params


def _space_frame(rng: random.Random) -> tuple[list[tuple[float, float, float]], list[tuple[int, int]],
                                               tuple[float, float, float], dict]:
    bx, by = rng.randint(2, 3), rng.randint(2, 3)
    sx, sy = float(rng.randint(35, 70)), float(rng.randint(35, 70))
    height = float(rng.randint(25, 50))
    r = float(rng.randint(2, 5))
    lower = [(i * sx, j * sy, 0.0) for j in range(by + 1) for i in range(bx + 1)]
    upper = [(i * sx, j * sy, height) for j in range(by + 1) for i in range(bx + 1)]
    nodes = [(x + r, y + r, z + r) for x, y, z in lower + upper]
    e = EdgeSet()
    w = bx + 1

    def grid_edges(offset: int) -> None:
        for j in range(by + 1):
            for i in range(bx):
                e.add(offset + j * w + i, offset + j * w + i + 1)
        for j in range(by):
            for i in range(bx + 1):
                e.add(offset + j * w + i, offset + (j + 1) * w + i)

    grid_edges(0)
    grid_edges(w * (by + 1))
    for j in range(by + 1):
        for i in range(bx + 1):
            idx = j * w + i
            e.add(idx, w * (by + 1) + idx)  # struts
    for j in range(by):  # one diagonal per lower cell for stiffness
        for i in range(bx):
            e.add(j * w + i, j * w + i + w + 1)
    bbox = (bx * sx + 2 * r, by * sy + 2 * r, height + 2 * r)
    params = {"bays_x": bx, "bays_y": by, "bay_x_mm": sx, "bay_y_mm": sy,
              "depth_mm": height, "member_radius_mm": r}
    return nodes, e.edges, bbox, params


def _tower(rng: random.Random) -> tuple[list[tuple[float, float, float]], list[tuple[int, int]],
                                         tuple[float, float, float], dict]:
    levels = rng.randint(3, 4)
    base = float(rng.randint(50, 90))
    set_back = float(rng.randint(6, 12)) * (levels - 1)
    level_h = float(rng.randint(35, 60))
    r = float(rng.randint(2, 4))
    nodes: list[tuple[float, float, float]] = []
    for k in range(levels + 1):
        inset = set_back * k / levels
        x0, x1 = inset, base - inset
        z = level_h * k
        for x, y in ((x0, x0), (x1, x0), (x1, x1), (x0, x1)):
            nodes.append((x + r, y + r, z + r))
    e = EdgeSet()
    for k in range(levels + 1):  # square rings
        b = 4 * k
        for i in range(4):
            e.add(b + i, b + (i + 1) % 4)
    for k in range(levels):  # legs + one X-diagonal per face
        b, t = 4 * k, 4 * (k + 1)
        for i in range(4):
            e.add(b + i, t + i)
            e.add(b + i, t + (i + 1) % 4)
    bbox = (base + 2 * r, base + 2 * r, level_h * levels + 2 * r)
    params = {"levels": levels, "base_mm": base, "level_height_mm": level_h,
              "member_radius_mm": r}
    return nodes, e.edges, bbox, params


def _cable_stayed(rng: random.Random) -> tuple[list[tuple[float, float, float]], list[tuple[int, int]],
                                                tuple[float, float, float], dict]:
    """Planar fan: continuous deck chord, A-pylon legs, cables from a lower apex."""
    pairs = rng.randint(3, 4)
    spacing = float(rng.randint(40, 70))
    pylon_h = float(rng.randint(70, 120))
    r = float(rng.randint(2, 4))
    span = 2 * pairs * spacing
    cx = span / 2
    deck = [(i * spacing, 0.0, 0.0) for i in range(2 * pairs + 1)]
    legs = [(cx - 0.4 * spacing, 0.0, 0.0), (cx + 0.4 * spacing, 0.0, 0.0)]
    apex = [(cx, 0.0, pylon_h), (cx, 0.0, 0.72 * pylon_h)]
    nodes = [(x + r, y + r, z + r) for x, y, z in deck + legs + apex]
    leg_a, leg_b, apex_top, apex_mid = len(deck), len(deck) + 1, len(deck) + 2, len(deck) + 3
    e = EdgeSet()
    for i in range(len(deck) - 1):
        e.add(i, i + 1)  # deck chord
    e.add(leg_a, leg_b)  # pylon base tie
    e.add(leg_a, apex_mid)
    e.add(leg_b, apex_mid)
    e.add(apex_mid, apex_top)  # mast head above the fan anchor
    for i in range(len(deck)):  # fan cables from the lower apex
        e.add(apex_mid, i)
    bbox = (span + 2 * r, 2 * r, pylon_h + 2 * r)
    params = {"anchor_pairs": pairs, "anchor_spacing_mm": spacing,
              "pylon_height_mm": pylon_h, "member_radius_mm": r}
    return nodes, e.edges, bbox, params


def _gantry(rng: random.Random) -> tuple[list[tuple[float, float, float]], list[tuple[int, int]],
                                          tuple[float, float, float], dict]:
    portals = rng.randint(3, 7)
    pitch = float(rng.randint(50, 95))
    height = float(rng.randint(45, 95))
    width = float(rng.randint(30, 60))
    r = float(rng.randint(2, 5))
    nodes: list[tuple[float, float, float]] = []
    for k in range(portals):
        x = k * pitch
        for y, z in ((0.0, 0.0), (width, 0.0), (width, height), (0.0, height)):
            nodes.append((x + r, y + r, z + r))
    e = EdgeSet()
    for k in range(portals):
        b = 4 * k
        e.add(b, b + 1)          # rail beam low side
        e.add(b + 2, b + 3)      # top beam
        e.add(b, b + 3)          # leg
        e.add(b + 1, b + 2)      # leg
    for k in range(portals - 1):  # longitudinal rails + tops + face bracing
        b, t = 4 * k, 4 * (k + 1)
        e.add(b, t)
        e.add(b + 1, t + 1)
        e.add(b + 3, t + 2)
        if k % 2:
            e.add(b, t + 1)
        else:
            e.add(b + 1, t)
    bbox = ((portals - 1) * pitch + 2 * r, width + 2 * r, height + 2 * r)
    params = {"portals": portals, "pitch_mm": pitch, "height_mm": height,
              "width_mm": width, "member_radius_mm": r}
    return nodes, e.edges, bbox, params


FAMILIES: dict[str, Callable[[random.Random], tuple[list, list, tuple, dict]]] = {
    "pratt": _pratt,
    "warren": _warren,
    "space_frame": _space_frame,
    "tower": _tower,
    "cable_stayed": _cable_stayed,
    "gantry": _gantry,
}

_KIND_NOUN = {
    "pratt": ("Pratt truss girder", "ферма Пратта"),
    "warren": ("Warren truss", "ферма Уоррена"),
    "space_frame": ("space frame grid", "пространственная рамная конструкция"),
    "tower": ("lattice tower", "решётчатая башня"),
    "cable_stayed": ("cable-stayed span model", "ванная модель пролёта на пилоне"),
    "gantry": ("gantry portal frame", "портальная эстакада"),
}


class WireFamiliesGenerator:
    """Seeded family generator; index determines (family, parameters) deterministically."""

    def __init__(self, seed: int = 0, families: tuple[str, ...] | None = None) -> None:
        self.seed = seed
        self.families = tuple(families or FAMILIES)
        unknown = set(self.families) - set(FAMILIES)
        if unknown:
            raise ValueError(f"unknown wire families {sorted(unknown)}; have {sorted(FAMILIES)}")

    def generate(self, index: int = 0) -> CADSample:
        if index < 0:
            raise ValueError("index must be non-negative")
        family = self.families[index % len(self.families)]
        rng = random.Random(f"omnicraft-wire-fam-v1:{self.seed}:{index}")
        nodes, edges, bbox, params = FAMILIES[family](rng)
        if len(nodes) > MAX_NODES:
            raise ValueError(f"{family} produced {len(nodes)} nodes > {MAX_NODES}")

        lines = [
            FACET_HEADER.rstrip("\n"),
            f"// target_bbox: {_fmt(bbox[0])}, {_fmt(bbox[1])}, {_fmt(bbox[2])}",
            f"// {family} frame with {len(nodes)} nodes and {len(edges)} members",
            "module strut(a, b, r) {",
            "  hull() {",
            "    translate(a) sphere(r=r);",
            "    translate(b) sphere(r=r);",
            "  }",
            "}",
            "union() {",
        ]
        for start, end in edges:
            lines.append(f"  strut({_point(nodes[start])}, {_point(nodes[end])}, {_fmt(params['member_radius_mm'])});")
        lines.append("}")
        code = "\n".join(lines) + "\n"
        digest = hashlib.sha256(code.encode("utf-8")).hexdigest()

        noun_en, noun_ru = _KIND_NOUN[family]
        dims_en = f"{bbox[0]:g} by {bbox[1]:g} by {bbox[2]:g} mm"
        dims_ru = f"{_fmt(bbox[0])}x{_fmt(bbox[1])}x{_fmt(bbox[2])} мм"
        prompts = {
            "en": f"{noun_en}, outer dimensions {dims_en}, built from round steel members",
            "ru": f"{noun_ru} внешними габаритами {dims_ru}, стержни круглого сечения",
            "free_en": f"A {noun_en.lower()} made of welded round bars "
                       f"measuring {dims_en} overall",
            "free_ru": f"Сварная {noun_ru}, габариты {dims_ru}, из круглой стальной трубки",
            "conv_en": f"need a light {noun_en.lower()} for a shelf bracket run, "
                       "scaled to my bench jig — you pick sensible dimensions",
            "conv_ru": f"сделай {noun_ru} для полки на верстаке, размеры на твоё усмотрение",
        }
        return CADSample(
            id=f"wire_fam_{family}_{self.seed:06d}_{index:06d}",
            layer="wire",
            prompts=prompts,
            code=code,
            verification=SampleVerification(target_bbox=bbox),
            auxiliary_ground_truth=AuxiliaryGroundTruth(nodes=nodes, edges=edges),
            metadata={
                "source": "wire_families_gen",
                "generator_version": 1,
                "generator_seed": self.seed,
                "generator_index": index,
                "kind": f"wire_{family}",
                "generator_parameters": params,
                "code_sha256": digest,
                "analytic_geometry": {
                    "kind": family,
                    "exact_bbox": True,
                    "bbox": list(bbox),
                    "volume_exact": False,
                    "graph_connected": True,
                    "member_radius_mm": params["member_radius_mm"],
                },
            },
        )

    def generate_many(self, count: int) -> Iterator[CADSample]:
        if count < 0:
            raise ValueError("count must be non-negative")
        for index in range(count):
            yield self.generate(index)


def generate_wire_families(count: int, seed: int = 0,
                           families: tuple[str, ...] | None = None) -> list[CADSample]:
    return list(WireFamiliesGenerator(seed, families).generate_many(count))
