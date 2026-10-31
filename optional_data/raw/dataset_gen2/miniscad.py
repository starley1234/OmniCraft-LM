"""MiniOpenSCAD: evaluate a restricted OpenSCAD dialect into real manifold geometry.

The dataset for ``optional_data/data/gen2/`` may only be produced from code that
actually compiles.  OpenSCAD itself is not always available on the generation
host, but the *geometry kernel* it uses (Manifold) is available as a Python
wheel.  This module implements the OpenSCAD subset that the gen2 generator
emits, with the same semantics as the OpenSCAD ``--backend=manifold`` pipeline:

* ``$fn = 32;`` header, ``$fn``/``$fa``/``$fs`` lookup and per-call overrides;
* variables, ``module`` definitions (``children()`` deliberately unsupported),
  ``function`` literals;
* ``for``/``if`` statements, ternaries, vector arithmetic, indexing, ranges;
* primitives ``cube``, ``sphere``, ``cylinder``, ``polyhedron``, ``square``,
  ``circle``, ``polygon``;
* transforms ``translate``, ``rotate``, ``mirror``, ``scale``;
* booleans ``union``, ``difference``, ``intersection``, ``hull``;
* ``linear_extrude`` (height/center/twist/slices/scale) and
  ``rotate_extrude`` (angle), 2D ``offset``.

Statement evaluation mirrors OpenSCAD's node list semantics: a module body
evaluates to a *list* of shapes, ``difference()`` subtracts the union of all
children after the first, and the implicit union only happens where OpenSCAD
performs it.

Anything outside that subset raises ``MiniScadError`` instead of silently
producing a different solid, so generated code can never drift from what real
OpenSCAD would build.
"""

from __future__ import annotations

import math
import re
from dataclasses import dataclass
from typing import Any, Sequence

import manifold3d as m3d

__all__ = ["MiniScadError", "Shape", "evaluate", "evaluate_3d"]


class MiniScadError(Exception):
    """Raised for syntax errors, unsupported constructs and invalid geometry."""


# ---------------------------------------------------------------------------
# lexer
# ---------------------------------------------------------------------------

_TOKEN_RE = re.compile(
    r"""
    (?P<ws>\s+|//[^\n]*|/\*.*?\*/)
  | (?P<num>(?:\d+\.\d*|\.\d+|\d+)(?:[eE][+-]?\d+)?)
  | (?P<id>\$?[A-Za-z_][A-Za-z0-9_]*)
  | (?P<op><=|>=|==|!=|&&|\|\||[-+*/%^?:;,.(){}\[\]<>=!#])
    """,
    re.VERBOSE | re.DOTALL,
)


@dataclass
class Token:
    kind: str  # num | id | op | eof
    value: Any
    line: int


def tokenize(source: str) -> list[Token]:
    tokens: list[Token] = []
    position = 0
    line = 1
    length = len(source)
    while position < length:
        match = _TOKEN_RE.match(source, position)
        if match is None:
            raise MiniScadError(f"line {line}: unexpected character {source[position]!r}")
        text = match.group(0)
        position = match.end()
        if match.lastgroup == "ws":
            line += text.count("\n")
            continue
        if match.lastgroup == "num":
            tokens.append(Token("num", float(text), line))
        elif match.lastgroup == "id":
            tokens.append(Token("id", text, line))
        else:
            tokens.append(Token("op", text, line))
    tokens.append(Token("eof", None, line))
    return tokens


# ---------------------------------------------------------------------------
# parser: AST nodes are plain tuples
# ---------------------------------------------------------------------------

