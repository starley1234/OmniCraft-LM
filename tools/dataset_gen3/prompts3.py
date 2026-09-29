"""Prompt composition for the gen3 corpus.

Same contract as the request: every prompt carries the overall size in mm in
both languages, plus the language strengthening asked for in the second
request:

* ~25 % of the prompts add a tolerance / fit / function sentence
  (`зазор 0.15 под свободную посадку`, `переходная посадка H7/g6`,
  `под печать PETG`),
* ~15 % mention the imperial size of a real feature next to its mm value
  (`посадка под вал 1/2 дюйма, то есть 12.7 мм`) - the geometry itself is
  always in mm, the inch value is only quoted,
* the rest as in the first request.
"""

from __future__ import annotations

from tools.dataset_gen2.common import Part, Rng
from tools.dataset_gen2.prompts import _tidy, build_prompt
from tools.dataset_gen2.common import fmt

# inch fractions that are common on shafts, bores and flats
INCH_TABLE: tuple[tuple[float, str], ...] = (
    (3.175, "1/8"),
    (4.7625, "3/16"),
    (6.35, "1/4"),
    (7.9375, "5/16"),
    (9.525, "3/8"),
    (12.7, "1/2"),
    (15.875, "5/8"),
    (19.05, "3/4"),
    (22.225, "7/8"),
    (25.4, "1"),
    (31.75, "1 1/4"),
    (38.1, "1 1/2"),
)


def inch_size(rng: Rng, max_mm: float | None = None, min_mm: float | None = None) -> tuple[float, str]:
    """A feature size that is exactly an imperial fraction, and its label."""
    table = [
        entry
        for entry in INCH_TABLE
        if (max_mm is None or entry[0] <= max_mm) and (min_mm is None or entry[0] >= min_mm)
    ]
    return rng.choice(table or INCH_TABLE)


TOLERANCE_RU = (
    "Посадка свободная: зазор 0.15 мм по сопряжению.",
    "Переходная посадка H7/g6 на посадочном пояске.",
    "Ходовая часть с зазором 0.2 мм, чтобы ходило без закусывания.",
    "Посадочные отверстия +0.15 мм, остальное свободно.",
    "Допуск на диаметры +0.05/-0, остальное по 0.3 мм.",
    "Зазор 0.25 мм в подвижном соединении.",
    "Натяг не нужен, сделай скользящую посадку 0.1 мм.",
    "Ключевой размер ±0.1 мм, допуск по чертежу.",
)
TOLERANCE_EN = (
    "Slip fit: 0.15 mm clearance in the mating features.",
    "H7/g6 transition fit on the locating spigot.",
    "Moving parts get a 0.2 mm gap so nothing binds.",
    "Mounting holes +0.15 mm, everything else loose.",
    "Diameter tolerance +0.05/-0, 0.3 mm everywhere else.",
    "0.25 mm clearance in the sliding joint.",
    "No press fit needed, make it a 0.1 mm sliding fit.",
    "Key dimension +/- 0.1 mm, per the drawing.",
)
FUNCTION_RU = (
    "Деталь под печать PETG на FDM.",
    "Печатать буду PETG, 0.2 мм слоем.",
    "Работает под нагрузкой, стенки держать не тоньше 2 мм.",
    "Установка на улице, нужен запас на УФ и влагу.",
    "Печать без поддержек, уклоны держать до 45 градусов.",
    "Деталь ремонтная, размеры подгоню по месту.",
)
FUNCTION_EN = (
    "Part is for PETG on an FDM printer.",
    "Printing in PETG with 0.2 mm layers.",
    "It carries load, keep the walls at least 2 mm.",
    "Outdoor installation, leave margin for UV and moisture.",
    "Print without supports, keep the overhangs under 45 degrees.",
    "It is a repair part, I will fit it on site.",
)
UNITS_RU = (
    "Посадочный размер {inch} дюйма, то есть {mm} мм.",
    "Сопрягается с имперской деталью {inch} дюйма ({mm} мм).",
    "Ключевой размер {inch} дюйма, в миллиметрах это {mm} мм.",
    "Ставлю имперский крепёж {inch} дюйма = {mm} мм.",
    "Размер по чертежу в дюймах: {inch}, у меня {mm} мм.",
)
UNITS_EN = (
    "The mating size is {inch} inch, that is {mm} mm.",
    "It couples with an imperial part of {inch} inch ({mm} mm).",
    "Key dimension {inch} inch, which is {mm} mm on my caliper.",
    "Imperial hardware goes here: {inch} inch = {mm} mm.",
    "The drawing is in inches: {inch}, so {mm} mm for me.",
)


def tail3(
    rng: Rng,
    units: tuple[float, str] | None = None,
    tolerance_p: float = 0.25,
    units_p: float = 0.3,
) -> tuple[str, str, list[str]]:
    """Return (ru tail, en tail, flags) with the gen3 probabilities."""
    ru: list[str] = []
    en: list[str] = []
    flags: list[str] = []
    if units is not None and rng.chance(units_p):
        mm, inch = units
        ru.append(rng.choice(UNITS_RU).format(inch=inch, mm=fmt(mm, 3).rstrip("0").rstrip(".")))
        en.append(rng.choice(UNITS_EN).format(inch=inch, mm=fmt(mm, 3).rstrip("0").rstrip(".")))
        flags.append("units")
    if rng.chance(tolerance_p):
        index = rng.integer(0, len(TOLERANCE_RU) - 1)
        ru.append(TOLERANCE_RU[index])
        en.append(TOLERANCE_EN[index])
        flags.append("tolerance")
    elif rng.chance(0.4):
        index = rng.integer(0, len(FUNCTION_RU) - 1)
        ru.append(FUNCTION_RU[index])
        en.append(FUNCTION_EN[index])
        flags.append("function")
    return " ".join(ru), " ".join(en), flags


def finish_part3(
    rng: Rng,
    *,
    family: str,
    variant: str,
    code: str,
    bbox: tuple[float, float, float],
    params: dict[str, float],
    ru_nouns: tuple[str, ...],
    en_nouns: tuple[str, ...],
    features_ru: list[str],
    features_en: list[str],
    units: tuple[float, str] | None = None,
    feature_count: tuple[int, int] = (2, 3),
) -> Part:
    """Compose the prompts (gen2 body + gen3 tail) and build the Part."""
    prompt_ru, prompt_en = build_prompt(
        rng,
        ru_nouns=ru_nouns,
        en_nouns=en_nouns,
        bbox=bbox,
        ru_feature_sentences=[sentence[0].upper() + sentence[1:] + "." for sentence in features_ru],
        en_feature_sentences=[sentence[0].upper() + sentence[1:] + "." for sentence in features_en],
        feature_count=rng.integer(feature_count[0], feature_count[1]),
        extra_tail=False,
    )
    ru_tail, en_tail, _ = tail3(rng, units)
    return Part(
        family=family,
        variant=variant,
        code=code,
        bbox=bbox,
        params=params,
        prompt_ru=_tidy(prompt_ru + " " + ru_tail),
        prompt_en=_tidy(prompt_en + " " + en_tail),
    )
