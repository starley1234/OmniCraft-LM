# Результаты обучения wire — v15r_wire_default

**Дата:** 2026-10-31 — 2026-11-01  
**Автор:** Оператор + AI-агент  
**Статус:** WIRE ЗАКРЫТ (лучший результат зафиксирован)

---

## 1. Проблема

На старте wire имел compile 16/42 (v14). Основные проблемы:
- **Z-ось:** медианная ошибка 32.7% (X: 0.1%, Y: 3.9%)
- **Масштаб:** кубический дефолт `(100,100,100)` для conv-промптов без размеров
- **Шаги:** выбор оптимального числа шагов не был подтверждён

## 2. Гипотеза и решение

**Гипотеза:** замена дефолта минера `(100,100,100)` на медиану wire-корпуса `(163, 50, 68)` улучшит bbox, особенно на conv-запросах без размеров.

**Изменения в коде:**
- `src/runtime/specs_hook.py`: добавлен `WIRE_DEFAULT_BBOX = (163.0, 49.8, 67.8)`
- `src/training/trainer.py`: degrade-путь использует canvas-специфичный дефолт
- `tests/test_specs_hook.py`: тест `test_mine_wire_default_bbox_when_no_dimensions`
- `tests/test_specs_noise.py`: тест degrade-пути обновлён под WIRE_DEFAULT_BBOX
- `tools/wsl_train_chain_v15.sh`: поддержка 5-го аргумента `--specs-degrade`

## 3. Прогоны

| Прогон | Дата | Шаги | degrade | compile | bbox ≤15% | med_err |
|:-------|:-----|:----:|:-------:|:-------:|:---------:|:-------:|
| v15r_2k | 31.10 | 2000 | 0 | 34/42 | 9/28 | 0.776 |
| **v15r_wire_default** | **31.10** | **2000** | **0** | **31/42** | **11/25** | **0.433** |
| v15r_2600 | 31.10 | 2600 | 0 | 27/42 | 7/21 | 0.610 |
| v15r_degrade | 01.11 | 2000 | 0.10 | 31/42 | 3/25 | 0.879 |

### 3.1 v15r_wire_default (2000 шагов) — лучший

```
step 2000/2000 | lm 0.0067 | aux 0.2804
compile 31/42 (74%), watertight 29/42, bbox ≤15% 11/25, med_err 0.433
```

**Улучшения относительно v15r_2k:**
- median err: **0.776 → 0.433 (−44%)**
- bbox hits: **9 → 11**
- mean err: **3.051 → 2.756**

**Конкретные улучшения bbox:**
- free_ru_07: 15.766 → 0.066 (гигантский скачок — X-ось перестала улетать)
- gen_02: 6.999 → 1.798 (Z завышение уменьшилось)
- gen_08: 5.942 → 0.933 (X-ось исправлена)
- free_en_04: 3.997 → 0.995 (Z завышение)

**Цена: compile 34→31 (−3).** Потерянные компиляции:
- gen_05, gen_06 (parser error)
- free_en_02, free_ru_08, free_ru_12 (syntax)

### 3.2 v15r_2600 (2600 шагов) — оверфиттинг

```
step 2600/2600 | lm 0.0039 | aux 0.2022
compile 27/42 (64%), watertight 27/42, bbox ≤15% 7/21, med_err 0.610
```

compile упал на 4 (dom 6→2, gen 5→4). Подтверждено: **2000 шагов оптимально**.

### 3.3 v15r_degrade (specs_degrade=0.10)

```
step 2000/2000 | lm 0.0046 | aux 0.2686
compile 31/42 (74%), watertight 30/42, bbox ≤15% 3/25, med_err 0.879
```

Degrade-путь (10% сэмплов с class=layer, bbox=WIRE_DEFAULT_BBOX) **ухудшил bbox** (11→3) без улучшения compile. Degrade для wire не рекомендуется.

## 4. Рекомендации

1. **Активные веса:** `checkpoints/wire/` = v15r_wire_default (2000 шагов, degrade=0).
2. **Минер:** использует `WIRE_DEFAULT_BBOX=(163, 50, 68)` для wire-промптов без размеров.
3. **Дальнейшее улучшение wire** не даст значимого прироста — убывающая отдача.
4. **Следующий канвас:** voxel conv scale injection / sketch / chuncked CE.

## 5. Файлы

| Файл | Описание |
|:-----|:---------|
| `checkpoints/wire/` | Лучшие веса (v15r_wire_default, 2000 шагов) |
| `data/processed/eval_wire_v15r_wire_default_step2000.jsonl` | Eval-лог лучшего прогона |
| `data/processed/eval_wire_v15r_2k_step2000.jsonl` | Eval-лог baseline |
| `runs/train_v15r_wire_default/chain_v15r_wire_default.log` | Полный лог обучения |
| `tools/analyze_bbox_wire.py` | Инструмент анализа bbox по осям |
| `tools/report_final.py` | Итоговое сравнение всех прогонов |