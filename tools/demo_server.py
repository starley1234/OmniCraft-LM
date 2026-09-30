"""Minimal human-facing demo: prompt -> [SPECS] -> trained canvas -> code -> manifold -> PNG.

Stdlib HTTP server; no framework. The model loads once per process per canvas.

    python tools/demo_server.py --port 8035
    # затем открыть http://127.0.0.1:8035

Requires the local backbone and at least one trained canvas checkpoint.
"""

from __future__ import annotations

import argparse
import json
import os
import subprocess
import time
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from pathlib import Path
from urllib.parse import parse_qs, urlparse

REPOSITORY_ROOT = Path(__file__).resolve().parents[1]
import sys

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

PAGE = """<!doctype html><meta charset="utf-8"><title>OmniCraft-LM</title>
<style>
 body {{ font-family: Segoe UI, sans-serif; margin: 24px; background: #10141c; color: #e6e9f0; }}
 textarea {{ width: 100%%; height: 90px; font-size: 15px; background:#171c26; color:#e6e9f0; border:1px solid #2a3242; border-radius:8px; padding:10px }}
 select, button {{ font-size: 15px; padding: 8px 14px; margin-top: 8px; background:#24304a; color:#e6e9f0; border:0; border-radius:8px; cursor:pointer }}
 pre {{ background:#0b0e14; padding:14px; border-radius:8px; overflow:auto; font-size:13px }}
 img {{ border-radius:8px; border:1px solid #2a3242; margin-top:12px }}
 .grid {{ display:grid; grid-template-columns: 1fr 1fr; gap:16px; }}
 .card {{ background:#171c26; border-radius:10px; padding:14px; }}
 h3 {{ margin: 4px 0 10px; color:#7fb4ff }}
 .ok {{ color:#7ee787 }} .bad {{ color:#ff7b72 }}
 small {{ color:#8b95a7 }}
</style>
<h2>OmniCraft-LM — генератор CAD</h2>
<form method="POST" action="/generate">
<textarea name="prompt" placeholder="Сделай фланец 60x60x10 мм с центральным отверстием 20 мм и 4 отверстиями М5 по углам...">{prompt}</textarea><br>
canvas: <select name="canvas">{canvas_options}</select>
<button type="submit">Сгенерировать</button>
</form>
{result}
<hr><small>backbone локально (offline); manifold OpenSCAD проверка; {load_note}</small>
"""

RESULT_CARD = """
<div class="grid">
 <div class="card"><h3>[SPECS]</h3><pre>{specs}</pre><h3>Код</h3><pre>{code}</pre></div>
 <div class="card"><h3>Проверка</h3>
  <div class="{klass}">{status}</div>
  <pre>{metrics}</pre>
  {image}
 </div>
</div>
"""


class DemoState:
    def __init__(self, args: argparse.Namespace) -> None:
        self.args = args
        self.shells: dict[str, object] = {}
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


