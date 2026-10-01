# Заявка №5 — четыре корпуса: `wire2`, `sketch2`, `asm2`, `scale1`

Файл для приёмщика: здесь перечислено ровно то, что сделано в пятой поставке —
четыре новых корпуса в `optional_data/data/` и инструменты, которые их собрали
и перепроверяют. Всё, что нужно для повторения, — команды в разделе D.

- **`openSCAD CLI on this machine / openSCAD CLI на этой машине: no / нет`.**
  Все локальные проверки выполнены на связке `manifold3d` + `trimesh` — том же
  ядре, которое использует `openscad --backend=manifold`. **Окончательная
  приёмка — только ваш прогон настоящим CLI OpenSCAD**; до него все четыре
  корпуса имеют статус `pending_openscad_manifold` (в каждой строке манифеста
  и в `VALIDATION_REQUIRED.md` каждого каталога).
- Ничего из уже принятого не переписано: правки вне новых каталогов
  `tools/dataset_{v5,wire2,sketch2,asm2,scale1}/` — ровно одна: аддитивный
  passthrough `color([...])` в вычислителе `tools/dataset_gen2/miniscad.py`
  (нужен asm2; геометрию не меняет). Модель и пайплайн обучения не тронуты —
  это поставка данных.
- Детерминизм: все генераторы на `Rng(family, index)`, сид 20261001 (отличается
  от сида 20260929 предыдущих поставок — пересечений отрисовок нет).

Итого: **4760 строк** датасета в четырёх корпусах.

| корпус | строк | семейств | sha256 `manifest.jsonl` |
| --- | ---: | ---: | --- |
| `optional_data/data/wire2` | 1560 | 6 × 260 | `d1603ce1932026ea02f78b1c0d4f38a74b6f541bbd4458f004544d7c1954530f` |
| `optional_data/data/sketch2` | 1380 | 6 × 230 | `67207b875d531d75bd3c3b6d54cb26719251f2b3c701a00a8f1b87fc5381e160` |
| `optional_data/data/asm2` | 1020 | 6 × 170 | `5ae1b62f0d42075b6a622b2e1d8276af34d4149f31a226f9ca4522349d4c22c9` |
| `optional_data/data/scale1` | 800 | 4 × 200 | `f7fe7c6f5a013c0e8e21820ca973710edc05e5906e254e803ae97523fce89ff1` |

В каждом каталоге: `manifest.jsonl`, `<family>/{scene,part}_NNNN.scad`,
`SHA256SUMS.txt`, `VALIDATION_REQUIRED.md`, `GENERATION_REPORT.md`
(аудиторский лист — не часть обучающих данных и в контрольных суммах не числится).

---

## A. Что закрыто по заявке №5

**Блок W2 (`wire2`, 1200-1600 сцен → 1560).** Каркасы из прутка: фермы,
гаечные мачты, решётчатые башни, трубопроводы с отводами, ролл-кейджи,
спейсфреймы. Манифест несёт `graph` (`nodes` мм, `edges`, `member_radius_mm`),
`expected_bbox_mm` совпадает с измеренным. Аудит: **0 несвязных графов,
0 висячих узлов, 0 рёбер короче 2R**; узлы 6..25, рёбра 5..88, радиусы 1.5-5 мм.
Отклонение (задокументировано): потолок **32 узла** вместо 64 —
`src/training/aux_losses.py::wire_auxiliary_loss` бросает исключение на GT
больше 32 узлов, холст `wire_canvas.py` архитектурно на 32 вершины.

**Блок S2 (`sketch2`, 1200-1800 деталей → 1380).** Эскиз → одна экструзия
(`linear` или `rotate`) + окна/карманы: плиты с окнами, дуговые профили
(сектор/линза/корона/паз, дуги с шагом 1°), ступенчатые бруски, тела вращения
с канавками, зубчатые секторы, V-направляющие. Манифест несёт `profile`
(CCW, 7..60 точек), `extrude`, `voids_profiles` + `void_depth_mm` (460 строк
с окнами, 230 тел вращения). Аудит: **0 самопересекающихся профилей**, знак
Shoelace, объём против аналитики (площадь × высота минус вырезы; Папп для
вращений) ≤ 1.5-2 %, стенки/дно ≥ 1.2 мм. Отклонение: у `gearsectors` дуги
впадины/ступицы с шагом 3° (объявлен параметром `arc_step`) — 1° всегда
выбивало потолок 64 точки профиля.

**Блок A2 (`asm2`, 800-1200 сцен → 1020, 5958 инстансов).** Живые сборки:
вал на двух подшипниках в стакане с крышкой; мотор на кронштейне + два шкива +
плоский ремень-лента (polyhedron-контур из `concat` двух `for`-обходов с шагом
45°); фланец + прокладка + крышка + **N болтов по окружности (один модуль,
N вызовов)**; рамный куб с **четырьмя одинаковыми стойками**; тележка
(**два одинаковых колеса** + ось + вилка); петля, открытая на 0/45/90°.
Дисциплина asm1 полностью: углы кратны 45°, модули без аргументов,
**наименьший зазор 0.2500 мм при норме ≥ 0.2**, каждая деталь своего цвета
(`color([r,g,b])` на каждом вызове), ≤ 12 KiB на сцену. Манифест несёт
`assembly: [{module, t, q (w-last)}]`. **510 сцен используют повторяющиеся
модули** — для этого аудит `core2b.py` форкнут с `check_scene` asm1
(определения модулей уникальны, инстансов сколько угодно).
Реплей разметки: 5958 строк, 0 расхождений; сумма объёмов деталей против
объёма сцены: худшее 0.0000 %.

