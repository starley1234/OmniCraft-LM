# Журнал обучения OmniCraft-LM (Training Ledger)

> Зачем: воспроизводимость «с нуля» и аудиторский след разработки ИИ
> (документирование версий модели, данных и гиперпараметров — в русле
> требований законодательства РФ о разработке ИИ, ФЗ № 243-ФЗ).
>
> Что здесь фиксируется на каждый прогон: дата/железо, версия корпуса и seed,
> гиперпараметры, финальные метрики, контрольные суммы обученных артефактов,
> путь к сырому логу. Правило: **ни один прогон не считается состоявшимся,
> пока не внесён в этот журнал.**

## Как воспроизвести прогон с нуля
1. `python tools/omni.py preflight --with-tests` — среда и золотые тесты зелёные.
2. `python tools/save_zero_point.py --verify` — якорь цел (SHA-256).
3. Данные: генераторы seed-детерминированы (seed 1234 сторожат
   `tests/test_golden.py`); корпус версии vN восстанавливается конвейером
   `omni gen/validate/split` с теми же флагами, что в строке журнала.
4. Чейн обучения: `tools/wsl_train_chain_vN.sh` (WSL2).
5. Приёмка: `tools/wsl_eval.sh` на held-out + сверка `trainer_state.json`.

## Источники истины
| Артефакт | Где | В git? |
|---|---|---|
| Манифест прогона (конфиг, lоссы, sha256 файлов) | `checkpoints/<layer>/trainer_state.json` | нет (бинарные артефакты), хэши — здесь |
| Сырые логи чейнов | `runs/train_<vN>/*.log` | нет (`runs/` в .gitignore), на диске |
| Этот журнал | `docs/TRAINING_LEDGER.md` | **да** |
| Якорь (zero point) | `checkpoints/zero_point/` seed=1234 | нет, хэш у `save_zero_point.py --verify` |

## Записи

### v12 — 2026-10-04 02:07 → 04:28 (E3-аугментация [SPECS]; приёмка НЕ пройдена, bbox-регресс)
- **Цель:** E3 — научить модель не доверять слепо ошибочному/чужому `[SPECS]`-блоку.
  Флаги `--specs-noise 0.30` / `--specs-degrade 0.10`; сид `sha1(id:specsnoise)` (не от шага).
- **Данные:** `data/processed/splits_v9_fixed/train.jsonl`; grids-GT 44 911/44 911 (100 %).
- **Рецепт:** voxel-only 2900×16@1000, lambda_geom 0.1, остальное как v9/v11; **wire не трогался**.
  Чейн `tools/wsl_train_chain_v12.sh`, лог `runs/train_v12/chain_v12.log`.
- **Held-out (42, WSL2, greedy, 1024 токена):** voxel **42/42 compile (100 %)**, watertight
  **42/42**, **bbox ≤15 % 1/42**, медиана bbox-ошибки **4.0**. Чистая база E2 (веса v9 +
  фикс минера, `eval_voxel_v9_clean.jsonl`): 40/42, 38/42, **13/42**, медиана 0.5.
- **Вывод:** синтаксис выиграл (100 % compile), геометрия проиграла — шум блока 0.30 +
  degrade 0.10 научил модель игнорировать масштаб из `[SPECS]`; регресс по всем категориям.
  **E3 в текущем виде вреден.** Гипотезу «модель не берёт масштаб» проверять в другой форме:
  малые вероятности без degrade, либо conv-пары «безразмерный текст + дефолтный блок +
  код с GT-масштабом». Коммит E3: `74eb1f27`.
- **Веса:** активный `checkpoints/voxel` = v12 (регресс), бэкап базы = `checkpoints/voxel_v9`.
- **Приёмка НЕ пройдена** (критерий bbox заметно > 13/42).

### v9 — 2026-10-01 20:15 → 2026-10-02 01:24 (первый прогон с живым aux; приёмка НЕ пройдена)
- **Данные:** `data/processed/splits_v9/train.jsonl` (60 859 строк; корпус combined_v9 = 75 157).
  Фильтр бюджета 1000 токенов: voxel — 7 628 из 45 093 длиннее бюджета → 37 465 в обучении;
  wire — 2 725 из 6 598 → 3 873. Покрытие сеток-GT до старта: 45 093/45 093 (100%),
  9 140 уникальных программ; трейнер печатал `gt 100%` на всех шагах обоих легов.
- **Рецепт:** voxel 2900×16@1000 (финал lm 0.0288, aux 0.279), wire 1600×16@1000
  (lm 0.00502, aux 0.767), lr 2e-4, warmup 30, accum 16, microbatch 8, lora_dropout 0.05,
  lambda_geom 0.1, zero point seed 1234. Чейн `tools/wsl_train_chain_v9.sh`,
  лог `runs/train_v9/chain_v9.log`.
- **Время:** voxel 20:16–22:42 (~2 ч 26 м), wire 22:42–00:34 (~1 ч 52 м), eval 00:34–01:24.
  `[EMPTY STEP]` = 0, OOM = 0, `skipped_chunks` = 0 (все три стража чисты).
