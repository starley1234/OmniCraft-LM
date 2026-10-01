$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 1 voids, 90 x 70 x 5 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 90;             // plate length, X
plate_w = 70;             // plate width, Y
plate_t = 5;              // plate thickness, Z
edge_margin = 12;         // wall from the plate edge to any window
win1_l = 52.8;            // window length
win1_w = 38.3;            // window width
depth_1 = 5;              // depth of void 1 (full thickness = through)
corner_c = 5;             // corner chamfer of the plate
fit_tol = 0.1;            // declared fit tolerance (prompt contract)
free_tol = 0.3;           // declared free tolerance (prompt contract)

profile = [[5, 0], [85, 0], [90, 5], [90, 65], [85, 70], [5, 70], [0, 65], [0, 5]];  // primary outline, 8 points, counter clockwise
void_1 = [[18.6, 15.85], [71.4, 15.85], [71.4, 54.15], [18.6, 54.15]];  // large central window, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
