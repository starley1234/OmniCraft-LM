$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: sidestep, 90 x 52 x 8/3.7 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 90;               // bar length, X
bar_w = 52;               // bar width, Y
plate_t = 8;              // thickness of the thick zone, Z
thin_t = 3.7;             // thickness of the thin zone
corner_c = 3;             // corner chamfer of the bar
step_cut = 4.3;           // material removed from the thin zone
ledge_y = 28.1;           // start of the ledge from the front edge
depth_1 = 4.3;            // depth of cut 1 from the top face
fit_tol = 0.05;           // declared fit tolerance (prompt contract)
free_tol = 0.3;           // declared free tolerance (prompt contract)

profile = [[3, 0], [87, 0], [90, 3], [90, 49], [87, 52], [3, 52], [0, 49], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[-1, 28.1], [91, 28.1], [91, 53], [-1, 53]];  // ledge cut along one edge, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
}
