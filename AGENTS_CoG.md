# AGENTS.md: Geometric Chain-of-Thought (CoG) & Dynamic Scale Hook Specification

## 1. Контекст и архитектурная цель
Модель **OmniCraft-LM** (`Qwen3.5-2B` + Spatial Canvas Bridge на слое $L_{12}$) должна строить сложные бытовые и CAD-объекты по единичным семантическим запросам (zero-shot, однословный ввод: «Утюг», «Чайник», «Мышь») без краша модуля нормализации масштаба и без размытия латентного вектора.

Для этого внедряется двухэтапный протокол:
1. **Geometric Chain-of-Thought (CoG):** Языковая модель генерирует детерминированный YAML-блок `[SPECS]` перед вызовом токена холста. Это накапливает пространственный контекст в KV-кэше и выравнивает латентный вектор $h_{\text{mid}}$.
2. **Dynamic Scale Injection Hook:** Рантайм-перехватчик парсит габариты (`bbox`) и тип холста (`canvas`) из `[SPECS]`, вычисляет $\mathbf{e}_{\text{scale}} = \text{MLP}_{\text{scale}}(\log(\text{bbox}))$ и передает управление в соответствующий модуль холста.

---

## 2. Формат данных и системный контракт (Data Pipeline)

Все обучающие примеры в датасете, а также системный промпт инференса **обязаны** следовать строгой схеме.

### 2.1. Спецификация контракта
```text
<|im_start|>user
{user_query}<|im_end|>
<|im_end|>
<|im_start|>assistant
[SPECS]
class: {object_class}
bbox: [{x}, {y}, {z}]
topology: {brief_geometric_strategy}
canvas: {sketch | voxel | wire | brep}
[/SPECS]
<|spatial_{canvas}|>
{cad_code}
<|im_end|>
```

### 2.2. Требования к полям `[SPECS]`
* `bbox`: Строго список из трех целых или вещественных чисел в миллиметрах `[X, Y, Z]`.
* `canvas`: Допустимы только зарегистрированные холсты: `sketch` (для тел вращения/лофтов), `voxel` (для сложных CSG/органических форм), `wire` (каркасы/профили), `brep` (аналитические грани).
* Тэг закрытия `[/SPECS]` является триггером остановки авторегрессионного префилла перед входом в мост.

---

## 3. Требования к модификации пайплайна инференса (`inference_pipeline.py`)

Агенту необходимо реализовать двухуровневый цикл генерации:

```
[Пользовательский ввод]
         │
         ▼
[Phase 1: Prefill & CoG Decoding]
         │  (Генерация до стоп-токена "[/SPECS]\n")
         ▼
[Hook: Regex Metadata Extraction]
         ├── Извлечение target_bbox -> torch.Tensor([X, Y, Z], dtype=torch.bfloat16)
         └── Выбор canvas_token -> "<|spatial_{canvas}|>"
         │
         ▼
[Phase 2: Bridge Activation (Layer 12)]
         ├── MLP_scale(log(target_bbox)) -> e_scale
         ├── In-Projector(h_mid) + e_scale -> z_in
         └── Run Spatial Canvas Forward -> z_spatial
         │
         ▼
[Phase 3: Autoregressive CAD Code Generation]
         └── Вывод детерминированного кода (Build123d / OpenSCAD)
```

### 3.1. Парсер метаданных (`runtime_parser.py`)
Требуется детерминированный, бессбойный парсер регулярных выражений:
* Должен содержать **Fallback BBox**: если модель выдала некорректный формат чисел, подставлять `[100.0, 100.0, 100.0]`, логировать `WARNING`, но не крашить процесс.
* Валидировать значения: $X, Y, Z > 0$. При значениях $\le 0$ заменять на $10.0$.

---

## 4. Памятка по изменениям в кодовой базе

### A. Вспомогательный модуль парсинга: `src/runtime/specs_hook.py`
Создать микро-модуль обработки:
```python
import re
import torch
import logging

logger = logging.getLogger("OmniCraft.Hook")
BBOX_PATTERN = re.compile(r"bbox:\s*\[\s*([0-9.]+)\s*,\s*([0-9.]+)\s*,\s*([0-9.]+)\s*\]")
CANVAS_PATTERN = re.compile(r"canvas:\s*(sketch|voxel|wire|brep)")

DEFAULT_BBOX = [100.0, 100.0, 100.0]
DEFAULT_CANVAS = "sketch"

def extract_specs_from_text(text: str):
    bbox_match = BBOX_PATTERN.search(text)
    if bbox_match:
        try:
            bbox = [float(bbox_match.group(i)) for i in range(1, 4)]
            bbox = [max(v, 1.0) for v in bbox]
        except ValueError:
            logger.warning("Failed parsing bbox values, fallback applied.")
            bbox = DEFAULT_BBOX
    else:
        logger.warning("BBox not found in [SPECS], fallback applied.")
        bbox = DEFAULT_BBOX

    canvas_match = CANVAS_PATTERN.search(text)
    canvas = canvas_match.group(1) if canvas_match else DEFAULT_CANVAS

    return bbox, canvas
```

### B. Интеграция в рантайм модели: `src/models/generation_mixin.py`
В методе генерации (`generate_cad`):
1. Выполнить первый вызов `generate()` с параметрами:
   * `stopping_criteria`: токен `[/SPECS]` (или строка `[/SPECS]\n`).
   * `max_new_tokens`: $128$.
2. Извлечь полученный текст, вызвать `extract_specs_from_text()`.
3. Сформировать тензор `bbox_tensor = torch.tensor(bbox, dtype=torch.bfloat16, device=device).unsqueeze(0)`.
4. Внедрить токен `<|spatial_{canvas}|>` в поток токенов.
5. Вызвать форвард-проход моста холста:
   $$\mathbf{e}_{\text{scale}} = \text{MLP}_{\text{scale}}(\log(\text{bbox\_tensor}))$$
6. Возобновить стандартную авторегрессию генерации кода (Build123d) до `<|im_end|>`.

### C. Обновление формата синтетического генератора: `scripts/generate_synthetic_data.py`
При процедурной генерации датасета через скрипты Build123d:
* Все синтетические образцы **обязаны** формировать префикс `[SPECS]` с реальными габаритами сгенерированного `Compound.bounding_box()`.

---

## 5. Граничные ограничения (Guardrails)
1. **Лимит VRAM:** Запрещено создание новых промежуточных полносвязных слоев более $2048 \times 2048$. Все операции хука выполняются либо на CPU, либо переиспользуют уже инициализированный `MLP_scale`.
2. **Zero-Token Ambiguity:** Не допускать прямую генерацию токена `<|spatial_*|>` без предварительного блока `[SPECS]`.
3. **Детерминизм CAD:** Генерация кода после холста должна иметь температуру $T \le 0.2$ во избежание синтаксических ошибок в AST Python/OpenSCAD.