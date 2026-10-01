$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 2 voids, 70 x 60 x 5 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 70;             // plate length, X
plate_w = 60;             // plate width, Y
plate_t = 5;              // plate thickness, Z
edge_margin = 12;         // wall from the plate edge to any window
windows = 2;              // number of windows in the row
win_l = 15;               // window length
win_w = 10;               // window width
win_pitch = 23;           // window pitch along X
depth_1 = 5;              // depth of void 1 (full thickness = through)
depth_2 = 5;              // depth of void 2 (full thickness = through)
corner_c = 2.5;           // corner chamfer of the plate
fit_tol = 0.05;           // declared fit tolerance (prompt contract)
free_tol = 0.2;           // declared free tolerance (prompt contract)

profile = [[2.5, 0], [67.5, 0], [70, 2.5], [70, 57.5], [67.5, 60], [2.5, 60], [0, 57.5], [0, 2.5]];  // primary outline, 8 points, counter clockwise
void_1 = [[16, 25], [31, 25], [31, 35], [16, 35]];  // window 1 of the row, 4 points
void_2 = [[39, 25], [54, 25], [54, 35], [39, 35]];  // window 2 of the row, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_2);
}
