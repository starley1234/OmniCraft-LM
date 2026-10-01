$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: twostep, 120 x 52 x 8/3.7 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 120;              // bar length, X
bar_w = 52;               // bar width, Y
plate_t = 8;              // thickness of the thick zone, Z
thin_t = 3.7;             // thickness of the thin zone
corner_c = 2;             // corner chamfer of the bar
step_cut = 4.3;           // material removed from the thin zone
stair1_x = 36;            // position of the first stair
stair2_x = 78;            // position of the second stair
mid_t = 5.8;              // thickness of the middle zone
depth_1 = 2.2;            // depth of cut 1 from the top face
depth_2 = 4.3;            // depth of cut 2 from the top face

profile = [[2, 0], [118, 0], [120, 2], [120, 50], [118, 52], [2, 52], [0, 50], [0, 2]];  // primary outline, 8 points, counter clockwise
void_1 = [[36, -1], [78, -1], [78, 53], [36, 53]];  // first stair, 4 points
void_2 = [[78, -1], [121, -1], [121, 53], [78, 53]];  // second stair, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
  translate([0, 0, plate_t - depth_2])
    linear_extrude(height = depth_2 + 1) polygon(points = void_2);
}
