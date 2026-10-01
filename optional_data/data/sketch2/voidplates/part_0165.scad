$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 1 voids, 100 x 70 x 6 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 100;            // plate length, X
plate_w = 70;             // plate width, Y
plate_t = 6;              // plate thickness, Z
edge_margin = 10;         // wall from the plate edge to any window
win1_l = 68.5;            // window length
win1_w = 43;              // window width
depth_1 = 1.6;            // depth of void 1 (full thickness = through)
corner_c = 2.5;           // corner chamfer of the plate
fit_tol = 0.05;           // declared fit tolerance (prompt contract)
free_tol = 0.3;           // declared free tolerance (prompt contract)

profile = [[2.5, 0], [97.5, 0], [100, 2.5], [100, 67.5], [97.5, 70], [2.5, 70], [0, 67.5], [0, 2.5]];  // primary outline, 8 points, counter clockwise
void_1 = [[15.75, 13.5], [84.25, 13.5], [84.25, 56.5], [15.75, 56.5]];  // large central window, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
}
