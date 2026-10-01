$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 1 voids, 100 x 80 x 10 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 100;            // plate length, X
plate_w = 80;             // plate width, Y
plate_t = 10;             // plate thickness, Z
edge_margin = 12;         // wall from the plate edge to any window
win1_l = 67.5;            // window length
win1_w = 48.8;            // window width
depth_1 = 10;             // depth of void 1 (full thickness = through)
corner_c = 3;             // corner chamfer of the plate
fit_tol = 0.1;            // declared fit tolerance (prompt contract)
free_tol = 0.5;           // declared free tolerance (prompt contract)

profile = [[3, 0], [97, 0], [100, 3], [100, 77], [97, 80], [3, 80], [0, 77], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[16.25, 15.6], [83.75, 15.6], [83.75, 64.4], [16.25, 64.4]];  // large central window, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
