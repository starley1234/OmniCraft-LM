$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: twostep, 90 x 52 x 12/9.5 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 90;               // bar length, X
bar_w = 52;               // bar width, Y
plate_t = 12;             // thickness of the thick zone, Z
thin_t = 9.5;             // thickness of the thin zone
corner_c = 2.5;           // corner chamfer of the bar
step_cut = 2.5;           // material removed from the thin zone
stair1_x = 32.4;          // position of the first stair
stair2_x = 64.8;          // position of the second stair
mid_t = 10.8;             // thickness of the middle zone
depth_1 = 1.2;            // depth of cut 1 from the top face
depth_2 = 2.5;            // depth of cut 2 from the top face

profile = [[2.5, 0], [87.5, 0], [90, 2.5], [90, 49.5], [87.5, 52], [2.5, 52], [0, 49.5], [0, 2.5]];  // primary outline, 8 points, counter clockwise
void_1 = [[32.4, -1], [64.8, -1], [64.8, 53], [32.4, 53]];  // first stair, 4 points
void_2 = [[64.8, -1], [91, -1], [91, 53], [64.8, 53]];  // second stair, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
  translate([0, 0, plate_t - depth_2])
    linear_extrude(height = depth_2 + 1) polygon(points = void_2);
}
