"""Prompt composition for the ``place1`` corpus.

Every sentence that describes *where* a feature sits is produced here, and each
one carries exactly the numbers the code carries: the feature count, the feature
size, the pitch / bolt-circle diameter / edge offset and the pocket depth.  The
closing sentences are deliberately numeric-free (`0.2 mm layers` style process
numbers would break the "every prompt number is in the code" law), with one
exception: the printing-allowance sentence, which quotes the nominal size *and*
the allowance — both of which the code declares and uses.

The prompt banks are separate from the gen2/gen3 banks so a memorised template
cannot carry over.
"""

from __future__ import annotations

import re
from typing import Sequence

from tools.dataset_gen2.common import Rng, fmt

# ---------------------------------------------------------------------------
# numbers and counts
# ---------------------------------------------------------------------------

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
)


def pnum(value: float, digits: int = 2) -> str:
    """A number as it is written in a prompt (up to ``digits`` decimals)."""
    return fmt(float(value), digits)


def inch_for(value: float, tolerance: float = 0.02) -> str | None:
    for millimetres, label in INCH_TABLE:
        if abs(value - millimetres) <= tolerance:
            return label
    return None


def inch_note_ru(label: str) -> str:
    return f" (это {label} дюйма)"


def inch_note_en(label: str) -> str:
    return f" ({label} in)"


def ru_count(count: int, one: str, few: str, many: str) -> str:
    tail = count % 100
    if 11 <= tail <= 14:
        return f"{count} {many}"
    last = count % 10
    if last == 1:
        return f"{count} {one}"
    if 2 <= last <= 4:
        return f"{count} {few}"
    return f"{count} {many}"


def en_count(count: int) -> str:
    return str(count)


# ---------------------------------------------------------------------------
# prompt skeleton
# ---------------------------------------------------------------------------

RU_OPENERS = (
    "Сделай, пожалуйста,",
    "Спроектируй",
    "Смоделируй",
    "Нарисуй модель",
    "Хочу напечатать",
    "Нужно изготовить",
    "Требуется изготовить",
    "Помоги сделать",
    "Прошу смоделировать",
    "Задача — изготовить",
    "Давай сделаем",
    "Подготовь модель",
)

EN_OPENERS = (
    "Please model a",
    "I need a",
    "Make me a",
    "Could you model a",
    "Design a",
    "Model a",
    "We need a",
    "Please draw up a",
    "Task: model a",
    "Please design a",
    "I want to print a",
    "Put together a",
)

RU_DIM_FORMS = (
    "габаритом {a} x {b} x {c} мм",
    "размером {a} x {b} x {c} мм",
    "{a} x {b} x {c} мм",
    "габаритом {a} x {b} x {c} мм",
    "размером {a} x {b} x {c} мм",
    "с габаритами {a} x {b} x {c} мм",
)
EN_DIM_FORMS = (
    "overall {a} x {b} x {c} mm",
    "size {a} x {b} x {c} mm",
    "{a} x {b} x {c} mm",
    "envelope {a} x {b} x {c} mm",
)

RU_TAILS = (
    "Параметры вынеси переменными, чтобы можно было крутить размеры.",
    "Печатать буду на PETG.",
    "Деталь под повторяемую печать, хочу править только числа.",
    "Стенки держи потолще, деталь нагруженная.",
    "Кромки притупить, без острых углов.",
    "Сделай аккуратно, без лишних свесов.",
    "Это прототип, точность не критична.",
    "Материал — PA6-CF, но модели это не касается.",
    "Точность посадочных мест важна, остальное свободно.",
    "Делаю под свой станочек, размеры примерные.",
    "Ориентир — ГОСТовская крепёжка.",
    "Размеры взял с чертежа, они важны.",
    "Нужно, чтобы в сборе встало без доработки.",
    "Лучше параметрически, потом подгоню под свою геометрию.",
    "Раскладку не меняй, она уже согласована.",
)
EN_TAILS = (
    "Expose the sizes as variables so I can tweak them.",
    "Printing on PETG.",
    "It will be printed repeatedly, I only want to edit numbers.",
    "Keep the walls generous, the part carries load.",
    "Break the sharp edges.",
    "Keep it printable without supports.",
    "It is a prototype, tolerance is not critical.",
    "Material is PA6-CF, the model does not depend on it.",
    "The location of the features matters, the rest is loose.",
    "Copy the sizes from the drawing, they matter.",
    "It has to drop into an existing assembly.",
    "Keep it parametric, I will adapt it to my setup.",
    "Do not move the layout, it is already agreed.",
    "Hand tools only afterwards, everything straight off the printer.",
)

