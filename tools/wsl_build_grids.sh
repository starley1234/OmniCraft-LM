#!/usr/bin/env bash
# Build voxel-grid GT for the whole v4 corpus (long CPU/CLI job).
set -euo pipefail
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"
cd "$HOME/omnicraft/repo"
source .venv/bin/activate
python tools/build_voxel_grids.py \
  --input data/processed/combined_v6.jsonl \
  --output data/processed/voxel_grids.jsonl \
  --workers 14 2>&1 | tee "$HOME/omnicraft/voxel_grids.log"
