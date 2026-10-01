$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: sidestep, 110 x 46 x 12/4.6 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 110;              // bar length, X
bar_w = 46;               // bar width, Y
plate_t = 12;             // thickness of the thick zone, Z
thin_t = 4.6;             // thickness of the thin zone
corner_c = 2;             // corner chamfer of the bar
step_cut = 7.4;           // material removed from the thin zone
ledge_y = 28.5;           // start of the ledge from the front edge
depth_1 = 7.4;            // depth of cut 1 from the top face

profile = [[2, 0], [108, 0], [110, 2], [110, 44], [108, 46], [2, 46], [0, 44], [0, 2]];  // primary outline, 8 points, counter clockwise
void_1 = [[-1, 28.5], [111, 28.5], [111, 47], [-1, 47]];  // ledge cut along one edge, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
}
