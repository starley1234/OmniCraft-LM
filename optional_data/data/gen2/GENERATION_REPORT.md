# gen2 corpus - generation report

This file is the audit sheet for `optional_data/data/gen2/`: it lists exactly what was added, how it was produced and how to re-verify it. Nothing in here is part of the training data itself - the corpus is `manifest.jsonl` plus the `.scad` files.

- generated: 2026-09-29 19:39 UTC
- samples: **2240** across **28** families
- corpus size: 5041.0 KiB of text (manifest + sources)
- `manifest.jsonl` sha256: `841ca737b455b0babb02b80885ea2ab692d329acedac29d031cb173546571264`
- generator: `tools/dataset_gen2/` (`build_corpus.py`, `families/*.py`)
- seeds: deterministic, `Rng(family, index)` with fixed seed 20260929
- local gate: 2240 samples evaluated with the manifold kernel (the same kernel OpenSCAD uses with `--backend=manifold`); 0 rejected before writing
- independent re-audit of the files on disk (`tools/dataset_gen2/verify_corpus.py`): 2240 rows / 28 families / 400 graph rows re-evaluated, worst bbox deviation vs the manifest 2.42% (the receiver allows 15%), SHA-256 list verified, 0 problems
- the corpus lives under `optional_data/`, which this repository ignores, so the deliverable was committed with `git add -f optional_data/data/gen2`

## What was added, file by file

| path (inside `optional_data/data/gen2/`) | what it is | size |
| --- | --- | ---: |
| `manifest.jsonl` | 2240 rows of metadata: file, family, `prompt_ru`, `prompt_en`, `expected_bbox_mm`, `parameters`, `graph`; sha256 `841ca737b455b0babb02b80885ea2ab692d329acedac29d031cb173546571264` | 1869.9 KiB |
| `<family>/part_NNNN.scad` | 2240 source files in 28 single-word family directories, four-digit part numbers | 3171.1 KiB |
| `SHA256SUMS.txt` | one `sha256  path` pair per artifact, manifest first | 2241 lines |
| `GENERATION_REPORT.md` | this audit sheet - not part of the training data | - |
| `tools/dataset_gen2/` (repository, not inside the corpus) | the generator that produced the corpus: 13 Python modules (`build_corpus.py`, `common.py`, `bearings.py`, `brackets.py`, `drive.py`, `joints.py`, `profiles.py`, `shells.py`, `wire.py`, `miniscad.py`, `prompts.py`, `report.py`, `verify_corpus.py`) | - |

Nothing else in the repository is modified by this delivery: the request file `docs/DATASET_REQUEST.md` and the training pipeline are untouched, and outside `tools/dataset_gen2/` the only change is the corpus itself. Because `.gitignore` covers `optional_data/`, the files were force-added (`git add -f`); `git show --stat HEAD` lists the whole diff.

## What was added, family by family

| family | samples | variants | what it contains |
| --- | ---: | ---: | --- |
| `lbrackets` | 80 | 8 | L-shaped corner bracket with euro slots and counterbores |
| `ubrackets` | 80 | 4 | U / channel bracket, cross holes through both uprights |
| `zbrackets` | 80 | 2 | Z / stepped bracket with gusseted offsets |
| `spurgears` | 80 | 15 | involute spur gears, evolute approximated with a polygon loop |
| `helicalgears` | 80 | 6 | helical gears (twisted extrude, same involute loop) |
| `racks` | 80 | 13 | gear racks for the same modules |
| `pulleys` | 80 | 40 | GT2 / GT3 / T5 / HTD5 / MXL timing pulleys with hub and set screw |
| `motormounts` | 80 | 9 | NEMA 17 / 23 / 34 motor adapter plates, slotted and flanged |
| `bearings` | 80 | 22 | bearing seats with shoulders, ribs and flange bolt circles |
| `caps` | 80 | 16 | retaining / cover caps with spigots, nipples and bolt circles |
| `spacers` | 80 | 4 | bearing spacers: plain, flanged, stepped, slotted |
| `oldhams` | 80 | 3 | Oldham coupling parts: hub A, hub B and the centre disc (mating triples) |
| `hinges` | 80 | 3 | hinge leaves with knuckle rings, pin bore and screw pattern |
| `clips` | 80 | 3 | snap-fit cable clips with a real undercut throat |
| `ducts` | 80 | 2 | cable ducts with finger slots, floor holes and mounting ears |
| `knobs` | 80 | 3 | knurled / star / wing thumb knobs and nuts with set screws |
| `impellers` | 80 | 2 | impellers and fan rotors built from rotated blade loops |
| `enclosures` | 80 | 8 | enclosure bodies: walls, corner bosses, vent grilles, cable glands, ears |
| `lids` | 80 | 8 | matching enclosure lids with lips, ribs, countersinks and marking pads |
| `bezels` | 80 | 2 | display bezels with variable-depth outer chamfers and funnel openings |
| `trusses` | 80 | 3 | flat Pratt / Warren / Howe trusses with equal panels (graph rows) |
| `towers` | 80 | 3 | four-leg towers with alternating brace pitch (graph rows) |
| `quadframes` | 80 | 2 | quadcopter X / H frames with motor pads (graph rows) |
| `ibeams` | 80 | 4 | lattice I-beams: twin round flanges plus a zig-zag web (graph rows) |
| `pipes` | 80 | 2 | pipe routes with 90 and 45 degree elbows, collars and branches (graph rows) |
| `shafts` | 80 | 3 | stepped shafts turned from a closed rotate_extrude profile |
| `flanges` | 80 | 4 | bolt-circle flanges with hubs, spigots, spot faces and gasket grooves |
| `handles` | 80 | 4 | ergonomic handles: spline-like grip outline, finger rests, screw boss |

