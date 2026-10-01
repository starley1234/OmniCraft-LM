$fn = 32;

// ----------------------------------------------------------------------
// Bracket plate: slot plate 90 x 40
// ----------------------------------------------------------------------

// --- parameters (mm) ---
hole_r = 4;               // bolt hole radius
plate_t = 6;              // plate thickness, Z (extrusion height)
plate_l = 90;             // plate length
plate_w = 40;             // plate width
slot_l = 32;              // slot straight length
slot_r = 4;               // slot end radius

slot_len = slot_l + 2 * slot_r;
slot_w = 2 * slot_r;
hole_d2 = 2 * hole_r;

profile = [[4, 0], [86, 0], [90, 4], [90, 36], [86, 40], [4, 40], [0, 36], [0, 4]];  // primary outline, 8 points, counter clockwise
void_1 = [[61, 16], [62.531, 16.304], [63.828, 17.172], [64.696, 18.469], [65, 20], [64.696, 21.531], [63.828, 22.828], [62.531, 23.696], [61, 24], [29, 24], [27.469, 23.696], [26.172, 22.828], [25.304, 21.531], [25, 20], [25.304, 18.469], [26.172, 17.172], [27.469, 16.304], [29, 16]];  // grip slot, 18 points
void_2 = [[13.527, 31.163], [12.619, 33.024], [10.902, 34.182], [8.837, 34.327], [6.976, 33.419], [5.818, 31.702], [5.673, 29.637], [6.581, 27.776], [8.298, 26.618], [10.363, 26.473], [12.224, 27.381], [13.382, 29.098]];  // corner hole, 12 points
void_3 = [[13.527, 10.363], [12.619, 12.224], [10.902, 13.382], [8.837, 13.527], [6.976, 12.619], [5.818, 10.902], [5.673, 8.837], [6.581, 6.976], [8.298, 5.818], [10.363, 5.673], [12.224, 6.581], [13.382, 8.298]];  // corner hole, 12 points
void_4 = [[84.327, 31.163], [83.419, 33.024], [81.702, 34.182], [79.637, 34.327], [77.776, 33.419], [76.618, 31.702], [76.473, 29.637], [77.381, 27.776], [79.098, 26.618], [81.163, 26.473], [83.024, 27.381], [84.182, 29.098]];  // corner hole, 12 points
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
