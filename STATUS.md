# STATUS.md — текущее состояние OmniCraft-LM

> Обновлять при каждом изменении контура (поставка, обучение, правка пайплайна).
> Читать первым в новой сессии. История — в git и docs/archive/.

**Обновлено:** 2026-09-30 · **Ветка:** `arena/01a0ec28-omnicraft-lm`

## Сейчас происходит
- **ИДЁТ ночной прогон v7 «с нуля»** (запущен 2026-09-30 ~23:12, WSL2, pid-обёртка `wsl_run_detached.sh`).
  Лог: `~/omnicraft/chain_v7.log` (обёртка: `chain_v7.wrapper.log`). Предусловия из `docs/NIGHT_RUN_V7.md`
  все 4 зелёные (status idle, preflight --with-tests ok, zero point intact, git clean).
  Voxel-лег идёт ~1.6 it/s, lm=0.0 с 20-го шага (как в v6); OOM-скипы воспроизводятся (~230 к шагу 120).
  Пока идёт — НЕ запускать pytest целиком/smoke/train/eval/bench и WSL-скрипты.
- Обучение v6 **завершено и оценено**. Чейн: voxel 1360×16 → wire 675×16 (WSL2, rc=0).
- Полный held-out eval (42 промпта, WSL2): **voxel 26% compile / bbox 3/42 · wire 29% / bbox 2/42**,
  watertight 23/23 (100% среди скомпилированных). Отчёты: `data/processed/eval_{voxel,wire}.jsonl`.
- GPU свободен (633 МиБ; демо-сервер, державший 10.5 ГиБ, остановлен 2026-09-30).
- Rsync WSL→Windows сверен по чексуммам: контент идентичен (различаются только биты прав 9p/NTFS).
- Заморозка этапа: `freeze/v6` (см. git).
- **Ночной прогон «с нуля» подготовлен**: бриф `docs/NIGHT_RUN_V7.md`, чейн `tools/wsl_train_chain_v7.sh`.

## Главные выводы v6 (что чиним дальше)
1. **Voxel-лег выучил корпус к ~шагу 20** (lm=0.0000 дальше весь ран) — синтетика слишком
   шаблонна: ёмкости хватает, не хватает разнообразия формулировок/масштабов.
2. **Scale-инъекция слабо переносится**: bbox_err 2.8×–24× на free/dom-категориях;
   conv-промпты (6/42) не компилируются вообще у обоих слоёв — в корпусе нет таких формулировок.
3. voxel-лег: **4136 [OOM]-скипов чанков ~96 токенов при бюджете 1600** (ранее в статусе
   стояло «470» — это была заниженная оценка). Страж аллокатора считает не то, что батчит — разобрать.
4. wire-лег: всплески lm до 0.30 / aux до 1.33 на шагах 520–640 с восстановлением; финал стабилен.
5. Инвариант дня: когда код парсится — геометрия здоровая (watertight 100%). Проблема — именно
   перенос (prompt diversity + scale), не manifold.

## Зафиксированные факты
| Что | Значение |
|---|---|
| Корпус | **combined_v6 = 34 535**: voxel 21 739 / wire 10 796 / sketch 2 000 |
| Сплит (на диске) | `splits_v6`: train 28 308 (voxel 17 700 / wire 9 153 / sketch 1 455) / val 2 494 / test 3 733 |
| Сплит (факт обучения v6 и v7!) | **splits_v4: 22 358 train-строк (voxel 13 205 / wire 9 153, sketch=0)** — `wsl_train.sh` до 2026-09-30 ночи указывал на него |
| Grid builder | 748 воксельных сеток, дедупликация по content-hash |
| Чекпойнты (в синхроне WSL↔Windows) | `zero_point` (seed 1234); voxel@1360 (lm=0.0); wire@675 (lm 0.0024, aux 0.084) |
| Железо | RTX 5060 Ti, sm_120, 15.9 GiB, bf16; OpenSCAD 2025.12.17 + manifold |
| Тесты | 58 зелёных (46 базовых + 4 golden + прочие), `preflight --with-tests` зелёный 2026-09-30 |
| Eval-скорость | WSL2 ~14 с/промпт vs Windows ~60 с/промпт (WDDM); eval → `tools/wsl_eval.sh` |
| Поставки корпусов | №1–4 приняты (place1: 2070/2070 manifold-CLI, 100% consistency) |
| Заявка №5 | wire2/sketch2/asm2 — выдана (docs/archive/DATASET_REQUEST_5.md) |
| Журнал обучения | `docs/TRAINING_LEDGER.md` (в git) — строка на прогон, хэши, ссылки на логи |

## Операционный слой (для маленькой модели и человека)
- `python tools/omni.py help` — единая точка входа (check/status/test/gen/validate/split/train/smoke/eval/preflight).
- Коды выхода omni: 0 ок · 2 usage · 3 preflight · 4 нет предусловий · прочие = код скрипта (лечение — RUNBOOK §7).
- `python tools/status.py --json` — машиночитаемый снимок состояния.
- **2026-09-30:** детект процессов в `status.py` честный: pgrep-братчик `[t]rain_spatial`+
  (иначе паттерн матчил собственную обёртку bash и вечно рисовал живые train_spatial/wsl_train_chain);
  добавлен ключ `evaluate_generation` (WSL-eval теперь виден в статусе).
- `tests/test_golden.py` сторожит детерминизм генераторов; намеренное изменение → `python tools/update_golden.py`.
- Eval/обучение — в WSL2 (`tools/wsl_eval.sh`, `tools/wsl_train*.sh`); Windows-путь остаётся запасным.

## Следующие шаги (по приоритету)
1. **Ночной прогон v7 «с нуля»** в новой сессии — бриф `docs/NIGHT_RUN_V7.md` (предусловия, команда, приёмка).
2. Разобрать страж OOM: 4136 скипов voxel-лега v6 (чанк 8×96 токенов при бюджете 1600). Файл: `src/training/trainer.py`.
3. Заявка №6: **промптовое разнообразие выполнено самостоятельно** (процедурно, без LLM):
   `tools/augment_prompts.py` + `src/data/generators/prompt_augment.py`; артефакт
   `data/processed/combined_v6_augmented.jsonl` — 192 671 строка (5 стилей на gen-строку,
   4 на импортную), валидировано CADSample на каждой строке, сплит не течёт (kind+bbox).
   Осталось в заявке: покрытие масштабов (края диапазона bbox), hard-случаи из провалов eval.
4. После v7: сравнить с записью v6 в `docs/TRAINING_LEDGER.md`, тег `freeze/v7`.

## Реорганизация 2026-09-30 (без изменения кода-модели)
- `AGENTS_CoG.md` → `docs/archive/`; действующий контракт [SPECS] теперь в ARCHITECTURE.md §8.1
  (агентоведение: `src/runtime/specs_hook.py`). AGENTS.md обновлён.
- Одноразовые WSL-спасалки (retrain_v4, fix_and_restart, probe*, salvage/diag_grids, bootstrap2) → `tools/archive/`.
- `configs/*.yaml`: добавлены указатели на `trainer_state.json` как авторитет фактических прогонов;
  расхождение lora.dropout (0.0→0.05) исправлено под CLI-дефолт.
- README.md — на русском, под агентов+операторов; добавлен журнал обучения.
