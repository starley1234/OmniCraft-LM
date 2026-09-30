#!/usr/bin/env bash
# Launch a WSL-side command detached (setsid+nohup) with self-diagnosis:
# after 2s we assert the child is alive and the log has its first line.
# Usage: wsl_run_detached.sh <logfile> <command...>
set -euo pipefail
LOG="${1:?usage: wsl_run_detached.sh <logfile> <command...>}"
shift
setsid nohup bash -c "$*" >"$LOG" 2>&1 < /dev/null &
CHILD=$!
echo "launched pid $CHILD -> $LOG"
sleep 2
if kill -0 "$CHILD" 2>/dev/null; then
  echo "alive after 2s: yes"
else
  echo "alive after 2s: NO -- log follows:"; cat "$LOG"; exit 1
fi
