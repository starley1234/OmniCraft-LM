# Превью обучающей выборки по семействам

## Для проверяющего агента (vision, без OpenSCAD)

- Каждой строке соответствует один `id` корпуса — вердикт привязывается к нему.
- Смотреть: сначала `contact_sheet_*.png` (листы по 20 деталей, без даунскейла), спорное — в полном `png/<...>.png` (320x320).
- Вердикт писать в `verdict_template.csv` (`verdict` = ok/bad, `reason`).
- Текст модели для сверки — колонка `prompt`; ожидаемый габарит — `target_bbox`.

## Параметры прогона

- вход: `C:\github\OmniCraft-LM\data\processed\combined_v9_fixed.jsonl`
- поле семейства: `metadata.origin`
- семейств: 140 · отрендерено: 140/140
- размер: 320x320, изометрия (ортопроекция)

## Таблица

| # | id | семейство | слой | bbox (мм) | промпт | изображение |
|---|---|---|---|---|---|---|
| 1 | `ext_domain_00463__conv_en` | adapter_flange/conical_reducer | voxel | 42.0x42.0x60.0 | Conical reducer from Ø42 mm to Ø18 mm with 2.5 mm wall, 28 mm cone and 16/16 mm straight … | `png/adapter_flange_conical_reducer.png` |
| 2 | `ext_domain_00271__free_en` | adapter_flange/oval_flange | voxel | 104.0x52.0x19.0 | Oval flange on 52 mm hole centres, 52 mm pad width, 5 mm thick, Ø28 mm bore, 14 mm neck a… | `png/adapter_flange_oval_flange.png` |
| 3 | `ext_domain_00075__conv_en` | adapter_flange/round_pipe_flange | voxel | 70.0x70.0x20.0 | Hey, quick one. Round pipe flange Ø70 mm, 8 mm thick, Ø42 mm bore, 12 mm neck and 4 Ø5.5 … | `png/adapter_flange_round_pipe_flange.png` |
| 4 | `gen3_01100__conv_ru` | airducts | voxel | 67.1x67.1x26.0 | Привет! Нужна деталька: Помоги сделать патрубок с плавным изгибом. Общие габариты 67.1 на… | `png/airducts.png` |
| 5 | `wire4_00823` | aladder | wire | 91.8x36.8x96.8 | Спроектируй каркас складной лестницы, габарит 91.8x36.8x96.8 мм. Передняя рама с опорой 5… | `png/aladder.png` |
| 6 | `place1_01524__free_ru` | anchorpads | voxel | 180.0x80.0x18.0 | Смоделируй стойку с анкерными площадками габаритом 180 x 80 x 18 мм. По углам 4 площадки … | `png/anchorpads.png` |
| 7 | `wire3_01008` | archtruss | wire | 106.8x26.8x38.8 | Сделай пару арочных ферм. 106.8x26.8x38.8. Две фермы с пролётом 100 мм на расстоянии 20 м… | `png/archtruss.png` |
| 8 | `gen3_02268__conv_ru` | archtrusses | wire | 248.2x9.8x100.0 | Габарит 248.2x9.8x100 мм — арочная ферма. Верхний пояс с усиленной серединой и пологими к… | `png/archtrusses.png` |
| 9 | `sketch2_00407` | arcprofiles | sketch | 70.0x53.6x8.0 | Габарит 70x53.6x8 мм — фасонную пластину с радиусами. Дуга аппроксимирована точками с шаг… | `png/arcprofiles.png` |
| 10 | `sketch1_01508__free_en` | arcstops | sketch | 30.0x30.0x14.0 | Here is what I need: I need sector stop, size 30 by 30 by 14 mm. 8 mm bore. 14 mm tall, 5… | `png/arcstops.png` |
| 11 | `gen3_01010` | bearingblocks | voxel | 100.0x52.0x43.2 | Задача: корпус подшипника. Габарит 100x52x43.2 мм. 4 отверстия 9 мм с шагом 72 мм. Корпус… | `png/bearingblocks.png` |
| 12 | `gen2_00718__free_en` | bearings | voxel | 32.1x32.1x13.4 | I need a part: I need pillow housing, overall 32.1 by 32.1 by 13.4 mm. 3 mm wall, 5 mm sh… | `png/bearings.png` |
| 13 | `gen3_02136__free_ru` | beltrollers | voxel | 42.0x42.0x22.0 | Мне нужно вот это: Сделай мне опорный ролик ремня, габариты 42x42x22 мм. Бочка 40 мм шири… | `png/beltrollers.png` |
| 14 | `gen2_01544__free_ru` | bezels | voxel | 180.0x120.0x12.0 | Нужна деталь: Помоги сделать накладная рамка, размеры 180x120x12 мм. Рамка шириной 10 мм,… | `png/bezels.png` |
| 15 | `wire3_00254` | bikeframe | wire | 148.6x50.6x94.6 | Нужно получить раму велосипеда из труб в плане 148.6x50.6x94.6 мм. Трубы d5.6 мм, два тре… | `png/bikeframe.png` |
| 16 | `place1_00242__conv_ru` | boltcircles | voxel | 100.0x100.0x25.0 | Помоги сделать фланец размером 100 x 100 x 25 мм. Болтовая окружность ø66 мм: 10 отверсти… | `png/boltcircles.png` |
| 17 | `sketch4_00804` | bracketplates | sketch | 70.0x45.0x5.0 | Помоги сделать плиту-кронштейн, размеры 70 на 45 на 5 мм. Пластина 70 x 45 мм со срезанны… | `png/bracketplates.png` |
| 18 | `wire2_00437` | bridgetrusses | wire | 136.8x38.8x32.8 | Общие габариты 136.8x38.8x32.8 — двухферменный мост. Схема зигзагообразные раскосы без ст… | `png/bridgetrusses.png` |
| 19 | `sketch1_00066__free_ru` | camdiscs | sketch | 34.0x34.3x6.0 | Нужна деталь: кулачок с бобышкой габариты 34x34.3x6. Базовый радиус 15 мм, подъём 4 мм. Т… | `png/camdiscs.png` |
| 20 | `sketch4_00159` | camplates | sketch | 56.0x56.0x6.0 | Сделай плиту с кулачковым профилем. Габарит 56x56x6 мм. 6 облегчающих отверстий d7 мм по … | `png/camplates.png` |
| 21 | `gen3_01849__free_en` | cams | voxel | 40.0x65.1x18.0 | Here is what I need: Size 40x65.1 mm footprint, 18 mm tall — cam. A 17 mm hub with a 9.53… | `png/cams.png` |
| 22 | `gen2_00783` | caps | voxel | 51.0x51.0x14.0 | крышка стакана размеры 51x51 мм, высота 14. Крепление четырьмя винтами 3.4 мм по окружнос… | `png/caps.png` |
| 23 | `gen3_00947__free_en` | cardans | voxel | 76.0x76.0x11.4 | I need a part: I need universal joint spider, overall 76 x 76 x 11.4 mm. A 19.52 mm hub w… | `png/cardans.png` |
| 24 | `gen3_02415__free_ru` | chassisframes | wire | 162.9x92.9x48.9 | Габариты 162.9x92.9x48.9 — трубчатая рама. Продольные лонжероны и 4 поперечины 4 мм. Труб… | `png/chassisframes.png` |
| 25 | `gen3_01509__free_ru` | cleats | voxel | 90.0x34.0x43.0 | Нужен утка для швартовки в плане 90x34x43 мм. Рога 85.5 мм с осью на высоте 32 мм. Центра… | `png/cleats.png` |
| 26 | `gen2_01058__conv_ru` | clips | voxel | 34.0x24.0x23.0 | Слушай, тут такая задача. Хочу напечатать зажим для провода, общие габариты 34x24x23 мм. … | `png/clips.png` |
| 27 | `solid2_00682` | controlknob | voxel | 35.0x35.0x24.0 | Требуется деталь: ручку управления, габарит 35 x 35 x 24 мм. Корпус d35 мм высотой 20 мм.… | `png/controlknob.png` |
| 28 | `place1_00046__conv_en` | cornerplates | voxel | 110.0x75.0x12.0 | Hey, quick one. We need a profile plate overall 110 x 75 x 12 mm. 3 holes Ø8.4 mm in thre… | `png/cornerplates.png` |
| 29 | `wire3_00966` | cranejib | wire | 96.8x38.8x38.8 | Задача: стрелу крана из прутка. В плане 96.8x38.8 мм, высота 38.8. Пояса d6 мм, раскосы d… | `png/cranejib.png` |
| 30 | `solid2_00753` | drilljig | voxel | 110.0x80.0x21.0 | Сгенерируй деталь по описанию: сверлильный кондуктор, габарит 110 x 80 x 21 мм. 2 бобышки… | `png/drilljig.png` |
| 31 | `gen2_01171__free_en` | ducts | voxel | 60.0x70.0x40.0 | I need a part: I need wire tray, overall 60x70x40 mm. 50x40 mm channel with 3 mm walls. T… | `png/ducts.png` |
| 32 | `sketch1_00649__conv_en` | eccentrics | sketch | 28.6x39.9x12.0 | I'm working on an assembly and need this: I need eccentric disc, 28.6 x 39.9 x 12 mm. 12 … | `png/eccentrics.png` |
| 33 | `ext_domain_00093__conv_ru` | enclosure_lid/gasket_lid | voxel | 90.0x65.0x5.0 | Слушай, тут такая задача. Крышка корпуса 90x65 мм толщиной 5 мм с замкнутым пазом под упл… | `png/enclosure_lid_gasket_lid.png` |
| 34 | `ext_domain_00081__free_ru` | enclosure_lid/pcb_standoff_base | voxel | 65.0x75.0x14.0 | Сделай, пожалуйста: Основание корпуса 65x75 мм толщиной 3 мм с четырьмя стойками под плат… | `png/enclosure_lid_pcb_standoff_base.png` |
| 35 | `ext_domain_00441` | enclosure_lid/vented_cover | voxel | 105.0x75.0x3.0 | Вентиляционная крышка 105x75 мм толщиной 3 мм с 7 сквозными прорезями шириной 3 мм и поле… | `png/enclosure_lid_vented_cover.png` |
| 36 | `solid3_00338` | enclosurebox | voxel | 70.0x50.0x50.0 | Сгенерируй деталь по описанию: открытый корпус, габарит 70 x 50 x 50 мм. Корпус 70 x 50 x… | `png/enclosurebox.png` |
| 37 | `gen2_01407__conv_ru` | enclosures | voxel | 110.0x50.0x80.0 | Слушай, тут такая задача. В плане 110x50x80 мм — корпус с бобышками. 4 бобышки 12 мм под … | `png/enclosures.png` |
| 38 | `sketch1_00307` | eyelugs | sketch | 40.0x22.0x6.0 | Хочу проушина с зевом габариты 40x22 мм, высота 6. Вилка с зевом 12 мм между щеками. Щеки… | `png/eyelugs.png` |
| 39 | `gen3_01261__free_en` | fairings | voxel | 140.4x58.0x36.0 | I need a part: 140.4x58 mm footprint, 36 mm tall — faired duct cover. 4 mm walls on a 3 m… | `png/fairings.png` |
| 40 | `sketch1_01469` | fanrotors | sketch | 50.9x51.1x6.0 | Подскажи конструкцию: рабочее колесо, 50.9x51.1 мм, высота 6. 9 лопастей высотой 8 мм от … | `png/fanrotors.png` |
| 41 | `gen2_02089` | flanges | voxel | 70.0x70.0x29.0 | Помоги сделать круглый фланец со ступицей, габарит 70x70x29 мм. Ступица 34 мм высотой 15 … | `png/flanges.png` |
| 42 | `sketch1_01752__conv_ru` | flatadapters | sketch | 51.4x55.7x10.0 | Подскажи по детали: Требуется адаптер с лысками. 51.4x55.7x10 мм. Диск радиусом 28 мм, то… | `png/flatadapters.png` |
| 43 | `sketch1_01259__free_ru` | formwashers | sketch | 75.0x22.0x8.0 | Мне нужно вот это: Спроектируй профильная шайба. Габарит 75x22x8 мм. Полигон из 12 точек … | `png/formwashers.png` |
| 44 | `sketch3_01011` | frameplates | sketch | 110.0x60.0x10.0 | Сделай монтажную рамку с окном. 110x60x10 мм. 4 отверстия d8 мм по углам, на 6 мм от краё… | `png/frameplates.png` |
| 45 | `sketch2_00989` | gearsectors | sketch | 64.6x70.0x8.0 | Подскажи конструкцию: секторную шестерню, 64.6 на 70 на 8 мм. Ступица с отверстием радиус… | `png/gearsectors.png` |
| 46 | `wire3_00211` | geodome | wire | 86.8x76.1x56.8 | сводчатую геоконструкцию 86.8x76.1x56.8. Вершина на 20 мм выше верхнего кольца. Верхнее к… | `png/geodome.png` |
| 47 | `sketch2_00832` | groovedshafts | sketch | 27.0x27.0x24.0 | дистанционную втулку с канавками размеры 27x27x24. 1 круговая канавка шириной 3 мм, глуби… | `png/groovedshafts.png` |
| 48 | `sketch1_01906__free_en` | guardgrids | sketch | 180.0x70.0x8.0 | I need a part: Overall 180x70 mm footprint, 8 mm tall — protection grille. 5 slats 7 mm w… | `png/guardgrids.png` |
| 49 | `wire2_01194` | guymasts | wire | 187.0x162.9x207.0 | мачту на растяжках в плане 187x162.9x207 мм. 2 яруса оттяжек на высотах 200, 120 мм. Мачт… | `png/guymasts.png` |
| 50 | `gen2_02209__free_ru` | handles | voxel | 180.0x30.0x20.0 | Мне нужно вот это: Планирую эргономичная рукоятка габариты 180x30 мм, высота 20. 4 подпал… | `png/handles.png` |
| 51 | `scale1_00490` | hardlayouts | voxel | 120.0x50.0x10.0 | Сделай параметрическую деталь: плиту с боссами по координатам, габарит 120 x 50 x 10 мм. … | `png/hardlayouts.png` |
| 52 | `solid2_00068` | heatsink | voxel | 110.0x60.0x39.0 | Требуется деталь: радиатор охлаждения, габарит 110 x 60 x 39 мм. 12 ребер высотой 30 мм с… | `png/heatsink.png` |
| 53 | `gen3_00825__free_en` | heatsinks | voxel | 60.0x56.0x32.0 | I need a part: Overall 60x56x32 mm — heat sink body. 26 mm pins on a 6 mm plate. Four 4.7… | `png/heatsinks.png` |
| 54 | `gen2_00387` | helicalgears | voxel | 123.0x123.0x20.0 | Нужно получить колесо с наклонным зубом габариты 123x123x20. Модуль 3, зубьев 39, наклон … | `png/helicalgears.png` |
| 55 | `gen3_00495__free_en` | herringbones | voxel | 44.0x44.0x28.0 | Please model this: I need herringbone gear, overall 44x44 mm footprint, 28 mm tall. 10 mm… | `png/herringbones.png` |
| 56 | `gen3_01620__free_en` | hexlattices | voxel | 85.5x84.8x8.0 | I need a part: I need hex cell lattice, overall 85.5x84.8x8 mm. Four 4.4 mm mounting hole… | `png/hexlattices.png` |
| 57 | `sketch3_00616` | hexplates | sketch | 58.0x58.0x5.0 | шестигранную монтажную пластину габариты 58 на 58 на 5 мм. 6 окон под болты d5 мм на окру… | `png/hexplates.png` |
| 58 | `gen2_01014__free_ru` | hinges | voxel | 60.0x42.0x14.0 | Мне нужно вот это: Нужно изготовить навес для дверцы. Габарит 60x42x14 мм. 4 проушины диа… | `png/hinges.png` |
| 59 | `sketch1_00234` | hookplates | sketch | 53.1x66.0x10.0 | Собираюсь сделать грузовой крюк 53.1x66 мм, высота 10. Толщина 10 мм. Лента шириной 10 мм… | `png/hookplates.png` |
| 60 | `gen3_02001__conv_en` | hooks | voxel | 52.3x80.0x10.0 | Hey, quick one. I need hoist hook, dimensions 52.3x80 mm footprint, 10 mm tall. A 26 mm b… | `png/hooks.png` |
| 61 | `solid3_00730` | hopper | voxel | 110.0x110.0x67.0 | Сгенерируй деталь по описанию: воронку с фланцем, габарит 110 x 110 x 67 мм. Воронка: кон… | `png/hopper.png` |
| 62 | `gen2_01843__conv_ru` | ibeams | wire | 158.4x8.4x48.4 | Слушай, тут такая задача. прогон перекрытия общие габариты 158.4x8.4 мм, высота 48.4. Два… | `png/ibeams.png` |
| 63 | `gen2_01280__free_en` | impellers | voxel | 67.0x65.9x26.0 | I need a part: I need fan rotor, size 67 x 65.9 x 26 mm. 18.9 mm hub with a 5 mm bore. Fi… | `png/impellers.png` |
| 64 | `sketch1_01034` | keybars | sketch | 39.9x11.9x8.0 | Нужно изготовить призматическая шпонка, размеры 39.9x11.9x8 мм. Толщина 8 мм. Шпонка 12 x… | `png/keybars.png` |
| 65 | `sketch3_00786` | keyways | sketch | 24.0x23.8x80.0 | Надо сделать заготовку вала со шпоночным пазом. Габарит 24x23.8x80 мм. Шпоночный паз шири… | `png/keyways.png` |
| 66 | `gen2_01272__conv_ru` | knobs | voxel | 58.1x35.0x40.0 | Подскажи по детали: Собери модель: круглая ручка с накаткой, общие габариты 58.1x35x40 мм… | `png/knobs.png` |
| 67 | `scale1_00321` | largestruc | voxel | 240.0x170.0x5.0 | Нарисуй в OpenSCAD: большую переходную плиту, габарит 240 x 170 x 5 мм. Центральное отвер… | `png/largestruc.png` |
| 68 | `para1_0542_formal_ru__free_en` | lbrackets | voxel | 30.0x25.0x45.0 | Here is what I need: Please model display bezel, envelope 80 x 120 x 8 mm. A 12 mm frame … | `png/lbrackets.png` |
| 69 | `sketch1_00138__conv_ru` | leverarms | sketch | 59.8x15.2x10.0 | Привет! Нужна деталька: Нужно изготовить коромысло, габариты 59.8x15.2x10. Плавный контур… | `png/leverarms.png` |
| 70 | `gen3_01917` | levers | voxel | 105.0x24.0x10.0 | Нужна деталь: рычаг с плавным контуром. Общие габариты 105x24 мм, высота 10. Толщина 10 м… | `png/levers.png` |
| 71 | `gen2_01445__free_en` | lids | voxel | 100.0x50.0x5.0 | Here is what I need: I need enclosure lid, dimensions 100x50 mm footprint, 5 mm tall. Bol… | `png/lids.png` |
| 72 | `gen3_00707__conv_en` | livinghinges | voxel | 50.0x42.0x8.0 | Question about a part: I need integral hinge plate, dimensions 50x42 mm footprint, 8 mm t… | `png/livinghinges.png` |
| 73 | `solid2_00400` | manifoldblock | voxel | 110.0x60.0x40.0 | Нарисуй в OpenSCAD: распределительный коллектор, габарит 110 x 60 x 40 мм. 5 портов d10 м… | `png/manifoldblock.png` |
| 74 | `wire2_00255` | masttowers | wire | 109.8x109.8x149.8 | Подскажи конструкцию: башню-опору переменного сечения, габариты 109.8x109.8x149.8. Раскос… | `png/masttowers.png` |
| 75 | `ext_domain_00078__free_ru` | mechanical_element/gt2_pulley | voxel | 18.3x18.3x18.4 | Шкив GT2 на 24 зубьев под ремень 9 мм, делительный диаметр 15.279 мм, отверстие Ø5 мм, дв… | `png/mechanical_element_gt2_pulley.png` |
| 76 | `ext_domain_00042__conv_en` | mechanical_element/split_shaft_coupler | voxel | 18.0x18.0x36.0 | Hey, quick one. Split shaft coupler 36 mm long, Ø18 mm outside, joining Ø5 mm and Ø8 mm s… | `png/mechanical_element_split_shaft_coupler.png` |
| 77 | `ext_domain_00362__free_en` | mechanical_element/spur_gear | voxel | 41.8x41.8x6.0 | Here is what I need: Spur gear: module 1.5, 25 teeth, 37.5 mm pitch diameter, 6 mm face w… | `png/mechanical_element_spur_gear.png` |
| 78 | `scale1_00055` | microfeatures | voxel | 14.0x10.0x8.0 | Требуется деталь: миниатюрную площадку, габарит 14 x 10 x 8 мм. Сквозное отверстие d3.5 м… | `png/microfeatures.png` |
| 79 | `gen2_00574__conv_ru` | motormounts | voxel | 61.0x45.0x13.0 | Подскажи по детали: Нужна деталь: переходник под NEMA, габарит 61x45x13 мм. Крепёж NEMA17… | `png/motormounts.png` |
| 80 | `ext_domain_00028__free_ru` | mounting_plate_bracket/chamfered_plate | voxel | 75.0x40.0x10.0 | Монтажная пластина 75x40 мм толщиной 10 мм с фаской 1.5 мм и четырьмя отверстиями Ø5.2 мм… | `png/mounting_plate_bracket_chamfered_plate.png` |
| 81 | `ext_domain_00276__conv_ru` | mounting_plate_bracket/nema_motor_plate | voxel | 47.0x47.0x4.0 | Привет! Нужна деталька: Пластина крепления двигателя NEMA 17: квадрат 47 мм, толщина 4 мм… | `png/mounting_plate_bracket_nema_motor_plate.png` |
| 82 | `ext_domain_00476__free_en` | mounting_plate_bracket/slotted_l_bracket | voxel | 45.0x30.0x45.0 | I need a part: L-bracket 45x30x45 mm with 6 mm walls and 5.2 mm wide, 10 mm long adjustme… | `png/mounting_plate_bracket_slotted_l_bracket.png` |
| 83 | `gen2_00891__free_ru` | oldhams | voxel | 34.0x34.0x22.0 | Габарит 34x34x22 мм — часть муфты Олдэма. Диск 34 мм толщиной 10 мм. Кулачок 18x6 мм свер… | `png/oldhams.png` |
| 84 | `sketch1_01654__free_ru` | overslots | sketch | 180.0x60.0x8.0 | Мне нужно вот это: монтажная планка с окнами общие габариты 180x60x8 мм. 2 увеличенных ок… | `png/overslots.png` |
| 85 | `sketch1_00514__free_en` | pawls | sketch | 46.0x25.0x6.0 | I need pawl, overall 46x25 mm footprint, 6 mm tall. A 15 point ccw polygon, extruded to 6… | `png/pawls.png` |
| 86 | `sketch1_01368__conv_ru` | pclips | sketch | 60.0x18.0x8.0 | Привет! Нужна деталька: Есть запрос: скоба-зажим, общие габариты 60x18 мм, высота 8. Поли… | `png/pclips.png` |
| 87 | `place1_00585` | perfpanels | voxel | 180.0x50.0x10.0 | Задача — изготовить перфорированную панель габаритом 180 x 50 x 10 мм. Контур из 18 отвер… | `png/perfpanels.png` |
| 88 | `wire4_00116` | pergola | wire | 126.8x66.8x93.9 | Собери модель: арочную шпалеру, размеры 126.8x66.8 мм, высота 93.9. 6 прогонов длиной 60 … | `png/pergola.png` |
| 89 | `gen3_01404` | pipeclamps | voxel | 32.4x46.8x14.0 | Хочу напечатать хомут для трубы. Габариты 32.4x46.8x14. Кольцо под трубу 12.7 мм, наружны… | `png/pipeclamps.png` |
| 90 | `wire2_00993` | piperoutes | wire | 31.4x61.4x160.6 | участок магистрали с отводами в плане 31.4x61.4 мм, высота 160.6. Труба диаметром 9 мм, 7… | `png/piperoutes.png` |
| 91 | `gen2_01948__free_ru` | pipes | wire | 144.0x157.0x87.0 | Нужна деталь: Нарисуй участок трубопровода. 144x157x87. Отвод 45 градусов по 60 мм на каж… | `png/pipes.png` |
| 92 | `place1_01166__free_en` | pocketplates | voxel | 72.0x72.0x18.0 | Here is what I need: Task: model a pocket plate 72 x 72 x 18 mm. 3 x 3 square pockets of … | `png/pocketplates.png` |
| 93 | `gen2_00498` | pulleys | voxel | 40.6x40.6x19.0 | Подскажи конструкцию: шкив зубчатый. Размеры 40.6 на 40.6 на 19 мм. Профиль HTD5, 24 зубь… | `png/pulleys.png` |
| 94 | `gen2_01787__conv_en` | quadframes | wire | 176.3x176.3x5.0 | Question about a part: I need quad frame, dimensions 176.3 x 176.3 x 5 mm. Each pad takes… | `png/quadframes.png` |
| 95 | `sketch1_00863__free_ru` | rackbars | sketch | 110.0x18.0x14.0 | Сделай, пожалуйста: Нужно получить рейка общие габариты 110 на 18 на 14 мм. 8 зубьев с ша… | `png/rackbars.png` |
| 96 | `gen2_00461__free_en` | racks | voxel | 141.7x30.0x11.2 | I need a part: I need module rack, overall 141.7 x 30 x 11.2 mm. 1.25 mm addendum, 10 mm … | `png/racks.png` |
| 97 | `solid3_00439` | ribbracket | voxel | 80.0x60.0x60.0 | Нарисуй в OpenSCAD: уголок с косынками, габарит 80 x 60 x 60 мм. Угольник: основание 80 x… | `png/ribbracket.png` |
| 98 | `place1_00880__free_ru` | ribframes | voxel | 220.0x100.0x16.0 | Мне нужно вот это: Требуется изготовить рамку с рёбрами с габаритами 220 x 100 x 16 мм. 9… | `png/ribframes.png` |
| 99 | `gen3_00304__free_ru` | ringgears | voxel | 63.0x63.0x29.0 | Мне нужно вот это: Помоги сделать зубчатый венец. В плане 63x63x29 мм. Ступица 46.1 мм с … | `png/ringgears.png` |
| 100 | `wire2_01497` | rollcages | wire | 122.8x50.8x46.8 | каркас безопасности габарит 122.8x50.8x46.8 мм. Продольные дуги и обручи из прутка диамет… | `png/rollcages.png` |
| 101 | `solid3_00995` | saddleclamp | voxel | 70.0x36.0x36.0 | Нужна модель: седловой зажим вала, габарит 70 x 36 x 36 мм. Седловой зажим 70 x 36 x 36 м… | `png/saddleclamp.png` |
| 102 | `wire3_00589` | scaffold | wire | 85.8x37.8x125.8 | Надо сделать секцию рамных лесов, габариты 85.8x37.8x125.8 мм. 2 пролёта по 40 мм, 3 ярус… | `png/scaffold.png` |
| 103 | `gen3_02525__free_ru` | scissorgrids | wire | 226.8x226.8x10.8 | Мне нужно вот это: Есть запрос: сетчатая панель. Общие габариты 226.8x226.8 мм, высота 10… | `png/scissorgrids.png` |
| 104 | `gen2_02034__conv_en` | shafts | voxel | 40.0x40.0x55.0 | I'm working on an assembly and need this: I need stepped axle, dimensions 40 x 40 x 55 mm… | `png/shafts.png` |
| 105 | `wire4_00749` | shelfunit | wire | 64.8x34.8x161.8 | Задача: стеллажную раму. Габарит 64.8x34.8x161.8 мм. Диагональные связи по задней и боков… | `png/shelfunit.png` |
| 106 | `wire4_00319` | shopcart | wire | 107.8x45.8x88.8 | Собери модель: каркас грузовой тележки. В плане 107.8x45.8x88.8 мм. Четыре опоры-колеса в… | `png/shopcart.png` |
| 107 | `sketch1_01824__free_ru` | sinkframes | sketch | 60.0x30.0x14.0 | По расчёту вышел монтажная рамка размеры 60x30x14 мм. Окно 44 x 18 мм открыто сверху под … | `png/sinkframes.png` |
| 108 | `gen3_01704__conv_ru` | slottedpanels | voxel | 150.0x100.0x5.0 | Слушай, тут такая задача. Нужна деталь: панель с щелями. В плане 150x100x5 мм. Шаг от 11 … | `png/slottedpanels.png` |
| 109 | `gen3_00648__free_ru` | snapfits | voxel | 56.0x56.0x26.0 | Сделай, пожалуйста: Есть запрос: защёлка для крышки. В плане 56x56x26 мм. 2 упругих плеча… | `png/snapfits.png` |
| 110 | `place1_01989__conv_en` | socketpads | voxel | 138.0x92.0x22.0 | Make me a socket pad plate envelope 138 x 92 x 22 mm. 2 x 3 bosses Ø38 mm at 46 mm pitch,… | `png/socketpads.png` |
| 111 | `wire2_00608` | spaceframes | wire | 159.8x43.8x39.8 | Габарит 159.8x43.8x39.8 мм — пространственную ферму. 4 панели длиной 38 мм, общая длина 1… | `png/spaceframes.png` |
| 112 | `sketch4_00312` | spacerplates | sketch | 100.0x40.0x6.0 | В плане 100 на 40 на 6 мм — плиту-проставку. Овальный контур: база 60 мм, торцы R20 мм. Д… | `png/spacerplates.png` |
| 113 | `gen2_00875` | spacers | voxel | 17.5x17.5x10.0 | По расчёту вышел кольцо дистанционное 17.5x17.5x10. Внутреннее отверстие 12.5 мм под вал … | `png/spacers.png` |
| 114 | `sketch4_00799` | spinparts | sketch | 64.0x64.0x12.0 | токарную деталь размеры 64x64x12 мм. Обод d64 мм шириной 7 мм. Ступица d24 мм, диск толщи… | `png/spinparts.png` |
| 115 | `gen3_01353` | springclamps | voxel | 39.9x38.1x10.0 | Изготовь пружинная скоба, габарит 39.9x38.1x10 мм. Лента шириной 10 мм и толщиной 3 мм. К… | `png/springclamps.png` |
| 116 | `sketch1_00783__free_en` | sprockets | sketch | 37.4x37.1x6.0 | Please model this: I need sprocket blank, 37.4 by 37.1 by 6 mm. 6 mm thick. 9 teeth, 28 m… | `png/sprockets.png` |
| 117 | `solid3_00112` | spurblank | voxel | 50.0x50.1x12.0 | Построй твердотельную модель: заготовку зубчатого колеса, габарит 50 x 50.08 x 12 мм. 14 … | `png/spurblank.png` |
| 118 | `gen2_00270__free_ru` | spurgears | voxel | 81.0x81.0x16.0 | Нужна деталь: Спроектируй прямозубая шестерня. В плане 81 на 81 на 16 мм. Ступица 41.9 мм… | `png/spurgears.png` |
| 119 | `ext_part_00450__conv_ru` | standard_part | voxel | 8.0x8.0x0.5 | Подскажи по детали: Стандартная инженерная деталь: Shim ring 1. Параметры должны быть сох… | `png/standard_part.png` |
| 120 | `sketch1_01112__conv_ru` | standoffs | sketch | 28.5x28.5x24.0 | профильная распорка размеры 28.5x28.5 мм, высота 24. Внутреннее отверстие 6.5 мм по всей … | `png/standoffs.png` |
| 121 | `sketch4_00599` | starwheels | sketch | 80.0x80.0x6.0 | В плане 80 на 80 на 6 мм — звёздочку. 8 зубьев: наружный радиус 40 мм, впадина 24 мм. Цен… | `png/starwheels.png` |
| 122 | `sketch2_00507` | steppedbars | sketch | 120.0x40.0x8.0 | двухтолщинную планку 120x40x8. Углы с фаской 2.5 мм. Полная толщина 8 мм, тонкая зона 4.2… | `png/steppedbars.png` |
| 123 | `gen3_02342__conv_ru` | steptowers | wire | 82.2x82.2x248.0 | Слушай, тут такая задача. Хотелось бы башня с ярусами 82.2x82.2x248. Четыре стойки 4.8 мм… | `png/steptowers.png` |
| 124 | `wire4_00511` | stoolchair | wire | 62.8x62.8x80.8 | Хотелось бы каркас табурета в плане 62.8x62.8 мм, высота 80.8. Ноги с развалом 8 мм, коль… | `png/stoolchair.png` |
| 125 | `sketch3_00446` | structsections | sketch | 60.0x50.0x40.0 | В плане 60x50x40 мм — заготовку конструкционного профиля. Швеллер 60 x 50 мм, полка 6 мм,… | `png/structsections.png` |
| 126 | `scale1_00630` | thinwalls | voxel | 70.0x60.0x40.0 | Сгенерируй деталь по описанию: тонкостенный короб, габарит 70 x 60 x 40 мм. Короб без кры… | `png/thinwalls.png` |
| 127 | `para1_0577_chat_ru__free_ru` | threadcaps | voxel | 45.0x45.0x26.0 | Сделай, пожалуйста: привет! нужна деталь «обтекатель» 160.4x58x36, стенка 3 мм. сделаешь?… | `png/threadcaps.png` |
| 128 | `para1_0048_formal_ru__conv_en` | threads | voxel | 35.2x30.5x52.4 | I'm working on an assembly and need this: Please model snap-fit latch, envelope 48 x 48 x… | `png/threads.png` |
| 129 | `gen3_00284__conv_en` | thumbscrews | voxel | 31.6x31.7x16.0 | I'm working on an assembly and need this: Dimensions 31.6 x 31.7 x 16 mm — threaded thumb… | `png/thumbscrews.png` |
| 130 | `gen2_01729__conv_ru` | towers | wire | 90.8x90.8x210.8 | Привет! Нужна деталька: Помоги сделать решетчатая стойка. Общие габариты 90.8x90.8x210.8.… | `png/towers.png` |
| 131 | `gen2_01638__free_en` | trusses | wire | 107.2x7.2x67.2 | Here is what I need: I need parallel-chord truss, size 107.2 by 7.2 by 67.2 mm. Chords of… | `png/trusses.png` |
| 132 | `sketch1_00967__free_ru` | tslots | sketch | 50.0x42.0x100.0 | Мне нужно вот это: Помоги сделать профильная направляющая, размеры 50x42x100 мм. Т-пазы с… | `png/tslots.png` |
| 133 | `gen2_00106` | ubrackets | voxel | 45.0x70.0x55.0 | Собираюсь сделать кронштейн с двумя стойками габариты 45x70x55. 1 отверстие M5 в основани… | `png/ubrackets.png` |
| 134 | `solid2_01164` | ventbox | voxel | 100.0x70.0x50.0 | Сделай параметрическую деталь: вентилируемый корпус, габарит 100 x 70 x 50 мм. Короб 100 … | `png/ventbox.png` |
| 135 | `place1_00998__free_en` | ventrows | voxel | 180.0x30.0x6.0 | I want to print a hole bar envelope 180 x 30 x 6 mm. A row of 9 holes Ø8.4 mm on the axis… | `png/ventrows.png` |
| 136 | `sketch2_01238` | vguides | sketch | 60.0x18.0x80.0 | 60x18x80 мм — рельс с V-пазом. Ласточкин хвост высотой 10 мм, низ 20 мм, верх 13.6 мм. Ре… | `png/vguides.png` |
| 137 | `sketch2_00027` | voidplates | sketch | 90.0x70.0x5.0 | Габариты 90x70x5 мм — крышку с окнами под разъёмы. 1 сквозное окно. Углы с фаской 2.5 мм.… | `png/voidplates.png` |
| 138 | `sketch1_00471__conv_en` | windowplates | sketch | 90.0x45.0x8.0 | Question about a part: Overall 90x45x8 mm — bayed plate. No web thinner than 4 mm between… | `png/windowplates.png` |
| 139 | `gen3_00571__conv_ru` | wormwheels | voxel | 91.0x91.0x32.0 | Подскажи по детали: 91x91 мм, высота 32 — колесо червячной передачи. Винтовой зуб Z24 мод… | `png/wormwheels.png` |
| 140 | `gen2_00176` | zbrackets | voxel | 55.0x40.0x40.0 | Спроектируй переходник Z-образный, габариты 55x40x40 мм. Лист 6 мм, перепад по высоте 40 … | `png/zbrackets.png` |
