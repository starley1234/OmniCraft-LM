#!/usr/bin/env bash
set -euo pipefail
export PATH="$HOME/bin:$PATH"
cd /mnt/c/github/OmniCraft-LM
openscad -o data/previews/sketch1_cam.png --imgsize=640,640 --colorscheme=Metallic --viewall --autocenter optional_data/data/sketch1/camdiscs/part_0001.scad >/dev/null 2>&1
openscad -o data/previews/asm1_scene.png --imgsize=640,640 --colorscheme=Metallic --viewall --autocenter optional_data/data/asm1/boltplate/scene_0003.scad >/dev/null 2>&1
echo rendered
