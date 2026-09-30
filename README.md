# OmniCraft-LM

Пространственные код-модели для CAD: **Qwen3.5-2B** (веса локально, read-only)
учится писать код **OpenSCAD** по текстовому описанию детали. Между языковой
моделью и кодом стоят **пространственные холсты** (Canvas), подключённые хуком
к слою 12: `VoxelCanvas`, `WireCanvas`, далее `Sketch/BRep/Assembly`.
Данные — синтетические (seed-детерминированные генераторы), валидация —
настоящим OpenSCAD (`--backend=manifold`). Обучение — в **WSL2** (на голом
Windows WDDM медленнее в ~5.8 раза, см. `docs/hardware-notes.md`).

Рассчитано на ИИ-агентов (см. [AGENTS.md](AGENTS.md)) и русскоязычных операторов.

## С чего начать

| Я… | Мой вход |
|---|---|
| ИИ-агент | [AGENTS.md](AGENTS.md) → [STATUS.md](STATUS.md) → `python tools/omni.py status` |
| Человек-оператор | [docs/RUNBOOK.md](docs/RUNBOOK.md) — полная инструкция |

**Единая точка входа:** `python tools/omni.py help` — самодокументируемый CLI
(status / preflight / test / gen / validate / split / train / smoke / eval / bench).
Вывод уходит в `runs/omni/*.log`, в консоль — только хвост и `OMNI_EXIT <код>`.

## Текущее состояние (v6)

Обучены и проверены слои **voxel** и **wire** (корпус 34 535 примеров).
Факты, метрики и ближайшие шаги — всегда в [STATUS.md](STATUS.md);
аудиторский след прогонов — в [docs/TRAINING_LEDGER.md](docs/TRAINING_LEDGER.md).

## Железо

Отлажено вживую на: NVIDIA GeForce RTX 5060 Ti (sm_120, 15.93 ГиБ, bfloat16)
+ OpenSCAD 2025.12.17 (manifold). Без CUDA код работает на CPU (float32) —
для тестов и генерации данных; обучение на CPU не предполагается.

## Установка

```powershell
python -m venv .venv
.venv\Scripts\Activate.ps1
# CUDA-сборку torch брать из официального селектора PyTorch; для CPU-only:
python -m pip install --index-url https://download.pytorch.org/whl/cpu "torch>=2.5"
python -m pip install -r requirements-dev.txt
```

Бэкбон скачивается один раз (зеркало `hf-mirror.com` при проблемах с CDN):
```powershell
$env:HF_ENDPOINT = "https://hf-mirror.com"
huggingface-cli download Qwen/Qwen3.5-2B --local-dir checkpoints/baseline_qwen35_2b
python tools/save_zero_point.py --seed 1234   # зафиксировать якорь отката
```

## Конвейер данных

Генерация создаёт **кандидатов**, валидация превращает их в принятый корпус:

```powershell
python tools/omni.py gen --voxel-count 1000 --wire-count 1000 --seed 1234 --output data/processed/candidates.jsonl
python tools/omni.py validate --input data/processed/candidates.jsonl --backend auto --workers 8
python tools/omni.py split --input data/processed/candidates.validation.accepted.jsonl --output-dir data/processed/splits_v6
```

Железные правила корпуса (сторожит `src/data/schema.py` и `tests/test_golden.py`):
1. Каждый `.scad` начинается со строки `$fn = 32;`.
2. Mock-валидация ≠ CAD-валидация: в обучение идут только `*.accepted.jsonl`.

## Обучение (только WSL2)

```powershell
# один слой:
wsl -d Ubuntu -- bash /mnt/c/github/OmniCraft-LM/tools/wsl_train.sh voxel 600 16
# полный чейн с нуля (ночной сценарий):
wsl -d Ubuntu -- bash /mnt/c/github/OmniCraft-LM/tools/wsl_train_chain_v7.sh
```

Каждый прогон стартует от нулевой точки и пишет артефакты в `checkpoints/<слой>/`.
Паника/откат: `python tools/train_spatial.py --layer voxel --rollback-only`.

## Оценка

```powershell
# быстрый путь — eval внутри WSL2, отчёты сразу в data/processed/eval_<слой>.jsonl:
wsl -d Ubuntu -- bash /mnt/c/github/OmniCraft-LM/tools/wsl_eval.sh voxel wire
```

Метрики: compile rate, watertight, ошибка габаритов (хорошо: bbox ≤ 15%).
Контроль без `--checkpoint` (нулевая точка) обязан давать ~0%.

## Демо (браузер)

```powershell
demo.cmd   # http://127.0.0.1:8035
```
Слева — блок `[SPECS]` + сгенерированный код, справа — вердикт manifold и
PNG-превью. Без обученного чекпойнта работает от якоря (контрольный 0%).

## Бенчмарк холстов

```powershell
python tools/omni.py bench --device cuda --batch-sizes 1 16 64 --iterations 30
```

## Структура репозитория

- `src/model/` — холсты, latent_bridge, hook_manager · `src/training/` — trainer, LoRA, чекпойнты
- `src/data/` — schema.py (контракт JSONL), генераторы · `src/env/` — CAD-раннеры
- `src/runtime/` — specs_hook ([SPECS] → хук) · `tools/` — CLI (вход: omni.py)
- `docs/` — RUNBOOK, архитектура, журнал обучения · `docs/archive/` — история поставок
- `data/`, `checkpoints/`, `runs/`, `optional_data/` — данные и артефакты (вне git)
