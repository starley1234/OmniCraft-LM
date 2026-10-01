$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 2 voids, 70 x 80 x 6 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 70;             // plate length, X
plate_w = 80;             // plate width, Y
plate_t = 6;              // plate thickness, Z
edge_margin = 10;         // wall from the plate edge to any window
windows = 2;              // number of windows in the row
win_l = 22;               // window length
win_w = 10;               // window width
win_pitch = 25;           // window pitch along X
depth_1 = 2.4;            // depth of void 1 (full thickness = through)
depth_2 = 1.8;            // depth of void 2 (full thickness = through)
corner_c = 3;             // corner chamfer of the plate

profile = [[3, 0], [67, 0], [70, 3], [70, 77], [67, 80], [3, 80], [0, 77], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[11.5, 35], [33.5, 35], [33.5, 45], [11.5, 45]];  // window 1 of the row, 4 points
void_2 = [[36.5, 35], [58.5, 35], [58.5, 45], [36.5, 45]];  // window 2 of the row, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
  translate([0, 0, plate_t - depth_2])
    linear_extrude(height = depth_2 + 1) polygon(points = void_2);
}
