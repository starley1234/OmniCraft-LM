# Бриф: ночной прогон v7 «с нуля» (для свежей сессии opencode)

> Одна сессия = одна задача. Этот файл — готовый бриф. Открывающий агент:
> прочти AGENTS.md → STATUS.md → этот файл. Контекст v6 — в
> `docs/TRAINING_LEDGER.md`, дальше не читай ничего, пока не понадобится.

## Цель
Полностью с-нуля перепройти чейн v6 на корпусе v6 (без изменений данных):
zero point → voxel 1360×16 → wire 675×16 → rsync → held-out eval обоих слоёв.
Зачем: воспроизводимость (см. TRAINING_LEDGER) + снять вопрос о 4136 OOM-скипах
voxel-лега v6 (см. «Открытые вопросы»).

## Предусловия (проверить за 2 минуты)
1. `python tools/omni.py status` — Processes: никаких train_spatial/wsl_train_chain
   (допустим только demo_server; если ест VRAM — `Stop-Process` по PID из
   `nvidia-smi --query-compute-apps=pid,used_memory --format=csv`).
2. `python tools/omni.py preflight --with-tests` — зелёный.
3. `python tools/save_zero_point.py --verify` — якорь цел.
4. `git status --porcelain` — чисто (freeze-теги на месте).

## Запуск (одна строка)
```powershell
wsl -d Ubuntu -- bash /mnt/c/github/OmniCraft-LM/tools/wsl_run_detached.sh "~/omnicraft/chain_v7.wrapper.log" "/mnt/c/github/OmniCraft-LM/tools/wsl_train_chain_v7.sh"
```
(wраpper должен ответить `alive after 2s: yes` — это самодиагностика запуска;
основной лог чейна: `~/omnicraft/chain_v7.log`)
Скрипт сам: проверит якорь, подождёт/потребует grids, прогонит оба лега,
зарсинчит чекпойнты обратно на Windows, сделает eval обоих слоёв
(`data/processed/eval_{voxel,wire}.jsonl`) и заархивирует лог в `runs/train_v7/`.
Ориентировочно: voxel ~10–25 мин, wire ~45–60 мин, eval ~15–25 мин (WSL).

## Пока идёт (правила)
- Править код можно (в WSL подхватится при следующем запуске скрипта).
- НЕЛЬЗЯ: pytest целиком, smoke, train/eval/bench параллельно, любые WSL-скрипты.
- Контроль вживую: `wsl -d Ubuntu -- tail -f ~/omnicraft/chain_v7.log`
  (маркер смерти — строки `step` перестают прирастать; лечение — RUNBOOK §7).

## Критерий приёмки (утро)
1. `chain_v7.log` заканчивается `ALL DONE`, оба лега `rc=0`.
2. `python tools/omni.py eval` использован не нужен — отчёты уже в
   `data/processed/eval_{voxel,wire}.jsonl`; сверить compile rate с v6-записью
   в TRAINING_LEDGER (деградация >5 п.п. = расследование, не молчок).
3. Число `[OOM] skipped` в voxel-леге: зафиксировать в журнал; если снова
   тысячи — это не отменяет приёмку, но поднимает приоритет разбора стража.
4. Внести прогон v7 в `docs/TRAINING_LEDGER.md` (строка по шаблону v6) и
   обновить STATUS.md; далее ритуал заморозки: `git tag freeze/v7`.

## Открытые вопросы (если ночной агент умеет — до запуска; иначе пропустить)
- **OOM-страж:** в v6 voxel-леге 4136 скипов чанков ~96 токенов при бюджете 1600
  (8×96=768 ≪ 1600). Гипотеза STATUS: учёт токенов стража не соответствует
  фактическому батчу. Файл: `src/training/trainer.py` (поиск `[OOM] skipped`).
  Безопасно НЕ трогать: прогон можно запускать и так (v6 прошёл, метрики приняты).
- **wire aux-всплески** (520–640 шаги, aux до 1.33): если повторятся в v7 на тех
  же шагах — это систематика данных/лосса, завести issue.
