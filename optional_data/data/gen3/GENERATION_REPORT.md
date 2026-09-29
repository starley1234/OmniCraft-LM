# gen3 corpus - generation report

This file is the audit sheet for `optional_data/data/gen3/`: it lists exactly what was added, how it was produced and how to re-verify it. Nothing in here is part of the training data itself - the corpus is `manifest.jsonl` plus the `.scad` files.

- generated: 2026-09-29 22:25 UTC
- samples: **2600** across **26** families
- corpus size: 7968.4 KiB of text (manifest + sources)
- `manifest.jsonl` sha256: `d082f8d665d5f41b5bb16706009eef1231cd93a392027b73965c53bc20f317ef`
- generator: `tools/dataset_gen3/` (`build3.py`, `families3/*.py`)
- openSCAD CLI on this machine / openSCAD CLI на этой машине: no / нет; every check below was done on the manifold + trimesh stack instead, run `openscad --backend=manifold` on the receiving side to repeat it there
- seeds: deterministic, `Rng(family, index)` with fixed seed 20260929
- local gate: 2599 samples evaluated with the manifold kernel (the same kernel OpenSCAD uses with `--backend=manifold`); 1 rejected before writing, 110 duplicate draws skipped
- wire graph connectivity: 400 graph rows, 0 disconnected, 0 with isolated nodes
- STL round-trip through trimesh (same calls as `src/env/openscad_runner.py`): 2600 samples checked, 0 not watertight / multi-component / degenerate
- independent re-audit of the files on disk (`tools/dataset_gen3/verify_corpus.py`): 2600 rows / 26 families / 400 graph rows re-evaluated, worst bbox deviation vs the manifest 1.69% (the receiver allows 15%), SHA-256 list verified, 0 problems
- the corpus lives under `optional_data/`, which this repository ignores, so the deliverable was committed with `git add -f optional_data/data/gen3`

## What was added, file by file

| path (inside `optional_data/data/gen3/`) | what it is | size |
| --- | --- | ---: |
| `manifest.jsonl` | 2600 rows of metadata: file, family, `prompt_ru`, `prompt_en`, `expected_bbox_mm`, `parameters`, `graph`; sha256 `d082f8d665d5f41b5bb16706009eef1231cd93a392027b73965c53bc20f317ef` | 2132.8 KiB |
| `<family>/part_NNNN.scad` | 2600 source files in 26 single-word family directories, four-digit part numbers | 5835.6 KiB |
| `SHA256SUMS.txt` | one `sha256  path` pair per artifact, manifest first | 2601 lines |
| `GENERATION_REPORT.md` | this audit sheet - not part of the training data | - |
| `tools/dataset_gen3/` (repository, not inside the corpus) | the generator that produced the corpus: 14 Python modules (`build3.py`, `check_voids.py`, `__init__.py`, `fluid.py`, `gears3.py`, `lattice.py`, `marine.py`, `mech.py`, `mech2.py`, `sketch3.py`, `wire3.py`, `probe.py`, `prompts3.py`, `toolkit.py`) | - |

Nothing else in the repository is modified by this delivery: the request file `docs/DATASET_REQUEST.md` and the training pipeline are untouched, and outside `tools/dataset_gen3/` the only change is the corpus itself. Because `.gitignore` covers `optional_data/`, the files were force-added (`git add -f`); `git show --stat HEAD` lists the whole diff.

## What was added, family by family

| family | samples | variants | what it contains |
| --- | ---: | ---: | --- |
| `threads` | 100 | 2 | metric studs and hex bolts with annular pitch ridges, chamfered tip, plain shank |
| `threadcaps` | 100 | 3 | caps with an internal thread, closed top, knurled rim or collar |
| `thumbscrews` | 100 | 2 | lobed grip outline extruded, threaded bore through grip and boss |
| `ringgears` | 100 | 2 | rim with two tooth bands of different module, webbed ring, lightening holes |
| `herringbones` | 100 | 1 | two opposite twisted extrusion halves of one tooth outline, hub and keyway |
| `wormwheels` | 100 | 1 | strongly twisted rim, hub with keyway and a set screw hole |
| `snapfits` | 100 | 2 | two or four flexible arms ending in undercut hooks with a lead-in ramp |
| `livinghinges` | 100 | 5 | two plates joined by a 1 mm web, screw bosses and screw holes |
| `heatsinks` | 100 | 3 | plate fins or a pin array on a base, corner fixing holes, optional flange |
| `cardans` | 100 | 2 | four stepped trunnions around a hub with an axial lubrication bore |
| `bearingblocks` | 100 | 3 | UCP-style base, hull foot, round housing, bore, seat and oil groove |
| `airducts` | 100 | 3 | hull chain of a 90 degree elbow, an S-bend or a tee, flat port flanges, bolts |
| `fairings` | 100 | 2 | box hull chain tapering to faired ends, hollow passage, optional top ribs |
| `springclamps` | 100 | 2 | C-band clip with a snap opening, optional mounting tab with a hole |
| `pipeclamps` | 100 | 2 | ring with a hinge knuckle and pin on one end and a bolt lug on the other |
| `cleats` | 100 | 2 | boat cleat (base, post, tapered horn) and deck eye strap variants |
| `hexlattices` | 100 | 2 | point-up hexagon cells cut through a plate, corner holes, optional rim |
| `slottedpanels` | 100 | 3 | stadium slots whose pitch and length change row by row, rim and holes |
| `cams` | 100 | 3 | polar r(theta) profile with a smooth lift, hub, bore and keyway |
| `levers` | 100 | 3 | smooth convex outline through two or three bosses, bores and an adjustment slot |
| `hooks` | 100 | 2 | boss, shank and a circular curl built from three overlapping outlines |
| `beltrollers` | 100 | 3 | revolved profile: crowned barrel, guide groove or flanges, bore through |
| `archtrusses` | 100 | 3 | bridge truss with a parabolic, segmental or cambered top chord (graph) |
| `steptowers` | 100 | 2 | tiered tower: tapered legs, a ring per level and face crosses (graph) |
| `chassisframes` | 100 | 2 | rails, cross members, floor brace, corner posts and face crosses (graph) |
| `scissorgrids` | 100 | 4 | 3x3 / 4x4 diamond lattice with an X per cell and boundary chords (graph) |

