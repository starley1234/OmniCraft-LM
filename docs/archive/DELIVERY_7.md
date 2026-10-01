# Delivery №7 — корпуса sketch4 / wire4 / solid3 / asm4 (2026-10-01)

Ветка: `arena/01a0f76b-omnicraft-lm`. Продолжение поставок №5 (`d9ae8a70…`) и №6 (`330f7ae3…`).
Все строки помечены `validation_status: pending_openscad_manifold` — финальная приёмка только реальным `openscad --backend=manifold` на стороне получателя.

## Состав (3650 строк, 4 корпуса, только новые файлы)

| корпус | строк | семейств | sha256 манифеста | верификатор |
| --- | ---: | ---: | --- | --- |
| `optional_data/data/sketch4` | 1000 | 5×200 | `89306d946ee47c9f712833a96446787944662a3cbfe154bbb280f1e276e567bb` | `verify_sketch2.py --parts-dir optional_data/data/sketch4` → **0 failed** |
| `optional_data/data/wire4` | 1000 | 5×200 | `bc62bbac50b36aa4b36d19d7654970bb8e5f29ea3fb5a339f8f2314badd22e63` | `verify_wire2.py --parts-dir optional_data/data/wire4` → **0 failed** |
| `optional_data/data/solid3` | 1000 | 5×200 | `473d2e6c05a081ee3de37bae598d99eb8fbbb8dcc10b501d1caf38f536afb139` | `verify_scale1.py --parts-dir optional_data/data/solid3` → **0 failed** |
| `optional_data/data/asm4` | 650 сцен / 6110 деталей | 5×130 | `b0a9db60fda18680b6198f47dc0de4c047541e7d840270ba772d7c36b7fbd76b` | `verify_asm2.py --parts-dir optional_data/data/asm4` → **problems: none** |

Генераторы: `tools/dataset_sketch4/`, `tools/dataset_wire4/`, `tools/dataset_solid3/`, `tools/dataset_asm4/` (ядро и верификаторы переиспользованы из sketch2/wire2/solid2/asm2).

## Семейства

- **sketch4**: camplates (кулачковые пластины, 1/2 лопасти/эксцентрик), spacerplates (прямоугольные/овальные/круглые проставки), starwheels (цевочные/храповые колёса), spinparts (тела вращения: шкив/фланцевая втулка/маховичок), bracketplates (косынки/пазовые пластины/трапеции). Профили 6..48 точек, 800 строк с отверстиями, 200 тел вращения.
- **wire4**: pergola (арки-шпалеры), shopcart (тележки), stoolchair (табуреты/стулья), shelfunit (стеллажи), aladder (стремянки). Узлы 12..24, рёбра 19..40, координаты литералами (4 знака).
- **solid3**: spurblank (зубчатые заготовки 10-18 зубьев), enclosurebox (открытые корпуса с бобышками и кабельным вырезом), ribbracket (уголки с косынками), hopper (воронки с квадратным фланцем), saddleclamp (седловые зажимы вала, plain/split).
- **asm4**: motorstation (мотор+подушка+шкив), beltloop (плоскоременная петля), pressfixture (прессовая оснастка), rockerlink (кулиса с вилкой), hingeflap (гребёнчатая петля со створкой). Зазор ≥0.2 мм везде (минимум 0.2000 — язык проушины в вилке).

## Дисциплина (без изменений)

- `$fn = 32;`, полная параметричность, без import/surface/text/children/echo/rands, детерминированные сиды, уникальные RU+EN промпты с размерами, ~20% строк с допусковыми фразами, закон place1 (каждое число промпта есть в коде), expected_bbox_mm в каждой строке.
- **OpenSCAD CLI на машине генерации отсутствует** — локальный гейт manifold3d+trimesh; отчёты `GENERATION_REPORT.md` в каждом корпусе (не входят в SHA256SUMS).
- Отклонения wire-канваса (≤32 узла) задокументированы в отчётах.

## Проверено локально

- sketch4: 1000 строк, sha256 bad 0, дубликаты 0/0, problems 0.
- wire4: 1000 строк, sha256 bad 0, дубликаты 0/0, problems 0.
- solid3: 1000 строк, sha256 bad 0, дубликаты 0/0, problems 0.
- asm4: 650 сцен, 6110 трансформаций, 0 расхождений, мин. зазор 0.2000 мм, bbox error 0.0000%, volume 0.0000%, problems: none.
