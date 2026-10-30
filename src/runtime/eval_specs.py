"""Which ``[SPECS]`` block evaluation feeds the model (torch-free, unit-testable).

The held-out prompts differ in one respect that matters for scale: some rows carry
``expected_bbox_mm`` (a trusted oracle), others only describe the part in words.
``evaluate_generation.py`` used to mix the two paths silently, which made it
impossible to tell whether a bad bbox came from the model ignoring the block or
from the miner guessing the wrong scale.

Three modes make the question answerable on the same weights and the same rows:

* ``auto``  — oracle bbox when the row has ``expected_bbox_mm``, else mined
  (the historical eval behaviour, kept as the default);
* ``mined`` — always the miner's reading of the text: the real user path, no GT;
* ``none``  — no ``[SPECS]`` block at all; the hook canvas still receives the
  mined bbox, so the only variable left is the textual block itself.

Comparing ``auto`` with ``none`` answers "does the model look at the block?";
comparing ``auto`` with ``mined`` answers "how much does the miner cost us?".
"""

from __future__ import annotations

from typing import Any, Mapping, Sequence

from src.runtime.specs_hook import Specs, compose_specs, extract_specs_from_text

SPECS_MODES = ("auto", "mined", "none")


def expected_bbox(row: Mapping[str, Any]) -> tuple[float, float, float] | None:
    """Return a usable oracle bbox from a held-out row, or ``None``."""
    raw = row.get("expected_bbox_mm")
    if not isinstance(raw, Sequence) or isinstance(raw, (str, bytes)) or len(raw) != 3:
        return None
    try:
        values = tuple(float(v) for v in raw)
    except (TypeError, ValueError):
        return None
    if any(v <= 0 for v in values):
        return None
    return values  # type: ignore[return-value]


def specs_for_row(
    row: Mapping[str, Any], *, layer: str, mode: str = "auto"
) -> tuple[Specs | None, tuple[float, float, float]]:
    """Build the block for one held-out row plus the bbox the canvas hook gets.

    Returns ``(specs_or_None, canvas_bbox)``; ``None`` means "prompt without a
    ``[SPECS]`` block". ``canvas_bbox`` is always the block bbox when a block is
    rendered, so text and canvas never disagree.
    """
    if mode not in SPECS_MODES:
        raise ValueError(f"specs mode must be one of {SPECS_MODES}, got {mode!r}")
    prompt = str(row.get("prompt", ""))
    mined = extract_specs_from_text(prompt, canvas_hint=layer)
    if mode == "none":
        return None, mined.bbox
    oracle = expected_bbox(row) if mode == "auto" else None
    bbox = oracle or mined.bbox
    specs = compose_specs(
        object_class=mined.object_class,
        bbox=bbox,
        canvas=layer,
        topology=mined.topology,
    )
    return specs, bbox
