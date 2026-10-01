# sketch3 corpus - generation report

Audit sheet for `optional_data/data/sketch3` (delivery no. 6). Not part of the training data - the corpus is `manifest.jsonl` plus the `.scad` files.

- generated: 2026-10-01, seed `Rng(family, index)` with fixed seed 20261001
- samples: **1250** across **5** families (250 each), 500 of them carry through-voids
- corpus size: ~7.1 MiB of text (manifest + 1250 sources)
- `manifest.jsonl` sha256: `ce37701b2c116ffa96ab06e497becdb9c583fe5e41ee72c22964b8e98b07066d`
- generator: `tools/dataset_sketch3/` (`families3s.py`, `build_sketch3.py`), shared core `tools/dataset_sketch2/core2s.py`, kit `tools/dataset_v5/kit.py`
- **OpenSCAD CLI on the generation machine: absent.** Every check ran on the manifold3d + trimesh stack (the kernel OpenSCAD uses with `--backend=manifold`). Final acceptance requires a real `openscad --backend=manifold` run on the receiving side.
- local gate per sample: `$fn = 32;` header, forbidden-construct scan, ≤ 12 KiB, manifold evaluation to a single solid, declared-vs-measured bbox ≤ 3 %, profile replay (CCW 6..64 points, simple polygon), void containment/overlap checks, place1 consistency law on both prompts
- profile points 6..52; every extrude is `linear` in this corpus (rotate-extrude lives in sketch1/sketch2)
- independent re-audit from disk (`verify_sketch2.py --parts-dir optional_data/data/sketch3`): 1250 rows re-evaluated, **sha256 bad 0, duplicate RU/EN prompts 0/0, problems: 0 rows failed**
- build rejects: 0 audit rejects (a handful of deliberate draw-retries)
- prompt uniqueness: 1250 distinct RU and EN prompts; both languages on every row

## Families

| family | samples | what it contains |
| --- | ---: | --- |
| `racks` | 250 | straight gear-rack blanks: tooth strips (3 variants of tooth pattern), mount holes |
| `structsections` | 250 | L/T/U/H structural sections extruded as profiles (4 variants) |
| `hexplates` | 250 | hexagonal adapter plates with bolt-circle voids (2 variants) |
| `keyways` | 250 | round hubs with keyway notches and central bores (3 variants) |
| `frameplates` | 250 | windowed frame plates with corner voids (2 variants) |

## Notes for the validator

- every row is `validation_status: pending_openscad_manifold` with `expected_bbox_mm`
- the hexplates/keyways families declare *measured* profile bboxes (polygon extrema, not 2R assumptions) - re-measure from the profile if anything looks off
- voids are through-cuts (`void_depth_mm` equals the plate thickness)
