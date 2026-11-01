"""Analyze per-axis bbox error for wire eval."""
import json
import sys
from pathlib import Path

V15R_2K = r"data\processed\eval_wire_v15r_2k_step2000.jsonl"
V15R_WIRE_DEFAULT = r"data\processed\eval_wire_v15r_wire_default_step2000.jsonl"

def analyze(eval_path: Path, label: str = ""):
    """Analyze one eval file."""
    if not eval_path.exists():
        print(f"File not found: {eval_path}")
        sys.exit(1)

    lines = eval_path.read_text().strip().splitlines()
    recs = [json.loads(l) for l in lines]

    compile_ok = [r for r in recs if r.get("compiled") and r.get("actual_bbox")]
    # Records with expected_bbox_mm available for bbox analysis (skip conv without GT)
    compile_with_bbox = [r for r in compile_ok if r.get("expected_bbox_mm") is not None]
    total = len(compile_ok)
    total_bbox = len(compile_with_bbox)
    print(f"File: {eval_path.name}")
    print(f"Total records: {len(recs)}, compiled: {total}/{len(recs)}")
    print(f"With expected_bbox_mm: {total_bbox}/{total}")
    print()

    axis_errors = []
    bbox_hits = 0

    for r in compile_with_bbox:
        exp = r["expected_bbox_mm"]
        act = r["actual_bbox"]
        err = {}
        for axis_name, e, a in zip(["X", "Y", "Z"], exp, act):
            if e > 0:
                rel_err = abs(a - e) / e
            else:
                rel_err = 0.0
            err[axis_name] = rel_err
        axis_errors.append(err)
        if all(v <= 0.15 for v in err.values()):
            bbox_hits += 1

    print(f"bbox <=15% (all 3 axes): {bbox_hits}/{total}")
    print()

    # Per-axis
    for axis in ["X", "Y", "Z"]:
        vals = [e[axis] for e in axis_errors]
        vals_ok = [v for v in vals if v <= 0.15]
        s_vals = sorted(vals)
        median = s_vals[len(s_vals) // 2]
        mean = sum(vals) / len(vals)
        print(f"Axis {axis}: median={median:.3f}, mean={mean:.3f}, "
              f"<=15%: {len(vals_ok)}/{len(vals)}, max={max(vals):.3f}")

    print()
    print("=" * 80)
    print("Per-record breakdown (expected vs actual per axis):")
    print("=" * 80)

    # Sort by worst error for readability
    if compile_with_bbox:
        sorted_pairs = sorted(enumerate(compile_with_bbox), key=lambda x: sum(axis_errors[x[0]].values()), reverse=True)

        for idx, (orig_idx, r) in enumerate(sorted_pairs):
            exp = r["expected_bbox_mm"]
            act = r["actual_bbox"]
            err = axis_errors[orig_idx]
            worst_axis = max(err.items(), key=lambda x: x[1])
            status = "FAIL" if any(v > 0.15 for v in err.values()) else "OK"

            axis_str = []
            for name, e, a in zip(["X", "Y", "Z"], exp, act):
                err_pct = round(err[name] * 100, 1)
                axis_str.append(f"{name}: exp={e}, act={a:.1f}, err={err_pct}%")

            print(f"  [{status}] {r['id']}: worst={worst_axis[0]}={worst_axis[1]*100:.1f}%")
            print(f"       {', '.join(axis_str)}")

    # Summary patterns
    print()
    print("=" * 80)
    print("Systematic bias check (mean signed error per axis):")
    print("=" * 80)
    for axis in ["X", "Y", "Z"]:
        signed = []
        for r in compile_with_bbox:
            exp = r["expected_bbox_mm"]
            act = r["actual_bbox"]
            axis_idx = ["X", "Y", "Z"].index(axis)
            e = exp[axis_idx]
            a = act[axis_idx]
            if e > 0:
                signed.append((a - e) / e)
        mean_signed = sum(signed) / len(signed)
        # count positive (overestimate) vs negative (underestimate)
        pos = sum(1 for s in signed if s > 0)
        neg = sum(1 for s in signed if s <= 0)
        print(f"Axis {axis}: mean_signed={mean_signed:.3f}  overestimates={pos}/{len(signed)}  underestimates={neg}/{len(signed)}")

    # Bbox success rate by specs_mode
    print()
    print("=" * 80)
    print("bbox <=15% by specs_mode:")
    print("=" * 80)
    modes = {}
    for r in recs:
        mode = r.get("specs_mode", "unknown")
        if mode not in modes:
            modes[mode] = {"total": 0, "compiled": 0, "bbox_ok": 0, "bbox_total": 0}
        modes[mode]["total"] += 1
        has_expected = r.get("expected_bbox_mm") is not None
        if r.get("compiled") and r.get("actual_bbox"):
            modes[mode]["compiled"] += 1
            if has_expected:
                modes[mode]["bbox_total"] += 1
                exp = r["expected_bbox_mm"]
                act = r["actual_bbox"]
                ok = all(abs(a - e) / max(e, 1e-6) <= 0.15 for a, e in zip(act, exp))
                if ok:
                    modes[mode]["bbox_ok"] += 1

    for mode, stats in modes.items():
        bbox_total = stats.get("bbox_total", stats["total"])
        print(f"  {mode}: bbox<=15% {stats['bbox_ok']}/{bbox_total} "
              f"(compiled {stats['compiled']}/{stats['total']})")

    # Count of axis combinations that fail
    if compile_with_bbox:
        print()
        print("=" * 80)
        print("Failure patterns (which axes fail together):")
        print("=" * 80)
        from collections import Counter
        patterns = Counter()
        for err in axis_errors:
            failing = tuple(sorted(a for a in ["X","Y","Z"] if err[a] > 0.15))
            patterns[failing] += 1
        for pat, cnt in patterns.most_common():
            axis_list = ",".join(pat) if pat else "none"
            print(f"  {axis_list}: {cnt}/{total_bbox}")


if __name__ == "__main__":
    main()