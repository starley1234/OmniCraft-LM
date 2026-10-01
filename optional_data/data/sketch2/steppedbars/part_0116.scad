$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: twostep, 110 x 40 x 10/4.3 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 110;              // bar length, X
bar_w = 40;               // bar width, Y
plate_t = 10;             // thickness of the thick zone, Z
thin_t = 4.3;             // thickness of the thin zone
corner_c = 2;             // corner chamfer of the bar
step_cut = 5.7;           // material removed from the thin zone
stair1_x = 38.5;          // position of the first stair
stair2_x = 79.2;          // position of the second stair
mid_t = 7.2;              // thickness of the middle zone
depth_1 = 2.8;            // depth of cut 1 from the top face
depth_2 = 5.7;            // depth of cut 2 from the top face

profile = [[2, 0], [108, 0], [110, 2], [110, 38], [108, 40], [2, 40], [0, 38], [0, 2]];  // primary outline, 8 points, counter clockwise
void_1 = [[38.5, -1], [79.2, -1], [79.2, 41], [38.5, 41]];  // first stair, 4 points
void_2 = [[79.2, -1], [111, -1], [111, 41], [79.2, 41]];  // second stair, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
  translate([0, 0, plate_t - depth_2])
    linear_extrude(height = depth_2 + 1) polygon(points = void_2);
}
