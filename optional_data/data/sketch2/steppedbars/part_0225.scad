$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: sidestep, 90 x 52 x 12/7.2 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 90;               // bar length, X
bar_w = 52;               // bar width, Y
plate_t = 12;             // thickness of the thick zone, Z
thin_t = 7.2;             // thickness of the thin zone
corner_c = 2.5;           // corner chamfer of the bar
step_cut = 4.8;           // material removed from the thin zone
ledge_y = 29.6;           // start of the ledge from the front edge
depth_1 = 4.8;            // depth of cut 1 from the top face
fit_tol = 0.1;            // declared fit tolerance (prompt contract)
free_tol = 0.5;           // declared free tolerance (prompt contract)

profile = [[2.5, 0], [87.5, 0], [90, 2.5], [90, 49.5], [87.5, 52], [2.5, 52], [0, 49.5], [0, 2.5]];  // primary outline, 8 points, counter clockwise
void_1 = [[-1, 29.6], [91, 29.6], [91, 53], [-1, 53]];  // ledge cut along one edge, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
}
