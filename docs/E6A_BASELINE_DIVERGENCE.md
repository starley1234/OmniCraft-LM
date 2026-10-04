# E6-a — расхождение базы eval v9: разбор и причина

**Дата:** 2026-10-04 (сессия с GPU) · **Ветка:** `arena/01a10346-omnicraft-lm`
**Вопрос:** почему `eval_voxel_v9_clean.jsonl` (E2: compile 40/42, bbox ≤15 % 13/42,
медиана 0.475) не воспроизводится текущим кодом на весах v9
(`eval_voxel_v9_current.jsonl`: 39/42, 5/42, медиана 1.083)?

**Ответ (кратко):** это **не расхождение кода**. База E2 снята **не на весах v9**, а на
последнем чекпойнте, который к тому моменту лежал в `checkpoints/voxel` — модели **v11**
(рецепт v9 на «исправленном» корпусе `splits_v9_fixed`). Ярлык «v9» — ошибка идентификации
чекпойнта. Артефакты v11 уничтожены безусловным `--rollback-only` в начале чейна v12.

---

## 1. Что установлено эмпирически (на этой машине, WSL2, RTX 5060 Ti)

1. **Текущий код + активные веса детерминированны и воспроизводят «current».**
   Прогон `evaluate_generation.py --checkpoint checkpoints/voxel --limit 5` дал
   `bbox_err` и **побайтово те же коды**, что в `eval_voxel_v9_current.jsonl`
   (gen_01 2.8166…, gen_02 0.35, gen_03 0.3960…, gen_04 1.1786…, gen_05 2.6875).
   → текущий контур самосогласован; `current` — честная воспроизводимая база.

2. **Активные веса — ровно v9 из журнала.** `checkpoints/voxel` (и `voxel_v9_keep`,
   и `~/omnicraft/v9_backup/voxel_v9`) дают sha256
   `scale_mlp 0635c728…`, `in_projector dc900660…`, `canvas df132035…`,
   `out_projector 730ed145…` — совпадают с `docs/TRAINING_LEDGER.md` (v9) и с
   `trainer_state.json` (step 2900, data `splits_v9/train.jsonl`).

3. **Код eval-пути между E2-коммитом и HEAD не менялся.** `git diff 333acf27..HEAD`
   показывает изменения только в `trainer.py`, `system_check.py`, `train_spatial.py`,
   `wsl_{train,eval}.sh` (+ новые файлы). `evaluate_generation.py`, `specs_hook.py`,
   `src/model/**`, `src/data/**` — **те же**. Из них на генерацию влияет только
   `trainer.py`, и только ветка E3-аугментации; при `specs_noise=specs_degrade=0`
   `specs_for_sample()` возвращает ровно прежний `compose_specs(object_class=origin,
   bbox=target_bbox, canvas=layer)`.

4. **Прямая проверка «код эпохи E2»:** подменили `src/training/trainer.py` на версию из
   `333acf27` (остальной репозиторий = HEAD), прогнали eval `--limit 5` против тех же
   весов. Результат — **побайтово те же коды**, что «current» (5/5). Затем файл
   восстановлен (sha `fa0ca3e2…`). → версия кода не является причиной.

5. **Следствие:** раз текущий код на v9 детерминированно даёт «current», а E2-код на v9
   даёт «current», то файл E2 получен **не на v9**. Остаётся только вес чекпойнта.

## 2. Каким был чекпойнт в момент E2

Таймлайн `checkpoints/voxel` (WSL), из логов и mtime:

