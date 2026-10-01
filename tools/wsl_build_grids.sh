#!/usr/bin/env bash
# Сетки-GT (16^3) на ВЕСЬ рабочий корпус: рендер STL + вокселизация (долгая CPU-задача).
#
# Почему на весь: в v8 сайдкар покрывал 0.4% воксельных строк, aux-лосс молча
# обнулялся почти на каждом батче (см. STATUS.md, разбор v8). Компиляция идёт по
# уникальным программам (code_sha256), строки пишутся всем id с этим кодом.
#
#   bash tools/wsl_build_grids.sh [SPLIT_DIR] [WORKERS]
set -euo pipefail
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"
cd "$HOME/omnicraft/repo"
source .venv/bin/activate

SPLIT_DIR="${1:-splits_v9}"
WORKERS="${2:-14}"
LOG="$HOME/omnicraft/voxel_grids.log"
WIN=/mnt/c/github/OmniCraft-LM

python tools/build_voxel_grids.py \
  --input "data/processed/${SPLIT_DIR}/train.jsonl" \
          "data/processed/${SPLIT_DIR}/validation.jsonl" \
          "data/processed/${SPLIT_DIR}/test.jsonl" \
  --output data/processed/voxel_grids.jsonl \
  --workers "$WORKERS" 2>&1 | tee "$LOG"

# Сайдкар нужен и на стороне Windows (status.py, повторные прогоны без пересборки).
rsync -a data/processed/voxel_grids.jsonl "$WIN/data/processed/voxel_grids.jsonl"
echo "[$(date +%T)] grids synced to Windows: $(wc -l < data/processed/voxel_grids.jsonl) rows"