RU_TOL_TAILS = (
    "Допуски — по чертежу, свободные размеры не критичны.",
    "Посадки оставь свободными, деталь декоративная.",
    "Сопрягаемые места подгоню по месту.",
    "Симметрию не нарушай, деталь двусторонняя.",
    "Отверстия под крепёж можно чуть свободнее.",
    "Точность по осям важнее, чем по глубине.",
)
EN_TOL_TAILS = (
    "Tolerances to the drawing, the loose sizes are not critical.",
    "Leave the fits free, the part is cosmetic.",
    "I will fit the mating faces on the bench.",
    "Keep it symmetric, the part works both ways.",
    "The fastener holes may run a little free.",
    "Accuracy across the axes matters more than the depth.",
)

_UNIT_WORDS = re.compile(r"\d")


def _capitalize(text: str) -> str:
    return text[0].upper() + text[1:] if text and text[0].islower() else text


def _join_sentences(items: Sequence[str]) -> str:
    """Feature phrases become whole sentences: stripped of stray punctuation, closed."""
    sentences = []
    for item in items:
        text = " ".join(item.split()).strip()
        if not text:
            continue
        sentences.append(_capitalize(text.rstrip(".;, ") + "."))
    return " ".join(sentences)


def _tidy(text: str) -> str:
    text = re.sub(r"\s+", " ", text).strip()
    text = text.replace(" ,", ",").replace(" .", ".")
    if text and text[-1] not in ".!?":
        text += "."
    return text


def build_prompt4(
    rng: Rng,
    *,
    ru_noun: str,
    en_noun: str,
    bbox: Sequence[float],
    ru_features: Sequence[str],
    en_features: Sequence[str],
    tolerance: bool = False,
    tol_pair: tuple[float, float] | None = None,
) -> tuple[str, str]:
    """Compose the RU/EN pair: dimensions, feature sentences, closing sentence."""
    dims_ru = rng.choice(RU_DIM_FORMS).format(
        a=pnum(bbox[0], 1), b=pnum(bbox[1], 1), c=pnum(bbox[2], 1)
    )
    dims_en = rng.choice(EN_DIM_FORMS).format(
        a=pnum(bbox[0], 1), b=pnum(bbox[1], 1), c=pnum(bbox[2], 1)
    )
    ru_opener = rng.choice(RU_OPENERS)
    en_opener = rng.choice(EN_OPENERS)
    if en_opener.endswith(" a") and en_noun[:1].lower() in "aeiou":
        en_opener = en_opener[:-1] + "an"
    ru = f"{ru_opener} {ru_noun} {dims_ru}. {_join_sentences(ru_features)}"
    en = f"{en_opener} {en_noun} {dims_en}. {_join_sentences(en_features)}"
    if tol_pair is not None:
        seat, free = tol_pair
        ru = f"{ru} Точность посадочных мест ±{pnum(seat)} мм, остальное по {pnum(free)}."
        en = f"{en} Fits to ±{pnum(seat)} mm, everything else {pnum(free)} mm."
        ru = f"{ru} {rng.choice(RU_TAILS)}"
        en = f"{en} {rng.choice(EN_TAILS)}"
    elif tolerance:
        ru = f"{ru} {rng.choice(RU_TOL_TAILS)}"
        en = f"{en} {rng.choice(EN_TOL_TAILS)}"
    else:
        ru = f"{ru} {rng.choice(RU_TAILS)}"
        en = f"{en} {rng.choice(EN_TAILS)}"
    return _tidy(ru), _tidy(en)


