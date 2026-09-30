# STATUS.md — текущее состояние OmniCraft-LM

> Обновлять при каждом изменении контура (поставка, обучение, правка пайплайна).
> Читать первым в новой сессии. История — в git и docs/archive/.

**Обновлено:** 2026-09-30 · **Ветка:** `arena/01a0ec28-omnicraft-lm`

## Сейчас происходит
- **Идёт большое обучение v6 в WSL2** (`wsl_train_chain`, detached-раннер; логи `~/omnicraft/*_train.log` внутри WSL).
- Пока идёт: править файлы можно (синк в WSL случится при следующем запуске скриптов), но **не запускать** pytest целиком / smoke / train / eval / bench / WSL-скрипты.
- По завершении: забрать чекпойнты rsync (RUNBOOK §6) → eval (§4) → ритуал заморозки (AGENTS.md).

## Зафиксированные факты
| Что | Значение |
|---|---|
| Корпус | **combined_v6 = 34 535**: voxel 21 739 / wire 10 796 / sketch 2 000 |
| Сплит | train 28 308 / val 2 494 / test 3 733 (`data/processed/splits_v6`) |
| Grid builder | 748 воксельных сеток, дедупликация по content-hash |
| Чекпойнты (Windows-mirror) | `zero_point` есть; voxel@600 (lm→0.0), wire@550 (lm 0.0028) |
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
1. Дождаться конца v6-чейна → rsync чекпойнтов → `omni eval` (heldout_eval.jsonl).
2. `omni preflight --with-tests` — полный зелёный прогон вне обучения.
3. Ритуал заморозки: чистый `git status` → `git tag freeze/v6`.
4. Приёмка корпусов заявки №5 через `omni validate --backend openscad`.
5. `omni smoke` как обязательный регресс после любых правок `src/training/`.

## Не синхронизировано
- Windows `checkpoints/` отстаёт от WSL до rsync; веса текущего v6-рана живут в `~/omnicraft/repo/checkpoints/`.
