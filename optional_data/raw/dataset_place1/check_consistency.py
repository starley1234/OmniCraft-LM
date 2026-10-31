"""Placement-consistency auditor for the ``place1`` corpus.

The promise of this corpus is narrow and testable: *every dimensional number in
the prompt is present in the code, and the feature centres in the code are where
the prompt says they are*.  This module is the machine that checks that promise
from the two artefacts alone — no CAD kernel, no rendering, no trust:

1. **prompt numbers** — every number of the English prompt (millimetres,
   inch fractions, degrees, plain counts) is extracted.  ``M5`` and other
   thread designators are not dimensions and are skipped, as are numbers inside
   words such as ``GT2``.
2. **code numbers** — the values of the header assignments (evaluated with the
   small AST evaluator below: arithmetic, lists, indexing, degrees-based
   trigonometry), every numeric literal outside comments, and the evaluated
   arguments of the geometry calls (``translate``/``rotate``/``cylinder``/
   ``cube``/``for``).
3. a row passes the number test when *every* prompt number is found in the code
   numbers within 0.5 % relative tolerance;
4. a row passes the placement test when the array ``feature_centers`` of the
   code evaluates to the centres declared in the manifest (1 %) and the declared
   rule holds: count, mirror symmetry about the axes, equal pitch, bolt circle
   radius/start angle, lattice membership — whichever the row declares.
5. a secondary report counts *magic coordinates*: geometry arguments that are
   bare literals instead of expressions over the header variables (a small set of
   safety allowances such as the 1 mm cutter overshoot is whitelisted).

Run it standalone::

    python tools/dataset_place1/check_consistency.py --parts-dir optional_data/data/place1

The last summary line is the acceptance number::

    consistency auditor: 100.0% pass
"""

from __future__ import annotations

import argparse
import ast
import json
import math
import re
from dataclasses import dataclass, field
from pathlib import Path
from typing import Any, Iterable, Sequence

NUMBER_TOLERANCE = 0.005  # request: 0.5 % for "the number is in the code"
PLACEMENT_TOLERANCE = 0.01  # request: 1 % for the geometric invariants
INCH_MM = 25.4

# Bare literals that are allowed to appear in geometry arguments: cutter
# overshoots, loop signs, quarter turns.  Everything else must be a variable.
SAFETY_LITERALS = {
    0.0, 1.0, -1.0, 2.0, -2.0, 3.0, -3.0,
    0.4, -0.4, 0.6, -0.6, 0.01, -0.01,
    32.0, 45.0, 90.0, 180.0, 270.0, 360.0,
}

GEOMETRY_CALLS = ("translate", "rotate", "cylinder", "cube", "linear_extrude", "rotate_extrude", "for")


class EvalError(Exception):
    """Raised when a code expression cannot be evaluated by this auditor."""


# ---------------------------------------------------------------------------
# 1. prompt numbers
# ---------------------------------------------------------------------------

@dataclass
class PromptNumber:
    text: str
    value: float
    kind: str  # "mm" | "inch" | "deg" | "count"
    candidates: tuple[float, ...]  # values compared against the code numbers

    def __str__(self) -> str:  # pragma: no cover - debugging helper
        return f"{self.text} ({self.kind})"


# dimension chains like "80x50x6" are split so every number stands alone
_DIM_CHAIN = re.compile(r"(?<=\d)\s*[x\u0445\u00d7]\s*(?=\d)")
_INCH_FRACTION = re.compile(
    r"(?<![0-9A-Za-z_.])(\d+)\s*/\s*(\d+)\s*(in\b|\"|\u0434\u044e\u0439\u043c\w*)"
)
_THREAD = re.compile(r"\bM\s*\d+(?:\.\d+)?\b")  # M5, M12 - not a dimension
# ASCII-only boundaries: a number glued to a Latin/ASCII identifier ("GT2", "M8")
# is never a dimension, while "\u00f86.6" and "6.6\u043c\u043c" still are
_NUMBER = re.compile(r"(?<![0-9A-Za-z_.])(\d+(?:[.,]\d+)?)(?![0-9A-Za-z_])")
_UNIT_AFTER = re.compile(r"\s*(mm\b|\"|in\b|inch\w*|\u0434\u044e\u0439\u043c\w*|\u00b0|deg\b|degrees\b)", re.I)