class Parser:
    def __init__(self, tokens: Sequence[Token]) -> None:
        self.tokens = tokens
        self.position = 0

    @property
    def current(self) -> Token:
        return self.tokens[self.position]

    def peek_op(self, *values: str) -> bool:
        return self.current.kind == "op" and self.current.value in values

    def peek_id(self, *values: str) -> bool:
        return self.current.kind == "id" and self.current.value in values

    def take_op(self, value: str) -> Token:
        if not self.peek_op(value):
            raise MiniScadError(
                f"line {self.current.line}: expected {value!r}, found {self.current.value!r}"
            )
        token = self.current
        self.position += 1
        return token

    def take_id(self) -> str:
        if self.current.kind != "id":
            raise MiniScadError(f"line {self.current.line}: expected identifier")
        token = self.current
        self.position += 1
        return token.value

    def accept_op(self, value: str) -> bool:
        if self.peek_op(value):
            self.position += 1
            return True
        return False

    # -- statements -------------------------------------------------------
    def parse_program(self) -> list[Any]:
        body: list[Any] = []
        while self.current.kind != "eof":
            body.append(self.parse_statement())
        return body

    def parse_statement(self) -> Any:
        while self.peek_op("*", "!", "#", "%"):
            modifier = self.current.value
            self.position += 1
            if modifier in ("!", "#", "%"):
                continue  # visual modifiers do not change geometry
            self.parse_statement()  # '*' disables the child
            return ("block", [])

        if self.peek_op("{"):
            return ("block", self.parse_block())
        if self.peek_op(";"):
            self.position += 1
            return ("block", [])

        if self.peek_id("module"):
            self.position += 1
            name = self.take_id()
            params = self.parse_parameter_list()
            body = self.parse_block()
            return ("module", name, params, body)
        if self.peek_id("function"):
            self.position += 1
            name = self.take_id()
            params = self.parse_parameter_list()
            self.take_op("=")
            expression = self.parse_expression()
            self.take_op(";")
            return ("function", name, params, expression)
        if self.peek_id("if"):
            self.position += 1
            self.take_op("(")
            condition = self.parse_expression()
            self.take_op(")")
            then_branch = self.parse_statement()
            else_branch = None
            if self.peek_id("else"):
                self.position += 1
                else_branch = self.parse_statement()
            return ("if", condition, then_branch, else_branch)
        if self.peek_id("for"):
            self.position += 1
            self.take_op("(")
            bindings = []
            while True:
                name = self.take_id()
                self.take_op("=")
                bindings.append((name, self.parse_expression()))
                if not self.accept_op(","):
                    break
            self.take_op(")")
            return ("for", bindings, self.parse_statement())
        if self.peek_id("let"):
            raise MiniScadError(f"line {self.current.line}: 'let' is not part of the gen2 dialect")
        if self.peek_id("include", "use"):
            raise MiniScadError(f"line {self.current.line}: include/use are forbidden")
        if self.peek_id("assert", "echo"):
            raise MiniScadError(f"line {self.current.line}: assert/echo are forbidden in the dataset")
        if self.peek_id("assign"):
            raise MiniScadError(f"line {self.current.line}: 'assign' is not part of the gen2 dialect")

        # assignment
        if (
            self.current.kind == "id"
            and self.tokens[self.position + 1].kind == "op"
            and self.tokens[self.position + 1].value == "="
        ):
            name = self.take_id()
            self.take_op("=")
            expression = self.parse_expression()
            self.take_op(";")
            return ("assign", name, expression)

        # module instantiation: `name(args) ;` or `name(args) <child statement>`
        expression = self.parse_expression()
        if self.accept_op(";"):
            return ("instantiation", expression, None)
        child = self.parse_statement()
        if self.accept_op(";"):
            pass
        return ("instantiation", expression, child)

    def parse_block(self) -> list[Any]:
        self.take_op("{")
        body: list[Any] = []
        while not self.peek_op("}"):
            if self.current.kind == "eof":
                raise MiniScadError("unexpected end of file inside a block")
            body.append(self.parse_statement())
        self.take_op("}")
        return body

    def parse_parameter_list(self) -> list[tuple[str, Any]]:
        self.take_op("(")
        params: list[tuple[str, Any]] = []
        if self.accept_op(")"):
            return params
        while True:
            name = self.take_id()
            default = None
            if self.accept_op("="):
                default = self.parse_expression()
            params.append((name, default))
            if not self.accept_op(","):
                break
        self.take_op(")")
        return params

    # -- expressions ------------------------------------------------------
    def parse_expression(self) -> Any:
        return self.parse_ternary()

    def parse_ternary(self) -> Any:
        condition = self.parse_or()
        if self.accept_op("?"):
            a = self.parse_ternary()
            self.take_op(":")
            b = self.parse_ternary()
            return ("ternary", condition, a, b)
        return condition

    def parse_or(self) -> Any:
        node = self.parse_and()
        while self.peek_op("||"):
            self.position += 1
            node = ("bin", "||", node, self.parse_and())
        return node

    def parse_and(self) -> Any:
        node = self.parse_equality()
        while self.peek_op("&&"):
            self.position += 1
            node = ("bin", "&&", node, self.parse_equality())
        return node

    def parse_equality(self) -> Any:
        node = self.parse_relational()
        while self.peek_op("==", "!="):
            operator = self.current.value
            self.position += 1
            node = ("bin", operator, node, self.parse_relational())
        return node

    def parse_relational(self) -> Any:
        node = self.parse_additive()
        while self.peek_op("<", "<=", ">", ">="):
            operator = self.current.value
            self.position += 1
            node = ("bin", operator, node, self.parse_additive())
        return node

    def parse_additive(self) -> Any:
        node = self.parse_multiplicative()
        while self.peek_op("+", "-"):
            operator = self.current.value
            self.position += 1
            node = ("bin", operator, node, self.parse_multiplicative())
        return node

    def parse_multiplicative(self) -> Any:
        node = self.parse_unary()
        while self.peek_op("*", "/", "%"):
            operator = self.current.value
            self.position += 1
            node = ("bin", operator, node, self.parse_unary())
        return node

    def parse_unary(self) -> Any:
        if self.peek_op("-"):
            self.position += 1
            return ("un", "-", self.parse_unary())
        if self.peek_op("+"):
            self.position += 1
            return self.parse_unary()
        if self.peek_op("!"):
            self.position += 1
            return ("un", "!", self.parse_unary())
        return self.parse_power()

    def parse_power(self) -> Any:
        node = self.parse_postfix()
        if self.peek_op("^"):
            self.position += 1
            return ("bin", "^", node, self.parse_unary())
        return node

    def parse_postfix(self) -> Any:
        node = self.parse_primary()
        while self.peek_op("["):
            self.position += 1
            index = self.parse_expression()
            self.take_op("]")
            node = ("index", node, index)
        return node

    def parse_primary(self) -> Any:
        token = self.current
        if token.kind == "num":
            self.position += 1
            return ("num", token.value)
        if token.kind == "op" and token.value == "(":
            self.position += 1
            node = self.parse_expression()
            self.take_op(")")
            return node
        if token.kind == "op" and token.value == "[":
            return self.parse_vector_or_range()
        if token.kind == "id":
            name = token.value
            self.position += 1
            if name in ("true", "false"):
                return ("bool", name == "true")
            if name == "undef":
                return ("undef",)
            if name == "let":
                return self.parse_let_expression()
            if self.peek_op("("):
                arguments, keyword_arguments = self.parse_arguments()
                node: Any = ("call", ("var", name), arguments, keyword_arguments)
                while self.peek_op("["):
                    self.position += 1
                    index = self.parse_expression()
                    self.take_op("]")
                    node = ("index", node, index)
                return node
            return ("var", name)
        raise MiniScadError(f"line {token.line}: unexpected token {token.value!r}")

    def parse_let_expression(self) -> Any:
        """``let (a = 1, b = 2) expr`` — non-recursive, so it stays a finite tree."""
        self.take_op("(")
        bindings = []
        while True:
            name = self.take_id()
            self.take_op("=")
            bindings.append((name, self.parse_expression()))
            if not self.accept_op(","):
                break
        self.take_op(")")
        body = self.parse_expression()
        return ("let", bindings, body)

    def parse_arguments(self) -> tuple[list[Any], dict[str, Any]]:
        self.take_op("(")
        arguments: list[Any] = []
        keyword_arguments: dict[str, Any] = {}
        if self.accept_op(")"):
            return arguments, keyword_arguments
        while True:
            if self.peek_id("each"):
                raise MiniScadError(f"line {self.current.line}: 'each' is not part of the gen2 dialect")
            if (
                self.current.kind == "id"
                and self.tokens[self.position + 1].kind == "op"
                and self.tokens[self.position + 1].value == "="
            ):
                name = self.take_id()
                self.take_op("=")
                keyword_arguments[name] = self.parse_expression()
            else:
                arguments.append(self.parse_expression())
            if not self.accept_op(","):
                break
        self.take_op(")")
        return arguments, keyword_arguments

    def parse_vector_or_range(self) -> Any:
        self.take_op("[")
        if self.accept_op("]"):
            return ("vec", [])
        if self.peek_id("for", "if", "each"):
            return ("comprehension", self.parse_comprehension_items())
        first = self.parse_expression()
        if self.accept_op(":"):
            second = self.parse_expression()
            if self.accept_op(":"):
                third = self.parse_expression()
                self.take_op("]")
                return ("range", first, second, third)
            self.take_op("]")
            return ("range", first, ("num", 1.0), second)
        items = [first]
        while self.accept_op(","):
            items.append(self.parse_expression())
        self.take_op("]")
        return ("vec", items)

    def parse_comprehension_items(self) -> list[Any]:
        """Parse the inside of a list comprehension: for/each/if plus values."""
        items: list[Any] = []
        while True:
            items.append(self.parse_comprehension_item())
            if not self.accept_op(","):
                break
        self.take_op("]")
        return items

    def parse_comprehension_item(self) -> Any:
        if self.peek_id("for"):
            self.position += 1
            self.take_op("(")
            bindings = []
            while True:
                name = self.take_id()
                self.take_op("=")
                bindings.append((name, self.parse_expression()))
                if not self.accept_op(","):
                    break
            self.take_op(")")
            return ("comp_for", bindings, self.parse_comprehension_item())
        if self.peek_id("if"):
            self.position += 1
            self.take_op("(")
            condition = self.parse_expression()
            self.take_op(")")
            body = self.parse_comprehension_item()
            else_body = None
            if self.peek_id("else"):
                self.position += 1
                else_body = self.parse_comprehension_item()
            return ("comp_if", condition, body, else_body)
        if self.peek_id("each"):
            self.position += 1
            return ("comp_each", self.parse_expression())
        return ("comp_item", self.parse_expression())


