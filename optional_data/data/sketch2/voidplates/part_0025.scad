$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 2 voids, 110 x 45 x 8 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 110;            // plate length, X
plate_w = 45;             // plate width, Y
plate_t = 8;              // plate thickness, Z
edge_margin = 12;         // wall from the plate edge to any window
windows = 2;              // number of windows in the row
win_l = 18;               // window length
win_w = 10;               // window width
win_pitch = 43;           // window pitch along X
depth_1 = 8;              // depth of void 1 (full thickness = through)
depth_2 = 2.8;            // depth of void 2 (full thickness = through)
corner_c = 5;             // corner chamfer of the plate

profile = [[5, 0], [105, 0], [110, 5], [110, 40], [105, 45], [5, 45], [0, 40], [0, 5]];  // primary outline, 8 points, counter clockwise
void_1 = [[24.5, 17.5], [42.5, 17.5], [42.5, 27.5], [24.5, 27.5]];  // window 1 of the row, 4 points
void_2 = [[67.5, 17.5], [85.5, 17.5], [85.5, 27.5], [67.5, 27.5]];  // window 2 of the row, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
  translate([0, 0, plate_t - depth_2])
    linear_extrude(height = depth_2 + 1) polygon(points = void_2);
}
