$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: centerstep, 100 x 52 x 8/4.3 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 100;              // bar length, X
bar_w = 52;               // bar width, Y
plate_t = 8;              // thickness of the thick zone, Z
thin_t = 4.3;             // thickness of the thin zone
corner_c = 3;             // corner chamfer of the bar
step_cut = 3.7;           // material removed from the thin zone
thick_from = 26;          // start of the thick middle zone
thick_to = 76;            // end of the thick middle zone
depth_1 = 3.7;            // depth of cut 1 from the top face
depth_2 = 3.7;            // depth of cut 2 from the top face

profile = [[3, 0], [97, 0], [100, 3], [100, 49], [97, 52], [3, 52], [0, 49], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[-1, -1], [26, -1], [26, 53], [-1, 53]];  // thin left end, 4 points
void_2 = [[76, -1], [101, -1], [101, 53], [76, 53]];  // thin right end, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
  translate([0, 0, plate_t - depth_2])
    linear_extrude(height = depth_2 + 1) polygon(points = void_2);
}
