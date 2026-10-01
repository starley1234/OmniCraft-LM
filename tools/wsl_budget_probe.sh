#!/usr/bin/env bash
# Подбор безопасного --max-tokens-per-forward: несколько коротких прогонов подряд,
# в выводе остаются только строки шагов и счётчик OOM-пропусков.
# Причина: при словаре 248k CE-логиты доминируют в памяти, и слишком большой бюджет
# превращает обучение в сплошные пропуски чанков (lm печатается как 0.0000).
# Usage: tools/wsl_budget_probe.sh [layer] [budget...]
set -uo pipefail
cd "$HOME/omnicraft/repo"
source .venv/bin/activate
export HF_HUB_OFFLINE=1 TRANSFORMERS_OFFLINE=1

LAYER="${1:-voxel}"
shift || true
BUDGETS=("$@")
if [ "${#BUDGETS[@]}" -eq 0 ]; then BUDGETS=(1600 900 600); fi

GRID=()
if [ "$LAYER" = "voxel" ]; then GRID=(--voxel-grids data/processed/voxel_grids.jsonl); fi

for B in "${BUDGETS[@]}"; do
  echo "===== budget ${B}"
  timeout 900 python tools/train_spatial.py \
    --layer "$LAYER" \
    --data "data/processed/splits_v8/train.jsonl" \
    --steps 6 --accumulate 16 --max-tokens-per-forward "$B" \
    --lr 2e-4 --log-every 3 "${GRID[@]}" 2>&1 \
    | grep -E '^step|пропущено|Error|error' | tail -n 5
done
