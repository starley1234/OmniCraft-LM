$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: sidestep, 100 x 40 x 8/2.9 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 100;              // bar length, X
bar_w = 40;               // bar width, Y
plate_t = 8;              // thickness of the thick zone, Z
thin_t = 2.9;             // thickness of the thin zone
corner_c = 2;             // corner chamfer of the bar
step_cut = 5.1;           // material removed from the thin zone
ledge_y = 25.6;           // start of the ledge from the front edge
depth_1 = 5.1;            // depth of cut 1 from the top face

profile = [[2, 0], [98, 0], [100, 2], [100, 38], [98, 40], [2, 40], [0, 38], [0, 2]];  // primary outline, 8 points, counter clockwise
void_1 = [[-1, 25.6], [101, 25.6], [101, 41], [-1, 41]];  // ledge cut along one edge, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
}
