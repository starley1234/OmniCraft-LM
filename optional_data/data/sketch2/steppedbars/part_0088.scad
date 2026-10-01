$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: sidestep, 130 x 46 x 12/3.5 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 130;              // bar length, X
bar_w = 46;               // bar width, Y
plate_t = 12;             // thickness of the thick zone, Z
thin_t = 3.5;             // thickness of the thin zone
corner_c = 3;             // corner chamfer of the bar
step_cut = 8.5;           // material removed from the thin zone
ledge_y = 24.8;           // start of the ledge from the front edge
depth_1 = 8.5;            // depth of cut 1 from the top face
fit_tol = 0.1;            // declared fit tolerance (prompt contract)
free_tol = 0.3;           // declared free tolerance (prompt contract)

profile = [[3, 0], [127, 0], [130, 3], [130, 43], [127, 46], [3, 46], [0, 43], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[-1, 24.8], [131, 24.8], [131, 47], [-1, 47]];  // ledge cut along one edge, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
}
