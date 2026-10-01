# asm3 corpus - generation report

Audit sheet for `optional_data/data/asm3` (delivery no. 6). Not part of the training data - the corpus is `manifest.jsonl` plus the `.scad` files.

- generated: 2026-10-01, seed `Rng(family, index)` with fixed seed 20261001
- samples: **800** scenes across **5** families (160 each), **6560 placed instances**, 480 scenes call a repeated module (jaw pairs, bolt circles, twin bushings)
- corpus size: ~5.7 MiB of text (manifest + 800 sources)
- `manifest.jsonl` sha256: `d4da6e34f40c1041704d96bf39ed7d0074abb0de3f03703382d1be3e1d08b2d9`
- generator: `tools/dataset_asm3/` (`scenes3b.py`, `build_asm3.py`) on the asm2 core (`core2b.check_scene2`, `verify_asm2.py`) with asm1's parts2 library
- **OpenSCAD CLI on the generation machine: absent.** Every check ran on the manifold3d + trimesh stack (the kernel OpenSCAD uses with `--backend=manifold`). Final acceptance requires a real `openscad --backend=manifold` run on the receiving side.
- local gate per scene: `$fn = 32;` header, forbidden-construct scan, ≤ 12 KiB, argument-less modules defined once, ordered `translate/rotate` calls replayed against the manifest `assembly [{module, t, q(w-last)}]` (**6560 transforms replayed, 0 mismatching**), 45°-grid angles, per-part manifold solids with analytic volumes (worst |parts − scene| 0.0000 %), predicted world bounds (max bbox error 0.0000 %), pairwise clearance ≥ 0.2 mm (**smallest gap in corpus: 0.2500 mm**), STL round trip
- independent re-audit from disk (`verify_asm2.py --parts-dir optional_data/data/asm3`): 800 rows re-evaluated, **sha256 list ok, duplicate RU/EN prompts 0/0, problems: none**
- build rejects: 78 deliberate draw-rejects ("pin hole breaks the clevis top") - rejected draws never reach disk; 0 audit rejects
- prompt uniqueness: 800 distinct RU and EN prompts; both languages on every row

## Families

| family | samples | parts | what it contains |
| --- | ---: | ---: | --- |
| `vise` | 160 | 7 | machine vise: bed plate, two jaw blocks (one module × 2), lead screw, collar, washer, standing handle |
| `cclamp` | 160 | 7 | C clamp: two jaw plates (one module × 2), spine, screw, washer, nut, tommy bar |
| `pumpstack` | 160 | 9 | pump stack: base, housing cup, gasket ring, rod, four-bolt cover, top collar |
| `indexingjig` | 160 | 9 | indexing jig: plate, locator block, fork-and-tongue index arm on a pin, washer, lock nut, two guide bushings |
| `lamparm` | 160 | 8 | column lamp: base, column, fork head, arm link on a pin, washer, nut, shade bracket |

## Notes for the validator

- every row is `validation_status: pending_openscad_manifold` with `expected_bbox_mm`
- fits are deliberately loose everywhere: `GAP = 0.25` mm on mating faces, `FIT = 0.8` mm diametral in every clearance hole
- pin heads carry a 1 mm overlap into their own shaft inside one module (single-part booleans only); the scene-level audit sees finished part meshes
- the C-clamp washer/nut/tommy bar sit below the frame in an exploded stack (the frame bases are solid at the screw axis) - intentional, clearance-checked layout
