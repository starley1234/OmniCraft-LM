#!/usr/bin/env bash
# Full WSL-side verification: system checks + test suite.
set -euo pipefail
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"
export HF_HUB_OFFLINE=1 TRANSFORMERS_OFFLINE=1
cd "$HOME/omnicraft/repo"
source .venv/bin/activate

rsync -a --delete \
  --exclude .git --exclude optional_data --exclude __pycache__ --exclude .pytest_cache \
  --exclude .venv \
  /mnt/c/github/OmniCraft-LM/ "$HOME/omnicraft/repo/"

echo "=== system_check (WSL)"
python -m src.utils.system_check
echo "=== pytest (WSL)"
python -m pytest -q 2>&1 | tail -3
