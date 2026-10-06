# Ночной конвейер v15: дождаться валидации -> корпус v15 -> синк в WSL -> wire-лег + eval.
# Запуск: powershell -File tools/night_v15.ps1 (в фоне)
$ErrorActionPreference = "Continue"
Set-Location C:\github\OmniCraft-LM
$log = "runs\night_v15.log"
function Say($m) { "$((Get-Date).ToString('HH:mm:ss')) $m" | Tee-Object -FilePath $log -Append }

Say "ожидаю окончания валидации wire-кандидатов"
while (Get-CimInstance Win32_Process -Filter "Name like 'python%'" |
       Where-Object { $_.CommandLine -like "*validate_dataset.py*wire_families_v15*" }) {
  Start-Sleep -Seconds 60
}
Say "валидация завершена"
Get-Content runs\wf_v15_validate.log -Tail 3 | Tee-Object -FilePath $log -Append

$acc = "data\processed\wire_families_v15.validation.accepted.jsonl"
if (-not (Test-Path $acc)) { Say "НЕТ accepted-файла — стоп"; exit 4 }
$n = (Get-Content $acc | Measure-Object -Line).Lines
Say "accepted wire-строк: $n"
if ($n -lt 3000) { Say "слишком мало accepted ($n) — стоп"; exit 4 }

Say "сборка корпуса v15"
python tools/build_corpus_v15.py *>> $log
if ($LASTEXITCODE -ne 0) { Say "build_corpus_v15 rc=$LASTEXITCODE — стоп"; exit $LASTEXITCODE }

Say "синк Windows -> WSL"
wsl bash -lc "bash /mnt/c/github/OmniCraft-LM/tools/wsl_sync.sh" *>> $log
if ($LASTEXITCODE -ne 0) { Say "wsl_sync rc=$LASTEXITCODE — стоп"; exit $LASTEXITCODE }

Say "старт wire-лега v15 (2600x16@1000, splits_v15)"
wsl bash -lc "cd ~/omnicraft/repo && setsid nohup bash tools/wsl_train_chain_v15.sh > /dev/null 2>&1 & sleep 5; echo launched"  *>> $log
Say "чейн запущен; лог обучения: ~/omnicraft/chain_v15.log (копия в runs/train_v15/)"
