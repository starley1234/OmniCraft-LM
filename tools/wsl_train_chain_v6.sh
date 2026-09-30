#!/usr/bin/env bash
# Full v6 retrain chain: grids wait -> voxel epoch -> wire epoch -> sync back.
# (simple >> appends; the previous exec-tee pattern died silently under setsid)
set -uo pipefail
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"
cd "$HOME/omnicraft/repo"
LOG="$HOME/omnicraft/chain_v6.log"

echo "[$(date +%T)] chain alive" >>"$LOG"
while pgrep -f build_voxel_grids.py >/dev/null; do sleep 20; done
echo "[$(date +%T)] grids ready: $(wc -l < data/processed/voxel_grids.jsonl) rows" >>"$LOG"

echo "[$(date +%T)] voxel: 1360x16" >>"$LOG"
bash tools/wsl_train.sh voxel 1360 16 1600 >>"$LOG" 2>&1
echo "[$(date +%T)] voxel done rc=$?" >>"$LOG"

echo "[$(date +%T)] wire: 675x16" >>"$LOG"
bash tools/wsl_train.sh wire 675 16 1200 >>"$LOG" 2>&1
echo "[$(date +%T)] wire done rc=$?" >>"$LOG"

rsync -a checkpoints/voxel/ /mnt/c/github/OmniCraft-LM/checkpoints/voxel/
rsync -a checkpoints/wire/  /mnt/c/github/OmniCraft-LM/checkpoints/wire/
echo "[$(date +%T)] ALL DONE" >>"$LOG"
