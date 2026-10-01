$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 1 voids, 70 x 80 x 10 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 70;             // plate length, X
plate_w = 80;             // plate width, Y
plate_t = 10;             // plate thickness, Z
edge_margin = 10;         // wall from the plate edge to any window
win1_l = 40.7;            // window length
win1_w = 52.5;            // window width
depth_1 = 4;              // depth of void 1 (full thickness = through)
corner_c = 3;             // corner chamfer of the plate
fit_tol = 0.05;           // declared fit tolerance (prompt contract)
free_tol = 0.3;           // declared free tolerance (prompt contract)

profile = [[3, 0], [67, 0], [70, 3], [70, 77], [67, 80], [3, 80], [0, 77], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[14.65, 13.75], [55.35, 13.75], [55.35, 66.25], [14.65, 66.25]];  // large central window, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
}