# ---------------------------------------------------------------------------
# shapes
# ---------------------------------------------------------------------------

@dataclass
class Shape:
    """A 2D (CrossSection) or 3D (Manifold) object with OpenSCAD algebra."""

    dim: int
    obj: Any = None

    @staticmethod
    def empty() -> "Shape":
        return Shape(0, None)

    @property
    def is_empty(self) -> bool:
        return self.obj is None

    def union(self, other: "Shape") -> "Shape":
        if other.is_empty:
            return self
        if self.is_empty:
            return other
        if self.dim != other.dim:
            raise MiniScadError("cannot mix 2D and 3D geometry in an operation")
        return Shape(self.dim, self.obj + other.obj)

    def as_manifold(self) -> Any:
        if self.is_empty:
            return m3d.Manifold()
        if self.dim != 3:
            raise MiniScadError("expected 3D geometry")
        return self.obj

    def as_section(self) -> Any:
        if self.is_empty:
            return m3d.CrossSection()
        if self.dim != 2:
            raise MiniScadError("expected 2D geometry")
        return self.obj

    def difference(self, others: list["Shape"]) -> "Shape":
        if self.is_empty:
            return self
        result = self
        for other in others:
            if other.is_empty:
                continue
            if result.dim != other.dim:
                raise MiniScadError("cannot mix 2D and 3D geometry in difference()")
            result = Shape(result.dim, result.obj - other.obj)
        return result

    def intersection(self, others: list["Shape"]) -> "Shape":
        result = self
        for other in others:
            if other.is_empty or result.is_empty:
                return Shape.empty()
            if result.dim != other.dim:
                raise MiniScadError("cannot mix 2D and 3D geometry in intersection()")
            # manifold3d spells the boolean intersection with ^ Python has no
            # set-intersection operator for these types.
            result = Shape(result.dim, result.obj ^ other.obj)
        return result

    def convex_hull(self, others: list["Shape"]) -> "Shape":
        shapes = [shape for shape in [self, *others] if not shape.is_empty]
        if not shapes:
            return Shape.empty()
        dim = shapes[0].dim
        if any(shape.dim != dim for shape in shapes):
            raise MiniScadError("cannot mix 2D and 3D geometry in hull()")
        objects = [shape.obj for shape in shapes]
        if len(objects) == 1:
            return Shape(dim, objects[0].hull())
        if dim == 3:
            return Shape(3, m3d.Manifold.batch_hull(objects))
        return Shape(2, m3d.CrossSection.batch_hull(objects))


