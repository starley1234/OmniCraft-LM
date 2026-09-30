# STATUS.md — текущее состояние OmniCraft-LM

> Обновлять при каждом изменении контура (поставка, обучение, правка пайплайна).
> Читать первым в новой сессии. История — в git и docs/archive/.

**Обновлено:** 2026-09-30 · **Ветка:** `arena/01a0ec28-omnicraft-lm`

## Сейчас происходит
- Обучение v6 **завершено** 2026-09-30 (`chain_v6.log`: `[14:56:28] ALL DONE`, wire rc=0; процессов train_spatial нет).
- Чейн: grids 1257 rows → voxel 1360×16 (~13205 pretokenized) → wire 675×16. GPU свободен.
- Живой пример после обучения (2026-09-30): voxel@1360, фланец по RU-промпту → manifold OK, watertight, bbox в допуске 15%; артефакт `runs/omni/eval_demo_voxel.jsonl`.
- Осталось: сверка rsync WSL→Windows → `omni preflight --with-tests` → заморозка `freeze/v6`.

## Зафиксированные факты
| Что | Значение |
|---|---|
| Корпус | **combined_v6 = 34 535**: voxel 21 739 / wire 10 796 / sketch 2 000 |
| Сплит | train 28 308 / val 2 494 / test 3 733 (`data/processed/splits_v6`) |
| Grid builder | 748 воксельных сеток, дедупликация по content-hash |
| Чекпойнты (Windows-mirror) | `zero_point` есть; voxel@1360 (lm→0.0), wire@675 (lm 0.0024, aux 0.084) |
| Железо | RTX 5060 Ti, sm_120, 15.9 GiB, bf16; OpenSCAD 2025.12.17 + manifold |
| Тесты | 46 базовых + 4 golden (хэши генераторов, seed 1234) |
| Поставки корпусов | №1–4 приняты (place1: 2070/2070 manifold-CLI, 100% consistency) |
| Заявка №5 | wire2/sketch2/asm2 — выдана (docs/archive/DATASET_REQUEST_5.md) |

## Операционный слой (для маленькой модели и человека)
- `python tools/omni.py help` — единая точка входа (check/status/test/gen/validate/split/train/smoke/eval/preflight), вывод — только хвост, полный лог в `runs/omni/`.
- Коды выхода omni: 0 ок · 2 usage · 3 preflight · 4 нет предусловий · прочие = код скрипта (лечение — RUNBOOK §7).
- `python tools/status.py --json` — машиночитаемый снимок состояния.
- `tests/test_golden.py` сторожит детерминизм генераторов; намеренное изменение → `python tools/update_golden.py`.

## Следующие шаги (по приоритету)
1. Сверить rsync WSL→Windows (`checkpoints/<layer>/`, RUNBOOK §6) и переснять `omni status`.
2. `omni preflight --with-tests` — полный зелёный прогон (GPU свободен).
3. Полный `omni eval` voxel и wire на held-out (RUNBOOK §4).
4. Ритуал заморозки: чистый `git status` → `git tag freeze/v6`.
5. Разобрать 470 OOM-скипнутых чанков voxel-лега v6 (маркер `[OOM] skipped chunk` — вероятно, занижен `--max-tokens-per-forward` для коротких чанков).

## Не синхронизировано
- Windows `checkpoints/` отстаёт от WSL до rsync; веса текущего v6-рана живут в `~/omnicraft/repo/checkpoints/`.
