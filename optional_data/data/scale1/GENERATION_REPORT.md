# scale1 corpus - generation report

Audit sheet for `optional_data/data/scale1` (leftover of request no. 6: real-scale disciplines). Not part of the training data - the corpus is `manifest.jsonl` plus the `.scad` files.

- generated: 2026-10-01, seed `Rng(family, index)` with fixed seed 20261001
- samples: **800** across **4** families (200 each)
- corpus size: 1342.9 KiB of text (manifest + 800 sources)
- `manifest.jsonl` sha256: `f7fe7c6f5a013c0e8e21820ca973710edc05e5906e254e803ae97523fce89ff1`
- generator: `tools/dataset_scale1/` (`families1x.py`, `build_scale1.py`, `verify_scale1.py`)
- **OpenSCAD CLI on the generation machine: absent.** Every check below ran on the manifold3d + trimesh stack (the kernel OpenSCAD uses with `--backend=manifold`). Final acceptance requires a real `openscad --backend=manifold` run on the receiving side.
- local gate per sample: gen2 `check_part` (header, forbidden constructs, ≤ 12 KiB, manifold evaluation to a single solid, declared-vs-measured bbox ≤ 3 %) + family axis rules + the place1 consistency law on both prompts
- scale audit: `microfeatures` all axes ≤ 20 mm (min 5), `largestruc` long axis 200-250 mm, `thinwalls` walls 1.2-1.5 mm, every axis inside 5-250 mm
- prompt consistency (place1 law, both languages): **800/800 rows = 100 %** of prompt dimension numbers present in the code for RU and EN - including the explicit `(x, y)` coordinates quoted by `hardlayouts` prompts
- independent re-audit from disk (`verify_scale1.py`): 800 rows re-evaluated, **sha256 bad 0, duplicate RU/EN prompts 0/0, problems: 0 rows failed**
- build rejects: 28 deliberate draw-rejects (e.g. `hole_field` plates that would put an axis under 5 mm) - rejected draws never reach disk

## Families

| family | samples | what it contains |
| --- | ---: | --- |
| `microfeatures` | 200 | pads, flanged posts, clip blocks - everything inside a 5-20 mm box |
| `largestruc` | 200 | rails, adapter plates, hollow box beams, L brackets with a 200-250 mm axis |
| `hardlayouts` | 200 | boss/hole/mixed fields at explicit prompt-dictated coordinates |
| `thinwalls` | 200 | open boxes, tubes, ribbed panels with 1.2-1.5 mm walls |

## Re-verification

```bash
python tools/dataset_scale1/verify_scale1.py --parts-dir optional_data/data/scale1
# receiving side (the only legitimate acceptance):
openscad --backend=manifold -o /tmp/check.stl optional_data/data/scale1/<family>/part_NNNN.scad
python tools/verify_delivery.py optional_data/data/scale1
```
