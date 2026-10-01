$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 1 voids, 80 x 45 x 5 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 80;             // plate length, X
plate_w = 45;             // plate width, Y
plate_t = 5;              // plate thickness, Z
edge_margin = 12;         // wall from the plate edge to any window
win1_l = 44.3;            // window length
win1_w = 9.3;             // window width
depth_1 = 5;              // depth of void 1 (full thickness = through)
corner_c = 5;             // corner chamfer of the plate
fit_tol = 0.05;           // declared fit tolerance (prompt contract)
free_tol = 0.2;           // declared free tolerance (prompt contract)

profile = [[5, 0], [75, 0], [80, 5], [80, 40], [75, 45], [5, 45], [0, 40], [0, 5]];  // primary outline, 8 points, counter clockwise
void_1 = [[17.85, 17.85], [62.15, 17.85], [62.15, 27.15], [17.85, 27.15]];  // large central window, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
