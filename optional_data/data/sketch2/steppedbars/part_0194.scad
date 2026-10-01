$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: sidestep, 100 x 34 x 10/2.6 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 100;              // bar length, X
bar_w = 34;               // bar width, Y
plate_t = 10;             // thickness of the thick zone, Z
thin_t = 2.6;             // thickness of the thin zone
corner_c = 2.5;           // corner chamfer of the bar
step_cut = 7.4;           // material removed from the thin zone
ledge_y = 19.4;           // start of the ledge from the front edge
depth_1 = 7.4;            // depth of cut 1 from the top face

profile = [[2.5, 0], [97.5, 0], [100, 2.5], [100, 31.5], [97.5, 34], [2.5, 34], [0, 31.5], [0, 2.5]];  // primary outline, 8 points, counter clockwise
void_1 = [[-1, 19.4], [101, 19.4], [101, 35], [-1, 35]];  // ledge cut along one edge, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
}
