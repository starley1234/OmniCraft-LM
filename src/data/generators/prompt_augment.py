"""Deterministic prompt-style augmentation for the CAD corpus.

The corpus stores a ``prompts`` dict per sample; most generator rows carry only
a formal English description while the held-out eval probes ``gen``/``dom``/
``free_ru``/``free_en``/``conv`` phrasings (conv prompts often omit dimensions
entirely -- scale must come from ``[SPECS]``). This module multiplies prompt
styles without touching geometry: each augmented row reuses the parent's code,
verification and metadata, so all schema invariants (``$fn = 32;`` header,
``code_sha256`` match, acceptance evidence) hold verbatim.

Determinism: per (seed, sample id, style) RNG, independent of input order.
"""

from __future__ import annotations

import copy
import random
from typing import Any, Iterable

AUGMENT_STYLES: tuple[str, ...] = ("formal_ru", "free_ru", "free_en", "conv_ru", "conv_en")

# Rows without a known generator kind (imports, paraphrases) already carry rich
# formal/domain prompts; for them the conversational/free styles are applied.
IMPORT_STYLES: tuple[str, ...] = ("free_ru", "free_en", "conv_ru", "conv_en")


# --------------------------------------------------------------------------- slots

def _fmt_mm(value: float) -> str:
    """Compact mm formatting: 71.0 -> '71', 65.14 -> '65.14'."""
    return f"{value:.2f}".rstrip("0").rstrip(".")


def _dims_xyz(bbox: Iterable[float]) -> dict[str, str]:
    x, y, z = (_fmt_mm(float(v)) for v in bbox)
    return {
        "dims": f"{x}x{y}x{z} мм",
        "dims_ru_na": f"{x} на {y} на {z} мм",
        "dims_ru_x": f"{x}×{y}×{z} мм",
        "dims_en": f"{x} by {y} by {z} mm",
        "dims_en_x": f"{x} x {y} x {z} mm",
        "dims_en_in": f"{x} x {y} x {z} mm overall",
        "x": x,
        "y": y,
        "z": z,
    }


def _slots(sample: dict[str, Any]) -> dict[str, str]:
    """Slot values available to templates for this sample."""
    slots = _dims_xyz(sample["verification"]["target_bbox"])
    params = sample.get("metadata", {}).get("generator_parameters") or {}
    for key, value in params.items():
        short = key[:-3] if key.endswith("_mm") else key
        try:
            slots[short] = _fmt_mm(float(value))
        except (TypeError, ValueError):
            continue
    slots.setdefault("wall", slots.get("z", "?"))
    return slots


# --------------------------------------------------------------------------- banks

