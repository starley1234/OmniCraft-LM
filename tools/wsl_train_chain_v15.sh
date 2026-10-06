#!/usr/bin/env bash
# Чейн v15 — wire-only: лечим единственную непройденную планку v14 (compile 16/42).
#
# Отличия от v14:
#   * корпус `splits_v15` = v14 LM-подмножество + OpenSCAD-accepted строки шести
#     новых wire-семейств (tools/build_corpus_v15.py);
#   * обучается ТОЛЬКО wire-лег; voxel-веса v14 (приёмка пройдена: 39/42, bbox 28/42)
#     не трогаются — ни отката, ни дообучения;
#   * перед откатом wire снимается снапшот чекпойнта (урок E6-a).
#
# Запуск строго отвязанно от хост-оболочки:
#   setsid nohup bash tools/wsl_train_chain_v15.sh > /dev/null 2>&1 &
set -uo pipefail
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"
cd "$HOME/omnicraft/repo"

W_STEP="${1:-2600}"            # wire optimizer steps (x16) — ~2.4 эпохи на корпусе v15
W_BUDGET="${2:-1000}"
SPLIT_DIR="${3:-splits_v15}"
TAG="${4:-v15}"
LOG="$HOME/omnicraft/chain_${TAG}.log"
WIN=/mnt/c/github/OmniCraft-LM

echo "[$(date +%T)] chain ${TAG} alive (wire ${W_STEP}x16@${W_BUDGET}, data ${SPLIT_DIR}, voxel untouched)" | tee -a "$LOG"

source .venv/bin/activate
export HF_HUB_OFFLINE=1 TRANSFORMERS_OFFLINE=1
export PYTHONIOENCODING=utf-8
export TMPDIR="$HOME/omnicraft/tmp"
mkdir -p "$TMPDIR"

if [ ! -s "data/processed/${SPLIT_DIR}/train.jsonl" ]; then
  echo "[$(date +%T)] ${SPLIT_DIR}/train.jsonl missing - build corpus v15 and run tools/wsl_sync.sh first" | tee -a "$LOG"
  exit 4
fi

python tools/save_zero_point.py --verify >>"$LOG" 2>&1 \
  || { echo "[$(date +%T)] ZERO POINT VERIFY FAILED - abort" | tee -a "$LOG"; exit 4; }

# Снапшот ПЕРЕД откатом (сценарий E6-a больше не повторяем).
python tools/snapshot_checkpoint.py --layers wire --tag "${TAG}_rollback" >>"$LOG" 2>&1
python tools/train_spatial.py --layer wire --rollback-only >>"$LOG" 2>&1
echo "[$(date +%T)] rollback (wire only) to zero point done" >>"$LOG"

echo "[$(date +%T)] wire: ${W_STEP}x16 on ${SPLIT_DIR}" >>"$LOG"
bash tools/wsl_train.sh wire "$W_STEP" 16 "$W_BUDGET" "$SPLIT_DIR" >>"$LOG" 2>&1
RC_WIRE=$?
echo "[$(date +%T)] wire done rc=${RC_WIRE}" >>"$LOG"
if [ "$RC_WIRE" -ne 0 ]; then
  echo "[$(date +%T)] WIRE LEG FAILED (rc=${RC_WIRE}) - abort chain" | tee -a "$LOG"
  exit "$RC_WIRE"
fi

rsync -a checkpoints/wire/ "$WIN/checkpoints/wire/"
echo "[$(date +%T)] rsync done" >>"$LOG"

bash tools/wsl_eval.sh wire >>"$LOG" 2>&1
RC_EVAL=$?
echo "[$(date +%T)] eval done rc=${RC_EVAL}" >>"$LOG"

mkdir -p "$WIN/runs/train_${TAG}"
cp -f "$LOG" "$WIN/runs/train_${TAG}/"
echo "[$(date +%T)] ALL DONE" | tee -a "$LOG"
