# asm4 corpus - generation report

Audit sheet for `optional_data/data/asm4` (delivery no. 7). Not part of the training data - the corpus is `manifest.jsonl` plus the `.scad` scene files.

- generated: 2026-10-01, seed `Rng(family, index)` (asm3 convention)
- samples: **650** scenes across **5** families (130 each), **6110** placed part instances (scenes of 7, 8 and 12 parts)
- corpus size: ~4.9 MiB of text (manifest + 650 scene sources)
- `manifest.jsonl` sha256: `b0a9db60fda18680b6198f47dc0de4c047541e7d840270ba772d7c36b7fbd76b`
- generator: `tools/dataset_asm4/` (`scenes4b.py`, `build_asm4.py`), parts libraries `tools/dataset_asm1/parts2.py` + `tools/dataset_asm2/parts2b.py`, scene core `tools/dataset_asm2/core2b.py`
- **OpenSCAD CLI on the generation machine: absent.** Every check ran on the manifold3d + trimesh stack (the kernel OpenSCAD uses with `--backend=manifold`). Final acceptance requires a real `openscad --backend=manifold` run on the receiving side.
- local gate per scene: `$fn = 32;` header, argument-less modules, one module per distinct part, angles on the 45° grid, manifold evaluation with per-instance decomposition (every part a separate solid, nothing touching), declared-vs-measured bbox, analytic-vs-mesh volume sum, transform replay, place1 consistency law on both prompts
- independent re-audit from disk (`verify_asm2.py --parts-dir optional_data/data/asm4`): 650 rows, 6110 transforms replayed with 0 mismatches, **smallest gap 0.2000 mm (limit 0.2), max bbox error 0.0000 %, worst volume-sum deviation 0.0000 %, RU/EN prompt dupes 0/0, sha256 list ok, problems: none**
- build rejects: deliberate draw-retries only (design guards resample; no audit failures)
- prompt uniqueness: 650 distinct RU and EN scene prompts; both languages on every row

## Families

| family | samples | parts | what it contains |
| --- | ---: | ---: | --- |
| `motorstation` | 130 | 7 | motor with pilot boss, pillow block, shaft, collar, washer, flanged pulley on one bed plate |
| `beltloop` | 130 | 8 | two bushed vertical shafts with flanged pulleys tied by a racetrack flat belt |
| `pressfixture` | 130 | 12 | arbor press: anvil block, four box posts, windowed frame plate, guide ring, screw, washer, nut, press collar |
| `rockerlink` | 130 | 12 | fork with axle-mounted swing block and roller, clevis-and-tongue link pinned on the bridge |
| `hingeflap` | 130 | 8 | comb hinge: riser, two interleaved leaves, flap plate, pin, washer, nut |

## Notes for the validator

- every row is `validation_status: pending_openscad_manifold` with `expected_bbox_mm` and an `assembly [{module, t, q(w-last)}]` manifest block
- clearance discipline: GAP on every mating face, FIT diametral clearance in every hole; the 0.2 mm floor comes from the eye-plate tongue in its clevis slot (0.4 mm per side)
- `hingeflap` tooth slots are centred on the leaf (`-leaf_l/2 + margin` origin) and the pin head sits clear of the knuckles - the leaves must never fuse with each other or with the pin hardware
- `rockerlink`'s pinned joint stands on the fork bridge, not in the swing zone - the swing block must stay below the bridge at every draw
- `motorstation` pulley diameters are filtered by motor height so the rotor always clears the bed plate
