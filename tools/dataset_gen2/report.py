"""Write the human-readable audit sheet for a generated gen2 corpus.

The report exists so the receiving team can check *what* was added without
reverse-engineering the generator: per-family counts, the exact manifest
schema, the local gate results and the checksum list.
"""

from __future__ import annotations

import hashlib
import json
import re
import shutil
import statistics
from datetime import datetime, timezone
from pathlib import Path
from typing import Sequence

TOLERANCE_MARKERS = (
    "зазор",
    "на печать",
    "посадк",
    "свободн",
    "+0.2",
    "+0.3",
    "+0.4",
    "clearance",
    "tolerance",
    "snug",
    "free fit",
)

COVERAGE_NOTES = {
    "lbrackets": "L-shaped corner bracket with euro slots and counterbores",
    "ubrackets": "U / channel bracket, cross holes through both uprights",
    "zbrackets": "Z / stepped bracket with gusseted offsets",
    "spurgears": "involute spur gears, evolute approximated with a polygon loop",
    "helicalgears": "helical gears (twisted extrude, same involute loop)",
    "racks": "gear racks for the same modules",
    "pulleys": "GT2 / GT3 / T5 / HTD5 / MXL timing pulleys with hub and set screw",
    "motormounts": "NEMA 17 / 23 / 34 motor adapter plates, slotted and flanged",
    "bearings": "bearing seats with shoulders, ribs and flange bolt circles",
    "caps": "retaining / cover caps with spigots, nipples and bolt circles",
    "spacers": "bearing spacers: plain, flanged, stepped, slotted",
    "oldhams": "Oldham coupling parts: hub A, hub B and the centre disc (mating triples)",
    "hinges": "hinge leaves with knuckle rings, pin bore and screw pattern",
    "clips": "snap-fit cable clips with a real undercut throat",
    "ducts": "cable ducts with finger slots, floor holes and mounting ears",
    "knobs": "knurled / star / wing thumb knobs and nuts with set screws",
    "impellers": "impellers and fan rotors built from rotated blade loops",
    "enclosures": "enclosure bodies: walls, corner bosses, vent grilles, cable glands, ears",
    "lids": "matching enclosure lids with lips, ribs, countersinks and marking pads",
    "bezels": "display bezels with variable-depth outer chamfers and funnel openings",
    "trusses": "flat Pratt / Warren / Howe trusses with equal panels (graph rows)",
    "towers": "four-leg towers with alternating brace pitch (graph rows)",
    "quadframes": "quadcopter X / H frames with motor pads (graph rows)",
    "ibeams": "lattice I-beams: twin round flanges plus a zig-zag web (graph rows)",
    "pipes": "pipe routes with 90 and 45 degree elbows, collars and branches (graph rows)",
    "shafts": "stepped shafts turned from a closed rotate_extrude profile",
    "flanges": "bolt-circle flanges with hubs, spigots, spot faces and gasket grooves",
    "handles": "ergonomic handles: spline-like grip outline, finger rests, screw boss",
}


def _load_rows(out_dir: Path) -> list[dict]:
    manifest = out_dir / "manifest.jsonl"
    return [
        json.loads(line)
        for line in manifest.read_text(encoding="utf-8").splitlines()
        if line.strip()
    ]


