#!/usr/bin/env bash
# Чейн v14 «с нуля»: v9-рецепт на хорошем корпусе (splits_v14), БЕЗ E3-шума.
#
# Отличия от v9:
#   * корпус — `splits_v14` (лёгкая чистка + conv-пары, см. docs/TRAIN_BRIEF_v14.md §1);
#   * пер-эпохальная seeded-перестановка в трейнере (R1) включена по умолчанию;
#   * бюджет-дефолт 1000, SPLIT_DIR обязателен;
#   * E3-флаги (specs-noise/degrade) отсутствуют — дефолты 0.0.
# Бюджет 1000 — потолок машины (tools/wsl_budget_probe.sh); eval 1024 токена.
#
# Чейн отвязывается от хост-оболочки (урок v13): запускать строго
#   setsid nohup bash tools/wsl_train_chain_v14.sh ... &
#   (внутри WSL), иначе реп хост-джоба убьёт обучение на середине.
set -uo pipefail
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"
cd "$HOME/omnicraft/repo"

V_STEP="${1:-2900}"            # voxel optimizer steps (x16 samples) — 1 эпоха;
                               # 6000-9000 = 2-3 эпохи, если позволяет время (бриф §3)
W_STEP="${2:-1600}"            # wire optimizer steps (x16 samples) — ~4 эпохи на v9-объёме
V_BUDGET="${3:-1000}"          # бюджет токенов на forward (tools/wsl_budget_probe.sh)
W_BUDGET="${4:-1000}"
SPLIT_DIR="${5:-splits_v14}"
TAG="${6:-v14}"
MIN_COVERAGE="${7:-90}"        # минимальное покрытие сеток, %
LOG="$HOME/omnicraft/chain_${TAG}.log"
WIN=/mnt/c/github/OmniCraft-LM

echo "[$(date +%T)] chain ${TAG} alive (voxel ${V_STEP}x16@${V_BUDGET}, wire ${W_STEP}x16@${W_BUDGET}, data ${SPLIT_DIR})" | tee -a "$LOG"

source .venv/bin/activate
export HF_HUB_OFFLINE=1 TRANSFORMERS_OFFLINE=1
export PYTHONIOENCODING=utf-8
# snap/AppImage OpenSCAD пишет STL в приватный /tmp, если TMPDIR не под $HOME.
export TMPDIR="$HOME/omnicraft/tmp"
mkdir -p "$TMPDIR"

if [ ! -s "data/processed/${SPLIT_DIR}/train.jsonl" ]; then
  echo "[$(date +%T)] ${SPLIT_DIR}/train.jsonl missing - build the corpus and run tools/wsl_sync.sh first" | tee -a "$LOG"
  exit 4
fi
if [ ! -s data/processed/voxel_grids.jsonl ]; then
  echo "[$(date +%T)] voxel_grids.jsonl missing - run tools/wsl_build_grids.sh ${SPLIT_DIR} first" | tee -a "$LOG"
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

# Откат ОБОИХ слоёв к zero point: v14 обязана начинаться с чистого листа.
python tools/train_spatial.py --layer voxel --rollback-only >>"$LOG" 2>&1
python tools/train_spatial.py --layer wire  --rollback-only >>"$LOG" 2>&1
echo "[$(date +%T)] rollback (voxel+wire) to zero point done" >>"$LOG"

# rc снимаем в переменную ДО любой другой команды: $(date) затирает $? .
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
