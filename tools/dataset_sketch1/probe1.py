"""Probe the sketch1 families: build, audit, report.

    python tools/dataset_sketch1/probe1.py [family ...] --count 4 [--stl]
"""

from __future__ import annotations

import argparse
import sys
import time
from pathlib import Path

REPO = Path(__file__).resolve().parents[2]
if str(REPO) not in sys.path:
    sys.path.insert(0, str(REPO))

from tools.dataset_sketch1.families1a import (  # noqa: E402
    build_camdiscs,
    build_eccentrics,
    build_eyelugs,
    build_hookplates,
    build_leverarms,
    build_pawls,
    build_rackbars,
    build_sprockets,
    build_tslots,
    build_windowplates,
)
from tools.dataset_sketch1.families1b import (  # noqa: E402
    build_arcstops,
    build_fanrotors,
    build_flatadapters,
    build_formwashers,
    build_guardgrids,
    build_keybars,
    build_pclips,
    build_sinkframes,
    build_standoffs,
    build_overslots,
)

FAMILY_BUILDERS = {
    "camdiscs": build_camdiscs,
    "leverarms": build_leverarms,
    "hookplates": build_hookplates,
    "eyelugs": build_eyelugs,
    "windowplates": build_windowplates,
    "pawls": build_pawls,
    "eccentrics": build_eccentrics,
    "sprockets": build_sprockets,
    "rackbars": build_rackbars,
    "tslots": build_tslots,
    "keybars": build_keybars,
    "standoffs": build_standoffs,
    "formwashers": build_formwashers,
    "pclips": build_pclips,
    "fanrotors": build_fanrotors,
    "arcstops": build_arcstops,
    "overslots": build_overslots,
    "flatadapters": build_flatadapters,
    "sinkframes": build_sinkframes,
    "guardgrids": build_guardgrids,
}


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("families", nargs="*")
    parser.add_argument("--count", type=int, default=4)
    parser.add_argument("--stl", action="store_true")
    parser.add_argument("--verbose", action="store_true")
    args = parser.parse_args()

    from tools.dataset_sketch1.core1 import check_sketch

    families = args.families or list(FAMILY_BUILDERS)
    failures = 0
    for family in families:
        builder = FAMILY_BUILDERS[family]
        started = time.time()
        problems: list[str] = []
        for index in range(args.count):
            try:
                part = builder(index)
            except Exception as exc:  # noqa: BLE001
                problems.append(f"[{index}] generator crash {type(exc).__name__}: {exc}")
                continue
            result = check_sketch(part, stl=args.stl)
            for error in result.errors:
                problems.append(f"[{index}] {error}")
            if args.verbose and not result.errors:
                print(
                    f"   [{index}] {part.variant}: {len(part.profile)} pts, "
                    f"bbox {part.bbox}, area {result.profile_area:.0f} mm2, vol {result.volume:.0f} mm3"
                )
        status = "ok" if not problems else f"{len(problems)} problems"
        print(f"{family:<13} {args.count} samples in {time.time() - started:5.1f}s  {status}")
        for line in problems[:5]:
            print(f"    {line}")
        failures += bool(problems)
    print()
    print("all families clean" if not failures else f"{failures} failing families")
    return 1 if failures else 0


if __name__ == "__main__":
    raise SystemExit(main())
