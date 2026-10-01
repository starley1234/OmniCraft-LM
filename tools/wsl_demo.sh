#!/usr/bin/env bash
# Демо-сервер внутри WSL2 — там же, где обучение и eval.
#
# Зачем: на Windows тот же бэкбон считает в ~4 раза медленнее (WDDM):
# замер tools/bench_generate.py — 123-159 мс/токен против 31-47 мс в WSL,
# загрузка холста 28.8 с против 11.2 с. Ответ на 300 токенов: ~45 с vs ~11 с.
# Порт виден из Windows по http://127.0.0.1:8035 (localhostForwarding WSL2).
#
# Usage: tools/wsl_demo.sh [port] [preload]
#   tools/wsl_demo.sh 8035 voxel,wire
set -uo pipefail
cd "$HOME/omnicraft/repo"
source .venv/bin/activate
export HF_HUB_OFFLINE=1 TRANSFORMERS_OFFLINE=1
export PYTORCH_CUDA_ALLOC_CONF="${PYTORCH_CUDA_ALLOC_CONF:-expandable_segments:True}"

PORT="${1:-8035}"
PRELOAD="${2:-voxel}"

echo "demo на http://127.0.0.1:${PORT} (preload: ${PRELOAD})"
exec python tools/demo_server.py --port "$PORT" --preload "$PRELOAD"
