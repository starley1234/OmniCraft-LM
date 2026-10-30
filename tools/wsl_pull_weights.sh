#!/usr/bin/env bash
# Забрать чекпойнты из WSL в Windows-зеркало и проверить их по манифесту.
#
# Направление важно (E7-a, docs/E7A_V15_CHECKPOINT_LOSS.md): во время обучения
# авторитет — WSL. Windows-копию только забираем, никогда не пушим обратно.
# --delete не используется: снимки, сделанные на Windows, не удаляются.
#
# Usage: tools/wsl_pull_weights.sh [layer...]      (default: wire voxel)
set -euo pipefail
SRC="$HOME/omnicraft/repo/checkpoints"
DST=/mnt/c/github/OmniCraft-LM/checkpoints
LAYERS=("$@")
if [ "${#LAYERS[@]}" -eq 0 ]; then LAYERS=(wire voxel); fi

mkdir -p "$DST"
rsync -a --checksum "$SRC/" "$DST/"

python3 - "$DST" "${LAYERS[@]}" <<'PY'
import hashlib, json, pathlib, sys

dst = pathlib.Path(sys.argv[1])
failed = False
for layer in sys.argv[2:]:
    base = dst / layer
    state_path = base / "trainer_state.json"
    if not state_path.is_file():
        print(f"[{layer}] нет trainer_state.json в {base} — пропуск")
        failed = True
        continue
    state = json.loads(state_path.read_text(encoding="utf-8"))
    step = state.get("step")
    bad = []
    for name, want in state.get("files_sha256", {}).items():
        path = base / f"{name}.pt"
        got = hashlib.sha256(path.read_bytes()).hexdigest() if path.is_file() else "MISSING"
        if got != want:
            bad.append((name, got[:12], want[:12]))
    if bad:
        failed = True
        print(f"[{layer}] step={step}: РАСХОЖДЕНИЕ {bad}")
    else:
        count = len(state.get("files_sha256", {}))
        print(f"[{layer}] step={step}: sha256 совпали ({count} файлов)")
sys.exit(1 if failed else 0)
PY
echo "weights pulled to $DST"
