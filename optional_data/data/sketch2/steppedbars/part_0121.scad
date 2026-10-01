$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: sidestep, 130 x 46 x 12/7.5 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 130;              // bar length, X
bar_w = 46;               // bar width, Y
plate_t = 12;             // thickness of the thick zone, Z
thin_t = 7.5;             // thickness of the thin zone
corner_c = 2;             // corner chamfer of the bar
step_cut = 4.5;           // material removed from the thin zone
ledge_y = 28.1;           // start of the ledge from the front edge
depth_1 = 4.5;            // depth of cut 1 from the top face

profile = [[2, 0], [128, 0], [130, 2], [130, 44], [128, 46], [2, 46], [0, 44], [0, 2]];  // primary outline, 8 points, counter clockwise
void_1 = [[-1, 28.1], [131, 28.1], [131, 47], [-1, 47]];  // ledge cut along one edge, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
}
