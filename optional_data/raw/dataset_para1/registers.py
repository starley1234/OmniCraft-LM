"""Prompt registers for the para1 corpus.

Five registers are produced for every source part:

1. ``formal_ru``      - formal engineering request in Russian,
2. ``shopslang_ru``   - shop floor slang in Russian,
3. ``chat_ru``        - a short chat message in Russian,
4. ``tolerance_ru``   - fits, tolerances and units, Russian,
5. ``technical_en``   - English technical request.

The facts (noun, envelope, feature sentences) are always taken from the source
part - the source prompt supplies the feature sentences, the manifest supplies
the envelope - so a paraphrase can never invent geometry that is not in the
code it points at.
"""

from __future__ import annotations

import re

from tools.dataset_gen2.common import Rng, fmt

REGISTERS = ("formal_ru", "shopslang_ru", "chat_ru", "tolerance_ru", "technical_en")

FAMILY_NOUNS: dict[str, tuple[str, str]] = {
    "lbrackets": ("монтажный уголок", "mounting L bracket"),
    "ubrackets": ("П-образный кронштейн", "U bracket"),
    "zbrackets": ("Z-образный кронштейн", "Z bracket"),
    "spurgears": ("прямозубая шестерня", "spur gear"),
    "helicalgears": ("косозубая шестерня", "helical gear"),
    "racks": ("зубчатая рейка", "gear rack"),
    "pulleys": ("шкив", "pulley"),
    "motormounts": ("монтажная плита под мотор", "motor mount plate"),
    "bearings": ("посадочный стакан под подшипник", "bearing seat"),
    "caps": ("заглушка", "cap"),
    "spacers": ("проставка", "spacer"),
    "oldhams": ("полумуфта Олдхема", "Oldham coupling hub"),
    "hinges": ("петля", "hinge leaf"),
    "clips": ("клипса для кабеля", "cable clip"),
    "ducts": ("кабельный канал", "cable duct"),
    "knobs": ("ручка-гайка", "knurled knob"),
    "impellers": ("крыльчатка", "impeller"),
    "enclosures": ("корпус прибора", "enclosure body"),
    "lids": ("крышка корпуса", "enclosure lid"),
    "bezels": ("лицевая рамка", "display bezel"),
    "trusses": ("плоская ферма", "flat truss"),
    "towers": ("четырёхопорная башня", "four-leg tower"),
    "quadframes": ("рама квадрокоптера", "quadcopter frame"),
    "ibeams": ("решётчатая двутавровая балка", "lattice I-beam"),
    "pipes": ("трубный маршрут", "pipe route"),
    "shafts": ("ступенчатый вал", "stepped shaft"),
    "flanges": ("фланец с буртом", "flanged hub"),
    "handles": ("эргономичная рукоятка", "ergonomic handle"),
    "threads": ("болт с резьбой", "threaded bolt"),
    "threadcaps": ("заглушка с резьбой", "threaded cap"),
    "thumbscrews": ("прижимная гайка с накаткой", "knurled thumbscrew"),
    "ringgears": ("зубчатое кольцо", "ring gear"),
    "herringbones": ("шевронная шестерня", "herringbone gear"),
    "wormwheels": ("червячное колесо", "worm wheel"),
    "snapfits": ("защёлка", "snap-fit latch"),
    "livinghinges": ("живой шарнир", "living hinge"),
    "heatsinks": ("радиатор", "heat sink"),
    "cardans": ("вилка карданного шарнира", "cardan yoke"),
    "bearingblocks": ("подшипниковый блок", "bearing block"),
    "airducts": ("воздуховод", "air duct"),
    "fairings": ("обтекатель", "fairing"),
    "springclamps": ("пружинный зажим", "spring clamp"),
    "pipeclamps": ("хомут для трубы", "pipe clamp"),
    "cleats": ("клемма", "cleat"),
    "hexlattices": ("сотовый заполнитель", "hex lattice panel"),
    "slottedpanels": ("панель со щелями", "slotted panel"),
    "cams": ("кулачок", "cam"),
    "levers": ("рычаг", "lever"),
    "hooks": ("крюк", "hook"),
    "beltrollers": ("ролик", "belt roller"),
    "archtrusses": ("арочная ферма", "arch truss"),
    "steptowers": ("ступенчатая башня", "step tower"),
    "chassisframes": ("рама шасси", "chassis frame"),
    "scissorgrids": ("ножничная решётка", "scissor grid"),
}

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
    (44.45, "1 3/4"),
    (50.8, "2"),
)