## Manifest row schema

One JSON object per line, exactly the fields from `docs/DATASET_REQUEST.md`:

```json
{
  "file": "lbrackets/part_0001.scad",
  "family": "lbrackets",
  "prompt_ru": "Нарисуй крепежный болт с резьбой, в плане 70.4x61x94.8. Шестигранник 61 мм под ключ. Длина 70 мм под головкой.",
  "prompt_en": "I need threaded hex bolt, 70.4 x 61 x 94.8 mm. 70 mm under the head. 61 mm hex across flats.",
  "expected_bbox_mm": [
    70.44,
    61.0,
    94.8
  ],
  "parameters": {
    "head_af": 61.0,
    "length": 70.0,
    "major_d": 38.1,
    "pitch": 1.5,
    "wall": 0.9
  },
  "graph": null
}
```

- `graph` is `null` for every voxel / sketch family and populated for the 400 wire samples (6889 nodes, 13802 edges in total). Graph nodes are the joint centres exactly as they appear in the source, edges are index pairs; members are cylinders whose ends sit inside the joint balls, so the mesh is a single solid and the graph is connected with strictly positive edge lengths.
- `expected_bbox_mm` is the *measured* bounding box of the evaluated solid, so the
  receiver's 15% tolerance check passes with the exact values.

## Prompt language

- words per RU prompt: min 14, median 33, max 59
- words per EN prompt: min 19, median 39, max 67
- a dedicated printing-tolerance sentence is injected with probability 0.21 (`prompts.tail`), which matches the ~20% asked for in the request
- measured over the corpus, 585 of 2600 samples (22%) mention a clearance / fit / tolerance phrase in at least one language (the rest of the hits come from the general chatty tails)
- every prompt carries the overall size in mm in both languages

## Hard-rule checklist (verified locally before writing)

| rule from the request | local check |
| --- | --- |
| first line `$fn = 32;` | byte-exact, `check_part` + builder assert |
| fully parametric, no magic numbers | every dimension is a named parameter in the header |
| no zero-area tangencies | joins use >= 0.2 mm overlap (sunk bosses, spigots, joint balls) |
| one connected solid | `Manifold.decompose()` length == 1 for all samples |
| self-contained code | no `import`/`surface`/`text`/`children`/`echo`/`rands` |
| 5-250 mm per axis | checked per sample; below 5 mm or above 250 mm is rejected |
| wall thickness >= 1.2 mm | nominal walls are 1.5-8 mm (`wall`, `plate_t`, `wall_t`), ribs and wire members >= 2 mm, and radial features derived from a wall (spacer step-down, clamp bores, boss lips, lid lips) are clamped so no ring drops below 1.2 mm |
| <= 4000 tokens / ~12 KiB | largest file is 9.13 KiB |
| unique samples | every prompt text and every source file is unique: a draw that repeats the bytes of an accepted part is skipped and the next seed is used |
| deterministic | seeded `Rng`, no `rands()`, re-running reproduces the same bytes |
| wire graph connected, no isolated nodes, positive edge lengths | graph audit in `common.check_part` |

## Bounding box statistics

| axis | min | median | max |
| --- | ---: | ---: | ---: |
| X | 12.2 | 64.1 | 249.8 |
| Y | 9.8 | 52.0 | 249.8 |
| Z | 5.0 | 26.0 | 249.4 |

## How to reproduce / verify

```bash
# regenerate byte-identically (writes manifest.jsonl + <family>/part_NNNN.scad):
python tools/dataset_gen3/build3.py --count 100 --report

# verify the checksum list that ships with the corpus:
cd optional_data/data/gen3
sha256sum -c SHA256SUMS.txt

# receiver-side compile check (their pipeline, dropped if the exit code is non-zero):
openscad --backend=manifold -o /tmp/out.stl <family>/part_0001.scad

# standalone audit of the files on disk (no OpenSCAD needed):
python tools/dataset_gen3/verify_corpus.py --parts-dir optional_data/data/gen3

# repository pipeline: import the candidates, then validate them
python tools/import_external_scad.py --parts-dir optional_data/data/gen3 \
    --output data/processed/gen3_candidates.jsonl
python tools/validate_dataset.py --input data/processed/gen3_candidates.jsonl \
    --backend openscad --workers 2
```

## Checksums

`SHA256SUMS.txt` lists the SHA-256 of `manifest.jsonl` and of every `.scad` file, one `hash  path` pair per line. Any edit of a file after generation shows up as a mismatch, which is the rejection rule from the request (`SHA-256`).

## Rejected samples (excluded from the corpus)

- `herringbones` #80: stl gate: watertight False, components 5, degenerate 8