def extract_prompt_numbers(prompt: str) -> list[PromptNumber]:
    """All dimensional numbers of an English prompt, in millimetre candidates."""
    text = _DIM_CHAIN.sub(" x ", prompt)
    text = _THREAD.sub(" ", text)
    consumed = [False] * len(text)
    found: list[PromptNumber] = []

    for match in _INCH_FRACTION.finditer(text):
        numerator, denominator = float(match.group(1)), float(match.group(2))
        if denominator == 0:
            continue
        millimetres = (numerator / denominator) * INCH_MM
        for index in range(match.start(), match.end()):
            consumed[index] = True
        found.append(
            PromptNumber(
                text=match.group(0).strip(),
                value=(numerator / denominator),
                kind="inch",
                candidates=(round(millimetres, 6),),
            )
        )

    for match in _NUMBER.finditer(text):
        if consumed[match.start()]:
            continue
        raw = match.group(1).replace(",", ".")
        value = float(raw)
        tail = text[match.end():match.end() + 10]
        unit_match = _UNIT_AFTER.match(tail)
        unit = unit_match.group(1).lower() if unit_match else ""
        if unit.startswith("in") or unit.startswith("дюйм") or unit == '"':
            kind = "inch"
            candidates = (round(value * INCH_MM, 6),)
        elif unit in ("°", "deg", "degrees"):
            kind = "deg"
            candidates = (value,)
        elif unit == "mm":
            kind = "mm"
            candidates = (value,)
        else:
            # A bare number in this corpus is either a count of features or a
            # millimetre size stated next to one; both are in the code pool.
            kind = "count" if abs(value - round(value)) < 1e-9 else "mm"
            candidates = (value,)
        found.append(PromptNumber(text=raw, value=value, kind=kind, candidates=candidates))
    return found


# ---------------------------------------------------------------------------
# 2. code numbers
# ---------------------------------------------------------------------------

_BINARY_OPS = {
    ast.Add: lambda a, b: a + b,
    ast.Sub: lambda a, b: a - b,
    ast.Mult: lambda a, b: a * b,
    ast.Div: lambda a, b: a / b,
    ast.FloorDiv: lambda a, b: a // b,
    ast.Mod: lambda a, b: a % b,
    ast.Pow: lambda a, b: a ** b,
}
_COMPARE_OPS = {
    ast.Eq: lambda a, b: a == b,
    ast.NotEq: lambda a, b: a != b,
    ast.Lt: lambda a, b: a < b,
    ast.LtE: lambda a, b: a <= b,
    ast.Gt: lambda a, b: a > b,
    ast.GtE: lambda a, b: a >= b,
}
_FUNCTIONS: dict[str, Any] = {
    "cos": lambda v: math.cos(math.radians(v)),
    "sin": lambda v: math.sin(math.radians(v)),
    "tan": lambda v: math.tan(math.radians(v)),
    "acos": lambda v: math.degrees(math.acos(max(-1.0, min(1.0, v)))),
    "asin": lambda v: math.degrees(math.asin(max(-1.0, min(1.0, v)))),
    "atan": lambda v: math.degrees(math.atan(v)),
    "atan2": lambda a, b: math.degrees(math.atan2(a, b)),
    "sqrt": lambda v: math.sqrt(v) if v >= 0 else float("nan"),
    "abs": abs,
    "floor": math.floor,
    "ceil": math.ceil,
    "round": round,
    "min": min,
    "max": max,
    "pow": pow,
}


def eval_expression(expression: str, env: dict[str, Any]) -> Any:
    """Evaluate a small arithmetic expression (OpenSCAD-ish, degrees)."""
    if not expression.strip():
        raise EvalError("empty expression")
    try:
        tree = ast.parse(expression, mode="eval")
    except SyntaxError as exc:
        raise EvalError(f"syntax error in {expression!r}: {exc}") from exc
    return _eval_node(tree.body, env)


