#!/usr/bin/env bash
# Train a spatial layer inside WSL2. Usage: tools/wsl_train.sh [layer] [steps] [accum]
set -euo pipefail
cd "$HOME/omnicraft/repo"
source .venv/bin/activate
export HF_HUB_OFFLINE=1 TRANSFORMERS_OFFLINE=1

LAYER="${1:-voxel}"
STEPS="${2:-600}"
ACC="${3:-16}"
BUDGET="${4:-2000}"   # token budget per forward; wire defaults to 1200 below

if [ "$LAYER" = "wire" ] && [ "${4:-}" = "" ]; then
  BUDGET=1200  # wire codes are ~3x longer; the PyTorch DeltaNet fallback is S-sensitive
fi

exec python tools/train_spatial.py \
  --layer "$LAYER" \
  --data data/processed/splits_v2/train.jsonl \
  --steps "$STEPS" --accumulate "$ACC" \
  --max-tokens-per-forward "$BUDGET" \
  --lr 2e-4 --save-every 100 --log-every 20