**Остаток заявки №6 (`scale1`, ~800 → 800).** Крайние масштабы и жёсткая
раскладка: `microfeatures` (всё в коробке 5-20 мм), `largestruc` (длинная ось
200-250 мм), `hardlayouts` (промпт диктует явные координаты (x, y) — закон
place1 соблюдён: 800/800 строк, 100 % в обоих языках), `thinwalls` (стенки
1.2-1.5 мм).

## B. Числа аудитов (локальный гейт + независимая перепроверка с диска)

Каждый корпус дважды проверен: гейтом на записи и отдельным `verify_*.py`,
который перечитывает файлы с диска и не доверяет результатам сборки.

| корпус | перепроверено строк | sha256 | дубли RU/EN | проблем |
| --- | ---: | ---: | ---: | ---: |
| wire2 | 1560 | 0 плохих | 0/0 | **0** |
| sketch2 | 1380 | 0 плохих | 0/0 | **0** |
| asm2 | 1020 | список ok | 0/0 | **0** |
| scale1 | 800 | 0 плохих | 0/0 | **0** |

- Закон place1 (каждое размерное число промпта есть в коде): sketch2 —
  **1380/1380 (100 %)** RU и EN; scale1 — **800/800 (100 %)** RU и EN.
- Отброшено на генерации (осознанные реджекты отрисовок, на диск не попали):
  wire2 248, sketch2 111, asm2 10, scale1 28.
- Худшее отклонение измеренного bbox от заявленного: wire2 ≤ 3 % (гейт),
  asm2 0.0012 %, sketch2/scale1 ≤ 3 % (гейт) — приёмщик допускает 15 %.

## C. Схема строк манифеста

Общее для всех: `file`, `family`, `prompt_ru`, `prompt_en`,
`expected_bbox_mm`, `parameters`, `graph` (null кроме wire2), `assembly`
(null кроме asm2), **`validation_status: "pending_openscad_manifold"`**.
Слои: wire2 добавляет `graph`; sketch2 — `profile`, `extrude`,
`voids_profiles`, `void_depth_mm`; asm2 — `assembly`; scale1 — только общее.
Импортер `tools/import_external_scad.py` отбрасывает строки без
`expected_bbox_mm` — здесь они есть у всех.

## D. Приёмка (команды)

```bash
# 0. целостность поставки (контрольные суммы)
python tools/verify_delivery.py optional_data/data/wire2
python tools/verify_delivery.py optional_data/data/sketch2
python tools/verify_delivery.py optional_data/data/asm2
python tools/verify_delivery.py optional_data/data/scale1

# 1. независимый аудит генератора (без OpenSCAD, manifold3d+trimesh)
python tools/dataset_wire2/verify_wire2.py   --parts-dir optional_data/data/wire2
python tools/dataset_sketch2/verify_sketch2.py --parts-dir optional_data/data/sketch2
python tools/dataset_asm2/verify_asm2.py     --parts-dir optional_data/data/asm2 --stl
python tools/dataset_scale1/verify_scale1.py --parts-dir optional_data/data/scale1

# 2. CAD-валидация настоящим OpenSCAD (только её результат легитимен)
openscad --backend=manifold -o /tmp/check.stl optional_data/data/wire2/spaceframes/scene_0001.scad
# ...прогоните выборку или все 4760 файлов пакетом

# 3. импорт в каноническую схему (кандидаты, НЕ принятые строки)
python tools/import_external_scad.py --parts-dir optional_data/data/wire2 \
    --output data/processed/wire2_candidates.jsonl
# и так же для sketch2 / asm2 / scale1
```

Воспроизведение генерации (детерминированное, байт-в-байт):
`python tools/dataset_<корпус>/build_<корпус>.py --count <N>`
(wire2 260, sketch2 230, asm2 170, scale1 200 на семейство).

## E. Ограничения, о которых приёмщик обязан знать

1. Локальный гейт — manifold3d через собственный вычислитель OpenSCAD-кода
   (`tools/dataset_gen2/miniscad.py`): он покрывает применённый подмножество
   языка ( CSG, `for`-циклы и comprehensions, `concat`, `rotate_extrude`,
   `color`). Конструкции вне подмножества в корпусах не используются.
2. `color()` в asm2 геометрически нейтрален; вычислитель его просто
   пробрасывает (единственная правка вне новых каталогов).
3. Строки в обучение не попадают, пока приёмщик не сменит
   `validation_status` и не прогонит `tools/validate_dataset.py`.

## F. Состав поставки в репозитории

- `tools/dataset_v5/kit.py` — общий кит (сид, хвосты промптов без утечки
  чисел, писатели поставки, потолок 32 узла).
- `tools/dataset_wire2/` — `families2w.py`, `build_wire2.py`, `verify_wire2.py`.
- `tools/dataset_sketch2/` — `core2s.py`, `families2s.py`, `build_sketch2.py`, `verify_sketch2.py`.
- `tools/dataset_asm2/` — `core2b.py`, `parts2b.py`, `scenes2b.py`, `build_asm2.py`, `verify_asm2.py`.
- `tools/dataset_scale1/` — `families1x.py`, `build_scale1.py`, `verify_scale1.py`.
- `docs/archive/DELIVERY_5.md` — этот файл.
- `docs/archive/DELIVERY_5_STATUS_SNIPPET.md` — блок для `STATUS.md`: поставка
  сознательно **не правит `STATUS.md`**, чтобы не пересекаться файлами с
  родительской веткой `arena/01a0ec28-omnicraft-lm`; приёмщик вставляет блок сам.
  Единственный изменённый общий файл поставки — `tools/dataset_gen2/miniscad.py`
  (4 строки, аддитивно, без изменения геометрии).
