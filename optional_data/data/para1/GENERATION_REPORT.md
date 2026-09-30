# para1 corpus - generation report

This file is the audit sheet for `optional_data/data/para1`: it lists exactly what was added, how it was produced and how to re-verify it. This corpus adds **no code**: each row points at a part that already exists in `optional_data/data/gen2` or `optional_data/data/gen3` through `code_ref`, so there is no duplicated geometry anywhere in the repository.

- generated: 2026-09-30 05:17 UTC
- rows: **4000** = 800 source parts x 5 registers
- registers: `formal_ru`, `shopslang_ru`, `chat_ru`, `tolerance_ru`, `technical_en`
- families covered: 54 (uniform per family, round robin over both corpora)
- `manifest.jsonl` sha256: `c28f69d9a6e0354b9e9591e1c768a6d045bed3e8e0b5641a3a6bf8fad37b281e`
- generator: `tools/dataset_para1/` (`registers.py`, `build_para1.py`); facts are taken from the source part (its own prompt sentences, envelope and parameters), so a paraphrase cannot contradict the code it points at
- uniqueness: RU prompts unique, EN prompts unique (76 draws re-rolled to keep it that way); a paraphrase identical to the source prompt would have been a copy: 0
- prompt sizes: RU mean 157.6 / max 283 chars, EN mean 143.3 / max 240 chars
- independent re-audit (`tools/dataset_para1/verify_para1.py`): 4000 rows, 800 sources, 5 registers, every `code_ref` resolved: True, envelope cross-check against the source manifest: True, SHA-256 list verified, 0 problems
- families: 54 from two corpora, 70..75 rows per family
- registers per source: [('chat_ru', 800), ('formal_ru', 800), ('shopslang_ru', 800), ('technical_en', 800), ('tolerance_ru', 800)]
- style gate: 0 rows outside the register rules (chat <= 260 chars with a size, tolerance row carries a fit, formal >= 120 chars, English register is Latin text with only '°±²³×Ø–—′⌀ allowed as symbols)
- the corpus lives under `optional_data/`, which this repository ignores, so the deliverable was committed with `git add -f optional_data/data/para1`

## What was added, file by file

| path (inside `optional_data/data/para1`) | what it is | size |
| --- | --- | ---: |
| `manifest.jsonl` | 4000 rows: id, source_id, corpus, family, register, lang, prompt_ru, prompt_en, expected_bbox_mm, code_ref | 2643.7 KiB |
| `source_index.json` | the 800 source parts: source_id, corpus, family, code_ref, envelope | |
| `SHA256SUMS.txt` | checksums of the two files above | |
| `GENERATION_REPORT.md` | this sheet | |

## Registers

| register | language | what it looks like |
| --- | --- | --- |
| `formal_ru` | RU | formal engineering request, envelope first, one feature sentence, formal closing |
| `shopslang_ru` | RU | shop floor slang, dimensions as "где-то 120 на 80" |
| `chat_ru` | RU | short chat message with the envelope and one key size |
| `tolerance_ru` | RU | fits and tolerances, imperial equivalents quoted when a parameter hits one |
| `technical_en` | EN | English technical request, envelope plus feature sentence |

## Rows per family

| family | rows |
| --- | ---: |
| `airducts` | 75 |
| `archtrusses` | 75 |
| `bearingblocks` | 75 |
| `bearings` | 75 |
| `beltrollers` | 75 |
| `bezels` | 75 |
| `cams` | 75 |
| `caps` | 75 |
| `cardans` | 75 |
| `chassisframes` | 75 |
| `cleats` | 75 |
| `clips` | 75 |
| `ducts` | 75 |
| `enclosures` | 75 |
| `fairings` | 75 |
| `flanges` | 75 |
| `handles` | 75 |
| `heatsinks` | 75 |
| `helicalgears` | 75 |
| `herringbones` | 75 |
| `hexlattices` | 75 |
| `hinges` | 75 |
| `hooks` | 75 |
| `ibeams` | 75 |
| `impellers` | 75 |
| `knobs` | 75 |
| `lbrackets` | 75 |
| `levers` | 75 |
| `lids` | 75 |
| `livinghinges` | 75 |
| `motormounts` | 75 |
| `oldhams` | 75 |
| `pipeclamps` | 75 |
| `pipes` | 75 |
| `pulleys` | 75 |
| `quadframes` | 75 |
| `racks` | 75 |
| `ringgears` | 70 |
| `scissorgrids` | 70 |
| `shafts` | 75 |
| `slottedpanels` | 70 |
| `snapfits` | 70 |
| `spacers` | 75 |
| `springclamps` | 70 |
| `spurgears` | 75 |
| `steptowers` | 70 |
| `threadcaps` | 70 |
| `threads` | 70 |
| `thumbscrews` | 70 |
| `towers` | 75 |
| `trusses` | 75 |
| `ubrackets` | 75 |
| `wormwheels` | 70 |
| `zbrackets` | 75 |

## How to re-verify

```bash
python tools/dataset_para1/verify_para1.py --parts-dir optional_data/data/para1
python tools/dataset_gen2/verify_corpus.py --parts-dir optional_data/data/gen2
python tools/dataset_gen3/...  # gen3 has no separate verifier: use dataset_gen2/verify_corpus.py
```

The verifier re-reads the manifest, resolves every `code_ref`, re-loads the referenced source manifest and compares envelopes, checks the five registers per source, prompt uniqueness and the register style rules (chat rows are short, tolerance rows carry a fit, English rows are ASCII).