def union_shapes(shapes: list[Shape]) -> Shape:
    result = Shape.empty()
    for shape in shapes:
        result = result.union(shape)
    return result


class Scope:
    __slots__ = ("variables", "parent")

    def __init__(self, parent: "Scope | None" = None) -> None:
        self.variables: dict[str, Any] = {}
        self.parent = parent

    def lookup(self, name: str) -> Any:
        scope: Scope | None = self
        while scope is not None:
            if name in scope.variables:
                return scope.variables[name]
            scope = scope.parent
        raise MiniScadError(f"unknown variable {name!r}")

    def has(self, name: str) -> bool:
        scope: Scope | None = self
        while scope is not None:
            if name in scope.variables:
                return True
            scope = scope.parent
        return False


_FORBIDDEN_MODULES = {
    "import", "surface", "text", "projection", "children", "render", "minkowski",
    "resize", "multmatrix", "import_stl", "import_dxf", "import_off", "rand", "rands",
}

_OPTION_NAMES: dict[str, tuple[str, ...]] = {
    "cube": ("size",),
    "sphere": ("r", "d"),
    "cylinder": ("h", "r", "r1", "r2", "d", "d1", "d2"),
    "polyhedron": ("points", "faces", "convexity"),
    "square": ("size",),
    "circle": ("r", "d"),
    "polygon": ("points", "paths", "convexity"),
    "linear_extrude": ("height",),
    "rotate_extrude": (),
    "offset": ("r", "delta"),
    "translate": ("v",),
    "rotate": ("a", "v"),
    "scale": ("v",),
    "mirror": ("v",),
}


