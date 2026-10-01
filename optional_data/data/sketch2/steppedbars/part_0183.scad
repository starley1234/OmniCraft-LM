$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: centerstep, 120 x 34 x 12/8.6 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 120;              // bar length, X
bar_w = 34;               // bar width, Y
plate_t = 12;             // thickness of the thick zone, Z
thin_t = 8.6;             // thickness of the thin zone
corner_c = 2;             // corner chamfer of the bar
step_cut = 3.4;           // material removed from the thin zone
thick_from = 37.2;        // start of the thick middle zone
thick_to = 84;            // end of the thick middle zone
depth_1 = 3.4;            // depth of cut 1 from the top face
depth_2 = 3.4;            // depth of cut 2 from the top face
fit_tol = 0.05;           // declared fit tolerance (prompt contract)
free_tol = 0.3;           // declared free tolerance (prompt contract)

profile = [[2, 0], [118, 0], [120, 2], [120, 32], [118, 34], [2, 34], [0, 32], [0, 2]];  // primary outline, 8 points, counter clockwise
void_1 = [[-1, -1], [37.2, -1], [37.2, 35], [-1, 35]];  // thin left end, 4 points
void_2 = [[84, -1], [121, -1], [121, 35], [84, 35]];  // thin right end, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
  translate([0, 0, plate_t - depth_2])
    linear_extrude(height = depth_2 + 1) polygon(points = void_2);
}