KIND_BANK: dict[str, dict[str, list[str]]] = {
    "box": {
        "formal_ru": [
            "Создай открытый короб {dims} с толщиной стенок {wall} мм.",
            "Смоделируй открытый сверху ящик {dims_ru_x}, стенка {wall} мм.",
            "Изготовь открытый прямоугольный контейнер {dims}, толщина стенок — {wall} мм.",
            "Нужна открытая ёмкость {dims_ru_na}, стенки по {wall} мм.",
        ],
        "free_ru": [
            "Мне нужен открытый ящичек {dims_ru_na}, стенки миллиметров {wall}.",
            "Нужен контейнер без крышки {x} на {y}, высотой {z} мм, стенка {wall} мм.",
            "Сделай коробочку без верха {dims}, стенку не толще {wall} мм.",
            "Есть место под ёмкость {dims_ru_x} — нужен открытый короб, стенка {wall} мм.",
            "Заодно сделай ящик {dims_ru_na}, крышка не нужна, стенки {wall} мм.",
        ],
        "free_en": [
            "I need an open-top box {dims_en_x} with {wall} mm walls.",
            "Make me a little open container {dims_en}, wall {wall} mm.",
            "Model an open crate {dims_en_x}, walls {wall} mm.",
            "A lidless box, {dims_en}, {wall} mm walls would do.",
        ],
        "conv_ru": [
            "Нужна коробочка для мелочёвки, открытая сверху, габариты примерно {dims}.",
            "Хочу органайзер без крышки размером где-то {dims_ru_x}.",
            "Сделай пустотелый ящичек под монтажную плату, ну примерно {dims_ru_na}.",
            "Нужен какой-нибудь открытый контейнер, чтоб влезло в {dims_ru_x}.",
            "Подай идею: открытый ящик под детали, без крышки.",
        ],
        "conv_en": [
            "I need a small open-top tray for bits and pieces, roughly {dims_en_in}.",
            "Can you model a lidless box around {dims_en_x}?",
            "Need some kind of open bin for screws, nothing fancy, about {dims_en_x}.",
            "A simple open container, maybe {dims_en} — no lid needed.",
        ],
    },
    "enclosure": {
        "formal_ru": [
            "Создай корпус {dims} с толщиной стенок {wall} мм.",
            "Смоделируй корпус прибора {dims_ru_x}, стенка {wall} мм.",
            "Изготовь защитный корпус {dims}, стенки равномерно {wall} мм.",
            "Нужен корпус блока {dims_ru_na}, стенка {wall} мм.",
        ],
        "free_ru": [
            "Нужен корпус {dims_ru_na}, стенки тонкие, миллиметра {wall}.",
            "Сделай корпус под электронику {x}x{y}x{z} мм, стенка {wall} мм.",
            "Ищу корпус размером {dims_ru_x}, стенки {wall} мм хватит.",
            "Мне бы корпусок {dims}, стенку {wall} мм.",
        ],
        "free_en": [
            "I need an enclosure {dims_en_x} with {wall} mm walls.",
            "A housing for a small board, about {dims_en}, {wall} mm wall.",
            "Model a device case {dims_en_x}, walls {wall} mm.",
            "Need a print-ready enclosure, {dims_en}, {wall} mm thick walls.",
        ],
        "conv_ru": [
            "Собираю прибор — нужен корпус примерно {dims_ru_x}.",
            "Ищу коробок-корпус под плату, габариты в районе {dims}.",
            "Плата лежит на столе без защиты, нужен простой корпус, габариты около {dims_ru_x}.",
            "Нужен корпус под самоделку, чтобы выглядело прилично.",
        ],
        "conv_en": [
            "I'm building a little device and need a case around {dims_en_in}.",
            "Need a protective housing, somewhere near {dims_en_x}.",
            "My board needs a case — think something like {dims_en_x}.",
            "Looking for an enclosure for a hobby project, roughly {dims_en}.",
        ],
    },
    "flange": {
        "formal_ru": [
            "Создай круглый фланец внешним диаметром {outer_diameter} мм, толщиной {height} мм, с центральным отверстием {bore_diameter} мм.",
            "Смоделируй фланец Ø{outer_diameter} мм, толщина {height} мм, проход Ø{bore_diameter} мм, отверстия под болты на окружности Ø{bolt_circle} мм.",
            "Изготовь трубный фланец Ø{outer_diameter}x{height} мм с центральным проходом Ø{bore_diameter} мм.",
            "Нужен круглый фланец: наружный Ø{outer_diameter} мм, высота {height} мм, проход Ø{bore_diameter} мм, болтовая окружность Ø{bolt_circle} мм.",
        ],
        "free_ru": [
            "Нужен фланец: наружка Ø{outer_diameter} мм, толщина {height}, внутри отверстие Ø{bore_diameter} мм.",
            "Сделай круглый фланец диаметром {outer_diameter} на {height} мм толщиной, проход {bore_diameter} мм.",
            "Мне бы фланец под трубу {bore_diameter} мм, наружный диаметр {outer_diameter} мм, толщина {height} мм.",
            "Ищу фланец Ø{outer_diameter} мм, толщиной {height} мм, отверстие по центру Ø{bore_diameter} мм.",
        ],
        "free_en": [
            "I need a pipe flange, {outer_diameter} mm OD, {height} mm thick, {bore_diameter} mm bore.",
            "Round flange please: Ø{outer_diameter} mm, {height} mm thick, center bore Ø{bore_diameter} mm.",
            "Make a disc flange {outer_diameter} mm across, {height} mm thick, hole Ø{bore_diameter} mm in the middle.",
            "A plain flange, OD {outer_diameter} mm, thickness {height} mm, bore {bore_diameter} mm.",
        ],
        "conv_ru": [
            "Надо состыковать две трубы — нужен фланец где-то Ø{outer_diameter} мм.",
            "Труба диаметром {bore_diameter} идёт, нужен фланец к ней, наружный примерно Ø{outer_diameter} мм.",
            "Скручиваю патрубки болтами, нужен фланец, посадка Ø{bore_diameter} мм.",
            "Нужна просто круглая пластина с дыркой {bore_diameter} мм посередине, по кругу {outer_diameter} мм.",
        ],
        "conv_en": [
            "I have to join two pipes, a flange around {outer_diameter} mm across should work.",
            "Looking for a bolt-on flange for a {bore_diameter} mm pipe, roughly {outer_diameter} mm OD.",
            "Need something to cap a {bore_diameter} mm line — a {outer_diameter} mm flange maybe?",
            "Just a round plate with a {bore_diameter} mm hole in the middle, {outer_diameter} mm across.",
        ],
    },
    "adapter": {
        "formal_ru": [
            "Создай цилиндрическую втулку-переходник: внешний диаметр {outer_diameter} мм, сквозной проход Ø{bore_diameter} мм, длина {height} мм.",
            "Смоделируй втулку Ø{outer_diameter} мм длиной {height} мм со сквозным отверстием Ø{bore_diameter} мм.",
            "Изготовь распорную втулку: наружный Ø{outer_diameter} мм, проход Ø{bore_diameter} мм, длина {height} мм.",
            "Нужна цилиндрическая втулка {outer_diameter}x{height} мм со сквозным проходом Ø{bore_diameter} мм.",
        ],
        "free_ru": [
            "Нужна втулка: снаружи Ø{outer_diameter} мм, внутри проход Ø{bore_diameter} мм, длина {height} мм.",
            "Сделай круглую втулку диаметром {outer_diameter} мм, длиной {height} мм, со сквозным отверстием {bore_diameter} мм.",
            "Мне нужна распорка-цилиндр: Ø{outer_diameter} мм, длина {height} мм, дырка насквозь Ø{bore_diameter} мм.",
            "Сделай втулочку {height} мм длиной, наружный {outer_diameter} мм, отверстие {bore_diameter} мм.",
        ],
        "free_en": [
            "I need a cylindrical adapter sleeve: {outer_diameter} mm OD, {bore_diameter} mm through bore, {height} mm long.",
            "Round bushing please, Ø{outer_diameter} mm outside, Ø{bore_diameter} mm through hole, {height} mm long.",
            "A plain spacer sleeve, {outer_diameter} mm OD, {height} mm tall, {bore_diameter} mm bore.",
            "Make a through-hole bushing {outer_diameter} mm across, {height} mm long, {bore_diameter} mm hole.",
        ],
        "conv_ru": [
            "Нужна втулка-переходник под шток Ø{bore_diameter} мм, снаружи примерно Ø{outer_diameter} мм.",
            "Есть стержень {bore_diameter} мм — нужна втулка на него, внешний диаметр где-то {outer_diameter} мм.",
            "Надо заполнить зазор вокруг болта {bore_diameter} мм — втулка {height} мм высотой",
            "Нужна просто трубочка: дырка {bore_diameter} мм, стенка пожирнее, общий Ø{outer_diameter} мм.",
        ],
        "conv_en": [
            "I need a sleeve adapter for a {bore_diameter} mm shaft, around {outer_diameter} mm outside.",
            "Got a {bore_diameter} mm rod here — a bushing around {outer_diameter} mm OD would fit it.",
            "Need a simple spacer tube, {bore_diameter} mm hole, roughly {outer_diameter} mm OD.",
            "A chunky washer-spacer for an M-style bolt: {bore_diameter} mm through, {height} mm tall.",
        ],
    },
    "truss": {
        "formal_ru": [
            "Создай пространственную ферму {skeleton_length}x{skeleton_width}x{skeleton_height} мм, сечение стержней Ø{member_radius} мм.",
            "Смоделируй решётчатую ферму пролётом {skeleton_length} мм, сечение {skeleton_width}x{skeleton_height} мм.",
            "Изготовь сварную ферму {skeleton_length}x{skeleton_width}x{skeleton_height} мм из прутка Ø{member_radius} мм.",
            "Нужна пространственная решётчатая балка: пролёт {skeleton_length} мм, габарит сечения {skeleton_width}x{skeleton_height} мм.",
        ],
        "free_ru": [
            "Нужна ферма {skeleton_length} на {skeleton_width} на {skeleton_height} мм, стержни диаметром {member_radius} мм.",
            "Сделай сварную решётчатую раму длиной {skeleton_length} мм, {skeleton_width}x{skeleton_height} мм в сечении.",
            "Собери из прутков ферму длиной {skeleton_length} мм, поперечник {skeleton_width} на {skeleton_height} мм.",
            "Мне нужна решётчатая балка: длина {skeleton_length}, высота {skeleton_height}, ширина {skeleton_width} мм.",
        ],
        "free_en": [
            "I need a spatial truss {skeleton_length} by {skeleton_width} by {skeleton_height} mm, {member_radius} mm members.",
            "Lattice girder, span {skeleton_length} mm, cross-section {skeleton_width} x {skeleton_height} mm.",
            "Build a rod truss {skeleton_length} mm long, {skeleton_width} wide, {skeleton_height} tall.",
            "A warren-style truss, {skeleton_length} mm span, {member_radius} mm rods.",
        ],
        "conv_ru": [
            "Нужна несущая ферма под полку, пролёт примерно {skeleton_length} мм.",
            "Делаю стеллаж — нужна решётчатая балка длиной где-то {skeleton_length} мм.",
            "Прогибается столешница — хочу ферму-усиление на {skeleton_length} мм.",
            "Нужен лёгкий каркас из стержней, длина в районе {skeleton_length} мм.",
        ],
        "conv_en": [
            "I need a load-bearing truss for a shelf rack, span around {skeleton_length} mm.",
            "Building a frame and need a lattice beam roughly {skeleton_length} mm long.",
            "My shelf sags — a truss reinforcement about {skeleton_length} mm would help.",
            "Need a lightweight rod framework, maybe {skeleton_length} mm end to end.",
        ],
    },
}

