# OmniCraft-LM — операторская карта для агентов

**Что это:** Qwen3.5-2B (веса локально, read-only) учится писать код OpenSCAD по описанию
детали через пространственные холсты (Canvas), подключённые хуком к слою 12. Данные
синтетические (seeded-генераторы), валидация — настоящим OpenSCAD (manifold).
Обучение — в WSL2 (на голом Windows WDDM медленнее в ~5.8 раза).

**Сначала прочти STATUS.md** — что сейчас происходит и что делать дальше. И обнови его в конце задачи.

## Железные инварианты (нарушение = сломать проект)
1. Каждый `.scad` начинается со строки `$fn = 32;` (сторожат schema.py и test_golden.py).
2. Mock-валидация ≠ CAD-валидация; в обучение идут только строки `*.accepted.jsonl`.
3. `checkpoints/baseline_qwen35_2b/` — только чтение. Откат — через zero point (`train_spatial.py --rollback-only`).
4. Хук слоя 12 срабатывает только на prefill (`seq_len > 1`); на KV-кэш-шагах возвращает тензор без изменений.
5. Никаких Triton / static KV cache. CUDA = bfloat16, CPU = float32.
6. Авторитет гиперпараметров — CLI-флаги `tools/train_spatial.py`; `configs/*.yaml` — декларативная справка, код их не читает.
7. Контракт данных `[SPECS]` — ARCHITECTURE.md §8.1 (код — `src/runtime/specs_hook.py`; история — `docs/archive/AGENTS_CoG.md`). Открывать только если задача про схему/промпты/hook.
8. Веса — авторитет WSL. `tools/wsl_sync.sh` не синхронизирует `checkpoints/`; забирать
   веса в Windows только `tools/wsl_pull_weights.sh` (WSL → Windows + сверка sha256).
   Снимок чекпойнта, снятый с Windows-зеркала, может содержать старые веса — см.
   `docs/E7A_V15_CHECKPOINT_LOSS.md`.

## Команды — всё через один вход
`python tools/omni.py [--json] [--tail N] <команда> [аргументы]` — вывод уходит в
`runs/omni/*.log`, назад возвращается только хвост + строка `OMNI_EXIT <код>`.

| Команда | Что делает | Когда |
|---|---|---|
| `help` | список команд | забыл синтаксис |
| `status` | корпус/чекпойнты/процессы/git | первым делом в сессии |
| `preflight` | system_check; `+ --with-tests` | перед обучением; НЕ во время чужого рана |
| `test` | `pytest -q` (можно `omni test tests/test_golden.py`) | после правок кода |
| `gen` / `validate` / `split` | конвейер данных | по заявкам на корпус |
| `train` | обучение слоя (со стражами предусловий) | только когда ничего не крутится |
| `smoke` | 2 шага CPU end-to-end в runs/omni/smoke | регресс после правок trainer'а |
| `eval` / `bench` | оценка на held-out / бенчмарк холстов | после обучения |

**Коды выхода:** 0 ок · 2 кривой вызов · 3 preflight провален ([MISSING]) · 4 нет
предусловий (веса/zero point/файл — читай сообщение) · прочие = код скрипта
→ таблица симптомов и лечения: `docs/RUNBOOK.md` §7.

## Карта репозитория
- `src/model/` холсты, latent_bridge, hook_manager · `src/training/` trainer, LoRA, чекпойнты, aux-лоссы
- `src/data/` schema.py (контракт JSONL), dataset.py, generators/ · `src/env/` CAD-раннеры (mock/openscad/build123d)
- `src/runtime/` specs_hook, eval_specs · `src/utils/` system_check, metrics
- `tools/` CLI (omni.py — вход; остальные — его дети) · `tools/archive/` одноразовые утилиты и старые чейны
- `tests/` pytest · `docs/` актуальные документы · `docs/archive/` истории поставок и сессий
- `data/`, `checkpoints/`, `optional_data/`, `runs/` — **ДАННЫЕ: не читать, не glob'ить, не grep'ать целиком** (тысячи файлов = смерть контекста)

## Экономия контекста (обязательные приёмы)
- «Где что лежит» → explore-сабагент; файлы читать с offset/limit, не целиком.
- Логи — только хвост (`omni` режет сам; иначе `Get-Content -Tail 20`).
- Одна сессия = одна задача; бриф в первом сообщении: цель + пути + критерий приёмки.
- Перед `train` всегда: `omni status` (нет ли живого рана) → `omni preflight`.

## Пока идёт обучение (частая ситуация)
Если `omni status` показывает живой `wsl_train_chain`/`train_spatial`: править файлы
можно (в WSL синк произойдёт при следующем запуске скриптов), но НЕ запускать
pytest целиком, smoke, train, eval, bench и любые WSL-скрипты.

## Заморозка этапа (Definition of Done)
1. `python tools/omni.py preflight --with-tests` — зелёный (вне обучения).
2. `STATUS.md` обновлён (дата, факты, следующий шаг).
3. `git status` чист; `git tag freeze/<имя>`.
