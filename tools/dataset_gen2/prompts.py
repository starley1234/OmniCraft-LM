"""Prompt composition for the gen2 corpus.

The request is explicit: prompts must read like a workshop request, never like a
filled-in template, they must always carry the part dimensions, and roughly one
sample in five mentions a printing/machining tolerance.  The banks below are
deliberately large and are combined with per-family nouns, features and closing
phrases so that every generated sentence is unique.
"""

from __future__ import annotations

import re
from typing import Sequence

from tools.dataset_gen2.common import Rng, fmt

# ---------------------------------------------------------------------------
# dimension phrases
# ---------------------------------------------------------------------------

_RU_DIM_FORMS = (
    "{a}x{b}x{c} мм",
    "{a} на {b} на {c} мм",
    "{a}x{b}x{c}",
    "{a}x{b} мм, высота {c}",
    "габарит {a}x{b}x{c} мм",
)
_RU_DIM_PREFIX = ("", "размеры ", "габариты ", "в плане ", "общие габариты ")
_EN_DIM_FORMS = (
    "{a} x {b} x {c} mm",
    "{a} by {b} by {c} mm",
    "{a}x{b} mm footprint, {c} mm tall",
    "overall {a}x{b}x{c} mm",
)
_EN_DIM_PREFIX = ("", "size ", "overall ", "dimensions ")


def _num(value: float) -> str:
    return fmt(value, 1 if abs(value - round(value)) > 1e-9 else 0)


def dim_phrase_ru(rng: Rng, bbox: Sequence[float]) -> str:
    form = rng.choice(_RU_DIM_FORMS)
    text = form.format(a=_num(bbox[0]), b=_num(bbox[1]), c=_num(bbox[2]))
    prefix = rng.choice(_RU_DIM_PREFIX)
    if prefix and form.startswith("габарит"):
        prefix = ""
    return prefix + text


def dim_phrase_en(rng: Rng, bbox: Sequence[float]) -> str:
    form = rng.choice(_EN_DIM_FORMS)
    text = form.format(a=_num(bbox[0]), b=_num(bbox[1]), c=_num(bbox[2]))
    prefix = rng.choice(_EN_DIM_PREFIX)
    if prefix and form.startswith("overall"):
        prefix = ""
    return prefix + text


def ru_count(count: int, one: str, few: str, many: str) -> str:
    """Russian plural form: 1 отверстие, 2 отверстия, 5 отверстий."""
    stripped = count % 100
    if 11 <= stripped <= 14:
        return f"{count} {many}"
    last = count % 10
    if last == 1:
        return f"{count} {one}"
    if 2 <= last <= 4:
        return f"{count} {few}"
    return f"{count} {many}"


_EN_WORDS = {
    1: "one", 2: "two", 3: "three", 4: "four", 5: "five", 6: "six",
    7: "seven", 8: "eight", 9: "nine", 10: "ten", 12: "twelve",
}


def en_count(count: int) -> str:
    return _EN_WORDS.get(count, str(count))


# ---------------------------------------------------------------------------
# openers, connectives, closing phrases
# ---------------------------------------------------------------------------

RU_OPENERS = (
    "Сделай", "Нужна деталь:", "Спроектируй", "Хочу напечатать", "Надо сделать",
    "Требуется", "Помоги сделать", "Собери модель:", "Сделай мне", "Нужно изготовить",
    "Нарисуй", "Задача:", "Есть запрос:", "Подскажи конструкцию:", "Изготовь",
)
RU_OPENERS_INLINE = (
    "нужен", "требуется", "хочу", "надо", "планирую", "собираюсь сделать",
    "хотелось бы", "по расчёту вышел", "нужно получить",
)
RU_TAILS = (
    "Печатать буду на PETG, 0.2 мм слоем.",
    "Печать FDM, сопло 0.6.",
    "Стенки не тоньше 2 мм, деталь должна держать нагрузку.",
    "Кромки притупить, без острых углов.",
    "Сделай аккуратно, без лишних свесов при печати.",
    "Материал — PA6-CF, но это не критично для модели.",
    "Это прототип, точность не хуже 0.3 мм.",
    "Фрезеровать потом не буду, всё сразу печатью.",
    "Подойдёт для SLS, но модель хочу параметрическую.",
    "Параметры вынеси переменными, чтобы крутить размеры.",
    "Нужна деталь под повторяемую печать, чтобы не пересчитывать вручную.",
    "Сделай параметрически, потом подгоню под свою геометрию.",
)
RU_TAILS_TOLERANCE = (
    "Посадки под печать: добавь 0.2 мм к наружным размерам.",
    "Отверстия сделай с запасом 0.15 на печать.",
    "Ключевой размер с допуском +0.2/-0, остальное свободно.",
    "Сопряжения оставь с зазором 0.25 мм.",
    "Под вал нужен зазор 0.15, буду разворачивать.",
    "Точность посадочных мест ±0.1 мм, остальное по 0.3.",
    "Учти усадку: плюс 0.3% по габаритам.",
    "Свободные отверстия +0.2, чтобы потом не сверлить.",
    "Дай зазор 0.2 по сопряжению, втулка должна крутиться.",
    "Допуск на диаметр +0.1, минус не нужен.",
)
EN_TAILS = (
    "Printing on PETG, 0.2 mm layers.",
    "FDM print, 0.6 mm nozzle.",
    "Walls at least 2 mm, it has to carry load.",
    "Break the sharp edges.",
    "Keep it printable without supports if you can.",
    "Prototype tolerance 0.3 mm is fine.",
    "It will be machined later, but model it as printed for now.",
    "Expose the sizes as variables so I can tweak them.",
    "Keep it parametric, I will adapt it to my setup.",
    "PA6-CF eventually, but the model does not depend on material.",
)
EN_TAILS_TOLERANCE = (
    "Add 0.2 mm print clearance to the outer sizes.",
    "Holes with 0.15 mm printing allowance.",
    "Key dimension at +0.2/-0, the rest loose.",
    "Leave a 0.25 mm gap in the mating features.",
    "0.15 mm clearance on the shaft fit.",
    "Fits to ±0.1 mm, everything else 0.3 mm.",
    "Take shrink into account: 0.3% on the overall size.",
    "Free holes +0.2 so I do not have to re-drill.",
)