- **Held-out (42 промпта, WSL2, greedy, 1024 токена):**
  - voxel **20/42 compile (48%)**, watertight 19/20, bbox ≤15% **0/42**, медиана bbox-ошибки 1.67.
    По категориям: gen 5/8, dom 5/8, free_ru 5/12, free_en 3/8, **conv 2/6**.
  - wire **12/42 (29%)**, watertight 12/12, bbox ≤15% 2/42, медиана bbox-ошибки 0.80
    (в v8 была 1.96 — габарит wire вырос). По категориям: gen 1/8, dom 1/8, free_ru 4/12,
    free_en 2/8, conv 4/6.
- **Приёмка НЕ пройдена** (критерий: voxel ≥30/42, wire >12/42): compile voxel упал
  71% → 48%, bbox ≤15% 16/42 → 0/42; wire удержал 12/42, габарит чуть лучше.
  Чистота механики подтверждена: ALL DONE, оба лега rc=0, eval rc=0, ноль пустых шагов.
- **Классы провалов:** voxel — 14 parser/syntax, 6 «no top-level statement», 2 «empty top-level»
  (в v8 лидировали пустые вызовы — класс сместился на синтаксис); wire — 11 parser,
  17 «no top-level statement», 2 «empty top-level».
- **Гипотезы регресса (разделить задачей следующей сессии):** ложный габарит в данных
  **опровергнут** — 0 строк из 75 157 называют в промпте габарит, расходящийся с
  `target_bbox` >15% (фильтр `tools/build_corpus_v8.py::states_wrong_bbox`). Остаются:
  (а) первый прогон, где aux реально шёл (gt 100%, lambda_geom 0.1 — в v8 aux молча был ≈0),
  (б) новые поставки №5–7 (10 488 строк нового распределения). Разделение — одна абляция:
  тот же voxel-лег с `lambda_geom=0`, всё остальное без изменений.
- **SHA-256 адаптеров (trainer_state.json):**
  - voxel: scale_mlp `0635c728…`, in_projector `dc900660…`, canvas `df132035…`, out_projector `730ed145…`
  - wire: scale_mlp `bba59fac…`, in_projector `833efad4…`, canvas `eae58ea4…`, out_projector `1d078f05…`
- **Инцидент 2026-10-02 01:42 (закрыт):** локальный `train_spatial --layer voxel` с дефолтным
  конфигом (`data\processed\splits\train.jsonl`, max_steps 20) затёр Windows-копию
  `checkpoints/voxel/` нулевым состоянием (step 0, history_tail пуст) — видно по статусу:
  01:41:55 `Processes: train_spatial` → 01:43:03 `voxel@0`. Метрики eval невредимы
  (eval читал WSL-копию). Windows-копия восстановлена ресинком WSL→Windows с `--checksum`,
  манифесты сошлись бит-в-бит; биты прав `lora/adapter_model.safetensors` отличаются
  (штатный артефакт 9p/NTFS, контент идентичен).

### v10 — 2026-10-02 (абляция aux; приёмка НЕ пройдена, но гипотеза опровергнута)
- **Данные:** `data/processed/splits_v9/train.jsonl` (60 859 строк; корпус combined_v9 = 75 157).
  Фильтр бюджета 1000 токенов: 37 465 voxel-образцов в обучении.
- **Рецепт:** voxel 2900×16@1000, `lambda_geom=0` (единственная переменная против v9),
  lr 2e-4, warmup 30, accum 16, microbatch 8, lora_dropout 0.05, zero point seed 1234.
  Лог: `~/omnicraft/train_v10_voxel.log`.
- **Время:** ~02:30–07:30 (~5 ч). `[EMPTY STEP]` = 0, OOM = 0.
- **Held-out (42 промпта, WSL2, greedy, 1024 токена):**
  - voxel **20/42 compile (48%)**, watertight 19/20, bbox ≤15% **0/20**, медиана 1.75.
  - **Идентично v9** — абляция aux не изменила метрики.
- **Вывод:** живой aux-лосс **невиновен** в регрессе bbox/compile. Виноваты поставки №5–7.
- **SHA-256 адаптеров:** не сохранены (экспериментальный прогон).

### Исправление поставок №5–7 — 2026-10-02
- **Проблема:** поставки №5–7 (10 488 строк) не прошли через `build_corpus_v8.py`:
  1. Нет `target_bbox` в комментариях кода (0% против 2.3% в v8)
  2. Только 2 языка промптов (ru, en) вместо 7 в v8
  3. Нет стилей промптов (free, conv, formal)
  4. Нет `metadata.quality`
- **Исправление:** скрипт `tools/fix_supplies_v9.py`:
  1. Добавил `target_bbox` в комментарии кода (10 488 строк)
  2. Сгенерировал стили промптов (free_ru, conv_ru, free_en, conv_en) — 41 222 новых стиля
  3. Добавил `metadata.quality` для всех строк
- **Новый корпус:** `combined_v9_fixed.jsonl` (75 157 строк)
- **Новый сплит:** `splits_v9_fixed` (train 60 561 / val 9 189 / test 5 407)

