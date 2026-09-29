#!/usr/bin/env bash
# Render a few gen2 parts to PNG for a human/agent visual spot-check.
set -euo pipefail
export PATH="$HOME/bin:$PATH"
OUT=/mnt/c/github/OmniCraft-LM/data/previews
SRC=/mnt/c/github/OmniCraft-LM/optional_data/data/gen2
mkdir -p "$OUT"
for f in shafts/part_0001 lbrackets/part_0062 spurgears/part_0001 trusses/part_0001 enclosures/part_0001 knobs/part_0001 quadframes/part_0001 handles/part_0001; do
  name=$(echo "$f" | tr '/' '_')
  openscad -o "$OUT/$name.png" --imgsize=512,512 --colorscheme=Metallic "$SRC/$f.scad" >/dev/null 2>&1
  echo "$name.png: $(stat -c%s "$OUT/$name.png" 2>/dev/null || echo 0) bytes"
done