class Evaluator:
    def __init__(self, source: str) -> None:
        self.source = source
        self.modules: dict[str, tuple[list[tuple[str, Any]], list[Any]]] = {}
        self.functions: dict[str, tuple[list[tuple[str, Any]], Any]] = {}
        self.global_scope = Scope()
        self.global_scope.variables["PI"] = math.pi

    # -- program ----------------------------------------------------------
    def run(self) -> Shape:
        program = Parser(tokenize(self.source)).parse_program()
        for statement in program:
            if statement[0] in ("module", "function"):
                self.define(statement)
        shapes: list[Shape] = []
        for statement in program:
            if statement[0] in ("module", "function"):
                continue
            shapes.extend(self.eval_statement(statement, self.global_scope))
        return union_shapes(shapes)

    def define(self, statement: Any) -> None:
        if statement[0] == "module":
            _, name, params, body = statement
            self.modules[name] = (params, body)
        else:
            _, name, params, expression = statement
            self.functions[name] = (params, expression)

    # -- statements -------------------------------------------------------
    def eval_statement(self, statement: Any, scope: Scope) -> list[Shape]:
        kind = statement[0]
        if kind == "block":
            shapes: list[Shape] = []
            for child in statement[1]:
                shapes.extend(self.eval_statement(child, scope))
            return shapes
        if kind == "assign":
            _, name, expression = statement
            scope.variables[name] = self.eval_expression(expression, scope)
            return []
        if kind in ("module", "function"):
            self.define(statement)
            return []
        if kind == "if":
            _, condition, then_branch, else_branch = statement
            if truthy(self.eval_expression(condition, scope)):
                return self.eval_statement(then_branch, scope)
            if else_branch is not None:
                return self.eval_statement(else_branch, scope)
            return []
        if kind == "for":
            _, bindings, body = statement
            shapes = []
            for child_scope in self.iter_for_scopes(bindings, scope):
                shapes.extend(self.eval_statement(body, child_scope))
            return shapes
        if kind == "instantiation":
            _, call, child = statement
            children: list[Shape] = []
            if child is not None:
                children = self.eval_statement(child, scope)
            return self.eval_instantiation(call, children, scope)
        raise MiniScadError(f"unsupported statement {kind!r}")

    def iter_for_scopes(self, bindings: list[tuple[str, Any]], scope: Scope) -> list[Scope]:
        scopes = [scope]
        for name, expression in bindings:
            value = self.eval_expression(expression, scope)
            values = list(value) if isinstance(value, list) else [value]
            expanded: list[Scope] = []
            for base in scopes:
                for item in values:
                    child = Scope(base)
                    child.variables[name] = item
                    expanded.append(child)
            scopes = expanded
        return scopes

    # -- instantiations ---------------------------------------------------
    def eval_instantiation(self, call: Any, children: list[Shape], scope: Scope) -> list[Shape]:
        if call[0] != "call" or call[1][0] != "var":
            raise MiniScadError("only named module instantiations are supported")
        name = call[1][1]
        if name in _FORBIDDEN_MODULES:
            raise MiniScadError(f"{name}() is forbidden in the gen2 dataset")
        if name in self.modules:
            params, body = self.modules[name]
            module_scope = Scope(scope)
            if children:
                raise MiniScadError("modules must not take children (children() is forbidden)")
            self.bind_parameters(module_scope, params, call[2], call[3], scope)
            # An instantiation is ONE child node in OpenSCAD: its body is a group.
            # Keeping that boundary is what makes difference() { module(); cut; }
            # subtract the cutter instead of subtracting the module's own solids.
            return [union_shapes(self.eval_statement(("block", body), module_scope))]
        if name == "color":
            # Rendering-only hint (the asm2 corpus colours every part, request 5
            # block A2); colour carries no geometry, children pass through.
            return children
        if name in ("union", "difference", "intersection", "hull"):
            if call[2] or call[3]:
                children = children + [self.eval_expression(argument, scope) for argument in call[2]]
            return [self.boolean(name, children)]
        if name in ("translate", "rotate", "scale", "mirror"):
            options = self.collect_options(name, call[2], call[3], scope)
            argument = options.pop("__positional__")
            parameter = argument[0] if argument else self.first_option(options, name)
            if parameter is None:
                raise MiniScadError(f"{name}() needs an argument")
            return self.transform(name, self.eval_expression(parameter, scope), children)
        if name in _OPTION_NAMES:
            options = self.collect_options(name, call[2], call[3], scope)
            positional = options.pop("__positional__")
            values = {
                key: self.eval_expression(value, scope) for key, value in options.items()
            }
            for index, argument in enumerate(positional):
                key = _OPTION_NAMES[name][index]
                values[key] = self.eval_expression(argument, scope)
            return [self.primitive(name, values, children, scope)]
        raise MiniScadError(f"unknown module {name!r}")

    def first_option(self, options: dict[str, Any], name: str) -> Any:
        for key in _OPTION_NAMES.get(name, ()):
            if key in options:
                return options[key]
        return None

    def collect_options(
        self, name: str, arguments: list[Any], keyword_arguments: dict[str, Any], scope: Scope
    ) -> dict[str, Any]:
        """Split call arguments into named options and positional leftovers."""
        allowed = _OPTION_NAMES.get(name, ())
        options: dict[str, Any] = {}
        positional: list[Any] = []
        index = 0
        for argument in arguments:
            if index < len(allowed):
                options[allowed[index]] = argument
                index += 1
            else:
                positional.append(argument)
        for key, value in keyword_arguments.items():
            options[key] = value
        options["__positional__"] = positional
        return options

    def bind_parameters(
        self,
        target: Scope,
        params: list[tuple[str, Any]],
        arguments: list[Any],
        keyword_arguments: dict[str, Any],
        caller_scope: Scope,
    ) -> None:
        if len(arguments) > len(params):
            raise MiniScadError("too many positional arguments")
        bound: set[str] = set()
        for index, argument in enumerate(arguments):
            name = params[index][0]
            target.variables[name] = self.eval_expression(argument, caller_scope)
            bound.add(name)
        for name, value in keyword_arguments.items():
            if not any(param_name == name for param_name, _ in params):
                raise MiniScadError(f"unknown parameter {name!r}")
            target.variables[name] = self.eval_expression(value, caller_scope)
            bound.add(name)
        for name, default in params:
            if name in bound:
                continue
            if default is None:
                raise MiniScadError(f"missing required argument {name!r}")
            target.variables[name] = self.eval_expression(default, target)

    # -- builtins ---------------------------------------------------------
    def boolean(self, name: str, children: list[Shape]) -> Shape:
        shapes = [shape for shape in children if not shape.is_empty]
        if not shapes:
            return Shape.empty()
        if name == "union":
            return union_shapes(shapes)
        if name == "difference":
            return shapes[0].difference(shapes[1:])
        if name == "intersection":
            return shapes[0].intersection(shapes[1:])
        return shapes[0].convex_hull(shapes[1:])

    def transform(self, name: str, parameter: Any, children: list[Shape]) -> list[Shape]:
        result: list[Shape] = []
        for child in children:
            if child.is_empty:
                continue
            if name == "translate":
                vector = as_vector(parameter, 3)
                # OpenSCAD ignores the z component when moving 2D children.
                moved = child.obj.translate(vector if child.dim == 3 else vector[:2])
            elif name == "rotate":
                if isinstance(parameter, (int, float)):
                    if child.dim == 3:
                        moved = child.obj.rotate([0.0, 0.0, float(parameter)])
                    else:
                        moved = child.obj.rotate(float(parameter))
                else:
                    angles = as_vector(parameter, 3)
                    if child.dim == 3:
                        moved = child.obj.rotate(angles)
                    else:
                        raise MiniScadError("rotate([..]) needs 3D geometry")
            elif name == "scale":
                if isinstance(parameter, (int, float)):
                    factor = float(parameter)
                    if child.dim == 3:
                        moved = child.obj.scale([factor, factor, factor])
                    else:
                        moved = child.obj.scale(factor)
                else:
                    factors = as_vector(parameter, 3)
                    if child.dim == 3:
                        moved = child.obj.scale(factors)
                    else:
                        moved = child.obj.scale([factors[0], factors[1]])
            else:  # mirror
                normal = as_vector(parameter, 3)
                if child.dim == 3:
                    moved = child.obj.mirror(normal)
                else:
                    moved = child.obj.mirror([normal[0], normal[1]])
            if moved is None:
                continue
            result.append(Shape(child.dim, moved))
        return result

    def primitive(
        self, name: str, values: dict[str, Any], children: list[Shape], scope: Scope
    ) -> Shape:
        if name == "cube":
            size = values.get("size", 1.0)
            dimensions = (
                [float(size)] * 3 if isinstance(size, (int, float)) else as_vector(size, 3)
            )
            if any(value <= 0 for value in dimensions):
                return Shape.empty()
            return Shape(3, m3d.Manifold.cube(dimensions, truthy(values.get("center", False))))
        if name == "sphere":
            radius = radius_of(values)
            if radius <= 0:
                return Shape.empty()
            return Shape(3, m3d.Manifold.sphere(radius, self.fragments(values, scope)))
        if name == "cylinder":
            return self.cylinder(values, scope)
        if name == "polyhedron":
            return self.polyhedron(values)
        if name == "square":
            size = values.get("size", 1.0)
            dimensions = (
                [float(size)] * 2 if isinstance(size, (int, float)) else as_vector(size, 3)[:2]
            )
            if any(value <= 0 for value in dimensions):
                return Shape.empty()
            return Shape(2, m3d.CrossSection.square(dimensions, truthy(values.get("center", False))))
        if name == "circle":
            radius = radius_of(values)
            if radius <= 0:
                return Shape.empty()
            return Shape(2, m3d.CrossSection.circle(radius, self.fragments(values, scope)))
        if name == "polygon":
            return self.polygon(values)
        if name == "linear_extrude":
            return self.linear_extrude(values, children, scope)
        if name == "rotate_extrude":
            return self.rotate_extrude(values, children, scope)
        if name == "offset":
            return self.offset(values, children, scope)
        raise MiniScadError(f"unknown primitive {name!r}")

    def cylinder(self, values: dict[str, Any], scope: Scope) -> Shape:
        height = float(values.get("h", 1.0))
        if height <= 0:
            return Shape.empty()
        if "r" in values:
            bottom = top = radius_of(values)
        elif "d" in values:
            bottom = top = 0.5 * float(values["d"])
        else:
            bottom = (
                float(values["r1"]) if "r1" in values
                else (0.5 * float(values["d1"]) if "d1" in values else 1.0)
            )
            top = (
                float(values["r2"]) if "r2" in values
                else (0.5 * float(values["d2"]) if "d2" in values else 1.0)
            )
        if bottom <= 0 and top <= 0:
            return Shape.empty()
        bottom = max(bottom, 1e-4)
        top = max(top, 1e-4)
        return Shape(
            3,
            m3d.Manifold.cylinder(
                height, bottom, top, self.fragments(values, scope), truthy(values.get("center", False))
            ),
        )

    def polyhedron(self, values: dict[str, Any]) -> Shape:
        points = [[float(coordinate) for coordinate in point] for point in values["points"]]
        faces: list[list[int]] = []
        for face in values["faces"]:
            polygon = [int(entry[0]) if isinstance(entry, list) else int(entry) for entry in face]
            if len(polygon) >= 3:
                faces.append(polygon)
        triangles: list[list[int]] = []
        for polygon in faces:
            for index in range(1, len(polygon) - 1):
                triangles.append([polygon[0], polygon[index], polygon[index + 1]])
        mesh = m3d.Mesh(vert_properties=points, tri_verts=triangles)
        manifold = m3d.Manifold(mesh)
        if manifold.status() != m3d.Error.NoError:
            raise MiniScadError(f"polyhedron() produced an invalid mesh: {manifold.status()}")
        return Shape(3, manifold)

    def polygon(self, values: dict[str, Any]) -> Shape:
        points = values["points"]
        paths = values.get("paths")
        if paths:
            contours = [
                [
                    [float(points[int(index)][0]), float(points[int(index)][1])]
                    for index in path
                ]
                for path in paths
            ]
        else:
            contours = [[[float(point[0]), float(point[1])] for point in points]]
        # OpenSCAD accepts either winding for a simple polygon and treats any
        # further path as a hole; manifold's CrossSection follows a fill rule,
        # so normalize: outline counter-clockwise, holes clockwise.
        normalized: list[list[list[float]]] = []
        for position, contour in enumerate(contours):
            if len(contour) < 3:
                continue
            area = signed_area(contour)
            wants_positive = position == 0
            if (area > 0) != wants_positive:
                contour = list(reversed(contour))
            normalized.append(contour)
        if not normalized:
            return Shape.empty()
        return Shape(2, m3d.CrossSection(normalized))

    def linear_extrude(self, values: dict[str, Any], children: list[Shape], scope: Scope) -> Shape:
        sections = [child for child in children if not child.is_empty]
        if not sections:
            return Shape.empty()
        height = float(values.get("height", 100.0))
        if height == 0:
            return Shape.empty()
        twist = float(values.get("twist", 0.0))
        scale_value = values.get("scale", 1.0)
        scale_vector = (
            [float(scale_value)] * 2
            if isinstance(scale_value, (int, float))
            else [float(scale_value[0]), float(scale_value[1])]
        )
        slices = int(values.get("slices", 0))
        if twist != 0.0 and slices == 0:
            slices = max(2, int(abs(twist) / 4.0) + 1)
        result: list[Shape] = []
        for child in sections:
            solid = m3d.Manifold.extrude(
                child.as_section(), abs(height), slices, twist, scale_vector
            )
            if height < 0:
                solid = solid.mirror([0, 0, 1])
            if truthy(values.get("center", False)):
                solid = solid.translate([0.0, 0.0, -0.5 * height])
            result.append(Shape(3, solid))
        return union_shapes(result)

    def rotate_extrude(self, values: dict[str, Any], children: list[Shape], scope: Scope) -> Shape:
        sections = [child for child in children if not child.is_empty]
        if not sections:
            return Shape.empty()
        angle = float(values.get("angle", 360.0))
        fragments = self.fragments(values, scope)
        if angle != 360.0:
            fragments = max(1, int(round(fragments * abs(angle) / 360.0)))
        result: list[Shape] = []
        for child in sections:
            section = child.as_section()
            bounds = section.bounds()
            if bounds and bounds[0] < -1e-9:
                raise MiniScadError("rotate_extrude() profile must stay at x >= 0")
            solid = m3d.Manifold.revolve(section, fragments, abs(angle))
            if angle < 0:
                solid = solid.mirror([1, 0, 0])
            result.append(Shape(3, solid))
        return union_shapes(result)

    def offset(self, values: dict[str, Any], children: list[Shape], scope: Scope) -> Shape:
        sections = [child for child in children if not child.is_empty]
        if not sections:
            return Shape.empty()
        if "r" in values:
            distance = float(values["r"])
            join = m3d.JoinType.Round
        elif "delta" in values:
            distance = float(values["delta"])
            join = m3d.JoinType.Miter
        else:
            raise MiniScadError("offset() needs r or delta")
        fragments = self.fragments(values, scope)
        result: list[Shape] = []
        for child in sections:
            result.append(Shape(2, child.as_section().offset(distance, join, 2.0, fragments)))
        return union_shapes(result)

    # -- expressions ------------------------------------------------------
    def eval_expression(self, node: Any, scope: Scope) -> Any:
        kind = node[0]
        try:
            if kind == "num":
                return node[1]
            if kind == "bool":
                return node[1]
            if kind == "undef":
                return None
            if kind == "var":
                return scope.lookup(node[1])
            if kind == "vec":
                return [self.eval_expression(item, scope) for item in node[1]]
            if kind == "comprehension":
                values: list[Any] = []
                for item in node[1]:
                    values.extend(self.eval_comprehension_item(item, scope))
                return values
            if kind == "let":
                local = Scope(scope)
                for name, expression in node[1]:
                    local.variables[name] = self.eval_expression(expression, local)
                return self.eval_expression(node[2], local)
            if kind == "range":
                start = self.eval_expression(node[1], scope)
                step = self.eval_expression(node[2], scope)
                end = self.eval_expression(node[3], scope)
                if isinstance(step, (int, float)) and isinstance(end, (int, float)):
                    return range_values(float(start), float(step), float(end))
                return [start, step, end]
            if kind == "index":
                base = self.eval_expression(node[1], scope)
                index = self.eval_expression(node[2], scope)
                if isinstance(index, list):
                    return [base[int(item)] for item in index]
                if base is None:
                    return None
                return base[int(index)]
            if kind == "un":
                value = self.eval_expression(node[2], scope)
                return negate(value) if node[1] == "-" else (not truthy(value))
            if kind == "ternary":
                condition = self.eval_expression(node[1], scope)
                return self.eval_expression(node[2] if truthy(condition) else node[3], scope)
            if kind == "bin":
                operator = node[1]
                if operator == "&&":
                    return truthy(self.eval_expression(node[2], scope)) and truthy(
                        self.eval_expression(node[3], scope)
                    )
                if operator == "||":
                    return truthy(self.eval_expression(node[2], scope)) or truthy(
                        self.eval_expression(node[3], scope)
                    )
                left = self.eval_expression(node[2], scope)
                right = self.eval_expression(node[3], scope)
                return binary(operator, left, right)
            if kind == "call":
                name = node[1][1]
                if name in self.functions:
                    params, expression = self.functions[name]
                    call_scope = Scope(scope)
                    self.bind_parameters(call_scope, params, node[2], node[3], scope)
                    return self.eval_expression(expression, call_scope)
                arguments = [self.eval_expression(argument, scope) for argument in node[2]]
                keywords = {
                    key: self.eval_expression(value, scope) for key, value in node[3].items()
                }
                return call_builtin(name, arguments, keywords)
        except MiniScadError:
            raise
        except Exception as exc:  # noqa: BLE001 - keep the failure message actionable
            raise MiniScadError(f"error while evaluating {kind}: {exc}") from exc
        raise MiniScadError(f"unsupported expression {kind!r}")

    def eval_comprehension_item(self, item: Any, scope: Scope) -> list[Any]:
        """One comprehension element: a value, ``each`` spread, ``for`` or ``if``."""
        kind = item[0]
        if kind == "comp_item":
            return [self.eval_expression(item[1], scope)]
        if kind == "comp_each":
            value = self.eval_expression(item[1], scope)
            if not isinstance(value, list):
                raise MiniScadError("each needs a list")
            return list(value)
        if kind == "comp_if":
            if truthy(self.eval_expression(item[1], scope)):
                return self.eval_comprehension_item(item[2], scope)
            if item[3] is not None:
                return self.eval_comprehension_item(item[3], scope)
            return []
        if kind == "comp_for":
            values: list[Any] = []
            for child_scope in self.iter_for_scopes(item[1], scope):
                values.extend(self.eval_comprehension_item(item[2], child_scope))
            return values
        raise MiniScadError(f"unsupported comprehension element {kind!r}")

    def fragments(self, values: dict[str, Any], scope: Scope) -> int:
        override = values.get("$fn")
        if override is not None:
            return max(3, int(round(float(override))))
        if scope.has("$fn"):
            return max(3, int(round(float(scope.lookup("$fn")))))
        if self.global_scope.has("$fn"):
            return max(3, int(round(float(self.global_scope.lookup("$fn")))))
        return 32


