"""Benchmark spatial canvases on the available device (latency and VRAM).

Usage:
    python tools/benchmark_canvases.py --device cuda --batch-sizes 1 16 64 --iterations 50
    python tools/benchmark_canvases.py --device cpu --batch-sizes 4 --iterations 10

The device policy matches training: bfloat16 on CUDA, float32 on CPU.
No Triton, no torch.compile — raw module forward passes only.
"""

from __future__ import annotations

import argparse
import sys
import time
from pathlib import Path

REPOSITORY_ROOT = Path(__file__).resolve().parents[1]
if str(REPOSITORY_ROOT) not in sys.path:
    sys.path.insert(0, str(REPOSITORY_ROOT))

import torch

from src.model.assembly_canvas import AssemblyCanvas
from src.model.brep_canvas import BRepCanvas
from src.model.device import get_compute_dtype
from src.model.latent_bridge import CANVAS_DIM, LLM_DIM, InProjector, OutProjector, ScaleMLP
from src.model.sketch_canvas import SketchCanvas
from src.model.voxel_canvas import VoxelCanvas
from src.model.wire_canvas import WireCanvas


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--device", choices=("auto", "cpu", "cuda"), default="auto")
    parser.add_argument("--batch-sizes", type=int, nargs="+", default=[1, 16, 64])
    parser.add_argument("--iterations", type=int, default=30)
    parser.add_argument("--warmup", type=int, default=5, help="unmeasured warmup iterations")
    return parser


def _resolve_device(requested: str) -> torch.device:
    if requested == "auto":
        return torch.device("cuda" if torch.cuda.is_available() else "cpu")
    device = torch.device(requested)
    if device.type == "cuda" and not torch.cuda.is_available():
        raise SystemExit("--device cuda requested but CUDA is not available")
    return device


def _canvas_inputs(batch: int, device: torch.device, dtype: torch.dtype) -> dict[str, tuple[torch.Tensor, ...]]:
    latent = torch.randn(batch, CANVAS_DIM, device=device, dtype=dtype)
    return {
        "ScaleMLP": (torch.full((batch, 3), 50.0, device=device, dtype=dtype),),
        "InProjector": (
            torch.randn(batch, LLM_DIM, device=device, dtype=dtype),
            torch.randn(batch, 128, device=device, dtype=dtype),
        ),
        "VoxelCanvas": (latent,),
        "WireCanvas": (latent,),
        "SketchCanvas": (torch.randn(batch, 16, 64, 64, device=device, dtype=dtype),),
        "BRepCanvas": (torch.randn(batch, 12, 32, device=device, dtype=dtype),),
        "AssemblyCanvas": (torch.eye(4, device=device, dtype=dtype).expand(batch, 8, 4, 4).contiguous(),),
        "OutProjector": (latent,),
    }


def benchmark(args: argparse.Namespace) -> list[tuple[str, int, float, float, float]]:
    device = _resolve_device(args.device)
    dtype = get_compute_dtype(device)
    modules = {
        "ScaleMLP": ScaleMLP(),
        "InProjector": InProjector(),
        "VoxelCanvas": VoxelCanvas(),
        "WireCanvas": WireCanvas(),
        "SketchCanvas": SketchCanvas(),
        "BRepCanvas": BRepCanvas(),
        "AssemblyCanvas": AssemblyCanvas(),
        "OutProjector": OutProjector(),
    }
    rows: list[tuple[str, int, float, float, float]] = []
    print(f"Device: {device} | dtype: {dtype} | iterations: {args.iterations} (+{args.warmup} warmup)")
    for name, module in modules.items():
        module = module.to(device=device, dtype=dtype).eval()
        for batch in args.batch_sizes:
            inputs = _canvas_inputs(batch, device, dtype)[name]
            with torch.inference_mode():
                for _ in range(args.warmup):
                    module(*inputs)
                if device.type == "cuda":
                    torch.cuda.synchronize()
                    torch.cuda.reset_peak_memory_stats()
                    start = time.perf_counter()
                    for _ in range(args.iterations):
                        module(*inputs)
                    torch.cuda.synchronize()
                else:
                    start = time.perf_counter()
                    for _ in range(args.iterations):
                        module(*inputs)
                elapsed = time.perf_counter() - start
            latency_ms = elapsed / args.iterations * 1000.0
            throughput = batch * args.iterations / elapsed if elapsed > 0 else float("inf")
            peak_mib = torch.cuda.max_memory_allocated() / 1024**2 if device.type == "cuda" else 0.0
            rows.append((name, batch, latency_ms, throughput, peak_mib))
            print(
                f"{name:15s} batch={batch:4d} | {latency_ms:8.3f} ms/iter | "
                f"{throughput:12.1f} samples/s | peak VRAM {peak_mib:9.1f} MiB"
            )
    return rows


def main() -> None:
    args = build_parser().parse_args()
    if args.iterations < 1 or args.warmup < 0 or not args.batch_sizes or min(args.batch_sizes) < 1:
        raise SystemExit("iterations must be >= 1, warmup >= 0, batch sizes >= 1")
    benchmark(args)


if __name__ == "__main__":
    main()
