# place1 corpus - generation report

This file is the audit sheet for `optional_data/data/place1`: it lists exactly what was added, how it was produced and how to re-verify it. Nothing in here is part of the training data itself - the corpus is `manifest.jsonl` plus the `.scad` files.

- generated: 2026-09-30 10:25 UTC
- samples: **2070** across **9** families
- corpus size: 6271.9 KiB of text (manifest + sources)
- `manifest.jsonl` sha256: `216e99b1e584d676d4545c04ce3009e6d365e192fa35dafbe45dfec328976361`
- generator: `tools/dataset_place1/` (`build_place1.py`, `families4a.py`, `families4b.py`, `core4.py`, `prompts4.py`)
- openSCAD CLI on this machine / openSCAD CLI на этой машине: no / нет; every check below was done on the manifold + trimesh stack instead, run `openscad --backend=manifold` on the receiving side to repeat it there
- seeds: deterministic, `Rng(family, index)` with fixed seed 20260929
- local gate: 2070 samples evaluated with the manifold kernel (the same kernel OpenSCAD uses with `--backend=manifold`); 0 rejected before writing, 29 duplicate draws skipped
- placement blocks: 9 layout rules (corners, bolt_circle, perforation, rib_row, row, pocket_grid, rack, boss_grid) with the declared centres in mm and the probe spec the audit re-runs
- independent re-audit of the files on disk (`tools/dataset_place1/`: the same checks the block ships with): 2070 rows / 9 families / every row re-evaluated, worst bbox deviation vs the manifest 0.00% (the receiver allows 15%), SHA-256 list verified, 0 problems
- consistency chief check: every number of the RU and EN prompt must be present in the code; 35845 of 35845 prompt numbers found (100.00 %), 2070 of 2070 rows carry no magic coordinates either
- consistency auditor: 100.0% pass
- placement rules re-derived from the code for 2070 of 2070 samples (counts, edge offsets, pitch, bolt circles, lattices, mirror symmetry)
- feature probe re-run by the independent audit: 17597 declared centres intersected with the solid, 0 mismatching
- the build gate additionally proved every sample before writing it: one connected solid, bounding box within 3 %, an empty cube inside every declared hole and a solid cube where a wrong layout would have drilled one
- the corpus lives under `optional_data/`, which this repository ignores, so the deliverable was committed with `git add -f optional_data/data/place1`

## What was added, file by file

| path (inside `optional_data/data/place1`) | what it is | size |
| --- | --- | ---: |
| `manifest.jsonl` | 2070 rows of metadata: file, family, `prompt_ru`, `prompt_en`, `expected_bbox_mm`, `parameters`, `placement` (layout rule + centres + probe) ; sha256 `216e99b1e584d676d4545c04ce3009e6d365e192fa35dafbe45dfec328976361` | 2709.9 KiB |
| `<family>/part_NNNN.scad` | 2070 source files in 9 single-word family directories, four-digit part numbers | 3561.9 KiB |
| `SHA256SUMS.txt` | one `sha256  path` pair per artifact, manifest first | 2071 lines |
| `GENERATION_REPORT.md` | this audit sheet - not part of the training data | - |
| `tools/dataset_place1/` (repository, not inside the corpus) | the generator that produced the corpus: 9 Python modules (`build_place1.py`, `check_consistency.py`, `common4.py`, `core4.py`, `families4a.py`, `families4b.py`, `probe4.py`, `prompts4.py`, `verify_place1.py`) | - |

Nothing else in the repository is modified by this delivery: the request file `docs/DATASET_REQUEST.md` and the training pipeline are untouched, and outside `tools/dataset_place1/` the only change is the corpus itself. Because `.gitignore` covers `optional_data/`, the files were force-added (`git add -f`); `git show --stat HEAD` lists the whole diff.

## What was added, family by family

| family | samples | variants | what it contains |
| --- | ---: | ---: | --- |
| `cornerplates` | 230 | 4 | 4 / 6 / 8 holes at the corners (and three of the four), centres taken from the edge offset |
| `boltcircles` | 230 | 2 | N holes on a bolt circle: pitch circle diameter and the angle of the first hole |
| `perfpanels` | 230 | 3 | straight rows x cols perforation, checkerboard perforation, perimeter ring |
| `ribframes` | 230 | 2 | ribs at a pitch in a single row, and ribs staggered from side to side |
| `ventrows` | 230 | 3 | a linear row with end offsets, holes drilled every other grid slot, two parallel rows |
| `pocketplates` | 230 | 3 | 2x2 / 3x3 / 2x3 pockets of one depth on a pitch, floor left under each |
| `anchorpads` | 230 | 1 | four corner bosses with anchor holes through boss and base |
| `rackbars` | 230 | 1 | rack teeth at a pitch along the top edge of a bar |
| `socketpads` | 230 | 2 | corner bosses and a boss grid with counterbored sockets plus through holes |

## Manifest row schema

One JSON object per line, exactly the fields from `docs/DATASET_REQUEST.md`:

