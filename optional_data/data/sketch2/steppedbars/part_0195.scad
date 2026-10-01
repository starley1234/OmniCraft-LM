$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: twostep, 90 x 52 x 12/7.6 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 90;               // bar length, X
bar_w = 52;               // bar width, Y
plate_t = 12;             // thickness of the thick zone, Z
thin_t = 7.6;             // thickness of the thin zone
corner_c = 3;             // corner chamfer of the bar
step_cut = 4.4;           // material removed from the thin zone
stair1_x = 26.1;          // position of the first stair
stair2_x = 58.5;          // position of the second stair
mid_t = 9.8;              // thickness of the middle zone
depth_1 = 2.2;            // depth of cut 1 from the top face
depth_2 = 4.4;            // depth of cut 2 from the top face

profile = [[3, 0], [87, 0], [90, 3], [90, 49], [87, 52], [3, 52], [0, 49], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[26.1, -1], [58.5, -1], [58.5, 53], [26.1, 53]];  // first stair, 4 points
void_2 = [[58.5, -1], [91, -1], [91, 53], [58.5, 53]];  // second stair, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
  translate([0, 0, plate_t - depth_2])
    linear_extrude(height = depth_2 + 1) polygon(points = void_2);
}
