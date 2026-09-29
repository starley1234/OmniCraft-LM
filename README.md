# OmniCraft-LM

CPU-first scaffolding for the Qwen3.5-2B spatial bridge, procedural OpenSCAD data, and trust-aware CAD validation. CUDA and OpenSCAD are optional at import/test time; validated mesh production uses OpenSCAD's manifold backend when installed.

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

The OpenSCAD integration test is skipped when the executable is not installed. Static/analytic validation and the deterministic mock backend remain usable on CPU-only machines.
