$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: sidestep, 130 x 34 x 12/2.9 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 130;              // bar length, X
bar_w = 34;               // bar width, Y
plate_t = 12;             // thickness of the thick zone, Z
thin_t = 2.9;             // thickness of the thin zone
corner_c = 2;             // corner chamfer of the bar
step_cut = 9.1;           // material removed from the thin zone
ledge_y = 20.4;           // start of the ledge from the front edge
depth_1 = 9.1;            // depth of cut 1 from the top face

profile = [[2, 0], [128, 0], [130, 2], [130, 32], [128, 34], [2, 34], [0, 32], [0, 2]];  // primary outline, 8 points, counter clockwise
void_1 = [[-1, 20.4], [131, 20.4], [131, 35], [-1, 35]];  // ledge cut along one edge, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
}
