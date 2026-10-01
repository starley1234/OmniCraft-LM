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

GRID_VOXEL = 16

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
    data: Path | None = None  # required by train(); not needed for inference shells
    backbone_dir: Path = Path("checkpoints") / "baseline_qwen35_2b"
    zero_point_dir: Path = Path("checkpoints") / "zero_point"
    output_dir: Path = Path("checkpoints")
    device: str = "cuda"
    max_steps: int = 20
    accumulate: int = 1
    microbatch: int = 8  # hard cap on samples per forward
    # CE loss keeps ~4 copies of the fp32 logits alive: ~4 MB per (B*S) token on
    # the 248320 vocab. 2000 keeps the longest corpus bucket (768) inside the
    # 14 GiB ceiling with headroom; 2700 provably spiked reserved to ~29 GiB.
    max_tokens_per_forward: int = 1600
    voxel_grids: Path | None = None  # sidecar JSONL from tools/build_voxel_grids.py
    seq_bucket: int = 128  # pad sequences to this quantum: the CUDA allocator keeps per-shape pools,
    # and hundreds of distinct lengths balloon reserved VRAM until WSL2 spills to system RAM
    empty_cache_every: int = 25  # release fragmented allocator pools periodically; 0 disables
    lr: float = 1e-4
    weight_decay: float = 0.0
    grad_clip: float = 1.0
    lambda_geom: float = 0.1
    max_prompt_tokens: int = 256   # measured corpus p100: ~22 prompt tokens; cap prevents silent bloat
    cog_specs: bool = True         # prepend the deterministic [SPECS] block (ARCHITECTURE.md 8.1)
    prompt_style: str = "rotate"   # "rotate" — детерминированный выбор среди всех стилей строки
                                   # (en/ru/free_*/conv_*); "en" — поведение v6/v7, когда обучение
                                   # видело только формальный английский и проваливало conv-промпты
    max_code_tokens: int = 2048    # v6 p99=1915 (place1 multi-feature codes); longer tails hit the OOM guard instead
    gradient_checkpointing: bool = False
    train_spatial_token_embeddings: bool = False  # True adds a ~1 GiB param + ~3 GiB of Adam state/grads
    lr_warmup_steps: int = 30
    lora_dropout: float = 0.05
    max_vram_gb: float = 14.0  # hard ceiling; log lines flag every breach (Windows spills instead of OOM)
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
        if self.device.type == "cuda" and config.max_vram_gb > 0:
            # Hard allocation cap: the ceiling is enforcement, not a log marker.
            # The allocator raises OutOfMemoryError (our per-chunk guard skips it)
            # instead of letting WSL2/WDDM silently spill into system RAM.
            device_index = self.device.index if self.device.index is not None else torch.cuda.current_device()
            total_gb = torch.cuda.get_device_properties(device_index).total_memory / 1024**3
            fraction = min(0.98, config.max_vram_gb / total_gb)
            torch.cuda.set_per_process_memory_fraction(fraction, device=device_index)
        self.zero_point = load_manifest(config.zero_point_dir)
        torch.manual_seed(self.zero_point.seed)

        self.tokenizer = self._load_tokenizer(Path(config.backbone_dir))
        self.control_token_id = int(self.tokenizer.convert_tokens_to_ids(SPATIAL_TOKENS[config.layer]))
        self.backbone, self._frozen_vocab = self._load_backbone(Path(config.backbone_dir))
        self.stack = self._load_verified_stack()
        self._pending_aux: tuple[str, object] | None = None

        self.hook = SpatialHookManager(self.control_token_id, layer_index=12)
        self.hook.attach_to_backbone(self.backbone)
        set_active_adapter(self.backbone, config.layer)
        freeze_inactive_adapters(self.backbone, config.layer)
        if config.train_spatial_token_embeddings:
            self._thaw_spatial_token_rows(self.backbone)
        self.optimizer = torch.optim.AdamW(
            self._trainable_parameters(), lr=config.lr, weight_decay=config.weight_decay
        )
        self.history: list[dict[str, float]] = []
        self._oom_skips = 0
        self._empty_steps = 0  # подряд идущие шаги, где OOM съел все чанки
        self._missing_gt = 0
        self._seen_gt = 0  # строк, для которых сетка нашлась: покрытие aux-GT
        self._voxel_grids: dict[str, torch.Tensor] | None = None

    def _load_voxel_grids(self) -> dict[str, torch.Tensor]:
        """Decode the sidecar JSONL into {id: float32 grid (16,16,16)}."""
        import base64

        import numpy as np

        if self.config.voxel_grids is None or not Path(self.config.voxel_grids).is_file():
            return {}
        grids: dict[str, torch.Tensor] = {}
        for line in Path(self.config.voxel_grids).read_text(encoding="utf-8").splitlines():
            if not line.strip():
                continue
            row = json.loads(line)
            packed = np.frombuffer(base64.b64decode(row["grid_b64"]), dtype=np.uint8)
            grid = np.unpackbits(packed, count=GRID_VOXEL**3).reshape(GRID_VOXEL, GRID_VOXEL, GRID_VOXEL)
            grids[row["id"]] = torch.from_numpy(grid.astype(np.float32))
        return grids

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
        needed_vocab = max(
            int(self.tokenizer.convert_tokens_to_ids(token)) for token in SPATIAL_TOKENS.values()
        ) + 1
        if needed_vocab > old_vocab:
            model.resize_token_embeddings(needed_vocab)
        model.to(device=self.device, dtype=self.dtype)
        freeze_module(model)
        model = attach_lora_adapters(
            model,
            layers=(self.config.layer,),
            seed=self.zero_point.seed,
            dropout=self.config.lora_dropout,
        )
        model.config.use_cache = False
        if self.config.gradient_checkpointing:
            model.gradient_checkpointing_enable()
            model.enable_input_require_grads()
        return model, old_vocab

    def _thaw_spatial_token_rows(self, model: nn.Module) -> None:
        """Only the ``<|spatial_*|>`` embedding rows learn; the base vocab stays frozen."""
        weight = model.get_input_embeddings().weight
        token_ids = [
            int(self.tokenizer.convert_tokens_to_ids(token)) for token in SPATIAL_TOKENS.values()
        ]
        if max(token_ids) >= weight.shape[0]:
            raise RuntimeError("spatial token rows are missing from the embedding matrix")
        weight.requires_grad_(True)
        row_mask = torch.zeros_like(weight, dtype=torch.float32)
        row_mask[token_ids] = 1.0

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

    def _apply_warmup(self, step: int) -> None:
        """Linear LR warmup; straight to ``lr`` after ``lr_warmup_steps``."""
        warmup = max(0, self.config.lr_warmup_steps)
        if warmup == 0 or step > warmup:
            return
        scale = step / warmup
        for group in self.optimizer.param_groups:
            group["lr"] = self.config.lr * scale

    def _trainable_parameters(self) -> list[nn.Parameter]:
        params = self.stack.trainable_parameters(self.config.layer) + adapter_parameters(
            self.backbone, self.config.layer
        )
        if self.config.train_spatial_token_embeddings:
            # Row-masked by the gradient hook; note the ~3 GiB optimizer/grad
            # footprint this single shared matrix adds on the VRAM budget.
            params = params + [self.backbone.get_input_embeddings().weight]
        return params

    # ------------------------------------------------------------- sequences

    def prompt_text_for(self, sample: CADSample) -> str:
        """Формулировка для обучения: ротация по стилям вместо жёсткого ``prompts['en']``.

        Выбор детерминирован (хэш id), поэтому ран воспроизводим и длины, посчитанные
        в ``_sample_lengths``, совпадают с реально собранной последовательностью.
        """
        prompts = {k: v for k, v in sample.prompts.items() if isinstance(v, str) and v.strip()}
        if not prompts:
            return ""
        if self.config.prompt_style == "en":
            return prompts.get("en") or next(iter(prompts.values()))
        keys = sorted(prompts)
        digest = hashlib.sha1(str(sample.id).encode("utf-8")).digest()
        return prompts[keys[digest[0] % len(keys)]]

    def build_sequence(self, sample: CADSample) -> dict[str, torch.Tensor]:
        """Compose ``prompt + [SPECS] + trigger`` (masked) followed by ``code + EOS``."""
        prompt_text = self.prompt_text_for(sample)
        if self.config.cog_specs:
            from src.runtime.specs_hook import build_prompt_with_specs, compose_specs

            object_class = str(sample.metadata.get("origin", sample.layer))
            specs = compose_specs(
                object_class=object_class,
                bbox=sample.verification.target_bbox,
                canvas=self.config.layer,
            )
            prompt_text = build_prompt_with_specs(prompt_text, specs)
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
            # Stay on-GPU: nonzero()/item() here would force a host sync per step,
            # which on WDDM (~32 us kernel dispatch) dominates the whole step.
            first = mask.float().argmax(dim=1)  # (B,) index of the first control token
            index = first.view(-1, 1, 1).expand(-1, 1, hidden.shape[-1])
            h_cls = hidden.gather(1, index).squeeze(1)  # (B, D)
            log_bbox_device = log_bbox.to(device=hidden.device)
            if layer == "wire":
                scale_embedding = bundle.scale_mlp.forward_log_bbox(log_bbox_device)
                z_in = bundle.in_projector(h_cls, scale_embedding)
                z_out, predicted_nodes, edge_logits = bundle.canvas.forward_graph(z_in)
                self._pending_aux = ("wire", (predicted_nodes, edge_logits))
                return bundle.out_projector(z_out)
            if layer == "voxel":
                scale_embedding = bundle.scale_mlp.forward_log_bbox(log_bbox_device)
                z_in = bundle.in_projector(h_cls, scale_embedding)
                z_out, occupancy_logits = bundle.canvas.forward_with_grid(z_in)
                self._pending_aux = ("voxel", occupancy_logits)
                return bundle.out_projector(z_out)
            return bundle(h_cls, log_bbox_device)

        return compute

    # -------------------------------------------------------------- training

    def _collate(self, builds: list[dict[str, torch.Tensor]]) -> dict[str, torch.Tensor]:
        """Pad per-sample builds into one microbatch, quantized to seq buckets.

        Padding to a fixed quantum (``seq_bucket``) keeps the CUDA caching
        allocator on a handful of stable logits shapes instead of one pool per
        observed length — the previous free-form padding ballooned reserved VRAM
        past the card over a few hundred steps.
        """
        batch = len(builds)
        max_len = max(build["input_ids"].shape[1] for build in builds)
        quantum = max(1, self.config.seq_bucket)
        target_len = ((max_len + quantum - 1) // quantum) * quantum
        pad_id = self.tokenizer.pad_token_id or 0
        input_ids = torch.full((batch, target_len), pad_id, dtype=torch.long)
        attention_mask = torch.zeros(batch, target_len, dtype=torch.long)
        labels = torch.full((batch, target_len), -100, dtype=torch.long)
        for index, build in enumerate(builds):
            length = build["input_ids"].shape[1]
            input_ids[index, :length] = build["input_ids"][0]
            attention_mask[index, :length] = 1
            labels[index, :length] = build["labels"][0]
        return {
            "input_ids": input_ids,
            "attention_mask": attention_mask,
            "labels": labels,
            "log_bbox": torch.cat([build["log_bbox"] for build in builds], dim=0),
        }

    def forward_loss(self, samples: list[CADSample]) -> tuple[torch.Tensor, torch.Tensor]:
        """One microbatch forward; returns ``(lm_loss, aux_loss)`` with graphs attached."""
        builds = [self.build_sequence(sample) for sample in samples]
        batch = self._collate(builds)
        input_ids = batch["input_ids"].to(self.device)
        attention_mask = batch["attention_mask"].to(self.device)
        labels = batch["labels"].to(self.device)
        self._pending_aux = None
        self.hook.set_context(input_ids.cpu(), spatial_fn=self._spatial_fn(batch["log_bbox"]))
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
        if self._pending_aux is not None and self._pending_aux[0] == "wire":
            predicted_nodes, edge_logits = self._pending_aux[1]
            aux = wire_auxiliary_loss(
                predicted_nodes.float(),
                edge_logits.float(),
                *self._collate_wire_targets(samples),
            )
        elif self._pending_aux is not None and self._pending_aux[0] == "voxel":
            occupancy_logits = self._pending_aux[1]
            aux = self._voxel_aux(occupancy_logits, samples)
        return lm_loss, aux

    def _voxel_aux(self, occupancy_logits: torch.Tensor, samples: list[CADSample]) -> torch.Tensor:
        """BCEWithLogits of predicted occupancy against the 16^3 STL-derived GT."""
        import torch.nn.functional as F

        if self._voxel_grids is None:
            self._voxel_grids = self._load_voxel_grids()
        targets: list[torch.Tensor] = []
        valid_rows: list[int] = []
        for row, sample in enumerate(samples):
            # Аугментированные строки носят id вида "{parent}__{style}", а сайдкар сеток
            # ключуется родительским id: без нормализации aux-лосс молча обнуляется.
            grid = self._voxel_grids.get(sample.id)
            if grid is None:
                parent = str(sample.metadata.get("augmented_from") or sample.id.split("__")[0])
                grid = self._voxel_grids.get(parent)
            if grid is not None:
                valid_rows.append(row)
                targets.append(grid)
        if not valid_rows:
            self._missing_gt += len(samples)
            return torch.zeros((), device=self.device, dtype=torch.float32)
        gt = torch.stack(targets).to(device=occupancy_logits.device, dtype=torch.float32)
        subset = torch.tensor(valid_rows, device=occupancy_logits.device)
        predicted = occupancy_logits.float().index_select(0, subset)
        self._missing_gt += len(samples) - len(valid_rows)
        self._seen_gt += len(valid_rows)
        return F.binary_cross_entropy_with_logits(predicted, gt)

    def _gt_coverage(self) -> float | None:
        """Доля воксельных строк, для которых нашлась сетка-GT (None = aux не считался)."""
        total = self._seen_gt + self._missing_gt
        if total == 0:
            return None
        return self._seen_gt / total

    def _gt_coverage_suffix(self) -> str:
        coverage = self._gt_coverage()
        return "" if coverage is None else f" (gt {coverage:.0%})"

    def _assert_live_aux(self, step: int) -> None:
        """Мёртвый aux — это не «ноль лосса», а отсутствие сеток: падать сразу.

        В v8 сайдкар покрывал 0.4% корпуса, aux тихо равнялся нулю весь прогон.
        Проверяем после прогрева: если сетки есть на диске, но не находятся по id.
        """
        if self.config.voxel_grids is None or self.config.layer != "voxel":
            return
        if step < 20:
            return
        coverage = self._gt_coverage()
        if coverage is None or coverage >= 0.5:
            return
        raise RuntimeError(
            f"aux-GT покрывает лишь {coverage:.1%} воксельных строк на шаге {step}: "
            f"сетки {self.config.voxel_grids} не джойнятся с корпусом. "
            "Соберите сетки на весь корпус (tools/wsl_build_grids.sh) и перезапустите."
        )

    def _collate_wire_targets(
        self, samples: list[CADSample]
    ) -> tuple[torch.Tensor, torch.Tensor, torch.Tensor]:
        """Pad per-sample GT graphs into a batched (nodes, node_mask, edges) triple."""
        batch = len(samples)
        max_nodes = max(len(sample.auxiliary_ground_truth.nodes) for sample in samples)
        nodes = torch.zeros(batch, max_nodes, 3, dtype=torch.float32)
        node_mask = torch.zeros(batch, max_nodes, dtype=torch.bool)
        edges = torch.zeros(batch, max_nodes, max_nodes, dtype=torch.float32)
        for index, sample in enumerate(samples):
            ground = sample.auxiliary_ground_truth
            count = len(ground.nodes)
            nodes[index, :count] = torch.tensor(ground.nodes, dtype=torch.float32)
            node_mask[index, :count] = True
            for start, end in ground.edges:
                edges[index, start, end] = 1.0
                edges[index, end, start] = 1.0
        return nodes.to(self.device), node_mask.to(self.device), edges.to(self.device)

    @staticmethod
    def _pack_chunks(
        lengths: list[int], token_budget: int, max_batch: int
    ) -> list[tuple[int, ...]]:
        """Greedy ascending-length packing: each chunk satisfies ``max_len * size <= budget``.

        Padding waste stays minimal because chunk mates have similar lengths;
        a long sample forces a small chunk, a run of short ones packs densely.
        """
        order = sorted(range(len(lengths)), key=lambda i: lengths[i])
        chunks: list[tuple[int, ...]] = []
        current: list[int] = []
        current_max = 0
        for index in order:
            candidate_max = max(current_max, lengths[index])
            if current and (candidate_max * (len(current) + 1) > token_budget or len(current) >= max_batch):
                chunks.append(tuple(current))
                current = []
                current_max = 0
            current.append(index)
            current_max = candidate_max
        if current:
            chunks.append(tuple(current))
        return chunks

    def _sample_lengths(self, samples: list[CADSample]) -> list[int]:
        """Tokenized sequence lengths, computed once per run (CPU-bound, ~1 ms each)."""
        import time as _time

        start = _time.monotonic()
        lengths: list[int] = []
        for sample in samples:
            prompt_text = self.prompt_text_for(sample)
            prompt_len = len(
                self.tokenizer(f"{prompt_text}\nX\n", add_special_tokens=False)["input_ids"]
            )
            code_len = len(self.tokenizer(sample.code, add_special_tokens=False)["input_ids"])
            lengths.append(min(prompt_len, self.config.max_prompt_tokens) + 1 + min(code_len, self.config.max_code_tokens))
        print(f"pretokenized {len(lengths)} lengths in {_time.monotonic() - start:.1f}s")
        return lengths

    def train(self) -> list[dict[str, float]]:
        if self.config.data is None or not Path(self.config.data).is_file():
            raise ValueError(f"training data not found: {self.config.data}")
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
        lengths = self._sample_lengths(samples)
        # Образец длиннее бюджета не делится: упаковщик всё равно отдаёт его одним
        # чанком, и тот гарантированно уходит в OOM. Отсеиваем заранее и честно
        # сообщаем сколько — молчаливый OOM-пропуск выглядел как обучение (v6-v8).
        budget = self.config.max_tokens_per_forward
        keep = [i for i, length in enumerate(lengths) if length <= budget]
        if len(keep) < len(samples):
            dropped = len(samples) - len(keep)
            longest = max(lengths)
            print(
                f"[data] {dropped} из {len(samples)} образцов длиннее бюджета {budget} "
                f"токенов (самый длинный {longest}) — исключены из обучения; "
                f"осталось {len(keep)}",
                flush=True,
            )
            samples = [samples[i] for i in keep]
            lengths = [lengths[i] for i in keep]
        if not samples:
            raise ValueError(
                f"все образцы слоя {self.config.layer!r} длиннее бюджета {budget} токенов: "
                "поднимите --max-tokens-per-forward или укоротите корпус"
            )
        cursor = 0
        import time as _time

        last_log_time = _time.monotonic()
        for step in range(1, self.config.max_steps + 1):
            # Keep per-microbatch losses on the GPU; host reads happen only on
            # log steps — each float() here is a WDDM host sync (~ms on Windows).
            step_lm = torch.zeros((), device=self.device)
            step_aux = torch.zeros((), device=self.device)
            done_groups = 0  # сколько чанков реально дошло до backward на этом шаге
            indices = [(cursor + offset) % len(samples) for offset in range(self.config.accumulate)]
            cursor += self.config.accumulate
            chunk_index_groups = self._pack_chunks(
                [lengths[i] for i in indices],
                self.config.max_tokens_per_forward,
                max(1, self.config.microbatch),
            )
            for group in chunk_index_groups:
                chunk = [samples[indices[i]] for i in group]
                try:
                    lm_loss, aux = self.forward_loss(chunk)
                    total = (lm_loss + self.config.lambda_geom * aux) / len(chunk_index_groups)
                    total.backward()
                    step_lm += lm_loss.detach()
                    step_aux += aux.detach()
                    done_groups += 1
                except torch.cuda.OutOfMemoryError:
                    # Патологический чанк не должен топить многочасовой ран. ВАЖНО: здесь
                    # нельзя звать optimizer.zero_grad() — это стирало бы градиенты, уже
                    # накопленные успешными чанками того же шага (баг v6/v7: 4136 скипов
                    # = тысячи шагов, ушедших в оптимизатор с обнулённым накоплением).
                    torch.cuda.empty_cache()
                    recovered = 0
                    for one in chunk:  # вторая попытка по одному образцу
                        try:
                            lm_loss, aux = self.forward_loss([one])
                            total = (lm_loss + self.config.lambda_geom * aux) / (
                                len(chunk_index_groups) * len(chunk)
                            )
                            total.backward()
                            step_lm += lm_loss.detach()
                            step_aux += aux.detach()
                            recovered += 1
                            done_groups += 1
                        except torch.cuda.OutOfMemoryError:
                            torch.cuda.empty_cache()
                    self._oom_skips += len(chunk) - recovered
                    if recovered < len(chunk):
                        print(
                            f"  [OOM] chunk of {len(chunk)} samples "
                            f"(max ~{max(lengths[indices[i]] for i in group)} tokens): "
                            f"восстановлено {recovered}, пропущено {len(chunk) - recovered}; "
                            f"всего пропусков: {self._oom_skips}",
                            flush=True,
                        )
            torch.nn.utils.clip_grad_norm_(
                [p for p in self._trainable_parameters() if p.grad is not None],
                self.config.grad_clip,
            )
            self._apply_warmup(step)
            self.optimizer.step()
            self.optimizer.zero_grad(set_to_none=True)
            if (
                self.device.type == "cuda"
                and self.config.empty_cache_every > 0
                and step % self.config.empty_cache_every == 0
            ):
                # Contract the fragmented allocator pools back to the driver; the
                # pools regrow from a handful of bucketed shapes instead of
                # accumulating one pool per observed sequence length.
                torch.cuda.empty_cache()
            if done_groups == 0:
                # Шаг, где все чанки съел OOM, печатал lm 0.0000 и выглядел как
                # идеальная сходимость — именно так «обучались» леги v6/v7.
                # Теперь это громкая ошибка, а не тихий ноль.
                self._empty_steps += 1
                print(
                    f"  [EMPTY STEP {step}] все чанки пропущены по OOM — обучения не было; "
                    f"снизьте --max-tokens-per-forward (сейчас {self.config.max_tokens_per_forward}). "
                    f"Пустых шагов подряд: {self._empty_steps}",
                    flush=True,
                )
                if self._empty_steps >= 20:
                    raise RuntimeError(
                        f"20 шагов подряд без единого успешного чанка при бюджете "
                        f"{self.config.max_tokens_per_forward}: ран бессмысленен, остановлен"
                    )
            else:
                self._empty_steps = 0
            denominator = max(done_groups, 1)
            metrics = {
                "step": float(step),
                "lm_loss": float(step_lm) / denominator,
                "aux_loss": float(step_aux) / denominator,
                "skipped_chunks": float(len(chunk_index_groups) - done_groups),
            }
            self.history.append(metrics)
            self._assert_live_aux(step)
            if step % self.config.log_every == 0 or step == self.config.max_steps:
                vram_now, vram_peak, vram_reserved = 0.0, 0.0, 0.0
                if self.device.type == "cuda":
                    vram_now = torch.cuda.memory_allocated() / 1024**3
                    vram_peak = torch.cuda.max_memory_allocated() / 1024**3
                    vram_reserved = torch.cuda.memory_reserved() / 1024**3
                breach = (
                    f"  !! over the {self.config.max_vram_gb:g} GiB ceiling"
                    if vram_peak > self.config.max_vram_gb or vram_reserved > self.config.max_vram_gb
                    else ""
                )
                now = _time.monotonic()
                steps_per_sec = self.config.log_every / max(now - last_log_time, 1e-9)
                last_log_time = now
                print(
                    f"step {step:4d}/{self.config.max_steps} | "
                    f"lm {metrics['lm_loss']:.4f} | aux {metrics['aux_loss']:.4f}"
                    f"{self._gt_coverage_suffix()} | "
                    f"{steps_per_sec:.2f} it/s | vram {vram_now:.1f}/{vram_peak:.1f} GiB, "
                    f"reserved {vram_reserved:.1f} GiB{breach}",
                    flush=True,
                )
            if self.config.save_every and step % self.config.save_every == 0:
                self.save(step=step)
        self.save(step=self.config.max_steps)
        if self._oom_skips:
            print(f"[warning] training finished with {self._oom_skips} OOM-skipped chunks")
        coverage = self._gt_coverage()
        if coverage is not None:
            print(
                f"[aux] voxel GT coverage {coverage:.1%} "
                f"({self._seen_gt} with grid / {self._missing_gt} without)"
            )
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
        """Restore the stack to the zero point, recreate the adapter, reset the optimizer.

        The stack is rebuilt in fp32 and swapped in whole: loading fp32 anchors
        into bf16 modules in place would silently round the restored weights.
        """
        self.stack = self._load_verified_stack()
        self._reset_adapter()
        self.optimizer = torch.optim.AdamW(
            self._trainable_parameters(), lr=self.config.lr, weight_decay=self.config.weight_decay
        )
        self.history.clear()

    # Aux heads are training-only; an older checkpoint may predate them.
    # Keys are relative to the submodule, e.g. canvas.pt holds "occupancy.weight".
    _COMPAT_MISSING_PREFIXES = ("occupancy.",)

    def load_trained_checkpoint(self, layer_dir: Path) -> None:
        """Load artifacts saved by :meth:`save` for inference or resumption.

        Strict by default; an older checkpoint may legally lack training-only
        aux heads (``_COMPAT_MISSING_PREFIXES``) — those keep zero-point values
        and are never read on the inference path.
        """
        layer_dir = Path(layer_dir)
        bundle = self.stack.bundles[self.config.layer]
        for submodule_name in SUBMODULE_NAMES:
            target = layer_dir / f"{submodule_name}.pt"
            if not target.is_file():
                raise FileNotFoundError(f"checkpoint file missing: {target}")
            state = torch.load(target, map_location="cpu", weights_only=True)
            module = getattr(bundle, submodule_name)
            try:
                module.load_state_dict(state, strict=True)
            except RuntimeError as exc:
                module_keys = set(module.state_dict())
                unexpected = sorted(key for key in state if key not in module_keys)
                missing = sorted(key for key in module_keys if key not in state)
                tolerated = (
                    submodule_name == "canvas"
                    and not unexpected
                    and all(m.startswith(self._COMPAT_MISSING_PREFIXES) for m in missing)
                )
                if not tolerated:
                    raise RuntimeError(
                        f"checkpoint {target} is incompatible beyond training-only heads: {exc}"
                    ) from exc
                module.load_state_dict(state, strict=False)
                print(f"[compat] {submodule_name}: aux head keys left at zero point ({missing})")
        self.stack.to(device=self.device, dtype=self.dtype)
        lora_dir = layer_dir / "lora"
        if lora_dir.is_dir():
            load_adapter = getattr(self.backbone, "load_adapter", None)
            if load_adapter is None:
                raise TypeError("backbone is not PEFT-wrapped; cannot load a trained adapter")
            # PEFT nests per-adapter directories when saving selected adapters.
            adapter_dir = lora_dir
            if not (adapter_dir / "adapter_config.json").is_file():
                nested = lora_dir / adapter_name(self.config.layer)
                if not (nested / "adapter_config.json").is_file():
                    raise FileNotFoundError(f"no adapter_config.json under {lora_dir}")
                adapter_dir = nested
            trained_name = adapter_name(self.config.layer) + "_trained"
            existing = getattr(self.backbone, "peft_config", {})
            if trained_name in existing:
                self.backbone.delete_adapter(trained_name)
            self.backbone.load_adapter(adapter_dir, adapter_name=trained_name)
            self.backbone.set_adapter(trained_name)

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
