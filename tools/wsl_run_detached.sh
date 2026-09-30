#!/usr/bin/env bash
# Launch a WSL-side command detached from the caller's lifecycle.
# The harness shell may be reaped at any time; detached workers survive it.
# Usage: wsl_run_detached.sh <logfile> <command...>
set -euo pipefail
LOG="${1:?usage: wsl_run_detached.sh <logfile> <command...>}"
shift
setsid nohup bash -c "$*" >"$LOG" 2>&1 < /dev/null &
echo "detached pid $! -> $LOG"