def allowance_sentence_ru(hole_d: float, nominal: float, allowance: float, noun: str = "Отверстия") -> str:
    return (
        f"{noun} ø{pnum(hole_d)} — это номинал {pnum(nominal)} мм плюс припуск "
        f"{pnum(allowance)} мм на печать."
    )


def allowance_sentence_en(hole_d: float, nominal: float, allowance: float, noun: str = "The holes") -> str:
    return (
        f"{noun} at Ø{pnum(hole_d)} mm are the {pnum(nominal)} mm nominal plus a "
        f"{pnum(allowance)} mm printing allowance."
    )


# ---------------------------------------------------------------------------
# placement phrasing, rule by rule
# ---------------------------------------------------------------------------

def corners_ru(rng: Rng, holes: int, hole_d: float, edge: float, inch: str | None = None) -> str:
    note = inch_note_ru(inch) if inch else ""
    options = (
        f"{ru_count(holes, 'отверстие', 'отверстия', 'отверстий')} ø{pnum(hole_d)} по углам, "
        f"отступ {pnum(edge)} мм от кромки{note}.",
        f"по углам {ru_count(holes, 'отверстие', 'отверстия', 'отверстий')} ø{pnum(hole_d)}, "
        f"{pnum(edge)} мм от кромки{note}.",
        f"{ru_count(holes, 'отверстие', 'отверстия', 'отверстий')} ø{pnum(hole_d)} в углах с "
        f"отступом {pnum(edge)} мм от края{note}.",
    )
    return rng.choice(options)


def corners_en(rng: Rng, holes: int, hole_d: float, edge: float, inch: str | None = None) -> str:
    note = inch_note_en(inch) if inch else ""
    options = (
        f"{en_count(holes)} holes at Ø{pnum(hole_d)} mm in the corners, "
        f"{pnum(edge)} mm in from the edge{note}.",
        f"corner holes Ø{pnum(hole_d)} mm, {en_count(holes)} of them, "
        f"{pnum(edge)} mm from the edge{note}.",
        f"{en_count(holes)} corner holes at Ø{pnum(hole_d)} mm with a {pnum(edge)} mm "
        f"edge offset{note}.",
    )
    return rng.choice(options)


def bolt_circle_ru(rng: Rng, holes: int, hole_d: float, pcd: float, start: float) -> str:
    options = (
        f"{ru_count(holes, 'отверстие', 'отверстия', 'отверстий')} ø{pnum(hole_d)} на окружности "
        f"ø{pnum(pcd)} мм, первое под углом {pnum(start, 1)}° к оси X.",
        f"{ru_count(holes, 'отверстие', 'отверстия', 'отверстий')} ø{pnum(hole_d)} по делительной "
        f"окружности ø{pnum(pcd)} мм, стартовый угол {pnum(start, 1)}°.",
        f"болтовая окружность ø{pnum(pcd)} мм: {ru_count(holes, 'отверстие', 'отверстия', 'отверстий')} "
        f"ø{pnum(hole_d)}, первое смещено на {pnum(start, 1)}° от оси X.",
    )
    return rng.choice(options)


def bolt_circle_en(rng: Rng, holes: int, hole_d: float, pcd: float, start: float) -> str:
    options = (
        f"{en_count(holes)} holes at Ø{pnum(hole_d)} mm on a {pnum(pcd)} mm bolt circle, "
        f"the first one {pnum(start, 1)} degrees off the X axis.",
        f"a {pnum(pcd)} mm bolt circle with {en_count(holes)} holes Ø{pnum(hole_d)} mm, "
        f"start angle {pnum(start, 1)} degrees.",
        f"{en_count(holes)} Ø{pnum(hole_d)} mm holes on a {pnum(pcd)} mm pitch circle, "
        f"first hole {pnum(start, 1)} degrees from X.",
    )
    return rng.choice(options)


