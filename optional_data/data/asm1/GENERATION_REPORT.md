# asm1 corpus - generation report

This file is the audit sheet for `optional_data/data/asm1`: it lists exactly what was added, how it was produced and how to re-verify it. Nothing in here is part of the training data itself - the corpus is `manifest.jsonl` plus the `.scad` files.

- generated: 2026-09-30 05:10 UTC
- samples: **900** across **10** families
- corpus size: 2938.2 KiB of text (manifest + sources)
- `manifest.jsonl` sha256: `271f147255d31384393c786964f2474102d1e46ac53636a341d757a6512af9ff`
- generator: `tools/dataset_asm1/` (`build2.py`, `scenes2.py`, `parts2.py`, `core2.py`)
- openSCAD CLI on this machine / openSCAD CLI на этой машине: no / нет; every check below was done on the manifold + trimesh stack instead, run `openscad --backend=manifold` on the receiving side to repeat it there
- seeds: deterministic, `Rng(family, index)` with fixed seed 20260929
- local gate: 900 samples evaluated with the manifold kernel (the same kernel OpenSCAD uses with `--backend=manifold`); 0 rejected before writing, 48 duplicate draws skipped
- wire graph connectivity: 0 graph rows, 0 disconnected, 0 with isolated nodes
- independent re-audit of the files on disk (`tools/dataset_asm1/`: the same checks the block ships with): 900 rows / 10 families / 0 graph rows re-evaluated, worst bbox deviation vs the manifest 0.00% (the receiver allows 15%), SHA-256 list verified, 0 problems
- assembly gate: every scene re-evaluated with the manifold kernel, 4138 placed parts in 900 scenes, smallest pairwise clearance 0.249 mm (the request asks for >= 0.2 mm)
- transform audit: the `assembly` rows carry mm translations and w-last quaternions; 4138 rows replayed, 0 mismatching the code
- part volumes add up: worst |sum(parts) - scene| 0.00% of the scene volume, so no two parts overlap and nothing is dropped; the build gate additionally compared every part with its designed solid (2 %) before writing it
- prompt uniqueness: duplicate RU 0, duplicate EN 0
- the corpus lives under `optional_data/`, which this repository ignores, so the deliverable was committed with `git add -f optional_data/data/asm1`

## What was added, file by file

| path (inside `optional_data/data/asm1`) | what it is | size |
| --- | --- | ---: |
| `manifest.jsonl` | 900 rows of metadata: file, family, `prompt_ru`, `prompt_en`, `expected_bbox_mm`, `parameters`, `assembly` (module + `t` + w-last `q` per part); sha256 `271f147255d31384393c786964f2474102d1e46ac53636a341d757a6512af9ff` | 1652.9 KiB |
| `<family>/part_NNNN.scad` | 900 source files in 10 single-word family directories, four-digit part numbers | 1285.3 KiB |
| `SHA256SUMS.txt` | one `sha256  path` pair per artifact, manifest first | 901 lines |
| `GENERATION_REPORT.md` | this audit sheet - not part of the training data | - |
| `tools/dataset_asm1/` (repository, not inside the corpus) | the generator that produced the corpus: 5 Python modules (`build2.py`, `core2.py`, `parts2.py`, `scenes2.py`, `verify2.py`) | - |

Nothing else in the repository is modified by this delivery: the request file `docs/DATASET_REQUEST.md` and the training pipeline are untouched, and outside `tools/dataset_asm1/` the only change is the corpus itself. Because `.gitignore` covers `optional_data/`, the files were force-added (`git add -f`); `git show --stat HEAD` lists the whole diff.

## What was added, family by family

| family | samples | variants | what it contains |
| --- | ---: | ---: | --- |
| `boltplate` | 90 | 2 | plate with 2-3 clearance holes, bolts through and nuts below |
| `shaftbearings` | 90 | 2 | housing cup, two bearings, a spacer ring and a shaft on the same axis |
| `bracketbolts` | 90 | 2 | L bracket with one or two horizontal bolt joints (washer, optional nut) |
| `flangelayers` | 90 | 2 | flange, gasket and cover with a common bolt pattern plus one fastener |
| `frameposts` | 90 | 2 | frame base with a window and four posts standing in clearance sockets |
| `pulleybelt` | 90 | 2 | two bored supports, a shaft, a flanged pulley and the belt in the groove |
| `spacercolumns` | 90 | 2 | base plate, one or two standoff spacers and the matching bolts |
| `shaftcollars` | 90 | 2 | shaft carrying spacer rings and set-screw collars, all turned 90 degrees |
| `clevispin` | 90 | 2 | clevis, eye lug in the slot and the pin through both, optional retainer |
| `bushingpress` | 90 | 2 | bored housing, flanged bushing, shaft through it and a bolted cover |

