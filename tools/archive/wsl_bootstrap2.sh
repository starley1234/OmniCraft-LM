#!/usr/bin/env bash
# Retry torch install from plain PyPI (pypi.nvidia.com is unreachable here).
set -euo pipefail
export PATH="$HOME/.local/bin:$PATH"
cd "$HOME/omnicraft/repo"
source .venv/bin/activate

echo "=== torch from pypi.org (linux wheels ship CUDA-enabled by default)"
uv pip install "torch>=2.5" --index-url https://pypi.org/simple

echo "=== project deps"
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

echo "=== BOOTSTRAP2 OK"
