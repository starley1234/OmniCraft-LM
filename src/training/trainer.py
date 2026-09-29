"""Isolated spatial-layer trainer on the frozen Qwen3.5-2B backbone.

Wires the Phase-1/2 path from ARCHITECTURE.md end to end:

- the backbone loads locally (offline) in bfloat16 on CUDA and stays frozen;
- one LoRA adapter per spatial layer; only the active adapter gets gradients;
- the prefill hook at layer 12 calls the active canvas bundle through
  ``spatial_fn``, so ``L_LM`` gradients reach ``In-Projector -> Canvas ->
  Out-Projector`` in a single forward pass (no double prefill);
- for the wire layer, ``L_aux`` (Chamfer + edge BCE) with weight
  ``lambda_geom`` uses the dataset's ``auxiliary_ground_truth``; the voxel
  layer runs LM-only until voxelized occupancy targets land in the pipeline;
- rollback: ``load_zero_point`` restores the stack; LoRA adapters are dropped
  and recreated from the zero-point seed (``lora_B`` starts at zero).
"""

from __future__ import annotations

import hashlib
import json
from dataclasses import asdict, dataclass
from pathlib import Path
from typing import Any

import torch
from torch import nn

from src.data.dataset import CADJsonlDataset
from src.data.schema import CADSample
from src.model.hook_manager import SpatialHookManager
from src.training.aux_losses import wire_auxiliary_loss
from src.training.checkpoints import SUBMODULE_NAMES, build_stack_with_seed, load_manifest, load_zero_point
from src.training.lora import (
    adapter_name,
    adapter_parameters,
    attach_lora_adapters,
    freeze_inactive_adapters,
    freeze_module,
    set_active_adapter,
)
from src.training.spatial_stack import CANVAS_REGISTRY, SpatialStack

SPATIAL_TOKENS: dict[str, str] = {
    "voxel": "<|spatial_voxel|>",
    "wire": "<|spatial_wire|>",
    "sketch": "<|spatial_sketch|>",
    "brep": "<|spatial_brep|>",
    "assembly": "<|spatial_assembly|>",
}


@dataclass(slots=True)
class TrainerConfig:
    layer: str
    data: Path
    backbone_dir: Path = Path("checkpoints") / "baseline_qwen35_2b"
    zero_point_dir: Path = Path("checkpoints") / "zero_point"
    output_dir: Path = Path("checkpoints")
    device: str = "cuda"
    max_steps: int = 20
    accumulate: int = 1
    lr: float = 1e-4
    weight_decay: float = 0.0
    grad_clip: float = 1.0
    lambda_geom: float = 0.1
    max_prompt_tokens: int = 1024
    max_code_tokens: int = 4096
    gradient_checkpointing: bool = False
    save_every: int = 0  # 0 = save only at the end
    log_every: int = 1


