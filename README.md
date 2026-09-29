# OmniCraft-LM

CPU-first scaffolding for the Qwen3.5-2B spatial bridge, procedural OpenSCAD data, and trust-aware CAD validation. CUDA and OpenSCAD are optional at import/test time; validated mesh production uses OpenSCAD's manifold backend when installed.

**Hardware status:** verified end-to-end on the target workstation — NVIDIA GeForce RTX 5060 Ti (sm_120, 15.93 GiB VRAM, native bfloat16) + OpenSCAD 2025.12.17 with the Manifold backend. All spatial canvases run on CUDA in bfloat16 (`tests/test_cuda_smoke.py`) and peak canvas activation memory stays around ~250 MiB at batch 64, far below the 14.2 GiB VRAM budget reserved for the frozen backbone.

## Install

Choose the PyTorch wheel for the target machine first. For a CPU-only Python environment:

```bash
python -m venv .venv
# Linux/macOS
source .venv/bin/activate
# Windows PowerShell: .venv\Scripts\Activate.ps1
python -m pip install --index-url https://download.pytorch.org/whl/cpu "torch>=2.5"
python -m pip install -r requirements-dev.txt
```

For CUDA, use the matching wheel command from the official PyTorch install selector in place of the CPU-wheel command. Modules select `cuda` dynamically and use bfloat16 there; CPU paths use float32. No Triton or static KV cache is used.

## Generate and validate a dataset

Generation creates **candidates**, not claimed CAD-verified records:

```bash
python tools/prepare_dataset.py \
  --voxel-count 1000 --wire-count 1000 --seed 1234 \
  --output data/processed/candidates.jsonl
```

Then run the validator:

```bash
python tools/validate_dataset.py \
  --input data/processed/candidates.jsonl \
  --backend auto --workers 1
```

The validator writes separate `*.accepted.jsonl`, `*.provisional.jsonl`, `*.rejected.jsonl`, and a per-record report. `auto` selects OpenSCAD if it is present; otherwise it performs static and analytic checks and leaves records provisional. Exact analytic CSG records can be admitted explicitly without an STL using `--allow-analytic`; wireframes remain provisional until their mesh is compiled. Use `--backend openscad` to require CAD, or `--backend mock` only to smoke-test integration. **Mock results are never accepted as CAD validation.** Repeated runs use a cache scoped to input content, backend version, and validation policy.

OpenSCAD validation checks CLI success, STL loading, finite positive volume and bounds, watertightness, component count, bbox tolerance, Euler consistency, and (where available) analytic volume/topology expectations. The default bbox and analytic volume tolerances are 15% and 5% respectively. `CADJsonlDataset` refuses provisional/unaccepted rows by default.

Split only the accepted dataset, grouping nearby geometry parameter ranges so close variants stay in one partition:

```bash
python tools/split_dataset.py \\
  --input data/processed/candidates.validation.accepted.jsonl \\
  --output-dir data/processed/splits --group-by kind-and-dimension
```

The split is deterministic and writes a manifest of group assignments. For very small corpora a partition may be empty; the tool reports this rather than splitting related variants across sets.

## Tests and diagnostics

```bash
python -m pytest -q
python -m src.utils.system_check
```

The OpenSCAD integration test is skipped when the executable is not installed. Static/analytic validation and the deterministic mock backend remain usable on CPU-only machines. The CUDA smoke suite (`tests/test_cuda_smoke.py`) is skipped without a GPU; on the target RTX 5060 Ti it verifies bfloat16 execution of the full spatial stack, backward-gradient flow, and prefill-only hook injection.

`system_check` probes CUDA name/VRAM/compute capability (expecting sm_120), native bfloat16 support, the offline Hugging Face variables, the OpenSCAD version, and a real `--backend=manifold` probe compile.

## Canvas benchmark

```bash
python tools/benchmark_canvases.py --device cuda --batch-sizes 1 16 64 --iterations 30
```

Measures per-module latency, throughput, and peak VRAM with the project device policy (bfloat16 on CUDA, float32 on CPU). On the RTX 5060 Ti every canvas keeps batch-1 latency in the low single-digit milliseconds; the heaviest modules (VoxelCanvas, WireCanvas) stay under ~8 ms, and peak VRAM at batch 64 is ~250 MiB.