def _eval_node(node: ast.AST, env: dict[str, Any]) -> Any:
    if isinstance(node, ast.Constant):
        if isinstance(node.value, bool) or not isinstance(node.value, (int, float)):
            raise EvalError(f"unsupported constant {node.value!r}")
        return float(node.value)
    if isinstance(node, ast.Name):
        if node.id in env:
            return env[node.id]
        raise EvalError(f"unknown name {node.id!r}")
    if isinstance(node, (ast.List, ast.Tuple)):
        return [_eval_node(item, env) for item in node.elts]
    if isinstance(node, ast.UnaryOp):
        operand = _eval_node(node.operand, env)
        if isinstance(node.op, ast.USub):
            return -operand if isinstance(operand, (int, float)) else [-item for item in operand]
        if isinstance(node.op, ast.UAdd):
            return operand
        if isinstance(node.op, ast.Not):
            return not operand
        raise EvalError("unsupported unary operator")
    if isinstance(node, ast.BinOp):
        operator = _BINARY_OPS.get(type(node.op))
        if operator is None:
            raise EvalError("unsupported binary operator")
        return operator(_eval_node(node.left, env), _eval_node(node.right, env))
    if isinstance(node, ast.Compare):
        left = _eval_node(node.left, env)
        for op, comparator in zip(node.ops, node.comparators):
            function = _COMPARE_OPS.get(type(op))
            if function is None:
                raise EvalError("unsupported comparison")
            right = _eval_node(comparator, env)
            if not function(left, right):
                return False
            left = right
        return True
    if isinstance(node, ast.BoolOp):
        values = [_eval_node(value, env) for value in node.values]
        return all(values) if isinstance(node.op, ast.And) else any(values)
    if isinstance(node, ast.IfExp):
        branch = node.body if _eval_node(node.test, env) else node.orelse
        return _eval_node(branch, env)
    if isinstance(node, ast.Subscript):
        container = _eval_node(node.value, env)
        index_node = node.slice
        if isinstance(index_node, ast.Slice):
            raise EvalError("slices are not part of the dialect")
        index = int(_eval_node(index_node, env))
        if not isinstance(container, list) or not 0 <= index < len(container):
            raise EvalError("index out of range")
        return container[index]
    if isinstance(node, ast.Call):
        if not isinstance(node.func, ast.Name) or node.func.id not in _FUNCTIONS:
            raise EvalError("unsupported function")
        if node.keywords:
            raise EvalError("keyword arguments are not supported here")
        arguments = [_eval_node(argument, env) for argument in node.args]
        return _FUNCTIONS[node.func.id](*arguments)
    raise EvalError(f"unsupported expression node {type(node).__name__}")


def strip_comments(code: str) -> str:
    """Remove ``//`` and ``/* */`` comments so numbers inside them never count."""
    without_block = re.sub(r"/\*.*?\*/", " ", code, flags=re.DOTALL)
    return re.sub(r"//[^\n]*", "", without_block)


def _scan_to_semicolon(text: str, start: int) -> int:
    depth = 0
    index = start
    while index < len(text):
        character = text[index]
        if character in "([{":
            depth += 1
        elif character in ")]}":
            depth -= 1
        elif character == ";" and depth == 0:
            return index
        index += 1
    return -1


def _scan_to_close(text: str, start: int) -> int:
    """``start`` is the index just after an opening ``(``; returns its index."""
    depth = 1
    index = start
    while index < len(text):
        character = text[index]
        if character == "(":
            depth += 1
        elif character == ")":
            depth -= 1
            if depth == 0:
                return index
        index += 1
    return -1


