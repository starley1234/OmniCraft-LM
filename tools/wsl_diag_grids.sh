#!/usr/bin/env bash
echo "--- grids file:"
ls -la "$HOME/omnicraft/repo/data/processed/voxel_grids.jsonl" 2>/dev/null || echo "absent"
echo "--- grids log:"
ls -la "$HOME/omnicraft/voxel_grids.log" 2>/dev/null || echo "absent"
cat "$HOME/omnicraft/voxel_grids.log" 2>/dev/null | head -5
echo "--- procs:"
pgrep -af build_voxel || echo "no builder running"
