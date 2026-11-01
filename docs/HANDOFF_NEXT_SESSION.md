# Handoff — следующая сессия

**Дата:** 2026-11-01  
**Ветка:** `main`  
**Предыдущая сессия:** wire закрыт, 4 прогона завершены

---

## Краткий статус

| Слой | compile | bbox | Статус |
|:-----|:-------:|:----:|:-------|
| **Voxel** | 39/42 | 28/42 | ✅ Принят (v14, 2026-10-05) |
| **Wire** | **31/42** | **11/25** | ✅ **Закрыт** (v15r_wire_default, med_err 0.433) |
| Sketch | — | — | 🟡 Корпус есть (12 060 строк), нет обученного канваса |
| BRep/Assembly | — | — | 🔴 Не начинали |

## Ключевые изменения кода

### Добавлено (эта сессия, 2026-10-31 → 2026-11-01)

| Файл | Изменение |
|:-----|:----------|
| `src/runtime/specs_hook.py` | `WIRE_DEFAULT_BBOX = (163.0, 49.8, 67.8)` — замена кубического дефолта для wire |
| `src/training/trainer.py` | degrade-путь использует `WIRE_DEFAULT_BBOX` для wire (canvas-специфичный) |
| `tools/wsl_train_chain_v15.sh` | 5-й аргумент `W_DEGRADE` для `--specs-degrade` |
| `tests/test_specs_hook.py` | +1 тест `test_mine_wire_default_bbox_when_no_dimensions` (17→17 tests) |
| `tests/test_specs_noise.py` | обновлён тест degrade-пути (42→42 tests) |
| `tools/analyze_bbox_wire.py` | Анализ bbox wire по осям (Z-ось доминирует) |
| `docs/WIRE_TRAINING_RESULTS.md` | Итоговый отчёт по wire |
| `STATUS.md` | Обновлён |

### Загрузка кода в WSL
```bash
rsync -a --checksum --exclude='__pycache__/' --exclude='.git/' \
  --exclude='checkpoints/' --exclude='data/' --exclude='runs/' \
  --exclude='optional_data/' --exclude='.venv/' \
  /mnt/c/github/OmniCraft-LM/ ~/omnicraft/repo/
```

## Рецепт обучения wire (лучший)

```
bash tools/wsl_train_chain_v15.sh 2000 1000 splits_v15 v15r_wire_default
# specs_degrade=0 по умолчанию — НЕ МЕНЯТЬ, degrade ухудшает bbox
```

Параметры: `W_STEP=2000`, `BUDGET=1000`, `splits_v15`, `degrade=0`, `TAG=v15r_wire_default`.
Время: ~2.2 ч на RTX 5060 Ti.

## Веса

| Слой | Где | Версия |
|:-----|:----|:-------|
| Voxel | `checkpoints/voxel/` | v14 (39/42 compile, 28/42 bbox) |
| **Wire** | `checkpoints/wire/` | **v15r_wire_default (31/42, 11/25 bbox)** |
| Zero point | `checkpoints/zero_point/` | seed=1234 |

Синхронизация WSL→Windows:
```bash
rsync -a ~/omnicraft/repo/checkpoints/wire/ /mnt/c/github/OmniCraft-LM/checkpoints/wire/
# или
bash tools/wsl_pull_weights.sh
```

## План на следующую сессию

### Приоритет 1: Conv-метрика для bbox

**Проблема:** у 12 held-out conv-строк (conv_01–06, conv_gt_01–08) нет `expected_bbox_mm` в основном eval-наборе. Bbox измерим только в oracle-режиме. Conv-масштаб неверифицируем.

**Что делать:**
1. Расширить `optional_data/data/heldout_conv_gt.jsonl` — добавить 12+ conv-строк с `expected_bbox_mm` (voxel + wire)
2. Или адаптировать `evaluate_generation.py` чтобы оценка bbox работала через `[SPECS]` block oracle
3. Связать с `summarize_eval_modes.py` для автоматической отчётности

### Приоритет 2: Voxel conv scale injection

**Проблема:** conv voxel 6/6 compile, но bbox не измерим. В v14 voxel-conv bbox был померян на `heldout_conv_gt.jsonl` и показал oracle 1.08 vs mined 2.30 «факт/эталон» — канал масштаба живой, но габарит мимо порога.

**Что делать:**
1. Прогнать eval voxel на `heldout_conv_gt.jsonl` с `--specs-mode mined` и `--specs-mode auto`
2. Сравнить bbox в двух режимах — ответить на вопрос: «прокидывается ли масштаб из `[SPECS]`?»

### Приоритет 3: Чанкованный CE

**Проблема:** 7011/17587 (40%) wire-строк длиннее бюджета 1000 токенов (самая длинная 2131 токен). Они исключены из обучения.

**Что делать:**
1. Увеличить бюджет до 1200 (проверить OOM через `wsl_budget_probe.sh`)
2. Или реализовать чанкованный CE-лосс (как aux — обрабатывать длинные строки по частям)
3. Привязать к `BudgetTracker` в trainer'е

### Приоритет 4: Resume при CUDA error

**Проблема:** при `CUDA error: unknown error` цепной скрипт падает и теряет прогресс.

**Что делать:**
1. `trainer.py`: сохранять `trainer_state.json` с номером шага после каждого чекпойнта
2. `wsl_train_chain_v15.sh`: проверять наличие чекпойнта и перезапускать с последнего шага (вместо rollback)
3. Ограничение: >1 перезапуск должен быть запрещён (защита от бесконечных циклов)

## Тесты

Перед коммитом:
```bash
python tools/omni.py preflight --with-tests
python -m pytest tests/test_specs_hook.py tests/test_eval_specs.py tests/test_specs_noise.py -v
```

42/42 тестов зелёные.

## Заморозка

```bash
git tag freeze/v15r_wire_default
```

## Ограничения

- Все eval/обучение — в WSL2 (`wsl_eval.sh`, `wsl_train_chain_v15.sh`)
- CUDA bfloat16, CPU float32
- Никаких Triton / static KV cache
- Хук слоя 12 только на prefill (seq_len > 1)