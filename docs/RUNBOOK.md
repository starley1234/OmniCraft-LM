# OmniCraft-LM — инструкция по запуску (для человека)

Что делает проект: учит языковую модель (Qwen3.5-2B, лежит локально) писать
код OpenSCAD по текстовому описанию детали — с «пространственным блокнотом»
(Canvas), подключённым к середине модели. Данные синтетические, проверяются
настоящим OpenSCAD, плохие отбраковываются автоматически.

Всё работает **офлайн** после первой установки. Веса модели лежат в
`checkpoints/baseline_qwen35_2b/` (4.3 GB), якорь отката — в
`checkpoints/zero_point/`.

---

## 0. Одноразовая подготовка (уже сделана на этой машине)

| Что | Где | Проверка |
|---|---|---|
| Python 3.12 + зависимости | Windows (системный python) | `python -m src.utils.system_check` |
| WSL2 + Ubuntu | включено | `wsl -l -v` |
| Python-окружение в WSL | `~/omnicraft/repo/.venv` | `wsl -d Ubuntu -- bash tools/wsl_check.sh` |
| OpenSCAD 2025.12.17 | Windows `PATH` и WSL `~/bin` | `openscad --version` |
| Веса Qwen3.5-2B | `checkpoints/baseline_qwen35_2b/` | каталог не пустой |

Если когда-нибудь на новой машине с нуля:
```powershell
# 1) веса модели — ссылки в docs/ или через зеркало:
$dest = "checkpoints/baseline_qwen35_2b"; New-Item -ItemType Directory -Force $dest
curl.exe -L -C - -o "$dest\model.safetensors-00001-of-00001.safetensors" `
  "https://hf-mirror.com/Qwen/Qwen3.5-2B/resolve/main/model.safetensors-00001-of-00001.safetensors"
# + мелкие файлы (config.json, tokenizer.json, merges.txt, ...) тем же curl
# 2) pip:  python -m pip install -r requirements-dev.txt
# 3) WSL:  wsl -d Ubuntu -- bash /mnt/c/github/OmniCraft-LM/tools/wsl_bootstrap.sh
# 4) якорь отката:  python tools/save_zero_point.py --seed 1234
```

---

## 1. Проверить, что всё живо (30 секунд)

```powershell
# Windows
python -m src.utils.system_check     # все строки [OK]
python -m pytest -q                  # 46 passed

# WSL (делает и синк кода, и тесты)
wsl -d Ubuntu -- bash /mnt/c/github/OmniCraft-LM/tools/wsl_check.sh
```

---

## 2. Данные: сгенерировать → проверить → разбить

```powershell
python tools/prepare_dataset.py --voxel-count 10000 --wire-count 10000 --seed 1234 `
  --output data/processed/candidates.jsonl

python tools/validate_dataset.py --input data/processed/candidates.jsonl `
  --backend openscad --workers 12

python tools/split_dataset.py --input data/processed/candidates.validation.accepted.jsonl `
  --output-dir data/processed/splits --group-by kind-and-dimension
```

Внешний корпус (`optional_data/`):
```powershell
python tools/import_external_scad.py --domain-expansion optional_data/data/domain_expansion.jsonl `
  --parts-dir optional_data/data/parts --fill-bbox-with-openscad --workers 8
