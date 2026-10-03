"""Контролируемый прогон обученной модели: вклад блока `[SPECS]` в геометрию.

Один и тот же пользовательский промпт генерируется в нескольких условиях:

    nospecs  — промпт + триггер, без блока `[SPECS]` (масштаб холсту всё равно дан);
    mined    — как в рантайме: `extract_specs_from_text` + `compose_specs`;
    specs    — блок `[SPECS]` задан вручную (оракул или намеренно неверный).

Для каждого случая: greedy-генерация → `extract_code` → компиляция настоящим
OpenSCAD/manifold → изометрический PNG 480x480 → строка в `cases.jsonl`, `.scad`,
`report.md` и общий `overview.png`. Назначение — снять доказательную базу для
внешнего анализа (у агента нет ни OpenSCAD, ни модели).

    python tools/specs_probe.py \
        --checkpoint C:/github/OmniCraft-LM/checkpoints/voxel \
        --backbone-dir C:/github/OmniCraft-LM/checkpoints/baseline_qwen35_2b \
        --zero-point-dir C:/github/OmniCraft-LM/checkpoints/zero_point \
        --out runs/specs_probe
"""
from __future__ import annotations

import argparse
import json
import os
import shutil
import subprocess
import sys
import time
import types
from pathlib import Path

REPOSITORY_ROOT = Path(__file__).resolve().parents[1]
if str(REPOSITORY_ROOT) not in sys.path:
    sys.path.insert(0, str(REPOSITORY_ROOT))
os.environ.setdefault("HF_HUB_OFFLINE", "1")
os.environ.setdefault("TRANSFORMERS_OFFLINE", "1")

if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")

import torch  # noqa: E402

from src.runtime.specs_hook import (  # noqa: E402
    Specs,
    build_prompt_with_specs,
    compose_specs,
    extract_specs_from_text,
)
from src.training.trainer import SPATIAL_TOKENS  # noqa: E402

OPENSCAD_FALLBACKS = (
    Path(r"C:\Program Files\OpenSCAD\openscad.exe"),
    Path(r"C:\Program Files\OpenSCAD\openscad.com"),
    Path("/usr/bin/openscad"),
)

# --- сценарий: один намеренный дефект под разными углами ----------------------
FLANGE = ("Создай круглый фланец внешним диаметром 96 мм, толщиной 10 мм, "
          "с центральным отверстием 32 мм и 5 отверстиями 6 мм по окружности 70 мм.")
FLANGE_ABC = ("Создай круглый фланец 96x96x10 мм с центральным отверстием 32 мм "
              "и 5 отверстиями 6 мм по окружности 70 мм.")
CAP = "Создай круглую крышку внешним диаметром 120 мм, толщиной 8 мм, с центральным отверстием 30 мм."
PLATE = "Сделай монтажную плиту 120x80x8 мм с 4 отверстиями 6 мм по углам."
BRACKET = "Сделай крепёжный кронштейн для датчика."

CASES: list[dict] = [
    {"name": "flange_nospecs", "canvas": "voxel", "prompt": FLANGE, "mode": "nospecs",
     "expected_bbox": [96, 96, 10], "note": "без блока [SPECS], масштаб холсту задан верно"},
    {"name": "flange_mined", "canvas": "voxel", "prompt": FLANGE, "mode": "mined",
     "expected_bbox": [96, 96, 10], "note": "текущий рантайм: miner (диаметр/толщина не поняты)"},
    {"name": "flange_abc", "canvas": "voxel", "prompt": FLANGE_ABC, "mode": "mined",
     "expected_bbox": [96, 96, 10], "note": "габарит в тексте записан как 96x96x10"},
    {"name": "flange_oracle", "canvas": "voxel", "prompt": FLANGE, "mode": "specs",
     "object_class": "flange", "bbox": [96, 96, 10], "topology": "csg union/difference",
     "expected_bbox": [96, 96, 10], "note": "правильные [SPECS] вручную"},
    {"name": "flange_wrongspec", "canvas": "voxel", "prompt": FLANGE, "mode": "specs",
     "object_class": "flange", "bbox": [200, 200, 20], "topology": "csg union/difference",
     "expected_bbox": [96, 96, 10], "note": "неверный bbox в [SPECS]: слепо ли доверяет"},
    {"name": "cap_mined", "canvas": "voxel", "prompt": CAP, "mode": "mined",
     "expected_bbox": [120, 120, 8], "note": "второй диаметр-промпт"},
    {"name": "plate_mined", "canvas": "voxel", "prompt": PLATE, "mode": "mined",
     "expected_bbox": [120, 80, 8], "note": "контроль: габарит вида AxBxC"},
    {"name": "bracket_mined", "canvas": "voxel", "prompt": BRACKET, "mode": "mined",
     "expected_bbox": None, "note": "размеров в тексте нет вовсе"},
]


