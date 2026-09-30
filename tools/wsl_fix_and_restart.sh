#!/usr/bin/env bash
# Recover + restart: salvage grids -> become the Windows-owned artifact, then
# rebuild the remainder from v6, then start the detached v6 training chain.
set -euo pipefail
WIN_PROC=/mnt/c/github/OmniCraft-LM/data/processed
REPO_PROC=/home/serg/omnicraft/repo/data/processed

# 1) salvaged rows take their place as the canonical file (both sides)
if [ -s /home/serg/omnicraft/salvaged_voxel_grids.jsonl ]; then
  cp /home/serg/omnicraft/salvaged_voxel_grids.jsonl "$WIN_PROC/voxel_grids.jsonl"
  cp /home/serg/omnicraft/salvaged_voxel_grids.jsonl "$REPO_PROC/voxel_grids.jsonl"
  echo "salvaged installed: $(wc -l < "$REPO_PROC/voxel_grids.jsonl") rows"
fi

# 2) the builder now targets v6
sed -i 's/combined_v4\.jsonl/combined_v6.jsonl/' /home/serg/omnicraft/repo/tools/wsl_build_grids.sh
grep -n 'combined' /home/serg/omnicraft/repo/tools/wsl_build_grids.sh

echo "READY"
