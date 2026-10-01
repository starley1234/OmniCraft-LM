$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: twostep, 120 x 40 x 8/4.7 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 120;              // bar length, X
bar_w = 40;               // bar width, Y
plate_t = 8;              // thickness of the thick zone, Z
thin_t = 4.7;             // thickness of the thin zone
corner_c = 2.5;           // corner chamfer of the bar
step_cut = 3.3;           // material removed from the thin zone
stair1_x = 42;            // position of the first stair
stair2_x = 80.4;          // position of the second stair
mid_t = 6.3;              // thickness of the middle zone
depth_1 = 1.7;            // depth of cut 1 from the top face
depth_2 = 3.3;            // depth of cut 2 from the top face

profile = [[2.5, 0], [117.5, 0], [120, 2.5], [120, 37.5], [117.5, 40], [2.5, 40], [0, 37.5], [0, 2.5]];  // primary outline, 8 points, counter clockwise
void_1 = [[42, -1], [80.4, -1], [80.4, 41], [42, 41]];  // first stair, 4 points
void_2 = [[80.4, -1], [121, -1], [121, 41], [80.4, 41]];  // second stair, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
  translate([0, 0, plate_t - depth_2])
    linear_extrude(height = depth_2 + 1) polygon(points = void_2);
}
