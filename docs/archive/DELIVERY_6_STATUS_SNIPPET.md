# Блок для STATUS.md (вставить приёмщиком; STATUS.md поставкой не менялся)

- **Поставка №6 (2026-10-01)**: четыре новых корпуса, **4550 строк**, все
  `pending_openscad_manifold` — `optional_data/data/sketch3` (1250),
  `optional_data/data/wire3` (1250), `optional_data/data/solid2` (1250),
  `optional_data/data/asm3` (800 сцен / 6560 деталей). Генераторы:
  `tools/dataset_{sketch3,wire3,solid2,asm3}/`. Локальный гейт — manifold3d +
  trimesh (CLI OpenSCAD на машине генерации отсутствует); независимая
  перепроверка с диска верификаторами поставок №2/5 — 0 проблем во всех
  четырёх корпусах. Подробности: `docs/archive/DELIVERY_6.md` и
  `GENERATION_REPORT.md` в каждом каталоге. В обучение — только после прогона
  настоящим `openscad --backend=manifold` на стороне приёмщика.
