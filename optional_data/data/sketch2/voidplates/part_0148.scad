$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 1 voids, 90 x 60 x 6 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 90;             // plate length, X
plate_w = 60;             // plate width, Y
plate_t = 6;              // plate thickness, Z
edge_margin = 8;          // wall from the plate edge to any window
win1_l = 65.5;            // window length
win1_w = 37.8;            // window width
depth_1 = 6;              // depth of void 1 (full thickness = through)
corner_c = 2;             // corner chamfer of the plate
fit_tol = 0.1;            // declared fit tolerance (prompt contract)
free_tol = 0.5;           // declared free tolerance (prompt contract)

profile = [[2, 0], [88, 0], [90, 2], [90, 58], [88, 60], [2, 60], [0, 58], [0, 2]];  // primary outline, 8 points, counter clockwise
void_1 = [[12.25, 11.1], [77.75, 11.1], [77.75, 48.9], [12.25, 48.9]];  // large central window, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
