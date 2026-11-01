"""Compare v15r_2k vs v15r_wire_default eval results."""
import json
from pathlib import Path

def load(path):
    lines = Path(path).read_text().strip().splitlines()
    return [json.loads(l) for l in lines]

OLD = Path(r"data\processed\eval_wire_v15r_2k_step2000.jsonl")
NEW = Path(r"data\processed\eval_wire_v15r_wire_default_step2000.jsonl")

old_recs = load(OLD)
new_recs = load(NEW)

# Build lookup by id
old_by_id = {r["id"]: r for r in old_recs}
new_by_id = {r["id"]: r for r in new_recs}

# Stats
def stats(recs):
    total = len(recs)
    compiled = sum(1 for r in recs if r.get("compiled"))
    watertight = sum(1 for r in recs if r.get("is_watertight"))
    scored = [r for r in recs if r.get("compiled") and r.get("expected_bbox_mm") is not None and r.get("actual_bbox")]
    bbox_ok = sum(1 for r in scored if r.get("bbox_relative_error", 999) <= 0.15)
    errors = [r.get("bbox_relative_error") for r in scored if r.get("bbox_relative_error") is not None]
    median_err = sorted(errors)[len(errors)//2] if errors else None
    return {
        "total": total, "compiled": compiled, "watertight": watertight,
        "scored": len(scored), "bbox_ok": bbox_ok,
        "median_err": median_err,
    }

s_old = stats(old_recs)
s_new = stats(new_recs)

print("=" * 70)
print(f"{'Metric':20s} {'v15r_2k':>15s} {'v15r_wire_default':>20s} {'delta':>10s}")
print("=" * 70)

metrics = [
    ("total", "total", ""),
    ("compiled", "compiled", ""),
    ("watertight", "watertight", ""),
    ("scored (with GT)", "scored", ""),
    ("bbox ≤15%", "bbox_ok", ""),
]

for name, key, _ in metrics:
    old_v = s_old[key]
    new_v = s_new[key]
    delta = new_v - old_v
    print(f"{name:20s} {old_v:>15d} {new_v:>20d} {delta:+10d}")

median_old = s_old["median_err"]
median_new = s_new["median_err"]
if median_old is not None and median_new is not None:
    print(f"{'median err':20s} {median_old:>15.3f} {median_new:>20.3f} {'':>8s}({'improved' if median_new < median_old else 'worse'})")
elif median_old is not None:
    print(f"{'median err':20s} {median_old:>15.3f} {'N/A':>20s}")
else:
    print(f"{'median err':20s} {'N/A':>15s} {'N/A':>20s}")

# Per-record breakdown
print()
print("=" * 70)
print("Per-record comparison (only where bbox error changed >0.1):")
print("=" * 70)

common_ids = set(old_by_id.keys()) & set(new_by_id.keys())
for rid in sorted(common_ids):
    o = old_by_id[rid]
    n = new_by_id[rid]
    o_err = o.get("bbox_relative_error")
    n_err = n.get("bbox_relative_error")
    o_comp = o.get("compiled", False)
    n_comp = n.get("compiled", False)
    
    if o_comp != n_comp:
        status = "NEWLY_COMPILED" if n_comp else "LOST_COMPILE"
        print(f"  {rid:25s} compile: {o_comp}→{n_comp} {status}")
    elif o_err is not None and n_err is not None and abs(o_err - n_err) > 0.1:
        delta = n_err - o_err
        direction = "GOOD" if delta < 0 else "BAD"
        print(f"  {rid:25s} err: {o_err:.3f} → {n_err:.3f} {direction} (Δ={delta:.3f})")
    elif o_err is None and n_err is not None:
        print(f"  {rid:25s} err: NONE → {n_err:.3f} (now has bbox_err)")
    elif o_err is not None and n_err is None:
        print(f"  {rid:25s} err: {o_err:.3f} → NONE (lost bbox_err)")

# Summary
print()
print("=" * 70)
print("COMPILE RATE by class:")
for label, recs in [("v15r_2k", old_recs), ("v15r_wire_default", new_recs)]:
    classes = {}
    for r in recs:
        rid = r["id"]
        cls = rid.split("_")[0] if "_" in rid else "other"
        if cls not in classes:
            classes[cls] = {"total": 0, "compiled": 0}
        classes[cls]["total"] += 1
        if r.get("compiled"):
            classes[cls]["compiled"] += 1
    print(f"  {label}:")
    for cls in sorted(classes):
        c = classes[cls]
        pct = c["compiled"] / c["total"] * 100 if c["total"] > 0 else 0
        print(f"    {cls:15s} {c['compiled']:3d}/{c['total']:2d} ({pct:.0f}%)")

print()
print("NEW wire checkpoints need WSL→Windows sync:")
print("  wsl.exe bash -c 'rsync -a ~/omnicraft/repo/checkpoints/wire/ /mnt/c/github/OmniCraft-LM/checkpoints/wire/'")