def find_openscad() -> str:
    found = shutil.which("openscad") or shutil.which("openscad.com")
    if found:
        return found
    for candidate in OPENSCAD_FALLBACKS:
        if candidate.exists():
            return str(candidate)
    raise SystemExit("[MISSING] openscad не найден")


def flatten_on_white(png: Path) -> None:
    from PIL import Image

    with Image.open(png) as image:
        rgba = image.convert("RGBA")
        background = Image.new("RGBA", rgba.size, (255, 255, 255, 255))
        Image.alpha_composite(background, rgba).convert("RGB").save(png, "PNG")


def specs_for_case(case: dict, canvas: str) -> "Specs | None":
    mode = case["mode"]
    bbox_expected = case.get("expected_bbox")
    if mode == "nospecs":
        return None
    if mode == "mined":
        mined = extract_specs_from_text(case["prompt"], canvas_hint=canvas)
        return compose_specs(object_class=mined.object_class, bbox=mined.bbox,
                             canvas=canvas, topology=mined.topology,
                             provenance=mined.provenance)
    if mode == "specs":
        return Specs(
            object_class=case.get("object_class", "unknown"),
            bbox=tuple(float(v) for v in case["bbox"]),
            topology=case.get("topology") or "csg union/difference",
            canvas=canvas,
            provenance="block",
        )
    raise ValueError(f"unknown mode {mode!r}")


