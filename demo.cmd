@echo off
rem OmniCraft-LM demo: запуск человеком из корня проекта (двойной клик).
rem Сервер: http://127.0.0.1:8035  (+ страница /status)
title OmniCraft-LM demo server
start "" http://127.0.0.1:8035
python tools\demo_server.py --port 8035
pause
