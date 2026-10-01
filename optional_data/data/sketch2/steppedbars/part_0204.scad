$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: sidestep, 100 x 40 x 12/5.6 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 100;              // bar length, X
bar_w = 40;               // bar width, Y
plate_t = 12;             // thickness of the thick zone, Z
thin_t = 5.6;             // thickness of the thin zone
corner_c = 2.5;           // corner chamfer of the bar
step_cut = 6.4;           // material removed from the thin zone
ledge_y = 23.2;           // start of the ledge from the front edge
depth_1 = 6.4;            // depth of cut 1 from the top face

profile = [[2.5, 0], [97.5, 0], [100, 2.5], [100, 37.5], [97.5, 40], [2.5, 40], [0, 37.5], [0, 2.5]];  // primary outline, 8 points, counter clockwise
void_1 = [[-1, 23.2], [101, 23.2], [101, 41], [-1, 41]];  // ledge cut along one edge, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
}
