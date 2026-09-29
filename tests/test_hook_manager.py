from __future__ import annotations

import torch
from torch import nn

from src.model.hook_manager import SpatialHookManager


def test_hook_injects_control_position_on_prefill_only() -> None:
    layer = nn.Identity()
    manager = SpatialHookManager(control_token_id=99)
    manager.attach(layer)
    ids = torch.tensor([[1, 99, 2]])
    hidden = torch.zeros(1, 3, 2048)
    spatial = torch.ones(1, 2048)
    with manager.context(ids, spatial):
        result = layer(hidden)
        assert torch.equal(result[0, 0], hidden[0, 0])
        assert torch.equal(result[0, 1], torch.ones(2048))
        assert torch.equal(result[0, 2], hidden[0, 2])
        decode = layer(torch.zeros(1, 1, 2048))
        assert torch.equal(decode, torch.zeros_like(decode))
    manager.remove()
