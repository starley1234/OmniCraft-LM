# Ревью проекта целиком (ветка arena/01a10346-omnicraft-lm, 2026-10-04)

Контекст: владелец гоняет E0–E2 ([SPECS]-приёмка). Это заметка-обзор, НЕ патч:
`src/` не тронут. Все ссылки проверены по строчкам на HEAD `b942bf3e`.

## Здорово и не трогать

- **HookManager** (`src/model/hook_manager.py`): fire только на prefill
  (`seq_len>1`), строгая проверка `LLM_DIM`, decode прозрачен, поиск слоя 12
  BFS с приоритетом `language_model`/`text`.
- **Гигиена VRAM** (`src/training/trainer.py`, `tools/wsl_train*.sh`):
  seq-bucketing 128 + greedy pack `<= budget`, `empty_cache_every=25`,
  `expandable_segments:True`, per-process cap `set_per_process_memory_fraction`
  (реальное ограничение, не лог), OOM-retry per-sample БЕЗ `zero_grad`
  (задокументированный урок v6/v7, trainer.py:465-470), `[EMPTY STEP]` >= 20
  -> hard stop с подсказкой, страж мёртвого aux (coverage <50% после 20-го
  шага -> raise; pre-abort чейна <90%).
- **Данные-шлюзы**: split принимает только accepted (`tools/split_dataset.py:77-83`),
  build_corpus_v9 принимает только `*.validation.accepted.jsonl` и режет дубли
  id; валидатор: `$fn = 32;` обязателен до компиляции, comment-aware парсер,
  аналитическая сверка с provenance-хэшем генератора (`code_sha256`),
  wire-graph check.
- **Детерминизм**: seeded `random.Random(f"...:{seed}:{index}")` во всех
  генераторах; zero point с sha256-манифестом и strict-загрузкой; LoRA
  `lora_B=0` (identity); golden-тесты.
- EOS-append в обеих сборках последовательности (trainer.py:290-291,
  dataset.py) — урок v6/v7 зафиксирован кодом и тестом.

## Находки (по убыванию пользы)

### R1. Нет перемешивки; циклический курсор по порядку файла
`trainer.py:546-557`: `indices = (cursor + offset) % len(samples)`, порядок =
строки train.jsonl = `sorted(group_keys)` в `split_dataset.py:93`. Для v9:
voxel 2900x16 = 46 400 >= 45 093 (ровно один проход, "впритык"); wire
1600x16 = 25 600 = ~3.9 эпохи в ОДНОМ порядке и с ОДНИМ стилем на строку
(стиль = sha1(id), не меняется между эпохами). Следствие: wire canvas
выучивает порядок, а не геометрию — правдоподобный со-виновник стагнации
12/42. Чин: пер-эпохальная перестановка, детерминированная по seed:
`perm = sorted(range(n), key=lambda i: sha1(f"{seed}:{epoch}:{i}"))`.
Воспроизводимость (инвариант) сохраняется. Делать после E1–E2, в подготовку v12.

### R2. Ловушки дефолтов запуска (бюджет и сплит)
- dataclass `trainer.py:68` `max_tokens_per_forward=1600` (потолок машины
  ~1000, `wsl_budget_probe.sh`, преамбула `wsl_train_chain_v9.sh`);
- CLI `tools/train_spatial.py:47` default **2000**; `tools/wsl_train.sh:15`
  BUDGET=**2000** (wire -> 1200 на строке 22).
Голый `omni train ...` или `wsl_train.sh voxel 2900 16` = прогон в пустую:
OOM-цепочка и abort `[EMPTY STEP]` (trainer.py:624 прямо советует снизить
бюджет — надо снижать до запуска). Также `wsl_train.sh:16`: SPLIT_DIR по
умолчанию `splits_v6` (комментарий помнит аварию v6/v7 на старом корпусе) —
актуальный дефолт должен быть `splits_v9` (или флаг обязательным).
Это 3 правки строк в конфигах-дефолтах, конфликта с обучением не создают.

### R3. Sketch/brep/assembly: задел, а не обучаемый путь — надо честно написать
`trainer._spatial_fn` имеет ветки только wire/voxel; generic-вызов
`trainer.py:326 -> spatial_stack.py:78` кидает "layer requires raw canvas
inputs". При этом `omni.py:64` анонсирует `--layer sketch|brep|assembly`, а
12 060 sketch-строк в STATUS читаются как обучающий корпус. Fail-fast
корректен; неточна документация. Мелкая правка README/RUNBOOK.

### R4. Два механизма выбора prompt-стиля (drift-risk)
Живой: `trainer.prompt_text_for` (sha1 от id; именно его воспроизвёл
`tools/reaudit_specs_corpus.py`). Мёртвый: `dataset._pick_prompt`
(dataset.py:68-75, `keys[(index+prompt_epoch)]`) — `set_epoch` (dataset.py:64)
никем из трейнера не вызывается. Опасность: сторонний инструмент, взявший
dataset-путь, будет мерить не тот промпт, что видит обучение. Мелочь, но
или удалить, или закомментировать источник истины.

### R5. Теоретический hazard: обрезка prompt может съесть триггер
`trainer.py:286`: `[: max_prompt_tokens]` режет хвост, где лежит
`<|spatial_*|>`; без триггера hook молча не срабатывает. Сейчас безопасно
(p100 ~22 токена, лимит 256 — комментарий trainer.py:77), поэтому
низкоприоритетно. Дешёвая страховка на будущее (длинные [SPECS]+ru-промпты):
в `_pack_chunks` assert наличия id контрольного токена в каждом чанке.

### R6. 67M обучаемых параметров в voxel-expand — профиль риска
Linear 512->131 072 в VoxelCanvas ~ 67.2M параметров против LoRA-ранка 16 на
заморозке; при 45k строк и R1 (тот же порядок каждую эпоху) — ёмкость для
запоминания. Наблюдать train/val gap по aux-метрикам; при признаках
запоминания — dropout на head или заморозка части expand-слоя (не сейчас).

### R7. Встроенные генераторы дают EN-only промпты
`voxel_csg_gen.py`: `prompts={"en": ...}`; ru-покрытие привносят augment и
поставки. При написании новых wire-генераторов (задача A из NEXT_SESSION_V9)
сразу отдавать 5+ стилей incl. ru с размерами в тексте — иначе
`prompt_style=rotate` для них вырождается в no-op.

## Связка с E0–E2

- Ревью-датасет подтверждён: full-corpus reaudit — 11 кандидатов, включая
  ровно 3 известных para1-дефекта; ложных «габаритов в промпте» нет. То есть
  регресс bbox 0/42 не объясняется данными — версия «живой aux» (задача D)
  остаётся главной; E0/E2 (мининг [SPECS] != регресс геометрии) разделяют
  причины корректно.
- Перед запусками чейнов — зафиксировать R2 (бюджет/сплит в явном виде).
- R1 включить в подготовку v12, не в текущий цикл (иначе сравнимость с
  v9/v11 нарушится).
