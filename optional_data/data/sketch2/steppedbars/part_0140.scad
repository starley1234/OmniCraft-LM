$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: sidestep, 100 x 46 x 12/5 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 100;              // bar length, X
bar_w = 46;               // bar width, Y
plate_t = 12;             // thickness of the thick zone, Z
thin_t = 5;               // thickness of the thin zone
corner_c = 3;             // corner chamfer of the bar
step_cut = 7;             // material removed from the thin zone
ledge_y = 26.2;           // start of the ledge from the front edge
depth_1 = 7;              // depth of cut 1 from the top face
fit_tol = 0.1;            // declared fit tolerance (prompt contract)
free_tol = 0.5;           // declared free tolerance (prompt contract)

profile = [[3, 0], [97, 0], [100, 3], [100, 43], [97, 46], [3, 46], [0, 43], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[-1, 26.2], [101, 26.2], [101, 47], [-1, 47]];  // ledge cut along one edge, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
}