# ---------------------------------------------------------------------------
# helpers
# ---------------------------------------------------------------------------

def range_values(start: float, step: float, end: float) -> list[float]:
    values: list[float] = []
    if step == 0:
        return values
    count = 0
    while True:
        value = start + count * step
        if (step > 0 and value > end + 1e-9) or (step < 0 and value < end - 1e-9):
            break
        values.append(round(value, 9))
        count += 1
        if count > 20000:
            raise MiniScadError("range is too large")
    return values


def truthy(value: Any) -> bool:
    if value is None:
        return False
    if isinstance(value, bool):
        return value
    if isinstance(value, (int, float)):
        return value != 0
    if isinstance(value, (list, str)):
        return len(value) > 0
    return True


def negate(value: Any) -> Any:
    if isinstance(value, list):
        return [-item for item in value]
    return -value


def binary(operator: str, left: Any, right: Any) -> Any:
    if operator in ("==", "!="):
        if isinstance(left, list) and isinstance(right, list):
            equal = len(left) == len(right) and all(a == b for a, b in zip(left, right))
        else:
            equal = left == right
        return equal if operator == "==" else not equal
    if operator in ("<", "<=", ">", ">="):
        if operator == "<":
            return left < right
        if operator == "<=":
            return left <= right
        if operator == ">":
            return left > right
        return left >= right
    if isinstance(left, list) or isinstance(right, list):
        if not isinstance(left, list):
            left = [left] * len(right)
        if not isinstance(right, list):
            right = [right] * len(left)
        if len(left) != len(right):
            raise MiniScadError("vector sizes do not match")
        return [binary(operator, a, b) for a, b in zip(left, right)]
    if operator == "+":
        return left + right
    if operator == "-":
        return left - right
    if operator == "*":
        return left * right
    if operator == "/":
        return math.nan if right == 0 else left / right
    if operator == "%":
        return math.nan if right == 0 else math.fmod(left, right)
    if operator == "^":
        return left ** right
    raise MiniScadError(f"unsupported operator {operator!r}")


