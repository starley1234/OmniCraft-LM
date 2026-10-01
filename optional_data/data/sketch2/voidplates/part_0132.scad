$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 1 voids, 90 x 50 x 8 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 90;             // plate length, X
plate_w = 50;             // plate width, Y
plate_t = 8;              // plate thickness, Z
edge_margin = 12;         // wall from the plate edge to any window
win1_l = 54.5;            // window length
win1_w = 16;              // window width
depth_1 = 8;              // depth of void 1 (full thickness = through)
corner_c = 4;             // corner chamfer of the plate
fit_tol = 0.1;            // declared fit tolerance (prompt contract)
free_tol = 0.5;           // declared free tolerance (prompt contract)

profile = [[4, 0], [86, 0], [90, 4], [90, 46], [86, 50], [4, 50], [0, 46], [0, 4]];  // primary outline, 8 points, counter clockwise
void_1 = [[17.75, 17], [72.25, 17], [72.25, 33], [17.75, 33]];  // large central window, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
