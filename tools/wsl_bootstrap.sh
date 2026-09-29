#!/usr/bin/env bash
# Bootstrap the OmniCraft-LM Linux environment inside WSL2 (run once).
set -euo pipefail

export PATH="$HOME/.local/bin:$PATH"
echo "=== uv: $(uv --version)"

echo "=== installing standalone CPython 3.12"
uv python install 3.12

echo "=== syncing repository into the Linux filesystem (fast ext4, not /mnt/c)"
mkdir -p "$HOME/omnicraft"
rsync -a --delete \
  --exclude .git --exclude optional_data --exclude __pycache__ --exclude .pytest_cache \
  --exclude .venv \
  /mnt/c/github/OmniCraft-LM/ "$HOME/omnicraft/repo/"
cd "$HOME/omnicraft/repo"

echo "=== creating venv (python 3.12)"
uv venv --python 3.12 .venv
source .venv/bin/activate

echo "=== torch (cu128 wheels)"
uv pip install --index-url https://download.pytorch.org/whl/cu128 "torch>=2.5"

echo "=== project deps (pypi)"
uv pip install "pydantic>=2.0" "trimesh>=4.0" "PyYAML>=6.0" "pytest>=8.0" \
  "transformers>=5.0" "peft>=0.15" "accelerate>=1.0" "huggingface_hub>=1.0"

python - <<'PY'
import torch
print("torch:", torch.__version__)
print("cuda:", torch.cuda.is_available())
if torch.cuda.is_available():
    print("device:", torch.cuda.get_device_name(0))
    print("capability:", torch.cuda.get_device_capability(0))
    print("vram GiB:", round(torch.cuda.get_device_properties(0).total_memory / 1024**3, 2))
PY

echo "=== BOOTSTRAP OK"
