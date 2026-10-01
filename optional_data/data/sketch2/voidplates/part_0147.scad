$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 2 voids, 120 x 50 x 6 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 120;            // plate length, X
plate_w = 50;             // plate width, Y
plate_t = 6;              // plate thickness, Z
edge_margin = 10;         // wall from the plate edge to any window
windows = 2;              // number of windows in the row
win_l = 12;               // window length
win_w = 12;               // window width
win_pitch = 50;           // window pitch along X
depth_1 = 6;              // depth of void 1 (full thickness = through)
depth_2 = 3.1;            // depth of void 2 (full thickness = through)
corner_c = 2;             // corner chamfer of the plate
fit_tol = 0.1;            // declared fit tolerance (prompt contract)
free_tol = 0.5;           // declared free tolerance (prompt contract)

profile = [[2, 0], [118, 0], [120, 2], [120, 48], [118, 50], [2, 50], [0, 48], [0, 2]];  // primary outline, 8 points, counter clockwise
void_1 = [[29, 19], [41, 19], [41, 31], [29, 31]];  // window 1 of the row, 4 points
void_2 = [[79, 19], [91, 19], [91, 31], [79, 31]];  // window 2 of the row, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
  translate([0, 0, plate_t - depth_2])
    linear_extrude(height = depth_2 + 1) polygon(points = void_2);
}
