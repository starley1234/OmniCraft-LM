$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: centerstep, 130 x 52 x 8/3.7 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 130;              // bar length, X
bar_w = 52;               // bar width, Y
plate_t = 8;              // thickness of the thick zone, Z
thin_t = 3.7;             // thickness of the thin zone
corner_c = 2.5;           // corner chamfer of the bar
step_cut = 4.3;           // material removed from the thin zone
thick_from = 44.2;        // start of the thick middle zone
thick_to = 89.7;          // end of the thick middle zone
depth_1 = 4.3;            // depth of cut 1 from the top face
depth_2 = 4.3;            // depth of cut 2 from the top face

profile = [[2.5, 0], [127.5, 0], [130, 2.5], [130, 49.5], [127.5, 52], [2.5, 52], [0, 49.5], [0, 2.5]];  // primary outline, 8 points, counter clockwise
void_1 = [[-1, -1], [44.2, -1], [44.2, 53], [-1, 53]];  // thin left end, 4 points
void_2 = [[89.7, -1], [131, -1], [131, 53], [89.7, 53]];  // thin right end, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
  translate([0, 0, plate_t - depth_2])
    linear_extrude(height = depth_2 + 1) polygon(points = void_2);
}
