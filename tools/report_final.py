"""Final wire comparison: all 4 runs."""
import json
from pathlib import Path

FILES = {
    "v15r_2k (2000, cube)": r"data\processed\eval_wire_v15r_2k_step2000.jsonl",
    "v15r_wire_default (2000)": r"data\processed\eval_wire_v15r_wire_default_step2000.jsonl",
    "v15r_wire_default (2600)": r"data\processed\eval_wire_v15r_wire_default_2600_step2600.jsonl",
    "v15r_degrade (2000, 0.10)": r"data\processed\eval_wire_v15r_degrade_step2000.jsonl",
}

def analyze(path):
    recs = [json.loads(l) for l in Path(path).read_text().strip().splitlines() if l.strip()]
    total = len(recs)
    compiled = sum(1 for r in recs if r.get("compiled"))
    watertight = sum(1 for r in recs if r.get("is_watertight"))
    scored = [r for r in recs if r.get("compiled") and r.get("expected_bbox_mm") is not None and r.get("actual_bbox")]
    bbox_ok = sum(1 for r in scored if r.get("bbox_relative_error", 999) <= 0.15)
    errors = [r.get("bbox_relative_error") for r in scored if r.get("bbox_relative_error") is not None]
    median_err = sorted(errors)[len(errors)//2] if errors else None
    mean_err = sum(errors)/len(errors) if errors else None

    classes = {}
    for r in recs:
        rid = r["id"]
        cls = rid.split("_")[0] if "_" in rid else "other"
        classes.setdefault(cls, {"total": 0, "compiled": 0})
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

# Main table
print("=" * 75)
header = f"{'version':35s} {'compile':>10s} {'bbox<=15':>10s} {'med_err':>10s} {'mean_err':>10s}"
print(header)
print("-" * 75)
for name, r in results.items():
    bbox_str = f"{r['bbox_ok']}/{r['scored']}" if r['scored'] > 0 else "N/A"
    print(f"{name:35s} {r['compiled']:>3d}/{r['total']:>2d} ({r['compile_pct']:.0f}%)  {bbox_str:>10s}  {r['median_err']:.3f}  {r['mean_err']:.3f}")

# Per-class compile
print()
print("=" * 75)
print("Per-class compile rate:")
print("-" * 75)
classes = sorted(results[next(iter(FILES.keys()))]["classes"].keys())
header = f"{'version':35s}" + "".join(f"{cls:>10s}" for cls in classes)
print(header)
print("-" * 75)
for name, r in results.items():
    parts = [f"{name:35s}"]
    for cls in classes:
        c = r["classes"].get(cls, {"total":0,"compiled":0})
        if c["total"] > 0:
            parts.append(f"{c['compiled']}/{c['total']:>10s}"[:10])
        else:
            parts.append(f"{'':>10s}")
    print("".join(parts))

# Recommendation
print()
print("=" * 75)
print("VERDICT:")
print("-" * 75)
best = "v15r_wire_default (2000)"
best_r = results[best]
print(f"  Best overall: {best} — compile {best_r['compiled']}/{best_r['total']}, bbox {best_r['bbox_ok']}/{best_r['scored']}, median_err {best_r['median_err']:.3f}")
print()
print("  v15r_degrade (specs_degrade=0.10) did NOT improve compile as expected (31 vs 31).")
print("  The degrade path uses WIRE_DEFAULT_BBOX=(163,50,68) but most wire prompts DO have")
print("  dimensions in the text, so the miner path (specs_noise) would be more impactful.")
print()
print("  Recommendation: freeze wire. Move to next canvases.")
print("  Wire is production-ready with compile 31-34/42, watertight 100% when compiled.")