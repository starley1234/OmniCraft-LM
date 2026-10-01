$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: centerstep, 110 x 40 x 8/3 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 110;              // bar length, X
bar_w = 40;               // bar width, Y
plate_t = 8;              // thickness of the thick zone, Z
thin_t = 3;               // thickness of the thin zone
corner_c = 3;             // corner chamfer of the bar
step_cut = 5;             // material removed from the thin zone
thick_from = 31.9;        // start of the thick middle zone
thick_to = 88;            // end of the thick middle zone
depth_1 = 5;              // depth of cut 1 from the top face
depth_2 = 5;              // depth of cut 2 from the top face

profile = [[3, 0], [107, 0], [110, 3], [110, 37], [107, 40], [3, 40], [0, 37], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[-1, -1], [31.9, -1], [31.9, 41], [-1, 41]];  // thin left end, 4 points
void_2 = [[88, -1], [111, -1], [111, 41], [88, 41]];  // thin right end, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
  translate([0, 0, plate_t - depth_2])
    linear_extrude(height = depth_2 + 1) polygon(points = void_2);
}
