"""R1 (v14): deterministic per-epoch shuffling — pure-stdlib, no torch/GPU needed.

The contract that matters for reproducibility: the same ``(seed, epoch, size)``
always yields the same permutation; disabling the shuffle reproduces the
sequential pre-v14 order byte for byte.
"""

from __future__ import annotations

import pytest

from src.training.sampling import EpochShuffle, epoch_permutation


def test_epoch_permutation_is_a_permutation() -> None:
    perm = epoch_permutation(50, 1234, 0)
    assert sorted(perm) == list(range(50))


def test_epoch_permutation_is_deterministic() -> None:
    assert epoch_permutation(64, 1234, 2) == epoch_permutation(64, 1234, 2)


def test_epoch_permutation_varies_across_epochs() -> None:
    assert epoch_permutation(64, 1234, 0) != epoch_permutation(64, 1234, 1)


def test_epoch_permutation_varies_across_seeds() -> None:
    assert epoch_permutation(64, 1234, 0) != epoch_permutation(64, 4321, 0)


def test_epoch_permutation_rejects_empty() -> None:
    with pytest.raises(ValueError):
        epoch_permutation(0, 1, 0)


def test_disabled_shuffle_is_sequential() -> None:
    sampler = EpochShuffle(10, seed=1234, enabled=False)
    picked, cursor = sampler.take(0, 5)
    assert picked == [0, 1, 2, 3, 4]
    assert cursor == 5


def test_take_covers_an_epoch_without_duplicates() -> None:
    sampler = EpochShuffle(10, seed=1234, enabled=True)
    picked, cursor = sampler.take(0, 10)
    assert sorted(picked) == list(range(10))
    assert cursor == 10


def test_take_spans_epoch_boundaries() -> None:
    size = 5
    sampler = EpochShuffle(size, seed=7, enabled=True)
    picked, cursor = sampler.take(3, 7)
    assert len(picked) == 7
    assert cursor == 10
    # first two slots come from epoch 0 at positions 3 and 4
    assert picked[:2] == sampler.permutation(0)[3:5]
    # remaining five fill exactly epoch 1
    assert picked[2:] == sampler.permutation(1)


def test_take_zero_count_is_noop() -> None:
    sampler = EpochShuffle(4, seed=1, enabled=True)
    assert sampler.take(2, 0) == ([], 2)


def test_take_rejects_negative_count() -> None:
    sampler = EpochShuffle(4, seed=1, enabled=True)
    with pytest.raises(ValueError):
        sampler.take(0, -1)


def test_two_instances_agree_bit_for_bit() -> None:
    stream_a = []
    stream_b = []
    a = EpochShuffle(37, seed=1234, enabled=True)
    b = EpochShuffle(37, seed=1234, enabled=True)
    ca = cb = 0
    for _ in range(20):
        picked_a, ca = a.take(ca, 8)
        picked_b, cb = b.take(cb, 8)
        stream_a.extend(picked_a)
        stream_b.extend(picked_b)
    assert stream_a == stream_b
