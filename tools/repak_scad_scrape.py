"""Репак ссыпанных с GitHub .scad в JSONL-кандидатов схемы проекта (СЫРЬЁ).

Канал: `optional_data/raw/github_scad_top70/` (тарболл или
распакованное дерево) → `*.scad` → нормализация (`$fn = 32;` заголовок, LF)
→ промпт из Customizer-блока/описательного комментария → дедупликации
(nominalized sha256; опционально против учебного корпуса) → кандидат-строки
`CADSample`-совместимого формата с `verification.accepted=false`.

target_bbox:
  * `--measure auto|on` — на машине с OpenSCAD+trimesh габарит измеряется
    штатным `src.env.openscad_runner.OpenSCADRunner` (тот же код, что у
    валидатора) и пишется в `target_bbox` (`metadata.target_source=
    "openscad_measured"`); это единственный режим, дающий после
    `omni validate` принятые строки;
  * без OpenSCAD (например, в песочнице) — плейсхолдер `[100,100,100]` с
    `metadata.provisional_target=true`; такие строки заведомо НЕ пройдут
    bbox-проверку валидатора и не попадут в accepted (защита от ложного GT).

Политика «учимся без BOSL2»: файлы с `use</include <` отсеиваются как
`external_lib` (флаг `--allow-external-libs` отключает фильтр); файлы без
Customizer/описания получают синтезированный из кода промпт
(`metadata.prompt_grade=synth_code`) — только литеральные имена параметров
и счётчики примитивов, никакой выдуманной семантики.

Выход пригоден для: `python tools/omni.py validate --input <файл>` (нужен
OpenSCAD), после чего `<файл>.validation.accepted.jsonl` подключается к
корпусу `tools/build_corpus_v9.py --add` (имя обязано кончаться на
`.validation.accepted.jsonl` — переименуйте при нужде). Строки СЫРЫЕ:
лицензии смешанные, промпты машинные — см. `optional_data/raw/
СЫРЫЕ_ДАННЫЕ.md`.

    python tools/repak_scad_scrape.py \
        --in optional_data/raw/github_scad_top70/files.tar.gz \
        --index optional_data/raw/github_scad_top70/index.csv \
        --out data/processed/scad_scrape_candidates.jsonl
"""
from __future__ import annotations

import argparse
import csv
import hashlib
import json
import re
import shutil
import sys
import tarfile
import tempfile
from collections import Counter, defaultdict
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path

REPO = Path(__file__).resolve().parents[1]
if str(REPO) not in sys.path:
    sys.path.insert(0, str(REPO))

FACET_HEADER = "$fn = 32;\n"
PLACEHOLDER_BBOX = (100.0, 100.0, 100.0)

try:  # та же проверка, что у валидатора; без pydantic тихо отключаемся
    from src.data.validation import has_top_level_object_statement as _HAS_TOP_LEVEL
except Exception:  # pragma: no cover
    _HAS_TOP_LEVEL = None

_GROUP_MARKER = re.compile(r"/\*\s*\[([^\]]*)\]\s*\*/")
_PARAM_LINE = re.compile(r"^\s*([A-Za-z_]\w*)\s*=\s*([^;]+?)\s*(?://\s*(.*?))?\s*;")
_STOP_SCAN = re.compile(r"^\s*(module|function|for|intersection_for|union|difference|translate|rotate|scale|mirror|cube|sphere|cylinder|import)\b")
_TITLE_COMMENT = re.compile(r"^\s*//\s*(\S.{4,160}?)\s*$")
_LIB_USE = re.compile(r"^\s*(?:use|include)\s*<([^>]+)>", re.M)


def normalize_code(text: str) -> str | None:
    """LF, без BOM, обязательный заголовок; None — не текст."""
    try:
        decoded = text.encode("utf-8", errors="strict").decode("utf-8") if isinstance(text, str) else ""
    except UnicodeError:
        return None
    decoded = decoded.lstrip("\ufeff").replace("\r\n", "\n").replace("\r", "\n")
    if "\x00" in decoded:
        return None
    decoded = decoded.rstrip("\n") + "\n"
    if not decoded.startswith(FACET_HEADER):
        decoded = FACET_HEADER + decoded
    return decoded


