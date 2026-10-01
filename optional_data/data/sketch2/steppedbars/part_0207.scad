$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: centerstep, 100 x 34 x 12/4.8 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 100;              // bar length, X
bar_w = 34;               // bar width, Y
plate_t = 12;             // thickness of the thick zone, Z
thin_t = 4.8;             // thickness of the thin zone
corner_c = 2;             // corner chamfer of the bar
step_cut = 7.2;           // material removed from the thin zone
thick_from = 20;          // start of the thick middle zone
thick_to = 77;            // end of the thick middle zone
depth_1 = 7.2;            // depth of cut 1 from the top face
depth_2 = 7.2;            // depth of cut 2 from the top face
fit_tol = 0.1;            // declared fit tolerance (prompt contract)
free_tol = 0.3;           // declared free tolerance (prompt contract)

profile = [[2, 0], [98, 0], [100, 2], [100, 32], [98, 34], [2, 34], [0, 32], [0, 2]];  // primary outline, 8 points, counter clockwise
void_1 = [[-1, -1], [20, -1], [20, 35], [-1, 35]];  // thin left end, 4 points
void_2 = [[77, -1], [101, -1], [101, 35], [77, 35]];  // thin right end, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
  translate([0, 0, plate_t - depth_2])
    linear_extrude(height = depth_2 + 1) polygon(points = void_2);
}
