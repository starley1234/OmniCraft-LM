#!/usr/bin/env bash
# Recreate the WSL venv after the rsync mishap (packages come from the uv cache).
set -euo pipefail
export PATH="$HOME/.local/bin:$PATH"
cd "$HOME/omnicraft/repo"

rm -rf .venv
uv venv --python 3.12 .venv
source .venv/bin/activate
uv pip install "torch>=2.5" --index-url https://pypi.org/simple
uv pip install "pydantic>=2.0" "trimesh>=4.0" "PyYAML>=6.0" "pytest>=8.0" \
  "transformers>=5.0" "peft>=0.15" "accelerate>=1.0" "huggingface_hub>=1.0"

python -c "import torch; print('torch', torch.__version__, '| cuda:', torch.cuda.is_available())"
echo "=== VENV RESTORED"
