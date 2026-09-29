### Цель этапа
Сформировать 100% готовую архитектурную, генерационную и тестовую инфраструктуру проекта на чистом CPU и стандартных библиотеках. Когда рабочая станция получит RTX 5060 Ti и OpenSCAD, запуск пайплайна обучения и бенчмаркинга должен произойти **без единой правки архитектурного кода** — простым переключением флага `--device cuda`.

---

### Архитектурные границы: что разрешено и что запрещено

| Разрешено (Делать обязательно) | Запрещено (Приведет к сбою) |
|---|---|
| Тензорные вычисления PyTorch на CPU (`torch.float32` / симуляция `bfloat16`) | Вызовы `torch.cuda.*` без проверки `torch.cuda.is_available()` |
| Строгая типизация (`typing`, `pydantic`, `dataclasses`) | Жёсткая привязка к бинарникам `openscad.exe` без Mock-режима |
| Синтетические генераторы кода OpenSCAD на Python | Попытки компиляции мешей без проверки наличия рантайма |
| Unit-тесты на проверку размерностей тензоров ($B, C, D$) | Загрузка полных весов Qwen через сеть (`HF_HUB_OFFLINE=1`) |
| Создание Mock-компиляторов и фейковых верификаторов | Использование `torch.compile(..., backend="triton")` |

---

### План работ (WBS — Work Breakdown Structure)

#### Модуль 1. Структура монорепозитория
Создать стандартизированное дерево каталогов:
```text
omnicraft-lm/
├── configs/
│   ├── base_config.yaml           # Гиперпараметры, размеры скрытых слоев
│   ├── model_qwen35_2b.yaml       # Параметры бэкбона и LoRA
│   └── data_generation.yaml       # Конфиг процедурных генераторов
├── src/
│   ├── model/
│   │   ├── __init__.py
│   │   ├── latent_bridge.py       # In-Projector, Out-Projector, ScaleMLP
│   │   ├── voxel_canvas.py        # 3D CoordConv + ResBlocks
│   │   ├── wire_canvas.py         # Graph Neural Network / EdgeConv
│   │   ├── sketch_canvas.py       # 2D Plane ResNet
│   │   ├── brep_canvas.py         # BRep-заглушка протокола
│   │   ├── assembly_canvas.py     # SE(3) Transform Tree
│   │   └── hook_manager.py        # Врезка в Layer 12, Pre-fill хуки
│   ├── env/
│   │   ├── __init__.py
│   │   ├── cad_interface.py       # Абстрактный базовый класс верификатора (ABC)
│   │   ├── mock_runner.py         # Mock-компилятор для тестов без OpenSCAD
│   │   ├── openscad_runner.py     # Полноценный CLI-раннер с флагом --backend=manifold
│   │   └── build123d_runner.py    # Скелет раннера для B-Rep/STEP
│   ├── data/
│   │   ├── __init__.py
│   │   ├── schema.py              # Pydantic-схема канонического JSONL
│   │   ├── dataset.py             # PyTorch Dataset с динамическим маскированием
│   │   └── generators/
│   │       ├── __init__.py
│   │       ├── voxel_csg_gen.py   # Процедурная генерация корпусов, фланцев, полостей
│   │       └── wire_truss_gen.py  # Процедурная генерация ферм, рам, балок
│   └── utils/
│       ├── __init__.py
│       ├── system_check.py        # Диагностика: наличие GPU, VRAM, OpenSCAD, OS
│       └── metrics.py             # Топологические метрики и проверка BBox <= 15%
├── tests/
│   ├── test_tensors_shape.py      # Проверка прогона через все Canvas на CPU
│   ├── test_generators.py         # Проверка синтаксиса и инварианта $fn=32;
│   ├── test_dataset_pipeline.py   # Валидация JSONL и расчёта Scale Embedding
│   └── test_mock_environment.py   # Тест пайплайна верификации на заглушках
├── tools/
│   └── prepare_dataset.py         # CLI-скрипт массовой генерации данных
├── requirements.txt
└── requirements-dev.txt
```

#### Модуль 2. Нейросетевое ядро (Все Canvas на PyTorch)
1. **`latent_bridge.py`**:
   - `ScaleMLP`: $\log(\text{bbox}) \in \mathbb{R}^3 \to \text{Linear}(3, 64) \to \text{SiLU} \to \text{Linear}(64, 128)$.
   - `InProjector`: $\mathbb{R}^{D_{\text{llm}} + 128} \to \mathbb{R}^{D_{\text{canvas}}}$ (по умолчанию $2048 + 128 \to 512$).
   - `OutProjector`: $\mathbb{R}^{D_{\text{canvas}}} \to \mathbb{R}^{D_{\text{llm}}}$ ($512 \to 2048$).
2. **`voxel_canvas.py`**:
   - Решейп вектора в сетку $16 \times 16 \times 16$ с 32 признаковыми каналами.
   - Слой `CoordConv3D`: конкатенация трёх координатных сеток $[-1, 1]$ (итого 35 каналов).
   - 3x ResBlock3D (`Conv3d` $3 \times 3 \times 3$, `GroupNorm(4, 32)`, `SiLU`).
   - `AdaptiveAvgPool3d(1)` $\to$ проекция обратно в $D_{\text{canvas}} = 512$.
3. **`wire_canvas.py`**:
   - Генерация $K = 32$ вершин в пространстве $\mathbb{R}^3$.
   - Реализация блока динамического графа (EdgeConv / дифференцируемый $k$-NN).
   - Вычисление матрицы смежности и пулинг в вектор $D_{\text{canvas}} = 512$.
4. **`hook_manager.py`**:
   - PyTorch forward-хук, монтируемый в `model.layers[12]`.
   - Логика: срабатывание **строго при `seq_len > 1`** (этап prefill). При шагах генерации (`seq_len == 1`, KV-кэш) хук возвращает неизменённый тензор `hidden_states`.

#### Модуль 3. Абстракция CAD-окружения
Создать модульную систему исполнения кода:
- Базовый класс `CADRunnerBase(ABC)` с методами `compile(code) -> VerificationResult`.
- `MockCADRunner`: парсит регулярными выражениями наличие `$fn = 32;`, извлекает габариты из названий примитивов (`cube([x, y, z])`) и генерирует реалистичный синтетический результат верификации (`is_watertight=True`, `euler_characteristic=2`, `components_count=1`).
- `OpenSCADRunner`: запускает `openscad.exe --backend=manifold -o temp.stl temp.scad`, валидирует через Trimesh. При отсутствии бинарника в системе выбрасывает понятное исключение `CADExecutableNotFound`, не ломая импорты тестов.

#### Модуль 4. Процедурные синтезаторы данных
Реализовать генераторы, выдающие код OpenSCAD без использования CAD:
- **`voxel_csg_gen.py`**: генерирует параметрические коробки, корпуса приборов, стаканы под подшипники, детали с выборками через `difference()` и `union()`.
- **`wire_truss_gen.py`**: генерирует пространственные стержневые конструкции, балки переменного сечения и рамы на базе связок `hull() { translate(...) sphere(...); translate(...) sphere(...); }`.
- **Каждый сгенерированный скрипт обязан начинаться с жесткой строки:**
  ```openscad
  $fn = 32;
  ```

#### Модуль 5. Системный инспектор (`system_check.py`)
Скрипт самодиагностики, который при старте выводит статус окружения:
- Доступность CUDA, имя видеокарты, объем памяти, соответствие sm_120.
- Наличие OpenSCAD в `PATH`, тест версии `--backend=manifold`.
- Проверка офлайн-переменных (`HF_HUB_OFFLINE`).