def build_text(case: dict, specs, canvas: str) -> str:
    trigger = SPATIAL_TOKENS[canvas]
    if specs is None:
        return f"{case['prompt']}\n{trigger}\n"
    return f"{build_prompt_with_specs(case['prompt'], specs)}{trigger}\n"


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("--checkpoint", type=Path, default=Path("checkpoints/voxel"))
    parser.add_argument("--backbone-dir", type=Path, default=Path("checkpoints/baseline_qwen35_2b"))
    parser.add_argument("--zero-point-dir", type=Path, default=Path("checkpoints/zero_point"))
    parser.add_argument("--out", type=Path, default=Path("runs/specs_probe"))
    parser.add_argument("--device", choices=("cuda", "cpu"), default="cuda")
    parser.add_argument("--max-new-tokens", type=int, default=512)
    parser.add_argument("--size", type=int, default=480)
    parser.add_argument("--only", default="", help="имена случаев через запятую")
    parser.add_argument("--cases-file", type=Path, default=None, help="свой JSON-список случаев")
    args = parser.parse_args()

    cases = CASES
    if args.cases_file:
        cases = json.loads(args.cases_file.read_text(encoding="utf-8"))
    if args.only:
        wanted = {name.strip() for name in args.only.split(",") if name.strip()}
        cases = [case for case in cases if case["name"] in wanted]

    args.out.mkdir(parents=True, exist_ok=True)
    (args.out / "png").mkdir(exist_ok=True)
    openscad = find_openscad()

    from src.env.openscad_runner import CADExecutableNotFound, OpenSCADRunner
    from tools.evaluate_generation import build_trainer_shell, extract_code

    try:
        runner = OpenSCADRunner()
    except CADExecutableNotFound:
        runner = None
        print("[WARNING] OpenSCAD runner недоступен — только статическая проверка")

    shells: dict[str, object] = {}

    def shell(canvas: str):
        if canvas not in shells:
            print(f"[load] canvas={canvas} …")
            started = time.time()
            shells[canvas] = build_trainer_shell(types.SimpleNamespace(
                layer=canvas,
                checkpoint=args.checkpoint if canvas == "voxel" else None,
                backbone_dir=args.backbone_dir,
                zero_point_dir=args.zero_point_dir,
                device=args.device,
            ))
            print(f"[load] canvas={canvas} готов за {time.time() - started:.1f} с")
        return shells[canvas]

    records: list[dict] = []
    for case in cases:
        canvas = case["canvas"]
        trainer = shell(canvas)
        specs = specs_for_case(case, canvas)
        text = build_text(case, specs, canvas)
        spatial_bbox = specs.bbox if specs is not None else (
            tuple(float(v) for v in case["expected_bbox"]) if case.get("expected_bbox")
            else (100.0, 100.0, 100.0)
        )
        inputs = trainer.tokenizer(text, add_special_tokens=False, return_tensors="pt")
        log_bbox = torch.log(torch.tensor([list(spatial_bbox)], dtype=torch.float32))

        started = time.time()
        with torch.inference_mode():
            trainer.hook.set_context(inputs["input_ids"], spatial_fn=trainer._spatial_fn(log_bbox))
            try:
                generated = trainer.backbone.generate(
                    input_ids=inputs["input_ids"].to(trainer.device),
                    attention_mask=inputs["attention_mask"].to(trainer.device),
                    max_new_tokens=args.max_new_tokens,
                    do_sample=False,
                    pad_token_id=trainer.tokenizer.pad_token_id,
                )
            finally:
                trainer.hook.clear_context()
        elapsed = time.time() - started
        continuation = trainer.tokenizer.decode(
            generated[0, inputs["input_ids"].shape[1]:], skip_special_tokens=False
        )
        code = extract_code(continuation)

        record = {
            "name": case["name"],
            "note": case.get("note", ""),
            "canvas": canvas,
            "mode": case["mode"],
            "prompt": case["prompt"],
            "specs_text": specs.render() if specs is not None else None,
            "spatial_bbox": list(spatial_bbox),
            "expected_bbox": case.get("expected_bbox"),
            "elapsed_s": round(elapsed, 1),
            "code": code,
            "code_chars": len(code),
            "compiled": False,
            "error": None,
            "is_watertight": None,
            "components_count": None,
            "actual_bbox": None,
            "bbox_relative_error": None,
        }

        scad_path = args.out / f"{case['name']}.scad"
        scad_path.write_text(code, encoding="utf-8")
        png_path = args.out / "png" / f"{case['name']}.png"

        if not code.startswith("$fn = 32;"):
            record["error"] = "нет заголовка $fn = 32;"
        elif runner is not None:
            result = runner.compile(code)
            record["compiled"] = result.error is None
            record["is_watertight"] = result.is_watertight
            record["components_count"] = result.components_count
            record["actual_bbox"] = list(result.bbox) if result.bbox else None
            record["error"] = result.error
            if result.error is None and result.bbox and case.get("expected_bbox"):
                record["bbox_relative_error"] = round(max(
                    abs(a - e) / e for a, e in zip(result.bbox, case["expected_bbox"])
                ), 3)

        if record["compiled"] or code.startswith("$fn = 32;"):
            command = [openscad, "-o", str(png_path), f"--imgsize={args.size},{args.size}",
                       "--colorscheme=Metallic", "--projection=o", "--viewall", "--autocenter", str(scad_path)]
            try:
                subprocess.run(command, capture_output=True, timeout=300, check=False)
                if png_path.exists():
                    flatten_on_white(png_path)
            except Exception as exc:  # noqa: BLE001
                record["error"] = f"{record['error'] or ''} render: {exc}"[:300]

        records.append(record)
        print(f"[{case['name']}] compiled={record['compiled']} "
              f"bbox={record['actual_bbox']} err={record['bbox_relative_error']} ({elapsed:.0f} с)")

    with (args.out / "cases.jsonl").open("w", encoding="utf-8", newline="\n") as handle:
        for record in records:
            handle.write(json.dumps(record, ensure_ascii=False) + "\n")

    write_report(records, args.out)
    build_overview(records, args.out)
    print(f"готово → {args.out}")
    return 0


