@echo off
rem OmniCraft-LM demo — запуск внутри WSL2 (~4x быстрее Windows).
rem Порт 8035 пробрасывается на localhost — http://127.0.0.1:8035
title OmniCraft-LM demo (WSL)
start "" http://127.0.0.1:8035
wsl.exe bash -l -c "cd ~/omnicraft/repo && source .venv/bin/activate && export HF_HUB_OFFLINE=1 TRANSFORMERS_OFFLINE=1 && export PYTORCH_CUDA_ALLOC_CONF=expandable_segments:True && exec python tools/demo_server.py --port 8035 --preload voxel,wire"
pause