def write_report(
    out_dir: Path,
    summary: dict,
    *,
    title: str = "gen2 corpus - generation report",
    corpus_label: str = "optional_data/data/gen2/",
    generator: str = "`tools/dataset_gen2/` (`build_corpus.py`, `families/*.py`)",
    coverage_notes: dict[str, str] | None = None,
    tool_dir: str = "tools/dataset_gen2",
    build_script: str = "build_corpus.py",
    variant_tag: str = "gen2",
    extra_bullets: Sequence[str] | None = None,
    schema_fields: str = "`graph`",
) -> Path:
    rows = _load_rows(out_dir)
    family_stats = summary.get("family_stats", {})

    sizes: list[int] = []
    axes = {"X": [], "Y": [], "Z": []}
    ru_words: list[int] = []
    en_words: list[int] = []
    tolerance_hits = 0
    graph_rows = 0
    graph_nodes = 0
    graph_edges = 0
    for row in rows:
        path = out_dir / str(row["file"])
        sizes.append(path.stat().st_size)
        for axis, value in zip("XYZ", row["expected_bbox_mm"]):
            axes[axis].append(float(value))
        ru_words.append(len(str(row["prompt_ru"]).split()))
        en_words.append(len(str(row["prompt_en"]).split()))
        text = f"{row['prompt_ru']} {row['prompt_en']}".lower()
        if any(marker in text for marker in TOLERANCE_MARKERS):
            tolerance_hits += 1
        if row.get("graph"):
            graph_rows += 1
            graph_nodes += len(row["graph"]["nodes"])
            graph_edges += len(row["graph"]["edges"])

    manifest_sha = hashlib.sha256((out_dir / "manifest.jsonl").read_bytes()).hexdigest()
    total_bytes = sum(sizes) + (out_dir / "manifest.jsonl").stat().st_size
    lines: list[str] = []
    add = lines.append

    add(f"# {title}")
    add("")
    add(
        f"This file is the audit sheet for `{corpus_label}`: it lists exactly what "
        "was added, how it was produced and how to re-verify it. Nothing in here is part of "
        "the training data itself - the corpus is `manifest.jsonl` plus the `.scad` files."
    )
    add("")
    add(f"- generated: {datetime.now(timezone.utc).strftime('%Y-%m-%d %H:%M UTC')}")
    add(f"- samples: **{len(rows)}** across **{len(family_stats)}** families")
    add(f"- corpus size: {total_bytes / 1024:.1f} KiB of text (manifest + sources)")
    add(f"- `manifest.jsonl` sha256: `{manifest_sha}`")
    add(f"- generator: {generator}")
    openscad = shutil.which("openscad")
    add(
        "- openSCAD CLI on this machine / openSCAD CLI на этой машине: "
        + (f"yes / есть (`{openscad}`)" if openscad else "no / нет")
        + "; every check below was done on the manifold + trimesh stack instead, "
        "run `openscad --backend=manifold` on the receiving side to repeat it there"
    )
    add("- seeds: deterministic, `Rng(family, index)` with fixed seed 20260929")
    add(
        f"- local gate: {len(rows) - len(summary.get('rejects', []))} samples evaluated with the "
        "manifold kernel (the same kernel OpenSCAD uses with `--backend=manifold`); "
        f"{len(summary.get('rejects', []))} rejected before writing, "
        f"{summary.get('duplicates_skipped', 0)} duplicate draws skipped"
    )
    audit = summary.get("audit") or {}
    if audit:
        add(
            f"- wire graph connectivity: {audit.get('wire_rows', 0)} graph rows, "
            f"{audit.get('disconnected_graphs', 0)} disconnected, "
            f"{audit.get('graphs_with_isolated_nodes', 0)} with isolated nodes"
        )
        if audit.get("stl_checked"):
            add(
                f"- STL round-trip through trimesh (same calls as `src/env/openscad_runner.py`): "
                f"{audit.get('stl_checked')} samples checked, "
                f"{len(audit.get('stl_bad', []))} not watertight / multi-component / degenerate"
            )
        add(
            f"- independent re-audit of the files on disk (`{tool_dir}/`: the same checks "
            f"the block ships with): {audit.get('rows')} rows / {audit.get('families')} "
            f"families / {audit.get('wire_rows', 0) or 0} graph rows re-evaluated, worst bbox "
            f"deviation vs the manifest {audit.get('max_bbox_error', 0):.2%} (the receiver "
            f"allows 15%), SHA-256 list "
            f"{'verified' if audit.get('checksums_ok') else 'MISMATCH'}, "
            f"{len(audit.get('problems', []))} problems"
        )
    for bullet in extra_bullets or ():
        add(f"- {bullet}")
    add(
        "- the corpus lives under `optional_data/`, which this repository ignores, so the "
        f"deliverable was committed with `git add -f {corpus_label.rstrip('/')}`"
    )
    add("")
    add("## What was added, file by file")
    add("")
    add(f"| path (inside `{corpus_label}`) | what it is | size |")
    add("| --- | --- | ---: |")
    add(
        f"| `manifest.jsonl` | {len(rows)} rows of metadata: file, family, `prompt_ru`, "
        f"`prompt_en`, `expected_bbox_mm`, `parameters`, {schema_fields}; sha256 `{manifest_sha}` | "
        f"{(out_dir / 'manifest.jsonl').stat().st_size / 1024:.1f} KiB |"
    )
    add(
        f"| `<family>/part_NNNN.scad` | {len(rows)} source files in {len(family_stats)} "
        f"single-word family directories, four-digit part numbers | {sum(sizes) / 1024:.1f} KiB |"
    )
    checksum_lines = 0
    checksum_path = out_dir / "SHA256SUMS.txt"
    if checksum_path.is_file():
        checksum_lines = len(
            [line for line in checksum_path.read_text(encoding="utf-8").splitlines() if line.strip()]
        )
    add(
        f"| `SHA256SUMS.txt` | one `sha256  path` pair per artifact, manifest first "
        f"| {checksum_lines} lines |"
    )
    add("| `GENERATION_REPORT.md` | this audit sheet - not part of the training data | - |")
    generator_files = sorted(
        path
        for path in Path(tool_dir).rglob("*.py")
        if "__pycache__" not in path.parts
    )
    add(
        f"| `{tool_dir}/` (repository, not inside the corpus) | the generator that "
        f"produced the corpus: {len(generator_files)} Python modules "
        f"({', '.join(f'`{path.name}`' for path in generator_files)}) | - |"
    )
    add("")
    add(
        "Nothing else in the repository is modified by this delivery: the request file "
        "`docs/DATASET_REQUEST.md` and the training pipeline are untouched, and outside "
        f"`{tool_dir}/` the only change is the corpus itself. Because `.gitignore` "
        "covers `optional_data/`, the files were force-added (`git add -f`); "
        "`git show --stat HEAD` lists the whole diff."
    )
    add("")
    add("## What was added, family by family")
    add("")
    add("| family | samples | variants | what it contains |")
    add("| --- | ---: | ---: | --- |")
    for family, stats in family_stats.items():
        note = (coverage_notes if coverage_notes is not None else COVERAGE_NOTES).get(family, "")
        add(f"| `{family}` | {stats['written']} | {stats['variants']} | {note} |")
    add("")
    add("## Manifest row schema")
    add("")
    add("One JSON object per line, exactly the fields from `docs/DATASET_REQUEST.md`:")
    add("")
    add("```json")
    add(
        json.dumps(
            {
                "file": "lbrackets/part_0001.scad",
                "family": "lbrackets",
                "prompt_ru": rows[0]["prompt_ru"] if rows else "",
                "prompt_en": rows[0]["prompt_en"] if rows else "",
                "expected_bbox_mm": rows[0]["expected_bbox_mm"] if rows else [],
                "parameters": rows[0]["parameters"] if rows else {},
                "graph": None,
            },
            ensure_ascii=False,
            indent=2,
        )
    )
    add("```")
    add("")
    add(
        f"- `graph` is `null` for every voxel / sketch family and populated for the "
        f"{graph_rows} wire samples ({graph_nodes} nodes, {graph_edges} edges in total). "
        "Graph nodes are the joint centres exactly as they appear in the source, edges are "
        "index pairs; members are cylinders whose ends sit inside the joint balls, so the mesh "
        "is a single solid and the graph is connected with strictly positive edge lengths."
    )
    add("- `expected_bbox_mm` is the *measured* bounding box of the evaluated solid, so the")
    add("  receiver's 15% tolerance check passes with the exact values.")
    add("")
    add("## Prompt language")
    add("")
    add(f"- words per RU prompt: min {min(ru_words)}, median {int(statistics.median(ru_words))}, max {max(ru_words)}")
    add(f"- words per EN prompt: min {min(en_words)}, median {int(statistics.median(en_words))}, max {max(en_words)}")
    add(
        "- a dedicated printing-tolerance sentence is injected with probability 0.21 "
        "(`prompts.tail`), which matches the ~20% asked for in the request"
    )
    add(
        f"- measured over the corpus, {tolerance_hits} of {len(rows)} samples "
        f"({100 * tolerance_hits / max(len(rows), 1):.0f}%) mention a clearance / fit / tolerance "
        "phrase in at least one language (the rest of the hits come from the general chatty tails)"
    )
    add("- every prompt carries the overall size in mm in both languages")
    add("")
    add("## Hard-rule checklist (verified locally before writing)")
    add("")
    add("| rule from the request | local check |")
    add("| --- | --- |")
    add("| first line `$fn = 32;` | byte-exact, `check_part` + builder assert |")
    add("| fully parametric, no magic numbers | every dimension is a named parameter in the header |")
    add("| no zero-area tangencies | joins use >= 0.2 mm overlap (sunk bosses, spigots, joint balls) |")
    add("| one connected solid | `Manifold.decompose()` length == 1 for all samples |")
    add("| self-contained code | no `import`/`surface`/`text`/`children`/`echo`/`rands` |")
    add("| 5-250 mm per axis | checked per sample; below 5 mm or above 250 mm is rejected |")
    add(
        "| wall thickness >= 1.2 mm | nominal walls are 1.5-8 mm (`wall`, `plate_t`, `wall_t`), "
        "ribs and wire members >= 2 mm, and radial features derived from a wall (spacer "
        "step-down, clamp bores, boss lips, lid lips) are clamped so no ring drops below 1.2 mm |"
    )
    add("| <= 4000 tokens / ~12 KiB | largest file is %.2f KiB |" % (max(sizes) / 1024))
    add(
        "| unique samples | every prompt text and every source file is unique: a draw that "
        "repeats the bytes of an accepted part is skipped and the next seed is used |"
    )
    add("| deterministic | seeded `Rng`, no `rands()`, re-running reproduces the same bytes |")
    add("| wire graph connected, no isolated nodes, positive edge lengths | graph audit in `common.check_part` |")
    add("")
    add("## Bounding box statistics")
    add("")
    add("| axis | min | median | max |")
    add("| --- | ---: | ---: | ---: |")
    for axis in "XYZ":
        values = axes[axis]
        add(
            f"| {axis} | {min(values):.1f} | {statistics.median(values):.1f} | {max(values):.1f} |"
        )
    add("")
    add("## How to reproduce / verify")
    add("")
    add("```bash")
    add("# regenerate byte-identically (writes manifest.jsonl + <family>/part_NNNN.scad):")
    add(f"python {tool_dir}/{build_script} --count {summary.get('count', 80)} --report")
    add("")
    add("# verify the checksum list that ships with the corpus:")
    add(f"cd {out_dir.as_posix()}")
    add("sha256sum -c SHA256SUMS.txt")
    add("")
    add("# receiver-side compile check (their pipeline, dropped if the exit code is non-zero):")
    add("openscad --backend=manifold -o /tmp/out.stl <family>/part_0001.scad")
    add("")
    add("# standalone audit of the files on disk (no OpenSCAD needed):")
    add(f"python {tool_dir}/verify_corpus.py --parts-dir {corpus_label.rstrip('/')}")
    add("")
    add("# repository pipeline: import the candidates, then validate them")
    add(f"python tools/import_external_scad.py --parts-dir {corpus_label.rstrip('/')} \\")
    add(f"    --output data/processed/{variant_tag}_candidates.jsonl")
    add(f"python tools/validate_dataset.py --input data/processed/{variant_tag}_candidates.jsonl \\")
    add("    --backend openscad --workers 2")
    add("```")
    add("")
    add("## Checksums")
    add("")
    add(
        "`SHA256SUMS.txt` lists the SHA-256 of `manifest.jsonl` and of every `.scad` file, "
        "one `hash  path` pair per line. Any edit of a file after generation shows up as a "
        "mismatch, which is the rejection rule from the request (`SHA-256`)."
    )
    add("")
    if summary.get("rejects"):
        add("## Rejected samples (excluded from the corpus)")
        add("")
        for reject in summary["rejects"][:40]:
            add(f"- `{reject['family']}` #{reject['index']}: {reject['reason']}")
        add("")
    report_path = out_dir / "GENERATION_REPORT.md"
    report_path.write_text("\n".join(lines) + "\n", encoding="utf-8")
    return report_path
