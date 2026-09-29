#!/usr/bin/env bash
# Train a spatial layer inside WSL2. Usage: tools/wsl_train.sh [layer] [steps] [accum]
set -euo pipefail
cd "$HOME/omnicraft/repo"
source .venv/bin/activate
export HF_HUB_OFFLINE=1 TRANSFORMERS_OFFLINE=1

LAYER="${1:-voxel}"
STEPS="${2:-600}"
ACC="${3:-16}"

exec python tools/train_spatial.py \
  --layer "$LAYER" \
  --data data/processed/splits_v2/train.jsonl \
  --steps "$STEPS" --accumulate "$ACC" \
  --lr 2e-4 --save-every 100 --log-every 20
