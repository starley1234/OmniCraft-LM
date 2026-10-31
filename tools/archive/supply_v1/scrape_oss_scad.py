"""Скрейпер реальных OpenSCAD-проектов с GitHub в СЫРОЙ датасет.

Каталог-получатель помечается как сырьё: строки НЕ проходят валидацию
проекта и не готовы к обучению (см. optional_data/raw_datasets/СЫРЫЕ_ДАННЫЕ.md).

Пайплайн: поиск репозиториев (gh API) → codeload-тарболлы → извлечение
``*.scad`` + README/``customizer.yml`` (текстовые, до --max-file-kb) →
``index.csv`` с sha1/лицензиями → ``files.tar.gz`` → ``stats.json``.
Существующие выходные файлы не затирает без --overwrite.

    python tools/scrape_oss_scad.py --top 70 --out optional_data/raw_datasets/github_scad_manual
Зависимости: stdlib + ``gh`` (авторизованный) + ``curl``; python без пакетов.
"""
from __future__ import annotations

import argparse
import csv
import hashlib
import io
import json
import re
import subprocess
import sys
import tarfile
import tempfile
from collections import Counter
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path

DOC_NAMES = {"readme.md", "readme.rst", "readme.txt", "customizer.yml", "customizer.yaml"}


def _run(cmd: list[str]) -> subprocess.CompletedProcess:
    return subprocess.run(cmd, capture_output=True, text=True, encoding="utf-8", errors="replace")


def list_repos(queries: list[str], max_repo_size_kb: int) -> list[dict]:
    seen: set[str] = set()
    out: list[dict] = []
    for query in queries:
        url = f"search/repositories?q={query.replace(' ', '+')}&sort=stars&order=desc&per_page=100"
        result = _run(["gh", "api", url])
        if result.returncode != 0:
            print(f"[WARN] gh api не удался для {query!r}: {result.stderr.strip()[:120]}", file=sys.stderr)
            continue
        for item in json.loads(result.stdout).get("items", []):
            full = item["full_name"]
            if full in seen or item.get("size", 10**9) > max_repo_size_kb:
                continue
            seen.add(full)
            out.append({"full_name": full, "stars": item["stargazers_count"],
                        "default_branch": item["default_branch"]})
    out.sort(key=lambda repo: -repo["stars"])
    return out


def license_of(full_name: str) -> str:
    result = _run(["gh", "api", f"repos/{full_name}"])
    if result.returncode != 0:
        return "?"
    try:
        return (json.loads(result.stdout).get("license") or {}).get("spdx_id") or "NOASSERTION"
    except json.JSONDecodeError:
        return "?"


def fetch_repo(repo: dict, dest_root: Path, max_file_kb: int) -> dict:
    name = repo["full_name"].replace("/", "__")
    url = f"https://codeload.github.com/{repo['full_name']}/tar.gz/refs/heads/{repo['default_branch']}"
    with tempfile.TemporaryDirectory(prefix="omnicraft-scrape-") as tmp:
        tgz = Path(tmp) / "src.tar.gz"
        code = _run(["curl", "-sL", "--max-time", "120", "-o", str(tgz), "-w", "%{http_code}", url]).stdout.strip()
        if code != "200":
            return {"repo": repo["full_name"], "status": f"http{code}"}
        try:
            archive = tarfile.open(tgz, "r:gz")
        except tarfile.TarError as exc:
            return {"repo": repo["full_name"], "status": f"tar:{exc.__class__.__name__}"}
        scad = docs = 0
        records: list[dict] = []
        with archive:
            for member in archive.getmembers():
                if not member.isfile() or member.size > max_file_kb * 1024:
                    continue
                lower = member.name.lower()
                keep = lower.endswith(".scad") or Path(lower).name in DOC_NAMES
                if not keep:
                    continue
                data = archive.extractfile(member).read()
                rel = member.name.split("/", 1)[1] if "/" in member.name else member.name
                target = dest_root / name / rel
                target.parent.mkdir(parents=True, exist_ok=True)
                target.write_bytes(data)
                text = data.decode("utf-8", errors="replace")
                is_scad = lower.endswith(".scad")
                if is_scad:
                    scad += 1
                    records.append({
                        "sha1_12": hashlib.sha256(data).hexdigest()[:12],
                        "path": f"{name}/{rel}", "bytes": len(data),
                        "customizer_block": int(bool(re.search(r"/\*\s*\[", text))),
                        "uses_library": int(bool(re.search(r"<(BOSL|MCAD|dotSCAD|threads|NopSCADlib)", text))),
                    })
                else:
                    docs += 1
        return {"repo": repo["full_name"], "status": "ok", "scad": scad, "docs": docs, "records": records}


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("--queries", nargs="*", default=["topic:openscad stars:>5", "topic:openscad-library stars:>3"])
    parser.add_argument("--top", type=int, default=70)
    parser.add_argument("--max-repo-size-mb", type=int, default=80)
    parser.add_argument("--max-file-kb", type=int, default=2000)
    parser.add_argument("--out", type=Path, required=True)
    parser.add_argument("--workers", type=int, default=8)
    parser.add_argument("--overwrite", action="store_true")
    args = parser.parse_args(argv)

    if args.out.exists() and any(args.out.iterdir()) and not args.overwrite:
        print(f"[ABORT] {args.out} непустой (перезапись — только с --overwrite)", file=sys.stderr)
        return 4
    args.out.mkdir(parents=True, exist_ok=True)
    stage = Path(tempfile.mkdtemp(prefix="scad-stage-"))

    repos = list_repos(args.queries, args.max_repo_size_mb * 1024)[: args.top]
    print(f"кандидатов к скачиванию: {len(repos)}")
    with ThreadPoolExecutor(max_workers=args.workers) as pool:
        results = list(pool.map(lambda repo: fetch_repo(repo, stage, args.max_file_kb), repos))

    ok = [item for item in results if item["status"] == "ok"]
    records = [row for item in ok for row in item["records"]]
    by_sha: dict[str, dict] = {}
    for row in records:
        by_sha.setdefault(row["sha1_12"], row)
    unique = list(by_sha.values())
    print(f"репозиториев ok: {len(ok)}; scad-строк: {len(records)}, уникальных: {len(unique)}")

    licenses = {item["repo"]: license_of(item["repo"]) for item in ok}
    index_path = args.out / "index.csv"
    with index_path.open("w", newline="", encoding="utf-8") as stream:
        writer = csv.DictWriter(stream, fieldnames=["sha1_12", "path", "bytes", "customizer_block",
                                                    "uses_library", "repo_license"])
        writer.writeheader()
        for row in unique:
            repo_name = row["path"].split("/", 1)[0].replace("__", "/", 1)
            writer.writerow({**row, "repo_license": licenses.get(repo_name, "?")})
    stats = {"scad_unique": len(unique), "customizer": sum(row["customizer_block"] for row in unique),
             "uses_library": sum(row["uses_library"] for row in unique),
             "licenses_by_repo": dict(Counter(licenses.values()).most_common())}
    (args.out / "stats.json").write_text(json.dumps(stats, indent=1, ensure_ascii=False), encoding="utf-8")

    tar_path = args.out / "files.tar.gz"
    with tarfile.open(tar_path, "w:gz") as tar:
        for path in sorted(stage.rglob("*")):
            if path.is_file():
                tar.add(path, arcname=str(path.relative_to(stage)))
    print(f"готово: {tar_path} ({tar_path.stat().st_size // 2**20} MiB), {index_path}")
    print("не забыть: пометить каталог как СЫРЫЕ (см. optional_data/raw_datasets/СЫРЫЕ_ДАННЫЕ.md)")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