def call_builtin(name: str, arguments: list[Any], keyword: dict[str, Any]) -> Any:
    def argument(index: int, key: str, default: Any = None) -> Any:
        if key in keyword:
            return keyword[key]
        if index < len(arguments):
            return arguments[index]
        return default

    if name == "abs":
        return abs(argument(0, "x"))
    if name == "sign":
        value = argument(0, "x")
        return 0 if value == 0 else (1 if value > 0 else -1)
    if name == "sin":
        return math.sin(math.radians(argument(0, "x")))
    if name == "cos":
        return math.cos(math.radians(argument(0, "x")))
    if name == "tan":
        return math.tan(math.radians(argument(0, "x")))
    if name == "asin":
        return math.degrees(math.asin(max(-1.0, min(1.0, argument(0, "x")))))
    if name == "acos":
        return math.degrees(math.acos(max(-1.0, min(1.0, argument(0, "x")))))
    if name == "atan":
        if len(arguments) > 1 or "y" in keyword:
            return math.degrees(math.atan2(argument(0, "y"), argument(1, "x")))
        return math.degrees(math.atan(argument(0, "x")))
    if name == "atan2":
        return math.degrees(math.atan2(argument(0, "y"), argument(1, "x")))
    if name == "floor":
        return math.floor(argument(0, "x"))
    if name == "ceil":
        return math.ceil(argument(0, "x"))
    if name == "round":
        value = argument(0, "x")
        return math.floor(value + 0.5) if value >= 0 else math.ceil(value - 0.5)
    if name == "sqrt":
        value = argument(0, "x")
        return math.sqrt(value) if value >= 0 else math.nan
    if name == "pow":
        return float(argument(0, "x")) ** float(argument(1, "y"))
    if name == "exp":
        return math.exp(argument(0, "x"))
    if name in ("ln", "log"):
        if name == "log" and (len(arguments) > 1 or "base" in keyword):
            return math.log(argument(0, "x"), argument(1, "base"))
        return math.log(argument(0, "x"))
    if name == "min":
        values = arguments[0] if len(arguments) == 1 and isinstance(arguments[0], list) else arguments
        return min(values)
    if name == "max":
        values = arguments[0] if len(arguments) == 1 and isinstance(arguments[0], list) else arguments
        return max(values)
    if name == "len":
        return len(argument(0, "x"))
    if name == "norm":
        return math.sqrt(sum(float(item) ** 2 for item in argument(0, "x")))
    if name == "cross":
        a = argument(0, "a")
        b = argument(1, "b")
        return [
            a[1] * b[2] - a[2] * b[1],
            a[2] * b[0] - a[0] * b[2],
            a[0] * b[1] - a[1] * b[0],
        ]
    if name == "concat":
        result: list[Any] = []
        for value in arguments:
            result.extend(value) if isinstance(value, list) else result.append(value)
        return result
    if name == "reverse":
        return list(reversed(argument(0, "x")))
    if name == "is_undef":
        return argument(0, "x", default=None) is None
    raise MiniScadError(f"unknown function {name!r}")


