$fn = 32;

// ----------------------------------------------------------------------
// Bracket plate: slot plate 70 x 40
// ----------------------------------------------------------------------

// --- parameters (mm) ---
hole_r = 4;               // bolt hole radius
plate_t = 5;              // plate thickness, Z (extrusion height)
plate_l = 70;             // plate length
plate_w = 40;             // plate width
slot_l = 28;              // slot straight length
slot_r = 5;               // slot end radius

slot_len = slot_l + 2 * slot_r;
slot_w = 2 * slot_r;
hole_d2 = 2 * hole_r;

profile = [[4, 0], [66, 0], [70, 4], [70, 36], [66, 40], [4, 40], [0, 36], [0, 4]];  // primary outline, 8 points, counter clockwise
void_1 = [[49, 15], [50.913, 15.381], [52.536, 16.464], [53.619, 18.087], [54, 20], [53.619, 21.913], [52.536, 23.536], [50.913, 24.619], [49, 25], [21, 25], [19.087, 24.619], [17.464, 23.536], [16.381, 21.913], [16, 20], [16.381, 18.087], [17.464, 16.464], [19.087, 15.381], [21, 15]];  // grip slot, 18 points
void_2 = [[13.527, 31.163], [12.619, 33.024], [10.902, 34.182], [8.837, 34.327], [6.976, 33.419], [5.818, 31.702], [5.673, 29.637], [6.581, 27.776], [8.298, 26.618], [10.363, 26.473], [12.224, 27.381], [13.382, 29.098]];  // corner hole, 12 points
void_3 = [[13.527, 10.363], [12.619, 12.224], [10.902, 13.382], [8.837, 13.527], [6.976, 12.619], [5.818, 10.902], [5.673, 8.837], [6.581, 6.976], [8.298, 5.818], [10.363, 5.673], [12.224, 6.581], [13.382, 8.298]];  // corner hole, 12 points
void_4 = [[64.327, 31.163], [63.419, 33.024], [61.702, 34.182], [59.637, 34.327], [57.776, 33.419], [56.618, 31.702], [56.473, 29.637], [57.381, 27.776], [59.098, 26.618], [61.163, 26.473], [63.024, 27.381], [64.182, 29.098]];  // corner hole, 12 points
void_5 = [[64.327, 10.363], [63.419, 12.224], [61.702, 13.382], [59.637, 13.527], [57.776, 12.619], [56.618, 10.902], [56.473, 8.837], [57.381, 6.976], [59.098, 5.818], [61.163, 5.673], [63.024, 6.581], [64.182, 8.298]];  // corner hole, 12 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_2);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_3);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_4);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_5);
}
