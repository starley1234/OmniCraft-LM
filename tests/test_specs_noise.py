"""E3 [SPECS] augmentation: noise/degrade flags, determinism, shared length path.

No GPU, weights, or OpenSCAD required: a stub tokenizer stands in for the backbone
tokenizer and the trainer shell is built with ``object.__new__`` (the augmentation
lives entirely in ``build_sequence`` / ``_sample_lengths``, which only need a config
and a tokenizer).
"""

from __future__ import annotations

import re

import pytest

from src.data.schema import CADSample, SampleVerification
from src.runtime.specs_hook import (
    DEFAULT_BBOX,
    WIRE_DEFAULT_BBOX,
    _default_topology,
    build_prompt_with_specs,
    compose_specs,
    extract_specs_from_text,
)
from src.training.trainer import (
    SPATIAL_TOKENS,
    SpatialTrainer,
    TrainerConfig,
    validate_specs_noise,
)

_SPATIAL_TRIGGER_RE = re.compile(r"<\|spatial_[a-z]+\|>")


class _StubTokenizer:
    """Char-level tokenizer where every ``<|spatial_*|>`` trigger is one token.

    Mirrors the real tokenizer's contract that ``X`` and a trigger token both map to
    exactly one id — that is what makes ``_sample_lengths`` and ``build_sequence``
    comparable without weights.
    """

    pad_token_id = 0
    eos_token_id = 99

    def __call__(self, text: str, **kwargs):
        ids: list[int] = []
        cursor = 0
        for match in _SPATIAL_TRIGGER_RE.finditer(text):
            ids.extend(ord(ch) % 50 + 1 for ch in text[cursor:match.start()])
            ids.append(1000)
            cursor = match.end()
        ids.extend(ord(ch) % 50 + 1 for ch in text[cursor:])
        maximum = kwargs.get("max_length")
        if maximum is not None:
            ids = ids[:maximum]
        return {"input_ids": ids or [1]}


class _RecordingTokenizer:
    """Forwards to ``_StubTokenizer`` and records every text it is asked to encode."""

    def __init__(self, inner: _StubTokenizer) -> None:
        self._inner = inner
        self.pad_token_id = inner.pad_token_id
        self.eos_token_id = inner.eos_token_id
        self.texts: list[str] = []

    def __call__(self, text: str, **kwargs):
        self.texts.append(text)
        return self._inner(text, **kwargs)


def _sample(
    sample_id: str,
    *,
    layer: str = "voxel",
    origin: str | None = None,
    bbox: tuple[float, float, float] = (96.0, 96.0, 10.0),
    prompts: dict[str, str] | None = None,
    code: str = "$fn = 32;\ncube([10, 10, 10]);\n",
) -> CADSample:
    metadata = {} if origin is None else {"origin": origin}
    return CADSample(
        id=sample_id,
        layer=layer,
        prompts=prompts or {"en": "Round flange 96 mm diameter, 10 mm thick, 32 mm bore."},
        code=code,
        verification=SampleVerification(target_bbox=bbox),
        metadata=metadata,
    )


def _trainer(layer: str = "voxel", **overrides) -> SpatialTrainer:
    """Shell over ``SpatialTrainer`` wiring only ``config`` and ``tokenizer``."""
    trainer = object.__new__(SpatialTrainer)
    trainer.config = TrainerConfig(layer=layer, **overrides)
    trainer.tokenizer = _StubTokenizer()
    return trainer


def test_zero_flags_keep_true_block_byte_for_byte() -> None:
    sample = _sample("byte-true", origin="flanges")
    trainer = _trainer()  # specs_noise = specs_degrade = 0.0

    # Expected block is built the pre-E3 way, with the unchanged compose/render path.
    raw_prompt = trainer.prompt_text_for(sample)
    expected = build_prompt_with_specs(
        raw_prompt,
        compose_specs(
            object_class=str(sample.metadata.get("origin", sample.layer)),
            bbox=sample.verification.target_bbox,
            canvas=sample.layer,
        ),
    )
    assert trainer.prompt_with_specs_for(sample) == expected

    recorder = _RecordingTokenizer(_StubTokenizer())
    trainer.tokenizer = recorder
    trainer.build_sequence(sample)
    assert recorder.texts[0] == f"{expected}\n{SPATIAL_TOKENS['voxel']}\n"


