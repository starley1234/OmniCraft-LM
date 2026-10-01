$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 1 voids, 120 x 45 x 6 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 120;            // plate length, X
plate_w = 45;             // plate width, Y
plate_t = 6;              // plate thickness, Z
edge_margin = 10;         // wall from the plate edge to any window
win1_l = 90;              // window length
win1_w = 13.8;            // window width
depth_1 = 6;              // depth of void 1 (full thickness = through)
corner_c = 3;             // corner chamfer of the plate
fit_tol = 0.1;            // declared fit tolerance (prompt contract)
free_tol = 0.5;           // declared free tolerance (prompt contract)

profile = [[3, 0], [117, 0], [120, 3], [120, 42], [117, 45], [3, 45], [0, 42], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[15, 15.6], [105, 15.6], [105, 29.4], [15, 29.4]];  // large central window, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
