# VALIDATION REQUIRED — корпус ещё НЕ принят

Статус: **pending_openscad_manifold**

Этот корпус сгенерирован 2026-10-01 16:27 UTC агентом-генератором и прошёл только
**локальный гейт** на ядре manifold3d (то же ядро, которое OpenSCAD использует
с `--backend=manifold`). Настоящим CLI OpenSCAD он **не прогонялся**:
на машине генерации OpenSCAD отсутствует.

Каждая строка `manifest.jsonl` несёт `"validation_status": "pending_openscad_manifold"`.

## Что обязан сделать приёмщик до принятия в обучение

```bash
# 1. целостность поставки
python tools/verify_delivery.py optional_data/data/scale1

# 2. независимый аудит генератора (без OpenSCAD)
python tools/dataset_scale1/verify_scale1.py --parts-dir optional_data/data/scale1

# 3. импорт в каноническую схему (кандидаты, НЕ принятые строки)
python tools/import_external_scad.py --parts-dir optional_data/data/scale1 \
    --output data/processed/scale1_candidates.jsonl

# 4. CAD-валидация настоящим OpenSCAD (только её результат легитимен)
python tools/validate_dataset.py --input data/processed/scale1_candidates.jsonl \
    --backend openscad --workers 4
```

В обучение идут только строки из `*.validation.accepted.jsonl`
(инвариант №2 AGENTS.md: mock-валидация ≠ CAD-валидация).
