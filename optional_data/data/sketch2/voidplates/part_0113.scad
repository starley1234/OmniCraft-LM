$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 2 voids, 120 x 50 x 6 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 120;            // plate length, X
plate_w = 50;             // plate width, Y
plate_t = 6;              // plate thickness, Z
edge_margin = 12;         // wall from the plate edge to any window
windows = 2;              // number of windows in the row
win_l = 15;               // window length
win_w = 12;               // window width
win_pitch = 48;           // window pitch along X
depth_1 = 2.8;            // depth of void 1 (full thickness = through)
depth_2 = 2;              // depth of void 2 (full thickness = through)
corner_c = 4;             // corner chamfer of the plate
fit_tol = 0.02;           // declared fit tolerance (prompt contract)
free_tol = 0.2;           // declared free tolerance (prompt contract)

profile = [[4, 0], [116, 0], [120, 4], [120, 46], [116, 50], [4, 50], [0, 46], [0, 4]];  // primary outline, 8 points, counter clockwise
void_1 = [[28.5, 19], [43.5, 19], [43.5, 31], [28.5, 31]];  // window 1 of the row, 4 points
void_2 = [[76.5, 19], [91.5, 19], [91.5, 31], [76.5, 31]];  // window 2 of the row, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
  translate([0, 0, plate_t - depth_2])
    linear_extrude(height = depth_2 + 1) polygon(points = void_2);
}
