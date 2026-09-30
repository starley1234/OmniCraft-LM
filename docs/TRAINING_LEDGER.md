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
