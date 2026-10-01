# solid2 corpus - generation report

Audit sheet for `optional_data/data/solid2` (delivery no. 6). Not part of the training data - the corpus is `manifest.jsonl` plus the `.scad` files.

- generated: 2026-10-01, seed `Rng(family, index)` with fixed seed 20261001
- samples: **1250** across **5** families (250 each)
- corpus size: ~6.4 MiB of text (manifest + 1250 sources)
- `manifest.jsonl` sha256: `7089bd3ca7a59ae4c15d43a5dc26b2033a6e2c2ba37e5ef3f24daf4fed83cfcb`
- generator: `tools/dataset_solid2/` (`families2v.py`, `build_solid2.py`), shared `tools/dataset_gen2/common.py` (check_part) and `tools/dataset_place1/check_consistency.py`, kit `tools/dataset_v5/kit.py`
- **OpenSCAD CLI on the generation machine: absent.** Every check ran on the manifold3d + trimesh stack (the kernel OpenSCAD uses with `--backend=manifold`). Final acceptance requires a real `openscad --backend=manifold` run on the receiving side.
- local gate per sample: `$fn = 32;` header, forbidden-construct scan, ≤ 12 KiB, manifold evaluation to a single solid, declared-vs-measured bbox ≤ 3 %, axes 5..250 mm, place1 consistency law on both prompts
- design discipline: every union overlap ≥ 0.5 mm (no face-to-face tangency), shell walls ≥ 1.5 mm, cutters overshoot surfaces by ≥ 0.5 mm
- independent re-audit from disk (`verify_scale1.py --parts-dir optional_data/data/solid2`): 1250 rows re-evaluated, **sha256 bad 0, duplicates 0/0, problems: 0 rows failed**
- build rejects: 139 deliberate draw-rejects (guards like "outlet misses or grazes the port row", "louver slats would overlap") - rejected draws never reach disk; 0 audit rejects
- prompt uniqueness: 1250 distinct RU and EN prompts; both languages on every row

## Families

| family | samples | what it contains |
| --- | ---: | --- |
| `heatsink` | 250 | finned cooling blocks: uniform / centre-slotted / cross-rib fin fields (3 variants) |
| `manifoldblock` | 250 | ported distribution blocks: through port rows, top gallery pocket, optional side outlet (2 variants) |
| `controlknob` | 250 | panel knobs: pointer rib / finger dimples / skirt with grip ribs, bore + set screw (3 variants) |
| `drilljig` | 250 | drill jigs: guide bosses with through holes, clamp slots, fence wall variant (3 variants) |
| `ventbox` | 250 | vented enclosures: louver wall / cross grid / round vent with hole ring (3 variants) |

## Notes for the validator

- every row is `validation_status: pending_openscad_manifold` with `expected_bbox_mm`
- louver slats and grid bars are unioned *after* the window cut and anchor 0.5-1 mm into the frame - a different (but equivalent) boolean order is fine as long as the solid stays single-piece
- skirt knob bbox = skirt diameter (the skirt, not the ribs, is the widest feature)
