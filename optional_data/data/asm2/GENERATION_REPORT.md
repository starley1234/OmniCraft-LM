# asm2 corpus - generation report

Audit sheet for `optional_data/data/asm2` (request 5, block A2). Not part of the training data - the corpus is `manifest.jsonl` plus the `.scad` files.

- generated: 2026-10-01, seed `Rng(family, index)` with fixed seed 20261001
- samples: **1020** scenes across **6** families (170 each), **5958 placed instances**
- corpus size: 4288.7 KiB of text (manifest + 1020 sources)
- `manifest.jsonl` sha256: `5ae1b62f0d42075b6a622b2e1d8276af34d4149f31a226f9ca4522349d4c22c9`
- generator: `tools/dataset_asm2/` (`core2b.py`, `parts2b.py`, `scenes2b.py`, `build_asm2.py`, `verify_asm2.py`); reuses asm1's `parts2.py` part library
- **OpenSCAD CLI on the generation machine: absent.** Every check below ran on the manifold3d + trimesh stack (the kernel OpenSCAD uses with `--backend=manifold`). Final acceptance requires a real `openscad --backend=manifold` run on the receiving side.
- local gate per scene: modules argument-less and defined exactly once, ordered `translate/rotate` calls match the manifest placements, rotations are multiples of 45° about one grid axis, every instance evaluated alone to one solid with its designed volume (2 %), world bounds predicted and confirmed, pairwise clearance via `manifold.min_gap`, full STL round trip of scene and parts
- clearance audit: **smallest pairwise gap 0.2500 mm** (request asks ≥ 0.2 mm) - **0 clearance violations**
- placement audit: **5958 manifest rows replayed against the code, 0 mismatching**; w-last quaternions are grid rotations
- overlap audit: worst |sum(instance volumes) − scene volume| = **0.0000 %** - nothing overlaps, nothing is dropped
- bbox audit: worst axis deviation vs `expected_bbox_mm` **0.0012 %** (receiver tolerance 15 %)
- **repeated modules** (the point of the second pass): **510 scenes instantiate one module several times** - `flangebolt` (4/8 bolts per circle), `framecube` (4 corner posts), `cartwheel` (2 wheels); module names unique per file, instances distinct in the manifest
- every instance call carries its own `color([r, g, b])`
- independent re-audit from disk (`verify_asm2.py`): 1020 rows, **sha256 list ok, duplicate RU/EN prompts 0/0, problems: none**
- build rejects: 10 deliberate draw-rejects (flange/bolt-circle geometry that admitted no valid bolt circle)

## Families

| family | samples | instances | what it contains |
| --- | ---: | --- | --- |
| `shaftstation` | 170 | 5 | shaft on two bearings inside a housing cup, cover on top |
| `motorbelt` | 170 | 8 | motor on a bracket plate, two flanged pulleys, shafts, flat racetrack belt (`concat` of `for` comprehensions, 45° arc sampling) |
| `flangebolt` | 170 | 7 / 11 | flange + gasket + cover + **4 or 8 bolts on a circle (one bolt module, N calls)** |
| `framecube` | 170 | 6 | base frame with sockets, **4 identical corner posts (one module)**, top frame |
| `cartwheel` | 170 | 4 | fork + **2 identical wheels (one module)** + shared axle |
| `hinge` | 170 | 3 | comb-style butt hinge, moving leaf swung 0/45/90°, pin through all teeth |

Scene sizes 3..11 instances (request block A2 is silent on the count; asm1 shipped 2-6).

## Re-verification

```bash
python tools/dataset_asm2/verify_asm2.py --parts-dir optional_data/data/asm2 [--stl]
# receiving side (the only legitimate acceptance):
openscad --backend=manifold -o /tmp/check.stl optional_data/data/asm2/<family>/scene_NNNN.scad
python tools/verify_delivery.py optional_data/data/asm2
```
