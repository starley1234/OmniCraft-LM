$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: sidestep, 90 x 34 x 12/6.3 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 90;               // bar length, X
bar_w = 34;               // bar width, Y
plate_t = 12;             // thickness of the thick zone, Z
thin_t = 6.3;             // thickness of the thin zone
corner_c = 3;             // corner chamfer of the bar
step_cut = 5.7;           // material removed from the thin zone
ledge_y = 20.4;           // start of the ledge from the front edge
depth_1 = 5.7;            // depth of cut 1 from the top face
fit_tol = 0.1;            // declared fit tolerance (prompt contract)
free_tol = 0.5;           // declared free tolerance (prompt contract)

profile = [[3, 0], [87, 0], [90, 3], [90, 31], [87, 34], [3, 34], [0, 31], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[-1, 20.4], [91, 20.4], [91, 35], [-1, 35]];  // ledge cut along one edge, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
}