```json
{
  "file": "cornerplates/part_0001.scad",
  "family": "cornerplates",
  "id": "place1_cornerplates_0001",
  "variant": "four",
  "prompt_ru": "Помоги сделать профильную пластину габаритом 70 x 60 x 6 мм. По углам 4 отверстия ø10.5, 8 мм от кромки, отверстия сквозные. Точность посадочных мест ±0.05 мм, остальное по 0.3. Размеры взял с чертежа, они важны.",
  "prompt_en": "I need a profile plate size 70 x 60 x 6 mm. 4 holes at Ø10.5 mm in the corners, 8 mm in from the edge; the holes go right through the plate. Fits to ±0.05 mm, everything else 0.3 mm. Material is PA6-CF, the model does not depend on it.",
  "expected_bbox_mm": [
    70.0,
    60.0,
    6.0
  ],
  "parameters": {
    "edge": 8.0,
    "hole_d": 10.5,
    "holes": 4.0,
    "plate_l": 70.0,
    "plate_w": 60.0,
    "thickness": 6.0
  },
  "placement": {
    "array": "feature_centers",
    "centers_mm": [
      [
        27.0,
        22.0
      ],
      [
        -27.0,
        22.0
      ],
      [
        -27.0,
        -22.0
      ],
      [
        27.0,
        -22.0
      ]
    ],
    "count": 4,
    "fields": {
      "edge_mm": 8.0,
      "hole_d_mm": 10.5
    },
    "kind": "corners",
    "probe": {
      "kind": "void",
      "size_mm": 3.0,
      "z_mm": 0.0
    },
    "symmetry": "mirror_xy"
  },
  "graph": null
}
```

- `graph` is `null` for every sample - the placement corpus carries a `placement` block instead: the layout rule (`kind`), the number of features the prompt states (`count`), every centre in mm, the mirror symmetry and the probe spec (a cube at each centre that must be empty for holes and pockets, filled for ribs, teeth and bosses).
- `expected_bbox_mm` is the *measured* bounding box of the evaluated solid, so the
  receiver's 15% tolerance check passes with the exact values.

## Prompt language

- words per RU prompt: min 24, median 41, max 66
- words per EN prompt: min 33, median 47, max 80
- shop tolerances are quoted with probability 0.05 (`common4.tolerance_note`); the sentence (RU «Точность посадочных мест ±0.1 мм, остальное по 0.3.», EN «Fits to ±0.1 mm, everything else 0.3 mm.») is the one Заявка №2 uses, and both of its numbers are declared in the code header (`seat_tol`, `free_tol`) like every other prompt number
- measured over the corpus, 508 of 2070 samples (25%) mention a clearance / fit / tolerance phrase in at least one language (the rest of the hits come from the general chatty tails)
- every prompt carries the overall size in mm in both languages

## Hard-rule checklist (verified locally before writing)

| rule from the request | local check |
| --- | --- |
| first line `$fn = 32;` | byte-exact, `check_place` + builder assert |
| fully parametric, no magic numbers | every dimension is a header parameter or a coordinate derived from one; the audit flags literal coordinates inside `translate` / `cylinder` / `cube` calls |
| no zero-area tangencies | every cut keeps >= 0.2 mm of material to the nearest free surface; the corner family clamps its offset to `hole_d / 2 + 1.5 mm`, the rack bar holds the teeth over the bar |
| one connected solid | `Manifold.decompose()` length == 1 for all samples |
| self-contained code | no `import`/`surface`/`text`/`children`/`echo`/`rands` |
| 5-250 mm per axis | checked per sample; below 5 mm or above 250 mm is rejected |
| wall thickness >= 1.2 mm | the narrowest wall of the corpus is a hole wall to the plate edge; probes prove every declared hole / pocket empty and every rib, tooth and boss solid, so a thin wall would show up as a probe failure |
| <= 4000 tokens / ~12 KiB | largest file is 5.35 KiB |
| unique samples | every prompt text and every source file is unique: a draw that repeats the bytes of an accepted part is skipped and the next seed is used |
| deterministic | seeded `Rng`, no `rands()`, re-running reproduces the same bytes |
| every prompt number lives in the code | the auditor extracts the numbers of the RU and EN prompt and the numbers of the header and body; `verify_place1.py` re-derives counts, edge offsets, pitch, bolt circle angles and mirror symmetry from the header and intersects a probe cube at every declared centre |

## Bounding box statistics

| axis | min | median | max |
| --- | ---: | ---: | ---: |
| X | 38.0 | 120.0 | 240.0 |
| Y | 16.0 | 70.0 | 138.0 |
| Z | 5.0 | 15.0 | 33.0 |

## How to reproduce / verify

```bash
# regenerate byte-identically (writes manifest.jsonl + <family>/part_NNNN.scad):
python tools/dataset_place1/build_place1.py --count 230 --report

# verify the checksum list that ships with the corpus:
cd optional_data/data/place1
sha256sum -c SHA256SUMS.txt

# receiver-side compile check (their pipeline, dropped if the exit code is non-zero):
openscad --backend=manifold -o /tmp/out.stl <family>/part_0001.scad

# standalone audit of the files on disk (no OpenSCAD needed):
python tools/dataset_place1/verify_place1.py --parts-dir optional_data/data/place1

# the consistency auditor the request asks for (its last line is the pass rate):
python tools/dataset_place1/check_consistency.py --parts-dir optional_data/data/place1 --prompt-lang en

# repository pipeline: import the candidates, then validate them
python tools/import_external_scad.py --parts-dir optional_data/data/place1 \
    --output data/processed/place1_candidates.jsonl
python tools/validate_dataset.py --input data/processed/place1_candidates.jsonl \
    --backend openscad --workers 2
```

## Checksums

`SHA256SUMS.txt` lists the SHA-256 of `manifest.jsonl` and of every `.scad` file, one `hash  path` pair per line. Any edit of a file after generation shows up as a mismatch, which is the rejection rule from the request (`SHA-256`).

