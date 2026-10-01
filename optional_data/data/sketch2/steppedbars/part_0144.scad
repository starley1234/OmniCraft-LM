$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: sidestep, 110 x 52 x 10/6.4 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 110;              // bar length, X
bar_w = 52;               // bar width, Y
plate_t = 10;             // thickness of the thick zone, Z
thin_t = 6.4;             // thickness of the thin zone
corner_c = 3;             // corner chamfer of the bar
step_cut = 3.6;           // material removed from the thin zone
ledge_y = 33.3;           // start of the ledge from the front edge
depth_1 = 3.6;            // depth of cut 1 from the top face

profile = [[3, 0], [107, 0], [110, 3], [110, 49], [107, 52], [3, 52], [0, 49], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[-1, 33.3], [111, 33.3], [111, 53], [-1, 53]];  // ledge cut along one edge, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
}
