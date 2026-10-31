#!/usr/bin/env bash
# Чейн v12: voxel с E3-аугментацией [SPECS] (устойчивость к неверному/чужому блоку).
#
# Отличия от v9/v11:
#   * трогаем ТОЛЬКО слой voxel; wire сохраняет текущие веса (откат — только voxel);
#   * в обучение включён E3-шум блока: specs-noise=0.30 (блок = рантайм-минер на том же
#     промпте), specs-degrade=0.10 (class=слой, bbox=100^3, канонический topology);
#   * TMPDIR уведён в $HOME: snap-OpenSCAD видит приватный /tmp, иначе STL не долетает.
# Рецепт как v9/v11: 2900x16@1000, lambda_geom по умолчанию 0.1, splits_v9_fixed.
#
# Приёмка: eval voxel bbox <=15% заметно выше чистой базы E2 (13/42), compile не ниже.
set -uo pipefail
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"
cd "$HOME/omnicraft/repo"

V_STEP="${1:-2900}"            # voxel optimizer steps (x16 samples)
V_BUDGET="${2:-1000}"          # бюджет токенов на forward
SPLIT_DIR="${3:-splits_v9_fixed}"
TAG="${4:-v12}"
NOISE="${5:-0.30}"
DEGRADE="${6:-0.10}"
MIN_COVERAGE="${7:-90}"        # минимальное покрытие сеток, %
LOG="$HOME/omnicraft/chain_${TAG}.log"
WIN=/mnt/c/github/OmniCraft-LM

echo "[$(date +%T)] chain ${TAG} alive (voxel ${V_STEP}x16@${V_BUDGET}, data ${SPLIT_DIR}, noise=${NOISE}, degrade=${DEGRADE})" | tee -a "$LOG"

source .venv/bin/activate
export HF_HUB_OFFLINE=1 TRANSFORMERS_OFFLINE=1
export TMPDIR="$HOME/omnicraft/tmp"
mkdir -p "$TMPDIR"

if [ ! -s "data/processed/${SPLIT_DIR}/train.jsonl" ]; then
  echo "[$(date +%T)] ${SPLIT_DIR}/train.jsonl missing - run tools/wsl_sync.sh first" | tee -a "$LOG"
  exit 4
fi
if [ ! -s data/processed/voxel_grids.jsonl ]; then
  echo "[$(date +%T)] voxel_grids.jsonl missing - run tools/wsl_build_grids.sh first" | tee -a "$LOG"
  exit 4
fi

# Страж мёртвого aux: покрытие сеток считается ДО запуска обучения.
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

# Только voxel: wire остаётся нетронутым.
python tools/train_spatial.py --layer voxel --rollback-only >>"$LOG" 2>&1
echo "[$(date +%T)] rollback voxel to zero point done" >>"$LOG"

echo "[$(date +%T)] voxel: ${V_STEP}x16 on ${SPLIT_DIR} (noise=${NOISE}, degrade=${DEGRADE})" >>"$LOG"
bash tools/wsl_train.sh voxel "$V_STEP" 16 "$V_BUDGET" "$SPLIT_DIR" "" "$NOISE" "$DEGRADE" >>"$LOG" 2>&1
RC_VOXEL=$?
echo "[$(date +%T)] voxel done rc=${RC_VOXEL}" >>"$LOG"
if [ "$RC_VOXEL" -ne 0 ]; then
  echo "[$(date +%T)] VOXEL LEG FAILED (rc=${RC_VOXEL}) - abort chain" | tee -a "$LOG"
  exit "$RC_VOXEL"
fi

rsync -a checkpoints/voxel/ "$WIN/checkpoints/voxel/"
echo "[$(date +%T)] rsync done" >>"$LOG"

bash tools/wsl_eval.sh voxel >>"$LOG" 2>&1
RC_EVAL=$?
echo "[$(date +%T)] eval done rc=${RC_EVAL}" >>"$LOG"

mkdir -p "$WIN/runs/train_${TAG}"
cp -f "$LOG" "$WIN/runs/train_${TAG}/"
echo "[$(date +%T)] ALL DONE" | tee -a "$LOG"
