$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: centerstep, 130 x 52 x 8/2.6 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 130;              // bar length, X
bar_w = 52;               // bar width, Y
plate_t = 8;              // thickness of the thick zone, Z
thin_t = 2.6;             // thickness of the thin zone
corner_c = 3;             // corner chamfer of the bar
step_cut = 5.4;           // material removed from the thin zone
thick_from = 28.6;        // start of the thick middle zone
thick_to = 91;            // end of the thick middle zone
depth_1 = 5.4;            // depth of cut 1 from the top face
depth_2 = 5.4;            // depth of cut 2 from the top face

profile = [[3, 0], [127, 0], [130, 3], [130, 49], [127, 52], [3, 52], [0, 49], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[-1, -1], [28.6, -1], [28.6, 53], [-1, 53]];  // thin left end, 4 points
void_2 = [[91, -1], [131, -1], [131, 53], [91, 53]];  // thin right end, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
  translate([0, 0, plate_t - depth_2])
    linear_extrude(height = depth_2 + 1) polygon(points = void_2);
}
