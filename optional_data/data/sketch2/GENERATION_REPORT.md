# sketch2 corpus - generation report

Audit sheet for `optional_data/data/sketch2` (request 5, block S2). Not part of the training data - the corpus is `manifest.jsonl` plus the `.scad` files.

- generated: 2026-10-01, seed `Rng(family, index)` with fixed seed 20261001
- samples: **1380** across **6** families (230 each)
- corpus size: 3717.0 KiB of text (manifest + 1380 sources)
- `manifest.jsonl` sha256: `67207b875d531d75bd3c3b6d54cb26719251f2b3c701a00a8f1b87fc5381e160`
- generator: `tools/dataset_sketch2/` (`core2s.py`, `families2s.py`, `build_sketch2.py`, `verify_sketch2.py`)
- **OpenSCAD CLI on the generation machine: absent.** Every check below ran on the manifold3d + trimesh stack (the kernel OpenSCAD uses with `--backend=manifold`). Final acceptance requires a real `openscad --backend=manifold` run on the receiving side.
- local gate per sample: header/forbidden scan, ≤ 12 KiB, manifold evaluation to a single solid, declared-vs-measured bbox ≤ 3 %, analytic volume (profile area × height minus clipped void cuts; Pappus for revolves) within 1.5 %/2 %, Shoelace CCW + simplicity on every ring, void containment and ≥ 1.2 mm walls/floors
- profile audit: **0 self-intersecting profiles, 0 clockwise profiles**; profile point counts 7..60 (allowed 6..64); **460 samples carry voids**, **230 are revolves**
- prompt consistency (place1 law, both languages): **1380/1380 rows = 100 %** of prompt dimension numbers present in the code for RU and EN
- independent re-audit from disk (`verify_sketch2.py`): 1380 rows re-evaluated, **sha256 bad 0, duplicate RU/EN prompts 0/0, problems: 0 rows failed**
- build rejects: 111 deliberate draw-rejects (layouts that would break the declared margins) - rejected draws never reach disk

## Families

| family | samples | what it contains |
| --- | ---: | --- |
| `voidplates` | 230 | chamfered plates with through windows / blind pockets in row and grid layouts |
| `arcprofiles` | 230 | sector (pointed apex), lens, crown and notch profiles, arcs sampled at 1° |
| `steppedbars` | 230 | bars with end/centre/side/two-step thickness changes via edge-cutter voids |
| `groovedshafts` | 230 | revolved shafts with 1-2 grooves, optional flange and 45° thread relief |
| `gearsectors` | 230 | gear sectors with 2-4 trapezoid teeth on 3°-sampled root/hub arcs |
| `vguides` | 230 | V-way / V-rib / dovetail / double-V guide rails extruded along Z |

## Documented deviations

- `gearsectors` samples root/hub arcs at **3°** instead of ≤ 1°: a 1° sampling of both arcs always exceeds the 64-point profile cap; the step is declared as the `arc_step` parameter. `arcprofiles` honours 1°.
- `arcprofiles` sectors are pointed-apex (outer arc + apex point) for the same cap reason.

## Re-verification

```bash
python tools/dataset_sketch2/verify_sketch2.py --parts-dir optional_data/data/sketch2
# receiving side (the only legitimate acceptance):
openscad --backend=manifold -o /tmp/check.stl optional_data/data/sketch2/<family>/part_NNNN.scad
python tools/verify_delivery.py optional_data/data/sketch2
```
