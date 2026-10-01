# solid3 corpus - generation report

Audit sheet for `optional_data/data/solid3` (delivery no. 7). Not part of the training data - the corpus is `manifest.jsonl` plus the `.scad` files.

- generated: 2026-10-01, seed `Rng(family, index)` (solid2 convention)
- samples: **1000** across **5** families (200 each)
- corpus size: ~5.1 MiB of text (manifest + 1000 sources)
- `manifest.jsonl` sha256: `473d2e6c05a081ee3de37bae598d99eb8fbbb8dcc10b501d1caf38f536afb139`
- generator: `tools/dataset_solid3/` (`families3v.py`, `build_solid3.py`), shared finishing/prompt helpers from `tools/dataset_solid2/families2v.py`, kit `tools/dataset_v5/kit.py`
- **OpenSCAD CLI on the generation machine: absent.** Every check ran on the manifold3d + trimesh stack (the kernel OpenSCAD uses with `--backend=manifold`). Final acceptance requires a real `openscad --backend=manifold` run on the receiving side.
- local gate per sample: `$fn = 32;` header, forbidden-construct scan, ≤ 12 KiB, manifold evaluation to a single solid, declared-vs-measured bbox ≤ 3 %, place1 consistency law on both prompts; design discipline: every union overlap ≥ 1 mm (no face-to-face tangency), walls ≥ 1.5 mm
- independent re-audit from disk (`verify_scale1.py --parts-dir optional_data/data/solid3`): 1000 rows re-evaluated, **sha256 bad 0, duplicate RU/EN prompts 0/0, problems: 0 rows failed**
- build rejects: 62 deliberate draw-retries (design guards resample, no audit failures)
- prompt uniqueness: 1000 distinct RU and EN prompts; both languages on every row

## Families

| family | samples | what it contains |
| --- | ---: | --- |
| `spurblank` | 200 | gear blanks with 10-18 stub teeth as sunk blocks; plain / bored / lightened with five pockets (3 variants) |
| `enclosurebox` | 200 | open enclosures: shell, corner bosses with blind screw holes, cable notch in the front wall (3 variants) |
| `ribbracket` | 200 | L brackets with 2-3 extruded triangular gussets sunk into foot and upright (2 variants) |
| `hopper` | 200 | square-flange funnels: cone walls ≥ 2 mm, open spout, optional four-hole flange (2 variants) |
| `saddleclamp` | 200 | shaft saddle clamps: semicircular top groove, bolt holes, split variant adds a saw kerf (2 variants) |

## Notes for the validator

- every row is `validation_status: pending_openscad_manifold` with `expected_bbox_mm`
- `spurblank` declares **measured** width/depth over the teeth as literal `bbox_x`/`bbox_y` header assignments (tooth-corner projections, not 2R) - re-measure from the mesh if anything looks off
- `ribbracket` gussets are `rotate([-90,0,0]) linear_extrude` prisms with a signed-y polygon; they sink 1 mm into both plates
- `hopper` spouts are open through the flange (inner cone starts 2 mm below the flange top); `saddleclamp` grooves are cut with the cylinder centre exactly on the top face