def parse_customizer(text: str, require_block: bool = True) -> dict[str, str]:
    """Имена параметров и их комментарии из Customizer-подобных объявлений.

    Возвращает {name: описание или ''}; останавливается на первом теле
    модуля/цикла, чтобы не ловать локальные переменные. `require_block=False`
    снимает требование заголовка `/* [` — для синтезированного промпта.
    """
    if require_block and "/* [" not in text and "/*[" not in text:
        return {}
    params: dict[str, str] = {}
    for line in text.splitlines():
        if _STOP_SCAN.match(line):
            break
        match = _PARAM_LINE.match(line)
        if match and not match.group(1).startswith("$"):
            name, _default, desc = match.groups()
            params.setdefault(name, (desc or "").strip())
    return params


def extract_title(text: str) -> str:
    """Первый осмысленный заглавный комментарий до кода ('' если нет)."""
    for line in text.splitlines():
        if line.strip() and not line.lstrip().startswith(("//", "/*", "*", "$")):
            break
        match = _TITLE_COMMENT.match(line)
        if match and not match.group(1).startswith("!"):
            return match.group(1).strip()
    return ""


_COMMENT_LINE = re.compile(r"//[^\n]*")
_COMMENT_BLOCK = re.compile(r"/\*.*?\*/", re.S)
_PRIM3D = ("cube", "sphere", "cylinder", "polyhedron", "linear_extrude", "rotate_extrude", "surface")
_BOOL_OPS = ("difference", "union", "intersection", "hull", "minkowski")
_MODULE_DEF = re.compile(r"^\s*module\s+([A-Za-z_]\w*)", re.M)


def synth_prompt(stem: str, code: str) -> str:
    """Машинное описание из самого кода: имя модуля/файла, параметры, композиция.

    Никакой выдуманной семантики — только то, что буквально стоит в исходнике;
    корректность геометрии/габарита после этого всё равно проверяет валидатор.
    """
    body = _COMMENT_BLOCK.sub(" ", _COMMENT_LINE.sub(" ", code))
    modules = _MODULE_DEF.findall(body)
    title = (modules[0] if modules else stem).replace("_", " ").replace("-", " ").strip()
    if not title:
        title = "OpenSCAD model"
    bits: list[str] = []
    params = parse_customizer(code, require_block=False)
    named = [f"{name}={value.strip()}" for name, value in list(params.items())[:6]]
    if named:
        bits.append("parameters: " + ", ".join(named))
    prim = {name: len(re.findall(rf"\b{name}\s*\(", body)) for name in _PRIM3D}
    prim = {name: count for name, count in prim.items() if count}
    if prim:
        order = sorted(prim.items(), key=lambda kv: (-kv[1], kv[0]))[:3]
        bits.append("built from " + ", ".join(f"{count}x {name}" for name, count in order))
    bools = [op for op in _BOOL_OPS if re.search(rf"\b{op}\s*\(", body)]
    if bools:
        bits.append("combined with " + " and ".join(bools))
    return f"{title}: " + "; ".join(bits) if bits else f"{title} (OpenSCAD model)"


def build_prompt(stem: str, title: str, params: dict[str, str], code: str,
                 allow_synth: bool) -> tuple[str, str]:
    """(текст промпта, оценка качества). Без кастомизатора и комментария —
    синтез из кода (grade='synth_code'); при --no-synth-prompt такие файлы
    отсеиваются (grade='filename_only')."""
    pretty = stem.replace("_", " ").replace("-", " ").strip()
    if params:
        bits = [f"{name} ({desc})" if desc else name for name, desc in list(params.items())[:6]]
        lead = title or f"{pretty} (parametric OpenSCAD model)"
        return f"{lead}, parameters: {', '.join(bits)}", "customizer"
    if title:
        return f"{title} (OpenSCAD model, {pretty})", "title_comment"
    if allow_synth:
        return synth_prompt(stem, code), "synth_code"
    return "", "filename_only"