def field_ru(rng: Rng, rows: int, cols: int, hole_d: float, px: float, py: float) -> str:
    pitch = f"{pnum(px)} x {pnum(py)} мм" if abs(px - py) > 1e-9 else f"{pnum(px)} мм"
    options = (
        f"поле {rows} x {cols} отверстий ø{pnum(hole_d)} с шагом {pitch}.",
        f"{rows} рядов по {cols} отверстий ø{pnum(hole_d)}, шаг {pitch}.",
        f"сетка {rows} x {cols} отверстий ø{pnum(hole_d)}, шаг {pitch}.",
    )
    return rng.choice(options)


def field_en(rng: Rng, rows: int, cols: int, hole_d: float, px: float, py: float) -> str:
    pitch = f"{pnum(px)} x {pnum(py)} mm" if abs(px - py) > 1e-9 else f"{pnum(px)} mm"
    options = (
        f"a {rows} x {cols} field of Ø{pnum(hole_d)} mm holes at {pitch} pitch.",
        f"{rows} rows of {cols} holes at Ø{pnum(hole_d)} mm, {pitch} pitch.",
        f"a {rows} x {cols} hole grid, Ø{pnum(hole_d)} mm, {pitch} pitch.",
    )
    return rng.choice(options)


def staggered_ru(rng: Rng, rows: int, cols: int, hole_d: float, px: float, py: float, offset: float) -> str:
    options = (
        f"отверстия ø{pnum(hole_d)} в шахматном порядке: поле {rows} x {cols}, шаг "
        f"{pnum(px)} x {pnum(py)} мм, смещение {pnum(offset)} мм через ряд.",
        f"шахматная перфорация ø{pnum(hole_d)}: {rows} x {cols}, шаг {pnum(px)} x {pnum(py)} мм, "
        f"ряды смещены на {pnum(offset)} мм.",
        f"поле {rows} x {cols} ø{pnum(hole_d)} со смещением рядов на {pnum(offset)} мм, "
        f"шаг {pnum(px)} x {pnum(py)} мм.",
    )
    return rng.choice(options)


def staggered_en(rng: Rng, rows: int, cols: int, hole_d: float, px: float, py: float, offset: float) -> str:
    options = (
        f"a staggered {rows} x {cols} field of Ø{pnum(hole_d)} mm holes, {pnum(px)} x {pnum(py)} mm "
        f"pitch, every other row shifted by {pnum(offset)} mm.",
        f"{rows} x {cols} Ø{pnum(hole_d)} mm holes on a {pnum(px)} x {pnum(py)} mm pitch, "
        f"alternate rows offset {pnum(offset)} mm.",
        f"checkerboard perforation: {rows} x {cols} holes Ø{pnum(hole_d)} mm, pitch "
        f"{pnum(px)} x {pnum(py)} mm, row offset {pnum(offset)} mm.",
    )
    return rng.choice(options)


def ribs_ru(rng: Rng, count: int, thickness: float, pitch: float, staggered: bool, offset: float, height: float) -> str:
    base = (
        f"{ru_count(count, 'ребро', 'ребра', 'рёбер')} толщиной {pnum(thickness)} мм "
        f"высотой {pnum(height)} мм с шагом {pnum(pitch)} мм"
    )
    if staggered:
        options = (
            f"{base}; соседние рёбра стоят на противоположных сторонах, ряды разнесены "
            f"на {pnum(offset)} мм.",
            f"{base}, в шахматном порядке: рёбра через одно на своей стороне, между рядами "
            f"{pnum(offset)} мм.",
        )
    else:
        options = (f"{base} в один ряд.", base + ".")
    return rng.choice(options)


