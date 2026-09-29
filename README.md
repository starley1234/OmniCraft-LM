# OmniCraft-LM

CPU-first scaffolding for the Qwen3.5-2B spatial bridge, procedural OpenSCAD data, and trust-aware CAD validation. CUDA and OpenSCAD are optional at import/test time; validated mesh production uses OpenSCAD's manifold backend when installed.

**Hardware status:** verified end-to-end on the target workstation — NVIDIA GeForce RTX 5060 Ti (sm_120, 15.93 GiB VRAM, native bfloat16) + OpenSCAD 2025.12.17 with the Manifold backend. All spatial canvases run on CUDA in bfloat16 (`tests/test_cuda_smoke.py`) and peak canvas activation memory stays around ~250 MiB at batch 64, far below the 14.2 GiB VRAM budget reserved for the frozen backbone.

**Start here: [docs/RUNBOOK.md](docs/RUNBOOK.md)** — пошаговая человеко-читаемая инструкция (проверка среды → данные → обучение в WSL2 → оценка → откат → симптомы/лечение).

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

## WSL2 (recommended for training on Windows hosts)

On WDDM the host→GPU kernel dispatch costs ~32 µs per launch (Linux: ~5 µs); the Qwen3.5 hybrid attention is dispatch-heavy, so training on raw Windows starves the GPU at ~15% utilization. WSL2 removes that tax (see `docs/hardware-notes.md` §4). One-time setup, then identical commands:

```powershell
wsl -d Ubuntu -- bash /mnt/c/github/OmniCraft-LM/tools/wsl_bootstrap.sh   # once
wsl -d Ubuntu -- bash tools/wsl_train.sh                                  # from ~/omnicraft/repo runs
```

The workspace lives at `~/omnicraft/repo` (a copy — checkpoints there are Linux-side; pull trained artifacts back with `rsync -a ~/omnicraft/repo/checkpoints/<layer>/ /mnt/c/github/OmniCraft-LM/checkpoints/<layer>/`). Data regenerates identically inside WSL (generators are seed-deterministic), including the `$fn = 32;` invariant, with OpenSCAD 2025.12.17 parity. Run `python -m src.utils.system_check` inside WSL to verify CUDA + manifold before any long run.

## Train a spatial layer (GPU)

Weights live locally and read-only at `checkpoints/baseline_qwen35_2b/` (Qwen3.5-2B, pinned revision `15852e8c`). The deterministic **zero point** sits at `checkpoints/zero_point/` (recorded via `tools/save_zero_point.py`, integrity-checked by SHA-256 per module) and anchors every rollback.

```bash
python tools/train_spatial.py --layer voxel --data data/processed/splits/train.jsonl --steps 20
python tools/train_spatial.py --layer wire  --data data/processed/splits/train.jsonl --steps 50
```

The trainer freezes the backbone, mounts an isolated `lora_<layer>` adapter (r=16, alpha=32), and lets `L_LM` gradients flow through `In-Projector -> Canvas -> Out-Projector` via the prefill hook at layer 12 in a single pass. The wire layer additionally optimizes `L_aux = Chamfer(nodes) + BCE(edges)` with `lambda_geom = 0.1`. Trained artifacts land in `checkpoints/<layer>/` (bundle state, PEFT adapter, `trainer_state.json`).

Rollback after a failed run restores the zero point bit-exactly and recreates the adapter (`lora_B = 0` is the gradient-identity state):

```bash
python tools/train_spatial.py --layer voxel --rollback-only
```

## Import external corpora and evaluate generation

External OpenSCAD corpora (e.g. `optional_data/`) are canonicalized to the `$fn = 32;` schema and then validated with the same trust pipeline (mesh verdicts only — no generator provenance):

```bash
python tools/import_external_scad.py \
  --domain-expansion optional_data/data/domain_expansion.jsonl \
  --parts-dir optional_data/data/parts --fill-bbox-with-openscad --workers 8 \
  --output data/processed/external_candidates.jsonl
python tools/validate_dataset.py --input data/processed/external_candidates.jsonl --backend openscad --workers 12
```

Greedy-decode a trained layer against a held-out prompt set and verify every output with the manifold runner (compile rate, watertight share, bbox error):

```bash
python tools/evaluate_generation.py \
  --layer voxel --checkpoint checkpoints/voxel \
  --eval-set optional_data/data/heldout_eval.jsonl
```

`heldout_eval.jsonl` stays hold-out only — never merge it into training splits.

## Canvas benchmark

```bash
python tools/benchmark_canvases.py --device cuda --batch-sizes 1 16 64 --iterations 30
```

Measures per-module latency, throughput, and peak VRAM with the project device policy (bfloat16 on CUDA, float32 on CPU). On the RTX 5060 Ti every canvas keeps batch-1 latency in the low single-digit milliseconds; the heaviest modules (VoxelCanvas, WireCanvas) stay under ~8 ms, and peak VRAM at batch 64 is ~250 MiB.
