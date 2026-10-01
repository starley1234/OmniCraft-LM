$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: sidestep, 110 x 46 x 10/4.9 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 110;              // bar length, X
bar_w = 46;               // bar width, Y
plate_t = 10;             // thickness of the thick zone, Z
thin_t = 4.9;             // thickness of the thin zone
corner_c = 3;             // corner chamfer of the bar
step_cut = 5.1;           // material removed from the thin zone
ledge_y = 27.1;           // start of the ledge from the front edge
depth_1 = 5.1;            // depth of cut 1 from the top face
fit_tol = 0.1;            // declared fit tolerance (prompt contract)
free_tol = 0.3;           // declared free tolerance (prompt contract)

profile = [[3, 0], [107, 0], [110, 3], [110, 43], [107, 46], [3, 46], [0, 43], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[-1, 27.1], [111, 27.1], [111, 47], [-1, 47]];  // ledge cut along one edge, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
}