### v8 — 2026-10-01 (первый прогон, где обучение действительно шло)
- **Данные:** `data/processed/splits_v8/train.jsonl` (51 968 строк; корпус combined_v8 = 64 669).
  Трейнер отсеял образцы длиннее бюджета: voxel 7 628 из 42 637, wire 475 из 3 276.
- **Рецепт:** voxel 2900×16@1000 (lm 0.59), wire 1200×16@1000 (lm 0.0103, aux 0.724),
  lr 2e-4, zero point seed 1234, `PYTORCH_CUDA_ALLOC_CONF=expandable_segments:True`.
  Чейн `tools/wsl_train_chain_v8.sh`, лог `runs/train_v8/chain_v8.log`.
- **Время:** voxel ~2 ч (10:05–11:13), wire ~1 ч 20 м (11:13–12:33), eval 30 мин. OOM-пропусков 0.
- **Held-out (42 промпта, max_new_tokens 1024):**
  - voxel **30/42 compile (71%)**, watertight 30/30, bbox ≤15% 16/42; по категориям
    dom 8/8, gen 7/8, free_en 5/8, free_ru 7/12, **conv 3/6** (в v6/v7 было 0/6).
    Медиана относительной ошибки bbox у скомпилированных — **0.0**.
  - wire **12/42 (29%)**, watertight 10, bbox ≤15% 1/42, медиана ошибки bbox 1.96.
- **Классы провалов** (вместо бесконечного повтора v7): voxel — 7 «top level object is
  empty» (модули объявлены, вызова нет) + 4 псевдо-OpenSCAD (`function` с телом модуля);
  wire — 16 синтаксис, 10 пустой объект.
- **Чем отличается от v7:** честная база v7 — 0/42 у обоих слоёв (прежние 26–33% были
  артефактом обрезки генерации на 384 токенах). Разбор шести поломок — в STATUS.md.
- **Инференс:** WSL 31–47 мс/токен, загрузка холста 11.2 с; Windows 123–159 мс/токен,
  загрузка 28.8 с (`tools/bench_generate.py`). Демо правильнее запускать в WSL.

### v6 — 2026-09-30, чейн завершён 14:56 (WSL2, RTX 5060 Ti)
- **Корпус:** combined_v6 = 34 535 (voxel 21 739 / wire 10 796 / sketch 2 000);
  сплит `data/processed/splits_v6` = 28 308 / 2 494 / 3 733; сетки: 748 → 1257 rows.
  ⚠️ **Фактические данные прогона:** `splits_v4/train.jsonl` (22 358: voxel 13 205 / wire 9 153;
  sha256 `F4C6D44A…`) — `wsl_train.sh` тогда указывал на splits_v4; прирост v6
  (voxel +4 495, sketch 1 455 train) до модели не дошёл. Путь исправлен 2026-09-30
  (аргумент 5 `SPLIT_DIR`, дефолт `splits_v6`).
- **Скрипт:** `tools/wsl_train_chain_v6.sh` (voxel 1360×16 budget 1600 → wire 675×16 budget 1200);
  `lr=2e-4`, warmup 30, microbatch 8, `lora_dropout=0.05`, `lambda_geom=0.1`, `$fn=32`.
- **Финал:** voxel lm=0.0000 aux=0.0000 (уже с ~шага 20 — корпус выучен);
  wire lm=0.002427, aux=0.08395. Сырые логи: `runs/train_v6/chain_v6.log`.
- **Held-out eval (42 промпта, WSL2, greedy, 384 токена):**
  voxel — compile 11/42, watertight 11/11, bbox ≤15% у 3/42;
  wire — compile 12/42, watertight 12/12, bbox ≤15% у 2/42.
  По категориям: conv 0/6 у обоих слоёв; масштаб теряется на free/dom
  (худшее: bbox_err 24× на free_ru_06). Отчёты: `data/processed/eval_{voxel,wire}.jsonl`.
  Вывод: syntax частично выучен, watertight идеален, **узкое место — перенос
  масштаба и покрытие разговорных/свободных формулировок**.
- **Аномалии:** voxel-лег: **4136 OOM-скипов чанков** (чаныки ~96 токенов при
  бюджете 1600 — подозрение на страж аллокатора); wire-лег: всплески lm до 0.30
  и aux до 1.33 на шагах 520–640 с последующим восстановлением.
- **SHA-256 адаптеров (из trainer_state.json):**
  - voxel: scale_mlp `15c709fb…`, in_projector `dd0751e5…`, canvas `161e881a…`, out_projector `b1a4b714…`
  - wire: scale_mlp `35bb0207…`, in_projector `8b48a098…`, canvas `5f784697…`, out_projector `d1fed986…`
- **Zero point:** `checkpoints/zero_point`, seed 1234 (нетронут).

### v4 — 2026-09-29/30 (историческая строка)
- wire/voxel ночные ретрейны; детали — git-история STATUS.md и
  `~/omnicraft/{wire_train_v4,orchestrator_v4}.log` (WSL). Переиздано в v6.

### zero point — 2026-09-2x (якорь)
- `tools/save_zero_point.py --seed 1234` → `checkpoints/zero_point/`;
  восстановление бит-в-бит: `tools/train_spatial.py --rollback-only`.
