"""Prompt-style augmentation: deterministic, schema-clean, geometry untouched."""

from __future__ import annotations

from src.data.generators.prompt_augment import (
    AUGMENT_STYLES,
    IMPORT_STYLES,
    augment_sample,
    render_prompt,
)
from src.data.schema import CADSample


def _row(kind: str | None, layer: str = "voxel", params: dict | None = None) -> dict:
    metadata: dict = {"source": "unit_test", "generator_version": 1}
    if kind is not None:
        metadata["kind"] = kind
    if params is not None:
        metadata["generator_parameters"] = params
    return {
        "id": f"unit_{kind or 'generic'}_0001",
        "layer": layer,
        "prompts": {"en": "Open-top rectangular box, 54 by 30 by 12 mm with 3 mm walls"},
        "code": "$fn = 32;\ncube([54, 30, 12]);\n",
        "verification": {
            "target_bbox": [54.0, 30.0, 12.0],
            "accepted": False,
        },
        "metadata": metadata,
    }


def test_determinism() -> None:
    row = _row("box", params={"x_mm": 54, "y_mm": 30, "z_mm": 12, "wall_mm": 3})
    first = augment_sample(row, seed=1234)
    second = augment_sample(row, seed=1234)
    assert first == second
    third = augment_sample(row, seed=4321)
    assert any(a["prompts"] != b["prompts"] for a, b in zip(first, third))


def test_geometry_and_ids_pass_through() -> None:
    row = _row("flange", params={"outer_diameter_mm": 96, "bore_diameter_mm": 32,
                                 "height_mm": 10, "bolt_circle_mm": 70,
                                 "bolt_hole_diameter_mm": 6})
    variants = augment_sample(row, seed=1234)
    assert len(variants) == len(AUGMENT_STYLES)
    for variant in variants:
        assert variant["id"].startswith(row["id"] + "__")
        assert variant["code"] == row["code"]
        assert variant["verification"] == row["verification"]
        assert variant["metadata"]["augmented_from"] == row["id"]
        CADSample.model_validate(variant)  # schema must accept the copy


def test_every_style_renders_for_known_kinds() -> None:
    for kind, params in (
        ("box", {"x_mm": 54, "y_mm": 30, "z_mm": 12, "wall_mm": 3}),
        ("enclosure", {"x_mm": 70, "y_mm": 50, "z_mm": 40, "wall_mm": 3}),
        ("flange", {"outer_diameter_mm": 96, "bore_diameter_mm": 32, "height_mm": 10,
                    "bolt_circle_mm": 70, "bolt_hole_diameter_mm": 6}),
        ("adapter", {"outer_diameter_mm": 52, "bore_diameter_mm": 28, "height_mm": 48}),
        ("truss", {"skeleton_length_mm": 84, "skeleton_width_mm": 30,
                   "skeleton_height_mm": 60, "member_radius_mm": 3}),
    ):
        layer = "wire" if kind == "truss" else "voxel"
        row = _row(kind, layer=layer, params=params)
        for style in AUGMENT_STYLES:
            text = render_prompt(row, style, seed=1234)
            assert text and "{" not in text, f"unfilled slot in {kind}/{style}: {text}"


def test_import_like_rows_get_only_import_styles() -> None:
    row = _row(None)
    variants = augment_sample(row, seed=1234)
    assert {v["metadata"]["prompt_style"] for v in variants} == set(IMPORT_STYLES)
    for variant in variants:
        CADSample.model_validate(variant)


def test_dims_appear_in_formal_and_free_ru() -> None:
    row = _row("box", params={"x_mm": 54, "y_mm": 30, "z_mm": 12, "wall_mm": 3})
    formal = render_prompt(row, "formal_ru", seed=1234)
    free = render_prompt(row, "free_ru", seed=1234)
    assert "54" in formal and "30" in formal
    assert "54" in free and "30" in free
