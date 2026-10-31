"""Shared kit for the delivery-5 corpora (wire2 / sketch2 / asm2 / scale1).

These four corpora answer ``docs/archive/DATASET_REQUEST_5.md`` (blocks W2/S2/A2)
and the leftover of request 6 recorded in STATUS.md (scale extremes + hard
placement cases).  Everything they produce is a *candidate* corpus: the local
gate runs on the manifold kernel (``manifold3d`` - the same kernel OpenSCAD
uses with ``--backend=manifold``), the final word belongs to the receiving
side's real OpenSCAD CLI.  Every manifest row therefore carries

    "validation_status": "pending_openscad_manifold"

and each corpus directory ships a ``VALIDATION_REQUIRED.md`` marker.

The kit keeps the shared disciplines in one place:

* prompt tails that never leak a number which is absent from the code
  (the place1 law: every prompt dimension number lives in the source);
* deterministic RNG seeding distinct from the earlier deliveries;
* delivery writers (manifest, SHA256SUMS, validation marker);
* the wire node/edge budget imposed by the 32-vertex WireCanvas
  (``src/training/aux_losses.py`` raises when a GT graph exceeds it).
"""

from __future__ import annotations

import hashlib
import json
from dataclasses import dataclass
from datetime import datetime, timezone
from pathlib import Path
from typing import Any, Callable, Sequence

from tools.dataset_gen2.common import Rng  # noqa: F401  (re-export: one seeded RNG class)

# A fresh seed so no draw collides with gen2/gen3/sketch1/asm1/place1 (20260929).
SEED_V5 = 20261001

# Hard cap: src/training/aux_losses.py:wire_auxiliary_loss raises
# "GT graph has N nodes; canvas predicts 32" for bigger graphs, and
# src/model/wire_canvas.py is architecturally fixed at 32 vertices.
MAX_GRAPH_NODES = 32

PENDING_STATUS = "pending_openscad_manifold"


# ---------------------------------------------------------------------------
# prompt tails - number discipline
# ---------------------------------------------------------------------------

RU_TAILS_PLAIN = (
    "Печатать буду на PETG, технология на модель не влияет.",
    "Материал — обычный PLA, модель от него не зависит.",
    "Это прототип, важнее геометрия, чем технология.",
    "Сделай параметрически: размеры вынеси переменными в шапку.",
    "Чертеж прикладываю мысленно, доверяй размерам в тексте.",
    "Деталь из домашней мастерской, без экзотики.",
    "Модель нужна под повторяемую печать, без ручных пересчётов.",
    "Ориентир — обычный крепёж из хозяйственного магазина.",
    "Потом буду масштабировать под себя, держи пропорции честными.",
    "Собираю установку своими руками, деталь должна встать с первого раза.",
)
EN_TAILS_PLAIN = (
    "Printing in PETG; the material does not change the model.",
    "Plain PLA is fine, the geometry is what matters.",
    "It is a prototype, the shape matters more than the process.",
    "Keep it parametric: put the sizes in named header variables.",
    "Trust the numbers in the text, I measured them off the drawing.",
    "A plain workshop part, nothing exotic.",
    "I reprint it often, so keep it clean and reproducible.",
    "Standard hardware-store fasteners are the reference.",
    "I will rescale it later, keep the proportions honest.",
    "Building the rig myself, the part has to fit first try.",
)

# Tolerance tails are *parameterised*: the two numbers they mention are
# declared as fit_tol / free_tol in the file header, so the place1 law holds.
RU_TAILS_TOL = (
    "Посадочные места держи в {fit}, остальные размеры в {free}.",
    "Допуск на сопряжения {fit}, на свободные размеры {free}.",
    "Точность посадок {fit} мм, прочее по {free} мм.",
)
EN_TAILS_TOL = (
    "Mating features to {fit}, everything else to {free}.",
    "Fit tolerance {fit} mm, free sizes {free} mm.",
    "Hold {fit} on the fits and {free} on the rest.",
)

RU_TOL_PAIRS = ((0.05, 0.3), (0.1, 0.3), (0.05, 0.2), (0.1, 0.5), (0.02, 0.2))


def tail_pair(rng: Rng, chance: float = 0.2) -> tuple[str, str, tuple[float, float] | None]:
    """Return (ru_tail, en_tail, tol_pair).  tol_pair != None => declare them."""
    if rng.chance(chance):
        fit, free = rng.choice(RU_TOL_PAIRS)
        ru = rng.choice(RU_TAILS_TOL).format(fit=_fmt_tol(fit), free=_fmt_tol(free))
        en = rng.choice(EN_TAILS_TOL).format(fit=_fmt_tol(fit), free=_fmt_tol(free))
        return ru, en, (fit, free)
    return rng.choice(RU_TAILS_PLAIN), rng.choice(EN_TAILS_PLAIN), None


def _fmt_tol(value: float) -> str:
    from tools.dataset_gen2.common import fmt

    return fmt(value)


# ---------------------------------------------------------------------------
# delivery writers
# ---------------------------------------------------------------------------

