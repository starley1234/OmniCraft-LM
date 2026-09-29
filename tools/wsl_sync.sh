#!/usr/bin/env bash
# Incremental repo sync Windows -> WSL; never touches the Linux venv.
set -euo pipefail
rsync -a --delete \
  --exclude .git --exclude optional_data --exclude __pycache__ --exclude .pytest_cache \
  --exclude .venv \
  /mnt/c/github/OmniCraft-LM/ "$HOME/omnicraft/repo/"
echo "synced to ~/omnicraft/repo"
