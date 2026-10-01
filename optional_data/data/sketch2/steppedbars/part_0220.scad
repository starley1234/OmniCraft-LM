$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: centerstep, 130 x 40 x 10/4.8 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 130;              // bar length, X
bar_w = 40;               // bar width, Y
plate_t = 10;             // thickness of the thick zone, Z
thin_t = 4.8;             // thickness of the thin zone
corner_c = 2.5;           // corner chamfer of the bar
step_cut = 5.2;           // material removed from the thin zone
thick_from = 37.7;        // start of the thick middle zone
thick_to = 94.9;          // end of the thick middle zone
depth_1 = 5.2;            // depth of cut 1 from the top face
depth_2 = 5.2;            // depth of cut 2 from the top face

profile = [[2.5, 0], [127.5, 0], [130, 2.5], [130, 37.5], [127.5, 40], [2.5, 40], [0, 37.5], [0, 2.5]];  // primary outline, 8 points, counter clockwise
void_1 = [[-1, -1], [37.7, -1], [37.7, 41], [-1, 41]];  // thin left end, 4 points
void_2 = [[94.9, -1], [131, -1], [131, 41], [94.9, 41]];  // thin right end, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
  translate([0, 0, plate_t - depth_2])
    linear_extrude(height = depth_2 + 1) polygon(points = void_2);
}