def iter_scad_files(root: Path):
    for path in sorted(root.rglob("*.scad")):
        if path.is_file():
            yield path


def load_licenses(index_csv: Path | None, base_dir: Path) -> dict[str, str]:
    """path -> license по index.csv скрейпера (путь в архиве: owner__repo/...)."""
    licenses: dict[str, str] = {}
    if not index_csv:
        return licenses
    with index_csv.open(encoding="utf-8-sig", newline="") as stream:
        for row in csv.DictReader(stream):
            licenses[row.get("path", "")] = row.get("repo_license", "?")
    return licenses


def make_runner(mode: str):
    """None | OpenSCADRunner; 'auto' тихо деградирует, 'on' — требует."""
    if mode == "off":
        return None
    try:
        if shutil.which("openscad") is None:
            raise RuntimeError("openscad не найден в PATH")
        import trimesh  # noqa: F401
        from src.env.openscad_runner import OpenSCADRunner
        runner = OpenSCADRunner()
        return runner
    except Exception as exc:
        if mode == "on":
            raise SystemExit(f"[ABORT] --measure on, но раннер недоступен: {exc}") from exc
        print(f"[INFO] OpenSCAD-измерение недоступно ({exc}); режим provisional-плейсхолдера",
              file=sys.stderr)
        return None


