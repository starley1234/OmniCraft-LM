"""Human-facing demo + project status board: prompt -> [SPECS] -> canvas -> code -> manifold -> 3D/PNG.

Stdlib HTTP server; no framework. The model loads lazily, once per process per canvas.
UI lives in tools/demo_ui/ (Tailwind + three.js vendored locally — работает офлайн).

    python tools/demo_server.py --port 8035     # затем открыть http://127.0.0.1:8035
    demo.cmd                                    # то же из корня проекта (Windows)

Маршруты:
    /                генератор (AJAX-страница)
    /status          панель состояния проекта (автоданные из файлов)
    /api/generate    POST {prompt, canvas} -> JSON с кодом и вердиктом
    /api/status      JSON-снимок проекта (status.py + trainer_state + eval_*.jsonl)
    /api/examples    примеры промптов в один клик
    /api/history     история генераций этой сессии сервера
    /model/<f>.stl   STL для three.js-вьювера · /preview/<f>.png · /static, /vendor
"""

from __future__ import annotations

import argparse
import importlib.util
import json
import os
import statistics
import subprocess
import sys
import time
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from pathlib import Path
from urllib.parse import urlparse

REPOSITORY_ROOT = Path(__file__).resolve().parents[1]
if str(REPOSITORY_ROOT) not in sys.path:
    sys.path.insert(0, str(REPOSITORY_ROOT))

os.environ.setdefault("HF_HUB_OFFLINE", "1")
os.environ.setdefault("TRANSFORMERS_OFFLINE", "1")

import torch

from src.runtime.specs_hook import (
    CANVASES,
    STOP_TOKEN,
    build_prompt_with_specs,
    compose_specs,
    extract_specs_from_text,
)
from src.training.trainer import SPATIAL_TOKENS

OUT_DIR = Path("data/demo_ui")
UI_DIR = Path(__file__).resolve().parent / "demo_ui"
VENDOR_DIR = UI_DIR / "vendor"

# Примеры в один клик; canvas подсказывает UI, но текст всё равно майнится.
EXAMPLES = [
    {"canvas": "voxel", "label": "Фланец 96 мм",
     "prompt": "Создай круглый фланец внешним диаметром 96 мм, толщиной 10 мм, с центральным отверстием 32 мм и 5 отверстиями 6 мм по окружности 70 мм."},
    {"canvas": "voxel", "label": "Корпус 120×80×40",
     "prompt": "Сделай прямоугольный корпус прибора 120x80x40 мм со стенкой 3 мм."},
    {"canvas": "voxel", "label": "Adapter plate (EN)",
     "prompt": "Make an adapter plate 60x60x8 mm with a central bore of 25 mm and 4 mounting holes of 5 mm."},
    {"canvas": "wire", "label": "Ферма 180 мм",
     "prompt": "Собери пространственную ферму длиной 180 мм с прямоугольным сечением 40x40 мм."},
    {"canvas": "wire", "label": "Вышка 200×50×50",
     "prompt": "Сделай ферменную вышку 200x50x50 мм из стержней."},
    {"canvas": "sketch", "label": "Шестерня (эскиз)",
     "prompt": "Нарисуй эскиз шестерни: диск диаметром 80 мм с центральным отверстием 20 мм."},
    {"canvas": "auto", "label": "«Утюг» (auto-routing)",
     "prompt": "Утюг"},
    {"canvas": "auto", "label": "«Чайник» (zero-shot CoG)",
     "prompt": "Чайник"},
]


class DemoState:
    def __init__(self, args: argparse.Namespace) -> None:
        self.args = args
        self.shells: dict[str, object] = {}
        self.history: list[dict] = []
        self._status_cache: tuple[float, dict] | None = None
        OUT_DIR.mkdir(parents=True, exist_ok=True)

    def shell(self, canvas: str):
        if canvas not in self.shells:
            import types

            from tools.evaluate_generation import build_trainer_shell

            checkpoint = Path("checkpoints") / canvas
            shell_args = types.SimpleNamespace(
                layer=canvas,
                checkpoint=checkpoint if (checkpoint / "canvas.pt").is_file() else None,
                backbone_dir=Path("checkpoints/baseline_qwen35_2b"),
                zero_point_dir=Path("checkpoints/zero_point"),
                device="cuda" if torch.cuda.is_available() else "cpu",
            )
            print(f"[load] canvas={canvas} (checkpoint={'yes' if shell_args.checkpoint else 'zero point'})")
            self.shells[canvas] = build_trainer_shell(shell_args)
        return self.shells[canvas]


# --------------------------------------------------------------------------- генерация

