# sketch4 corpus - generation report

Audit sheet for `optional_data/data/sketch4` (delivery no. 7). Not part of the training data - the corpus is `manifest.jsonl` plus the `.scad` files.

- generated: 2026-10-01, seed `Rng(family, index)` with fixed seed 20261001
- samples: **1000** across **5** families (200 each), 800 of them carry through- or blind-voids, 200 are rotate-extrudes
- corpus size: ~6.1 MiB of text (manifest + 1000 sources)
- `manifest.jsonl` sha256: `89306d946ee47c9f712833a96446787944662a3cbfe154bbb280f1e276e567bb`
- generator: `tools/dataset_sketch4/` (`families4s.py`, `build_sketch4.py`), shared core `tools/dataset_sketch2/core2s.py`, kit `tools/dataset_v5/kit.py`
- **OpenSCAD CLI on the generation machine: absent.** Every check ran on the manifold3d + trimesh stack (the kernel OpenSCAD uses with `--backend=manifold`). Final acceptance requires a real `openscad --backend=manifold` run on the receiving side.
- local gate per sample: `$fn = 32;` header, forbidden-construct scan, ≤ 12 KiB, manifold evaluation to a single solid, declared-vs-measured bbox and volume, profile replay (CCW 6..64 points, simple polygon), void containment/overlap checks, place1 consistency law on both prompts
- profile points 6..48; the `spinparts` family is revolved (full 360, Pappus volume check), everything else is linear
- independent re-audit from disk (`verify_sketch2.py --parts-dir optional_data/data/sketch4`): 1000 rows re-evaluated, **sha256 bad 0, duplicate RU/EN prompts 0/0, problems: 0 rows failed**
- build rejects: 22 deliberate draw-retries (design guards resample, no audit failures)
- prompt uniqueness: 1000 distinct RU and EN prompts; both languages on every row

## Families

| family | samples | what it contains |
| --- | ---: | --- |
| `camplates` | 200 | cam plates: single-lobe, double-lobe and eccentric discs with a shaft bore and a bolt ring (3 variants) |
| `spacerplates` | 200 | chamfered rectangular, obround and circular spacer plates with hole patterns (3 variants) |
| `starwheels` | 200 | star / ratchet / blunt-tooth wheels with a central bore; voids kept inside the outline kernel (3 variants) |
| `spinparts` | 200 | revolved v-pulleys, flange bushings and handwheels (full-turn rotate extrudes, 3 variants) |
| `bracketplates` | 200 | convex bracket outlines: corner pads, slotted plates, trapezoid gussets with lightening holes (3 variants) |

## Notes for the validator

- every row is `validation_status: pending_openscad_manifold` with `expected_bbox_mm`
- `starwheels` and `bracketplates` keep every void inside the polygon kernel - the audit's expected volume uses a convex clip of the void against the profile, which is exact only there; do not "fix" the outlines to concave ones without re-deriving the volumes
- `camplates` enforce an exact per-void-point wall check (≥ 1.25 mm to the profile ring) - lobe flanks come closer than a radial estimate would suggest
- revolved rows declare `extrude.kind = rotate` with `revolve_angle = 360`; their expected volume is the full Pappus solid
