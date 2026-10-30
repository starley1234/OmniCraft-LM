#!/usr/bin/env bash
# [B] Диагностика габарита wire: один и тот же чекпойнт, одни и те же строки,
# меняется только блок [SPECS] (см. src/runtime/eval_specs.py).
#
#   auto  — oracle-bbox, если в строке есть expected_bbox_mm (историческое поведение eval)
#   mined — всегда догадка минера по тексту (реальный путь пользователя)
#   none  — блока нет вообще (канвас всё равно получает bbox минера)
#
# Вопросы, на которые отвечает прогон:
#   auto vs none  — модель вообще смотрит на блок?
#   auto vs mined — сколько стоит ошибка минера?
#
# Usage (внутри WSL, отвязанно): bash tools/wsl_diag_wire_scale.sh [layer]
# Reports: data/processed/diag_wire_scale/<set>_<mode>.jsonl (Windows-зеркало).
set -uo pipefail
cd "$HOME/omnicraft/repo"
source .venv/bin/activate
export HF_HUB_OFFLINE=1 TRANSFORMERS_OFFLINE=1
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"
export TMPDIR="${TMPDIR:-$HOME/omnicraft/tmp}"
mkdir -p "$TMPDIR"

if ! python -m src.utils.system_check --openscad-only; then
  echo "[diag] ENV GUARD FAILED: OpenSCAD не отдаёт STL — метрики bbox будут пустыми." >&2
  exit 3
fi

LAYER="${1:-wire}"
WIN=/mnt/c/github/OmniCraft-LM
OUT_WIN="${WIN}/data/processed/diag_wire_scale"
mkdir -p "$OUT_WIN"
mkdir -p optional_data/data
cp -f "${WIN}/optional_data/data/heldout_eval.jsonl" optional_data/data/ 2>/dev/null || true
cp -f "${WIN}/optional_data/data/heldout_conv_gt.jsonl" optional_data/data/ 2>/dev/null || true

MAX_TOKENS="${MAX_NEW_TOKENS:-1024}"

# heldout_conv_gt смешивает 8 воксельных прототипов и 4 wire-строки; на wire-слое
# имеет смысл только wire-подмножество (у них масштаб вообще не назван в тексте —
# единственный источник — oracle [SPECS]).
python - "$OUT_WIN" <<'PY'
import json, pathlib, sys
out_dir = pathlib.Path(sys.argv[1])
src = pathlib.Path("optional_data/data/heldout_conv_gt.jsonl")
rows = [json.loads(line) for line in src.read_text(encoding="utf-8").splitlines() if line.strip()]
wire = [row for row in rows if "wire" in row.get("id", "")]
target = out_dir / "conv_gt_wire.jsonl"
target.write_text("".join(json.dumps(r, ensure_ascii=False) + "\n" for r in wire), encoding="utf-8")
print(f"conv_gt wire subset: {len(wire)}/{len(rows)} -> {target}")
PY

run_one() {  # run_one <eval-set> <mode> <tag>
  local set="$1" mode="$2" tag="$3"
  echo "===== ${tag} / ${mode} start $(date -Is) ====="
  python tools/evaluate_generation.py \
    --layer "$LAYER" \
    --checkpoint "checkpoints/${LAYER}" \
    --eval-set "$set" \
    --max-new-tokens "$MAX_TOKENS" \
    --specs-mode "$mode" \
    --output "${OUT_WIN}/${tag}_${mode}.jsonl"
  echo "===== ${tag} / ${mode} done rc=$? $(date -Is) ====="
}

# 42 общих held-out строк: нужен только контраст «блок есть / блока нет».
run_one optional_data/data/heldout_eval.jsonl auto  heldout_eval
run_one optional_data/data/heldout_eval.jsonl none  heldout_eval

# 4 wire-conv строки без цифр в тексте: все три режима.
run_one "${OUT_WIN}/conv_gt_wire.jsonl" auto  conv_gt_wire
run_one "${OUT_WIN}/conv_gt_wire.jsonl" mined conv_gt_wire
run_one "${OUT_WIN}/conv_gt_wire.jsonl" none  conv_gt_wire

echo "ALL DIAG DONE $(date -Is)"
