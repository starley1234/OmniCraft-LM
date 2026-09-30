#!/usr/bin/env bash
set -euo pipefail
export PATH="$HOME/bin:$PATH"
cd /mnt/c/github/OmniCraft-LM
mkdir -p data/previews
for f in optional_data/data/place1/boltcircles/part_0001.scad optional_data/data/place1/perfpanels/part_0001.scad; do
  name=$(basename "$(dirname "$f")")_$(basename "$f" .scad)
  openscad -o "data/previews/place1_${name}.png" --imgsize=640,640 --colorscheme=Metallic --viewall --autocenter "$f" >/dev/null 2>&1
  echo "place1_${name}.png ok"
done
