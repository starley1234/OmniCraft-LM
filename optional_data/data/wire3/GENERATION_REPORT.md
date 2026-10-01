# wire3 corpus - generation report

Audit sheet for `optional_data/data/wire3` (delivery no. 6). Not part of the training data - the corpus is `manifest.jsonl` plus the `.scad` files.

- generated: 2026-10-01, seed `Rng(family, index)` with fixed seed 20261001
- samples: **1250** across **5** families (250 each)
- corpus size: ~7.8 MiB of text (manifest + 1250 sources)
- `manifest.jsonl` sha256: `1875a77a88d92b78d318a586bbf0de102cce93d1bb2e2d5ac734c820ddc063cc`
- generator: `tools/dataset_wire3/` (`families3w.py`, `build_wire3.py`), shared core `tools/dataset_wire2/` (`families2w.py` scene API, `build_wire2.audit`, `verify_wire2.py`), kit `tools/dataset_v5/kit.py`
- **OpenSCAD CLI on the generation machine: absent.** Every check ran on the manifold3d + trimesh stack (the kernel OpenSCAD uses with `--backend=manifold`). Final acceptance requires a real `openscad --backend=manifold` run on the receiving side.
- local gate per sample: `$fn = 32;` header, forbidden-construct scan, ≤ 12 KiB, manifold evaluation, declared-vs-measured bbox, **graph replay** (manifest `graph {nodes, edges, member_radius_mm}` against the code's `nodes` literal/comprehension, tolerance 5e-4), edge length > 2 × member radius, member radii 1.5..5 mm, axes 5..250 mm, place1 law on both prompts
- graph audit: **0 disconnected graphs, 0 isolated nodes**; node counts 8..32, edge counts 12..76
- independent re-audit from disk (`verify_wire2.py --parts-dir optional_data/data/wire3`): 1250 rows re-evaluated, **sha256 bad 0, duplicate RU/EN prompts 0/0, problems: 0 rows failed**
- build rejects: 0 audit rejects (254 deliberate draw-retries, mostly scaffold node-budget redraws)
- prompt uniqueness: 1250 distinct RU and EN prompts; both languages on every row

## Families

| family | samples | what it contains |
| --- | ---: | --- |
| `geodome` | 250 | geodesic dome frames: 6/8-gon base and top rings, optional half-step twist, apex hub (4 variants) |
| `bikeframe` | 250 | diamond bicycle frames: head tube, seat/chain stays, fork, literal node coordinates (2 variants) |
| `scaffold` | 250 | construction scaffold towers: levels × bays × two sides with ledgers, braces and diagonals (4 variants) |
| `cranejib` | 250 | crane jibs: tapered box jib / pyramid jib / kingpost jib (3 variants) |
| `archtruss` | 250 | arch trusses: parabolic top chord over columns, 4(bays+1) nodes (6 variants) |

## Documented deviations

- **Node cap 32 instead of the requested up-to-64** (same as wire2): `src/training/aux_losses.py::wire_auxiliary_loss` raises above 32 vertices and `src/model/wire_canvas.py` is a fixed 32-vertex canvas, so no sample exceeds 32 nodes (actual maximum: 32, scaffold 3×3).
