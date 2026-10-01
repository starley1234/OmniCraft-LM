$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 1 voids, 90 x 80 x 5 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 90;             // plate length, X
plate_w = 80;             // plate width, Y
plate_t = 5;              // plate thickness, Z
edge_margin = 8;          // wall from the plate edge to any window
win1_l = 60.9;            // window length
win1_w = 53.5;            // window width
depth_1 = 5;              // depth of void 1 (full thickness = through)
corner_c = 2.5;           // corner chamfer of the plate
fit_tol = 0.05;           // declared fit tolerance (prompt contract)
free_tol = 0.3;           // declared free tolerance (prompt contract)

profile = [[2.5, 0], [87.5, 0], [90, 2.5], [90, 77.5], [87.5, 80], [2.5, 80], [0, 77.5], [0, 2.5]];  // primary outline, 8 points, counter clockwise
void_1 = [[14.55, 13.25], [75.45, 13.25], [75.45, 66.75], [14.55, 66.75]];  // large central window, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
