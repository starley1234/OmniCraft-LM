"""Geometric Chain-of-Thought support: compose and parse [SPECS] blocks.

Contract (docs/archive/AGENTS_CoG.md / ARCHITECTURE.md 8.1): before the canvas trigger token
the stream carries

    [SPECS]
    class: <object_class>
    bbox: [X, Y, Z]
    topology: <brief strategy>
    canvas: <sketch|voxel|wire|brep|assembly>
    [/SPECS]

Deterministic everywhere: composed from dataset records at collate time and
reconstructed from free-text prompts at inference with strict fallbacks — no
path may raise; a missing/broken block degrades to the defaults with a warning.
"""

from __future__ import annotations

import logging
import re
from dataclasses import dataclass

logger = logging.getLogger("omnicraft.specs")

STOP_TOKEN = "[/SPECS]"
DEFAULT_BBOX = (100.0, 100.0, 100.0)
DEFAULT_CANVAS = "sketch"
CANVASES = ("voxel", "wire", "sketch", "brep", "assembly")

_BBOX_RE = re.compile(r"bbox\s*:\s*\[\s*([0-9.]+)\s*,\s*([0-9.]+)\s*,\s*([0-9.]+)\s*\]")
_CANVAS_RE = re.compile(r"canvas\s*:\s*([a-zA-Z]+)")
_CLASS_RE = re.compile(r"class\s*:\s*([^\n]+)")
_TOPOLOGY_RE = re.compile(r"topology\s*:\s*([^\n]+)")
# Dimensional phrases in free text: "80x50x6 мм", "60 x 60 x 10 mm", "d=6" excluded.
_DIMS_RE = re.compile(
    r"(\d+(?:[.,]\d+)?)\s*[xх×]\s*(\d+(?:[.,]\d+)?)\s*[xх×]\s*(\d+(?:[.,]\d+)?)\s*(мм|mm)?",
    re.IGNORECASE,
)
_NUMBER_RE = re.compile(r"\d+(?:[.,]\d+)?")


@dataclass(frozen=True, slots=True)
class Specs:
    object_class: str
    bbox: tuple[float, float, float]
    topology: str
    canvas: str

    def render(self) -> str:
        x, y, z = self.bbox
        return (
            f"[SPECS]\nclass: {self.object_class}\n"
            f"bbox: [{x:g}, {y:g}, {z:g}]\n"
            f"topology: {self.topology}\ncanvas: {self.canvas}\n{STOP_TOKEN}\n"
        )


def compose_specs(
    *,
    object_class: str,
    bbox: tuple[float, float, float],
    canvas: str,
    topology: str | None = None,
) -> Specs:
    """Build a valid specs block from trusted record fields."""
    if canvas not in CANVASES:
        raise ValueError(f"canvas must be one of {CANVASES}, got {canvas!r}")
    if any(v <= 0 for v in bbox):
        raise ValueError(f"bbox must be positive, got {bbox}")
    strategy = topology or _default_topology(canvas)
    return Specs(object_class=object_class, bbox=bbox, topology=strategy, canvas=canvas)


def _default_topology(canvas: str) -> str:
    return {
        "voxel": "csg union/difference",
        "wire": "node-edge graph hull members",
        "sketch": "closed profile + extrude/revolve",
        "brep": "analytic surface boundary",
        "assembly": "se3 transform tree",
    }[canvas]


def _parse_dims(text: str) -> tuple[float, float, float] | None:
    match = _DIMS_RE.search(text)
    if match:
        try:
            return tuple(float(group.replace(",", ".")) for group in match.groups()[:3])  # type: ignore[return-value]
        except ValueError:
            return None
    return None


def parse_specs_block(text: str) -> Specs | None:
    """Parse a [SPECS] block; returns None when no block is present."""
    if "[SPECS]" not in text:
        return None
    bbox: tuple[float, float, float] = DEFAULT_BBOX
    canvas = DEFAULT_CANVAS
    bbox_match = _BBOX_RE.search(text)
    if bbox_match:
        try:
            values = [max(float(bbox_match.group(i)), 1.0) for i in range(1, 4)]
            bbox = (values[0], values[1], values[2])
        except ValueError:
            logger.warning("specs bbox malformed; fallback bbox used")
    else:
        logger.warning("no bbox in [SPECS]; fallback bbox used")
    canvas_match = _CANVAS_RE.search(text)
    if canvas_match and canvas_match.group(1) in CANVASES:
        canvas = canvas_match.group(1)
    elif canvas_match:
        logger.warning("unknown canvas %r; fallback %r", canvas_match.group(1), DEFAULT_CANVAS)
    object_class = _CLASS_RE.search(text)
    topology = _TOPOLOGY_RE.search(text)
    return Specs(
        object_class=object_class.group(1).strip() if object_class else "unknown",
        bbox=bbox,
        topology=topology.group(1).strip() if topology else _default_topology(canvas),
        canvas=canvas,
    )


def extract_specs_from_text(text: str) -> Specs:
    """Robust path for raw user prompts: parse a specs block, else mine the text.

    Falls back never crash: dimensions like ``80x50x6 мм`` wire the scale; a
    canvas hint word ("ферма"/"truss" → wire, etc.) routes the layer; anything
    missing degrades to documented defaults plus a warning.
    """
    block = parse_specs_block(text)
    if block is not None:
        return block
    bbox = _parse_dims(text)
    if bbox is None:
        logger.warning("no dimensions found in prompt; fallback bbox used")
        bbox = DEFAULT_BBOX
    lowered = text.lower()
    canvas = DEFAULT_CANVAS
    for keyword, target in _CANVAS_KEYWORDS.items():
        if keyword in lowered:
            canvas = target
            break
    return Specs(
        object_class="freeform",
        bbox=bbox,
        topology=_default_topology(canvas),
        canvas=canvas,
    )


_CANVAS_KEYWORDS = {
    "ферм": "wire", "truss": "wire", "каркас": "wire", "frame": "wire",
    "балка": "wire", "beam": "wire", "рама": "wire",
    "шестерн": "sketch", "gear": "sketch", "профиль": "sketch", "profile": "sketch",
    "кулач": "sketch", "cam": "sketch", "рычаг": "sketch", "lever": "sketch",
    "сборк": "assembly", "assembly": "assembly",
    "фланец": "voxel", "flange": "voxel", "корпус": "voxel", "enclosure": "voxel",
    "пластина": "voxel", "plate": "voxel", "втулка": "voxel", "bushing": "voxel",
}


def build_prompt_with_specs(user_query: str, specs: Specs) -> str:
    """Compose the training/inference prompt body fed to the model."""
    return f"{user_query}\n{specs.render()}"
