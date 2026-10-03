"""Выборочные изометрические превью корпуса по семействам деталей.

Даёт агенту (без OpenSCAD) компактный визуальный срез обучающей выборки:
по одному детерминированному образцу на семейство, PNG 320x320 в изометрии,
машиночитаемый манифест и общий контактный лист с подписями.

Семейство берётся из `metadata.origin` (например `lbrackets`, `spurgears`,
`mounting_plate_bracket/chamfered_plate`). Строки без семейства пропускаются —
их природа выражена через `metadata.kind`, а не через происхождение.

    python tools/render_family_previews.py \
        --input data/processed/combined_v9_fixed.jsonl \
        --out data/previews/families_v9

Управление объёмом: `--per-family N`, `--max-images N`, `--families a,b,c`,
`--list-families` (только показать раскладку и выйти).
"""
from __future__ import annotations

import argparse
import concurrent.futures
import hashlib
import json
import math
import random
import re
import shutil
import subprocess
import sys
from pathlib import Path
from typing import Any

if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")

OPENSCAD_FALLBACKS = (
    Path(r"C:\Program Files\OpenSCAD\openscad.exe"),
    Path(r"C:\Program Files\OpenSCAD\openscad.com"),
    Path("/usr/bin/openscad"),
)
SAFE = re.compile(r"[^0-9A-Za-zА-Яа-яЁё._-]+")


def find_openscad() -> str:
    found = shutil.which("openscad") or shutil.which("openscad.com")
    if found:
        return found
    for candidate in OPENSCAD_FALLBACKS:
        if candidate.exists():
            return str(candidate)
    raise SystemExit("[MISSING] openscad не найден в PATH и стандартных путях")


def load_rows(path: Path) -> list[dict[str, Any]]:
    rows: list[dict[str, Any]] = []
    with path.open(encoding="utf-8") as handle:
        for line in handle:
            line = line.strip()
            if not line:
                continue
            rows.append(json.loads(line))
    return rows


def family_of(row: dict[str, Any], field: str) -> str | None:
    metadata = row.get("metadata") or {}
    value = metadata.get(field) or metadata.get("origin")
    if value is None:
        return None
    value = str(value).strip()
    return value or None


def safe_name(family: str) -> str:
    name = SAFE.sub("_", family).strip("._-")
    return name or "unnamed"


def first_prompt(row: dict[str, Any]) -> str:
    prompts = row.get("prompts") or {}
    if isinstance(prompts, str):
        return prompts
    for value in prompts.values():
        if isinstance(value, str) and value.strip():
            return value.strip()
    return ""


def flatten_on_white(png: Path) -> None:
    from PIL import Image

    with Image.open(png) as image:
        rgba = image.convert("RGBA")
        background = Image.new("RGBA", rgba.size, (255, 255, 255, 255))
        Image.alpha_composite(background, rgba).convert("RGB").save(png, "PNG")