PARAM_NAMES_RU: dict[str, str] = {
    "hole_d": "отверстие",
    "bore_d": "посадочное отверстие",
    "bore": "посадочное отверстие",
    "shaft_d": "шейка вала",
    "major_d": "наружный диаметр резьбы",
    "pitch": "шаг",
    "wall": "стенка",
    "thickness": "толщина",
    "height": "высота",
    "length": "длина",
    "width": "ширина",
    "depth": "глубина",
    "outer_d": "наружный диаметр",
    "pcd": "окружность отверстий",
    "holes": "число отверстий",
    "teeth": "число зубьев",
    "slots": "число пазов",
    "web": "перемычка",
    "angle": "угол",
}

PARAM_NAMES_EN: dict[str, str] = {
    "hole_d": "hole",
    "bore_d": "bore",
    "bore": "bore",
    "shaft_d": "shaft journal",
    "major_d": "thread outside diameter",
    "pitch": "pitch",
    "wall": "wall",
    "thickness": "thickness",
    "height": "height",
    "length": "length",
    "width": "width",
    "depth": "depth",
    "outer_d": "outside diameter",
    "pcd": "bolt circle",
    "holes": "hole count",
    "teeth": "tooth count",
    "slots": "slot count",
    "web": "web",
    "angle": "angle",
}


def _precise(value: float) -> str:
    """Number without a trailing zero run, keeping up to three decimals."""
    text = fmt(value, 3).rstrip("0").rstrip(".")
    return text or "0"


def _num(value: float) -> str:
    return fmt(value, 1 if abs(value - round(value)) > 1e-9 else 0)


def inch_match(value: float, tolerance: float = 0.06) -> str | None:
    for millimetres, label in INCH_TABLE:
        if abs(value - millimetres) <= tolerance:
            return label
    return None


def sentences(text: str) -> list[str]:
    parts = [part.strip() for part in re.split(r"(?<=[.!?])\s+", text.strip()) if part.strip()]
    return [part for part in parts if any(ch.isdigit() for ch in part)]


def feature_pool(row: dict, language: str) -> list[str]:
    """Factual, dimension bearing sentences of the source prompt."""
    text = str(row.get("prompt_" + language, ""))
    pool = sentences(text)
    # drop the opening sentence if it is only the envelope, keep the rest
    if len(pool) > 1:
        pool = pool[1:]
    return pool


LENGTH_LIKE = ("thickness", "height", "length", "width", "depth")


def key_params(row: dict, limit: int = 3) -> list[tuple[str, float]]:
    """Named sizes of the part, most telling first, without the envelope.

    Zero / missing entries are dropped (a family may carry a parameter that is
    unused in this variant) and a length that merely repeats the overall size
    is skipped, so the paraphrase never says the same number twice.
    """
    wanted = ("hole_d", "bore_d", "bore", "major_d", "pitch", "wall", "thickness", "height", "teeth", "outer_d")
    parameters = row.get("parameters") or {}
    envelope = {round(float(value), 2) for value in row.get("expected_bbox_mm") or []}
    items = []
    for key in wanted:
        if key not in parameters:
            continue
        value = float(parameters[key])
        if value <= 0.0:
            continue
        if key in LENGTH_LIKE and round(value, 2) in envelope:
            continue
        items.append((key, value))
    if not items:
        # only keys this table can name; a raw parameter key must never leak
        # into the prose (it would read as "inner r 12.7 mm" in a Russian row)
        items = [
            (str(key), float(value))
            for key, value in parameters.items()
            if str(key) in PARAM_NAMES_RU and float(value) > 0.0
        ][:limit]
    return items[:limit]


def _envelope_ru(bbox) -> str:
    return f"{_num(bbox[0])} x {_num(bbox[1])} x {_num(bbox[2])} мм"


def _envelope_en(bbox) -> str:
    return f"{_num(bbox[0])} x {_num(bbox[1])} x {_num(bbox[2])} mm"


