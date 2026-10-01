$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: sidestep, 120 x 52 x 12/4.1 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 120;              // bar length, X
bar_w = 52;               // bar width, Y
plate_t = 12;             // thickness of the thick zone, Z
thin_t = 4.1;             // thickness of the thin zone
corner_c = 2.5;           // corner chamfer of the bar
step_cut = 7.9;           // material removed from the thin zone
ledge_y = 32.8;           // start of the ledge from the front edge
depth_1 = 7.9;            // depth of cut 1 from the top face
fit_tol = 0.05;           // declared fit tolerance (prompt contract)
free_tol = 0.3;           // declared free tolerance (prompt contract)

profile = [[2.5, 0], [117.5, 0], [120, 2.5], [120, 49.5], [117.5, 52], [2.5, 52], [0, 49.5], [0, 2.5]];  // primary outline, 8 points, counter clockwise
void_1 = [[-1, 32.8], [121, 32.8], [121, 53], [-1, 53]];  // ledge cut along one edge, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
}