def ribs_en(rng: Rng, count: int, thickness: float, pitch: float, staggered: bool, offset: float, height: float) -> str:
    base = (
        f"{count} ribs {pnum(thickness)} mm thick and {pnum(height)} mm tall at {pnum(pitch)} mm pitch"
    )
    if staggered:
        options = (
            f"{base}; neighbouring ribs sit on opposite sides, the two rows are {pnum(offset)} mm apart.",
            f"{base}, staggered from side to side, {pnum(offset)} mm between the rows.",
        )
    else:
        options = (f"{base} in a single row.", base + ".")
    return rng.choice(options)


def row_ru(rng: Rng, count: int, hole_d: float, pitch: float, start: float | None) -> str:
    edge = f" Первое отверстие в {pnum(start)} мм от края." if start is not None else ""
    options = (
        f"{ru_count(count, 'отверстие', 'отверстия', 'отверстий')} ø{pnum(hole_d)} в ряд по центру детали, "
        f"шаг {pnum(pitch)} мм.{edge}",
        f"ряд из {ru_count(count, 'отверстие', 'отверстия', 'отверстий')} ø{pnum(hole_d)} по осевой линии, "
        f"шаг {pnum(pitch)} мм.{edge}",
        f"{ru_count(count, 'отверстие', 'отверстия', 'отверстий')} ø{pnum(hole_d)} вдоль длинной оси, "
        f"шаг {pnum(pitch)} мм.{edge}",
    )
    return rng.choice(options)


def row_en(rng: Rng, count: int, hole_d: float, pitch: float, start: float | None) -> str:
    edge = f" The first hole sits {pnum(start)} mm from the end." if start is not None else ""
    options = (
        f"{count} holes Ø{pnum(hole_d)} mm in a row down the centre line, {pnum(pitch)} mm pitch.{edge}",
        f"a row of {count} holes Ø{pnum(hole_d)} mm on the axis, pitch {pnum(pitch)} mm.{edge}",
        f"{count} holes Ø{pnum(hole_d)} mm along the long axis, {pnum(pitch)} mm apart.{edge}",
    )
    return rng.choice(options)


def skip_row_ru(rng: Rng, count: int, hole_d: float, pitch: float, grid: float, start: float | None) -> str:
    edge = f" Первое отверстие в {pnum(start)} мм от края." if start is not None else ""
    options = (
        f"{ru_count(count, 'отверстие', 'отверстия', 'отверстий')} ø{pnum(hole_d)} с шагом {pnum(pitch)} мм, "
        f"промежуточные позиции сетки {pnum(grid)} мм пропущены.{edge}",
        f"{ru_count(count, 'отверстие', 'отверстия', 'отверстий')} ø{pnum(hole_d)} через одну позицию: "
        f"сетка {pnum(grid)} мм, между отверстиями {pnum(pitch)} мм.{edge}",
    )
    return rng.choice(options)


def skip_row_en(rng: Rng, count: int, hole_d: float, pitch: float, grid: float, start: float | None) -> str:
    edge = f" The first hole sits {pnum(start)} mm from the end." if start is not None else ""
    options = (
        f"{count} holes Ø{pnum(hole_d)} mm at {pnum(pitch)} mm pitch, skipping every other "
        f"{pnum(grid)} mm grid position.{edge}",
        f"{count} holes Ø{pnum(hole_d)} mm drilled every second slot of a {pnum(grid)} mm grid, "
        f"so {pnum(pitch)} mm apart.{edge}",
    )
    return rng.choice(options)


def two_rows_ru(rng: Rng, count: int, hole_d: float, pitch: float, offset: float, start: float | None) -> str:
    edge = f" Первые отверстия в {pnum(start)} мм от края." if start is not None else ""
    options = (
        f"два ряда по {ru_count(count, 'отверстие', 'отверстия', 'отверстий')} ø{pnum(hole_d)} с шагом "
        f"{pnum(pitch)} мм, ряды разнесены на {pnum(offset)} мм по оси Y.{edge}",
        f"{ru_count(count, 'отверстие', 'отверстия', 'отверстий')} ø{pnum(hole_d)} в каждом из двух рядов "
        f"на расстоянии {pnum(offset)} мм друг от друга, шаг {pnum(pitch)} мм.{edge}",
    )
    return rng.choice(options)