## Manifest row schema

One JSON object per line, exactly the fields from `docs/DATASET_REQUEST.md`:

```json
{
  "file": "lbrackets/part_0001.scad",
  "family": "lbrackets",
  "prompt_ru": "Собери модель узла: плита с болтами, 90 на 60 на 26.2 мм. Плита 90 x 60 x 8 мм с 3 отверстиями d6.8. Болт с резьбовым стержнем d6 длиной 22 мм, головка d12 x 4.2 мм. Болт с резьбовым стержнем d6 длиной 22 мм, головка d12 x 4.2 мм. Болт с резьбовым стержнем d6 длиной 22 мм, головка d12 x 4.2 мм. Установка на улице, нужен запас на УФ и влагу.",
  "prompt_en": "Put the assembly together: bolted plate, overall 90 by 60 by 26.2 mm. Plate 90 x 60 x 8 mm with 3 d6.8 holes. Bolt with a d6 shank 22 mm long and a d12 x 4.2 mm head. Bolt with a d6 shank 22 mm long and a d12 x 4.2 mm head. Bolt with a d6 shank 22 mm long and a d12 x 4.2 mm head. Outdoor installation, leave margin for UV and moisture.",
  "expected_bbox_mm": [
    90.0,
    60.0,
    26.2
  ],
  "parameters": {
    "bolt1_head_d": 12.0,
    "bolt1_head_h": 4.2,
    "bolt1_shank_d": 6.0,
    "bolt1_shank_l": 22.0,
    "bolt2_head_d": 12.0,
    "bolt2_head_h": 4.2,
    "bolt2_shank_d": 6.0,
    "bolt2_shank_l": 22.0,
    "bolt3_head_d": 12.0,
    "bolt3_head_h": 4.2,
    "bolt3_shank_d": 6.0,
    "bolt3_shank_l": 22.0,
    "parts": 4.0,
    "plate_hole_d": 6.8,
    "plate_length": 90.0,
    "plate_thickness": 8.0,
    "plate_width": 60.0
  },
  "graph": null
}
```

- `graph` is `null` for every voxel / sketch family and populated for the 0 wire samples (0 nodes, 0 edges in total). Graph nodes are the joint centres exactly as they appear in the source, edges are index pairs; members are cylinders whose ends sit inside the joint balls, so the mesh is a single solid and the graph is connected with strictly positive edge lengths.
- `expected_bbox_mm` is the *measured* bounding box of the evaluated solid, so the
  receiver's 15% tolerance check passes with the exact values.

## Prompt language

- words per RU prompt: min 44, median 67, max 91
- words per EN prompt: min 50, median 73, max 89
- a dedicated printing-tolerance sentence is injected with probability 0.21 (`prompts.tail`), which matches the ~20% asked for in the request
- measured over the corpus, 575 of 900 samples (64%) mention a clearance / fit / tolerance phrase in at least one language (the rest of the hits come from the general chatty tails)
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
| <= 4000 tokens / ~12 KiB | largest file is 2.46 KiB |
| unique samples | every prompt text and every source file is unique: a draw that repeats the bytes of an accepted part is skipped and the next seed is used |
| deterministic | seeded `Rng`, no `rands()`, re-running reproduces the same bytes |
| wire graph connected, no isolated nodes, positive edge lengths | graph audit in `common.check_part` |

## Bounding box statistics

| axis | min | median | max |
| --- | ---: | ---: | ---: |
| X | 60.0 | 120.0 | 200.0 |
| Y | 37.0 | 70.0 | 170.0 |
| Z | 24.2 | 63.4 | 108.2 |

## How to reproduce / verify

```bash
# regenerate byte-identically (writes manifest.jsonl + <family>/part_NNNN.scad):
python tools/dataset_asm1/build2.py --count 90 --report

# verify the checksum list that ships with the corpus:
cd optional_data/data/asm1
sha256sum -c SHA256SUMS.txt

# receiver-side compile check (their pipeline, dropped if the exit code is non-zero):
openscad --backend=manifold -o /tmp/out.stl <family>/part_0001.scad

# standalone audit of the files on disk (no OpenSCAD needed):
python tools/dataset_asm1/verify_corpus.py --parts-dir optional_data/data/asm1

# repository pipeline: import the candidates, then validate them
python tools/import_external_scad.py --parts-dir optional_data/data/asm1 \
    --output data/processed/asm1_candidates.jsonl
python tools/validate_dataset.py --input data/processed/asm1_candidates.jsonl \
    --backend openscad --workers 2
```

## Checksums

`SHA256SUMS.txt` lists the SHA-256 of `manifest.jsonl` and of every `.scad` file, one `hash  path` pair per line. Any edit of a file after generation shows up as a mismatch, which is the rejection rule from the request (`SHA-256`).

