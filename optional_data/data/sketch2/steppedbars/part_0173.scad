$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: centerstep, 120 x 52 x 12/9.2 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 120;              // bar length, X
bar_w = 52;               // bar width, Y
plate_t = 12;             // thickness of the thick zone, Z
thin_t = 9.2;             // thickness of the thin zone
corner_c = 3;             // corner chamfer of the bar
step_cut = 2.8;           // material removed from the thin zone
thick_from = 26.4;        // start of the thick middle zone
thick_to = 91.2;          // end of the thick middle zone
depth_1 = 2.8;            // depth of cut 1 from the top face
depth_2 = 2.8;            // depth of cut 2 from the top face

profile = [[3, 0], [117, 0], [120, 3], [120, 49], [117, 52], [3, 52], [0, 49], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[-1, -1], [26.4, -1], [26.4, 53], [-1, 53]];  // thin left end, 4 points
void_2 = [[91.2, -1], [121, -1], [121, 53], [91.2, 53]];  // thin right end, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
  translate([0, 0, plate_t - depth_2])
    linear_extrude(height = depth_2 + 1) polygon(points = void_2);
}
