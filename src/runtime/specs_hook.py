"""Geometric Chain-of-Thought support: compose and parse [SPECS] blocks.

Contract (docs/archive/AGENTS_CoG.md / ARCHITECTURE.md 8.1): before the canvas trigger token
the stream carries

    [SPECS]
    class: <object_class>
    bbox: [X, Y, Z]
    topology: <brief strategy>
    canvas: <sketch|voxel|wire|brep|assembly>
    [/SPECS]

Training composes the block from *trusted* record fields (``compose_specs``); inference
reconstructs it from free text (``extract_specs_from_text``). The miner must stay a
faithful *summariser* of the distribution the model was trained on, so three rules bind it:

1. ``class`` is only ever a family name from the corpus vocabulary (``metadata.origin``);
   an unrecognised prompt degrades to the canvas name — the exact fallback the trainer
   applies (``metadata.get("origin", layer)``). A value outside the vocabulary (the old
   hard-coded ``freeform``) hijacks the shape prior and is forbidden.
2. ``bbox`` is recovered from the phrasings the prompt generators actually emit
   (``96x96x10``, ``96 на 96 на 10 мм``, ``96 by 96 by 10 mm``, ``90x55 мм толщиной 6``,
   ``Ø96, толщиной 10``, ``90 mm OD, 8 mm thick``, ``Ø96x10``, ``пролёт 180 / сечение 40x40``);
   when nothing is recoverable the documented default [100, 100, 100] is kept — with
   ``provenance`` recording that honesty.
3. ``topology`` is always canonical for the *final* canvas: training never showed a block
   whose ``topology`` contradicted ``canvas`` (the old sketch-topology-on-voxel-canvas block
   made the model emit pseudo-OpenSCAD like ``module body() extrude()`` → parser errors).

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
# Canvas-specific fallback when the miner finds no dimensions; median of the v15 wire corpus
# (combined_v15_lm, 20,834 wire records, 2026-10-31) — avoids 2× Z-bias of the cubic default.
WIRE_DEFAULT_BBOX = (163.0, 49.8, 67.8)
DEFAULT_CANVAS = "sketch"
CANVASES = ("voxel", "wire", "sketch", "brep", "assembly")

# Plausibility window for a mined part size (mm): anything outside is a parsing
# artefact (thread codes, hole callouts, serial numbers), not the part envelope.
_MIN_DIM_MM = 0.5
_MAX_DIM_MM = 1000.0
# z/D prior for a round part when no height/thickness/length is stated anywhere.
# Median of bbox_z / bbox_x over round (x == y) voxel families of the v9 corpus
# slice (data/previews/families_v9/manifest.jsonl, 28 families) ≈ 0.44.
_ROUND_Z_RATIO = 0.45

_BBOX_RE = re.compile(r"bbox\s*:\s*\[\s*([0-9.]+)\s*,\s*([0-9.]+)\s*,\s*([0-9.]+)\s*\]")
_CANVAS_RE = re.compile(r"canvas\s*:\s*([a-zA-Z]+)")
_CLASS_RE = re.compile(r"class\s*:\s*([^\n]+)")
_TOPOLOGY_RE = re.compile(r"topology\s*:\s*([^\n]+)")

# --- free-text scale mining ---------------------------------------------------
# The corpus was built from prompt_augment.py templates; the patterns below mirror
# the dimension slots those templates render ("{x}x{y}x{z} мм", "{x} на {y} на {z}",
# "{x} by {y} by {z} mm", "Ø{d} мм", "{d} mm OD, {t} mm thick", "Ø{d}x{t}",
# "диаметром {d} на {t} мм толщиной", "квадрат {d} мм", "пролёт {L} / сечение {A}x{B}", ...).
_NUM = r"\d+(?:[.,]\d+)?"
_TRIPLE_RE = re.compile(
    rf"({_NUM})\s*(?:[xх×]|на|by)\s*({_NUM})\s*(?:[xх×]|на|by)\s*({_NUM})", re.IGNORECASE
)
# "Ø96x10 мм" — round stock written as diameter x height; must win over the bare pair.
_OMEGA_PAIR_RE = re.compile(rf"[Ø∅⌀]\s*({_NUM})\s*[xх×]\s*({_NUM})", re.IGNORECASE)
_PAIR_DELIM = rf"\s*(?:[xх×]|на|by)\s*"
_PAIR_RE = re.compile(rf"({_NUM}){_PAIR_DELIM}({_NUM})", re.IGNORECASE)
# Envelope words in front of a plan pair mean "the bbox is stated": such a pair outranks a
# stray diameter callout (pipes/flanges love mentioning tube bores mid-sentence).
_ENVELOPE_BEFORE_RE = re.compile(
    r"(?:габарит\w*|размер\w*|в\s+плане|габа\w+|envelope|overall|footprint)\W{0,12}$",
    re.IGNORECASE,
)
# "расстояние между гранями 17 мм" -> across-corners = 2/√3 · across-flats (hex prisms in
# the corpus are boxed as (2/√3·AF, AF, H)).
_HEX_AF_RE = re.compile(rf"(?:между\s+гран\w*|по\s+граням)\s*[:=]?\s*({_NUM})", re.IGNORECASE)
_CUBE_RE = re.compile(rf"(?:кубик?\w*|\bcube\b)\s*(?:размером|размер\w*|со стороной)?\s*[:=]?\s*({_NUM})\s*(?:мм|mm)", re.IGNORECASE)

# Outer-diameter candidates, most explicit first. Hole/bolt-circle callouts are then
# excluded by context (see _HOLE_BEFORE_RE / _CENTRES_AFTER_RE): "отверстием Ø23",
# "Ø3.4 мм с шагом", "по окружности Ø66" must never become the part envelope.
_DIA_RE = (
    re.compile(rf"(?:внешн\w*|наружн\w*|outer|outside)\s+диаметр\w*\s*(?:[:=—-]\s*)?({_NUM})"),
    re.compile(rf"({_NUM})\s*(?:мм|mm)?\s+(?:outer diameter|outside diameter)\b", re.IGNORECASE),
    re.compile(rf"(?:outer\s+)?(?:OD|outside)\s*(?:of)?\s*[:=]?\s*({_NUM})\s*(?:мм|mm)?", re.IGNORECASE),
    re.compile(rf"({_NUM})\s*(?:мм|mm)\s+(?:OD|across|outside|in diameter)\b", re.IGNORECASE),
    re.compile(rf"(?:квадрат\w*|square)\s*(?:со стороной\s*)?[:=]?\s*({_NUM})", re.IGNORECASE),
    re.compile(rf"[Ø∅⌀Φ]\s*({_NUM})"),
    re.compile(rf"(?:диаметр|diameters?)(?:ом| of)?\s*[:=]?\s*({_NUM})", re.IGNORECASE),
)
_HOLE_BEFORE_RE = re.compile(
    r"(?:отверст|отв\.|проход|паз|канавк|посадк|under|bore\b|hole\b|slot\b|clearance|под [Mm]\d)",
    re.IGNORECASE,
)
_CENTRES_AFTER_RE = re.compile(
    rf"\s*(?:{_NUM})?\s*(?:мм|mm)?\s*(?:hole\s*cent|bolt\s*cent|окружност|circle|центров|spacing|pitch|шаг|под\b)",
    re.IGNORECASE,
)

# Height/thickness/length, both word orders. Kind matters: "length/длина" of a linear
# member runs along X, "thickness/высота" stays on Z. Never matching "стенк/wall":
# the number must be adjacent to the keyword, and "толщиной стенок" is skipped because
# a word, not a digit, follows it.
_HEIGHT_Z_RE = (
    re.compile(rf"(?:толщин\w*|высот\w*)\s*[:=—-]?\s*({_NUM})"),
    re.compile(rf"({_NUM})\s*(?:мм|mm)?\s*(?:толщиной|высотой)\b"),
    re.compile(rf"({_NUM})\s*(?:мм|mm)?\s*(?:thick(?:ness)?|tall|high)\b", re.IGNORECASE),
    re.compile(rf"(?:thickness|height)\s*(?:of)?\s*[:=]?\s*({_NUM})\s*(?:мм|mm)?", re.IGNORECASE),
)
_HEIGHT_LEN_RE = (
    re.compile(rf"(?:длин\w*|пролёт\w*|пролет\w*)\s*(?:ом|ой)?\s*[:=—-]?\s*({_NUM})"),
    re.compile(rf"({_NUM})\s*(?:мм|mm)?\s*(?:длиной|пролётом|пролетом|long\b|span)\b"),
    re.compile(rf"(?:length|span)\s*(?:of)?\s*[:=]?\s*({_NUM})\s*(?:мм|mm)?", re.IGNORECASE),
)

# class-vocabulary mining: keyword → family name from ``metadata.origin`` in the training
# corpus (the full list: data/previews/families_v9/manifest.jsonl). Every target must be a
# real family; tests/test_specs_hook.py guards that against the manifest slice.
# First match wins, so the more specific phrase goes first. Unrecognised → the canvas name
# (the trainer's own fallback for records without origin) — never a foreign label.
_CLASS_HINTS: tuple[tuple[str, str], ...] = (
    (r"флан|\bflanges?\b", "flanges"),
    (r"монтажн\w*\s+(?:плит|пластин|панел|креплен|рамк)|mounting\s+plate|mounting\s+bracket",
     "mounting_plate_bracket/chamfered_plate"),
    (r"пластин|\bплит\w*|\bplate\b", "mounting_plate_bracket/chamfered_plate"),
    (r"крышк|\blids?\b|cover\s+plate", "caps"),
    (r"ферм|\btruss\w*", "trusses"),
    (r"вышк", "masttowers"),
    (r"корпус|enclosure|housing", "enclosures"),
    (r"короб|\box\b|ящик", "enclosurebox"),
    (r"кронштейн|\bbrackets?\b|l-bracket", "lbrackets"),
    (r"уголк\w*|gusset", "ribbracket"),
    (r"втулк|bushing|sleeve", "spacers"),
    (r"проставк|\bspacers?\b", "spacers"),
    (r"хомут|\bclamps?\b", "pipeclamps"),
    (r"петл|\bhinges?\b", "hinges"),
    (r"ручк|\bknobs?\b|\bhandle\b", "knobs"),
    (r"патрубк|air\s+duct", "airducts"),
    (r"воздуховод|\bducts?\b|wire\s+tray|лоток", "ducts"),
    (r"шестерн|шестерёнк|\bgear\b|\bgears\b", "spurgears"),
    (r"венц|ring\s+gear", "ringgears"),
    (r"шкив|\bpulleys?\b", "pulleys"),
    (r"звёздочк|звездочк|sprocket", "starwheels"),
    (r"зубчат\w*\s+рейк|\bracks?\b", "racks"),
    (r"червячн|\bworm\b", "wormwheels"),
    (r"подшипник|bearing|pillow\s+(block|housing)", "bearingblocks"),
    (r"кулач|\bcams?\b", "cams"),
    (r"проушин|eye\s+lug", "eyelugs"),
    (r"защёлк|защелк|snap[- ]?fit", "snapfits"),
    (r"направляющ|t[- ]slot", "tslots"),
    (r"ласточкин", "vguides"),
    (r"\bвал\b|\bвалы\b|stepped\s+axle|\bshaft", "shafts"),
    (r"перфораци|perforated\s+(?:panel|sheet)", "perfpanels"),
)
_CLASS_RES: tuple[tuple[re.Pattern[str], str], ...] = tuple(
    (re.compile(pattern, re.IGNORECASE), family) for pattern, family in _CLASS_HINTS
)


@dataclass(frozen=True, slots=True)
class Specs:
    object_class: str
    bbox: tuple[float, float, float]
    topology: str
    canvas: str
    # "record" (trusted dataset fields) | "block" (hand-written [SPECS]) |
    # how the miner derived the values, e.g. "class:keyword=фланц bbox:diameter+height".
    # Not part of the rendered contract — logging/UI only.
    provenance: str = "record"

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
    provenance: str = "record",
) -> Specs:
    """Build a valid specs block from trusted record fields."""
    if canvas not in CANVASES:
        raise ValueError(f"canvas must be one of {CANVASES}, got {canvas!r}")
    if any(v <= 0 for v in bbox):
        raise ValueError(f"bbox must be positive, got {bbox}")
    strategy = topology or _default_topology(canvas)
    return Specs(
        object_class=object_class, bbox=bbox, topology=strategy, canvas=canvas,
        provenance=provenance,
    )


def _default_topology(canvas: str) -> str:
    return {
        "voxel": "csg union/difference",
        "wire": "node-edge graph hull members",
        "sketch": "closed profile + extrude/revolve",
        "brep": "analytic surface boundary",
        "assembly": "se3 transform tree",
    }[canvas]


def _to_float(text: str) -> float:
    return float(text.replace(",", "."))


def _plausible(*values: float) -> bool:
    return all(_MIN_DIM_MM <= v <= _MAX_DIM_MM for v in values)


def _scan_height(patterns, text: str) -> float | None:
    for pattern in patterns:
        match = pattern.search(text)
        if not match:
            continue
        try:
            value = _to_float(match.group(1))
        except (TypeError, ValueError):
            continue
        if _plausible(value):
            return value
    return None


def _scan_diameter(text: str) -> float | None:
    """First diameter naming the part envelope; hole/BCD callouts are skipped by context."""
    for pattern in _DIA_RE:
        for match in pattern.finditer(text):
            before = text[max(0, match.start() - 28):match.start()]
            after = text[match.end():match.end() + 24]
            if _HOLE_BEFORE_RE.search(before) or _CENTRES_AFTER_RE.match(after):
                continue
            try:
                value = _to_float(match.group(1))
            except (TypeError, ValueError):
                continue
            if _plausible(value):
                return value
    return None


def _scan_pair(pattern: re.Pattern[str], text: str) -> tuple[float, float] | None:
    match = pattern.search(text)
    if not match:
        return None
    try:
        values = tuple(_to_float(group) for group in match.groups())
    except (TypeError, ValueError):
        return None
    return values if _plausible(*values) else None  # type: ignore[return-value]


def _first_envelope_pair(text: str) -> tuple[float, float, int] | None:
    """(a, b, rank): first AxB pair; rank 2 marks a pair stated right after an envelope word."""
    best: tuple[float, float, int] | None = None
    for match in _PAIR_RE.finditer(text):
        try:
            values = tuple(_to_float(group) for group in match.groups())
        except (TypeError, ValueError):
            continue
        if not _plausible(*values):
            continue
        before = text[max(0, match.start() - 20):match.start()]
        rank = 2 if _ENVELOPE_BEFORE_RE.search(before) else 1
        if best is None:
            best = (values[0], values[1], rank)
        if rank == 2:
            return (values[0], values[1], 2)
    return best


def _mine_bbox(text: str) -> tuple[tuple[float, float, float], str]:
    """Recover (bbox, source) from free text; never raises, degrades to DEFAULT_BBOX.

    Precedence mirrors how the corpus states envelopes: three explicit axes first,
    then a round envelope (Ø / diameter / "square" / hex across-flats / cube, ± height),
    then a plan pair with a height. A pair stated right after "габарит/envelope/в плане"
    outranks stray hole/pipe diameters mentioned elsewhere. Height kind decides the axis:
    "length/span" runs along X for linear members, "thickness/height" stays on Z.
    """
    triple = _TRIPLE_RE.search(text)
    if triple:
        try:
            values = tuple(_to_float(group) for group in triple.groups())
        except ValueError:
            values = None  # type: ignore[assignment]
        if values is not None and _plausible(*values):
            return values, "triple"  # type: ignore[return-value]
    omega_pair = _scan_pair(_OMEGA_PAIR_RE, text)
    if omega_pair is not None:
        diameter, height = omega_pair
        return (diameter, diameter, height), "omega-pair"
    height_z = _scan_height(_HEIGHT_Z_RE, text)
    height_len = _scan_height(_HEIGHT_LEN_RE, text)
    cube = _CUBE_RE.search(text)
    if cube:
        try:
            edge = _to_float(cube.group(1))
        except ValueError:
            edge = 0.0
        if _plausible(edge):
            return (edge, edge, edge), "cube"
    hex_af = _HEX_AF_RE.search(text)
    if hex_af:
        try:
            across_flats = _to_float(hex_af.group(1))
        except ValueError:
            across_flats = 0.0
        if _plausible(across_flats):
            across_corners = round(2.0 / 3.0 ** 0.5 * across_flats, 2)
            height = height_z if height_z is not None else height_len
            if height is None:
                height = round(_ROUND_Z_RATIO * across_flats, 1)
            return (across_corners, across_flats, height), "hex-across-flats"
    envelope_pair = _first_envelope_pair(text)
    diameter = _scan_diameter(text)
    if envelope_pair is not None and (diameter is None or envelope_pair[2] >= 2):
        a, b = envelope_pair[0], envelope_pair[1]
        if height_len is not None and height_len > max(a, b):
            return (height_len, a, b), "envelope-pair+length"
        if height_z is not None:
            return (a, b, height_z), "envelope-pair+height"
        return (a, b, DEFAULT_BBOX[2]), "envelope-pair"
    if diameter is not None:
        height = height_z if height_z is not None else height_len
        if height is None:
            return (diameter, diameter, round(_ROUND_Z_RATIO * diameter, 1)), "diameter+z-prior"
        return (diameter, diameter, height), "diameter+height"
    logger.warning("no dimensions found in prompt; fallback bbox used")
    return DEFAULT_BBOX, "default"


def _mine_class(text: str) -> str | None:
    for pattern, family in _CLASS_RES:
        if pattern.search(text):
            return family
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
        provenance="block",
    )


def extract_specs_from_text(text: str, *, canvas_hint: str | None = None) -> Specs:
    """Robust path for raw user prompts: parse a specs block, else mine the text.

    Falls back never crash: dimensions like ``80x50x6 мм`` or ``Ø96, толщиной 10 мм``
    wire the scale; ``canvas_hint`` (the layer the caller will actually run) pins the
    canvas — with it the topology and the class fallback stay consistent with the
    executed layer, exactly as training composed them. A canvas keyword in the text
    routes the layer only when no hint is given; anything missing degrades to the
    documented defaults plus a warning.
    """
    block = parse_specs_block(text)
    if block is not None:
        return block
    bbox, bbox_src = _mine_bbox(text)
    lowered = text.lower()
    class_src = "fallback"
    if canvas_hint in CANVASES:
        canvas = canvas_hint
    else:
        canvas = DEFAULT_CANVAS
        for keyword, target in _CANVAS_KEYWORDS.items():
            if keyword in lowered:
                canvas = target
                break
    object_class = _mine_class(lowered)
    if object_class is None:
        # Same fallback as trainer.build_sequence (metadata.get("origin", layer)):
        # in-vocabulary by construction, unlike a foreign label.
        object_class = canvas
    else:
        class_src = "keyword"
    if bbox_src == "default" and canvas == "wire":
        bbox = WIRE_DEFAULT_BBOX
        bbox_src = "wire-default"
        logger.warning("specs scale unknown; WIRE_DEFAULT_BBOX used (provenance=bbox:wire-default)")
    elif bbox_src == "default":
        logger.warning("specs scale unknown; DEFAULT_BBOX used (provenance=bbox:default)")
    return Specs(
        object_class=object_class,
        bbox=bbox,
        topology=_default_topology(canvas),
        canvas=canvas,
        provenance=f"class:{class_src} bbox:{bbox_src}",
    )


_CANVAS_KEYWORDS = {
    "ферм": "wire", "truss": "wire", "каркас": "wire", "frame": "wire",
    "балка": "wire", "beam": "wire", "рама": "wire",
    "шестерн": "sketch", "gear": "sketch", "профиль": "sketch", "profile": "sketch",
    "кулач": "sketch", "cam": "sketch", "рычаг": "sketch", "lever": "sketch",
    "сборк": "assembly", "assembly": "assembly",
    "фланец": "voxel", "flange": "voxel", "корпус": "voxel", "enclosure": "voxel",
    "пластина": "voxel", "plate": "voxel", "втулка": "voxel", "bushing": "voxel",
    # additions: shapes whose corpus families live on a non-default canvas
    "плит": "voxel", "крышк": "voxel", "хомут": "voxel", "короб": "voxel",
    "перфораци": "voxel", "червячн": "voxel", "проушин": "sketch",
    "ласточкин": "sketch", "вышк": "wire",
}


def build_prompt_with_specs(user_query: str, specs: Specs) -> str:
    """Compose the training/inference prompt body fed to the model."""
    return f"{user_query}\n{specs.render()}"
