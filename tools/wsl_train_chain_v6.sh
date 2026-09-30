#!/usr/bin/env bash
# Full v6 retrain chain: grids wait -> voxel epoch -> wire epoch -> logs.
set -uo pipefail
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"
cd "$HOME/omnicraft/repo"

echo "[$(date +%T)] waiting for the voxel-grid builder..."
while pgrep -f build_voxel_grids.py >/dev/null; do sleep 20; done
echo "[$(date +%T)] grids ready:"
tail -1 "$HOME/omnicraft/voxel_grids.log"

echo "[$(date +%T)] voxel: 1360 steps x 16 (1 epoch of voxel v6, occupancy aux)"
bash tools/wsl_train.sh voxel 1360 16 1600

echo "[$(date +%T)] wire: 675 steps x 16 (1 epoch of wire v6, graph aux)"
bash tools/wsl_train.sh wire 675 16 1200

echo "[$(date +%T)] chain done; syncing checkpoints back to Windows"
rsync -a checkpoints/voxel/ /mnt/c/github/OmniCraft-LM/checkpoints/voxel/
rsync -a checkpoints/wire/  /mnt/c/github/OmniCraft-LM/checkpoints/wire/
echo "[$(date +%T)] ALL DONE"
