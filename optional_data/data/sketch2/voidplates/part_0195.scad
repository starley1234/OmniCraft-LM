$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 2 voids, 120 x 70 x 6 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 120;            // plate length, X
plate_w = 70;             // plate width, Y
plate_t = 6;              // plate thickness, Z
edge_margin = 12;         // wall from the plate edge to any window
windows = 2;              // number of windows in the row
win_l = 12;               // window length
win_w = 12;               // window width
win_pitch = 48;           // window pitch along X
depth_1 = 6;              // depth of void 1 (full thickness = through)
depth_2 = 6;              // depth of void 2 (full thickness = through)
corner_c = 5;             // corner chamfer of the plate

profile = [[5, 0], [115, 0], [120, 5], [120, 65], [115, 70], [5, 70], [0, 65], [0, 5]];  // primary outline, 8 points, counter clockwise
void_1 = [[30, 29], [42, 29], [42, 41], [30, 41]];  // window 1 of the row, 4 points
void_2 = [[78, 29], [90, 29], [90, 41], [78, 41]];  // window 2 of the row, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_2);
}
