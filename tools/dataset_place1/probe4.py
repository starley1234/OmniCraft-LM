"""Quick per-family probe for ``place1``: geometry gate + consistency auditor.

    python tools/dataset_place1/probe4.py [family ...] [--count N] [--no-probe]

Every configuration is built, evaluated with the manifold kernel, audited by the
placement probes (an empty cube in each declared feature, a solid cube where a
wrong layout would have drilled one) and finally run through the consistency
auditor, which compares the prompt numbers against the code.  A family is good
only when all three agree.
"""

from __future__ import annotations

import argparse
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[2]))

from tools.dataset_place1.check_consistency import check_row  # noqa: E402
from tools.dataset_place1.core4 import check_place  # noqa: E402
from tools.dataset_place1.families4a import BUILDERS as BUILDERS_A  # noqa: E402
from tools.dataset_place1.families4b import BUILDERS as BUILDERS_B  # noqa: E402

BUILDERS = {**BUILDERS_A, **BUILDERS_B}


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description="family probe of place1")
    parser.add_argument("families", nargs="*", default=None)
    parser.add_argument("--count", type=int, default=12, help="indices per family")
    parser.add_argument("--no-probe", action="store_true", help="skip the geometric probes")
    args = parser.parse_args(argv)

    names = args.families or list(BUILDERS)
    failures = 0
    for name in names:
        builder = BUILDERS[name]
        good = 0
        for index in range(args.count):
            part = builder(index)
            result = check_place(part, probes=not args.no_probe)
            row = part.manifest_row(f"{name}/part_{index + 1:04d}.scad", f"{name}_{index + 1:04d}")
            consistency = check_row(row, part.code, "both")
            if result.ok and consistency.ok:
                good += 1
                continue
            failures += 1
            print(f"FAIL {name}[{index}] variant={part.variant}")
            for error in result.errors:
                print("   geometry:", error)
            for missing in consistency.missing:
                print("   prompt number not in the code:", missing)
            for error in consistency.placement_errors:
                print("   placement:", error)
        print(f"{name:16s} {good}/{args.count} clean")
    return 1 if failures else 0


if __name__ == "__main__":
    raise SystemExit(main())
