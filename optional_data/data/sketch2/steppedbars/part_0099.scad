$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: sidestep, 100 x 34 x 10/3.3 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 100;              // bar length, X
bar_w = 34;               // bar width, Y
plate_t = 10;             // thickness of the thick zone, Z
thin_t = 3.3;             // thickness of the thin zone
corner_c = 2;             // corner chamfer of the bar
step_cut = 6.7;           // material removed from the thin zone
ledge_y = 20.7;           // start of the ledge from the front edge
depth_1 = 6.7;            // depth of cut 1 from the top face

profile = [[2, 0], [98, 0], [100, 2], [100, 32], [98, 34], [2, 34], [0, 32], [0, 2]];  // primary outline, 8 points, counter clockwise
void_1 = [[-1, 20.7], [101, 20.7], [101, 35], [-1, 35]];  // ledge cut along one edge, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
}
