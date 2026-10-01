#!/usr/bin/env bash
# Чейн v8 «с нуля» на вычищенном корпусе splits_v8.
#
# Чем отличается от v7 (все изменения — следствие разбора v7, см. STATUS.md):
#   * данные: splits_v8 (68 151 строка, доминирование скелета 94% -> 6.5%,
#     безликие промпты «деталь NxNxN мм» вырезаны, стили free/conv сохраняют описание);
#   * dataset.py ротирует формулировки по стилям (v6/v7 учились только на prompts['en']);
#   * сторож OOM больше не обнуляет накопленные градиенты шага;
#   * eval генерирует до 1024 токенов (в v7 обрыв на 384 давал ложные провалы wire).
# Параметры шагов подняты под больший корпус: 1 эпоха voxel ~ 2900 шагов x16.
set -uo pipefail
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"
cd "$HOME/omnicraft/repo"

V_STEP="${1:-2900}"            # voxel optimizer steps (x16 samples)
W_STEP="${2:-1200}"            # wire optimizer steps (x16 samples)
# Бюджет токенов на forward. 600 — эмпирический потолок этой машины
# (tools/wsl_budget_probe.sh): при 900 и 1600 CE-логиты словаря 248k съедают
# 14 GiB и ВСЕ чанки уходят в OOM — так леги v6/v7 и «сходились» к lm=0.0000.
V_BUDGET="${3:-600}"
W_BUDGET="${4:-600}"
SPLIT_DIR="${5:-splits_v8}"
TAG="${6:-v8}"
LOG="$HOME/omnicraft/chain_${TAG}.log"
WIN=/mnt/c/github/OmniCraft-LM

echo "[$(date +%T)] chain ${TAG} alive (voxel ${V_STEP}x16@${V_BUDGET}, wire ${W_STEP}x16@${W_BUDGET}, data ${SPLIT_DIR})" | tee -a "$LOG"

source .venv/bin/activate
export HF_HUB_OFFLINE=1 TRANSFORMERS_OFFLINE=1

python tools/save_zero_point.py --verify >>"$LOG" 2>&1 \
  || { echo "[$(date +%T)] ZERO POINT VERIFY FAILED - abort" | tee -a "$LOG"; exit 4; }

# Откат обоих слоёв к zero point: чейн обязан начинать с чистого листа.
python tools/train_spatial.py --layer voxel --rollback-only >>"$LOG" 2>&1
python tools/train_spatial.py --layer wire  --rollback-only >>"$LOG" 2>&1
echo "[$(date +%T)] rollback to zero point done" >>"$LOG"

if [ ! -s "data/processed/${SPLIT_DIR}/train.jsonl" ]; then
  echo "[$(date +%T)] ${SPLIT_DIR}/train.jsonl missing - rsync the corpus first" | tee -a "$LOG"
  exit 4
fi
if [ ! -s data/processed/voxel_grids.jsonl ]; then
  echo "[$(date +%T)] voxel_grids.jsonl missing - run tools/wsl_build_grids.sh first" | tee -a "$LOG"
  exit 4
fi
echo "[$(date +%T)] grids ready: $(wc -l < data/processed/voxel_grids.jsonl) rows" >>"$LOG"

echo "[$(date +%T)] voxel: ${V_STEP}x16 on ${SPLIT_DIR}" >>"$LOG"
bash tools/wsl_train.sh voxel "$V_STEP" 16 "$V_BUDGET" "$SPLIT_DIR" >>"$LOG" 2>&1
echo "[$(date +%T)] voxel done rc=$?" >>"$LOG"

echo "[$(date +%T)] wire: ${W_STEP}x16 on ${SPLIT_DIR}" >>"$LOG"
bash tools/wsl_train.sh wire "$W_STEP" 16 "$W_BUDGET" "$SPLIT_DIR" >>"$LOG" 2>&1
echo "[$(date +%T)] wire done rc=$?" >>"$LOG"

rsync -a checkpoints/voxel/ "$WIN/checkpoints/voxel/"
rsync -a checkpoints/wire/  "$WIN/checkpoints/wire/"
echo "[$(date +%T)] rsync done" >>"$LOG"

bash tools/wsl_eval.sh voxel wire >>"$LOG" 2>&1
echo "[$(date +%T)] eval done rc=$?" >>"$LOG"

mkdir -p "$WIN/runs/train_${TAG}"
cp -f "$LOG" "$WIN/runs/train_${TAG}/"
echo "[$(date +%T)] ALL DONE" | tee -a "$LOG"
