$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: centerstep, 130 x 52 x 8/5.2 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 130;              // bar length, X
bar_w = 52;               // bar width, Y
plate_t = 8;              // thickness of the thick zone, Z
thin_t = 5.2;             // thickness of the thin zone
corner_c = 2.5;           // corner chamfer of the bar
step_cut = 2.8;           // material removed from the thin zone
thick_from = 33.8;        // start of the thick middle zone
thick_to = 102.7;         // end of the thick middle zone
depth_1 = 2.8;            // depth of cut 1 from the top face
depth_2 = 2.8;            // depth of cut 2 from the top face
fit_tol = 0.02;           // declared fit tolerance (prompt contract)
free_tol = 0.2;           // declared free tolerance (prompt contract)

profile = [[2.5, 0], [127.5, 0], [130, 2.5], [130, 49.5], [127.5, 52], [2.5, 52], [0, 49.5], [0, 2.5]];  // primary outline, 8 points, counter clockwise
void_1 = [[-1, -1], [33.8, -1], [33.8, 53], [-1, 53]];  // thin left end, 4 points
void_2 = [[102.7, -1], [131, -1], [131, 53], [102.7, 53]];  // thin right end, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
  translate([0, 0, plate_t - depth_2])
    linear_extrude(height = depth_2 + 1) polygon(points = void_2);
}
