$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: twostep, 100 x 40 x 12/7.2 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 100;              // bar length, X
bar_w = 40;               // bar width, Y
plate_t = 12;             // thickness of the thick zone, Z
thin_t = 7.2;             // thickness of the thin zone
corner_c = 2.5;           // corner chamfer of the bar
step_cut = 4.8;           // material removed from the thin zone
stair1_x = 31;            // position of the first stair
stair2_x = 65;            // position of the second stair
mid_t = 9.6;              // thickness of the middle zone
depth_1 = 2.4;            // depth of cut 1 from the top face
depth_2 = 4.8;            // depth of cut 2 from the top face

profile = [[2.5, 0], [97.5, 0], [100, 2.5], [100, 37.5], [97.5, 40], [2.5, 40], [0, 37.5], [0, 2.5]];  // primary outline, 8 points, counter clockwise
void_1 = [[31, -1], [65, -1], [65, 41], [31, 41]];  // first stair, 4 points
void_2 = [[65, -1], [101, -1], [101, 41], [65, 41]];  // second stair, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
  translate([0, 0, plate_t - depth_2])
    linear_extrude(height = depth_2 + 1) polygon(points = void_2);
}
