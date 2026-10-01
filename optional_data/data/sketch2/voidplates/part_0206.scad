$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 1 voids, 110 x 70 x 8 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 110;            // plate length, X
plate_w = 70;             // plate width, Y
plate_t = 8;              // plate thickness, Z
edge_margin = 10;         // wall from the plate edge to any window
win1_l = 83.8;            // window length
win1_w = 40.2;            // window width
depth_1 = 8;              // depth of void 1 (full thickness = through)
corner_c = 2;             // corner chamfer of the plate
fit_tol = 0.1;            // declared fit tolerance (prompt contract)
free_tol = 0.3;           // declared free tolerance (prompt contract)

profile = [[2, 0], [108, 0], [110, 2], [110, 68], [108, 70], [2, 70], [0, 68], [0, 2]];  // primary outline, 8 points, counter clockwise
void_1 = [[13.1, 14.9], [96.9, 14.9], [96.9, 55.1], [13.1, 55.1]];  // large central window, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
