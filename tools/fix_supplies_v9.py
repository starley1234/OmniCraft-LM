"""Fix supplies 5-7: add target_bbox to code comments and generate prompt styles.

Problem: supplies 5-7 were merged into v9 without passing through build_corpus_v8.py.
They lack:
1. target_bbox in code comments (v8 has 2.3%, supplies have 0%)
2. Prompt styles (free, conv, formal) — only base ru/en
3. metadata.quality

This script fixes these issues by working with plain dicts (no CADSample validation).

Usage: python tools/fix_supplies_v9.py [--dry-run]
"""
from __future__ import annotations

import argparse
import collections
import hashlib
import json
import re
import sys
from pathlib import Path

REPOSITORY_ROOT = Path(__file__).resolve().parents[1]
if str(REPOSITORY_ROOT) not in sys.path:
    sys.path.insert(0, str(REPOSITORY_ROOT))

# Style templates for prompt generation
STYLE_TEMPLATES = {
    'free_ru': [
        "Мне нужен {description}",
        "Сделай {description}",
        "Построй {description}",
    ],
    'conv_ru': [
        "Нужен какой-нибудь {description}, чтоб влезло в {dims}",
        "Сделай {description} с габаритом {dims}",
        "Требуется {description}, размеры {dims}",
    ],
    'free_en': [
        "I need {description}",
        "Make {description}",
        "Build {description}",
    ],
    'conv_en': [
        "Need a {description} that fits in {dims}",
        "Make {description} with dimensions {dims}",
        "Required {description}, size {dims}",
    ],
}


def extract_description(prompt: str) -> str:
    """Extract description from prompt, removing dimensions."""
    desc = re.sub(r'\d+\s*(?:x|×|by|на)\s*\d+\s*(?:x|×|by|на)\s*\d+\s*(?:mm|мм)?', '', prompt)
    desc = re.sub(r'\d+\s*(?:mm|мм)', '', desc)
    desc = re.sub(r'\s+', ' ', desc).strip()
    desc = re.sub(r'^(?:Сделай|Смоделируй|Построй|Требуется|Изготовь|Нужен|Мне нужен|Собери)\s+', '', desc, flags=re.IGNORECASE)
    desc = re.sub(r'^(?:Make|Build|I need|Required)\s+', '', desc, flags=re.IGNORECASE)
    return desc.strip(' ,.')


def extract_dims(prompt: str) -> str:
    """Extract dimensions from prompt."""
    match = re.search(r'(\d+(?:\.\d+)?)\s*(?:x|×|by|на)\s*(\d+(?:\.\d+)?)\s*(?:x|×|by|на)\s*(\d+(?:\.\d+)?)\s*(?:mm|мм)?', prompt, re.IGNORECASE)
    if match:
        return f"{match.group(1)}x{match.group(2)}x{match.group(3)} mm"
    return ""


def add_target_bbox_to_code(code: str, target_bbox: list[float]) -> str:
    """Add target_bbox comment to code."""
    if not target_bbox or len(target_bbox) != 3:
        return code
    
    bbox_str = f"{target_bbox[0]:g}, {target_bbox[1]:g}, {target_bbox[2]:g}"
    comment = f"// target_bbox: {bbox_str}"
    
    if 'target_bbox' in code:
        return code
    
    lines = code.split('\n')
    new_lines = []
    fn_found = False
    for line in lines:
        new_lines.append(line)
        if not fn_found and line.strip().startswith('$fn'):
            new_lines.append(comment)
            fn_found = True
    
    if not fn_found:
        new_lines.insert(0, comment)
    
    return '\n'.join(new_lines)


