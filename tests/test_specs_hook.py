"""CoG [SPECS] contract: compose, parse, fallbacks — nothing may crash."""

from __future__ import annotations

from src.runtime.specs_hook import (
    DEFAULT_BBOX,
    DEFAULT_CANVAS,
    Specs,
    build_prompt_with_specs,
    compose_specs,
    extract_specs_from_text,
    parse_specs_block,
)


def test_compose_render_parse_roundtrip() -> None:
    specs = compose_specs(object_class="flange", bbox=(60.0, 60.0, 10.0), canvas="voxel")
    text = build_prompt_with_specs("Сделай фланец", specs)
    parsed = parse_specs_block(text)
    assert parsed is not None
    assert parsed.bbox == (60.0, 60.0, 10.0)
    assert parsed.canvas == "voxel"
    assert parsed.object_class == "flange"
    assert parsed.topology == "csg union/difference"


def test_parse_free_text_dims_and_canvas_hint() -> None:
    specs = extract_specs_from_text("Крепёжная пластина 80x50x6 мм с отверстиями")
    assert specs.bbox == (80.0, 50.0, 6.0)
    assert specs.canvas == "voxel"
    truss = extract_specs_from_text("Spatial truss beam 180x30x30 mm with diagonal braces")
    assert truss.canvas == "wire"
    assert truss.bbox == (180.0, 30.0, 30.0)


def test_fallbacks_never_raise() -> None:
    empty = extract_specs_from_text("сделай деталь")
    assert empty.bbox == DEFAULT_BBOX and empty.canvas == DEFAULT_CANVAS
    broken = extract_specs_from_text("[SPECS]\nbbox: [a, b, c]\ncanvas: quantum\n[/SPECS]")
    assert broken is not None and broken.bbox == DEFAULT_BBOX and broken.canvas == DEFAULT_CANVAS
    negative = extract_specs_from_text("[SPECS]\nbbox: [-5, 0, 10]\ncanvas: voxel\n[/SPECS]")
    assert all(v >= 1.0 for v in negative.bbox)


def test_compose_rejects_bad_inputs() -> None:
    try:
        compose_specs(object_class="x", bbox=(0.0, 1.0, 1.0), canvas="voxel")
        raise AssertionError("must have raised")
    except ValueError:
        pass


def test_sizes_and_types_of_render() -> None:
    specs = compose_specs(object_class="plate", bbox=(80.0, 50.0, 6.0), canvas="voxel")
    rendered = specs.render()
    assert rendered.startswith("[SPECS]\nclass: plate\n")
    assert rendered.rstrip().endswith("[/SPECS]")
    assert "bbox: [80, 50, 6]" in rendered
    assert isinstance(specs, Specs)