python tools/validate_dataset.py --input data/processed/external_candidates.jsonl --backend openscad --workers 12
```

Правило: обучать можно **только на `*.accepted.jsonl`**. Provisional/mock в обучение не идут никогда.

---

## 3. Обучение

### Рекомендовано: внутри WSL2 (в ~6 раз быстрее — см. ниже «почему»)

```powershell
wsl -d Ubuntu -- bash /mnt/c/github/OmniCraft-LM/tools/wsl_train.sh voxel 600 16
wsl -d Ubuntu -- bash /mnt/c/github/OmniCraft-LM/tools/wsl_train.sh wire  550 16
```
Аргументы: `<слой> <шаги> <сэмплов_на_шаг>`. 600×16 ≈ одна эпоха voxel (~10 мин в WSL).
Лог: `~/omnicraft/*_train.log` внутри WSL; строка вида
`step 300/600 | lm 0.0012 | aux 0.0000 | 1.57 it/s | vram 4.6/10.4 GiB`
(внимание на `it/s` и на маркер `!! over the 14 GiB ceiling`).

### Запасной вариант: Windows (медленнее в ~5.8 раза)

```powershell
# процесс держит ~11 GiB VRAM; запускать ТОЛЬКО ОДИН прогон одновременно
python tools/train_spatial.py --layer voxel --steps 600 --accumulate 16 --save-every 100
```
Чтобы рабочий стол не подтормаживал: Диспетчер задач → Подробности → python.exe →
«Задать приоритет» → «Ниже среднего» — скорость почти не пострадает.

Каждый прогон **всегда стартует от нулевой точки** и пишет артефакты в
`checkpoints/<слой>/` (снимки каждые 100 шагов). Прерванный прогон ничего не портит.

---

## 4. Оценка генерации (после обучения)

```powershell
# Рекомендуемо: внутри WSL2 — в ~4-6 раз быстрее (тот же WDDM-налог);
# оба слоя, отчёты сразу в data/processed/eval_<слой>.jsonl на стороне Windows:
wsl -d Ubuntu -- bash /mnt/c/github/OmniCraft-LM/tools/wsl_eval.sh voxel wire

# Запасной путь на Windows (медленный: ~60 с на промпт, 42 промпта ≈ 40+ мин):
python tools/evaluate_generation.py --layer voxel --checkpoint checkpoints/voxel `
  --eval-set optional_data/data/heldout_eval.jsonl --max-new-tokens 384

# контроль: то же с нулевой точки (без --checkpoint) — должно быть ~0%
python tools/evaluate_generation.py --layer voxel --eval-set optional_data/data/heldout_eval.jsonl
```
Отчёт: `data/processed/eval_<слой>.jsonl` — там код каждой генерации, флаг
компиляции, watertight и ошибка габаритов. Хорошая метрика: bbox ≤ 15%.

---

## 5. Откат к заводскому состоянию (если обучение не пошло)

```powershell
python tools/train_spatial.py --layer voxel --rollback-only   # стек = якорь, LoRA = заново
python tools/save_zero_point.py --verify                      # проверка целостности якоря (SHA-256)
```
Якорь бит-в-бит восстанавливает стартовые веса холста; адаптер пересоздаётся
пустым. Бэкбон — только для чтения и не трогается никогда.

---

## 6. Забрать обученные веса из WSL обратно в Windows

```powershell
wsl -d Ubuntu -- bash -c "rsync -a ~/omnicraft/repo/checkpoints/voxel/ /mnt/c/github/OmniCraft-LM/checkpoints/voxel/"
```

---

## 7. Быстрые симптомы и лечение

| Симптом | Причина | Лечение |
|---|---|---|
| Скачивание с huggingface.co виснет на 0 байт | CDN частично блокируется | зеркало `hf-mirror.com` (команда выше), `curl -C -` докачивает |
| VRAM 15+ GB и всё вязнет без ошибки OOM | Windows WDDM молча переливает в ОЗУ | в логе строки `vram a/b GiB`; снизить `--max-tokens-per-forward`; не запускать 2 прогона сразу |
| CPU ~40%, GPU ~15% при обучении на Windows | запуск ядер по 32 мкс (WDDM) | это ожидаемо на Windows; для скорости — WSL2 (×5.8) |
| В WSL ОЗУ растёт, потом OOM в логе CUDA | длинные wire-батчи × референс-DeltaNet; VRAM переливается в ОЗУ (WSL oversubscription) | wire: `--max-tokens-per-forward 1200` (вшито в wsl_train.sh); желательно `uv pip install flash-linear-attention` |
| `CUBLAS_STATUS_EXECUTION_FAILED` на смешанном прогоне | транзиент torch 2.14+sm_120; под подозрением Triton-ядра | повторный прогон от снимка; если стабильно то же место — сообщить с шагом/логом |
| `openscad: command not found` в WSL | PATH без `~/bin` | запускать через `bash -lc` или `tools/wsl_check.sh` |
| `bad interpreter`/`$'\r'` ошибка в WSL | CRLF в .sh после чекаутa | в `.gitattributes` есть `*.sh text eol=lf`; `git checkout -- tools/` |
| Обучение «замерло» надолго без лога | смотреть `it/s` в последнем логе | if 0 → убито внешне; рестарт от последнего снимка или якоря |
| `[OOM] skipped chunk (max ~N tokens)` в логе | страж аллокатора роняет слишком жирный микробатч, не дав умереть рану | доля скипов ≤5% чанков — ожидаемо (в т.ч. транзиент на старте); больше — снизить `--max-tokens-per-forward` и/или `--microbatch`; в v6 voxel-леге было ~470 скипов на 1360 шагов (~2%) |

Подробности и обоснования: `docs/hardware-notes.md` (полевые замеры на этом железе).

---

## Шпаргалка (самое частое)

```powershell
# статус
python -m src.utils.system_check

# обучение (WSL2, основной путь)
wsl -d Ubuntu -- bash /mnt/c/github/OmniCraft-LM/tools/wsl_train.sh voxel 600 16

# оценка
python tools/evaluate_generation.py --layer voxel --checkpoint checkpoints/voxel --eval-set optional_data/data/heldout_eval.jsonl

# паника / откат
python tools/train_spatial.py --layer voxel --rollback-only
```
