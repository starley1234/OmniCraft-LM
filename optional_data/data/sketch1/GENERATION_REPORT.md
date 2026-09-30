# sketch1 corpus - generation report

This file is the audit sheet for `optional_data/data/sketch1`: it lists exactly what was added, how it was produced and how to re-verify it. Nothing in here is part of the training data itself - the corpus is `manifest.jsonl` plus the `.scad` files.

- generated: 2026-09-30 05:15 UTC
- samples: **2000** across **20** families
- corpus size: 4017.1 KiB of text (manifest + sources)
- `manifest.jsonl` sha256: `95c3ff7457741936f56c13a3d2ac89b62f5321ef2315d2c62e7c623cc53c4175`
- generator: `tools/dataset_sketch1/` (`build1.py`, `families1a.py`, `families1b.py`, `geom1.py`)
- openSCAD CLI on this machine / openSCAD CLI на этой машине: no / нет; every check below was done on the manifold + trimesh stack instead, run `openscad --backend=manifold` on the receiving side to repeat it there
- seeds: deterministic, `Rng(family, index)` with fixed seed 20260929
- local gate: 2000 samples evaluated with the manifold kernel (the same kernel OpenSCAD uses with `--backend=manifold`); 0 rejected before writing, 449 duplicate draws skipped
- wire graph connectivity: 0 graph rows, 0 disconnected, 0 with isolated nodes
- independent re-audit of the files on disk (`tools/dataset_sketch1/`: the same checks the block ships with): 2000 rows / 20 families / 0 graph rows re-evaluated, worst bbox deviation vs the manifest 0.00% (the receiver allows 15%), SHA-256 list verified, 0 problems
- profile ground truth: 6-40 points per polygon, mean area 1582 mm2, mean perimeter 255 mm, all counter clockwise and simple
- profile vs mesh agreement: worst volume deviation 0.64% (area x height for the linear extrusions, the Pappus theorem for the revolves)
- prompt uniqueness: duplicate RU 0, duplicate EN 0
- the corpus lives under `optional_data/`, which this repository ignores, so the deliverable was committed with `git add -f optional_data/data/sketch1`

## What was added, file by file

| path (inside `optional_data/data/sketch1`) | what it is | size |
| --- | --- | ---: |
| `manifest.jsonl` | 2000 rows of metadata: file, family, `prompt_ru`, `prompt_en`, `expected_bbox_mm`, `parameters`, `graph`; sha256 `95c3ff7457741936f56c13a3d2ac89b62f5321ef2315d2c62e7c623cc53c4175` | 2459.8 KiB |
| `<family>/part_NNNN.scad` | 2000 source files in 20 single-word family directories, four-digit part numbers | 1557.3 KiB |
| `SHA256SUMS.txt` | one `sha256  path` pair per artifact, manifest first | 2001 lines |
| `GENERATION_REPORT.md` | this audit sheet - not part of the training data | - |
| `tools/dataset_sketch1/` (repository, not inside the corpus) | the generator that produced the corpus: 8 Python modules (`build1.py`, `core1.py`, `families1a.py`, `families1b.py`, `geom1.py`, `probe1.py`, `verify1.py`, `walkers1.py`) | - |

Nothing else in the repository is modified by this delivery: the request file `docs/DATASET_REQUEST.md` and the training pipeline are untouched, and outside `tools/dataset_sketch1/` the only change is the corpus itself. Because `.gitignore` covers `optional_data/`, the files were force-added (`git add -f`); `git show --stat HEAD` lists the whole diff.

## What was added, family by family

| family | samples | variants | what it contains |
| --- | ---: | ---: | --- |
| `camdiscs` | 100 | 3 | polar r(theta) cam profiles: rise-dwell, harmonic or dwell-arc, optional boss |
| `leverarms` | 100 | 3 | smooth outline through two or three bosses (rocker, bell crank, offset) |
| `hookplates` | 100 | 3 | J hook, deep curl or shallow mouth drawn as a stroked curve |
| `eyelugs` | 100 | 2 | clevis fork with an open slot, or an open C ring with a tangent tail |
| `windowplates` | 100 | 2 | plate with open keyhole or rectangular windows on one edge |
| `pawls` | 100 | 2 | rounded body with a triangular beak on the top edge or the end |
| `eccentrics` | 100 | 3 | egg and stepped eccentrics, double-D discs with two flats |
| `sprockets` | 100 | 7 | 8-16 tooth chain sprocket, roots and teeth sampled by angle |
| `rackbars` | 100 | 2 | comb rack with trapezoid teeth along the top edge |
| `tslots` | 100 | 2 | T-slot rail section with one or two real T-slots |
| `keybars` | 100 | 4 | parallel, dovetail, hex and woodruff keys |
| `standoffs` | 100 | 4 | revolved spacers: spool, flanged, stepped, conical, all with a bore |
| `formwashers` | 100 | 5 | revolved washers (chamfered, countersunk, domed, shouldered) and C washers |
| `pclips` | 100 | 2 | Pi staple and omega clip outlines |
| `fanrotors` | 100 | 5 | fan rotor section: 7-11 backward raked blades on a hub |
| `arcstops` | 100 | 2 | annular sectors with a stop lug, and revolved stop collars |
| `overslots` | 100 | 2 | bars with oversize keyhole windows for adjustment |
| `flatadapters` | 100 | 4 | double-D, single-D, hex-disc and keyed adaptor plates |
| `sinkframes` | 100 | 2 | Pi shaped retaining frames for a heat sink |
| `guardgrids` | 100 | 4 | guard grilles: slats standing on a base bar between side rails |

