# wire4 corpus - generation report

Audit sheet for `optional_data/data/wire4` (delivery no. 7). Not part of the training data - the corpus is `manifest.jsonl` plus the `.scad` files.

- generated: 2026-10-01, seed `Rng(family, index)` with fixed seed 20261001
- samples: **1000** scenes across **5** families (200 each)
- corpus size: ~5.7 MiB of text (manifest + 1000 sources)
- `manifest.jsonl` sha256: `bc62bbac50b36aa4b36d19d7654970bb8e5f29ea3fb5a339f8f2314badd22e63`
- generator: `tools/dataset_wire4/` (`families4w.py`, `build_wire4.py`), shared scene core `tools/dataset_wire2/families2w.py` (`WireScene`), kit `tools/dataset_v5/kit.py`
- **OpenSCAD CLI on the generation machine: absent.** Every check ran on the manifold3d + trimesh stack (the kernel OpenSCAD uses with `--backend=manifold`). Final acceptance requires a real `openscad --backend=manifold` run on the receiving side.
- local gate per scene: `$fn = 32;` header, forbidden-construct scan, ≤ 12 KiB, manifold evaluation (members + joint balls fuse into one solid), graph replay against the manifest (node coordinates literal in code, rounded to 4 decimals), connectivity, no isolated nodes, every edge longer than 2r + 2 mm, place1 consistency law on both prompts
- graph sizes: nodes 12..24, edges 19..40 (wire canvas deviation "nodes ≤ 32" holds)
- independent re-audit from disk (`verify_wire2.py --parts-dir optional_data/data/wire4`): 1000 rows re-evaluated, **sha256 bad 0, duplicate RU/EN prompts 0/0, problems: 0 rows failed**
- build rejects: 13 deliberate draw-retries (design guards resample, no audit failures)
- prompt uniqueness: 1000 distinct RU and EN prompts; both languages on every row

## Families

| family | samples | what it contains |
| --- | ---: | --- |
| `pergola` | 200 | garden arch trellises: two 5- or 7-segment arch frames tied by purlins |
| `shopcart` | 200 | trolley frames: basket loop, slanted rim, push handle, four caster stubs |
| `stoolchair` | 200 | stool and chair frames: splayed legs, stretcher ring, chair variant adds a two-slat backrest |
| `shelfunit` | 200 | shelving towers: four posts, foot ring, 2-3 shelf loops, back and side braces |
| `aladder` | 200 | A-frame ladders: front and rear frames, 3-4 rungs, top platform loop |

## Notes for the validator

- every row is `validation_status: pending_openscad_manifold` with `expected_bbox_mm` and a `graph {nodes, edges, member_radius_mm}` manifest block
- node coordinates are literals in the source (4-decimal rounding, replay tolerance 5e-4) - the graph in the manifest must match the code exactly
- `shelfunit` posts overshoot the top shelf by 10 mm so every shelf loop ties into them; `aladder` rejects draws whose lowest rung would be shorter than 2r + 2 mm
- member radii per scene: 1.5..3.0 mm chords/braces, joints are r + 0.4 mm balls
