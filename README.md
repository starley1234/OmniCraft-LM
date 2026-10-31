# OmniCraft-LM

**Qwen3.5-2B с пространственными холстами: генерация OpenSCAD-кода по тексту.**

Модель учится писать 3D-детали на OpenSCAD — от болтов до ферм. Не RAG, не retrieval — чистый
in-context learning через LoRA-адаптер на слой 12: в промпт подмешивается блок `[SPECS]` с
классом, bbox и топологией, а хук инжектит вектор холста в attention backbone.

---

## Где веса (самое ценное)

| Файл | Размер | Содержание |
|---|---|---|
| `checkpoints/baseline_qwen35_2b/model.safetensors-00001-of-00001.safetensors` | **~4.2 GB** | Бэкбон Qwen3.5-2B (заморожен, не обучается) |
| `checkpoints/wire/trainer_state.json` | — | Метаданные: **v15r_2k**, step 2000, sha256 весов |
| `checkpoints/wire/canvas.pt` | **5.7 MB** | Холст wire-слоя — главный обучаемый артефакт |
| `checkpoints/wire/in_projector.pt` | 4.3 MB | Проектор «текст → холст» |
| `checkpoints/wire/out_projector.pt` | 4.0 MB | Проектор «холст → текст» |
| `checkpoints/wire/scale_mlp.pt` | 36 KB | MLP масштаба (bbox → позиция на холсте) |
| `checkpoints/wire/lora/lora_wire/adapter_model.safetensors` | **5.6 MB** | LoRA-адаптер (ранг 16) |
| `checkpoints/voxel/canvas.pt` | **270 MB** | Холст voxel-слоя (39/42 compile) |
| `checkpoints/zero_point/` | init | Начальное состояние (seed 1234) |

**Итого «софта» на слой ~20 MB.** Бэкбон 4.2 GB — тяжёлый, но замороженный.
Обучаются только projectors + scale_mlp + адаптер → **~20 MB на слой**.

---

## Производственное сжатие и инференс

Текущая архитектура:
- `Qwen3.5-2B` (4.5 GB в bf16) + canvas (5–270 MB) + LoRA (5.6 MB)
- Инференс 300 токенов: ~11 с в WSL2, ~45 с на Windows (WDDM)
- VRAM: ~10.5 GiB на 1024 токена

### Что можно сделать для продакшена

**1. Заменить бэкбон на int4-квант (главный выигрыш).**
Сейчас Qwen3.5-2B в bf16 весит 4.2 GB. В int4 (AWQ/GPTQ) — **~1.2 GB**.
Время инференса: ~3.5 с вместо 11 с. Canvas и LoRA накладываются поверх,
их квантовать не нужно (они и так маленькие).
Как: `autoawq` или `llama.cpp` для бэкбона, canvas-веса поверх.

**2. Объединить canvas + LoRA в один safetensors (v1 → v2 чекпойнта).**
Сейчас веса слоя размазаны по 5+ файлам. Склеить `canvas.pt + in_projector.pt +
out_projector.pt + scale_mlp.pt + lora/adapter_model.safetensors` в один
`wire_canvas.safetensors` (словарь `state_dict` с ключами). Итог: **один файл ~20 MB**
загружается за миллисекунды.

**3. ONNX / TensorRT для инференса.**
Экспорт backbone + spatial_stack → ONNX даёт выигрыш 2–3× по latency
на GPU. Torch-TensorRT (через `torch_tensorrt`) — до 4×. Минус: усложняется
сборка промпта (хук остаётся в Python, бэкбон — в TensorRT).

**4. Пристыковка к старшей Qwen.**
Canvas-хук привязан к слою 12, который в Qwen3.5-2B — предпоследний Mamba-слой.
Для Qwen3-7B/14B слой придётся переподобрать (`depth_ratio * N_layers`).
Проекторы (linear 512→131072) по размеру те же — порт тривиален.
Новый бэкбон даст лучшее понимание сложных промптов (сборки, многокомпонентные).
Рецепт: заменить `baseline_qwen35_2b` на старшую модель, перебить слой хука,
переобуть LoRA (canvas weights переносятся без изменений).

**5. Сжать canvas (voxel 270 MB → 5 MB).**
VoxelCanvas — dense 131072-мерный вектор. Это избыточно: у wire-слоя
canvas.pt 5.7 MB при той же размерности. Проверить, не dead code ли
в voxel-холсте. Если да — prune/quant.

### Асимптотический продакшен-пайплайн

```
вход: "фланец Ø96×10 мм" 
→ минер bbox [96,96,10]
→ [SPECS] block
→ int4-Qwen + canvas (10 MB в safetensors)
→ код OpenSCAD (~200 токенов, ~3 с)
→ OpenSCAD manifold → STL
```

---

## План следующей сессии (агентский бриф)

**Цель:** закрепить v15r_2k как релизный baseline и двинуться дальше.

### Приоритет 1: упаковка релиза

1. **Склеить веса слоя** — `tools/pack_canvas.py --layer wire --out models/wire_v15r_2k.safetensors`.
   Проверить, что `load_trained_checkpoint` умеет читать packed-формат.
2. **Квантовать бэкбон** — `tools/quantize_backbone.py --backbone checkpoints/baseline_qwen35_2b
   --bits 4 --out models/backbone_int4/`. Сравнить качество (eval compile/bbox) до и после.
3. **Заморозить контрольную точку** — `freeze/v15r_2k` уже стоит. Проверить:
   `git log --oneline freeze/v15r_2k..HEAD`.

### Приоритет 2: [B] bbox wire (9/42 → 20/42)

4. **Анализ осей** — `tools/analyze_bbox_axes.py --eval data/processed/eval_wire_v15r_2k_step2000.jsonl`
   — какая ось (X/Y/Z) систематически уходит у wire в eval. Ожидание: Z (высота фермы)
   или X (пролёт). Если одна ось — добавить auxiliary loss с осью или нормализовать данные.
5. **Скелетный bbox для минера** — `src/runtime/specs_hook.py`: если минер не нашёл
   размеры, а canvas = wire и в тексте есть упоминание фермы/рамы — выводить bbox из
   аналитического скелета (как в `wire_families_gen`). Тесты + eval.
6. **Повторное обучение** — если пункт 5 дал >1 bbox-hits, запустить wire 2000×16
   снова (дефолт уже 2000 в chain-скрипте).

### Приоритет 3: инженерный долг

7. **Resume-тренировка** — `SpatialTrainer.__init__`: уметь загружать чекпойнт шага N
   и продолжать, а не стартовать с zero_point. Ключ к итеративному обучению.
8. **Чанкованный CE** — сейчас 40% wire-строк выпадают из обучения (длиннее 1000 токенов).
   Чанковать лосс через `CrossEntropyLoss(reduction='sum') / n_chunks`.

### Метрики приёмки (Definition of Done)

- `preflight --with-tests` зелёный (151 passed)
- `wsl_pull_weights.sh` проходит sha256-верификацию
- Eval wire на checkpoint/wire: compile ≥30/42, bbox ≥10/28
- `tools/identify_checkpoint.py --layer wire` показывает v15r_2k, step 2000
- TAG `freeze/v16` в git