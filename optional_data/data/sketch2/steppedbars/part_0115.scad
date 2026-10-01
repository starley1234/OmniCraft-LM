$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: sidestep, 130 x 40 x 10/6.9 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 130;              // bar length, X
bar_w = 40;               // bar width, Y
plate_t = 10;             // thickness of the thick zone, Z
thin_t = 6.9;             // thickness of the thin zone
corner_c = 2.5;           // corner chamfer of the bar
step_cut = 3.1;           // material removed from the thin zone
ledge_y = 21.2;           // start of the ledge from the front edge
depth_1 = 3.1;            // depth of cut 1 from the top face

profile = [[2.5, 0], [127.5, 0], [130, 2.5], [130, 37.5], [127.5, 40], [2.5, 40], [0, 37.5], [0, 2.5]];  // primary outline, 8 points, counter clockwise
void_1 = [[-1, 21.2], [131, 21.2], [131, 41], [-1, 41]];  // ledge cut along one edge, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
}