def _param_phrase_ru(key: str, value: float) -> str:
    name = PARAM_NAMES_RU.get(key, key.replace("_", " "))
    if abs(value - round(value)) < 1e-9:
        if key in ("holes", "teeth", "slots"):
            return f"{name} — {int(round(value))} шт."
        return f"{name} {_num(value)} мм"
    return f"{name} {_num(value)} мм"


def _param_phrase_en(key: str, value: float) -> str:
    name = PARAM_NAMES_EN.get(key, key.replace("_", " "))
    if abs(value - round(value)) < 1e-9:
        if key in ("holes", "teeth", "slots"):
            return f"{name} {int(round(value))} pcs"
        return f"{name} {_num(value)} mm"
    return f"{name} {_num(value)} mm"


FORMAL_RU = (
    "Требуется спроектировать",
    "Задание на проектирование:",
    "Необходимо изготовить",
    "В рамках заказа требуется смоделировать",
    "Техническое задание:",
    "Прошу подготовить модель детали",
)
FORMAL_RU_TAIL = (
    "Модель должна быть пригодна для 3D-печати без поддержек.",
    "Требования по материалу и допускам — стандартные для участка.",
    "Файл нужен в виде solid-модели, единицы — миллиметры.",
    "Прошу оформить как готовый к печати файл.",
    "Модель должна повторять указанные размеры без искажений.",
    "Чертёж прилагается, отклонения согласовать с технологом.",
)
FORMAL_EN_TAIL = (
    "All dimensions in millimetres, keep the model printable.",
    "Deliver a single watertight solid, units in mm.",
    "Millimetre units, printable without supports.",
    "The model must repeat the stated sizes as drawn.",
    "One closed solid body, please, ready for printing.",
)
SLANG_RU = (
    "Слушай, надо деталь:",
    "Мужики, нужна железка:",
    "Тут вот какая штука:",
    "Дай модельку, коллега:",
    "Заказ простой:",
    "Короче, надо:",
)
SLANG_RU_TAIL = (
    "Сделай чтоб всё село нормально, без сюрпризов.",
    "Главное — чтоб по размерам сошлось, остальное неважно.",
    "Накидай модель, я на печать поставлю.",
    "Только не переусложняй, нам это к вечеру надо.",
    "Сделай нормально, чтоб в сборе встало.",
    "Проверь по месту, чтоб не пришлось переделывать.",
)
SLANG_EN_OPEN = (
    "Shop request: knock out a",
    "Quick one for you: a",
    "Workshop needs a",
    "Can you bang out a",
    "On the shop floor we need a",
    "Favour for the shop: a",
)
SLANG_EN_TAIL = (
    "Keep it simple, it has to fit on the first try.",
    "Nothing fancy, it just has to fit.",
    "Print it as is, we will fit it on the bench.",
    "Make it sturdy, it will see some abuse.",
    "Don't overthink it, just make it fit.",
    "Rough and ready is fine, as long as it fits.",
)
CHAT_RU_OPEN = (
    "привет!",
    "здравствуйте,",
    "привет, подскажи,",
    "добрый день!",
    "привет)",
    "приветствую,",
)
CHAT_RU_ASK = (
    "сделаешь?",
    "можешь смоделировать?",
    "накидаешь модель?",
    "соберёшь файл?",
    "сделай, плиз.",
    "оформишь моделишку?",
)
CHAT_RU_TAIL = (
    "спасибо!",
    "заранее спасибо.",
    "очень надо, спасибо!",
    "спс",
    "буду благодарен.",
    "как сможешь — маякни.",
)
CHAT_EN_OPEN = ("Hi!", "Hello!", "Hey,", "Hi there,", "Good day!", "Hello there,")
CHAT_EN_TAIL = ("Thanks!", "Thanks in advance.", "Cheers!", "Much appreciated!", "Thanks a lot!", "Ta!")
RU_TECH_TAIL = (
    "Единицы — миллиметры, одна замкнутая оболочка.",
    "Всё в миллиметрах, модель должна быть замкнутой.",
    "Размеры в мм, деталь одним цельным телом.",
    "Единицы измерения — миллиметры, без самопересечений.",
    "Миллиметры, одна оболочка без разрывов.",
    "В мм, единый solid без внутренних полостей.",
)
TOL_RU_OPEN = (
    "Деталь по чертежу:",
    "Нужна модель с рабочими допусками:",
    "Сделай под механическую обработку:",
    "Посадки важны, деталь:",
    "Требования по точности выше обычных:",
    "Модель под сопряжение:",
)
TOL_RU_FITS = (
    "Сопрягаемые размеры — H7, свободные поля допуска +0.3 мм.",
    "Зазор в подвижном соединении 0.2 мм, всё остальное свободно.",
    "Допуск на сопрягаемые диаметры +0.05/-0, остальное ±0.2 мм.",
    "Посадка скользящая с зазором 0.15 мм, биение не более 0.1 мм.",
    "Отверстия под крепёж +0.2 мм, центрирующие пояски по H8.",
    "Натяга не нужно, везде скользящая посадка 0.1–0.2 мм.",
    "Ключевой размер ±0.1 мм, остальное по общему допуску.",
)
TOL_RU_UNITS = (
    "Профиль печатается слоем 0.2 мм, PETG, усадка 0.3 %.",
    "Печать ABS, компенсация усадки 0.4 %.",
    "Фрезеровка из Д16Т, припуск по контуру 0.1 мм.",
    "Печать PLA, стенка 3 периметра, заполнение 30 %.",
    "Литьё под давлением, уклон по стенкам 1 градус.",
    "Точение из стали 45, шероховатость Ra 3.2.",
)
TOL_EN_UNITS = (
    "Print in PETG, 0.2 mm layers, account for 0.3 % shrinkage.",
    "Machined from 6082-T6, 0.1 mm stock on the profile.",
    "Printed in PLA, three perimeters, 30 % infill.",
    "Injection moulded, 1 degree draft on the walls.",
    "Printed in ABS, 0.4 % shrinkage compensation.",
    "Turned from C45 steel, Ra 3.2 finish.",
)
TOL_EN_FITS = (
    "Mating sizes to H7, free fields +0.3/-0.",
    "Running clearance 0.2 mm, everything else free.",
    "Centring seats H7, bolt holes +0.2 mm.",
    "Sliding fit 0.15 mm on the guide, press seats left nominal.",
    "Key face tolerance ±0.05 mm, the rest ±0.2 mm.",
    "No interference fits, 0.1-0.2 mm sliding fit throughout.",
)
TECH_EN = (
    "Deliverable: a printable model of a",
    "Please model the following part - a",
    "Task: model a",
    "Request: build the CAD model of a",
    "Please produce the model of a",
    "Engineering request: define the solid model of a",
)
TECH_EN_TAIL = (
    "All dimensions in millimetres, keep the model watertight.",
    "Millimetre units, single solid, no self intersections.",
    "Tolerances to the default drawing block, millimetres.",
    "Keep the part printable as a single solid body.",
    "Units: mm, deliver one closed solid.",
    "Model it as one manifold body, mm units.",
)
TECH_RU_FRAME = (
    "Смоделируй деталь",
    "Нужна модель детали",
    "Построй модель детали",
    "Сделай solid-модель детали",
    "Оформи деталь",
    "Собери модель детали",
)


