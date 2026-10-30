#!/usr/bin/env bash
# Incremental repo sync Windows -> WSL; never touches the Linux venv.
#
# ВАЖНО (E7-a, docs/E7A_V15_CHECKPOINT_LOSS.md): checkpoints НЕ синхронизируются
# в эту сторону. Во время обучения авторитет — WSL, а rsync с --delete затирал
# свежие веса Windows-копией и удалял WSL-снимки. Забирать веса — только
# tools/wsl_pull_weights.sh (WSL -> Windows, со сверкой sha256).
set -euo pipefail
rsync -a --delete \
  --exclude .git --exclude optional_data --exclude __pycache__ --exclude .pytest_cache \
  --exclude .venv --exclude checkpoints \
  /mnt/c/github/OmniCraft-LM/ "$HOME/omnicraft/repo/"
echo "synced to ~/omnicraft/repo (checkpoints не трогали)"
