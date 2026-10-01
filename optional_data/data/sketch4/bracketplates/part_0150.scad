$fn = 32;

// ----------------------------------------------------------------------
// Bracket plate: slot plate 90 x 50
// ----------------------------------------------------------------------

// --- parameters (mm) ---
hole_r = 4;               // bolt hole radius
plate_t = 5;              // plate thickness, Z (extrusion height)
plate_l = 90;             // plate length
plate_w = 50;             // plate width
slot_l = 24;              // slot straight length
slot_r = 4;               // slot end radius

slot_len = slot_l + 2 * slot_r;
slot_w = 2 * slot_r;
hole_d2 = 2 * hole_r;

profile = [[4, 0], [86, 0], [90, 4], [90, 46], [86, 50], [4, 50], [0, 46], [0, 4]];  // primary outline, 8 points, counter clockwise
void_1 = [[57, 21], [58.531, 21.304], [59.828, 22.172], [60.696, 23.469], [61, 25], [60.696, 26.531], [59.828, 27.828], [58.531, 28.696], [57, 29], [33, 29], [31.469, 28.696], [30.172, 27.828], [29.304, 26.531], [29, 25], [29.304, 23.469], [30.172, 22.172], [31.469, 21.304], [33, 21]];  // grip slot, 18 points
void_2 = [[13.527, 41.163], [12.619, 43.024], [10.902, 44.182], [8.837, 44.327], [6.976, 43.419], [5.818, 41.702], [5.673, 39.637], [6.581, 37.776], [8.298, 36.618], [10.363, 36.473], [12.224, 37.381], [13.382, 39.098]];  // corner hole, 12 points
void_3 = [[13.527, 10.363], [12.619, 12.224], [10.902, 13.382], [8.837, 13.527], [6.976, 12.619], [5.818, 10.902], [5.673, 8.837], [6.581, 6.976], [8.298, 5.818], [10.363, 5.673], [12.224, 6.581], [13.382, 8.298]];  // corner hole, 12 points
void_4 = [[84.327, 41.163], [83.419, 43.024], [81.702, 44.182], [79.637, 44.327], [77.776, 43.419], [76.618, 41.702], [76.473, 39.637], [77.381, 37.776], [79.098, 36.618], [81.163, 36.473], [83.024, 37.381], [84.182, 39.098]];  // corner hole, 12 points
void_5 = [[84.327, 10.363], [83.419, 12.224], [81.702, 13.382], [79.637, 13.527], [77.776, 12.619], [76.618, 10.902], [76.473, 8.837], [77.381, 6.976], [79.098, 5.818], [81.163, 5.673], [83.024, 6.581], [84.182, 8.298]];  // corner hole, 12 points

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
