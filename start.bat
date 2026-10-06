@echo off
rem OmniCraft-LM — запуск демо человеком (двойной клик по файлу).
rem Демо поднимается внутри WSL2: там тот же бэкбон считает в ~4 раза быстрее,
rem чем на Windows (WDDM). Страница та же: http://127.0.0.1:8035
title OmniCraft-LM demo
cd /d "%~dp0"

echo [1/3] синхронизация кода и весов Windows -> WSL...
wsl bash -lc "bash /mnt/c/github/OmniCraft-LM/tools/wsl_sync.sh"
if errorlevel 1 (
  echo.
  echo Не удалось синхронизировать репозиторий в WSL.
  echo Запасной путь ^(медленнее^): demo.cmd
  pause
  exit /b 1
)

echo [2/3] открываю браузер...
start "" http://127.0.0.1:8035

echo [3/3] поднимаю демо в WSL (модель грузится на старте, ~15 с)...
echo     Остановить: Ctrl+C в этом окне.
wsl bash -lc "cd ~/omnicraft/repo && bash tools/wsl_demo.sh 8035 voxel,wire"
pause
