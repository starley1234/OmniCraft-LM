#!/usr/bin/env bash
# Ночной конвейер v15 целиком внутри WSL (хост-оболочка не нужна):
#   валидация wire-кандидатов настоящим OpenSCAD -> корпус v15 + сплит
#   -> wire-лег с нуля (voxel v14 не трогаем) -> eval -> копии артефактов в Windows.
#
# Запуск:
#   wsl bash -lc "cd ~/omnicraft/repo && setsid nohup bash tools/wsl_night_v15.sh >/dev/null 2>&1 &"
set -uo pipefail
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"
cd "$HOME/omnicraft/repo"
source .venv/bin/activate
export HF_HUB_OFFLINE=1 TRANSFORMERS_OFFLINE=1 PYTHONIOENCODING=utf-8
export TMPDIR="$HOME/omnicraft/tmp"; mkdir -p "$TMPDIR"

WIN=/mnt/c/github/OmniCraft-LM
LOG="$HOME/omnicraft/night_v15.log"
CAND=data/processed/wire_families_v15.jsonl
ACC=data/processed/wire_families_v15.validation.accepted.jsonl
say() { echo "[$(date +%T)] $*" | tee -a "$LOG"; mkdir -p "$WIN/runs"; cp -f "$LOG" "$WIN/runs/night_v15.log" 2>/dev/null; }

say "start: validate -> corpus v15 -> wire leg -> eval"

if [ ! -s "$CAND" ]; then
  say "no candidates at $CAND - abort"; exit 4
fi

if [ ! -s "$ACC" ]; then
  say "validating $(wc -l < "$CAND") wire candidates with OpenSCAD (workers 8)"
  python tools/validate_dataset.py --input "$CAND" --backend openscad --workers 8 \
    --cache data/cache/wf_v15.json >>"$LOG" 2>&1
  RC=$?
  say "validate rc=${RC}"
  [ "$RC" -eq 0 ] || exit "$RC"
fi

N=$(wc -l < "$ACC")
say "accepted wire rows: ${N}"
if [ "$N" -lt 3000 ]; then say "too few accepted - abort"; exit 4; fi

say "building corpus v15"
python tools/build_corpus_v15.py >>"$LOG" 2>&1
RC=$?; say "build_corpus_v15 rc=${RC}"; [ "$RC" -eq 0 ] || exit "$RC"

# артефакты корпуса обратно в Windows (обучение идёт из WSL-копии)
rsync -a data/processed/combined_v15_lm.jsonl "$WIN/data/processed/" 2>>"$LOG"
rsync -a data/processed/splits_v15/ "$WIN/data/processed/splits_v15/" 2>>"$LOG"
rsync -a "$ACC" "$WIN/data/processed/" 2>>"$LOG"
rsync -a runs/corpus_v15/ "$WIN/runs/corpus_v15/" 2>>"$LOG"

say "launching wire leg v15"
bash tools/wsl_train_chain_v15.sh "${1:-2600}" "${2:-1000}" splits_v15 v15 >>"$LOG" 2>&1
RC=$?; say "chain v15 rc=${RC}"
cp -f "$LOG" "$WIN/runs/night_v15.log"
exit "$RC"
