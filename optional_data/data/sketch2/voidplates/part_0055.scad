$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 2 voids, 90 x 80 x 8 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 90;             // plate length, X
plate_w = 80;             // plate width, Y
plate_t = 8;              // plate thickness, Z
edge_margin = 10;         // wall from the plate edge to any window
windows = 2;              // number of windows in the row
win_l = 12;               // window length
win_w = 10;               // window width
win_pitch = 35;           // window pitch along X
depth_1 = 8;              // depth of void 1 (full thickness = through)
depth_2 = 8;              // depth of void 2 (full thickness = through)
corner_c = 2;             // corner chamfer of the plate

profile = [[2, 0], [88, 0], [90, 2], [90, 78], [88, 80], [2, 80], [0, 78], [0, 2]];  // primary outline, 8 points, counter clockwise
void_1 = [[21.5, 35], [33.5, 35], [33.5, 45], [21.5, 45]];  // window 1 of the row, 4 points
void_2 = [[56.5, 35], [68.5, 35], [68.5, 45], [56.5, 45]];  // window 2 of the row, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_2);
}
