$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 2 voids, 70 x 45 x 10 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 70;             // plate length, X
plate_w = 45;             // plate width, Y
plate_t = 10;             // plate thickness, Z
edge_margin = 8;          // wall from the plate edge to any window
windows = 2;              // number of windows in the row
win_l = 18;               // window length
win_w = 10;               // window width
win_pitch = 27;           // window pitch along X
depth_1 = 8.1;            // depth of void 1 (full thickness = through)
depth_2 = 4.6;            // depth of void 2 (full thickness = through)
corner_c = 3;             // corner chamfer of the plate
fit_tol = 0.1;            // declared fit tolerance (prompt contract)
free_tol = 0.5;           // declared free tolerance (prompt contract)

profile = [[3, 0], [67, 0], [70, 3], [70, 42], [67, 45], [3, 45], [0, 42], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[12.5, 17.5], [30.5, 17.5], [30.5, 27.5], [12.5, 27.5]];  // window 1 of the row, 4 points
void_2 = [[39.5, 17.5], [57.5, 17.5], [57.5, 27.5], [39.5, 27.5]];  // window 2 of the row, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
  translate([0, 0, plate_t - depth_2])
    linear_extrude(height = depth_2 + 1) polygon(points = void_2);
}