def _pick(pool, variant: int, salt: int):
    """Mixed-radix pick: salt selects a base-5 digit of ``variant``.

    One variant therefore walks a wide grid of combinations (5 picks per digit)
    instead of moving every pool in lockstep, which is what the corpus needs to
    keep 4000 paraphrases distinct.
    """
    return pool[(variant // (5 ** salt)) % len(pool)]


def compose(row: dict, corpus: str, register: str, rng: Rng, variant: int = 0) -> tuple[str, str]:
    """One RU/EN prompt pair for the requested register.

    ``variant`` walks the phrasing grids deterministically (each pool pick is a
    base-5 digit of the variant); the builder raises it until the pair is unique
    in the corpus.  Facts always come from the source row.
    """
    family = str(row["family"])
    noun_ru, noun_en = FAMILY_NOUNS.get(family, (family, family))
    noun_ru = f"«{noun_ru}»"
    bbox = [float(value) for value in row["expected_bbox_mm"]]
    ru_features = feature_pool(row, "ru") or [f"Габарит {_envelope_ru(bbox)}."]
    en_features = feature_pool(row, "en") or [f"Envelope {_envelope_en(bbox)}."]
    params_all = key_params(row, limit=3) or key_params(row, limit=1)

    feature_ru = _pick(ru_features, variant, 1)
    feature_en = _pick(en_features, variant, 1)
    detail_ru = _pick(params_all, variant, 2) if params_all else None
    detail_en = _pick(params_all, variant, 2) if params_all else None
    ru_dims = _envelope_ru(bbox)
    en_dims = _envelope_en(bbox)

    if register == "formal_ru":
        ru = (
            f"{_pick(FORMAL_RU, variant, 0)} {noun_ru} по эскизу. "
            f"Габаритные размеры {ru_dims}. {feature_ru} {_pick(FORMAL_RU_TAIL, variant, 3)}"
        )
        en = f"Please model {noun_en}, envelope {en_dims}. {feature_en} {_pick(FORMAL_EN_TAIL, variant, 3)}"
    elif register == "shopslang_ru":
        dims = _pick(
            (
                f"где-то {ru_dims}",
                f"примерно {_num(bbox[0])} на {_num(bbox[1])} на {_num(bbox[2])}",
                f"габарит {ru_dims}",
                f"размером {ru_dims}",
                f"плюс-минус {_num(bbox[0])} на {_num(bbox[1])}",
            ),
            variant,
            2,
        )
        ru = f"{_pick(SLANG_RU, variant, 0)} {noun_ru}, {dims}. {feature_ru} {_pick(SLANG_RU_TAIL, variant, 3)}"
        en = (
            f"{_pick(SLANG_EN_OPEN, variant, 0)} {noun_en}, roughly {en_dims}. {feature_en} "
            f"{_pick(SLANG_EN_TAIL, variant, 3)}"
        )
    elif register == "chat_ru":
        detail = f", {_param_phrase_ru(*detail_ru)}" if detail_ru else ""
        ru = (
            f"{_pick(CHAT_RU_OPEN, variant, 0)} нужна деталь {noun_ru} "
            f"{_num(bbox[0])}x{_num(bbox[1])}x{_num(bbox[2])}{detail}. "
            f"{_pick(CHAT_RU_ASK, variant, 3)} {_pick(CHAT_RU_TAIL, variant, 4)}"
        )
        en_detail = f", {_param_phrase_en(*detail_en)}" if detail_en else ""
        en = (
            f"{_pick(CHAT_EN_OPEN, variant, 0)} could you model a {noun_en}, "
            f"{_num(bbox[0])}x{_num(bbox[1])}x{_num(bbox[2])} mm{en_detail}? {_pick(CHAT_EN_TAIL, variant, 4)}"
        )
    elif register == "tolerance_ru":
        # only one imperial note per row, and quoted as its own full sentence:
        # a bare "bore 6.3 mm (1/4 in)" glued mid-paragraph read as a typo
        pairs = [
            (_precise(value), inch)
            for key, value in params_all
            if (inch := inch_match(value))
        ]
        if pairs:
            value_text, inch = _pick(tuple(pairs), variant, 4)
            mix = f"Ключевой размер {value_text} мм — это ровно {inch} дюйма."
        else:
            mix = ""
        ru = (
            f"{_pick(TOL_RU_OPEN, variant, 0)} {noun_ru}, габарит {ru_dims}. {feature_ru} "
            f"{_pick(TOL_RU_FITS, variant, 3)}{' ' + mix if mix else ''} {_pick(TOL_RU_UNITS, variant, 4)}"
        )
        if pairs:
            value_text, inch = _pick(tuple(pairs), variant, 4)
            en_mix = f"Key size {value_text} mm equals {inch} in."
        else:
            en_mix = ""
        en = (
            f"{noun_en}, envelope {en_dims}. {feature_en} {_pick(TOL_EN_FITS, variant, 3)}"
            f"{' ' + en_mix if en_mix else ''} {_pick(TOL_EN_UNITS, variant, 4)}"
        )
    else:  # technical_en
        ru = (
            f"{_pick(TECH_RU_FRAME, variant, 0)} {noun_ru}: габарит {ru_dims}. "
            f"{_pick(ru_features, variant, 2)} {_pick(RU_TECH_TAIL, variant, 4)}"
        )
        en = (
            f"{_pick(TECH_EN, variant, 0)} {noun_en}. Envelope {en_dims}. {feature_en} "
            f"{_pick(TECH_EN_TAIL, variant, 3)}"
        )
    ru = " ".join(ru.split())
    en = " ".join(en.split())
    return ru, en
