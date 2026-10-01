$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: twostep, 120 x 52 x 8/4.6 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 120;              // bar length, X
bar_w = 52;               // bar width, Y
plate_t = 8;              // thickness of the thick zone, Z
thin_t = 4.6;             // thickness of the thin zone
corner_c = 2.5;           // corner chamfer of the bar
step_cut = 3.4;           // material removed from the thin zone
stair1_x = 38.4;          // position of the first stair
stair2_x = 79.2;          // position of the second stair
mid_t = 6.3;              // thickness of the middle zone
depth_1 = 1.7;            // depth of cut 1 from the top face
depth_2 = 3.4;            // depth of cut 2 from the top face

profile = [[2.5, 0], [117.5, 0], [120, 2.5], [120, 49.5], [117.5, 52], [2.5, 52], [0, 49.5], [0, 2.5]];  // primary outline, 8 points, counter clockwise
void_1 = [[38.4, -1], [79.2, -1], [79.2, 53], [38.4, 53]];  // first stair, 4 points
void_2 = [[79.2, -1], [121, -1], [121, 53], [79.2, 53]];  // second stair, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
  translate([0, 0, plate_t - depth_2])
    linear_extrude(height = depth_2 + 1) polygon(points = void_2);
}
