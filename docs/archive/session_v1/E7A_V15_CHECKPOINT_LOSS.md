# E7-a: чекпойнт v15 wire не сохранён — активные веса оказались v14

**Дата разбора:** 2026-10-30 · **Ветка:** `arena/01a10346-omnicraft-lm`
**Статус:** расхождение доказано; веса v15 wire на диске отсутствуют; нужен повторный прогон wire-лега.

## Что случилось

`STATUS.md` (запись от 2026-10-06) утверждает: «Активны веса step 1600 (бэкап
`checkpoints/_pre_v15_s1600/wire`)», результат v15 — **compile 34/42** на wire.
На деле `checkpoints/wire` содержит **веса v14**: тот же чекпойнт, что дал
`eval_wire_v14.jsonl` (16/42). Воспроизведение на текущем коде даёт **ровно те же
compiled-флаги 42/42**, что и v14-файл, и ни одного совпадения кода с v15-файлом.

## Доказательства

1. **Текущий прогон = v14.** `data/processed/diag_wire_scale/heldout_eval_auto.jsonl`
   (30.10, веса `checkpoints/wire`, код HEAD) против архивных eval-файлов:

   | файл | compile | совпадение compiled-флагов с 30.10 |
   |---|---|---|
   | `eval_wire_v14.jsonl` | 16/42 | **42/42** |
   | `eval_wire_v15_step1600.jsonl` | 34/42 | 22/42 |
   | `eval_wire_v15b_step2600.jsonl` | 29/42 | 25/42 |

2. **«Бэкап v15» — это бэкап v14.** sha256 файлов `checkpoints/wire`,
   `checkpoints/_pre_v15_s1600/wire` и `checkpoints/_pre_pre_v15/wire`
   совпадают побайтово (canvas `b2aff5aa…`, in `bce15cfd…`, out `c159617c…`,
   scale_mlp `0013f988…`, LoRA `f74aa9a8…`). `_pre_pre_v15` — снимок **до** v15,
   то есть «pre_v15_s1600» неотличим от «до v15».

3. **Время снимка.** `SNAPSHOT.json` в `_pre_v15_s1600/wire`: `taken_at`
   2026-10-06T10:48:43Z (13:48 МСК), при этом файлы внутри имеют mtime
   2026-10-05 00:25:40 — момент окончания v14-лега. Снимок делался по
   **Windows-зеркалу**, куда результат v15-прогона не приезжал.

4. **У v15 был свой снимок, но в WSL.** `runs/train_v15b/chain_v15b.log`, строка 4:
   `[snapshot] wire: 8 files, 20.6 MB -> checkpoints/_pre_v15b_rollback/wire`
   (13:49, то есть настоящие веса v15 step 1600), затем `rollback (wire only) to
   zero point done` и прогон B на 2600 шагов. В Windows-зеркале каталога
   `_pre_v15b_rollback` нет.

5. **Как потерялось.** После eval прогона B (17:20) «откат на step 1600» сделали
   из `_pre_v15_s1600` (v14), а не из `_pre_v15b_rollback` (v15). В 18:13
   (`mtime` каталогов `checkpoints/wire` и `wire/lora/lora_wire` в обоих
   зеркалах) прошёл `tools/wsl_sync.sh` — `rsync -a --delete` Windows → WSL:
   он записал v14-веса в WSL и **удалил** `_pre_v15b_rollback` (в Windows его
   не было). Единственная копия v15 wire исчезла.

## Почему это не поймали

- `snapshot_checkpoint.py` не записывает, **откуда** снят снимок и насколько он
  свежий: нет ни `source_dir`, ни сверки `mtime`/`trainer_state` с журналом
  обучения. Снимок «v15_s1600» формально валиден, хотя снят с v14.
- `wsl_sync.sh` синхронизирует **checkpoints в сторону WSL с `--delete`**. Для
  весов это неверное направление: во время обучения авторитет — WSL, а синк
  затирал его Windows-копией и удалял WSL-снимки.
- STATUS фиксировал намерение («бэкап снят до отката»), но не проверял, что
  снимок содержит именно новые веса. Тот же класс ошибки, что E6-a (чекпойнт
  идентифицирован неверно) и инцидент 01:42 (Windows-копия затёрта).

## Что сделано в этом разборе

- `tools/evaluate_generation.py --specs-mode auto|mined|none` +
  `src/runtime/eval_specs.py`: режим блока `[SPECS]` стал явным (раньше oracle-bbox
  подмешивался молча), результаты пишут `specs_mode`/`specs_bbox`.
- `tools/summarize_eval_modes.py` — сводка по режимам (compile, bbox ≤15 %,
  медиана «факт/эталон», вердикт «блок помогает / не влияет / мешает»).
- `tools/wsl_diag_wire_scale.sh` — прогон диагностики в WSL (отвязанно).
- `tools/wsl_sync.sh`: `checkpoints/` исключён из синка (веса — только
  WSL → Windows, `tools/wsl_pull_weights.sh`).

## Что делать дальше

1. **Восстановить веса v15 wire**: повторный wire-лег на `splits_v15`, 1600 шагов
   (рецепт `tools/wsl_train_chain_v15.sh`, без rollback обоих слоёв — voxel не
   трогаем). Ожидание: compile 30–34/42. ~1.5–2 ч.
2. Перед запуском: `omni status` (нет живого рана) → `omni preflight`.
3. После обучения: **сначала** `wsl_pull_weights.sh` (WSL → Windows, с проверкой
   sha256), **потом** eval и только затем любые правки/синки.
4. Диагностика `[SPECS]` (задача [B]) повторяется уже на восстановленных весах;
   прогон на v14-весах (30.10) остаётся как база сравнения.
