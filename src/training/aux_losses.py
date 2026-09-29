"""Auxiliary geometric losses (ARCHITECTURE.md section 6).

Wire: ``L_aux = ChamferDistance(V_pred, V_gt) + BCE(E_pred, E_gt)`` over the
predicted 32 vertices/edge scores and the dataset's ``auxiliary_ground_truth``.
GT node coordinates are normalized to the unit cube per sample before the
Chamfer term; edge supervision is masked to pairs of existing GT nodes.
Voxel: the 16^3 occupancy target is not yet materialized in the dataset
pipeline, so ``L_aux`` for the voxel layer is intentionally absent and the LM
cross-entropy drives the canvas until voxelized STL ground truth lands.
"""

from __future__ import annotations

import torch
import torch.nn.functional as F


def normalize_nodes_to_unit_cube(nodes: torch.Tensor, node_mask: torch.Tensor) -> torch.Tensor:
    """Map GT nodes (absolute mm) to ``[-1, 1]`` per sample using their own bounds."""
    masked = nodes.masked_fill(~node_mask.unsqueeze(-1), float("inf"))
    minimum = masked.amin(dim=1, keepdim=True)
    masked_max = nodes.masked_fill(~node_mask.unsqueeze(-1), float("-inf"))
    maximum = masked_max.amax(dim=1, keepdim=True)
    center = (minimum + maximum) / 2
    half_extent = ((maximum - minimum) / 2).clamp_min(1e-6).amax(dim=-1, keepdim=True)
    normalized = (nodes - center) / half_extent
    return torch.nan_to_num(normalized, nan=0.0, posinf=0.0, neginf=0.0)


def chamfer_distance_masked(
    predicted: torch.Tensor, target: torch.Tensor, target_mask: torch.Tensor
) -> torch.Tensor:
    """Symmetric Chamfer distance; GT rows dropped by ``target_mask`` never contribute."""
    distances = torch.cdist(predicted.float(), target.float())  # (B, P, T)
    invalid = ~target_mask
    distances = distances.masked_fill(invalid.unsqueeze(1), float("inf"))
    pred_to_gt = distances.amin(dim=2).mean(dim=1)  # every prediction pulls to the cloud
    gt_to_pred = distances.amin(dim=1)  # every GT node is covered
    gt_to_pred = (gt_to_pred * target_mask).sum(dim=1) / target_mask.sum(dim=1).clamp_min(1)
    return (pred_to_gt + gt_to_pred).mean()


def edge_bce_masked(
    edge_logits: torch.Tensor, target_edges: torch.Tensor, node_mask: torch.Tensor
) -> torch.Tensor:
    """BCE over adjacency scores restricted to pairs of existing GT nodes."""
    valid_pairs = node_mask.unsqueeze(2) & node_mask.unsqueeze(1)
    if not valid_pairs.any():
        raise ValueError("no valid node pairs to supervise edges on")
    return F.binary_cross_entropy_with_logits(
        edge_logits[valid_pairs].float(), target_edges[valid_pairs].float()
    )


def wire_auxiliary_loss(
    positions: torch.Tensor,
    edge_logits: torch.Tensor,
    nodes: torch.Tensor,
    node_mask: torch.Tensor,
    edges: torch.Tensor,
) -> torch.Tensor:
    """Combined wire-layer auxiliary loss from dataset collate fields.

    ``nodes``/``edges`` are zero-padded to ``positions.shape[1]`` vertices here.
    """
    vertex_count = positions.shape[1]
    batch = positions.shape[0]
    if nodes.shape[1] > vertex_count:
        raise ValueError(f"GT graph has {nodes.shape[1]} nodes; canvas predicts {vertex_count}")
    padded_nodes = torch.zeros(batch, vertex_count, 3, dtype=nodes.dtype, device=nodes.device)
    padded_mask = torch.zeros(batch, vertex_count, dtype=torch.bool, device=nodes.device)
    padded_edges = torch.zeros(batch, vertex_count, vertex_count, dtype=edges.dtype, device=edges.device)
    count = nodes.shape[1]
    padded_nodes[:, :count] = nodes
    padded_mask[:, :count] = node_mask
    padded_edges[:, :count, :count] = edges
    normalized = normalize_nodes_to_unit_cube(padded_nodes, padded_mask)
    return chamfer_distance_masked(positions, normalized, padded_mask) + edge_bce_masked(
        edge_logits, padded_edges, padded_mask
    )
