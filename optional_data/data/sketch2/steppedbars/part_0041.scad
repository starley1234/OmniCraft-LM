$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: sidestep, 110 x 46 x 10/6.4 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 110;              // bar length, X
bar_w = 46;               // bar width, Y
plate_t = 10;             // thickness of the thick zone, Z
thin_t = 6.4;             // thickness of the thin zone
corner_c = 2.5;           // corner chamfer of the bar
step_cut = 3.6;           // material removed from the thin zone
ledge_y = 23.5;           // start of the ledge from the front edge
depth_1 = 3.6;            // depth of cut 1 from the top face
fit_tol = 0.05;           // declared fit tolerance (prompt contract)
free_tol = 0.2;           // declared free tolerance (prompt contract)

profile = [[2.5, 0], [107.5, 0], [110, 2.5], [110, 43.5], [107.5, 46], [2.5, 46], [0, 43.5], [0, 2.5]];  // primary outline, 8 points, counter clockwise
void_1 = [[-1, 23.5], [111, 23.5], [111, 47], [-1, 47]];  // ledge cut along one edge, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
}
