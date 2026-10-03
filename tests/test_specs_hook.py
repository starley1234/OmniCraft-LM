"""CoG [SPECS] contract: compose, parse, fallbacks — nothing may crash."""

from __future__ import annotations

from src.runtime.specs_hook import (
    CANVASES,
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


# --------------------------------------------------------------------------- miner (inference)
# extract_specs_from_text must reproduce what trainer.build_sequence composed at training
# time: in-vocabulary class (metadata.origin family or layer fallback), bbox recovered from
# the corpus phrasings, topology canonical for the executed canvas.

_FLANGE_PROMPT = (
    "Создай круглый фланец внешним диаметром 96 мм, толщиной 10 мм, "
    "с центральным отверстием 32 мм и 5 отверстиями 6 мм по окружности 70 мм."
)


def test_mine_flange_acceptance() -> None:
    specs = extract_specs_from_text(_FLANGE_PROMPT, canvas_hint="voxel")
    assert specs.bbox == (96.0, 96.0, 10.0)          # «Ø96, толщиной 10» is not lost
    assert specs.object_class == "flanges"            # in the training vocabulary
    assert specs.topology == "csg union/difference"   # canonical for voxel, not sketch
    assert specs.canvas == "voxel"
    assert "freeform" not in specs.render()


def test_mine_diameter_phrasings_agree() -> None:
    variants = [
        "Создай круглый фланец внешним диаметром 96 мм, толщиной 10 мм, с отверстием 32 мм.",
        "Смоделируй фланец Ø96 мм, толщина 10 мм, проход Ø32 мм, отверстия под болты на окружности Ø66 мм.",
        "Сделай круглый фланец диаметром 96 на 10 мм толщиной, проход 32 мм.",
        "I need a pipe flange, 96 mm OD, 10 mm thick, 32 mm bore.",
        "Round flange please: Ø96 mm, 10 mm thick, center bore Ø32 mm.",
        "Make a disc flange 96 mm across, 10 mm thick, hole Ø32 mm in the middle.",
    ]
    for text in variants:
        specs = extract_specs_from_text(text, canvas_hint="voxel")
        assert specs.bbox == (96.0, 96.0, 10.0), text
        assert specs.object_class == "flanges", text


def test_mine_pair_plus_thickness() -> None:
    specs = extract_specs_from_text(
        "Сделай монтажную плиту 120x80x8 мм с 4 отверстиями 6 мм по углам.", canvas_hint="voxel"
    )
    assert specs.bbox == (120.0, 80.0, 8.0)
    assert specs.object_class == "mounting_plate_bracket/chamfered_plate"
    assert specs.topology == "csg union/difference"  # plate_mined parser bug must not return
    two_dim = extract_specs_from_text(
        "Нужна прямоугольная пластина 80 на 50 мм, толщина 4 мм, по углам четыре отверстия под винт М4."
    )
    assert two_dim.bbox == (80.0, 50.0, 4.0)


def test_mine_linear_member_span_along_x() -> None:
    truss = extract_specs_from_text(
        "Собери пространственную ферму длиной 180 мм с прямоугольным сечением 40x40 мм.",
        canvas_hint="wire",
    )
    assert truss.bbox == (180.0, 40.0, 40.0)
    assert truss.object_class == "trusses"
    assert truss.topology == "node-edge graph hull members"
    # but a vertical "высота" stays on Z
    pipe = extract_specs_from_text(
        "Участок магистрали с отводами в плане 31.4x61.4 мм, высота 160.6. Труба диаметром 9 мм."
    )
    assert pipe.bbox == (31.4, 61.4, 160.6)


def test_mine_special_shapes() -> None:
    assert extract_specs_from_text("Мне нужен кубик 30 мм с сквозным отверстием 10 мм.").bbox == (30.0, 30.0, 30.0)
    hexagon = extract_specs_from_text(
        "Шестигранная призма с расстоянием между гранями 17 мм, высотой 10 мм и сквозным отверстием 10 мм."
    )
    assert abs(hexagon.bbox[0] - 19.63) < 0.05 and hexagon.bbox[1:] == (17.0, 10.0)
    standoff = extract_specs_from_text(
        "Cylindrical standoff 20 mm tall, 12 mm outer diameter, with a 4 mm through hole.",
        canvas_hint="voxel",
    )
    assert standoff.bbox == (12.0, 12.0, 20.0)
    # a hole diameter must never masquerade as the envelope
    plate = extract_specs_from_text(
        "Основание корпуса 85x65 мм толщиной 4 мм, Ø7 мм под винт M3 по углам.", canvas_hint="voxel"
    )
    assert plate.bbox == (85.0, 65.0, 4.0)


def test_mine_no_dimensions_stays_honest() -> None:
    bare = extract_specs_from_text("Сделай крепёжный кронштейн для датчика.", canvas_hint="voxel")
    assert bare.bbox == DEFAULT_BBOX
    assert "bbox:default" in bare.provenance
    assert bare.object_class == "lbrackets"  # mined from the keyword, not "freeform"
    empty = extract_specs_from_text("Чайник")
    assert empty.bbox == DEFAULT_BBOX and empty.canvas == DEFAULT_CANVAS
    assert empty.object_class == empty.canvas  # trainer-style fallback, in vocabulary
    assert empty.topology == "closed profile + extrude/revolve"  # canonical for the default canvas


def test_mine_never_contradicts_canvas() -> None:
    # whatever the keyword router thinks, a canvas hint pins topology
    for text in ("Сделай круглую крышку.", "Нарисуй ферму пролётом 120 мм.", "whatever 5x5"):
        specs = extract_specs_from_text(text, canvas_hint="voxel")
        assert specs.topology == "csg union/difference" and specs.canvas == "voxel"


def test_mine_class_vocabulary_against_corpus_slice() -> None:
    """class values on the v9 family manifest stay inside metadata.origin ∪ canvases."""
    import json
    from pathlib import Path

    manifest = Path("data/previews/families_v9/manifest.jsonl")
    if not manifest.is_file():  # data slice ships with the repo; be soft if extracted elsewhere
        return
    vocabulary = {json.loads(line)["family"] for line in manifest.read_text(encoding="utf-8").splitlines() if line.strip()}
    vocabulary.update(CANVASES)
    for line in manifest.read_text(encoding="utf-8").splitlines():
        row = json.loads(line)
        specs = extract_specs_from_text(row["prompt"], canvas_hint=row["layer"])
        assert specs.object_class in vocabulary, (row["id"], specs.object_class)


def test_mine_bbox_accuracy_on_corpus_slice() -> None:
    """Regression bar for the miner on the 140-prompt v9 slice: ≥120 prompts within 15%."""
    import json
    from pathlib import Path

    manifest = Path("data/previews/families_v9/manifest.jsonl")
    if not manifest.is_file():
        return
    hits = 0
    total = 0
    for line in manifest.read_text(encoding="utf-8").splitlines():
        if not line.strip():
            continue
        row = json.loads(line)
        target = row.get("target_bbox")
        if not target:
            continue
        total += 1
        mined = extract_specs_from_text(row["prompt"], canvas_hint=row["layer"]).bbox
        if max(abs(a - t) / t for a, t in zip(mined, target)) <= 0.15:
            hits += 1
    assert total == 140
    assert hits >= 120, f"miner regressed: {hits}/{total}"


def test_mine_never_raises_on_garbage() -> None:
    for text in ("", "Ø", "x x x", "nan", "999999999999x1x1 мм", "диаметром", "[SPECS]x"):
        specs = extract_specs_from_text(text)
        assert len(specs.bbox) == 3 and all(v > 0 for v in specs.bbox)


def test_compose_accepts_provenance_and_render_ignores_it() -> None:
    specs = compose_specs(object_class="flanges", bbox=(96.0, 96.0, 10.0), canvas="voxel",
                          provenance="class:keyword bbox:diameter+height")
    assert "provenance" not in specs.render()
    assert specs.render().startswith("[SPECS]\nclass: flanges\n")
