"""JSONL PyTorch dataset and variable-length multimodal-target collator."""

from __future__ import annotations

from collections.abc import Callable, Sequence
from pathlib import Path
from typing import Any, Protocol

import torch
from torch.utils.data import Dataset

from src.data.schema import CADSample, parse_jsonl


class TokenizerLike(Protocol):
    pad_token_id: int | None

    def __call__(self, text: str, **kwargs: Any) -> Any: ...


class CADJsonlDataset(Dataset[dict[str, Any]]):
    """Read validated canonical records and prepare model-friendly CPU tensors.

    ``scale_embedding`` contains ``log(target_bbox)`` and is intended for
    ``ScaleMLP.forward_log_bbox``. Pass the real backbone tokenizer for training;
    a deterministic UTF-8 byte tokenizer is provided for smoke tests and tooling.
    By default only records explicitly marked ``verification.accepted`` are loaded;
    provisional candidates require ``require_accepted=False`` as an opt-in.

    ``prompt_style`` управляет выбором формулировки:
    ``"rotate"`` (по умолчанию) — детерминированная ротация по всем стилям записи
    (en/ru/free_*/conv_*), чтобы слой видел не только формальный английский;
    ``"en"`` — поведение v6/v7 (только ``prompts['en']``), оставлено для воспроизведения.
    """

    def __init__(
        self,
        path: Path,
        tokenizer: TokenizerLike | Callable[..., Any] | None = None,
        max_prompt_tokens: int | None = 2048,
        max_code_tokens: int | None = 4096,
        require_accepted: bool = True,
        prompt_style: str = "rotate",
    ) -> None:
        self.path = Path(path)
        self.samples: list[CADSample] = parse_jsonl(self.path)
        if require_accepted:
            unaccepted = [sample.id for sample in self.samples if not sample.verification.accepted]
            if unaccepted:
                preview = ", ".join(unaccepted[:5])
                raise ValueError(
                    f"training dataset contains {len(unaccepted)} unaccepted records ({preview}); "
                    "use the validator's accepted JSONL or explicitly set require_accepted=False for smoke tests"
                )
        self.tokenizer = tokenizer
        self.max_prompt_tokens = max_prompt_tokens
        self.max_code_tokens = max_code_tokens
        self.pad_token_id = int(getattr(tokenizer, "pad_token_id", 0) or 0)
        eos = getattr(tokenizer, "eos_token_id", None)
        self.eos_token_id = int(eos) if isinstance(eos, int) else None
        self.prompt_style = prompt_style
        self.prompt_epoch = 0

    def set_epoch(self, epoch: int) -> None:
        """Сменить раунд ротации формулировок (вызывать из трейнера на каждой эпохе)."""
        self.prompt_epoch = int(epoch)

    def _pick_prompt(self, sample: CADSample, index: int) -> str:
        prompts = {k: v for k, v in sample.prompts.items() if isinstance(v, str) and v.strip()}
        if not prompts:
            return ""
        if self.prompt_style == "en":  # прежнее поведение (v6/v7): только английская формальная
            return prompts.get("en") or prompts.get("ru") or next(iter(prompts.values()))
        keys = sorted(prompts)  # детерминированно: ротация зависит только от index и эпохи
        return prompts[keys[(index + self.prompt_epoch) % len(keys)]]

    def __len__(self) -> int:
        return len(self.samples)

    def _encode(self, text: str, maximum: int | None, append_eos: bool = False) -> torch.Tensor:
        if self.tokenizer is None:
            token_ids = [byte + 1 for byte in text.encode("utf-8")]
        else:
            result = self.tokenizer(text, truncation=True, max_length=maximum, add_special_tokens=True)
            token_ids = result["input_ids"] if isinstance(result, dict) else result.input_ids
            if isinstance(token_ids, torch.Tensor):
                token_ids = token_ids.detach().cpu().reshape(-1).tolist()
            elif token_ids and isinstance(token_ids[0], (list, tuple)):
                token_ids = token_ids[0]
        if maximum is not None:
            token_ids = token_ids[:maximum]
        if not token_ids:
            token_ids = [self.pad_token_id]
        if append_eos and self.eos_token_id is not None and token_ids[-1] != self.eos_token_id:
            # Без EOS в метках модель не учится останавливаться: на инференсе greedy
            # уходит в повтор («profile = [b/2, t, ...» до конца бюджета) и код не
            # компилируется. Регрессия v6/v7 — вся генерация без признака конца.
            if maximum is not None and len(token_ids) >= maximum:
                token_ids = token_ids[: maximum - 1]
            token_ids = token_ids + [self.eos_token_id]
        return torch.tensor(token_ids, dtype=torch.long)

    def __getitem__(self, index: int) -> dict[str, Any]:
        sample = self.samples[index]
        prompt = self._pick_prompt(sample, index)
        target_bbox = torch.tensor(sample.verification.target_bbox, dtype=torch.float32)
        log_bbox = torch.log(target_bbox)
        nodes = torch.tensor(sample.auxiliary_ground_truth.nodes, dtype=torch.float32).reshape(-1, 3)
        node_count = nodes.shape[0]
        adjacency = torch.zeros((node_count, node_count), dtype=torch.float32)
        for start, end in sample.auxiliary_ground_truth.edges:
            if start < 0 or end < 0 or start >= node_count or end >= node_count:
                raise ValueError(f"sample {sample.id!r} contains an edge outside its node list")
            adjacency[start, end] = 1.0
            adjacency[end, start] = 1.0
        return {
            "id": sample.id,
            "layer": sample.layer,
            "input_ids": self._encode(prompt, self.max_prompt_tokens),
            "labels": self._encode(sample.code, self.max_code_tokens, append_eos=True),
            "scale_embedding": log_bbox,
            "target_bbox": target_bbox,
            "auxiliary_targets": {"nodes": nodes, "edges": adjacency},
        }

    def collate_fn(self, items: Sequence[dict[str, Any]]) -> dict[str, Any]:
        if not items:
            raise ValueError("cannot collate an empty batch")
        batch_size = len(items)
        input_length = max(item["input_ids"].numel() for item in items)
        label_length = max(item["labels"].numel() for item in items)
        max_nodes = max(item["auxiliary_targets"]["nodes"].shape[0] for item in items)
        input_ids = torch.full((batch_size, input_length), self.pad_token_id, dtype=torch.long)
        attention_mask = torch.zeros((batch_size, input_length), dtype=torch.long)
        labels = torch.full((batch_size, label_length), -100, dtype=torch.long)
        nodes = torch.zeros((batch_size, max_nodes, 3), dtype=torch.float32)
        node_mask = torch.zeros((batch_size, max_nodes), dtype=torch.bool)
        edges = torch.zeros((batch_size, max_nodes, max_nodes), dtype=torch.float32)
        for batch_index, item in enumerate(items):
            ids = item["input_ids"]
            target = item["labels"]
            input_ids[batch_index, : ids.numel()] = ids
            attention_mask[batch_index, : ids.numel()] = 1
            labels[batch_index, : target.numel()] = target
            sample_nodes = item["auxiliary_targets"]["nodes"]
            count = sample_nodes.shape[0]
            if count:
                nodes[batch_index, :count] = sample_nodes
                node_mask[batch_index, :count] = True
                edges[batch_index, :count, :count] = item["auxiliary_targets"]["edges"]
        return {
            "ids": [item["id"] for item in items],
            "layers": [item["layer"] for item in items],
            "input_ids": input_ids,
            "attention_mask": attention_mask,
            "labels": labels,
            "scale_embedding": torch.stack([item["scale_embedding"] for item in items]),
            "target_bbox": torch.stack([item["target_bbox"] for item in items]),
            "auxiliary_targets": {"nodes": nodes, "node_mask": node_mask, "edges": edges},
        }


# Shorter conventional alias.
CADDataset = CADJsonlDataset
