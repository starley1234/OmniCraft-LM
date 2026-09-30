"""OmniCraft-LM operator CLI — единая точка входа для человека и локальной модели.

Использование:
    python tools/omni.py [--json] [--tail N] <команда> [аргументы команды...]
    python tools/omni.py help

Флаги omni (только ДО команды!):
    --json     финальный конверт одной строкой: {ok, cmd, exit_code, duration_s, log, tail}
    --tail N   сколько последних строк вывода вернуть в консоль (по умолчанию 30)

Философия: весь вывод дочернего скрипта пишется в runs/omni/<ts>_<cmd>.log,
в консоль возвращается только хвост и строка `OMNI_EXIT <код>`.
Это защищает контекст модели и экран человека от «простынь».

Коды выхода:
    0  успех
    2  ошибка использования omni (неизвестная команда — см. `omni help`)
    3  preflight провален (system_check нашёл [MISSING] или тесты упали)
    4  предусловие не выполнено (нет весов / zero point / входного файла) — читай сообщение
    остальные — код дочернего скрипта как есть; симптомы и лечение: docs/RUNBOOK.md §7
"""

from __future__ import annotations

import json
import os
import subprocess
import sys
import time
from datetime import datetime
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
RUN_DIR = ROOT / "runs" / "omni"

EXIT_OK = 0
EXIT_USAGE = 2
EXIT_PREFLIGHT = 3
EXIT_PRECONDITION = 4

BACKBONE_DIR = ROOT / "checkpoints" / "baseline_qwen35_2b"
ZERO_POINT_MANIFEST = ROOT / "checkpoints" / "zero_point" / "manifest.json"
SMOKE_DIR = RUN_DIR / "smoke"

PY = sys.executable

# команда -> (базовый argv, одна строка назначения)
COMMANDS: dict[str, tuple[list[str], str]] = {
    "check":    ([PY, "-m", "src.utils.system_check"],
                 "диагностика окружения: CUDA, OpenSCAD+manifold, offline-переменные"),
    "status":   ([PY, "tools/status.py"],
                 "сводка проекта: корпус, чекпойнты, процессы, git (есть --json)"),
    "test":     ([PY, "-m", "pytest", "-q"],
                 "pytest; пример узкого прогона: omni test tests/test_golden.py"),
    "gen":      ([PY, "tools/prepare_dataset.py"],
                 "генерация candidates JSONL: --voxel-count N --wire-count N --seed S --output F"),
    "validate": ([PY, "tools/validate_dataset.py"],
                 "валидация JSONL (OpenSCAD/analytic/mock); обязателен --input"),
    "split":    ([PY, "tools/split_dataset.py"],
                 "детерминированный split accepted-корпуса; обязательны --input/--output-dir"),
    "train":    ([PY, "tools/train_spatial.py"],
                 "обучение слоя; обязателен --layer voxel|wire|sketch|brep|assembly"),
    "eval":     ([PY, "tools/evaluate_generation.py"],
                 "оценка генерации на held-out; обязательны --layer/--eval-set"),
    "bench":    ([PY, "tools/benchmark_canvases.py"],
                 "латентность/VRAM всех холстов: --device auto|cpu|cuda"),
}


# --------------------------------------------------------------------------- guards

def _fail(code: int, message: str) -> "SystemExit":
    print(f"[omni] ОТКАЗ (код {code}): {message}", file=sys.stderr)
    return SystemExit(code)


def _guard_weights() -> None:
    if not BACKBONE_DIR.is_dir() or not any(BACKBONE_DIR.glob("*.safetensors")):
        raise _fail(EXIT_PRECONDITION,
                    f"нет весов бэкбона в {BACKBONE_DIR}. "
                    "Эта машина не готова к train/smoke/eval; раздел 0 в docs/RUNBOOK.md.")
    if not ZERO_POINT_MANIFEST.is_file():
        raise _fail(EXIT_PRECONDITION,
                    f"нет якоря отката {ZERO_POINT_MANIFEST}. "
                    "Сначала: python tools/save_zero_point.py --seed 1234")


def _guard_file(flag: str, args: list[str]) -> None:
    """Проверить, что файл, указанный после флага в args, существует."""
    if flag in args:
        value = Path(args[args.index(flag) + 1])
        if not value.is_file():
            raise _fail(EXIT_PRECONDITION, f"{flag} указывает на несуществующий файл: {value}")


# --------------------------------------------------------------------------- runner

def _label(argv: list[str]) -> str:
    """Короткое имя команды для лог-файла (обходит `-m` и пути)."""
    if "-m" in argv:
        return argv[argv.index("-m") + 1].rsplit(".", 1)[-1]
    return Path(argv[1]).stem if len(argv) > 1 else "cmd"


