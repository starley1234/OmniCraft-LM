#!/usr/bin/env bash
# Train a spatial layer inside WSL2. Usage: tools/wsl_train.sh [layer] [steps] [accum]
set -euo pipefail
cd "$HOME/omnicraft/repo"
source .venv/bin/activate
export HF_HUB_OFFLINE=1 TRANSFORMERS_OFFLINE=1
# Фрагментация аллокатора — главный источник OOM на длинных ранах: reserved дорастает
# до потолка, и дальше падают даже чанки по ~100 токенов (v8: лег умер на шаге 242).
# expandable_segments отдаёт память обратно вместо накопления пулов на каждую длину.
export PYTORCH_CUDA_ALLOC_CONF="${PYTORCH_CUDA_ALLOC_CONF:-expandable_segments:True}"

LAYER="${1:-voxel}"
STEPS="${2:-600}"
ACC="${3:-16}"
BUDGET="${4:-2000}"   # token budget per forward; wire defaults to 1200 below
SPLIT_DIR="${5:-splits_v6}"   # ВНИМАНИЕ: путь к сплиту был захардкожен на splits_v4,
                              # из-за чего чейны v6/v7 обучались на старом корпусе.
LAMBDA_GEOM="${6:-}"   # опционально: вес aux-лосса (дефолт трейнера 0.1);
                       # 0 = aux выключен — для абляции живого aux (задача D, NEXT_SESSION_V9)

if [ "$LAYER" = "wire" ] && [ "${4:-}" = "" ]; then
  BUDGET=1200  # wire codes are ~3x longer; the PyTorch DeltaNet fallback is S-sensitive
fi

DATA="data/processed/${SPLIT_DIR}/train.jsonl"
if [ ! -s "$DATA" ]; then
  echo "train data missing: $DATA" >&2
  exit 4
fi
echo "train data: $DATA ($(wc -l < "$DATA") rows)"

VGRID_ARG=()
if [ "$LAYER" = "voxel" ] && [ -f data/processed/voxel_grids.jsonl ]; then
  VGRID_ARG=(--voxel-grids data/processed/voxel_grids.jsonl)
fi

LAMBDA_ARG=()
if [ -n "$LAMBDA_GEOM" ]; then
  LAMBDA_ARG=(--lambda-geom "$LAMBDA_GEOM")
fi

exec python tools/train_spatial.py \
  --layer "$LAYER" \
  --data "$DATA" \
  --steps "$STEPS" --accumulate "$ACC" \
  --max-tokens-per-forward "$BUDGET" \
  --lr 2e-4 --save-every 100 --log-every 20 \
  "${VGRID_ARG[@]}" "${LAMBDA_ARG[@]}"