| время (+03) | событие | чекпойнт в `checkpoints/voxel` |
|---|---|---|
| 2026-10-01 20:15–22:42 | обучение v9 (voxel-лег) | **v9** (`0635c728…`) |
| 2026-10-02 ~07:30 | завершён **v10** (`~/omnicraft/train_v10_voxel.log`, финал: `Saved trained artifacts to checkpoints/voxel`) | v10 |
| 2026-10-02 15:53 | завершён **v11** (`~/omnicraft/train_v11_voxel.log`, `data splits_v9_fixed`, `Saved trained artifacts to checkpoints/voxel`) | **v11** |
| 2026-10-02 21:13 | `eval_voxel_v9_contaminated.jsonl` (старый минер, `class=freeform`, 0/42) | v11 (не менялся) |
| **2026-10-04 01:41–01:57** | **E2** — «чистый eval v9» (`~/omnicraft/e2_voxel.log`), 40/42 · 13/42 | **v11** (не менялся) |
| 2026-10-04 02:08 | `chain_v12.log`: `Rolled back to the zero point and saved the clean state to checkpoints/voxel` | zero point (v11 **уничтожен**) |
| 2026-10-04 02:07–04:28 | обучение v12 (E3-шум) | v12 |
| 2026-10-04 ~09:5x | восстановлен истинный v9 из `v9_backup/voxel_v9` → свежая база | v9 (mtime 10-01 22:42, sha `0635c728…`) |
| 2026-10-04 09:51–10:13 | `eval_v9base_wsl.log` = `eval_voxel_v9_current.jsonl`, 39/42 · 5/42 | v9 |
| 2026-10-04 11:56–14:18 | v13 | `voxel_v13_clean`, активный откатан на v9 |

Между 2026-10-02 15:53 и 2026-10-04 02:08 `checkpoints/voxel` никто не перезаписывал,
поэтому E2 и «contaminated» измеряли **один и тот же чекпойнт** — v11. Первый чистый eval
v11 — это и есть E2 (40/42 · 13/42); «contaminated» (v11 + старый минер) — 0/42.

`v11` обучался на `splits_v9_fixed` — то есть на **«исправленных» данных** (поставки №5–7
+ стили + `target_bbox`), ровно то, что v14 пытается воспроизвести. Отсюда и лучший bbox
(13/42 против 5/42 у истинного v9).

## 3. Почему артефакты v11 не удалось перепроверить побайтово

`wsl_train_chain_v12.sh` начинается с безусловного
`train_spatial.py --layer voxel --rollback-only`, который пишет zero point в
`checkpoints/voxel` до какого-либо бэкапа. Ни `voxel_v11`, ни «pre-v12» копии не осталось
(на диске только `voxel` v9, `voxel_v9_keep`, `voxel_v12`, `voxel_v13_clean`,
`v9_backup/voxel_v9`). Прямой сверки v11-весов больше нет — вывод опирается на
п. 1–5 выше (детерминизм + неизменность eval-кода + таймлайн чекпойнтов) и на то, что
`v10` (абляция aux) до фикса минера давала метрики, идентичные v9, а не E2.

## 4. Последствия для v14

- **Сравнение с E2-файлом нечестно** (это v11). Порог приёмки §4 брифа — против
  *свежей* базы v9 (`eval_voxel_v9_current.jsonl`: 39/42 compile, bbox 5/42, медиана 1.083),
  что и записано в `STATUS.md` как эталон.
- Полезный побочный факт: **v11 на `splits_v9_fixed` уже давал bbox 13/42 при compile
  40/42** — это «планка хороших данных» для v14, а не аномалия кода. Цель v14
  (bbox ≥ 20/42, медиана < 0.5, conv ≥ 3/6) на этом фоне осмысленна.
- На будущее (защита от повторения): чейн **не должен** уничтожать текущий чекпойнт
  безусловным rollback — минимум снапшот `checkpoints/<layer>` в
  `checkpoints/<layer>_pre<tag>` перед откатом. Вынесено в отчёт/STATUS как рекомендация
  (в код не внесено в этой задаче).

## 5. Как воспроизвести разбор

```bash
# истинный v9 = активные веса
sha256sum checkpoints/voxel/*.pt           # scale_mlp 0635c728… и т.д.
# current база воспроизводится побайтово:
python tools/evaluate_generation.py --layer voxel --checkpoint checkpoints/voxel \
  --eval-set optional_data/data/heldout_eval.jsonl --max-new-tokens 1024 --limit 5 \
  --output /tmp/repro.jsonl                 # bbox_err = значениям eval_voxel_v9_current.jsonl
# E2-код (trainer.py из 333acf27) даёт тот же результат:
git show 333acf27:src/training/trainer.py > /tmp/trainer_E2.py   # затем подменить и прогнать
```
