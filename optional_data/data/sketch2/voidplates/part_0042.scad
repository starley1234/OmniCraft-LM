$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 1 voids, 120 x 60 x 8 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 120;            // plate length, X
plate_w = 60;             // plate width, Y
plate_t = 8;              // plate thickness, Z
edge_margin = 8;          // wall from the plate edge to any window
win1_l = 89.5;            // window length
win1_w = 34.4;            // window width
depth_1 = 8;              // depth of void 1 (full thickness = through)
corner_c = 3;             // corner chamfer of the plate
fit_tol = 0.05;           // declared fit tolerance (prompt contract)
free_tol = 0.3;           // declared free tolerance (prompt contract)

profile = [[3, 0], [117, 0], [120, 3], [120, 57], [117, 60], [3, 60], [0, 57], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[15.25, 12.8], [104.75, 12.8], [104.75, 47.2], [15.25, 47.2]];  // large central window, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
