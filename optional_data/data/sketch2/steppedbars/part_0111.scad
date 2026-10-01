$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: twostep, 90 x 52 x 10/2.9 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 90;               // bar length, X
bar_w = 52;               // bar width, Y
plate_t = 10;             // thickness of the thick zone, Z
thin_t = 2.9;             // thickness of the thin zone
corner_c = 2;             // corner chamfer of the bar
step_cut = 7.1;           // material removed from the thin zone
stair1_x = 30.6;          // position of the first stair
stair2_x = 58.5;          // position of the second stair
mid_t = 6.5;              // thickness of the middle zone
depth_1 = 3.5;            // depth of cut 1 from the top face
depth_2 = 7.1;            // depth of cut 2 from the top face

profile = [[2, 0], [88, 0], [90, 2], [90, 50], [88, 52], [2, 52], [0, 50], [0, 2]];  // primary outline, 8 points, counter clockwise
void_1 = [[30.6, -1], [58.5, -1], [58.5, 53], [30.6, 53]];  // first stair, 4 points
void_2 = [[58.5, -1], [91, -1], [91, 53], [58.5, 53]];  // second stair, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
  translate([0, 0, plate_t - depth_2])
    linear_extrude(height = depth_2 + 1) polygon(points = void_2);
}