def render_one(
    row: dict[str, Any],
    family: str,
    out_dir: Path,
    size: int,
    openscad: str,
    timeout: int,
    orthographic: bool,
) -> dict[str, Any]:
    stem = safe_name(family)
    scad_path = out_dir / "scad" / f"{stem}.scad"
    png_path = out_dir / "png" / f"{stem}.png"
    scad_path.parent.mkdir(parents=True, exist_ok=True)
    png_path.parent.mkdir(parents=True, exist_ok=True)
    scad_path.write_text(row.get("code", ""), encoding="utf-8")

    command = [
        openscad,
        "-o", str(png_path),
        f"--imgsize={size},{size}",
        "--colorscheme=Metallic",
        "--viewall",
        "--autocenter",
    ]
    if orthographic:
        command.append("--projection=o")
    command.append(str(scad_path))

    verification = row.get("verification") or {}
    metadata = row.get("metadata") or {}
    entry: dict[str, Any] = {
        "id": row.get("id"),
        "family": family,
        "image": f"png/{png_path.name}",
        "scad": f"scad/{scad_path.name}",
        "layer": row.get("layer"),
        "source": metadata.get("source"),
        "kind": metadata.get("kind"),
        "target_bbox": verification.get("target_bbox"),
        "prompt": first_prompt(row),
        "prompts": row.get("prompts"),
        "code_sha256": metadata.get("code_sha256"),
        "code_sha256_local": hashlib.sha256(row.get("code", "").encode("utf-8")).hexdigest(),
        "ok": False,
        "error": None,
    }
    try:
        completed = subprocess.run(
            command, capture_output=True, timeout=timeout, check=False
        )
        if completed.returncode != 0 or not png_path.exists():
            stderr = completed.stderr.decode("utf-8", "replace").strip().splitlines()
            entry["error"] = (stderr[-1] if stderr else f"rc={completed.returncode}")[:300]
            return entry
        flatten_on_white(png_path)
        entry["ok"] = True
    except subprocess.TimeoutExpired:
        entry["error"] = f"timeout {timeout}s"
    except Exception as exc:  # noqa: BLE001 — одна плохая деталь не рушит прогон
        entry["error"] = f"{type(exc).__name__}: {exc}"[:300]
    return entry


def load_font(size: int):
    from PIL import ImageFont

    for name in ("arial.ttf", "segoeui.ttf", "DejaVuSans.ttf"):
        try:
            return ImageFont.truetype(name, size)
        except OSError:
            continue
    return ImageFont.load_default()