def generate_styles(prompts: dict[str, str], target_bbox: list[float]) -> dict[str, str]:
    """Generate prompt styles from base prompts."""
    styles = {}
    dims = extract_dims(prompts.get('ru', '') + ' ' + prompts.get('en', ''))
    
    for base_lang, base_prompt in prompts.items():
        if not base_prompt:
            continue
        
        description = extract_description(base_prompt)
        if not description:
            continue
        
        if base_lang == 'ru':
            for style in ['free_ru', 'conv_ru']:
                templates = STYLE_TEMPLATES[style]
                template = templates[hash(description) % len(templates)]
                if '{dims}' in template and dims:
                    styles[style] = template.format(description=description, dims=dims)
                elif '{dims}' not in template:
                    styles[style] = template.format(description=description)
        elif base_lang == 'en':
            for style in ['free_en', 'conv_en']:
                templates = STYLE_TEMPLATES[style]
                template = templates[hash(description) % len(templates)]
                if '{dims}' in template and dims:
                    styles[style] = template.format(description=description, dims=dims)
                elif '{dims}' not in template:
                    styles[style] = template.format(description=description)
    
    return styles


def compute_quality(prompts: dict[str, str]) -> dict:
    """Compute metadata.quality for a row."""
    n_prompts = len([p for p in prompts.values() if p])
    return {
        "score": round(n_prompts / max(len(prompts), 1), 2),
        "flags": [],
        "skeleton": "",
        "skeleton_rows": 1,
        "prompt_styles": sorted(prompts.keys()),
        "dropped_styles": [],
        "builder": "v9_fix",
    }


def read_jsonl(path: Path) -> list[dict]:
    with path.open(encoding="utf-8") as f:
        return [json.loads(line) for line in f if line.strip()]


def write_jsonl(path: Path, rows: list[dict]) -> None:
    with path.open("w", encoding="utf-8") as f:
        for row in rows:
            f.write(json.dumps(row, ensure_ascii=False) + "\n")


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--input", type=Path, default=Path("data/processed/combined_v9.jsonl"))
    parser.add_argument("--output", type=Path, default=Path("data/processed/combined_v9_fixed.jsonl"))
    parser.add_argument("--report", type=Path, default=Path("data/processed/combined_v9_fixed.report.json"))
    parser.add_argument("--dry-run", action="store_true")
    args = parser.parse_args()
    
    rows = read_jsonl(args.input)
    print(f"input: {args.input} — {len(rows)} rows")
    
    # Identify supplies 5-7 (not in v8)
    v8_path = Path("data/processed/combined_v8.jsonl")
    if v8_path.exists():
        v8_ids = {r['id'] for r in read_jsonl(v8_path)}
    else:
        v8_ids = set()
    
    supplies = [r for r in rows if r['id'] not in v8_ids]
    print(f"supplies 5-7: {len(supplies)} rows")
    
    # Fix supplies
    fixed = []
    stats = collections.Counter()
    
    for row in supplies:
        # Add target_bbox to code
        target_bbox = row.get('verification', {}).get('target_bbox', [])
        if target_bbox:
            row['code'] = add_target_bbox_to_code(row['code'], target_bbox)
            # Update code_sha256
            row['metadata']['code_sha256'] = hashlib.sha256(row['code'].encode('utf-8')).hexdigest()
            stats['target_bbox_added'] += 1
        
        # Generate styles
        base_prompts = row.get('prompts', {})
        new_styles = generate_styles(base_prompts, target_bbox)
        row['prompts'] = {**base_prompts, **new_styles}
        stats['styles_generated'] += len(new_styles)
        
        # Add metadata.quality
        row['metadata']['quality'] = compute_quality(row['prompts'])
        stats['quality_added'] += 1
        
        fixed.append(row)
    
    # Rebuild full corpus: v8 + fixed supplies
    v8_rows = [r for r in rows if r['id'] in v8_ids]
    all_rows = v8_rows + fixed
    
    # Report
    report = {
        "input": str(args.input),
        "output": str(args.output),
        "total_rows": len(all_rows),
        "v8_rows": len(v8_rows),
        "supplies_fixed": len(fixed),
        "stats": dict(stats),
    }
    print(json.dumps(report, ensure_ascii=False, indent=2))
    
    if args.dry_run:
        print("[dry-run] ничего не записано")
        return 0
    
    write_jsonl(args.output, all_rows)
    args.report.write_text(json.dumps(report, ensure_ascii=False, indent=2), encoding="utf-8")
    print(f"записано: {args.output} ({len(all_rows)} строк), отчёт: {args.report}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