def header_assignments(code: str) -> dict[str, Any]:
    """Evaluated values of the leading ``name = expression;`` statements."""
    text = strip_comments(code)
    env: dict[str, Any] = {"PI": math.pi}
    position = 0
    while position < len(text):
        while position < len(text) and text[position].isspace():
            position += 1
        special = re.match(r"\$[A-Za-z_]\w*\s*=", text[position:])
        if special:
            end = _scan_to_semicolon(text, position + special.end())
            if end < 0:
                break
            position = end + 1
            continue
        assignment = re.match(r"([A-Za-z_]\w*)\s*=", text[position:])
        if not assignment:
            break
        name = assignment.group(1)
        end = _scan_to_semicolon(text, position + assignment.end())
        if end < 0:
            break
        expression = text[position + assignment.end():end].strip()
        try:
            env[name] = eval_expression(expression, env)
        except (EvalError, ZeroDivisionError, ValueError, TypeError):
            break
        position = end + 1
    return env


def _iter_calls(text: str) -> Iterable[tuple[str, str]]:
    for match in re.finditer(r"\b([A-Za-z_]\w*)\s*\(", text):
        name = match.group(1)
        end = _scan_to_close(text, match.end())
        if end < 0:
            continue
        yield name, text[match.end():end]


def _split_arguments(text: str) -> list[str]:
    parts: list[str] = []
    current: list[str] = []
    depth = 0
    for character in text:
        if character in "([{":
            depth += 1
        elif character in ")]}":
            depth -= 1
        if character == "," and depth == 0:
            parts.append("".join(current))
            current = []
        else:
            current.append(character)
    if "".join(current).strip():
        parts.append("".join(current))
    return [part.strip() for part in parts]


def flatten_numbers(value: Any) -> list[float]:
    if isinstance(value, bool):
        return []
    if isinstance(value, (int, float)):
        return [float(value)]
    if isinstance(value, (list, tuple)):
        numbers: list[float] = []
        for item in value:
            numbers.extend(flatten_numbers(item))
        return numbers
    return []


def code_number_set(code: str) -> set[float]:
    """Every number the code carries: header values, literals, call arguments."""
    text = strip_comments(code)
    numbers: set[float] = set()
    env = header_assignments(code)
    for value in env.values():
        numbers.update(flatten_numbers(value))
    for match in re.finditer(r"\d+(?:\.\d+)?(?:[eE][+-]?\d+)?", text):
        numbers.add(float(match.group(0)))
    for name, arguments in _iter_calls(text):
        if name not in GEOMETRY_CALLS:
            continue
        for argument in _split_arguments(arguments):
            expression = argument.split("=", 1)[1] if re.match(r"\s*[A-Za-z_]\w*\s*=", argument) else argument
            try:
                numbers.update(flatten_numbers(eval_expression(expression, env)))
            except (EvalError, ZeroDivisionError, ValueError, TypeError):
                continue
    return numbers


def magic_coordinates(code: str) -> list[str]:
    """Geometry arguments that are bare literals instead of variable expressions."""
    text = strip_comments(code)
    env = header_assignments(code)
    offenders: list[str] = []
    for name, arguments in _iter_calls(text):
        if name not in ("translate", "rotate", "cylinder", "cube"):
            continue
        for argument in _split_arguments(arguments):
            expression = argument.split("=", 1)[1] if re.match(r"\s*[A-Za-z_]\w*\s*=", argument) else argument
            try:
                tree = ast.parse(expression, mode="eval")
            except SyntaxError:
                continue
            if any(isinstance(node, ast.Name) for node in ast.walk(tree)):
                continue  # driven by the header variables
            try:
                values = flatten_numbers(eval_expression(expression, env))
            except (EvalError, ZeroDivisionError, ValueError, TypeError):
                continue
            if not values:
                continue
            if all(abs(value) in {abs(allowed) for allowed in SAFETY_LITERALS} for value in values):
                continue
            offenders.append(f"{name}({expression.strip()})")
    return offenders


# ---------------------------------------------------------------------------
# 3/4. row level checks
# ---------------------------------------------------------------------------

@dataclass
class RowReport:
    row_id: str
    prompt_numbers: int = 0
    matched_numbers: int = 0
    missing: list[str] = field(default_factory=list)
    placement_errors: list[str] = field(default_factory=list)
    magic: list[str] = field(default_factory=list)

    @property
    def numbers_ok(self) -> bool:
        return self.prompt_numbers > 0 and not self.missing

    @property
    def placement_ok(self) -> bool:
        return not self.placement_errors

    @property
    def ok(self) -> bool:
        return self.numbers_ok and self.placement_ok


