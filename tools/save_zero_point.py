"""Record the zero point: the rollback anchor taken before any training.

    python tools/save_zero_point.py --seed 1234
    python tools/save_zero_point.py --verify            # integrity check only

The command refuses to overwrite an existing anchor unless ``--force`` is given,
so a later training run can never silently destroy the rollback state.
"""

from __future__ import annotations

import argparse
import sys
from pathlib import Path

REPOSITORY_ROOT = Path(__file__).resolve().parents[1]
if str(REPOSITORY_ROOT) not in sys.path:
    sys.path.insert(0, str(REPOSITORY_ROOT))

from src.training.checkpoints import (
    ZERO_POINT_DIR_NAME,
    load_manifest,
    save_zero_point,
    verify_zero_point,
)

DEFAULT_DIRECTORY = Path("checkpoints") / ZERO_POINT_DIR_NAME


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--directory", type=Path, default=DEFAULT_DIRECTORY)
    parser.add_argument("--seed", type=int, default=1234, help="deterministic init seed")
    parser.add_argument("--layers", nargs="*", default=None, help="subset of canvas layers to anchor")
    parser.add_argument("--backbone", default="Qwen/Qwen3.5-2B")
    parser.add_argument("--backbone-revision", default=None, help="pinned backbone commit SHA")
    parser.add_argument("--verify", action="store_true", help="verify an existing anchor and exit")
    parser.add_argument("--force", action="store_true", help="overwrite an existing anchor")
    return parser


def main() -> int:
    args = build_parser().parse_args()
    if args.verify:
        violations = verify_zero_point(args.directory)
        manifest = load_manifest(args.directory)
        if violations:
            print(f"[CORRUPTED] {args.directory}:")
            for violation in violations:
                print(f"  - {violation}")
            return 1
        print(f"[OK] zero point at {args.directory} is intact")
        print(f"     seed={manifest.seed}, layers={', '.join(manifest.layers)}, "
              f"modules={len(manifest.payload['modules'])}, git={manifest.payload['git_commit'][:12]}")
        return 0
    manifest = save_zero_point(
        args.directory,
        seed=args.seed,
        layers=tuple(args.layers) if args.layers else None,
        backbone_name=args.backbone,
        backbone_revision=args.backbone_revision,
        force=args.force,
    )
    module_count = len(manifest.payload["modules"])
    print(f"Zero point recorded at {args.directory}: {module_count} module files, {manifest.payload['layers']}")
    print(f"  seed={manifest.seed}, git={manifest.payload['git_commit'][:12]}, torch={manifest.payload['torch_version']}")
    print(f"  backbone={manifest.payload['backbone']['name']} @ {manifest.payload['backbone']['revision']}")
    print("  Rollback: load_zero_point(stack, directory) + recreate LoRA adapters with the same seed.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