def build_contact_sheets(
    entries: list[dict[str, Any]],
    out_dir: Path,
    thumb: int,
    columns: int,
    per_sheet: int,
) -> list[Path]:
    """Собирает контактные листы. per_sheet>0 режет на несколько листов,
    чтобы vision-модель не даунскейлила плитки и читала детали."""
    from PIL import Image, ImageDraw

    if not entries:
        return []
    font = load_font(15)
    label_h = 22
    pad = 8
    cell_w, cell_h = thumb, thumb + label_h
    if per_sheet <= 0 or per_sheet >= len(entries):
        chunks = [entries]
    else:
        chunks = [entries[i : i + per_sheet] for i in range(0, len(entries), per_sheet)]

    paths: list[Path] = []
    start = 0
    for sheet_index, chunk in enumerate(chunks, start=1):
        rows = math.ceil(len(chunk) / columns)
        sheet = Image.new(
            "RGB",
            (columns * (cell_w + pad) + pad, rows * (cell_h + pad) + pad),
            (255, 255, 255),
        )
        draw = ImageDraw.Draw(sheet)

        for local_index, entry in enumerate(chunk):
            index = start + local_index
            col, row_index = local_index % columns, local_index // columns
            x = pad + col * (cell_w + pad)
            y = pad + row_index * (cell_h + pad)
            image_path = out_dir / entry["image"]
            tile = Image.new("RGB", (cell_w, cell_h), (245, 245, 245))
            draw.rectangle([x, y, x + cell_w, y + cell_h], outline=(210, 210, 210))
            if image_path.exists():
                with Image.open(image_path) as image:
                    image = image.convert("RGB")
                    scale = min(cell_w / image.width, thumb / image.height)
                    resized = image.resize(
                        (max(1, int(image.width * scale)), max(1, int(image.height * scale))),
                        Image.LANCZOS,
                    )
                tile.paste(resized, ((cell_w - resized.width) // 2, (thumb - resized.height) // 2))
            else:
                draw.text((x + 6, y + thumb // 2), "render failed", fill=(180, 60, 60), font=font)
            sheet.paste(tile, (x, y))

            label = f"{index + 1}. {entry['family']}"
            bbox = entry.get("target_bbox")
            if isinstance(bbox, (list, tuple)) and len(bbox) == 3:
                label = f"{label}  {bbox[0]:.0f}x{bbox[1]:.0f}x{bbox[2]:.0f}"
            max_chars = max(8, cell_w // 9)
            if len(label) > max_chars:
                label = label[: max_chars - 1] + "…"
            draw.text((x + 2, y + thumb + 3), label, fill=(20, 20, 20), font=font)

        name = "contact_sheet.png" if len(chunks) == 1 else f"contact_sheet_{sheet_index:02d}.png"
        sheet_path = out_dir / name
        sheet.save(sheet_path, "PNG")
        paths.append(sheet_path)
        start += len(chunk)
    return paths


def write_verdict_template(entries: list[dict[str, Any]], path: Path) -> None:
    """Таблица, которую заполняет проверяющий агент: verdict/reason по каждому id."""
    import csv

    with path.open("w", encoding="utf-8", newline="") as handle:
        writer = csv.writer(handle)
        writer.writerow(
            ["index", "id", "family", "layer", "target_bbox", "image", "prompt", "verdict", "reason"]
        )
        for index, entry in enumerate(entries, start=1):
            bbox = entry.get("target_bbox")
            bbox_text = (
                "x".join(f"{v:.1f}" for v in bbox)
                if isinstance(bbox, (list, tuple)) and len(bbox) == 3
                else ""
            )
            writer.writerow(
                [
                    index,
                    entry.get("id"),
                    entry["family"],
                    entry.get("layer"),
                    bbox_text,
                    entry["image"],
                    entry.get("prompt", ""),
                    "",
                    "",
                ]
            )


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("--input", type=Path, default=Path("data/processed/combined_v9_fixed.jsonl"))
    parser.add_argument("--out", type=Path, default=Path("data/previews/families"))
    parser.add_argument("--family-field", default="origin", help="поле metadata (origin|kind|source)")
    parser.add_argument("--per-family", type=int, default=1)
    parser.add_argument("--max-images", type=int, default=0, help="0 = без лимита")
    parser.add_argument("--families", default="", help="список семейств через запятую")
    parser.add_argument("--size", type=int, default=320)
    parser.add_argument("--thumb", type=int, default=240)
    parser.add_argument("--columns", type=int, default=5)
    parser.add_argument(
        "--per-sheet", type=int, default=20,
        help="плиток на контактный лист; 0 = один общий лист",
    )
    parser.add_argument("--workers", type=int, default=8)
    parser.add_argument("--timeout", type=int, default=300)
    parser.add_argument("--seed", type=int, default=1234)
    parser.add_argument("--perspective", action="store_true", help="камера с перспективой (по умолчанию ортопроекция)")
    parser.add_argument("--list-families", action="store_true")
    args = parser.parse_args()

    if not args.input.exists():
        print(f"[MISSING] {args.input} не найден")
        return 4

    wanted = {f.strip() for f in args.families.split(",") if f.strip()}
    rng = random.Random(args.seed)
    buckets: dict[str, list[dict[str, Any]]] = {}
    counts: dict[str, int] = {}
    for row in load_rows(args.input):
        family = family_of(row, args.family_field)
        if family is None:
            continue
        counts[family] = counts.get(family, 0) + 1
        if wanted and family not in wanted:
            continue
        buckets.setdefault(family, []).append(row)

    if args.list_families:
        print(f"семейств: {len(counts)}  (вход {args.input})")
        for family, count in sorted(counts.items(), key=lambda item: (-item[1], item[0])):
            marker = " *" if not wanted or family in wanted else ""
            print(f"  {count:>6}  {family}{marker}")
        return 0

    if not buckets:
        print(f"[EMPTY] нет строк с семейством (field={args.family_field})")
        return 4

    selected: list[tuple[str, dict[str, Any]]] = []
    for family in sorted(buckets):
        rows = buckets[family]
        pick = rng.sample(rows, min(args.per_family, len(rows)))
        for row in pick:
            selected.append((family, row))
    if args.max_images and len(selected) > args.max_images:
        selected = selected[: args.max_images]

    openscad = find_openscad()
    args.out.mkdir(parents=True, exist_ok=True)
    print(f"OpenSCAD: {openscad}")
    print(f"Семейств: {len(buckets)}, к рендеру образцов: {len(selected)} → {args.out}")

    with concurrent.futures.ThreadPoolExecutor(max_workers=args.workers) as pool:
        futures = [
            pool.submit(
                render_one, row, family, args.out, args.size, openscad,
                args.timeout, not args.perspective,
            )
            for family, row in selected
        ]
        entries = [future.result() for future in concurrent.futures.as_completed(futures)]
    entries.sort(key=lambda entry: entry["family"])

    manifest = args.out / "manifest.jsonl"
    with manifest.open("w", encoding="utf-8", newline="\n") as handle:
        for entry in entries:
            handle.write(json.dumps(entry, ensure_ascii=False) + "\n")

    md = args.out / "manifest.md"
    with md.open("w", encoding="utf-8", newline="\n") as handle:
        handle.write("# Превью обучающей выборки по семействам\n\n")
        handle.write("## Для проверяющего агента (vision, без OpenSCAD)\n\n")
        handle.write("- Каждой строке соответствует один `id` корпуса — вердикт привязывается к нему.\n")
        handle.write("- Смотреть: сначала `contact_sheet_*.png` (листы по "
                     f"{args.per_sheet or len(entries)} деталей, без даунскейла), "
                     "спорное — в полном `png/<...>.png` (320x320).\n")
        handle.write("- Вердикт писать в `verdict_template.csv` (`verdict` = ok/bad, `reason`).\n")
        handle.write("- Текст модели для сверки — колонка `prompt`; ожидаемый габарит — `target_bbox`.\n\n")
        handle.write("## Параметры прогона\n\n")
        handle.write(f"- вход: `{args.input}`\n")
        handle.write(f"- поле семейства: `metadata.{args.family_field}`\n")
        handle.write(f"- семейств: {len(entries)} · отрендерено: "
                     f"{sum(1 for e in entries if e['ok'])}/{len(entries)}\n")
        handle.write(f"- размер: {args.size}x{args.size}, изометрия "
                     f"({'ортопроекция' if not args.perspective else 'перспектива'})\n\n")
        handle.write("## Таблица\n\n")
        handle.write("| # | id | семейство | слой | bbox (мм) | промпт | изображение |\n")
        handle.write("|---|---|---|---|---|---|---|\n")
        for index, entry in enumerate(entries, start=1):
            bbox = entry.get("target_bbox")
            bbox_text = "x".join(f"{v:.1f}" for v in bbox) if isinstance(bbox, (list, tuple)) else "?"
            prompt = (entry.get("prompt") or "").replace("|", "/").replace("\n", " ")
            if len(prompt) > 90:
                prompt = prompt[:89] + "…"
            status = "" if entry["ok"] else " ⚠"
            handle.write(
                f"| {index} | `{entry.get('id')}` | {entry['family']}{status} | {entry['layer']} | "
                f"{bbox_text} | {prompt} | `{entry['image']}` |\n"
            )

    verdict = args.out / "verdict_template.csv"
    write_verdict_template(entries, verdict)

    sheets = build_contact_sheets(entries, args.out, args.thumb, args.columns, args.per_sheet)
    failed = [entry["family"] for entry in entries if not entry["ok"]]
    print(f"готово: {sum(1 for e in entries if e['ok'])}/{len(entries)} PNG")
    if failed:
        print(f"не отрендерились ({len(failed)}): {', '.join(failed[:10])}"
              + (" …" if len(failed) > 10 else ""))
    for sheet in sheets:
        print(f"контактный лист: {sheet}")
    print(f"манифест: {manifest}")
    print(f"шаблон вердикта: {verdict}")
    return 0 if not failed else 1


if __name__ == "__main__":
    raise SystemExit(main())