# Layer- and kind-agnostic fallback banks (bbox-only slots).
GENERIC_BANK: dict[str, list[str]] = {
    "formal_ru": [
        "Создай деталь {dims}.",
        "Смоделируй деталь габаритами {dims_ru_x}.",
        "Изготовь деталь {dims_ru_na}.",
        "Нужна деталь с габаритами {dims}.",
    ],
    "free_ru": [
        "Нужна деталь {dims_ru_na}.",
        "Сделай деталь размером {dims}.",
        "Хочу деталь, габариты {dims_ru_x}.",
        "Мне нужна деталь {x} на {y} на {z} мм.",
        "Сделай такую штуку {dims_ru_na}.",
        "Нужна вот такая деталь: {dims}.",
    ],
    "free_en": [
        "I need a part {dims_en_x}.",
        "Make a part {dims_en}.",
        "A mechanical part, {dims_en_in}.",
        "Model a part that is {dims_en_x}.",
        "Please make something {dims_en} big.",
    ],
    "conv_ru": [
        "Нужна деталь, надо чтобы влезла в {dims_ru_x}.",
        "Подбери деталь: габариты не больше {dims}.",
        "Есть посадочное место {dims_ru_na} — нужна деталь под него.",
        "Нужна нехитрая деталь, примерно {dims_ru_x}.",
        "Сделай что-нибудь размером с {dims_ru_na}.",
    ],
    "conv_en": [
        "I need a part that fits inside {dims_en_x}.",
        "Need something machined, no bigger than {dims_en_in}.",
        "Make a part, roughly {dims_en} should be fine.",
        "Something about {dims_en_x} big would do.",
    ],
}