def _generate(state: DemoState, prompt: str, canvas_override: str) -> dict:
    mined = extract_specs_from_text(prompt)
    canvas = canvas_override if canvas_override in CANVASES else mined.canvas
    specs = compose_specs(
        object_class=mined.object_class, bbox=mined.bbox, canvas=canvas, topology=mined.topology
    )
    trainer = state.shell(canvas)
    trigger = SPATIAL_TOKENS[canvas]
    text = f"{build_prompt_with_specs(prompt, specs)}{trigger}\n"
    inputs = trainer.tokenizer(text, add_special_tokens=False, return_tensors="pt")
    log_bbox = torch.log(torch.tensor([list(specs.bbox)], dtype=torch.float32))
    started = time.time()
    with torch.inference_mode():
        trainer.hook.set_context(inputs["input_ids"], spatial_fn=trainer._spatial_fn(log_bbox))
        try:
            generated = trainer.backbone.generate(
                input_ids=inputs["input_ids"].to(trainer.device),
                attention_mask=inputs["attention_mask"].to(trainer.device),
                max_new_tokens=state.args.max_tokens,
                do_sample=False,
                pad_token_id=trainer.tokenizer.pad_token_id,
            )
        finally:
            trainer.hook.clear_context()
    continuation = trainer.tokenizer.decode(
        generated[0, inputs["input_ids"].shape[1]:], skip_special_tokens=False
    )

    from tools.evaluate_generation import extract_code

    code = extract_code(continuation)
    elapsed = time.time() - started
    stamp = int(started * 1000)
    scad_path = OUT_DIR / f"gen_{stamp}.scad"
    scad_path.write_text(code, encoding="utf-8")

    result = {
        "canvas": canvas, "elapsed_s": elapsed, "specs_text": specs.render() + STOP_TOKEN,
        "code": code, "code_chars": len(code), "bbox_target": list(specs.bbox),
        "compiled": None, "watertight": None, "components_count": None,
        "bbox": None, "bbox_rel_err": None, "compile_log": "", "stl": None, "png": None,
    }

    if not code.startswith("$fn = 32;"):
        result["compile_log"] = "нет заголовка $fn = 32; — модель не оформила деталь"
        return _record(state, prompt, result)

    stl = OUT_DIR / f"gen_{stamp}.stl"
    try:
        completed = subprocess.run(
            ["openscad", "--backend=manifold", "-o", str(stl), str(scad_path)],
            capture_output=True, text=True, timeout=180, check=False,
        )
    except FileNotFoundError:
        result["compile_log"] = "openscad не найден в PATH — вердикт не проверялся"
        return _record(state, prompt, result)

    if completed.returncode != 0 or not stl.is_file():
        tail = (completed.stderr or completed.stdout or "unknown").strip().splitlines()
        result.update(compiled=False, compile_log=(tail[0] if tail else "")[:400])
        return _record(state, prompt, result)

    result["compiled"] = True
    result["stl"] = stl.name
    try:
        import trimesh

        mesh = trimesh.load(str(stl), force="mesh", process=True)
        bbox = tuple(float(v) for v in (mesh.bounds[1] - mesh.bounds[0]))
        result["bbox"] = list(bbox)
        result["bbox_rel_err"] = max(abs(a - t) / t for a, t in zip(bbox, specs.bbox))
        result["watertight"] = bool(mesh.is_watertight)
        result["components_count"] = len(list(mesh.split(only_watertight=False)))
    except Exception as exc:
        result["compile_log"] = f"mesh metrics failed: {exc}"

    png_path = OUT_DIR / f"gen_{stamp}.png"
    subprocess.run(
        ["openscad", "-o", str(png_path), "--imgsize=640,520",
         "--colorscheme=Metallic", "--viewall", "--autocenter", str(scad_path)],
        capture_output=True, timeout=120, check=False,
    )
    if png_path.is_file():
        result["png"] = png_path.name
    return _record(state, prompt, result)


def _record(state: DemoState, prompt: str, result: dict) -> dict:
    state.history.insert(0, {
        "prompt": prompt, "canvas": result["canvas"],
        "compiled": result["compiled"], "elapsed_s": result["elapsed_s"],
    })
    del state.history[25:]
    return result


# --------------------------------------------------------------------------- статус проекта (всё из файлов)

def _load_status_module():
    spec = importlib.util.spec_from_file_location("omni_status", REPOSITORY_ROOT / "tools" / "status.py")
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


