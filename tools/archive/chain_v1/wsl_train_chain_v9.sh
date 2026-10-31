#!/usr/bin/env bash
# Чейн v9 «с нуля» на splits_v9 с ЖИВЫМ aux-лоссом воксельного слоя.
#
# Чем отличается от v8 (всё — следствие разбора v8, см. STATUS.md):
#   * сетки-GT построены на весь корпус (в v8 сайдкар покрывал 0.4% строк,
#     aux молча равнялся нулю весь прогон);
#   * перед стартом чейн проверяет покрытие сеток и падает, если оно < 90%;
#   * трейнер печатает `gt NN%` в каждой строке лога и падает после шага 20,
#     если покрытие < 50% (страж мёртвого aux).
# Бюджет токенов — 1000 (потолок машины, tools/wsl_budget_probe.sh), eval 1024 токена.
# Шаги под корпус splits_v9 (train: voxel 45 093 / wire 6 598 / sketch 9 168):
#   voxel 2900x16 ~ 1 эпоха; wire 1600x16 ~ 4 эпохи (в v8 слой wire был слабым звеном,
#   и корпус wire вырос с 3 276 до 6 598 строк за счёт поставок №5-7).
set -uo pipefail
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"
cd "$HOME/omnicraft/repo"

V_STEP="${1:-2900}"            # voxel optimizer steps (x16 samples)
W_STEP="${2:-1600}"            # wire optimizer steps (x16 samples)
V_BUDGET="${3:-1000}"          # бюджет токенов на forward (tools/wsl_budget_probe.sh)
W_BUDGET="${4:-1000}"
SPLIT_DIR="${5:-splits_v9}"
TAG="${6:-v9}"
MIN_COVERAGE="${7:-90}"        # минимальное покрытие сеток, %
LOG="$HOME/omnicraft/chain_${TAG}.log"
WIN=/mnt/c/github/OmniCraft-LM

echo "[$(date +%T)] chain ${TAG} alive (voxel ${V_STEP}x16@${V_BUDGET}, wire ${W_STEP}x16@${W_BUDGET}, data ${SPLIT_DIR})" | tee -a "$LOG"

source .venv/bin/activate
export HF_HUB_OFFLINE=1 TRANSFORMERS_OFFLINE=1

if [ ! -s "data/processed/${SPLIT_DIR}/train.jsonl" ]; then
  echo "[$(date +%T)] ${SPLIT_DIR}/train.jsonl missing - run tools/wsl_sync.sh first" | tee -a "$LOG"
  exit 4
fi
if [ ! -s data/processed/voxel_grids.jsonl ]; then
  echo "[$(date +%T)] voxel_grids.jsonl missing - run tools/wsl_build_grids.sh first" | tee -a "$LOG"
  exit 4
fi

# Страж мёртвого aux №1: покрытие сеток считается ДО запуска обучения.
COVERAGE_LINE=$(python tools/build_voxel_grids.py --coverage-only \
  --input "data/processed/${SPLIT_DIR}/train.jsonl" | tail -n 1)
echo "[$(date +%T)] grids: ${COVERAGE_LINE}" | tee -a "$LOG"
COVERAGE=$(echo "$COVERAGE_LINE" | sed -n 's/.*covered rows: [0-9]* (\([0-9]*\)\.\?[0-9]*%).*/\1/p')
if [ -z "$COVERAGE" ] || [ "$COVERAGE" -lt "$MIN_COVERAGE" ]; then
  echo "[$(date +%T)] AUX GT COVERAGE ${COVERAGE:-?}% < ${MIN_COVERAGE}% - abort (aux был бы мёртв)" | tee -a "$LOG"
  exit 4
fi

python tools/save_zero_point.py --verify >>"$LOG" 2>&1 \
  || { echo "[$(date +%T)] ZERO POINT VERIFY FAILED - abort" | tee -a "$LOG"; exit 4; }

# Откат обоих слоёв к zero point: чейн обязан начинать с чистого листа.
python tools/train_spatial.py --layer voxel --rollback-only >>"$LOG" 2>&1
python tools/train_spatial.py --layer wire  --rollback-only >>"$LOG" 2>&1
echo "[$(date +%T)] rollback to zero point done" >>"$LOG"

# ВНИМАНИЕ: rc надо снимать в переменную ДО любой другой команды. Запись вида
# echo "$(date) rc=$?" всегда печатала 0 (подстановка $(date) затирает $?).
echo "[$(date +%T)] voxel: ${V_STEP}x16 on ${SPLIT_DIR}" >>"$LOG"
bash tools/wsl_train.sh voxel "$V_STEP" 16 "$V_BUDGET" "$SPLIT_DIR" >>"$LOG" 2>&1
RC_VOXEL=$?
echo "[$(date +%T)] voxel done rc=${RC_VOXEL}" >>"$LOG"
if [ "$RC_VOXEL" -ne 0 ]; then
  echo "[$(date +%T)] VOXEL LEG FAILED (rc=${RC_VOXEL}) - abort chain" | tee -a "$LOG"
  exit "$RC_VOXEL"
fi

echo "[$(date +%T)] wire: ${W_STEP}x16 on ${SPLIT_DIR}" >>"$LOG"
bash tools/wsl_train.sh wire "$W_STEP" 16 "$W_BUDGET" "$SPLIT_DIR" >>"$LOG" 2>&1
RC_WIRE=$?
echo "[$(date +%T)] wire done rc=${RC_WIRE}" >>"$LOG"
if [ "$RC_WIRE" -ne 0 ]; then
  echo "[$(date +%T)] WIRE LEG FAILED (rc=${RC_WIRE}) - abort chain" | tee -a "$LOG"
  exit "$RC_WIRE"
fi

rsync -a checkpoints/voxel/ "$WIN/checkpoints/voxel/"
rsync -a checkpoints/wire/  "$WIN/checkpoints/wire/"
echo "[$(date +%T)] rsync done" >>"$LOG"

bash tools/wsl_eval.sh voxel wire >>"$LOG" 2>&1
RC_EVAL=$?
echo "[$(date +%T)] eval done rc=${RC_EVAL}" >>"$LOG"

mkdir -p "$WIN/runs/train_${TAG}"
cp -f "$LOG" "$WIN/runs/train_${TAG}/"
echo "[$(date +%T)] ALL DONE" | tee -a "$LOG"