class SpatialTrainer:
    """Train one spatial bundle + its LoRA adapter against the frozen backbone."""

    def __init__(self, config: TrainerConfig) -> None:
        if config.layer not in CANVAS_REGISTRY:
            raise ValueError(f"unknown layer {config.layer!r}")
        if config.max_steps < 1 or config.accumulate < 1:
            raise ValueError("max_steps and accumulate must be at least 1")
        if not Path(config.backbone_dir).is_dir():
            raise FileNotFoundError(
                f"backbone directory {config.backbone_dir} is missing; download the weights first"
            )
        self.config = config
        self.device = torch.device(config.device)
        if self.device.type == "cuda" and not torch.cuda.is_available():
            raise RuntimeError("CUDA requested for training but is unavailable")
        self.dtype = torch.bfloat16 if self.device.type == "cuda" else torch.float32
        self.zero_point = load_manifest(config.zero_point_dir)
        torch.manual_seed(self.zero_point.seed)

        self.tokenizer = self._load_tokenizer(Path(config.backbone_dir))
        self.control_token_id = int(self.tokenizer.convert_tokens_to_ids(SPATIAL_TOKENS[config.layer]))
        self.backbone, self._frozen_vocab = self._load_backbone(Path(config.backbone_dir))
        self.stack = self._load_verified_stack()
        self._pending_aux: tuple[torch.Tensor, torch.Tensor] | None = None

        self.hook = SpatialHookManager(self.control_token_id, layer_index=12)
        self.hook.attach_to_backbone(self.backbone)
        set_active_adapter(self.backbone, config.layer)
        freeze_inactive_adapters(self.backbone, config.layer)
        self.optimizer = torch.optim.AdamW(
            self._trainable_parameters(), lr=config.lr, weight_decay=config.weight_decay
        )
        self.history: list[dict[str, float]] = []

    # ------------------------------------------------------------------ setup

    def _load_tokenizer(self, backbone_dir: Path) -> Any:
        from transformers import AutoTokenizer

        tokenizer = AutoTokenizer.from_pretrained(backbone_dir, local_files_only=True)
        tokens = list(dict.fromkeys(SPATIAL_TOKENS.values()))
        missing = [
            token
            for token in tokens
            if tokenizer.convert_tokens_to_ids(token) is None
            or tokenizer.convert_tokens_to_ids(token) >= len(tokenizer)
        ]
        if missing:
            tokenizer.add_special_tokens({"additional_special_tokens": missing})
        for layer, token in SPATIAL_TOKENS.items():
            identifier = tokenizer.convert_tokens_to_ids(token)
            if identifier is None or identifier < 0:
                raise RuntimeError(f"failed to register spatial token {token!r}")
        if tokenizer.pad_token_id is None:
            tokenizer.pad_token = tokenizer.eos_token
        return tokenizer

    def _load_backbone(self, backbone_dir: Path) -> tuple[Any, int]:
        from transformers import AutoModelForImageTextToText

        model = AutoModelForImageTextToText.from_pretrained(
            backbone_dir, dtype=self.dtype, local_files_only=True
        )
        old_vocab = int(model.get_input_embeddings().weight.shape[0])
        target_vocab = len(self.tokenizer)
        if target_vocab > old_vocab:
            model.resize_token_embeddings(target_vocab)
        model.to(device=self.device, dtype=self.dtype)
        freeze_module(model)
        model = attach_lora_adapters(model, layers=(self.config.layer,), seed=self.zero_point.seed)
        model.config.use_cache = False
        if self.config.gradient_checkpointing:
            model.gradient_checkpointing_enable()
            model.enable_input_require_grads()
        self._thaw_new_embedding_rows(model, old_vocab)
        return model, old_vocab

    def _thaw_new_embedding_rows(self, model: nn.Module, old_vocab: int) -> None:
        """Only token rows added for ``<|spatial_*|>`` learn; the base vocab stays frozen."""
        weight = model.get_input_embeddings().weight
        if weight.shape[0] <= old_vocab:
            raise RuntimeError("spatial token rows were not added to the embedding matrix")
        weight.requires_grad_(True)
        row_mask = torch.zeros_like(weight, dtype=torch.float32)
        row_mask[old_vocab:] = 1.0

        def _mask_gradient(gradient: torch.Tensor) -> torch.Tensor:
            return gradient * row_mask.to(device=gradient.device, dtype=gradient.dtype)

        weight.register_hook(_mask_gradient)

    def _load_verified_stack(self) -> SpatialStack:
        # Only the active layer's bundle is materialized; the anchor stores all
        # five, and strict loading replaces the fresh weights bit-exactly.
        stack = build_stack_with_seed(self.zero_point.seed, layers=(self.config.layer,))
        load_zero_point(stack, self.config.zero_point_dir)
        stack.to(device=self.device, dtype=self.dtype)
        return stack

    def _trainable_parameters(self) -> list[nn.Parameter]:
        return self.stack.trainable_parameters(self.config.layer) + adapter_parameters(
            self.backbone, self.config.layer
        )

    # ------------------------------------------------------------- sequences

    def build_sequence(self, sample: CADSample) -> dict[str, torch.Tensor]:
        """Compose ``prompt + trigger`` (masked) followed by ``code + EOS`` (labels)."""
        prompt_text = sample.prompts.get("en") or next(iter(sample.prompts.values()))
        trigger = SPATIAL_TOKENS[self.config.layer]
        prompt_ids = self.tokenizer(f"{prompt_text}\n{trigger}\n", add_special_tokens=False)[
            "input_ids"
        ][: self.config.max_prompt_tokens]
        code_ids = self.tokenizer(sample.code, add_special_tokens=False)["input_ids"][
            : self.config.max_code_tokens
        ]
        eos = self.tokenizer.eos_token_id
        code_ids = code_ids + ([eos] if eos is not None else [])
        input_ids = prompt_ids + code_ids
        labels = [-100] * len(prompt_ids) + code_ids
        return {
            "input_ids": torch.tensor([input_ids], dtype=torch.long),
            "attention_mask": torch.ones(1, len(input_ids), dtype=torch.long),
            "labels": torch.tensor([labels], dtype=torch.long),
            "log_bbox": torch.log(
                torch.tensor([sample.verification.target_bbox], dtype=torch.float32)
            ),
        }

    def _spatial_fn(self, log_bbox: torch.Tensor):
        layer = self.config.layer
        bundle = self.stack.bundles[layer]

        def compute(hidden: torch.Tensor, mask: torch.Tensor) -> torch.Tensor:
            batch = hidden.shape[0]
            gathered = []
            for index in range(batch):
                positions = mask[index].nonzero(as_tuple=False)
                if positions.numel() == 0:
                    gathered.append(
                        torch.zeros(hidden.shape[-1], device=hidden.device, dtype=hidden.dtype)
                    )
                else:
                    gathered.append(hidden[index, int(positions[0].item())])
            h_cls = torch.stack(gathered, dim=0)
            log_bbox_device = log_bbox.to(device=hidden.device)
            if layer == "wire":
                scale_embedding = bundle.scale_mlp.forward_log_bbox(log_bbox_device)
                z_in = bundle.in_projector(h_cls, scale_embedding)
                z_out, predicted_nodes, edge_logits = bundle.canvas.forward_graph(z_in)
                self._pending_aux = (predicted_nodes, edge_logits)
                return bundle.out_projector(z_out)
            return bundle(h_cls, log_bbox_device)

        return compute

    # -------------------------------------------------------------- training

    def forward_loss(self, sample: CADSample) -> tuple[torch.Tensor, torch.Tensor]:
        """Single-sample forward; returns ``(lm_loss, aux_loss)`` with graphs attached."""
        build = self.build_sequence(sample)
        input_ids = build["input_ids"].to(self.device)
        attention_mask = build["attention_mask"].to(self.device)
        labels = build["labels"].to(self.device)
        self._pending_aux = None
        self.hook.set_context(build["input_ids"], spatial_fn=self._spatial_fn(build["log_bbox"]))
        try:
            outputs = self.backbone(
                input_ids=input_ids,
                attention_mask=attention_mask,
                labels=labels,
                use_cache=False,
            )
        finally:
            self.hook.clear_context()
        lm_loss = outputs.loss.float()
        aux = torch.zeros((), device=self.device, dtype=torch.float32)
        if self._pending_aux is not None:
            predicted_nodes, edge_logits = self._pending_aux
            nodes = torch.tensor([sample.auxiliary_ground_truth.nodes], dtype=torch.float32)
            node_mask = torch.ones(1, nodes.shape[1], dtype=torch.bool)
            edges = torch.zeros(1, nodes.shape[1], nodes.shape[1], dtype=torch.float32)
            for start, end in sample.auxiliary_ground_truth.edges:
                edges[0, start, end] = 1.0
                edges[0, end, start] = 1.0
            aux = wire_auxiliary_loss(
                predicted_nodes.float(),
                edge_logits.float(),
                nodes.to(self.device),
                node_mask.to(self.device),
                edges.to(self.device),
            )
        return lm_loss, aux

    def train(self) -> list[dict[str, float]]:
        dataset = CADJsonlDataset(
            Path(self.config.data),
            tokenizer=None,
            max_prompt_tokens=self.config.max_prompt_tokens,
            max_code_tokens=self.config.max_code_tokens,
        )
        samples = [sample for sample in dataset.samples if sample.layer == self.config.layer]
        if not samples:
            raise ValueError(
                f"no accepted samples for layer {self.config.layer!r} in {self.config.data}"
            )
        cursor = 0
        for step in range(1, self.config.max_steps + 1):
            step_lm = 0.0
            step_aux = 0.0
            for _ in range(self.config.accumulate):
                sample = samples[cursor % len(samples)]
                cursor += 1
                lm_loss, aux = self.forward_loss(sample)
                total = (lm_loss + self.config.lambda_geom * aux) / self.config.accumulate
                total.backward()
                step_lm += float(lm_loss)
                step_aux += float(aux)
            torch.nn.utils.clip_grad_norm_(
                [p for p in self._trainable_parameters() if p.grad is not None],
                self.config.grad_clip,
            )
            self.optimizer.step()
            self.optimizer.zero_grad(set_to_none=True)
            metrics = {
                "step": float(step),
                "lm_loss": step_lm / self.config.accumulate,
                "aux_loss": step_aux / self.config.accumulate,
            }
            self.history.append(metrics)
            if step % self.config.log_every == 0 or step == self.config.max_steps:
                print(
                    f"step {step:4d}/{self.config.max_steps} | "
                    f"lm {metrics['lm_loss']:.4f} | aux {metrics['aux_loss']:.4f}"
                )
            if self.config.save_every and step % self.config.save_every == 0:
                self.save(step=step)
        self.save(step=self.config.max_steps)
        return self.history

    # ------------------------------------------------------------ checkpoints

    def save(self, step: int) -> Path:
        layer_dir = Path(self.config.output_dir) / self.config.layer
        layer_dir.mkdir(parents=True, exist_ok=True)
        bundle = self.stack.bundles[self.config.layer]
        hashes: dict[str, str] = {}
        for submodule_name in SUBMODULE_NAMES:
            target = layer_dir / f"{submodule_name}.pt"
            state = {
                key: value.detach().cpu().float()
                for key, value in getattr(bundle, submodule_name).state_dict().items()
            }
            torch.save(state, target)
            hashes[submodule_name] = hashlib.sha256(target.read_bytes()).hexdigest()
        lora_dir = layer_dir / "lora"
        if hasattr(self.backbone, "save_pretrained"):
            lora_dir.mkdir(parents=True, exist_ok=True)
            self.backbone.save_pretrained(lora_dir, selected_adapters=[adapter_name(self.config.layer)])
        state = {
            "layer": self.config.layer,
            "step": step,
            "files_sha256": hashes,
            "zero_point": {"directory": str(self.config.zero_point_dir), "seed": self.zero_point.seed},
            "config": {key: str(value) for key, value in asdict(self.config).items()},
            "history_tail": self.history[-10:],
        }
        (layer_dir / "trainer_state.json").write_text(
            json.dumps(state, indent=2, ensure_ascii=False) + "\n", encoding="utf-8"
        )
        return layer_dir

    def rollback(self) -> None:
        """Restore the stack to the zero point, recreate the adapter, reset the optimizer."""
        load_zero_point(self.stack, self.config.zero_point_dir)
        self.stack.to(device=self.device, dtype=self.dtype)
        self._reset_adapter()
        self.optimizer = torch.optim.AdamW(
            self._trainable_parameters(), lr=self.config.lr, weight_decay=self.config.weight_decay
        )
        self.history.clear()

    def _reset_adapter(self) -> None:
        """Drop the trained adapter and recreate it (lora_B = 0 → gradient identity)."""
        name = adapter_name(self.config.layer)
        delete_adapter = getattr(self.backbone, "delete_adapter", None)
        if delete_adapter is None:
            raise TypeError("backbone is not PEFT-wrapped; cannot reset its adapter")
        peft_config = self.backbone.peft_config[name]
        self.backbone.delete_adapter(name)
        torch.manual_seed(self.zero_point.seed)
        self.backbone.add_adapter(name, peft_config)
        set_active_adapter(self.backbone, self.config.layer)
        freeze_inactive_adapters(self.backbone, self.config.layer)
