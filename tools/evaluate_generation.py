"""Greedy-decode evaluation on the held-out prompt set.

For each prompt: tokenize ``prompt + <|spatial_<layer>|>``, run one prefilled
forward where the hook injects the trained canvas vector, greedily decode,
extract the OpenSCAD code, and verify it with the real manifold runner.

Reports JSONL + console summary: compile rate, watertight share, bbox errors
against ``expected_bbox_mm``, and optional code ECC/Euler diagnostics.

    python tools/evaluate_generation.py \
        --layer voxel \
        --checkpoint checkpoints/voxel \
        --eval-set optional_data/data/heldout_eval.jsonl \
        --limit 42
"""

from __future__ import annotations

import argparse
import json
import os
import sys
from pathlib import Path

REPOSITORY_ROOT = Path(__file__).resolve().parents[1]
if str(REPOSITORY_ROOT) not in sys.path:
    sys.path.insert(0, str(REPOSITORY_ROOT))

os.environ.setdefault("HF_HUB_OFFLINE", "1")
os.environ.setdefault("TRANSFORMERS_OFFLINE", "1")

import torch

from src.data.validation import has_top_level_object_statement
from src.env.openscad_runner import CADExecutableNotFound, OpenSCADRunner
from src.runtime.eval_specs import SPECS_MODES, specs_for_row
from src.training.trainer import SPATIAL_TOKENS, SpatialTrainer, TrainerConfig


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--layer", required=True, choices=sorted(SPATIAL_TOKENS))
    parser.add_argument("--checkpoint", type=Path, default=None, help="trained layer dir; omit for zero point")
    parser.add_argument("--eval-set", type=Path, required=True)
    parser.add_argument("--backbone-dir", type=Path, default=Path("checkpoints/baseline_qwen35_2b"))
    parser.add_argument("--zero-point-dir", type=Path, default=Path("checkpoints/zero_point"))
    parser.add_argument("--output", type=Path, default=None)
    parser.add_argument("--max-new-tokens", type=int, default=1024)
    parser.add_argument("--limit", type=int, default=None)
    parser.add_argument("--bbox-tolerance", type=float, default=0.15)
    parser.add_argument(
        "--specs-mode",
        choices=SPECS_MODES,
        default="auto",
        help=(
            "auto: oracle bbox when the row has expected_bbox_mm, else mined (default); "
            "mined: always the miner's reading of the text; "
            "none: no [SPECS] block (canvas still gets the mined bbox)"
        ),
    )
    parser.add_argument("--device", choices=("cuda", "cpu"), default="cuda")
    return parser


def build_trainer_shell(args: argparse.Namespace) -> SpatialTrainer:
    """Trainer used purely as an inference shell (no optimizer states touched)."""
    config = TrainerConfig(
        layer=args.layer,
        data=None,
        backbone_dir=args.backbone_dir,
        zero_point_dir=args.zero_point_dir,
        device=args.device,
    )
    trainer = SpatialTrainer(config)
    trainer.backbone.eval()
    trainer.stack.eval()
    if args.checkpoint is not None:
        trainer.load_trained_checkpoint(Path(args.checkpoint))
        print(f"Loaded trained checkpoint for layer {args.layer!r} from {args.checkpoint}")
    return trainer


def extract_code(text: str) -> str:
    """Pull the generated OpenSCAD program out of the decoded continuation."""
    if "$fn" in text:
        text = text[text.index("$fn"):]
    stop = text.find("<|im_end|>")
    if stop != -1:
        text = text[:stop]
    lines = [line for line in text.splitlines() if line.strip()]
    return "\n".join(lines).strip() + "\n"


def main() -> int:
    args = build_parser().parse_args()
    trainer = build_trainer_shell(args)
    try:
        runner = OpenSCADRunner()
    except CADExecutableNotFound:
        print("[WARNING] OpenSCAD not available; generation will be scored by static checks only")
        runner = None

    rows = [json.loads(line) for line in args.eval_set.read_text(encoding="utf-8").splitlines() if line.strip()]
    if args.limit:
        rows = rows[: args.limit]

    trigger = SPATIAL_TOKENS[args.layer]
    report_rows: list[dict] = []
    compiled = watertight = bbox_hits = 0
    from src.runtime.specs_hook import build_prompt_with_specs

    for index, row in enumerate(rows):
        prompt = row["prompt"]
        specs, bbox = specs_for_row(row, layer=args.layer, mode=args.specs_mode)
        expected = row.get("expected_bbox_mm")
        body = build_prompt_with_specs(prompt, specs) if specs is not None else f"{prompt}\n"
        text = f"{body}{trigger}\n"
        inputs = trainer.tokenizer(text, add_special_tokens=False, return_tensors="pt")
        input_ids = inputs["input_ids"].to(trainer.device)
        attention = inputs["attention_mask"].to(trainer.device)
        log_bbox = torch.log(torch.tensor([list(bbox)], dtype=torch.float32))

        with torch.inference_mode():
            trainer.hook.set_context(
                input_ids.cpu(), spatial_fn=trainer._spatial_fn(log_bbox)
            )
            try:
                generated = trainer.backbone.generate(
                    input_ids=input_ids,
                    attention_mask=attention,
                    max_new_tokens=args.max_new_tokens,
                    do_sample=False,
                    pad_token_id=trainer.tokenizer.pad_token_id,
                )
            finally:
                trainer.hook.clear_context()
        continuation = trainer.tokenizer.decode(
            generated[0, input_ids.shape[1]:], skip_special_tokens=False
        )
        code = extract_code(continuation)
        record = {
            "id": row.get("id", f"row_{index}"),
            "specs_mode": args.specs_mode,
            "specs_bbox": list(bbox),
            "code_chars": len(code),
            "expected_bbox_mm": expected,
            "code": code,
        }
        if not code.startswith("$fn = 32;"):
            record.update(compiled=False, error="missing canonical $fn header")
        elif not has_top_level_object_statement(code):
            record.update(compiled=False, error="no top-level object-producing statement")
        elif runner is not None:
            result = runner.compile(code)
            record["compiled"] = result.error is None
            record["is_watertight"] = result.is_watertight
            record["components_count"] = result.components_count
            record["actual_bbox"] = result.bbox
            record["error"] = result.error
            if result.error is None:
                compiled += 1
                if result.is_watertight:
                    watertight += 1
                if result.bbox is not None and expected:
                    error = max(
                        abs(a - e) / e for a, e in zip(result.bbox, [float(v) for v in expected])
                    )
                    record["bbox_relative_error"] = error
                    if error <= args.bbox_tolerance:
                        bbox_hits += 1
        report_rows.append(record)
        print(
            f"[{index + 1}/{len(rows)}] {record['id']}: compiled={record.get('compiled')}, "
            f"bbox_err={record.get('bbox_relative_error')}"
        )

    total = len(rows)
    output = args.output or Path("data/processed") / f"eval_{args.layer}.jsonl"
    output.parent.mkdir(parents=True, exist_ok=True)
    with output.open("w", encoding="utf-8", newline="\n") as stream:
        for record in report_rows:
            stream.write(json.dumps(record, ensure_ascii=False) + "\n")
    print("---")
    print(f"specs mode:    {args.specs_mode}")
    print(f"compile rate:  {compiled}/{total} ({(compiled / total * 100) if total else 0:.0f}%)")
    print(f"watertight:    {watertight}/{total}")
    print(f"bbox within {args.bbox_tolerance:.0%}: {bbox_hits}/{total}")
    print(f"report: {output}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
