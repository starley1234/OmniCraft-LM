"""Замер инференса: сколько стоит загрузка холста и сколько — генерация токена.

Нужен, чтобы отделить «долго грузится» от «медленно считает» и сравнить
Windows (WDDM) с WSL2 одними и теми же числами.

    python tools/bench_generate.py --layer voxel --new-tokens 128
"""
from __future__ import annotations

import argparse
import sys
import time
import types
from pathlib import Path

import torch

REPOSITORY_ROOT = Path(__file__).resolve().parents[1]
if str(REPOSITORY_ROOT) not in sys.path:
    sys.path.insert(0, str(REPOSITORY_ROOT))

if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")

PROMPT = "Сделай фланец 60x60x10 мм с центральным отверстием 20 мм"


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--layer", default="voxel")
    parser.add_argument("--new-tokens", type=int, default=128)
    parser.add_argument("--repeat", type=int, default=2)
    parser.add_argument("--prompt", default=PROMPT)
    args = parser.parse_args()

    from src.runtime.specs_hook import build_prompt_with_specs, compose_specs, extract_specs_from_text
    from src.training.trainer import SPATIAL_TOKENS
    from tools.evaluate_generation import build_trainer_shell

    device = "cuda" if torch.cuda.is_available() else "cpu"
    checkpoint = Path("checkpoints") / args.layer

    started = time.time()
    trainer = build_trainer_shell(types.SimpleNamespace(
        layer=args.layer,
        checkpoint=checkpoint if (checkpoint / "canvas.pt").is_file() else None,
        backbone_dir=Path("checkpoints/baseline_qwen35_2b"),
        zero_point_dir=Path("checkpoints/zero_point"),
        device=device,
    ))
    load_s = time.time() - started
    print(f"загрузка холста {args.layer}: {load_s:.1f} с (device={device})")

    mined = extract_specs_from_text(args.prompt)
    specs = compose_specs(object_class=mined.object_class, bbox=mined.bbox,
                          canvas=args.layer, topology=mined.topology)
    text = f"{build_prompt_with_specs(args.prompt, specs)}{SPATIAL_TOKENS[args.layer]}\n"
    inputs = trainer.tokenizer(text, add_special_tokens=False, return_tensors="pt")
    log_bbox = torch.log(torch.tensor([list(specs.bbox)], dtype=torch.float32))

    for run in range(1, args.repeat + 1):
        if device == "cuda":
            torch.cuda.synchronize()
        started = time.time()
        with torch.inference_mode():
            trainer.hook.set_context(inputs["input_ids"], spatial_fn=trainer._spatial_fn(log_bbox))
            try:
                generated = trainer.backbone.generate(
                    input_ids=inputs["input_ids"].to(trainer.device),
                    attention_mask=inputs["attention_mask"].to(trainer.device),
                    max_new_tokens=args.new_tokens,
                    do_sample=False,
                    pad_token_id=trainer.tokenizer.pad_token_id,
                )
            finally:
                trainer.hook.clear_context()
        if device == "cuda":
            torch.cuda.synchronize()
        elapsed = time.time() - started
        produced = generated.shape[1] - inputs["input_ids"].shape[1]
        print(f"прогон {run}: {produced} токенов за {elapsed:.1f} с = "
              f"{produced / max(elapsed, 1e-6):.2f} ток/с ({elapsed / max(produced, 1) * 1000:.0f} мс/токен)")

    if device == "cuda":
        print(f"VRAM: {torch.cuda.memory_allocated() / 2**30:.2f} ГиБ выделено, "
              f"{torch.cuda.memory_reserved() / 2**30:.2f} ГиБ зарезервировано")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
