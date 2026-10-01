#!/usr/bin/env bash
# Подбор режима, в котором обучение реально идёт: короткие прогоны с разными
# бюджетами токенов и опциями памяти; в выводе — только шаги, пустые шаги и OOM.
#
# Зачем: при словаре 248k CE-логиты доминируют в памяти. Слишком большой бюджет
# превращает ран в сплошные пропуски чанков, и lm печатается как 0.0000 (так
# «обучались» леги v6/v7). Слишком маленький — отбрасывает длинные образцы целиком.
#
# Usage: tools/wsl_budget_probe.sh [layer] [steps] [extra train_spatial args...] -- budget...
#   tools/wsl_budget_probe.sh voxel 40 --gradient-checkpointing -- 1200 1600
set -uo pipefail
cd "$HOME/omnicraft/repo"
source .venv/bin/activate
export HF_HUB_OFFLINE=1 TRANSFORMERS_OFFLINE=1
export PYTORCH_CUDA_ALLOC_CONF="${PYTORCH_CUDA_ALLOC_CONF:-expandable_segments:True}"

LAYER="${1:-voxel}"
STEPS="${2:-40}"
shift 2 || true

EXTRA=()
while [ "$#" -gt 0 ] && [ "$1" != "--" ]; do EXTRA+=("$1"); shift; done
[ "${1:-}" = "--" ] && shift
BUDGETS=("$@")
if [ "${#BUDGETS[@]}" -eq 0 ]; then BUDGETS=(600 1200); fi

GRID=()
if [ "$LAYER" = "voxel" ]; then GRID=(--voxel-grids data/processed/voxel_grids.jsonl); fi

for B in "${BUDGETS[@]}"; do
  echo "===== budget ${B} ${EXTRA[*]:-}"
  timeout 2400 python tools/train_spatial.py \
    --layer "$LAYER" \
    --data "data/processed/splits_v8/train.jsonl" \
    --steps "$STEPS" --accumulate 16 --max-tokens-per-forward "$B" \
    --lr 2e-4 --log-every 10 "${EXTRA[@]}" "${GRID[@]}" 2>&1 \
    | grep -E '^step|EMPTY|пропущено|Error' | tail -n 6
done
