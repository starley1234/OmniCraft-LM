#!/usr/bin/env bash
# Salvage the orphaned builder: its grids file was unlinked by an rsync
# (--delete) while it held the fd open; the written rows still live on the
# deleted inode. Copy them out via /proc before killing the process.
set -uo pipefail
PID=$(pgrep -f build_voxel_grids.py | head -1 || true)
if [ -z "${PID:-}" ]; then echo "no builder process"; exit 0; fi
echo "builder pid: $PID"
SAVED=""
for fd in /proc/$PID/fd/*; do
  tgt=$(readlink "$fd" 2>/dev/null || true)
  case "$tgt" in
    *deleted*)
      if [[ "$tgt" == *voxel_grids.jsonl* ]]; then
        cp "$fd" /home/serg/omnicraft/salvaged_voxel_grids.jsonl && SAVED="yes"
        echo "salvaged $tgt -> salvaged_voxel_grids.jsonl ($(stat -c%s /home/serg/omnicraft/salvaged_voxel_grids.jsonl) bytes)"
      fi
      ;;
  esac
done
kill -9 "$PID" 2>/dev/null || true
echo "builder killed; saved=${SAVED:-no}"