def _generate(state: DemoState, prompt: str, canvas_override: str) -> str:
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

    metrics_lines = [f"generation: {elapsed:.1f} s", f"canvas: {canvas}", f"code: {len(code)} chars"]
    image_html = ""
    if code.startswith("$fn = 32;"):
        stl = OUT_DIR / f"gen_{stamp}.stl"
        completed = subprocess.run(
            ["openscad", "--backend=manifold", "-o", str(stl), str(scad_path)],
            capture_output=True,
            text=True,
            timeout=180,
            check=False,
        )
        if completed.returncode == 0 and stl.is_file():
            try:
                import trimesh

                mesh = trimesh.load(str(stl), force="mesh", process=True)
                bbox = tuple(float(v) for v in (mesh.bounds[1] - mesh.bounds[0]))
                err = max(
                    abs(a - t) / t for a, t in zip(bbox, specs.bbox)
                )
                metrics_lines += [
                    f"compiled: yes (manifold)",
                    f"bbox: {bbox[0]:.1f} x {bbox[1]:.1f} x {bbox[2]:.1f} мм",
                    f"bbox vs SPECS: {err:.2%}" + ("  ✓ within 15%" if err <= 0.15 else "  ✗ over 15%"),
                    f"watertight: {mesh.is_watertight}, components: {len(list(mesh.split(only_watertight=False)))}",
                ]
                status = "<span class=ok>VALID (manifold)</span>"
                png_path = OUT_DIR / f"gen_{stamp}.png"
                subprocess.run(
                    [
                        "openscad", "-o", str(png_path), "--imgsize=640,520",
                        "--colorscheme=Metallic", "--viewall", "--autocenter", str(scad_path),
                    ],
                    capture_output=True,
                    timeout=120,
                    check=False,
                )
                if png_path.is_file():
                    image_html = f'<img src="/preview/{png_path.name}" width="100%">'
            except Exception as exc:
                metrics_lines.append(f"mesh metrics failed: {exc}")
                status = "<span class=ok>compiled, metrics n/a</span>"
        else:
            tail = (completed.stderr or completed.stdout or "unknown").strip().splitlines()
            metrics_lines.append("compile error: " + (tail[0] if tail else ""))
            status = "<span class=bad>OPENSCAD REJECTED</span>"
    else:
        metrics_lines.append("missing $fn header — not even signed geometry")
        status = "<span class=bad>NO CAD HEADER</span>"

    return RESULT_CARD.format(
        specs=specs.render() + STOP_TOKEN,
        code=code.replace("&", "&amp;").replace("<", "&lt;"),
        metrics="\n".join(metrics_lines),
        status=status,
        image=image_html,
        klass="ok" if "VALID" in status else "bad",
    )


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--port", type=int, default=8035)
    parser.add_argument("--max-tokens", type=int, default=512)
    args = parser.parse_args()
    state = DemoState(args)

    class Handler(BaseHTTPRequestHandler):
        def log_message(self, *a):  # quiet
            pass

        def _send(self, body: str) -> None:
            encoded = body.encode("utf-8")
            self.send_response(200)
            self.send_header("Content-Type", "text/html; charset=utf-8")
            self.send_header("Content-Length", str(len(encoded)))
            self.end_headers()
            self.wfile.write(encoded)

        def do_GET(self) -> None:
            parsed = urlparse(self.path)
            if parsed.path == "/":
                options = "".join(
                    f'<option value="{c}"{" selected" if c=="voxel" else ""}>{c}</option>' for c in CANVASES
                ) + '<option value="auto">auto (из текста)</option>'
                trained = [c for c in CANVASES if (Path("checkpoints") / c / "canvas.pt").is_file()]
                note = f"обученные холсты: {', '.join(trained) or 'нет'}; без чекпоинта — нулевая точка"
                self._send(PAGE.format(prompt="", canvas_options=options, result="", load_note=note))
                return
            if parsed.path.startswith("/preview/"):
                name = Path(parsed.path).name
                png = OUT_DIR / name
                if png.is_file():
                    data = png.read_bytes()
                    self.send_response(200)
                    self.send_header("Content-Type", "image/png")
                    self.send_header("Content-Length", str(len(data)))
                    self.end_headers()
                    self.wfile.write(data)
                    return
            self.send_error(404)

        def do_POST(self) -> None:
            parsed = urlparse(self.path)
            if parsed.path != "/generate":
                self.send_error(404)
                return
            length = int(self.headers.get("Content-Length", "0"))
            form = parse_qs(self.rfile.read(length).decode("utf-8"))
            prompt = form.get("prompt", [""])[0].strip()
            canvas = form.get("canvas", ["voxel"])[0]
            if not prompt:
                self._send(PAGE.format(prompt="", canvas_options="", result="<p>Пустой промпт.</p>", load_note=""))
                return
            try:
                result = _generate(state, prompt, canvas)
            except Exception as exc:  # never strand the human without an answer
                result = f"<div class=card><h3>Ошибка</h3><pre>{type(exc).__name__}: {exc}</pre></div>"
            options = "".join(
                f'<option value="{c}"{" selected" if c==canvas else ""}>{c}</option>' for c in CANVASES
            ) + '<option value="auto">auto (из текста)</option>'
            self._send(PAGE.format(prompt=prompt, canvas_options=options, result=result, load_note=""))

    server = ThreadingHTTPServer(("127.0.0.1", args.port), Handler)
    print(f"OmniCraft-LM demo: http://127.0.0.1:{args.port} (Ctrl+C — стоп)")
    server.serve_forever()
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
