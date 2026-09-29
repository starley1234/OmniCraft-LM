"""Spatial latent modules for OmniCraft-LM."""

from src.model.assembly_canvas import AssemblyCanvas
from src.model.brep_canvas import BRepCanvas
from src.model.hook_manager import SpatialHookManager
from src.model.latent_bridge import InProjector, OutProjector, ScaleMLP
from src.model.sketch_canvas import SketchCanvas
from src.model.voxel_canvas import VoxelCanvas
from src.model.wire_canvas import WireCanvas

__all__ = [
    "AssemblyCanvas",
    "BRepCanvas",
    "InProjector",
    "OutProjector",
    "ScaleMLP",
    "SketchCanvas",
    "SpatialHookManager",
    "VoxelCanvas",
    "WireCanvas",
]
