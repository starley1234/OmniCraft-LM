#!/usr/bin/env bash
# Render the demo generations from the eval report into PNG previews.
set -euo pipefail
export PATH="$HOME/bin:$PATH"
OUT=/mnt/c/github/OmniCraft-LM/data/demo
cd /mnt/c/github/OmniCraft-LM
source "$HOME/omnicraft/repo/.venv/bin/activate"
python - <<'PY'
import json
rows = [json.loads(l) for l in open('data/demo/eval_demo_voxel.jsonl', encoding='utf-8')]
for r in rows:
    if r.get('compiled'):
        open(f"data/demo/{r['id']}.scad", 'w', encoding='utf-8', newline='\n').write(r['code'])
        print('wrote', r['id'])
PY
for id in demo_flange demo_plate; do
  if [ -f "$OUT/$id.scad" ]; then
    openscad -o "$OUT/$id.png" --imgsize=640,640 --colorscheme=Metallic --viewall --autocenter "$OUT/$id.scad" >/dev/null 2>&1 && echo "$id.png: $(stat -c%s "$OUT/$id.png") bytes"
  fi
done