VALIDATION_MARKER = """# VALIDATION REQUIRED — корпус ещё НЕ принят

Статус: **{status}**

Этот корпус сгенерирован {generated} агентом-генератором и прошёл только
**локальный гейт** на ядре manifold3d (то же ядро, которое OpenSCAD использует
с `--backend=manifold`). Настоящим CLI OpenSCAD он **не прогонялся**:
на машине генерации OpenSCAD отсутствует.

Каждая строка `manifest.jsonl` несёт `"validation_status": "{status}"`.

## Что обязан сделать приёмщик до принятия в обучение

```bash
# 1. целостность поставки
python tools/verify_delivery.py {corpus_dir}

# 2. независимый аудит генератора (без OpenSCAD)
{verify_cmd}

# 3. импорт в каноническую схему (кандидаты, НЕ принятые строки)
python tools/import_external_scad.py --parts-dir {corpus_dir} \\
    --output data/processed/{name}_candidates.jsonl

# 4. CAD-валидация настоящим OpenSCAD (только её результат легитимен)
python tools/validate_dataset.py --input data/processed/{name}_candidates.jsonl \\
    --backend openscad --workers 4
```

В обучение идут только строки из `*.validation.accepted.jsonl`
(инвариант №2 AGENTS.md: mock-валидация ≠ CAD-валидация).
"""


def write_delivery(
    out_dir: Path,
    rows: Sequence[dict[str, Any]],
    written: Sequence[Path],
    *,
    corpus_dir: str,
    verify_cmd: str,
) -> str:
    """Write manifest.jsonl, SHA256SUMS.txt and VALIDATION_REQUIRED.md."""
    out_dir.mkdir(parents=True, exist_ok=True)
    manifest_path = out_dir / "manifest.jsonl"
    manifest_path.write_text(
        "".join(json.dumps(row, ensure_ascii=False, sort_keys=True) + "\n" for row in rows),
        encoding="utf-8",
    )
    manifest_sha = hashlib.sha256(manifest_path.read_bytes()).hexdigest()
    lines = [f"{manifest_sha}  manifest.jsonl"]
    for path in sorted(written, key=lambda p: str(p)):
        digest = hashlib.sha256(path.read_bytes()).hexdigest()
        lines.append(f"{digest}  {path.relative_to(out_dir).as_posix()}")
    (out_dir / "SHA256SUMS.txt").write_text("\n".join(lines) + "\n", encoding="utf-8")
    (out_dir / "VALIDATION_REQUIRED.md").write_text(
        VALIDATION_MARKER.format(
            status=PENDING_STATUS,
            generated=datetime.now(timezone.utc).strftime("%Y-%m-%d %H:%M UTC"),
            corpus_dir=corpus_dir,
            verify_cmd=verify_cmd,
            name=out_dir.name,
        ),
        encoding="utf-8",
    )
    return manifest_sha


# ---------------------------------------------------------------------------
# shared build loop
# ---------------------------------------------------------------------------


@dataclass
class BuildStats:
    rows: int = 0
    rejects: int = 0
    duplicate_sources: int = 0
    duplicate_prompts: int = 0
    families: int = 0
    seconds: float = 0.0
    family_stats: dict[str, Any] | None = None


def build_family_corpus(
    out_dir: Path,
    family_builders: dict[str, Callable[[int], Any]],
    *,
    audit: Callable[[Any], list[str]],
    render_code: Callable[[Any], str],
    render_prompts: Callable[[Any], tuple[str, str]],
    manifest_row: Callable[[Any, str], dict[str, Any]],
    file_stem: str,
    count_per_family: int,
    post_accept: Callable[[Any], None] | None = None,
    quiet: bool = False,
) -> tuple[list[dict[str, Any]], list[Path], dict[str, Any], list[dict[str, str]]]:
    """Generate ``count_per_family`` accepted samples per family.

    ``audit`` returns the list of gate problems (empty = accept).  Every
    accepted sample must have a unique source digest and unique RU/EN prompts.
    """
    rows: list[dict[str, Any]] = []
    written: list[Path] = []
    family_stats: dict[str, Any] = {}
    rejects: list[dict[str, str]] = []
    seen_sources: set[str] = set()
    seen_ru: set[str] = set()
    seen_en: set[str] = set()
    duplicates = 0
    duplicate_prompts = 0

    for family, builder in family_builders.items():
        directory = out_dir / family
        directory.mkdir(parents=True, exist_ok=True)
        accepted = 0
        variants: set[str] = set()
        attempts = 0
        max_attempts = count_per_family * 6 + 40
        while accepted < count_per_family and attempts < max_attempts:
            index = attempts
            attempts += 1
            try:
                sample = builder(index)
            except Exception as exc:  # noqa: BLE001 - a template may refuse a draw
                rejects.append({"family": family, "index": str(index), "reason": f"{type(exc).__name__}: {exc}"})
                continue
            problems = audit(sample)
            if problems:
                rejects.append({"family": family, "index": str(index), "reason": "; ".join(problems[:4])})
                continue
            code = render_code(sample)
            digest = hashlib.sha256(code.encode("utf-8")).hexdigest()
            if digest in seen_sources:
                duplicates += 1
                continue
            ru, en = render_prompts(sample)
            if ru in seen_ru or en in seen_en:
                duplicate_prompts += 1
                continue
            seen_sources.add(digest)
            seen_ru.add(ru)
            seen_en.add(en)
            relative = f"{family}/{file_stem}_{accepted + 1:04d}.scad"
            path = out_dir / relative
            path.write_text(code, encoding="utf-8")
            written.append(path)
            rows.append(manifest_row(sample, relative))
            if post_accept is not None:
                post_accept(sample)
            variants.add(getattr(sample, "variant", ""))
            accepted += 1
        family_stats[family] = {
            "requested": count_per_family,
            "written": accepted,
            "variants": len(variants),
            "attempts": attempts,
        }
        if not quiet:
            print(
                f"{family:<16} {accepted}/{count_per_family} written, "
                f"{len(variants)} variants, {attempts} attempts",
                flush=True,
            )
    return rows, written, family_stats, rejects
