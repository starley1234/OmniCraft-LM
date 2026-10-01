$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: sidestep, 130 x 40 x 12/4.1 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 130;              // bar length, X
bar_w = 40;               // bar width, Y
plate_t = 12;             // thickness of the thick zone, Z
thin_t = 4.1;             // thickness of the thin zone
corner_c = 3;             // corner chamfer of the bar
step_cut = 7.9;           // material removed from the thin zone
ledge_y = 24.4;           // start of the ledge from the front edge
depth_1 = 7.9;            // depth of cut 1 from the top face

profile = [[3, 0], [127, 0], [130, 3], [130, 37], [127, 40], [3, 40], [0, 37], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[-1, 24.4], [131, 24.4], [131, 41], [-1, 41]];  // ledge cut along one edge, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
}
