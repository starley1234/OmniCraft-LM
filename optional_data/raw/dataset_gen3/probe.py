"""Quick gate probe for the gen3 families.

Usage::

    python tools/dataset_gen3/probe.py [family ...] [--stl] [--count N]

Without arguments every registered family is probed with ``--count`` samples
(default 4).  Each sample goes through ``check_part`` (source rules, manifold
evaluation, single component, bbox within 3 %) and, with ``--stl``, through the
receiver-simulation STL gate (watertight, one shell, no degenerate facets).
"""

from __future__ import annotations

import argparse
import sys
import time
from pathlib import Path

REPO = Path(__file__).resolve().parents[2]
if str(REPO) not in sys.path:
    sys.path.insert(0, str(REPO))

from tools.dataset_gen3.build3 import FAMILY_BUILDERS  # noqa: E402


def probe(family: str, indices: list[int], stl: bool) -> list[str]:
    from tools.dataset_gen2.common import check_part

    builder = FAMILY_BUILDERS[family]
    problems: list[str] = []
    for index in indices:
        try:
            part = builder(index)
        except Exception as exc:  # noqa: BLE001 - report the generator crash
            problems.append(f"{family}[{index}] generator crash: {type(exc).__name__}: {exc}")
            continue
        try:
            result = check_part(part)
        except Exception as exc:  # noqa: BLE001
            problems.append(f"{family}[{index}] evaluation crash: {type(exc).__name__}: {exc}")
            continue
        for error in result.errors:
            problems.append(f"{family}[{index}] {error}")
        if stl and not result.errors:
            from tools.dataset_gen2.stlcheck import check_source, is_bad

            try:
                info = check_source(part.code)
                if is_bad(info):
                    problems.append(
                        f"{family}[{index}] STL gate: watertight={info['watertight']} "
                        f"components={info['components']} degenerate={info['degenerate']}"
                    )
            except Exception as exc:  # noqa: BLE001
                problems.append(f"{family}[{index}] STL crash: {type(exc).__name__}: {exc}")
    return problems


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("families", nargs="*", help="family names (default: all)")
    parser.add_argument("--count", type=int, default=4, help="samples per family")
    parser.add_argument("--start", type=int, default=0, help="first index")
    parser.add_argument("--stl", action="store_true", help="also run the STL gate")
    parser.add_argument("--quiet", action="store_true")
    args = parser.parse_args()

    families = args.families or list(FAMILY_BUILDERS)
    unknown = [name for name in families if name not in FAMILY_BUILDERS]
    if unknown:
        parser.error(f"unknown families: {unknown}")

    indices = list(range(args.start, args.start + args.count))
    total = 0
    failures: dict[str, list[str]] = {}
    for family in families:
        started = time.time()
        problems = probe(family, indices, args.stl)
        failures[family] = problems
        total += len(indices)
        if not args.quiet:
            status = "ok" if not problems else f"{len(problems)} problems"
            print(f"{family:<14} {len(indices)} samples in {time.time() - started:5.1f}s  {status}")
            for line in problems[:6]:
                print(f"    {line}")

    broken = {name: lines for name, lines in failures.items() if lines}
    print()
    if broken:
        print(f"{len(broken)} failing families, {sum(len(v) for v in broken.values())} problems:")
        for name, lines in broken.items():
            print(f"  {name}: {lines[0]}")
    else:
        print(f"all {len(families)} families clean over {len(indices)} samples each ({total} parts)")
    return 1 if broken else 0


if __name__ == "__main__":
    raise SystemExit(main())
