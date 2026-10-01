# Поставка №6 — четыре корпуса: `sketch3`, `wire3`, `solid2`, `asm3`

Файл для приёмщика: здесь перечислено ровно то, что сделано в шестой поставке —
четыре новых корпуса в `optional_data/data/` и инструменты, которые их собрали
и перепроверяют. Всё, что нужно для повторения, — команды в разделе C.

- **`openSCAD CLI on this machine / openSCAD CLI на этой машине: no / нет`.**
  Все локальные проверки выполнены на связке `manifold3d` + `trimesh` — том же
  ядре, которое использует `openscad --backend=manifold`. **Окончательная
  приёмка — только ваш прогон настоящим CLI OpenSCAD**; до него все четыре
  корпуса имеют статус `pending_openscad_manifold` (в каждой строке манифеста
  и в `VALIDATION_REQUIRED.md` каждого каталога).
- Ничего из уже принятого не переписано: поставка состоит **только из новых
  файлов** — каталоги `tools/dataset_{sketch3,wire3,solid2,asm3}/` и
  `optional_data/data/{sketch3,wire3,solid2,asm3}/`. Общие ядра предыдущих
  поставок (`dataset_sketch2`, `dataset_wire2`, `dataset_asm2`, `dataset_gen2`,
  `dataset_place1`, `dataset_v5`) используются как есть, без правок.
  `STATUS.md` не тронут — блок для вставки лежит рядом
  (`DELIVERY_6_STATUS_SNIPPET.md`).
- Детерминизм: все генераторы на `Rng(family, index)`, сид 20261001; имена
  семейств новые, пересечений отрисовок с поставками №1-5 нет.

Итого: **4550 строк** датасета в четырёх корпусах, все канвасы с пайплайном
покрыты очередной волной (voxel, wire, sketch, assembly; у brep пайплайна
данных по-прежнему нет — это известная щель, а не пропуск поставки).

| корпус | строк | семейств | sha256 `manifest.jsonl` |
| --- | ---: | ---: | --- |
| `optional_data/data/sketch3` | 1250 | 5 × 250 | `ce37701b2c116ffa96ab06e497becdb9c583fe5e41ee72c22964b8e98b07066d` |
| `optional_data/data/wire3` | 1250 | 5 × 250 | `1875a77a88d92b78d318a586bbf0de102cce93d1bb2e2d5ac734c820ddc063cc` |
| `optional_data/data/solid2` | 1250 | 5 × 250 | `7089bd3ca7a59ae4c15d43a5dc26b2033a6e2c2ba37e5ef3f24daf4fed83cfcb` |
| `optional_data/data/asm3` | 800 | 5 × 160 | `d4da6e34f40c1041704d96bf39ed7d0074abb0de3f03703382d1be3e1d08b2d9` |

В каждом каталоге: `manifest.jsonl`, `<family>/…_NNNN.scad`,
`SHA256SUMS.txt`, `VALIDATION_REQUIRED.md`, `GENERATION_REPORT.md`
(аудиторский лист — не часть обучающих данных и в контрольных суммах не числится).

---

## A. Состав по канвасам

**Sketch (`sketch3`, 1250).** Вторая волна профиля-и-выдавливания: рейки
(`racks`, 3 варианта зубчатого пояса), конструкционные профили L/T/U/H
(`structsections`, 4 варианта), шестигранные плиты с болтовым кругом
(`hexplates`), ступицы со шпоночным пазом (`keyways`), рамные пластины с
окнами (`frameplates`). 500 деталей со сквозными пустотами; профили 6..52
точки, CCW, простые; bbox объявлен по измеренным экстремумам профиля.

**Wire (`wire3`, 1250).** Каркасы из прутка: геодом (`geodome`, кольца 6/8
углов, полшаговый твист), велосипедная рама (`bikeframe`, литеральные
координаты), строительные леса (`scaffold`, ярусы × пролёты × две стороны),
стрела крана (`cranejib`, 3 варианта), арочная ферма (`archtruss`,
параболический пояс). Графы 8..32 узла, 12..76 рёбер; манифест несёт `graph`,
реплей графа против кода с допуском 5e-4; 0 изолированных узлов.
Отклонение (задокументировано, как в wire2): кап 32 узла вместо 64 —
`aux_losses.py` и `wire_canvas.py` ограничены 32.

**Voxel (`solid2`, 1250).** Твердотельная волна: радиаторы (`heatsink`,
прямые/пазовые/крестовые рёбра), распределительные коллекторы
(`manifoldblock`, ряд портов + верхняя галерея + боковой выход), ручки
управления (`controlknob`, указатель/ямки/юбка с рёбрами), сверлильные
кондукторы (`drilljig`, бобышки/пазы/упор), вентилируемые корпуса (`ventbox`,
жалюзи/решётка/круглая вентиляция). Все соединения с перекрытием ≥ 0.5 мм
(никаких касаний гранями), стенки ≥ 1.5 мм.

**Assembly (`asm3`, 800 сцен / 6560 деталей).** Механизмы из библиотеки
деталей asm1: тиски, струбцина, насосный узел, делительный кондуктор,
ламповый рычаг. Зазоры: `GAP = 0.25` мм по стыкам, `FIT = 0.8` мм
диаметрально; углы кратны 45°; минимальный фактический зазор в корпусе —
0.2500 мм; 480 сцен используют повторяющиеся модули.

## B. Как это проверялось локально (без CLI OpenSCAD)

- Каждое семейство перед сборкой прошло смоук 8..40 отрисовок через полный
  аудит; все найденные на смоуке дефекты геометрии исправлены в генераторах
  (тангенциальные касания, неверные габариты, коллизии в сборках).
- Локальный гейт на каждую строку: заголовок `$fn = 32;`, запрещённые
  конструкции, ≤ 12 КиБ, manifold-вычисление в одно связное тело (single solid),
  объявленный bbox против измеренного, закон place1 (каждое число промпта
  существует в коде) на RU и EN.
- Независимая перепроверка **с диска** верификаторами предыдущих поставок:
  - `verify_sketch2.py --parts-dir optional_data/data/sketch3` → **0 строк с проблемами**;
  - `verify_wire2.py --parts-dir optional_data/data/wire3` → **0 строк с проблемами**;
  - `verify_scale1.py --parts-dir optional_data/data/solid2` → **0 строк с проблемами**;
  - `verify_asm2.py --parts-dir optional_data/data/asm3` → **problems: none**
    (6560 трансформаций реплеено, 0 расхождений; sha256 ok; дубли RU/EN 0/0).

## C. Команды повторения

```bash
python tools/dataset_sketch3/build_sketch3.py --count 250
python tools/dataset_wire3/build_wire3.py --count 250
python tools/dataset_solid2/build_solid2.py --count 250
python tools/dataset_asm3/build_asm3.py --count 160

python tools/dataset_sketch2/verify_sketch2.py --parts-dir optional_data/data/sketch3
python tools/dataset_wire2/verify_wire2.py --parts-dir optional_data/data/wire3
python tools/dataset_scale1/verify_scale1.py --parts-dir optional_data/data/solid2
python tools/dataset_asm2/verify_asm2.py --parts-dir optional_data/data/asm3
```

## D. Что сделать приёмщику

1. Прогнать настоящий `openscad --backend=manifold` по всем `.scad`
   (или хотя бы по случайной выборке ≥ 100 на корпус) и сверить bbox с
   `expected_bbox_mm`.
2. Сверить `SHA256SUMS.txt` в каждом каталоге.
3. При успехе — сменить `validation_status` и допустить манифесты в обучение
   (`*.accepted.jsonl` — только после приёмки).
