"""Train one spatial layer (bundle + LoRA) on the frozen local backbone.

    python tools/train_spatial.py --layer voxel --data data/processed/splits/train.jsonl --steps 20
    python tools/train_spatial.py --layer wire --data data/processed/splits/train.jsonl --steps 50
    python tools/train_spatial.py --layer voxel --rollback-only   # restore zero point and exit

The backbone is loaded strictly offline from ``--backbone-dir``. Initial
weights come from the hash-verified zero point, and every run saves its
artifacts under ``checkpoints/<layer>/`` (``trainer_state.json`` records the
zero-point identity the run started from).
"""

from __future__ import annotations

import argparse
import os
import sys
from pathlib import Path

REPOSITORY_ROOT = Path(__file__).resolve().parents[1]
if str(REPOSITORY_ROOT) not in sys.path:
    sys.path.insert(0, str(REPOSITORY_ROOT))

os.environ.setdefault("HF_HUB_OFFLINE", "1")
os.environ.setdefault("TRANSFORMERS_OFFLINE", "1")
# Cap cached blocks so long-seq logits buffers return to the driver instead of
# growing the cache to the card's ceiling (see docs/hardware-notes.md §1-2).
os.environ.setdefault(
    "PYTORCH_CUDA_ALLOC_CONF", "max_split_size_mb:512,garbage_collection_threshold:0.7"
)

from src.training.trainer import SPATIAL_TOKENS, SpatialTrainer, TrainerConfig


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--layer", required=True, choices=sorted(SPATIAL_TOKENS))
    parser.add_argument("--data", type=Path, default=Path("data/processed/splits/train.jsonl"))
    parser.add_argument("--backbone-dir", type=Path, default=Path("checkpoints/baseline_qwen35_2b"))
    parser.add_argument("--zero-point-dir", type=Path, default=Path("checkpoints/zero_point"))
    parser.add_argument("--output-dir", type=Path, default=Path("checkpoints"))
    parser.add_argument("--device", choices=("cuda", "cpu"), default="cuda")
    parser.add_argument("--steps", type=int, default=20)
    parser.add_argument("--accumulate", type=int, default=1)
    parser.add_argument("--microbatch", type=int, default=8, help="hard cap on samples per forward")
    parser.add_argument(
        "--max-tokens-per-forward",
        type=int,
        default=2000,
        help="token budget B*S per forward; CE logits keep ~4 copies (~4 MB per token on the 248320 vocab)",
    )
    parser.add_argument("--lr", type=float, default=2e-4)
    parser.add_argument("--warmup-steps", type=int, default=30)
    parser.add_argument("--lora-dropout", type=float, default=0.05)
    parser.add_argument("--max-vram-gb", type=float, default=14.0)
    parser.add_argument("--lambda-geom", type=float, default=0.1)
    parser.add_argument("--max-prompt-tokens", type=int, default=256)
    parser.add_argument("--max-code-tokens", type=int, default=768)
    parser.add_argument("--gradient-checkpointing", action="store_true")
    parser.add_argument("--save-every", type=int, default=0)
    parser.add_argument("--voxel-grids", type=Path, default=None, help="sidecar voxel-grid GT JSONL (voxel layer aux loss)")
    parser.add_argument("--log-every", type=int, default=1)
    parser.add_argument("--rollback-only", action="store_true", help="restore the zero point and exit")
    return parser


def main() -> int:
    args = build_parser().parse_args()
    config = TrainerConfig(
        layer=args.layer,
        data=args.data,
        backbone_dir=args.backbone_dir,
        zero_point_dir=args.zero_point_dir,
        output_dir=args.output_dir,
        device=args.device,
        max_steps=args.steps,
        accumulate=args.accumulate,
        microbatch=args.microbatch,
        max_tokens_per_forward=args.max_tokens_per_forward,
        voxel_grids=args.voxel_grids,
        lr=args.lr,
        lr_warmup_steps=args.warmup_steps,
        lora_dropout=args.lora_dropout,
        max_vram_gb=args.max_vram_gb,
        lambda_geom=args.lambda_geom,
        max_prompt_tokens=args.max_prompt_tokens,
        max_code_tokens=args.max_code_tokens,
        gradient_checkpointing=args.gradient_checkpointing,
        save_every=args.save_every,
        log_every=args.log_every,
    )
    trainer = SpatialTrainer(config)
    if args.rollback_only:
        trainer.rollback()
        saved = trainer.save(step=0)
        print(f"Rolled back to the zero point and saved the clean state to {saved}")
        return 0
    if not config.data.is_file():
        raise SystemExit(f"training data not found: {config.data}")
    if trainer.device.type == "cuda":
        properties = trainer.device and __import__("torch").cuda.get_device_properties(0)
        print(f"Backbone device: {trainer.device} ({properties.name})")
    print(
        f"recipe: lr={config.lr} (warmup {config.lr_warmup_steps}), accum={config.accumulate}, "
        f"microbatch={config.microbatch}, lora_dropout={config.lora_dropout}, "
        f"max_code_tokens={config.max_code_tokens}, vram ceiling={config.max_vram_gb} GiB"
    )
    trainer.train()
    saved = trainer.save(step=config.max_steps)
    print(f"Saved trained artifacts to {saved}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
