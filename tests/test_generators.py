from __future__ import annotations

from src.data.generators.voxel_csg_gen import VoxelCSGGenerator
from src.data.generators.wire_truss_gen import WireTrussGenerator


def _assert_balanced_scad(source: str) -> None:
    assert source.startswith("$fn = 32;\n")
    assert "nan" not in source.lower()
    stack: list[str] = []
    pairs = {")": "(", "]": "[", "}": "{"}
    opening = set(pairs.values())
    for raw_line in source.splitlines():
        line = raw_line.split("//", 1)[0]
        for character in line:
            if character in opening:
                stack.append(character)
            elif character in pairs:
                assert stack and stack.pop() == pairs[character], f"unbalanced {character}: {source}"
    assert not stack, f"unclosed delimiters: {source}"


def test_generators_are_reproducible_by_seed_and_index() -> None:
    assert VoxelCSGGenerator(seed=31).generate(7).code == VoxelCSGGenerator(seed=31).generate(7).code
    assert WireTrussGenerator(seed=32).generate(5).code == WireTrussGenerator(seed=32).generate(5).code


def test_fifty_procedural_designs_have_header_and_balanced_syntax() -> None:
    samples = [*VoxelCSGGenerator(seed=11).generate_many(25), *WireTrussGenerator(seed=19).generate_many(25)]
    assert len(samples) == 50
    for sample in samples:
        _assert_balanced_scad(sample.code)
        assert sample.verification.target_bbox[0] > 0
        assert sample.id
