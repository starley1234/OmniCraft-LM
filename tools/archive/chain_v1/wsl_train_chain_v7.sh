#!/usr/bin/env bash
# Full v7 from-scratch overnight chain: zero-point check -> grids -> voxel epoch ->
# wire epoch -> rsync back to Windows -> held-out eval -> log archive.
# Clone of wsl_train_chain_v6.sh flow; keep parameters proven on v6 unless you
# deliberately change them (see docs/TRAINING_LEDGER.md for context).
set -uo pipefail
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"
cd "$HOME/omnicraft/repo"

V_STEP="${1:-1360}"            # voxel optimizer steps (x16 samples)
W_STEP="${2:-675}"             # wire optimizer steps (x16 samples)
V_BUDGET="${3:-1600}"          # max tokens per forward, voxel leg
W_BUDGET="${4:-1200}"          # wire codes are ~3x longer
TAG="${5:-v7}"
LOG="$HOME/omnicraft/chain_${TAG}.log"
WIN=/mnt/c/github/OmniCraft-LM

echo "[$(date +%T)] chain ${TAG} alive (voxel ${V_STEP}x16@${V_BUDGET}, wire ${W_STEP}x16@${W_BUDGET})" | tee -a "$LOG"

# Zero point must be intact before any leg starts.
source .venv/bin/activate
export HF_HUB_OFFLINE=1 TRANSFORMERS_OFFLINE=1
python tools/save_zero_point.py --verify >>"$LOG" 2>&1 \
  || { echo "[$(date +%T)] ZERO POINT VERIFY FAILED - abort" | tee -a "$LOG"; exit 4; }

# Voxel grids are a prerequisite for the voxel leg (built once per corpus).
if [ ! -s data/processed/voxel_grids.jsonl ]; then
  echo "[$(date +%T)] voxel_grids.jsonl missing - run tools/wsl_build_grids.sh first" | tee -a "$LOG"
  exit 4
fi
echo "[$(date +%T)] grids ready: $(wc -l < data/processed/voxel_grids.jsonl) rows" >>"$LOG"

echo "[$(date +%T)] voxel: ${V_STEP}x16" >>"$LOG"
bash tools/wsl_train.sh voxel "$V_STEP" 16 "$V_BUDGET" >>"$LOG" 2>&1
echo "[$(date +%T)] voxel done rc=$?" >>"$LOG"

echo "[$(date +%T)] wire: ${W_STEP}x16" >>"$LOG"
bash tools/wsl_train.sh wire "$W_STEP" 16 "$W_BUDGET" >>"$LOG" 2>&1
echo "[$(date +%T)] wire done rc=$?" >>"$LOG"

rsync -a checkpoints/voxel/ "$WIN/checkpoints/voxel/"
rsync -a checkpoints/wire/  "$WIN/checkpoints/wire/"
echo "[$(date +%T)] rsync done" >>"$LOG"

bash tools/wsl_eval.sh voxel wire >>"$LOG" 2>&1
echo "[$(date +%T)] eval done rc=$?" >>"$LOG"

mkdir -p "$WIN/runs/train_${TAG}"
cp -f "$LOG" "$WIN/runs/train_${TAG}/"
echo "[$(date +%T)] ALL DONE" | tee -a "$LOG"