def _run_child(argv: list[str], tail: int, as_json: bool) -> tuple[int, list[str]]:
    """Запустить скрипт, увести вывод в лог, вернуть (код выхода, хвост вывода)."""
    RUN_DIR.mkdir(parents=True, exist_ok=True)
    stamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    log_path = RUN_DIR / f"{stamp}_{_label(argv)}.log"
    env = dict(os.environ, PYTHONIOENCODING="utf-8")

    started = time.monotonic()
    proc = subprocess.run(
        argv, cwd=ROOT, env=env,
        stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
        text=True, encoding="utf-8", errors="replace",
    )
    duration = time.monotonic() - started

    log_path.write_text(proc.stdout or "", encoding="utf-8")
    lines = (proc.stdout or "").splitlines()
    tail_lines = lines[-tail:]
    code = proc.returncode

    if as_json:
        print(json.dumps({
            "ok": code == EXIT_OK, "cmd": argv[1:], "exit_code": code,
            "duration_s": round(duration, 1), "log": str(log_path.relative_to(ROOT)),
            "tail": tail_lines,
        }, ensure_ascii=False))
    else:
        for line in tail_lines:
            print(line)
        print(f"OMNI_EXIT {code}  ({duration:.1f}s, полный лог: {log_path.relative_to(ROOT)})")
    return code, lines


# --------------------------------------------------------------------------- команды

def cmd_help() -> int:
    print("python tools/omni.py [--json] [--tail N] <команда> [аргументы]\n")
    for name, (_, descr) in {**COMMANDS,
                             "smoke": ([], "крошечный CPU-прогон обучения (2 шага) — сквозная проверка пайплайна"),
                             "preflight": ([], "check (+ тесты при --with-tests); запускать перед обучением")}.items():
        print(f"  {name:<10} {descr}")
    print("\nКоды выхода: 0 ок; 2 usage; 3 preflight; 4 предусловия; прочие = код скрипта (см. RUNBOOK §7)")
    return EXIT_OK


def cmd_preflight(args: list[str], tail: int, as_json: bool) -> int:
    check_code, check_lines = _run_child(COMMANDS["check"][0], tail, as_json)
    missing = [ln for ln in check_lines if "[MISSING]" in ln]
    if missing:
        print("[omni] preflight: найдены MISSING-строки:")
        for ln in missing:
            print("  " + ln)
        return EXIT_PREFLIGHT
    if check_code != EXIT_OK:
        print("[omni] preflight: system_check завершился ненулевым кодом")
        return EXIT_PREFLIGHT
    if "--with-tests" in args:
        test_code = cmd_generic("test", [a for a in args if a != "--with-tests"] or ["-x"], tail, as_json)
        if test_code != EXIT_OK:
            print("[omni] preflight: тесты упали — чини до обучения")
            return EXIT_PREFLIGHT
    print("[omni] preflight OK")
    return EXIT_OK


def cmd_smoke(args: list[str], tail: int, as_json: bool) -> int:
    """2 шага обучения на CPU с минимальными буферами — проверка plumbing end-to-end."""
    _guard_weights()
    SMOKE_DIR.mkdir(parents=True, exist_ok=True)
    data = SMOKE_DIR / "smoke_data.jsonl"
    if not data.is_file():
        gen_code, _ = _run_child([
            PY, "tools/prepare_dataset.py",
            "--voxel-count", "4", "--wire-count", "4", "--seed", "1234",
            "--output", str(data),
        ], tail, as_json)
        if gen_code != EXIT_OK or not data.is_file():
            return gen_code or EXIT_PRECONDITION
    argv = [PY, "tools/train_spatial.py",
            "--device", "cpu", "--steps", "2", "--microbatch", "1", "--accumulate", "1",
            "--max-tokens-per-forward", "256", "--max-prompt-tokens", "96",
            "--max-code-tokens", "128", "--lr", "1e-5",
            "--data", str(data), "--output-dir", str(SMOKE_DIR / "checkpoints")]
    if "--layer" not in args:
        argv += ["--layer", "voxel"]
    argv += args  # оператор может переопределить (--layer wire, --steps 5, ...)
    return _run_child(argv, tail, as_json)


def cmd_generic(name: str, args: list[str], tail: int, as_json: bool) -> int:
    base = COMMANDS[name][0]
    if name == "train":
        _guard_weights()
        _guard_file("--data", args)
    elif name == "eval":
        _guard_weights()
        _guard_file("--eval-set", args)
    elif name in ("validate", "split"):
        _guard_file("--input", args)
    code, _ = _run_child(base + args, tail, as_json)
    return code


# --------------------------------------------------------------------------- main

def main(argv: list[str]) -> int:
    as_json, tail = False, 30
    rest: list[str] = []
    i = 0
    # флаги omni признаются только до команды
    while i < len(argv) and argv[i].startswith("--") and not rest:
        if argv[i] == "--json":
            as_json = True
        elif argv[i] == "--tail":
            i += 1
            tail = int(argv[i])
        else:
            raise _fail(EXIT_USAGE, f"неизвестный флаг omni {argv[i]!r}; флаги — только до команды")
        i += 1
    rest = argv[i:]

    if not rest or rest[0] in ("help", "--help", "-h"):
        return cmd_help()
    cmd, args = rest[0], rest[1:]
    if cmd == "preflight":
        return cmd_preflight(args, tail, as_json)
    if cmd == "smoke":
        return cmd_smoke(args, tail, as_json)
    if cmd not in COMMANDS:
        cmd_help()
        raise _fail(EXIT_USAGE, f"неизвестная команда {cmd!r}")
    return cmd_generic(cmd, args, tail, as_json)


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
