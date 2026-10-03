# Проба [SPECS]: один промпт в разных условиях

| случай | режим | canvas | specs в промпте | ожид. bbox | факт. bbox | err | compile |
|---|---|---|---|---|---|---|---|
| flange_nospecs | nospecs | voxel | — нет — | [96, 96, 10] | [96.0, 96.0, 63.30127018922193] | 5.33 | True |
| flange_mined | mined | voxel | [SPECS] / class: freeform / bbox: [100, 100, 100] / topology: csg union/difference / canvas: voxel / [/SPECS] /  | [96, 96, 10] | [100.0, 100.0, 124.0] | 11.4 | True |
| flange_abc | mined | voxel | [SPECS] / class: freeform / bbox: [96, 96, 10] / topology: csg union/difference / canvas: voxel / [/SPECS] /  | [96, 96, 10] | [96.0, 96.0, 26.4] | 1.64 | True |
| flange_oracle | specs | voxel | [SPECS] / class: flange / bbox: [96, 96, 10] / topology: csg union/difference / canvas: voxel / [/SPECS] /  | [96, 96, 10] | [96.0, 143.0, 21.0] | 1.1 | True |
| flange_wrongspec | specs | voxel | [SPECS] / class: flange / bbox: [200, 200, 20] / topology: csg union/difference / canvas: voxel / [/SPECS] /  | [96, 96, 10] | [209.0, 300.0, 10.0] | 2.125 | True |
| cap_mined | mined | voxel | [SPECS] / class: freeform / bbox: [100, 100, 100] / topology: closed profile + extrude/revolve / canvas: voxel / [/SPECS] /  | [120, 120, 8] | [169.0, 100.8, 142.79999999701977] | 16.85 | True |
| plate_mined | mined | voxel | [SPECS] / class: freeform / bbox: [120, 80, 8] / topology: closed profile + extrude/revolve / canvas: voxel / [/SPECS] /  | [120, 80, 8] | — | — | False |
| bracket_mined | mined | voxel | [SPECS] / class: freeform / bbox: [100, 100, 100] / topology: closed profile + extrude/revolve / canvas: voxel / [/SPECS] /  | — | [100.0, 198.0, 100.0] | — | True |

## Промпты и заметки

### flange_nospecs

- заметка: без блока [SPECS], масштаб холсту задан верно
- промпт: Создай круглый фланец внешним диаметром 96 мм, толщиной 10 мм, с центральным отверстием 32 мм и 5 отверстиями 6 мм по окружности 70 мм.
- specs: `нет`
- ожидаемый bbox: [96, 96, 10] · фактический: [96.0, 96.0, 63.30127018922193]
- изображение: `png/flange_nospecs.png` · код: `flange_nospecs.scad`

### flange_mined

- заметка: текущий рантайм: miner (диаметр/толщина не поняты)
- промпт: Создай круглый фланец внешним диаметром 96 мм, толщиной 10 мм, с центральным отверстием 32 мм и 5 отверстиями 6 мм по окружности 70 мм.
- specs: `[SPECS] | class: freeform | bbox: [100, 100, 100] | topology: csg union/difference | canvas: voxel | [/SPECS] | `
- ожидаемый bbox: [96, 96, 10] · фактический: [100.0, 100.0, 124.0]
- изображение: `png/flange_mined.png` · код: `flange_mined.scad`

### flange_abc

- заметка: габарит в тексте записан как 96x96x10
- промпт: Создай круглый фланец 96x96x10 мм с центральным отверстием 32 мм и 5 отверстиями 6 мм по окружности 70 мм.
- specs: `[SPECS] | class: freeform | bbox: [96, 96, 10] | topology: csg union/difference | canvas: voxel | [/SPECS] | `
- ожидаемый bbox: [96, 96, 10] · фактический: [96.0, 96.0, 26.4]
- изображение: `png/flange_abc.png` · код: `flange_abc.scad`

### flange_oracle

- заметка: правильные [SPECS] вручную
- промпт: Создай круглый фланец внешним диаметром 96 мм, толщиной 10 мм, с центральным отверстием 32 мм и 5 отверстиями 6 мм по окружности 70 мм.
- specs: `[SPECS] | class: flange | bbox: [96, 96, 10] | topology: csg union/difference | canvas: voxel | [/SPECS] | `
- ожидаемый bbox: [96, 96, 10] · фактический: [96.0, 143.0, 21.0]
- изображение: `png/flange_oracle.png` · код: `flange_oracle.scad`

### flange_wrongspec

- заметка: неверный bbox в [SPECS]: слепо ли доверяет
- промпт: Создай круглый фланец внешним диаметром 96 мм, толщиной 10 мм, с центральным отверстием 32 мм и 5 отверстиями 6 мм по окружности 70 мм.
- specs: `[SPECS] | class: flange | bbox: [200, 200, 20] | topology: csg union/difference | canvas: voxel | [/SPECS] | `
- ожидаемый bbox: [96, 96, 10] · фактический: [209.0, 300.0, 10.0]
- изображение: `png/flange_wrongspec.png` · код: `flange_wrongspec.scad`

### cap_mined

- заметка: второй диаметр-промпт
- промпт: Создай круглую крышку внешним диаметром 120 мм, толщиной 8 мм, с центральным отверстием 30 мм.
- specs: `[SPECS] | class: freeform | bbox: [100, 100, 100] | topology: closed profile + extrude/revolve | canvas: voxel | [/SPECS] | `
- ожидаемый bbox: [120, 120, 8] · фактический: [169.0, 100.8, 142.79999999701977]
- изображение: `png/cap_mined.png` · код: `cap_mined.scad`

### plate_mined

- заметка: контроль: габарит вида AxBxC
- промпт: Сделай монтажную плиту 120x80x8 мм с 4 отверстиями 6 мм по углам.
- specs: `[SPECS] | class: freeform | bbox: [120, 80, 8] | topology: closed profile + extrude/revolve | canvas: voxel | [/SPECS] | `
- ожидаемый bbox: [120, 80, 8] · фактический: None
- изображение: `png/plate_mined.png` · код: `plate_mined.scad`

### bracket_mined

- заметка: размеров в тексте нет вовсе
- промпт: Сделай крепёжный кронштейн для датчика.
- specs: `[SPECS] | class: freeform | bbox: [100, 100, 100] | topology: closed profile + extrude/revolve | canvas: voxel | [/SPECS] | `
- ожидаемый bbox: None · фактический: [100.0, 198.0, 100.0]
- изображение: `png/bracket_mined.png` · код: `bracket_mined.scad`

