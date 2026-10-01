$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: twostep, 110 x 40 x 12/5.7 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 110;              // bar length, X
bar_w = 40;               // bar width, Y
plate_t = 12;             // thickness of the thick zone, Z
thin_t = 5.7;             // thickness of the thin zone
corner_c = 2.5;           // corner chamfer of the bar
step_cut = 6.3;           // material removed from the thin zone
stair1_x = 36.3;          // position of the first stair
stair2_x = 69.3;          // position of the second stair
mid_t = 8.8;              // thickness of the middle zone
depth_1 = 3.2;            // depth of cut 1 from the top face
depth_2 = 6.3;            // depth of cut 2 from the top face

profile = [[2.5, 0], [107.5, 0], [110, 2.5], [110, 37.5], [107.5, 40], [2.5, 40], [0, 37.5], [0, 2.5]];  // primary outline, 8 points, counter clockwise
void_1 = [[36.3, -1], [69.3, -1], [69.3, 41], [36.3, 41]];  // first stair, 4 points
void_2 = [[69.3, -1], [111, -1], [111, 41], [69.3, 41]];  // second stair, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
  translate([0, 0, plate_t - depth_2])
    linear_extrude(height = depth_2 + 1) polygon(points = void_2);
}
