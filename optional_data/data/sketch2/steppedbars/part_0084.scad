$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: sidestep, 130 x 52 x 8/4 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 130;              // bar length, X
bar_w = 52;               // bar width, Y
plate_t = 8;              // thickness of the thick zone, Z
thin_t = 4;               // thickness of the thin zone
corner_c = 2.5;           // corner chamfer of the bar
step_cut = 4;             // material removed from the thin zone
ledge_y = 28.1;           // start of the ledge from the front edge
depth_1 = 4;              // depth of cut 1 from the top face

profile = [[2.5, 0], [127.5, 0], [130, 2.5], [130, 49.5], [127.5, 52], [2.5, 52], [0, 49.5], [0, 2.5]];  // primary outline, 8 points, counter clockwise
void_1 = [[-1, 28.1], [131, 28.1], [131, 53], [-1, 53]];  // ledge cut along one edge, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
}
