$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: centerstep, 130 x 40 x 12/5.6 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 130;              // bar length, X
bar_w = 40;               // bar width, Y
plate_t = 12;             // thickness of the thick zone, Z
thin_t = 5.6;             // thickness of the thin zone
corner_c = 3;             // corner chamfer of the bar
step_cut = 6.4;           // material removed from the thin zone
thick_from = 39;          // start of the thick middle zone
thick_to = 91;            // end of the thick middle zone
depth_1 = 6.4;            // depth of cut 1 from the top face
depth_2 = 6.4;            // depth of cut 2 from the top face

profile = [[3, 0], [127, 0], [130, 3], [130, 37], [127, 40], [3, 40], [0, 37], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[-1, -1], [39, -1], [39, 41], [-1, 41]];  // thin left end, 4 points
void_2 = [[91, -1], [131, -1], [131, 41], [91, 41]];  // thin right end, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
  translate([0, 0, plate_t - depth_2])
    linear_extrude(height = depth_2 + 1) polygon(points = void_2);
}
