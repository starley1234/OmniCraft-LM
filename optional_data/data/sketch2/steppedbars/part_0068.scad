$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: centerstep, 130 x 46 x 8/3 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 130;              // bar length, X
bar_w = 46;               // bar width, Y
plate_t = 8;              // thickness of the thick zone, Z
thin_t = 3;               // thickness of the thin zone
corner_c = 2;             // corner chamfer of the bar
step_cut = 5;             // material removed from the thin zone
thick_from = 28.6;        // start of the thick middle zone
thick_to = 94.9;          // end of the thick middle zone
depth_1 = 5;              // depth of cut 1 from the top face
depth_2 = 5;              // depth of cut 2 from the top face

profile = [[2, 0], [128, 0], [130, 2], [130, 44], [128, 46], [2, 46], [0, 44], [0, 2]];  // primary outline, 8 points, counter clockwise
void_1 = [[-1, -1], [28.6, -1], [28.6, 47], [-1, 47]];  // thin left end, 4 points
void_2 = [[94.9, -1], [131, -1], [131, 47], [94.9, 47]];  // thin right end, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
  translate([0, 0, plate_t - depth_2])
    linear_extrude(height = depth_2 + 1) polygon(points = void_2);
}
