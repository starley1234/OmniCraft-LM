$fn = 32;

// ----------------------------------------------------------------------
// Bracket plate: slot plate 80 x 50
// ----------------------------------------------------------------------

// --- parameters (mm) ---
hole_r = 4;               // bolt hole radius
plate_t = 8;              // plate thickness, Z (extrusion height)
plate_l = 80;             // plate length
plate_w = 50;             // plate width
slot_l = 28;              // slot straight length
slot_r = 5;               // slot end radius

slot_len = slot_l + 2 * slot_r;
slot_w = 2 * slot_r;
hole_d2 = 2 * hole_r;

profile = [[4, 0], [76, 0], [80, 4], [80, 46], [76, 50], [4, 50], [0, 46], [0, 4]];  // primary outline, 8 points, counter clockwise
void_1 = [[54, 20], [55.913, 20.381], [57.536, 21.464], [58.619, 23.087], [59, 25], [58.619, 26.913], [57.536, 28.536], [55.913, 29.619], [54, 30], [26, 30], [24.087, 29.619], [22.464, 28.536], [21.381, 26.913], [21, 25], [21.381, 23.087], [22.464, 21.464], [24.087, 20.381], [26, 20]];  // grip slot, 18 points
void_2 = [[13.527, 41.163], [12.619, 43.024], [10.902, 44.182], [8.837, 44.327], [6.976, 43.419], [5.818, 41.702], [5.673, 39.637], [6.581, 37.776], [8.298, 36.618], [10.363, 36.473], [12.224, 37.381], [13.382, 39.098]];  // corner hole, 12 points
void_3 = [[13.527, 10.363], [12.619, 12.224], [10.902, 13.382], [8.837, 13.527], [6.976, 12.619], [5.818, 10.902], [5.673, 8.837], [6.581, 6.976], [8.298, 5.818], [10.363, 5.673], [12.224, 6.581], [13.382, 8.298]];  // corner hole, 12 points
void_4 = [[74.327, 41.163], [73.419, 43.024], [71.702, 44.182], [69.637, 44.327], [67.776, 43.419], [66.618, 41.702], [66.473, 39.637], [67.381, 37.776], [69.098, 36.618], [71.163, 36.473], [73.024, 37.381], [74.182, 39.098]];  // corner hole, 12 points
void_5 = [[74.327, 10.363], [73.419, 12.224], [71.702, 13.382], [69.637, 13.527], [67.776, 12.619], [66.618, 10.902], [66.473, 8.837], [67.381, 6.976], [69.098, 5.818], [71.163, 5.673], [73.024, 6.581], [74.182, 8.298]];  // corner hole, 12 points

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