def process_file(path: Path, base_dir: Path, args, runner, corpus_hashes: set[str]) -> tuple[str, dict | None, str]:
    """(вердикт, строка|None, причина)."""
    raw = path.read_bytes()
    if len(raw) > args.max_file_bytes:
        return "skip", None, "too_large"
    try:
        text = raw.decode("utf-8")
    except UnicodeDecodeError:
        return "skip", None, "not_utf8"
    code = normalize_code(text)
    if code is None or len(code) < args.min_code_chars:
        return "skip", None, "not_scad_text"
    digest = hashlib.sha256(code.encode("utf-8")).hexdigest()
    if digest in corpus_hashes:
        return "skip", None, "duplicate_of_corpus"
    libs = sorted({m.split("/")[-1] for m in _LIB_USE.findall(code)})
    if libs and not args.allow_external_libs:
        # «учимся без BOSL2»: файл, не компилируемый standalone, не кандидат
        return "skip", None, "external_lib"
    rel = path.relative_to(base_dir).as_posix()
    repo = rel.split("/", 1)[0].replace("__", "/", 1) if "/" in rel else "?"
    title = extract_title(code)
    params = parse_customizer(code)
    prompt, grade = build_prompt(path.stem, title, params, code, allow_synth=not args.no_synth_prompt)
    if grade == "filename_only":
        return "skip", None, "no_description"
    if not re.search(r"\b(cube|sphere|cylinder|polyhedron|linear_extrude|rotate_extrude|import|surface)\b", code):
        return "skip", None, "no_geometry_op"
    if _HAS_TOP_LEVEL is not None and not _HAS_TOP_LEVEL(code):
        return "skip", None, "no_top_level_call"

    target = list(PLACEHOLDER_BBOX)
    provisional = True
    if runner is not None:
        result = runner.compile(code)
        if result.error or result.bbox is None:
            return "skip", None, "compile_failed"
        dims = [round(float(v), 3) for v in result.bbox]
        if any(v <= 0 for v in dims):
            return "skip", None, "empty_bbox"
        target = dims
        provisional = False

    stem_sha = hashlib.sha1(rel.encode("utf-8")).hexdigest()[:10]
    row = {
        "id": f"scadscr_{stem_sha}",
        "layer": "voxel",
        "prompts": {"en": prompt},
        "code": code,
        "verification": {
            "target_bbox": target,
            "accepted": False,
            "validation_status": "generated",
            "validation_backend": "none",
        },
        "metadata": {
            "source": "oss_scad_scrape",
            "generator_version": 1,
            "repo": repo,
            "path": rel,
            "license": args.licenses.get(rel, "?"),
            "prompt_grade": grade,
            "customizer_params": len(params),
            "needs_libs": libs,
            "provisional_target": provisional,
            "target_source": "placeholder" if provisional else "openscad_measured",
            "code_sha256": digest,
        },
    }
    return "keep", row, ""


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("--in", dest="src", type=Path,
                        default=REPO / "optional_data/raw/github_scad_top70/files.tar.gz")
    parser.add_argument("--index", type=Path,
                        default=REPO / "optional_data/raw/github_scad_top70/index.csv")
    parser.add_argument("--out", type=Path, required=True)
    parser.add_argument("--corpus-dedup", type=Path, default=None,
                        help="учебный корпус (jsonl), чей код не повторяем")
    parser.add_argument("--limit", type=int, default=0, help="максимум keep-строк (0 = без лимита)")
    parser.add_argument("--per-repo", type=int, default=12, help="кап строк на репозиторий (0 = без капа)")
    parser.add_argument("--max-file-bytes", type=int, default=200_000)
    parser.add_argument("--min-code-chars", type=int, default=80)
    parser.add_argument("--measure", choices=("auto", "on", "off"), default="auto")
    parser.add_argument("--workers", type=int, default=4)
    parser.add_argument("--allow-external-libs", action="store_true",
                        help="не отсеивать файлы с use/include (по умолчанию «учимся без BOSL2»)")
    parser.add_argument("--no-synth-prompt", action="store_true",
                        help="не синтезировать промпт из кода; файлы без описания тогда отсевятся")
    parser.add_argument("--overwrite", action="store_true")
    args = parser.parse_args(argv)

    if args.out.exists() and not args.overwrite:
        print(f"[ABORT] {args.out} существует (перезапись — только с --overwrite)", file=sys.stderr)
        return 4

    temp_dir: tempfile.TemporaryDirectory | None = None
    if args.src.is_file() and args.src.suffixes[-2:] == [".tar", ".gz"]:
        temp_dir = tempfile.TemporaryDirectory(prefix="repak-scad-")
        base = Path(temp_dir.name)
        with tarfile.open(args.src, "r:gz") as archive:
            for member in archive.getmembers():
                if not member.isfile() or member.name.startswith(("/", "..")) or "../" in member.name:
                    continue
                target = base / member.name
                target.parent.mkdir(parents=True, exist_ok=True)
                target.write_bytes(archive.extractfile(member).read())  # safe_extract-подобный обход
    elif args.src.is_dir():
        base = args.src
    else:
        print(f"[MISSING] --in: {args.src} (нужен каталог или files.tar.gz)", file=sys.stderr)
        return 2

    args.licenses = load_licenses(args.index, base)

    corpus_hashes: set[str] = set()
    if args.corpus_dedup and args.corpus_dedup.is_file():
        with args.corpus_dedup.open(encoding="utf-8") as stream:
            for line in stream:
                if line.strip():
                    corpus_hashes.add(hashlib.sha256(
                        json.loads(line)["code"].encode("utf-8")).hexdigest())

    runner = make_runner(args.measure)
    decisions: Counter[str] = Counter()
    per_repo: Counter[str] = Counter()
    rows: list[dict] = []
    reasons: dict[str, Counter[str]] = defaultdict(Counter)

    files = list(iter_scad_files(base))
    if runner is None:
        results = [process_file(p, base, args, runner, corpus_hashes) for p in files]
    else:
        with ThreadPoolExecutor(max_workers=args.workers) as pool:
            results = list(pool.map(lambda p: process_file(p, base, args, runner, corpus_hashes), files))

    seen_ids: set[str] = set()
    seen_hashes: set[str] = set()
    for verdict, row, reason in results:
        if verdict == "skip":
            decisions["skip"] += 1
            reasons["reason"][reason or "?"] += 1
            continue
        assert row is not None
        digest = row["metadata"]["code_sha256"]
        if digest in seen_hashes:
            decisions["skip"] += 1
            reasons["reason"]["duplicate_code"] += 1
            continue
        seen_hashes.add(digest)
        repo = row["metadata"]["repo"]
        if args.per_repo and per_repo[repo] >= args.per_repo:
            decisions["skip"] += 1
            reasons["reason"]["per_repo_cap"] += 1
            continue
        if row["id"] in seen_ids:
            decisions["skip"] += 1
            reasons["reason"]["duplicate_id"] += 1
            continue
        seen_ids.add(row["id"])
        per_repo[repo] += 1
        decisions["keep"] += 1
        rows.append(row)
        if args.limit and len(rows) >= args.limit:
            break

    rows.sort(key=lambda row: row["id"])
    args.out.parent.mkdir(parents=True, exist_ok=True)
    temporary = args.out.with_name(args.out.name + ".tmp")
    with temporary.open("w", encoding="utf-8", newline="\n") as stream:
        for row in rows:
            stream.write(json.dumps(row, ensure_ascii=False, sort_keys=True) + "\n")
    temporary.replace(args.out)

    report = args.out.with_name(args.out.stem + ".report.md")
    provisional = sum(1 for row in rows if row["metadata"]["provisional_target"])
    lines = [
        "# Репак OSS-scad → кандидаты (СЫРЬЁ, не accepted)",
        "",
        f"- вход: `{args.src}` (scad-файлов: {len(files)})",
        f"- выход: `{args.out}` — **{decisions['keep']}** строк, отброшено {decisions['skip']}",
        f"- режим габаритов: {'openscad_measured' if runner else 'PROVISIONAL-плейсхолдер (только с ним НЕ обучать — прогоните --measure на машине с OpenSCAD)'}",
        f"- provisional-строк: {provisional}",
        "",
        "## Причины отсева",
        "",
    ]
    for reason, count in reasons["reason"].most_common():
        lines.append(f"- {reason}: {count}")
    lines += ["", "## Топ репозиториев (keep)", ""]
    for repo, count in per_repo.most_common(12):
        lines.append(f"- {repo}: {count}")
    lines += ["", "## Дальше по конвейеру", "",
              "1. `python tools/omni.py validate --input <выход> --backend openscad --workers 12`"
              " (или пересобрать через `--measure auto` там, где OpenSCAD уже есть);",
              "2. accepted-файл переименовать в `*.validation.accepted.jsonl` →"
              " `python tools/build_corpus_v9.py --add <файл>` → новый сплит;",
              "3. `python tools/reaudit_specs_corpus.py --input <новый combined>` — контроль"
              " промпт↔геометрия (машинные промпты могут не совпасть; тогда чинить промпт, не геометрию).",
              "",
              "Лицензии пофайлово — в metadata каждой строки (из index.csv). Промпты: "
              f"customizer={sum(1 for r in rows if r['metadata']['prompt_grade'] == 'customizer')}, "
              f"title_comment={sum(1 for r in rows if r['metadata']['prompt_grade'] == 'title_comment')}, "
              f"synth_code={sum(1 for r in rows if r['metadata']['prompt_grade'] == 'synth_code')}.",
              ""]
    report.write_text("\n".join(lines), encoding="utf-8")

    print(f"keep={decisions['keep']} skip={decisions['skip']} из {len(files)} файлов → {args.out}")
    print(f"отчёт: {report}")
    if provisional:
        print(f"[WARN] {provisional} строк с плейсхолдерным target_bbox — в таком виде они не "
              "примутся валидатором (так и задумано: ложный GT запрещён)", file=sys.stderr)
    if temp_dir:
        temp_dir.cleanup()
    return 0


if __name__ == "__main__":
    # cp1251-консоль Windows не умеет часть символов (→): печать не должна валить прогон.
    for _stream in (sys.stdout, sys.stderr):
        if hasattr(_stream, "reconfigure"):
            _stream.reconfigure(encoding="utf-8", errors="replace")
    raise SystemExit(main())