def two_rows_en(rng: Rng, count: int, hole_d: float, pitch: float, offset: float, start: float | None) -> str:
    edge = f" The first hole of each row sits {pnum(start)} mm from the end." if start is not None else ""
    options = (
        f"two rows of {count} holes Ø{pnum(hole_d)} mm at {pnum(pitch)} mm pitch, the rows "
        f"{pnum(offset)} mm apart in Y.{edge}",
        f"{count} holes Ø{pnum(hole_d)} mm per row, two rows {pnum(offset)} mm apart, "
        f"{pnum(pitch)} mm pitch.{edge}",
    )
    return rng.choice(options)


def pockets_ru(rng: Rng, rows: int, cols: int, size: float, depth: float, px: float, py: float) -> str:
    pitch = f"{pnum(px)} x {pnum(py)} мм" if abs(px - py) > 1e-9 else f"{pnum(px)} мм"
    options = (
        f"карманы {pnum(size)} x {pnum(size)} мм глубиной {pnum(depth)} мм по сетке "
        f"{rows} x {cols} с шагом {pitch}.",
        f"сетка карманов {rows} x {cols} с шагом {pitch}: {pnum(size)} x {pnum(size)} мм, "
        f"глубина {pnum(depth)} мм.",
        f"{rows} x {cols} квадратных карманов {pnum(size)} мм с шагом {pitch} и глубиной "
        f"{pnum(depth)} мм.",
    )
    return rng.choice(options)


def pockets_en(rng: Rng, rows: int, cols: int, size: float, depth: float, px: float, py: float) -> str:
    pitch = f"{pnum(px)} x {pnum(py)} mm" if abs(px - py) > 1e-9 else f"{pnum(px)} mm"
    options = (
        f"pockets {pnum(size)} x {pnum(size)} mm and {pnum(depth)} mm deep on a {rows} x {cols} grid, "
        f"{pitch} pitch.",
        f"a {rows} x {cols} pocket grid at {pitch} pitch, each pocket {pnum(size)} x {pnum(size)} mm, "
        f"{pnum(depth)} mm deep.",
        f"{rows} x {cols} square pockets of {pnum(size)} mm, {pnum(depth)} mm deep, spaced {pitch}.",
    )
    return rng.choice(options)


def bosses_ru(rng: Rng, count: int, boss_d: float, hole_d: float, edge: float, height: float) -> str:
    options = (
        f"{ru_count(count, 'бобышка', 'бобышки', 'бобышек')} ø{pnum(boss_d)} мм высотой {pnum(height)} мм "
        f"по углам, с отверстиями ø{pnum(hole_d)} — центры в {pnum(edge)} мм от кромки.",
        f"по углам {ru_count(count, 'площадка', 'площадки', 'площадок')} ø{pnum(boss_d)} мм с "
        f"отверстиями ø{pnum(hole_d)}, отступ {pnum(edge)} мм от кромки, высота {pnum(height)} мм.",
        f"{ru_count(count, 'бобышка', 'бобышки', 'бобышек')} ø{pnum(boss_d)} x {pnum(height)} мм в углах "
        f"под анкерные отверстия ø{pnum(hole_d)}, {pnum(edge)} мм от кромки.",
    )
    return rng.choice(options)


def bosses_en(rng: Rng, count: int, boss_d: float, hole_d: float, edge: float, height: float) -> str:
    options = (
        f"{count} bosses Ø{pnum(boss_d)} mm and {pnum(height)} mm tall at the corners, with "
        f"Ø{pnum(hole_d)} mm anchor holes {pnum(edge)} mm in from the edge.",
        f"corner pads Ø{pnum(boss_d)} mm carrying Ø{pnum(hole_d)} mm holes, centres "
        f"{pnum(edge)} mm from the edge, pads {pnum(height)} mm high.",
        f"{count} Ø{pnum(boss_d)} x {pnum(height)} mm bosses in the corners for Ø{pnum(hole_d)} mm "
        f"anchors, {pnum(edge)} mm edge offset.",
    )
    return rng.choice(options)