def gather_status(state: DemoState) -> dict:
    if state._status_cache and time.time() - state._status_cache[0] < 20:
        return state._status_cache[1]

    board = _load_status_module().collect()

    commit = subprocess.run(
        ["git", "rev-parse", "--short", "HEAD"], capture_output=True, text=True, check=False
    ).stdout.strip()

    trained: dict[str, dict] = {}
    for layer in SPATIAL_TOKENS:
        state_file = REPOSITORY_ROOT / "checkpoints" / layer / "trainer_state.json"
        if not state_file.is_file():
            continue
        try:
            payload = json.loads(state_file.read_text(encoding="utf-8"))
            tail = (payload.get("history_tail") or [{}])[-1]
            trained[layer] = {
                "step": payload.get("step"),
                "lm_loss": tail.get("lm_loss"),
                "aux_loss": tail.get("aux_loss"),
                "data": (payload.get("config") or {}).get("data", ""),
            }
        except Exception:
            trained[layer] = {"step": "?", "lm_loss": None, "aux_loss": None, "data": ""}

    evals = []
    for path in sorted((REPOSITORY_ROOT / "data" / "processed").glob("eval_*.jsonl")):
        try:
            rows = [json.loads(line) for line in path.read_text(encoding="utf-8").splitlines() if line.strip()]
        except Exception:
            continue
        bbox = [r["bbox_relative_error"] for r in rows if r.get("bbox_relative_error") is not None]
        evals.append({
            "name": path.stem, "rows": len(rows),
            "compiled": sum(1 for r in rows if r.get("compiled")),
            "watertight": sum(1 for r in rows if r.get("is_watertight")),
            "bbox_mean": statistics.mean(bbox) if bbox else None,
        })

    snapshot = {
        "environment": board.get("environment", {}),
        "processes": board.get("processes", {}),
        "corpus": board.get("corpus", {}),
        "zero_point": (board.get("checkpoints") or {}).get("zero_point", "?"),
        "git": {**(board.get("git") or {}), "commit": commit},
        "trained": trained,
        "evals": evals,
    }
    state._status_cache = (time.time(), snapshot)
    return snapshot


# --------------------------------------------------------------------------- HTTP

def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--port", type=int, default=8035)
    parser.add_argument("--max-tokens", type=int, default=512)
    args = parser.parse_args()
    state = DemoState(args)

    class Handler(BaseHTTPRequestHandler):
        def log_message(self, *a):  # quiet
            pass

        # ответы ------------------------------------------------------------
        def _send_bytes(self, data: bytes, content_type: str) -> None:
            self.send_response(200)
            self.send_header("Content-Type", content_type)
            self.send_header("Content-Length", str(len(data)))
            self.end_headers()
            self.wfile.write(data)

        def _send_json(self, payload: dict) -> None:
            self._send_bytes(json.dumps(payload, ensure_ascii=False).encode("utf-8"),
                             "application/json; charset=utf-8")

        def _send_page(self, name: str) -> None:
            self._send_bytes((UI_DIR / name).read_bytes(), "text/html; charset=utf-8")

        def _send_named_file(self, base: Path, name: str, content_type: str) -> bool:
            path = base / Path(name).name  # защита от path traversal
            if path.is_file():
                self._send_bytes(path.read_bytes(), content_type)
                return True
            return False

        # роутинг -----------------------------------------------------------
        def do_GET(self) -> None:
            parsed = urlparse(self.path)
            path = parsed.path
            if path == "/":
                return self._send_page("index.html")
            if path == "/status":
                return self._send_page("status.html")
            if path == "/api/examples":
                trained = [c for c in CANVASES if (Path("checkpoints") / c / "canvas.pt").is_file()]
                return self._send_json({
                    "examples": EXAMPLES, "canvases": list(CANVASES), "trained": trained,
                })
            if path == "/api/status":
                return self._send_json(gather_status(state))
            if path == "/api/history":
                return self._send_json({"items": state.history})
            if path.startswith("/static/"):
                found = self._send_named_file(UI_DIR, path.split("/", 2)[2], "text/javascript; charset=utf-8")
                return found or self.send_error(404)
            if path.startswith("/vendor/"):
                name = path.split("/", 2)[2]
                ctype = "text/javascript; charset=utf-8" if name.endswith(".js") else "application/octet-stream"
                found = self._send_named_file(VENDOR_DIR, name, ctype)
                return found or self.send_error(404)
            if path.startswith("/model/") and path.endswith(".stl"):
                found = self._send_named_file(OUT_DIR, path.split("/", 2)[2], "model/stl")
                return found or self.send_error(404)
            if path.startswith("/preview/"):
                found = self._send_named_file(OUT_DIR, path.split("/", 2)[2], "image/png")
                return found or self.send_error(404)
            self.send_error(404)

        def do_POST(self) -> None:
            if urlparse(self.path).path != "/api/generate":
                return self.send_error(404)
            try:
                length = int(self.headers.get("Content-Length", "0"))
                payload = json.loads(self.rfile.read(length).decode("utf-8") or "{}")
            except json.JSONDecodeError:
                return self._send_json({"error": "невалидный JSON"})
            prompt = str(payload.get("prompt", "")).strip()
            canvas = str(payload.get("canvas", "auto"))
            if not prompt:
                return self._send_json({"error": "пустой промпт"})
            try:
                self._send_json(_generate(state, prompt, canvas))
            except Exception as exc:  # никогда не оставляем человека без ответа
                self._send_json({"error": f"{type(exc).__name__}: {exc}"})

    server = ThreadingHTTPServer(("127.0.0.1", args.port), Handler)
    print(f"OmniCraft-LM demo:  http://127.0.0.1:{args.port}  (генератор)")
    print(f"OmniCraft-LM status: http://127.0.0.1:{args.port}/status  (Ctrl+C — стоп)")
    server.serve_forever()
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