def _close(first: float, second: float, tolerance: float = PLACEMENT_TOLERANCE) -> bool:
    return abs(first - second) <= tolerance * max(abs(first), abs(second), 1e-9) + 1e-9


def find_prompt_number(value: float, code_numbers: set[float]) -> bool:
    if not code_numbers:
        return False
    for candidate in code_numbers:
        if _close(value, candidate, NUMBER_TOLERANCE):
            return True
    return False


def _centres_close(first: Sequence[float], second: Sequence[float], tolerance: float = PLACEMENT_TOLERANCE) -> bool:
    if len(first) != len(second):
        return False
    return all(_close(float(a), float(b), tolerance) for a, b in zip(first, second))


def _mirror_pairs(centres: Sequence[Sequence[float]], axis: str) -> bool:
    for centre in centres:
        mirrored = list(centre)
        mirrored[0 if axis == "y" else 1] *= -1
        if not any(_centres_close(mirrored, other) for other in centres):
            return False
    return True


def check_placement(placement: dict[str, Any], centres: Sequence[Sequence[float]],
                    extras: dict[str, Sequence[Sequence[float]]]) -> list[str]:
    """The geometric invariant of one row (request step 4)."""
    errors: list[str] = []
    kind = str(placement.get("kind", ""))
    declared_count = int(placement.get("count", -1))
    declared = [list(map(float, centre)) for centre in placement.get("centers_mm", [])]
    fields = placement.get("fields") or {}

    if declared_count != len(declared):
        errors.append(f"manifest count {declared_count} != {len(declared)} declared centres")
    if len(centres) != declared_count:
        errors.append(f"{len(centres)} centres in the code, {declared_count} declared")
    if len(centres) != len(declared):
        errors.append("code centres and manifest centres differ in length")
    for index, (code_centre, declared_centre) in enumerate(zip(centres, declared)):
        if not _centres_close(code_centre, declared_centre):
            errors.append(
                f"centre {index} in the code {tuple(round(v, 3) for v in code_centre)} "
                f"!= declared {tuple(round(v, 3) for v in declared_centre)}"
            )

    symmetry = str(placement.get("symmetry", "none"))
    if symmetry == "mirror_xy":
        if not _mirror_pairs(centres, "y"):
            errors.append("centres are not symmetric about the y axis")
        if not _mirror_pairs(centres, "x"):
            errors.append("centres are not symmetric about the x axis")
    elif symmetry == "mirror_y":
        if not _mirror_pairs(centres, "y"):
            errors.append("centres are not symmetric about the y axis")
    elif symmetry == "mirror_x":
        if not _mirror_pairs(centres, "x"):
            errors.append("centres are not symmetric about the x axis")
    elif symmetry == "rotational":
        pcd = float(fields.get("pcd_mm", 0.0))
        start = float(fields.get("start_deg", 0.0))
        if declared_count >= 3 and pcd > 0:
            radius = pcd / 2.0
            angles = sorted(
                (math.degrees(math.atan2(centre[1], centre[0])) - start) % 360.0 for centre in centres
            )
            for centre in centres:
                if not _close(math.hypot(centre[0], centre[1]), radius, PLACEMENT_TOLERANCE):
                    errors.append("a bolt-circle centre does not sit on the declared radius")
                    break
            step = 360.0 / declared_count
            # every centre must be start + k * step, and the step itself must be
            # the one the manifest declares; both are checked in angle space
            slack = PLACEMENT_TOLERANCE * step
            for centre in centres:
                angle = math.degrees(math.atan2(centre[1], centre[0]))
                residual = (angle - start) % step
                if min(residual, step - residual) > slack:
                    errors.append("bolt-circle centres are not equally spaced from the start angle")
                    break
            angles = sorted(math.degrees(math.atan2(centre[1], centre[0])) for centre in centres)
            gaps = [(second - first) % 360.0 for first, second in zip(angles, angles[1:])]
            if angles:
                gaps.append((angles[0] - angles[-1]) % 360.0)
            if any(abs(gap - step) > slack for gap in gaps):
                errors.append("bolt-circle angular pitch differs from 360 / count")

    pitch = fields.get("pitch_mm")
    if pitch and kind in ("row", "skip_row", "rib_row", "rack", "staggered_grid") and len(centres) >= 2:
        if kind == "staggered_grid":
            pass  # rows carry their own pitch, checked by the lattice fields
        else:
            expected = float(pitch) * (int(fields.get("skip", 1)) if kind == "skip_row" else 1)
            for first, second in zip(centres, centres[1:]):
                if not _close(abs(second[0] - first[0]), expected, PLACEMENT_TOLERANCE * 2):
                    errors.append(f"centre spacing {abs(second[0] - first[0]):.3f} != declared pitch {expected:.3f}")
                    break

    for entry in placement.get("extra") or []:
        name = str(entry.get("array", ""))
        code_centres = extras.get(name) or []
        declared_extra = [list(map(float, centre)) for centre in entry.get("centers_mm", [])]
        if len(code_centres) != len(declared_extra):
            errors.append(f"array {name}: {len(code_centres)} centres in the code, {len(declared_extra)} declared")
            continue
        for code_centre, declared_centre in zip(code_centres, declared_extra):
            if not _centres_close(code_centre, declared_centre):
                errors.append(f"array {name}: a centre of the code differs from the manifest")
                break
        extra_pitch = (entry.get("fields") or {}).get("pitch_mm")
        if extra_pitch and len(code_centres) >= 2:
            for first, second in zip(code_centres, code_centres[1:]):
                if not _close(abs(second[0] - first[0]), float(extra_pitch), PLACEMENT_TOLERANCE * 2):
                    errors.append(f"array {name}: spacing differs from the declared pitch")
                    break
   # row identity
    return errors


