$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 3 voids, 110 x 60 x 10 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 110;            // plate length, X
plate_w = 60;             // plate width, Y
plate_t = 10;             // plate thickness, Z
edge_margin = 10;         // wall from the plate edge to any window
windows = 3;              // number of windows in the row
win_l = 12;               // window length
win_w = 10;               // window width
win_pitch = 30;           // window pitch along X
depth_1 = 2.9;            // depth of void 1 (full thickness = through)
depth_2 = 3.8;            // depth of void 2 (full thickness = through)
depth_3 = 6.8;            // depth of void 3 (full thickness = through)
corner_c = 5;             // corner chamfer of the plate
fit_tol = 0.1;            // declared fit tolerance (prompt contract)
free_tol = 0.3;           // declared free tolerance (prompt contract)

profile = [[5, 0], [105, 0], [110, 5], [110, 55], [105, 60], [5, 60], [0, 55], [0, 5]];  // primary outline, 8 points, counter clockwise
void_1 = [[19, 25], [31, 25], [31, 35], [19, 35]];  // window 1 of the row, 4 points
void_2 = [[49, 25], [61, 25], [61, 35], [49, 35]];  // window 2 of the row, 4 points
void_3 = [[79, 25], [91, 25], [91, 35], [79, 35]];  // window 3 of the row, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
  translate([0, 0, plate_t - depth_2])
    linear_extrude(height = depth_2 + 1) polygon(points = void_2);
  translate([0, 0, plate_t - depth_3])
    linear_extrude(height = depth_3 + 1) polygon(points = void_3);
}