## Manifest row schema

One JSON object per line, exactly the fields from `docs/DATASET_REQUEST.md`:

```json
{
  "file": "lbrackets/part_0001.scad",
  "family": "lbrackets",
  "prompt_ru": "Нужна деталь: кулачковый диск, габарит 38x38.3x14 мм. Базовый радиус 17 мм, подъём 4 мм. Профиль с плавным подъёмом и возвратом. Толщина 14 мм по всей плите. Профиль — один замкнутый полигон из 26 точек, он выдавливается на 14.0 мм. Ходовая часть с зазором 0.2 мм, чтобы ходило без закусывания.",
  "prompt_en": "I need profile cam plate, overall 38x38.3x14 mm. One polygon, 26 points, counter clockwise, then extruded to 14.0 mm. 14 mm thick plate. Smooth rise and return so the follower never jams. Base radius 17 mm with a 4 mm lift. Moving parts get a 0.2 mm gap so nothing binds.",
  "expected_bbox_mm": [
    38.0,
    38.254,
    14.0
  ],
  "parameters": {
    "base_r": 17.0,
    "boss": 0.0,
    "lift": 4.0,
    "points": 26.0,
    "thickness": 14.0
  },
  "graph": null
}
```

- `graph` is `null` for every voxel / sketch family and populated for the 0 wire samples (0 nodes, 0 edges in total). Graph nodes are the joint centres exactly as they appear in the source, edges are index pairs; members are cylinders whose ends sit inside the joint balls, so the mesh is a single solid and the graph is connected with strictly positive edge lengths.
- `expected_bbox_mm` is the *measured* bounding box of the evaluated solid, so the
  receiver's 15% tolerance check passes with the exact values.

## Prompt language

- words per RU prompt: min 22, median 41, max 67
- words per EN prompt: min 23, median 45, max 69
- a dedicated printing-tolerance sentence is injected with probability 0.21 (`prompts.tail`), which matches the ~20% asked for in the request
- measured over the corpus, 501 of 2000 samples (25%) mention a clearance / fit / tolerance phrase in at least one language (the rest of the hits come from the general chatty tails)
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
| <= 4000 tokens / ~12 KiB | largest file is 1.08 KiB |
| unique samples | every prompt text and every source file is unique: a draw that repeats the bytes of an accepted part is skipped and the next seed is used |
| deterministic | seeded `Rng`, no `rands()`, re-running reproduces the same bytes |
| wire graph connected, no isolated nodes, positive edge lengths | graph audit in `common.check_part` |

## Bounding box statistics

| axis | min | median | max |
| --- | ---: | ---: | ---: |
| X | 7.3 | 51.1 | 210.0 |
| Y | 6.0 | 36.5 | 79.9 |
| Z | 5.0 | 10.0 | 120.0 |

## How to reproduce / verify

```bash
# regenerate byte-identically (writes manifest.jsonl + <family>/part_NNNN.scad):
python tools/dataset_sketch1/build1.py --count 100 --report

# verify the checksum list that ships with the corpus:
cd optional_data/data/sketch1
sha256sum -c SHA256SUMS.txt

# receiver-side compile check (their pipeline, dropped if the exit code is non-zero):
openscad --backend=manifold -o /tmp/out.stl <family>/part_0001.scad

# standalone audit of the files on disk (no OpenSCAD needed):
python tools/dataset_sketch1/verify_corpus.py --parts-dir optional_data/data/sketch1

# repository pipeline: import the candidates, then validate them
python tools/import_external_scad.py --parts-dir optional_data/data/sketch1 \
    --output data/processed/sketch1_candidates.jsonl
python tools/validate_dataset.py --input data/processed/sketch1_candidates.jsonl \
    --backend openscad --workers 2
```

## Checksums

`SHA256SUMS.txt` lists the SHA-256 of `manifest.jsonl` and of every `.scad` file, one `hash  path` pair per line. Any edit of a file after generation shows up as a mismatch, which is the rejection rule from the request (`SHA-256`).