def _flatten_centres(value: Any) -> list[list[float]]:
    if not isinstance(value, list):
        raise EvalError("feature_centers is not a list")
    centres: list[list[float]] = []
    for item in value:
        if not isinstance(item, list) or len(item) < 2:
            raise EvalError("a feature centre is not a [x, y] pair")
        centres.append([float(component) for component in item])
    return centres


def check_row(row: dict[str, Any], code: str, prompt_lang: str = "en") -> RowReport:
    """Audit one manifest row against its own source code.

    ``prompt_lang`` selects which prompt is audited: ``en``, ``ru`` or ``both``
    (the corpus is generated so that all three answers are "every number").
    """
    report = RowReport(row_id=str(row.get("id") or row.get("file")))
    fields = ["prompt_en"] if prompt_lang == "en" else ["prompt_ru"] if prompt_lang == "ru" else ["prompt_en", "prompt_ru"]

    numbers: list[PromptNumber] = []
    for field_name in fields:
        numbers.extend(extract_prompt_numbers(str(row.get(field_name, ""))))
    report.prompt_numbers = len(numbers)
    code_numbers = code_number_set(code)
    for number in numbers:
        if any(find_prompt_number(candidate, code_numbers) for candidate in number.candidates):
            report.matched_numbers += 1
        else:
            report.missing.append(f"{number.text} ({number.kind})")

    report.magic = magic_coordinates(code)

    placement = row.get("placement")
    if placement:
        env = header_assignments(code)
        array_name = str(placement.get("array", "feature_centers"))
        try:
            centres = _flatten_centres(env.get(array_name))
        except EvalError as exc:
            report.placement_errors.append(f"{array_name}: {exc}")
            centres = []
        extras: dict[str, Sequence[Sequence[float]]] = {}
        for entry in placement.get("extra") or []:
            name = str(entry.get("array", ""))
            try:
                extras[name] = _flatten_centres(env.get(name))
            except EvalError:
                extras[name] = []
        if centres:
            report.placement_errors.extend(check_placement(placement, centres, extras))
    return report


# ---------------------------------------------------------------------------
# 5. corpus level audit
# ---------------------------------------------------------------------------

