$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: centerstep, 130 x 34 x 12/4.1 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 130;              // bar length, X
bar_w = 34;               // bar width, Y
plate_t = 12;             // thickness of the thick zone, Z
thin_t = 4.1;             // thickness of the thin zone
corner_c = 2.5;           // corner chamfer of the bar
step_cut = 7.9;           // material removed from the thin zone
thick_from = 39;          // start of the thick middle zone
thick_to = 89.7;          // end of the thick middle zone
depth_1 = 7.9;            // depth of cut 1 from the top face
depth_2 = 7.9;            // depth of cut 2 from the top face
fit_tol = 0.05;           // declared fit tolerance (prompt contract)
free_tol = 0.3;           // declared free tolerance (prompt contract)

profile = [[2.5, 0], [127.5, 0], [130, 2.5], [130, 31.5], [127.5, 34], [2.5, 34], [0, 31.5], [0, 2.5]];  // primary outline, 8 points, counter clockwise
void_1 = [[-1, -1], [39, -1], [39, 35], [-1, 35]];  // thin left end, 4 points
void_2 = [[89.7, -1], [131, -1], [131, 35], [89.7, 35]];  // thin right end, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
  translate([0, 0, plate_t - depth_2])
    linear_extrude(height = depth_2 + 1) polygon(points = void_2);
}
