$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: sidestep, 90 x 46 x 8/4.8 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 90;               // bar length, X
bar_w = 46;               // bar width, Y
plate_t = 8;              // thickness of the thick zone, Z
thin_t = 4.8;             // thickness of the thin zone
corner_c = 2.5;           // corner chamfer of the bar
step_cut = 3.2;           // material removed from the thin zone
ledge_y = 25.3;           // start of the ledge from the front edge
depth_1 = 3.2;            // depth of cut 1 from the top face

profile = [[2.5, 0], [87.5, 0], [90, 2.5], [90, 43.5], [87.5, 46], [2.5, 46], [0, 43.5], [0, 2.5]];  // primary outline, 8 points, counter clockwise
void_1 = [[-1, 25.3], [91, 25.3], [91, 47], [-1, 47]];  // ledge cut along one edge, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
}