def rack_ru(rng: Rng, count: int, pitch: float, tooth_h: float, crest: float, height: float) -> str:
    options = (
        f"{ru_count(count, 'зуб', 'зуба', 'зубьев')} с шагом {pnum(pitch)} мм, высота зуба "
        f"{pnum(tooth_h)} мм, ширина у вершины {pnum(crest)} мм.",
        f"зубчатая рейка на {ru_count(count, 'зуб', 'зуба', 'зубьев')}: модуль шага {pnum(pitch)} мм, "
        f"зуб {pnum(tooth_h)} x {pnum(crest)} мм.",
        f"{ru_count(count, 'зуб', 'зуба', 'зубьев')} по верху планки с шагом {pnum(pitch)} мм и "
        f"профилем {pnum(tooth_h)} x {pnum(crest)} мм.",
    )
    return rng.choice(options)


def rack_en(rng: Rng, count: int, pitch: float, tooth_h: float, crest: float, height: float) -> str:
    options = (
        f"{count} teeth at {pnum(pitch)} mm pitch, {pnum(tooth_h)} mm tall and {pnum(crest)} mm "
        f"across the crest.",
        f"a rack with {count} teeth, {pnum(pitch)} mm pitch, tooth {pnum(tooth_h)} x {pnum(crest)} mm.",
        f"{count} rack teeth along the top edge, pitch {pnum(pitch)} mm, tooth profile "
        f"{pnum(tooth_h)} x {pnum(crest)} mm.",
    )
    return rng.choice(options)


def sockets_ru(rng: Rng, count: int, boss_d: float, socket_d: float, socket_depth: float, edge: float) -> str:
    options = (
        f"{ru_count(count, 'площадка', 'площадки', 'площадок')} ø{pnum(boss_d)} мм по углам с гнёздами "
        f"ø{pnum(socket_d)} мм глубиной {pnum(socket_depth)} мм, отступ {pnum(edge)} мм от кромки.",
        f"по углам {ru_count(count, 'площадка', 'площадки', 'площадок')} ø{pnum(boss_d)} мм, "
        f"{pnum(edge)} мм от кромки, в каждой гнездо ø{pnum(socket_d)} x {pnum(socket_depth)} мм.",
    )
    return rng.choice(options)


def sockets_en(rng: Rng, count: int, boss_d: float, socket_d: float, socket_depth: float, edge: float) -> str:
    options = (
        f"{count} corner bosses Ø{pnum(boss_d)} mm with Ø{pnum(socket_d)} mm sockets "
        f"{pnum(socket_depth)} mm deep, centres {pnum(edge)} mm in from the edge.",
        f"corner pads Ø{pnum(boss_d)} mm at a {pnum(edge)} mm edge offset, each with a "
        f"Ø{pnum(socket_d)} x {pnum(socket_depth)} mm socket.",
    )
    return rng.choice(options)


def frame_ru(rng: Rng, holes: int, hole_d: float, px: float, py: float) -> str:
    options = (
        f"отверстия ø{pnum(hole_d)} по периметру: {ru_count(holes, 'штука', 'штуки', 'штук')} "
        f"с шагом {pnum(px)} x {pnum(py)} мм.",
        f"контур из {ru_count(holes, 'отверстия', 'отверстий', 'отверстий')} ø{pnum(hole_d)} "
        f"по краю, шаг {pnum(px)} x {pnum(py)} мм.",
    )
    return rng.choice(options)


def frame_en(rng: Rng, holes: int, hole_d: float, px: float, py: float) -> str:
    options = (
        f"{holes} holes Ø{pnum(hole_d)} mm around the perimeter at a {pnum(px)} x {pnum(py)} mm pitch.",
        f"a perimeter ring of {holes} Ø{pnum(hole_d)} mm holes, {pnum(px)} x {pnum(py)} mm pitch.",
    )
    return rng.choice(options)
