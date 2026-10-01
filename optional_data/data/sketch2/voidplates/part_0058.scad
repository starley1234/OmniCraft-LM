$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 2 voids, 110 x 45 x 10 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 110;            // plate length, X
plate_w = 45;             // plate width, Y
plate_t = 10;             // plate thickness, Z
edge_margin = 12;         // wall from the plate edge to any window
windows = 2;              // number of windows in the row
win_l = 12;               // window length
win_w = 14;               // window width
win_pitch = 43;           // window pitch along X
depth_1 = 5.7;            // depth of void 1 (full thickness = through)
depth_2 = 7.2;            // depth of void 2 (full thickness = through)
corner_c = 3;             // corner chamfer of the plate

profile = [[3, 0], [107, 0], [110, 3], [110, 42], [107, 45], [3, 45], [0, 42], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[27.5, 15.5], [39.5, 15.5], [39.5, 29.5], [27.5, 29.5]];  // window 1 of the row, 4 points
void_2 = [[70.5, 15.5], [82.5, 15.5], [82.5, 29.5], [70.5, 29.5]];  // window 2 of the row, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
  translate([0, 0, plate_t - depth_2])
    linear_extrude(height = depth_2 + 1) polygon(points = void_2);
}
