#!/usr/bin/env bash
# Held-out eval of trained layers inside WSL2 (fast path; Windows WDDem MM is ~6x slower).
# Usage: tools/wsl_eval.sh [layer...]   (default: voxel wire)
# ВАЖНО: бюджет генерации >= p95 длины кода в корпусе (wire p95 ~1566 симв. ~ 520 токенов).
# До 2026-10-01 стояло 384 токена -> 31/39 провалов wire были обрывом на полуслове, не ошибкой модели.
# Reports are written straight to the Windows mirror: /mnt/c/.../data/processed/eval_<layer>.jsonl
set -euo pipefail
cd "$HOME/omnicraft/repo"
source .venv/bin/activate
export HF_HUB_OFFLINE=1 TRANSFORMERS_OFFLINE=1
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"
# snap/AppImage OpenSCAD пишет STL в приватный /tmp, если TMPDIR не под $HOME.
export TMPDIR="${TMPDIR:-$HOME/omnicraft/tmp}"
mkdir -p "$TMPDIR"

# Страж окружения: реальная пробная компиляция простой детали тем же раннером,
# что и eval. Поломка CAD-рантайма обязана читаться как [MISSING] здесь, а не как
# «модель ничего не умеет».
if ! python -m src.utils.system_check --openscad-only; then
  echo "[wsl_eval] ENV GUARD FAILED: OpenSCAD не отдал STL — eval был бы невалиден." >&2
  echo "[wsl_eval] Это поломка CAD-окружения, НЕ показатель качества модели." >&2
  exit 3
fi

LAYERS=("$@")
if [ "${#LAYERS[@]}" -eq 0 ]; then LAYERS=(voxel wire); fi

EVAL_SET=optional_data/data/heldout_eval.jsonl
if [ ! -f "$EVAL_SET" ]; then
  mkdir -p optional_data/data
  cp -f /mnt/c/github/OmniCraft-LM/optional_data/data/heldout_eval.jsonl "$EVAL_SET"
fi

WIN_OUT=/mnt/c/github/OmniCraft-LM/data/processed
for LAYER in "${LAYERS[@]}"; do
  echo "===== eval ${LAYER} start $(date -Is) ====="
  python tools/evaluate_generation.py \
    --layer "$LAYER" \
    --checkpoint "checkpoints/${LAYER}" \
    --eval-set "$EVAL_SET" \
    --max-new-tokens "${MAX_NEW_TOKENS:-1024}" \
    --output "${WIN_OUT}/eval_${LAYER}.jsonl"
  echo "===== eval ${LAYER} done $(date -Is) ====="
done
echo "ALL EVAL DONE"
