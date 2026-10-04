"""Deterministic per-epoch shuffling for training (R1, v14 brief).

The v9/v10 corpus was consumed strictly sequentially (``(cursor + offset) % n``),
so every epoch saw the same order and the tail of the dataset was reached only
after a full pass. R1 fixes that with a seeded, per-epoch permutation:

    perm = sorted(range(n), key=lambda i: sha1(f"{seed}:{epoch}:{i}"))

The key is derived from ``(seed, epoch, index)`` only — never from a global RNG
or the training step — so the order is stable across processes and runs, which
keeps the "from zero" reproduction invariant. This module is stdlib-only so the
determinism contract can be tested without torch.
"""

from __future__ import annotations

import hashlib


def epoch_permutation(size: int, seed: int, epoch: int) -> list[int]:
    """A deterministic permutation of ``range(size)`` for ``(seed, epoch)``."""
    if size < 1:
        raise ValueError(f"size must be >= 1, got {size!r}")
    return sorted(
        range(size),
        key=lambda index: hashlib.sha1(f"{seed}:{epoch}:{index}".encode("utf-8")).digest(),
    )


class EpochShuffle:
    """Cursor-based shuffled sampler with a per-epoch permutation cache.

    ``take(cursor, count)`` returns exactly ``count`` indices and the advanced
    cursor. An epoch boundary transparently rolls over to the next permutation;
    ``enabled=False`` degrades to the pre-v14 sequential order
    (``0, 1, 2, ...``). Permutations are cached so a 60k-sample epoch is sorted
    once per epoch, not once per step.
    """

    def __init__(self, size: int, seed: int = 1234, enabled: bool = True) -> None:
        if size < 1:
            raise ValueError(f"size must be >= 1, got {size!r}")
        self.size = size
        self.seed = seed
        self.enabled = enabled
        self._cache: dict[int, list[int]] = {}

    def permutation(self, epoch: int) -> list[int]:
        cached = self._cache.get(epoch)
        if cached is None:
            cached = epoch_permutation(self.size, self.seed, epoch) if self.enabled else list(range(self.size))
            self._cache[epoch] = cached
        return cached

    def take(self, cursor: int, count: int) -> tuple[list[int], int]:
        if count < 0:
            raise ValueError(f"count must be >= 0, got {count!r}")
        picked: list[int] = []
        while len(picked) < count:
            epoch, position = divmod(cursor, self.size)
            perm = self.permutation(epoch)
            take = min(count - len(picked), self.size - position)
            picked.extend(perm[position : position + take])
            cursor += take
        return picked, cursor