RU_REFERENCE_TAILS = (
    "Ориентир — ГОСТовская крепёжка.",
    "Крепёж обычный DIN 912.",
    "Винты под шестигранник, 4.6 класс.",
    "Деталь из мастерской, без экзотики.",
    "Делаю под свой станочек, размеры примерные.",
    "Размеры взял с чертежа, они важны.",
    "Место под гайку должно остаться доступным.",
)


def tail(rng: Rng) -> tuple[str, str, bool]:
    """Return (ru tail, en tail, tolerance mentioned)."""
    if rng.chance(0.21):
        return rng.choice(RU_TAILS_TOLERANCE), rng.choice(EN_TAILS_TOLERANCE), True
    ru = rng.choice(RU_TAILS)
    if rng.chance(0.25):
        ru = ru + " " + rng.choice(RU_REFERENCE_TAILS)
    return ru, rng.choice(EN_TAILS), False


# ---------------------------------------------------------------------------
# sentence assembly
# ---------------------------------------------------------------------------


def _capitalize(text: str) -> str:
    text = text.strip()
    if not text:
        return text
    return text[0].upper() + text[1:]


def _tidy(text: str) -> str:
    text = re.sub(r"\s+", " ", text).strip()
    text = text.replace(" ,", ",").replace(" .", ".")
    if text and text[-1] not in ".!?":
        text += "."
    return text


def build_prompt(
    rng: Rng,
    *,
    ru_nouns: Sequence[str],
    en_nouns: Sequence[str],
    bbox: Sequence[float],
    ru_feature_sentences: Sequence[str],
    en_feature_sentences: Sequence[str],
    ru_lead: str | None = None,
    en_lead: str | None = None,
    feature_count: int = 2,
    extra_tail: bool = True,
) -> tuple[str, str]:
    """Compose one RU/EN prompt pair that always contains the dimensions."""
    ru_noun = rng.choice(ru_nouns)
    en_noun = rng.choice(en_nouns)
    ru_features = rng.shuffled(ru_feature_sentences)[: max(1, feature_count)]
    en_features = rng.shuffled(en_feature_sentences)[: max(1, feature_count)]

    ru_dims = dim_phrase_ru(rng, bbox)
    en_dims = dim_phrase_en(rng, bbox)
    ru_tail, en_tail, _ = tail(rng) if extra_tail else ("", "", False)

    plan = rng.integer(0, 4)
    if ru_lead:
        ru_parts = [ru_lead]
        if plan % 2 == 0:
            ru_parts.append(f"{ru_noun}, {ru_dims}.")
        else:
            ru_parts.append(f"{ru_noun}. {_capitalize(ru_dims)}.")
    elif plan == 0:
        ru_parts = [f"{rng.choice(RU_OPENERS)} {ru_noun}, {ru_dims}."]
    elif plan == 1:
        ru_parts = [f"{rng.choice(RU_OPENERS_INLINE).capitalize()} {ru_noun} {ru_dims}."]
    elif plan == 2:
        ru_parts = [f"{_capitalize(ru_dims)} — {ru_noun}."]
    elif plan == 3:
        ru_parts = [f"{rng.choice(RU_OPENERS)} {ru_noun}. {_capitalize(ru_dims)}."]
    else:
        ru_parts = [f"{ru_noun} {ru_dims}."]
    ru_parts.extend(feature[0].upper() + feature[1:] for feature in ru_features)
    if ru_tail:
        ru_parts.append(ru_tail)

    if en_lead:
        en_parts = [en_lead]
        en_parts.append(f"{en_noun}, {en_dims}.")
    elif plan == 2:
        en_parts = [f"{_capitalize(en_dims)} — {en_noun}."]
    else:
        en_parts = [f"I need {en_noun}, {en_dims}."]
    en_parts.extend(feature[0].upper() + feature[1:] for feature in en_features)
    if en_tail:
        en_parts.append(en_tail)

    return _tidy(" ".join(ru_parts)), _tidy(" ".join(en_parts))
