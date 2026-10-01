$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: sidestep, 110 x 34 x 10/5.1 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 110;              // bar length, X
bar_w = 34;               // bar width, Y
plate_t = 10;             // thickness of the thick zone, Z
thin_t = 5.1;             // thickness of the thin zone
corner_c = 2.5;           // corner chamfer of the bar
step_cut = 4.9;           // material removed from the thin zone
ledge_y = 19.7;           // start of the ledge from the front edge
depth_1 = 4.9;            // depth of cut 1 from the top face

profile = [[2.5, 0], [107.5, 0], [110, 2.5], [110, 31.5], [107.5, 34], [2.5, 34], [0, 31.5], [0, 2.5]];  // primary outline, 8 points, counter clockwise
void_1 = [[-1, 19.7], [111, 19.7], [111, 35], [-1, 35]];  // ledge cut along one edge, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
}
