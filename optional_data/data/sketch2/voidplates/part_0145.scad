$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 3 voids, 120 x 80 x 8 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 120;            // plate length, X
plate_w = 80;             // plate width, Y
plate_t = 8;              // plate thickness, Z
edge_margin = 8;          // wall from the plate edge to any window
windows = 3;              // number of windows in the row
win_l = 22;               // window length
win_w = 10;               // window width
win_pitch = 34.7;         // window pitch along X
depth_1 = 8;              // depth of void 1 (full thickness = through)
depth_2 = 8;              // depth of void 2 (full thickness = through)
depth_3 = 8;              // depth of void 3 (full thickness = through)
corner_c = 2;             // corner chamfer of the plate

profile = [[2, 0], [118, 0], [120, 2], [120, 78], [118, 80], [2, 80], [0, 78], [0, 2]];  // primary outline, 8 points, counter clockwise
void_1 = [[14.35, 35], [36.35, 35], [36.35, 45], [14.35, 45]];  // window 1 of the row, 4 points
void_2 = [[49.05, 35], [71.05, 35], [71.05, 45], [49.05, 45]];  // window 2 of the row, 4 points
void_3 = [[83.75, 35], [105.75, 35], [105.75, 45], [83.75, 45]];  // window 3 of the row, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_2);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_3);
}
