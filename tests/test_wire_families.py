"""Wire-family generator invariants (TRAIN_BRIEF_v15 «задача A»)."""

from __future__ import annotations

import re

import pytest

from src.data.generators.wire_families_gen import (
    FAMILIES,
    MAX_NODES,
    WireFamiliesGenerator,
    generate_wire_families,
)
from src.data.validation import DatasetValidator


def _assert_balanced_scad(code: str) -> None:
    stripped = re.sub(r"//[^\n]*", "", code)
    assert stripped.count("{") == stripped.count("}"), "unbalanced braces in generated OpenSCAD"
    assert stripped.count("(") == stripped.count(")"), "unbalanced parentheses in generated OpenSCAD"


def test_reproducible_ids_code_and_graph() -> None:
    first = WireFamiliesGenerator(seed=99).generate(7)
    second = WireFamiliesGenerator(seed=99).generate(7)
    assert first.id == second.id
    assert first.code == second.code
    assert first.auxiliary_ground_truth.nodes == second.auxiliary_ground_truth.nodes
    assert first.auxiliary_ground_truth.edges == second.auxiliary_ground_truth.edges
    assert WireFamiliesGenerator(seed=100).generate(7).id != first.id


def test_graphs_pass_validator_and_bbox_is_exact() -> None:
    samples = generate_wire_families(48, seed=5)  # 8 cycles over all six families
    assert {str(s.metadata["kind"]) for s in samples} == {f"wire_{k}" for k in FAMILIES}
    for sample in samples:
        assert len(sample.auxiliary_ground_truth.nodes) <= MAX_NODES
        assert DatasetValidator._check_wire_graph(sample) == []
        nodes, edges = (sample.auxiliary_ground_truth.nodes,
                        sample.auxiliary_ground_truth.edges)
        for start, end in edges:
            a, b = nodes[start], nodes[end]
            assert any(abs(a[k] - b[k]) > 1e-9 for k in range(3)), f"zero-length member in {sample.id}"
        bbox = sample.verification.target_bbox
        r = float(sample.metadata["analytic_geometry"]["member_radius_mm"])
        for axis in range(3):
            lo = min(n[axis] for n in nodes)
            hi = max(n[axis] for n in nodes)
            assert lo >= r - 1e-6, f"{sample.id}: skeleton crosses axis {axis} origin"
            assert abs(hi - lo + 2 * r - bbox[axis]) < 1e-6, f"{sample.id}: bbox mismatch axis {axis}"


def test_scad_syntax_and_specs_prompt_contract() -> None:
    for sample in generate_wire_families(24, seed=11):
        _assert_balanced_scad(sample.code)
        assert sample.code.startswith("$fn = 32;\n")
        assert "module strut(" in sample.code
        assert "sphere(" in sample.code
        # dimensioned prompt styles must state the analytic bbox (miner-parseable)
        for style in ("en", "ru", "free_en", "free_ru"):
            numbers = [float(v) for v in re.findall(r"\d+(?:\.\d+)?", sample.prompts[style])]
            bbox = list(sample.verification.target_bbox)
            assert len(numbers) >= 3
            for stated in numbers[:3]:
                assert any(abs(stated - want) <= 1e-6 for want in bbox), (
                    f"{sample.id}[{style}]: stated {stated} not in bbox {bbox}"
                )
        # conv pair: no digits, no cube fallback language
        for style in ("conv_en", "conv_ru"):
            assert not re.search(r"\d", sample.prompts[style]), f"{sample.id}[{style}] leaks digits"
            assert not re.search(r"\bcube\b", sample.prompts[style], re.IGNORECASE)


def test_unknown_family_rejected_and_count_cycling() -> None:
    with pytest.raises(ValueError, match="unknown wire families"):
        WireFamiliesGenerator(seed=0, families=("nope",))
    subset = WireFamiliesGenerator(seed=0, families=("warren", "gantry"))
    kinds = [str(s.metadata["kind"]) for s in subset.generate_many(6)]
    assert kinds == ["wire_warren", "wire_gantry"] * 3