def write_report(records: list[dict], out_dir: Path) -> None:
    with (out_dir / "report.md").open("w", encoding="utf-8", newline="\n") as handle:
        handle.write("# Проба [SPECS]: один промпт в разных условиях\n\n")
        handle.write("| случай | режим | canvas | specs в промпте | ожид. bbox | факт. bbox | err | compile |\n")
        handle.write("|---|---|---|---|---|---|---|---|\n")
        for record in records:
            specs_line = (record["specs_text"] or "— нет —").replace("\n", " / ")
            handle.write(
                f"| {record['name']} | {record['mode']} | {record['canvas']} | {specs_line} | "
                f"{record.get('expected_bbox') or '—'} | {record.get('actual_bbox') or '—'} | "
                f"{record.get('bbox_relative_error') if record.get('bbox_relative_error') is not None else '—'} | "
                f"{record['compiled']} |\n"
            )
        handle.write("\n## Промпты и заметки\n\n")
        for record in records:
            handle.write(f"### {record['name']}\n\n")
            handle.write(f"- заметка: {record['note']}\n")
            handle.write(f"- промпт: {record['prompt']}\n")
            handle.write(f"- specs: `{(record['specs_text'] or 'нет').replace(chr(10), ' | ')}`\n")
            handle.write(f"- ожидаемый bbox: {record.get('expected_bbox')} · фактический: {record.get('actual_bbox')}\n")
            handle.write(f"- изображение: `png/{record['name']}.png` · код: `{record['name']}.scad`\n\n")


def build_overview(records: list[dict], out_dir: Path) -> None:
    from PIL import Image, ImageDraw, ImageFont

    try:
        font = ImageFont.truetype("arial.ttf", 16)
    except OSError:
        font = ImageFont.load_default()
    thumb = 288
    label_h = 46
    pad = 10
    cols = min(4, len(records)) or 1
    rows = (len(records) + cols - 1) // cols
    sheet = Image.new("RGB", (cols * (thumb + pad) + pad, rows * (thumb + label_h + pad) + pad), (255, 255, 255))
    draw = ImageDraw.Draw(sheet)
    for index, record in enumerate(records):
        col, row = index % cols, index // cols
        x = pad + col * (thumb + pad)
        y = pad + row * (thumb + label_h + pad)
        image_path = out_dir / "png" / f"{record['name']}.png"
        draw.rectangle([x, y, x + thumb, y + thumb], outline=(200, 200, 200))
        if image_path.exists():
            with Image.open(image_path) as image:
                image = image.convert("RGB")
                scale = min(thumb / image.width, thumb / image.height)
                resized = image.resize((max(1, int(image.width * scale)), max(1, int(image.height * scale))), Image.LANCZOS)
            sheet.paste(resized, (x + (thumb - resized.width) // 2, y + (thumb - resized.height) // 2))
        draw.text((x + 2, y + thumb + 2), record["name"], fill=(20, 20, 20), font=font)
        draw.text((x + 2, y + thumb + 22), f"target={record.get('expected_bbox')}", fill=(90, 90, 90), font=font)
    sheet.save(out_dir / "overview.png", "PNG")


if __name__ == "__main__":
    raise SystemExit(main())
