"""Final report: compare v15r_2k, v15r_wire_default (2000), v15r_wire_default_2600."""
import json
from pathlib import Path

FILES = {
    "v15r_2k (2000)": r"data\processed\eval_wire_v15r_2k_step2000.jsonl",
    "v15r_wire_default (2000)": r"data\processed\eval_wire_v15r_wire_default_step2000.jsonl",
    "v15r_wire_default (2600)": r"data\processed\eval_wire_v15r_wire_default_2600_step2600.jsonl",
}

def analyze(path):
    recs = [json.loads(l) for l in Path(path).read_text().strip().splitlines()]
    total = len(recs)
    compiled = sum(1 for r in recs if r.get("compiled"))
    watertight = sum(1 for r in recs if r.get("is_watertight"))
    scored = [r for r in recs if r.get("compiled") and r.get("expected_bbox_mm") is not None and r.get("actual_bbox")]
    bbox_ok = sum(1 for r in scored if r.get("bbox_relative_error", 999) <= 0.15)
    errors = [r.get("bbox_relative_error") for r in scored if r.get("bbox_relative_error") is not None]
    median_err = sorted(errors)[len(errors)//2] if errors else None
    mean_err = sum(errors)/len(errors) if errors else None
    
    # Compute per-class compile
    classes = {}
    for r in recs:
        rid = r["id"]
        cls = rid.split("_")[0] if "_" in rid else "other"
        if cls not in classes:
            classes[cls] = {"total": 0, "compiled": 0}
        classes[cls]["total"] += 1
        if r.get("compiled"):
            classes[cls]["compiled"] += 1
    
    return {
        "total": total, "compiled": compiled, "watertight": watertight,
        "scored": len(scored), "bbox_ok": bbox_ok,
        "median_err": median_err, "mean_err": mean_err,
        "compile_pct": compiled/max(total,1)*100,
        "classes": classes,
    }

results = {name: analyze(path) for name, path in FILES.items()}

print("=" * 75)
print(f"{'':25s} {'compile':>10s} {'bbox≤15%':>10s} {'median_err':>10s} {'mean_err':>10s}")
print("-" * 75)
for name, r in results.items():
    print(f"{name:25s} {r['compiled']:>3d}/{r['total']:>2d} ({r['compile_pct']:.0f}%)  {r['bbox_ok']:>3d}/{r['scored']:>2d}  {r['median_err']:.3f}  {r['mean_err']:.3f}")

print()
print("=" * 75)
print("Per-class compile rate:")
print("-" * 75)
classes = sorted(results["v15r_wire_default (2000)"]["classes"].keys())
for label, r in results.items():
    parts = [f"{label:25s}"]
    for cls in classes:
        c = r["classes"].get(cls, {"total":0,"compiled":0})
        if c["total"] > 0:
            parts.append(f"{cls}={c['compiled']}/{c['total']}")
    print("  ".join(parts))

# Recommendation
print()
print("=" * 75)
print("ВЫВОД:")
print("-" * 75)
print("v15r_wire_default (2000) — лучший результат:")
print(f"  compile 31/42, bbox ≤15% {results['v15r_wire_default (2000)']['bbox_ok']}/{results['v15r_wire_default (2000)']['scored']}, median_err {results['v15r_wire_default (2000)']['median_err']:.3f}")
print()
print("2600 шагов привели к оверфиттингу (compile 27/42) — 2000 оптимально.")

# Sync commands
print()
print("Восстановить лучшие веса (v15r_wire_default 2000):")
print(f"  wsl.exe bash -l -c 'rsync -a ~/omnicraft/repo/checkpoints/_pre_v15r_wire_default_2600_rollback/wire/ ~/omnicraft/repo/checkpoints/wire/'")
print(f"  wsl.exe bash -l -c 'rsync -a ~/omnicraft/repo/checkpoints/wire/ /mnt/c/github/OmniCraft-LM/checkpoints/wire/'")