SKETCH_GENERIC: dict[str, list[str]] = {
    "formal_ru": [
        "Создай плоский профиль {dims}.",
        "Смоделируй контур для резки, габариты {dims_ru_x}.",
        "Нужна плоская профильная деталь {dims_ru_na}.",
    ],
    "free_ru": [
        "Нужен плоский профиль {dims_ru_na}.",
        "Сделай профильную деталь размером {dims}.",
        "Хочу контур под резку {dims_ru_x}.",
    ],
    "free_en": [
        "I need a flat profile {dims_en_x}.",
        "Cut-out profile, {dims_en_in}.",
        "Make a sheet-profile part {dims_en}.",
    ],
    "conv_ru": [
        "Нужен контур под резку из листа, габариты примерно {dims_ru_x}.",
        "Хочу вырезать плоскую деталь, размером где-то {dims}.",
    ],
    "conv_en": [
        "Need a profile to cut from sheet stock, roughly {dims_en_in}.",
        "I'm cutting a flat part, something like {dims_en_x}.",
    ],
}

WIRE_GENERIC: dict[str, list[str]] = {
    "formal_ru": [
        "Создай каркасную конструкцию {dims}.",
        "Смоделируй пространственный каркас {dims_ru_x}.",
        "Нужна решётчатая конструкция {dims_ru_na}.",
    ],
    "free_ru": [
        "Нужен каркас {dims_ru_na}.",
        "Сделай рамную конструкцию размером {dims}.",
        "Хочу пространственную ферму габаритами {dims_ru_x}.",
    ],
    "free_en": [
        "I need a wireframe structure {dims_en_x}.",
        "A skeleton frame, {dims_en_in}.",
        "Make a latticework structure around {dims_en}.",
    ],
    "conv_ru": [
        "Нужен несущий каркас, габариты примерно {dims_ru_x}.",
        "Делаю раму из прутков, размер где-то {dims}.",
    ],
    "conv_en": [
        "Need a skeletal frame, roughly {dims_en_in}.",
        "Building a light frame, around {dims_en_x} in size.",
    ],
}