def test_block_choice_is_deterministic_per_id_and_step_free() -> None:
    sample = _sample("stable-id")
    trainer = _trainer(specs_noise=0.5, specs_degrade=0.25)
    first = trainer.specs_for_sample(sample).render()

    assert trainer._specs_roll(sample) == trainer._specs_roll(sample)
    for _ in range(5):
        assert trainer.specs_for_sample(sample).render() == first

    # No step is an input; a fresh instance with the same config picks the same block.
    other = _trainer(specs_noise=0.5, specs_degrade=0.25)
    assert other.specs_for_sample(sample).render() == first


def test_noise_one_replaces_block_with_runtime_mined() -> None:
    prompt = "Круглый фланец внешним диаметром 96 мм, толщиной 10 мм, с отверстием 32 мм."
    sample = _sample("mined", origin="flanges", prompts={"en": prompt})
    trainer = _trainer(specs_noise=1.0, specs_degrade=0.0)

    mined = extract_specs_from_text(trainer.prompt_text_for(sample), canvas_hint=sample.layer)
    chosen = trainer.specs_for_sample(sample)
    assert chosen.render() == mined.render()          # exactly the runtime render
    assert mined.render() in trainer.prompt_with_specs_for(sample)

    # Ground-truth code continuation is untouched by the augmentation.
    seq = trainer.build_sequence(sample)
    code_ids = trainer.tokenizer(sample.code, add_special_tokens=False)["input_ids"]
    expected_tail = code_ids + [trainer.tokenizer.eos_token_id]
    assert seq["input_ids"][0, -len(expected_tail):].tolist() == expected_tail
    assert seq["labels"][0, -len(expected_tail):].tolist() == expected_tail


def test_degrade_one_yields_valid_layer_level_block() -> None:
    sample = _sample("degraded", origin="flanges", bbox=(200.0, 50.0, 8.0))
    specs = _trainer(specs_noise=0.0, specs_degrade=1.0).specs_for_sample(sample)

    assert specs.object_class == "voxel"          # the layer name, not the family
    assert specs.bbox == DEFAULT_BBOX             # [100, 100, 100]
    assert specs.canvas == "voxel"
    assert specs.topology == _default_topology("voxel")
    assert "flanges" not in specs.render()        # no fabricated per-feature claims

    # A non-default layer degrades to its own name, still canonical for its canvas.
    wire = _sample("degraded-wire", layer="wire", origin="trusses")
    wire_specs = _trainer(layer="wire", specs_degrade=1.0).specs_for_sample(wire)
    assert wire_specs.object_class == "wire"
    assert wire_specs.canvas == "wire"
    assert wire_specs.topology == _default_topology("wire")
    assert wire_specs.bbox == WIRE_DEFAULT_BBOX


@pytest.mark.parametrize(
    "flags",
    [{"specs_noise": 0.0}, {"specs_noise": 1.0}, {"specs_degrade": 1.0}],
)
def test_sample_lengths_match_built_sequence(flags: dict[str, float]) -> None:
    trainer = _trainer(**flags)
    samples = [
        _sample("len-a"),
        _sample("len-b", prompts={"ru": "Деталь без явных размеров"}),
    ]
    lengths = trainer._sample_lengths(samples)
    built = [trainer.build_sequence(sample)["input_ids"].shape[1] for sample in samples]
    assert lengths == built


def test_build_sequence_and_sample_lengths_share_the_block_helper() -> None:
    trainer = _trainer(specs_noise=1.0)
    sample = _sample("shared-id")
    calls: list[str] = []
    original = trainer.prompt_with_specs_for

    def spy(current: CADSample) -> str:
        calls.append(current.id)
        return original(current)

    trainer.prompt_with_specs_for = spy  # type: ignore[method-assign]
    trainer._sample_lengths([sample])
    trainer.build_sequence(sample)
    assert calls == ["shared-id", "shared-id"]


def test_flag_validation_rejects_out_of_range_and_over_sum() -> None:
    validate_specs_noise(0.0, 0.0)
    validate_specs_noise(0.6, 0.4)  # boundary sum is legal

    for noise, degrade in [(-0.1, 0.0), (1.1, 0.0), (0.0, -0.1), (0.0, 1.1), (0.7, 0.4)]:
        with pytest.raises(ValueError):
            validate_specs_noise(noise, degrade)

    with pytest.raises(ValueError):
        TrainerConfig(layer="voxel", specs_noise=1.2)
    with pytest.raises(ValueError):
        TrainerConfig(layer="voxel", specs_noise=0.7, specs_degrade=0.4)
