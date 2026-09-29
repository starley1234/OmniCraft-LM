#!/usr/bin/env bash
# Probe the WSL-side toolchain: OpenSCAD manifold compile + python env import.
set -euo pipefail
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"

echo "--- openscad:"
openscad --version

echo "--- manifold probe compile:"
printf '$fn = 32;\ncube([1.0, 1.0, 1.0]);\n' > /tmp/omnicraft_probe.scad
openscad --backend=manifold -o /tmp/omnicraft_probe.stl /tmp/omnicraft_probe.scad
test -s /tmp/omnicraft_probe.stl && echo "STL written: $(stat -c%s /tmp/omnicraft_probe.stl) bytes"
