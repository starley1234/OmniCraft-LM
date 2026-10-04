# MANIFEST — внешние датасеты (сырьё), сняты 2026-10-04

Статус-марка всего каталога: `СЫРЫЕ_ДАННЫЕ.md` (не валидировано, не для
обучения без прогона `omni validate`). Путь в git: только этот каталог и
`tools/scrape_oss_scad.py`; конвертеры в схему проекта — задача на потом.

## Что скачано (здесь, в ветке не лежит — файлы в песочнице; при pull не ждите)

| датасет | файлы | содержимое | источник | лицензии |
|---|---|---|---|---|
| `github_scad_top70/` | `files.tar.gz` 5.3 MB + `index.csv` (2 123 строки) + `stats.json` | 2 123 уникальных `.scad` (24 MiB в архиве) + README/`customizer.yml` из 70 топ-репозиториев GitHub по topic:openscad; 101 файл с Customizer-блоками `/* [params] */`, 249 используют библиотеки (BOSL/MCAD/dotSCAD) | поиск GitHub API (`topic:openscad stars:>5`, …), codeload-архивы; скрипт генерации: `tools/scrape_oss_scad.py` | пофайлово в `index.csv`: LGPL-3 700, NOASSERTION 510, GPL-3 265, MIT 158, AGPL-3 151, GPL-2 146 |
| `cadprompt_200/` | `CADPrompt.tar.gz` 1.4 MB | 200 примеров бенчмарка CADPrompt (ICLR 2025): 2–3 варианта текстовых промптов (с размерами/без), Python-код (cadquery), JSON параметров, STL/OBJ геометрии | github.com/Kamel773/CAD_Code_Generation | исследования/указания авторов (сверять при републикации) |
| `curated_code_cad_README.md` | 19 KB | каталог «Curated Code CAD»: десятки ссылок на scad-проекты с документацией — источник для следующего скрейпа | github.com/Irev-Dev/curated-code-cad | MIT |
| `awesome_cad_datasets_notes.md` | 2.4 KB | выдержка раздела «CAD Datasets» из awesome-cad — карта датасетов на будущее | github.com/mlightcad/awesome-cad | — |

Как извлечь: `tar xzf files.tar.gz -C /tmp/scad` (архив держит пути
`<owner>__<repo>/<путь>`). Промпты для пар «текст→scad» брать из README и
параметров Customizer; дальше репак-скрипт (не написан) → `omni validate`.

## Чего в песочнице нет и почему (скачать браузером на машине владельца)

Прямой HTTP в huggingface.co и hf-mirror.com из песочницы блокируется
(000). Кандидаты на снятие — по убыванию ценности для проекта:

1. **Zero-to-CAD 1M** — `huggingface.co/datasets/ADSKAILab/Zero-To-CAD-1m`
   (коллекция `ADSKAILab/zero-to-cad`): ~1M исполняемых CadQuery-последо-
   валностей, **Apache-2.0** (редкость для поля), есть STL/STEP и рендеры,
   curated-подсет 100k. Прямых scad нет, но промпты↔код↔геометрия —
   богатейший источник; CadQuery→scad транспиляруется. arXiv 2604.24479.
2. **thingiverse-openscad** — `huggingface.co/datasets/redcathode/thingiverse-openscad`:
   scad-файлы Thingiverse + синтетические английские промпты (parquet,
   формат 1k–10k) — ближе всего к нашей задаче текст→scad. Парсить
   аккуратно: промпты синтезированы LLM.
3. **Text2CAD** — `huggingface.co/datasets/SadilKhan/Text2CAD` (NeurIPS'24):
   подписи к CAD-последовательностям; **весь корпус 605 GB** — брать только
   captions/сплиты. CC BY-NC-SA.
4. **Text2CAD-Bench** — `huggingface.co/datasets/AICAD/Text2CAD-Bench`:
   600 курированных промптов L1–L4 (двойной стиль: геометрия/процедура) —
   хорош как EVAL, не обучение.
5. **CADInstruct** (CAD-MLLM) — `huggingface.co/datasets/yuchaozheng/CAD_Instruct`:
   ~60k инструкций над DeepCAD; исследовательская лицензия.
6. **MCAD** (40k текст→OpenSCAD, «Benchmarking LLMs for Text-to-3D CAD»,
   2024) — точный репозиторий не верифицирован за 1 поиск; искать по названию
   статьи, если найдётся — приоритет выше пунктов 3–5 (это буквально наш
   формат).
7. **ABC-captioning** — github `abhendsa/abc-captioning` (метаданные +
   подписи 30k, сами STL по OneDrive-ссылкам) — для генератора промптов.
8. **SolidGen** — `huggingface.co/datasets/neology/SolidGen-21k`: 21k STEP с
   подписями (CC BY-NC); STEP→scad через OpenSCAD import не годится, но
   геометрия — источник GT-габаритов.

## Правила добора (чтобы не травить модель)

* Приоритет: промпт написан человеком (Customizer-описания, README) либо
  синтезирован, но потом перепроверен валидатором OpenSCAD + bbox-сверкой
  (наш реаудит-контур `tools/reaudit_specs_corpus.py`).
* В учебный корпус — только после `omni validate` (accepted-only) и сплита;
  GPL/AGPL-код допустим для приватного обучения, публиковать веса «как есть»
  не планировать без юридической сверки.
* Сырьё в git не разрастать: новые скачивания — архивами ≤ 10 MB или только
  манифесты (этот каталог — осознанное исключение, tar.gz ≤ 5.5 MB).
