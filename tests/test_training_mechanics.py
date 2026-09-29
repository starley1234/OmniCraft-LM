"""Trainer mechanics that must not regress: masked aux losses and hook routing."""

from __future__ import annotations

import torch
from torch import nn

from src.model.hook_manager import SpatialHookManager
from src.training.trainer import SpatialTrainer
from src.training.aux_losses import (
    chamfer_distance_masked,
    edge_bce_masked,
    normalize_nodes_to_unit_cube,
    wire_auxiliary_loss,
)


def test_chamfer_never_returns_nan_with_padded_targets() -> None:
    predicted = torch.randn(2, 32, 3)
    target = torch.zeros(2, 32, 3)
    mask = torch.zeros(2, 32, dtype=torch.bool)
    mask[0, :8] = True
    mask[1, :3] = True
    loss = chamfer_distance_masked(predicted, target, mask)
    assert torch.isfinite(loss)
    assert loss > 0


def test_wire_auxiliary_loss_is_finite_and_differentiable() -> None:
    positions = torch.randn(1, 32, 3, requires_grad=True)
    edge_logits = torch.randn(1, 32, 32, requires_grad=True)
    nodes = torch.tensor([[[0.0, 0.0, 0.0], [10.0, 0.0, 0.0], [10.0, 10.0, 0.0]]])
    node_mask = torch.ones(1, 3, dtype=torch.bool)
    edges = torch.zeros(1, 3, 3)
    edges[0, 0, 1] = edges[0, 1, 0] = 1.0
    edges[0, 1, 2] = edges[0, 2, 1] = 1.0
    loss = wire_auxiliary_loss(positions, edge_logits, nodes, node_mask, edges)
    assert torch.isfinite(loss)
    loss.backward()
    assert positions.grad is not None and torch.isfinite(positions.grad).all()
    assert edge_logits.grad is not None and torch.isfinite(edge_logits.grad).all()


def test_normalize_nodes_handles_single_point_and_padding() -> None:
    nodes = torch.tensor([[[5.0, 5.0, 5.0], [0.0, 0.0, 0.0]]])
    mask = torch.tensor([[True, False]])
    normalized = normalize_nodes_to_unit_cube(nodes, mask)
    assert torch.isfinite(normalized).all()
    assert normalized[0, 0].abs().max() <= 1e-6  # a lone node collapses to origin


def test_edge_bce_rejects_empty_masks() -> None:
    logits = torch.zeros(1, 4, 4)
    adjacency = torch.zeros(1, 4, 4)
    mask = torch.zeros(1, 4, dtype=torch.bool)
    try:
        edge_bce_masked(logits, adjacency, mask)
    except ValueError:
        pass
    else:  # pragma: no cover
        raise AssertionError("empty pair mask must raise")


def test_pack_chunks_respects_token_budget_and_covers_all() -> None:
    lengths = [600, 150, 150, 700, 150, 300, 150, 150]
    chunks = SpatialTrainer._pack_chunks(lengths, token_budget=2700, max_batch=8)
    flat = sorted(i for chunk in chunks for i in chunk)
    assert flat == list(range(len(lengths)))  # every sample exactly once
    for chunk in chunks:
        assert max(lengths[i] for i in chunk) * len(chunk) <= 2700
        assert len(chunk) <= 8


def test_pack_chunks_caps_batch_and_handles_tight_budget() -> None:
    chunks = SpatialTrainer._pack_chunks([10] * 20, token_budget=10_000, max_batch=4)
    assert all(len(chunk) <= 4 for chunk in chunks)
    assert sum(len(chunk) for chunk in chunks) == 20
    chunks = SpatialTrainer._pack_chunks([900, 850, 100], token_budget=1000, max_batch=8)
    assert chunks == [(2,), (1,), (0,)]  # ascending sort; each long sample packs alone


class _FakeAttention(nn.Module):
    def __init__(self) -> None:
        super().__init__()
        self.self_attn = nn.Linear(4, 4)


class _FakeBackbone(nn.Module):
    """Mimics a multimodal shell: vision blocks next to the text decoder."""

    def __init__(self) -> None:
        super().__init__()
        self.visual = nn.Module()
        self.visual.blocks = nn.ModuleList(_FakeAttention() for _ in range(24))
        self.language_model = nn.Module()
        self.language_model.layers = nn.ModuleList(_FakeAttention() for _ in range(24))

    def forward(self) -> None:  # pragma: no cover
        raise NotImplementedError


def test_hook_attach_prefers_language_model_over_vision_tower() -> None:
    backbone = _FakeBackbone()
    manager = SpatialHookManager(control_token_id=1, layer_index=12)
    manager.attach_to_backbone(backbone)
    # The hook must land on language_model.layers[12]; attaching to the vision
    # tower instead used to silently never fire during text-only forward.
    text_hooks = len(backbone.language_model.layers[12]._forward_hooks)
    vision_hooks = len(backbone.visual.blocks[12]._forward_hooks)
    manager.remove()
    assert text_hooks == 1 and vision_hooks == 0
