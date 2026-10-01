# wire2 corpus - generation report

Audit sheet for `optional_data/data/wire2` (request 5, block W2). Not part of the training data - the corpus is `manifest.jsonl` plus the `.scad` files.

- generated: 2026-10-01, seed `Rng(family, index)` with fixed seed 20261001
- samples: **1560** across **6** families (260 each)
- corpus size: 7485.0 KiB of text (manifest + 1560 sources)
- `manifest.jsonl` sha256: `d1603ce1932026ea02f78b1c0d4f38a74b6f541bbd4458f004544d7c1954530f`
- generator: `tools/dataset_wire2/` (`families2w.py`, `build_wire2.py`, `verify_wire2.py`), shared kit `tools/dataset_v5/kit.py`
- **OpenSCAD CLI on the generation machine: absent.** Every check below ran on the manifold3d + trimesh stack (the kernel OpenSCAD uses with `--backend=manifold`). Final acceptance requires a real `openscad --backend=manifold` run on the receiving side.
- local gate per sample: `$fn = 32;` header, forbidden-construct scan, ≤ 12 KiB, manifold evaluation to a single solid, declared-vs-measured bbox ≤ 3 %, graph replay (nodes/edges against the code literals), edge length > 2 × member radius
- graph audit: **0 disconnected graphs, 0 isolated nodes, 0 zero-length edges**; node counts 6..25, edge counts 5..88; member radii 1.5..5 mm
- independent re-audit from disk (`verify_wire2.py`, trusts nothing from the build): 1560 rows re-evaluated, **sha256 bad 0, duplicate RU/EN prompts 0/0, problems: 0 rows failed**
- build rejects: 248 deliberate draw-rejects (mostly masttowers "top ring too narrow for the brace pattern") - rejected draws never reach disk
- prompt uniqueness: 1560 distinct RU and EN prompts; RU/EN both on every row

## Families

| family | samples | what it contains |
| --- | ---: | --- |
| `bridgetrusses` | 260 | planar Warren/Pratt-style trusses, deck chords, verticals, diagonals |
| `guymasts` | 260 | central mast with radial guy levels anchored to ground rings |
| `masttowers` | 260 | tapered lattice towers with ring braces (draws with too-narrow top rings are rejected) |
| `piperoutes` | 260 | axis-aligned pipe runs with elbow joints on a walk |
| `rollcages` | 260 | closed-loop cages with hoops and diagonals |
| `spaceframes` | 260 | 3-D tetra/octa space frames between two chords |

## Documented deviations

- **Node cap 32 instead of the requested up-to-64**: `src/training/aux_losses.py::wire_auxiliary_loss` raises for GT graphs above 32 vertices and `src/model/wire_canvas.py` is fixed at a 32-vertex canvas, so no sample exceeds 32 nodes (actual maximum in the corpus: 25).
- Pipe members are cylinder members with fatter joint spheres, not hull capsules: near-tangential hull chains decomposed into two solids via hair-thin flaps on the manifold kernel.

## Re-verification

```bash
python tools/dataset_wire2/verify_wire2.py --parts-dir optional_data/data/wire2   # local, no OpenSCAD
# receiving side (the only legitimate acceptance):
openscad --backend=manifold -o /tmp/check.stl optional_data/data/wire2/<family>/scene_NNNN.scad
python tools/verify_delivery.py optional_data/data/wire2
```