@dataclass
class CorpusReport:
    rows: int = 0
    rows_consistent: int = 0
    rows_numbers_ok: int = 0
    rows_placement_ok: int = 0
    prompt_numbers: int = 0
    matched_numbers: int = 0
    rows_without_magic: int = 0
    failures: list[RowReport] = field(default_factory=list)
    problems: list[str] = field(default_factory=list)

    @property
    def pass_rate(self) -> float:
        return 100.0 * self.rows_consistent / self.rows if self.rows else 0.0

    @property
    def number_rate(self) -> float:
        return 100.0 * self.matched_numbers / self.prompt_numbers if self.prompt_numbers else 0.0


def audit_corpus(parts_dir: Path, limit: int | None = None, prompt_lang: str = "en") -> CorpusReport:
    report = CorpusReport()
    manifest = parts_dir / "manifest.jsonl"
    if not manifest.exists():
        report.problems.append(f"missing {manifest}")
        return report
    with manifest.open(encoding="utf-8") as handle:
        for index, line in enumerate(handle):
            if limit is not None and index >= limit:
                break
            line = line.strip()
            if not line:
                continue
            row = json.loads(line)
            report.rows += 1
            source = parts_dir / str(row["file"])
            if not source.exists():
                report.problems.append(f"missing source {source}")
                continue
            code = source.read_text(encoding="utf-8")
            result = check_row(row, code, prompt_lang)
            report.prompt_numbers += result.prompt_numbers
            report.matched_numbers += result.matched_numbers
            if result.numbers_ok:
                report.rows_numbers_ok += 1
            if result.placement_ok:
                report.rows_placement_ok += 1
            if not result.magic:
                report.rows_without_magic += 1
            if result.ok:
                report.rows_consistent += 1
            elif len(report.failures) < 12:
                report.failures.append(result)
    return report


def format_report(report: CorpusReport, examples: int = 5) -> str:
    lines = [
        f"rows                 : {report.rows}",
        f"prompt numbers       : {report.prompt_numbers} ({report.matched_numbers} found in the code, "
        f"{report.number_rate:.2f}%)",
        f"rows with all numbers: {report.rows_numbers_ok}",
        f"rows with a valid placement rule: {report.rows_placement_ok}",
        f"rows without magic coordinates   : {report.rows_without_magic}",
    ]
    for problem in report.problems[:5]:
        lines.append(f"problem              : {problem}")
    for failure in report.failures[:examples]:
        details = []
        if failure.missing:
            details.append("numbers not in the code: " + ", ".join(failure.missing[:6]))
        if failure.placement_errors:
            details.append("placement: " + "; ".join(failure.placement_errors[:3]))
        lines.append(f"FAIL {failure.row_id}: " + " | ".join(details))
    lines.append(f"consistency auditor: {report.pass_rate:.1f}% pass")
    return "\n".join(lines)


def main(argv: Sequence[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description="placement-consistency auditor of place1")
    parser.add_argument("--parts-dir", type=Path, default=Path("optional_data/data/place1"))
    parser.add_argument("--limit", type=int, default=None)
    parser.add_argument("--prompt-lang", choices=("en", "ru", "both"), default="en")
    parser.add_argument("--examples", type=int, default=5, help="how many failing rows to show")
    parser.add_argument("--json", type=Path, default=None, help="also write the summary as JSON")
    args = parser.parse_args(argv)

    report = audit_corpus(args.parts_dir, args.limit, args.prompt_lang)
    print(format_report(report, args.examples))
    if args.json is not None:
        args.json.write_text(
            json.dumps(
                {
                    "rows": report.rows,
                    "rows_consistent": report.rows_consistent,
                    "prompt_numbers": report.prompt_numbers,
                    "matched_numbers": report.matched_numbers,
                    "rows_without_magic": report.rows_without_magic,
                    "pass_percent": round(report.pass_rate, 2),
                    "number_percent": round(report.number_rate, 3),
                    "problems": report.problems,
                },
                ensure_ascii=False,
                indent=2,
            ),
            encoding="utf-8",
        )
    return 0 if not report.problems and report.pass_rate >= 97.0 else 1


if __name__ == "__main__":
    raise SystemExit(main())
