$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: twostep, 90 x 52 x 12/4.9 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 90;               // bar length, X
bar_w = 52;               // bar width, Y
plate_t = 12;             // thickness of the thick zone, Z
thin_t = 4.9;             // thickness of the thin zone
corner_c = 2;             // corner chamfer of the bar
step_cut = 7.1;           // material removed from the thin zone
stair1_x = 27;            // position of the first stair
stair2_x = 66.6;          // position of the second stair
mid_t = 8.4;              // thickness of the middle zone
depth_1 = 3.6;            // depth of cut 1 from the top face
depth_2 = 7.1;            // depth of cut 2 from the top face

profile = [[2, 0], [88, 0], [90, 2], [90, 50], [88, 52], [2, 52], [0, 50], [0, 2]];  // primary outline, 8 points, counter clockwise
void_1 = [[27, -1], [66.6, -1], [66.6, 53], [27, 53]];  // first stair, 4 points
void_2 = [[66.6, -1], [91, -1], [91, 53], [66.6, 53]];  // second stair, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
  translate([0, 0, plate_t - depth_2])
    linear_extrude(height = depth_2 + 1) polygon(points = void_2);
}
