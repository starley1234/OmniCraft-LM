$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: sidestep, 120 x 46 x 10/4.3 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 120;              // bar length, X
bar_w = 46;               // bar width, Y
plate_t = 10;             // thickness of the thick zone, Z
thin_t = 4.3;             // thickness of the thin zone
corner_c = 2.5;           // corner chamfer of the bar
step_cut = 5.7;           // material removed from the thin zone
ledge_y = 28.1;           // start of the ledge from the front edge
depth_1 = 5.7;            // depth of cut 1 from the top face
fit_tol = 0.1;            // declared fit tolerance (prompt contract)
free_tol = 0.5;           // declared free tolerance (prompt contract)

profile = [[2.5, 0], [117.5, 0], [120, 2.5], [120, 43.5], [117.5, 46], [2.5, 46], [0, 43.5], [0, 2.5]];  // primary outline, 8 points, counter clockwise
void_1 = [[-1, 28.1], [121, 28.1], [121, 47], [-1, 47]];  // ledge cut along one edge, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
}