LAYER_GENERIC: dict[str, dict[str, list[str]]] = {
    "sketch": SKETCH_GENERIC,
    "wire": WIRE_GENERIC,
}


# --------------------------------------------------------------------------- core

def _rng(seed: int, sample_id: str, style: str) -> random.Random:
    return random.Random(f"prompt_augment:{seed}:{sample_id}:{style}")


def _bank_for(sample: dict[str, Any], style: str, import_like: bool) -> list[str]:
    kind = str(sample.get("metadata", {}).get("kind") or "")
    layer = str(sample.get("layer") or "")
    if not import_like and kind in KIND_BANK:
        bank = KIND_BANK[kind]
    else:
        bank = LAYER_GENERIC.get(layer) or GENERIC_BANK
    return bank.get(style) or GENERIC_BANK[style]


def render_prompt(sample: dict[str, Any], style: str, seed: int, *, import_like: bool = False) -> str:
    """Render one deterministic prompt of the requested style for a sample."""
    rng = _rng(seed, str(sample["id"]), style)
    template = rng.choice(_bank_for(sample, style, import_like))
    return template.format(**_slots(sample))


def is_import_like(sample: dict[str, Any]) -> bool:
    """Samples with a known generator kind get rich per-kind banks; others generic."""
    return not sample.get("metadata", {}).get("kind")


def augment_sample(
    sample: dict[str, Any],
    seed: int,
    styles: Iterable[str] = AUGMENT_STYLES,
) -> list[dict[str, Any]]:
    """Emit augmented copies of a sample, one per style, ids ``{id}__{style}``.

    The parent sample itself is NOT re-emitted; append it separately when
    composing the corpus.
    """
    sample_id = str(sample["id"])
    import_like = is_import_like(sample)
    out = []
    for style in styles:
        if import_like and style not in IMPORT_STYLES:
            continue
        row = copy.deepcopy(sample)
        row["id"] = f"{sample_id}__{style}"
        row["prompts"] = {style: render_prompt(sample, style, seed, import_like=import_like)}
        meta = row.setdefault("metadata", {})
        meta["augmented_from"] = sample_id
        meta["prompt_style"] = style
        out.append(row)
    return out


def augment_corpus(
    rows: Iterable[dict[str, Any]],
    seed: int,
    styles: Iterable[str] = AUGMENT_STYLES,
    keep_original: bool = True,
) -> Iterable[dict[str, Any]]:
    """Stream original + augmented rows (memory-safe for large corpora)."""
    for row in rows:
        if keep_original:
            yield row
        yield from augment_sample(row, seed, styles)