## Manifest row schema

One JSON object per line, exactly the fields from `docs/DATASET_REQUEST.md`:

```json
{
  "file": "lbrackets/part_0001.scad",
  "family": "lbrackets",
  "prompt_ru": "Общие габариты 65 на 32 на 55 мм — монтажный уголок. 2 отверстия M6 в горизонтальной полке. Обе полки толщиной 3.5 мм. 2 отверстия M6 в вертикальной полке. Печать FDM, сопло 0.6.",
  "prompt_en": "Dimensions 65 by 32 by 55 mm — L-shaped mount. Both legs 3.5 mm thick. Two M6 holes in the horizontal leg. Two M6 holes in the upright. Keep it parametric, I will adapt it to my setup.",
  "expected_bbox_mm": [
    65.0,
    32.0,
    55.0
  ],
  "parameters": {
    "depth": 32.0,
    "hole_d": 6.6,
    "holes": 4,
    "leg_a": 65.0,
    "leg_b": 55.0,
    "wall": 3.5
  },
  "graph": null
}
```

- `graph` is `null` for every voxel / sketch family and populated for the 400 wire samples (4537 nodes, 7804 edges in total). Graph nodes are the joint centres exactly as they appear in the source, edges are index pairs; members are cylinders whose ends sit inside the joint balls, so the mesh is a single solid and the graph is connected with strictly positive edge lengths.
- `expected_bbox_mm` is the *measured* bounding box of the evaluated solid, so the
  receiver's 15% tolerance check passes with the exact values.

## Prompt language

- words per RU prompt: min 18, median 33, max 52
- words per EN prompt: min 19, median 36, max 56
- a dedicated printing-tolerance sentence is injected with probability 0.21 (`prompts.tail`), which matches the ~20% asked for in the request
- measured over the corpus, 611 of 2240 samples (27%) mention a clearance / fit / tolerance phrase in at least one language (the rest of the hits come from the general chatty tails)
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
| <= 4000 tokens / ~12 KiB | largest file is 2.93 KiB |
| deterministic | seeded `Rng`, no `rands()`, re-running reproduces the same bytes |
| wire graph connected, no isolated nodes, positive edge lengths | graph audit in `common.check_part` |

## Bounding box statistics

| axis | min | median | max |
| --- | ---: | ---: | ---: |
| X | 8.7 | 69.8 | 248.3 |
| Y | 7.2 | 41.2 | 248.0 |
| Z | 5.0 | 21.0 | 248.6 |

## How to reproduce / verify

```bash
# regenerate byte-identically (writes manifest.jsonl + <family>/part_NNNN.scad):
python tools/dataset_gen2/build_corpus.py --count 80 --report

# verify the checksum list that ships with the corpus:
cd optional_data/data/gen2
sha256sum -c SHA256SUMS.txt

# receiver-side compile check (their pipeline, dropped if the exit code is non-zero):
openscad --backend=manifold -o /tmp/out.stl <family>/part_0001.scad

# standalone audit of the files on disk (no OpenSCAD needed):
python tools/dataset_gen2/verify_corpus.py --parts-dir optional_data/data/gen2

# repository pipeline: import the candidates, then validate them
python tools/import_external_scad.py --parts-dir optional_data/data/gen2 \
    --output data/processed/gen2_candidates.jsonl
python tools/validate_dataset.py --input data/processed/gen2_candidates.jsonl \
    --backend openscad --workers 2
```

## Checksums

`SHA256SUMS.txt` lists the SHA-256 of `manifest.jsonl` and of every `.scad` file, one `hash  path` pair per line. Any edit of a file after generation shows up as a mismatch, which is the rejection rule from the request (`SHA-256`).