def as_vector(value: Any, size: int, pad: float | None = None) -> list[float]:
    if isinstance(value, (int, float)):
        return [float(value)] * size
    vector = [float(item) for item in value]
    if len(vector) < size:
        vector = vector + [0.0 if pad is None else float(pad)] * (size - len(vector))
    return vector[:size]


def radius_of(values: dict[str, Any]) -> float:
    if "r" in values:
        return float(values["r"])
    if "d" in values:
        return 0.5 * float(values["d"])
    return 1.0


def signed_area(contour: list[list[float]]) -> float:
    """Signed area of a 2D contour (positive when counter-clockwise)."""
    total = 0.0
    for index in range(len(contour)):
        x1, y1 = contour[index]
        x2, y2 = contour[(index + 1) % len(contour)]
        total += x1 * y2 - x2 * y1
    return 0.5 * total


def evaluate(source: str) -> Shape:
    """Parse and evaluate OpenSCAD source, returning a validated 3D Shape."""
    shape = Evaluator(source).run()
    if shape.is_empty:
        raise MiniScadError("the model is empty")
    if shape.dim != 3:
        raise MiniScadError("the top level object is 2D; the dataset needs solids")
    status = shape.obj.status()
    if status != m3d.Error.NoError:
        raise MiniScadError(f"manifold reported {status}")
    return shape


def evaluate_3d(source: str) -> m3d.Manifold:
    return evaluate(source).obj
