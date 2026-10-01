$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: sidestep, 130 x 34 x 10/4.7 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 130;              // bar length, X
bar_w = 34;               // bar width, Y
plate_t = 10;             // thickness of the thick zone, Z
thin_t = 4.7;             // thickness of the thin zone
corner_c = 3;             // corner chamfer of the bar
step_cut = 5.3;           // material removed from the thin zone
ledge_y = 21.8;           // start of the ledge from the front edge
depth_1 = 5.3;            // depth of cut 1 from the top face

profile = [[3, 0], [127, 0], [130, 3], [130, 31], [127, 34], [3, 34], [0, 31], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[-1, 21.8], [131, 21.8], [131, 35], [-1, 35]];  // ledge cut along one edge, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
}
