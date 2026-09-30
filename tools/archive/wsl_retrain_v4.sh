#!/usr/bin/env bash
# Overnight orchestrator for the v4 retrain (runs unattended):
#   1. wait for the voxel-grid builder to finish
#   2. wait for the wire retrain to release the GPU
#   3. full voxel retrain: 980 steps x 16 (~1 epoch) with occupancy aux loss
#   4. evaluate: held-out voxel (trained vs zero point), wire test set
#   5. copy artifacts back to the Windows tree
set -uo pipefail
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"
REPO="$HOME/omnicraft/repo"
WIN=/mnt/c/github/OmniCraft-LM
LOG="$HOME/omnicraft/orchestrator_v4.log"
exec > >(tee -a "$LOG") 2>&1

echo "=== [$(date +%T)] orchestrator started"

# 1. grids
while pgrep -f build_voxel_grids.py >/dev/null; do sleep 30; done
echo "=== [$(date +%T)] voxel grids finished:"
tail -2 "$HOME/omnicraft/voxel_grids.log"

# 1b. stash grids on the Windows side as well (survives any later rsync)
mkdir -p "$WIN/data/processed"
cp -f "$REPO/data/processed/voxel_grids.jsonl" "$WIN/data/processed/voxel_grids.jsonl"

# 2. wait for the GPU (wire training in flight)
while pgrep -f train_spatial >/dev/null; do sleep 30; done
echo "=== [$(date +%T)] GPU free; starting voxel retrain"

# 3. voxel retrain on v4 (aux from voxel_grids is auto-detected by wsl_train.sh)
bash "$REPO/tools/wsl_train.sh" voxel 980 16 1600
echo "=== [$(date +%T)] voxel retrain done"

# 3b. bring wire + voxel checkpoints back to Windows
rsync -a "$REPO/checkpoints/voxel/" "$WIN/checkpoints/voxel/"
rsync -a "$REPO/checkpoints/wire/"  "$WIN/checkpoints/wire/"

# 4. evaluations (WSL side; same US-assets get copied in first)
mkdir -p "$REPO/data/eval_import"
cp -f "$WIN/optional_data/data/heldout_eval.jsonl" "$REPO/data/eval_import/"
cp -f "$WIN/data/processed/eval_wire_set.jsonl" "$REPO/data/eval_import/" 2>/dev/null || true
cd "$REPO"
source .venv/bin/activate
export HF_HUB_OFFLINE=1 TRANSFORMERS_OFFLINE=1

echo "=== [$(date +%T)] eval: voxel trained on heldout"
python tools/evaluate_generation.py --layer voxel --checkpoint checkpoints/voxel \
  --eval-set data/eval_import/heldout_eval.jsonl --max-new-tokens 384 \
  --output data/processed/eval_voxel_v4_trained.jsonl

echo "=== [$(date +%T)] eval: zero-point control"
python tools/evaluate_generation.py --layer voxel \
  --eval-set data/eval_import/heldout_eval.jsonl --max-new-tokens 384 \
  --output data/processed/eval_voxel_v4_baseline.jsonl

if [ -f data/eval_import/eval_wire_set.jsonl ]; then
  echo "=== [$(date +%T)] eval: wire trained on the wire test set"
  python tools/evaluate_generation.py --layer wire --checkpoint checkpoints/wire \
    --eval-set data/eval_import/eval_wire_set.jsonl --max-new-tokens 640 \
    --output data/processed/eval_wire_v4_trained.jsonl
fi

# 5. reports back to Windows
rsync -a "$REPO/data/processed/eval_voxel_v4_trained.jsonl" \
          "$REPO/data/processed/eval_voxel_v4_baseline.jsonl" \
          "$WIN/data/processed/" 2>/dev/null || true
rsync -a "$REPO/data/processed/eval_wire_v4_trained.jsonl" "$WIN/data/processed/" 2>/dev/null || true

echo "=== [$(date +%T)] orchestrator finished"
