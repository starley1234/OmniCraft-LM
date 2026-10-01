$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 2 voids, 100 x 80 x 5 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 100;            // plate length, X
plate_w = 80;             // plate width, Y
plate_t = 5;              // plate thickness, Z
edge_margin = 12;         // wall from the plate edge to any window
windows = 2;              // number of windows in the row
win_l = 15;               // window length
win_w = 14;               // window width
win_pitch = 38;           // window pitch along X
depth_1 = 1.9;            // depth of void 1 (full thickness = through)
depth_2 = 5;              // depth of void 2 (full thickness = through)
corner_c = 2;             // corner chamfer of the plate

profile = [[2, 0], [98, 0], [100, 2], [100, 78], [98, 80], [2, 80], [0, 78], [0, 2]];  // primary outline, 8 points, counter clockwise
void_1 = [[23.5, 33], [38.5, 33], [38.5, 47], [23.5, 47]];  // window 1 of the row, 4 points
void_2 = [[61.5, 33], [76.5, 33], [76.5, 47], [61.5, 47]];  // window 2 of the row, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_2);
}
