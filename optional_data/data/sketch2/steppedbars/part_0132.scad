$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: twostep, 100 x 46 x 8/5.2 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 100;              // bar length, X
bar_w = 46;               // bar width, Y
plate_t = 8;              // thickness of the thick zone, Z
thin_t = 5.2;             // thickness of the thin zone
corner_c = 2.5;           // corner chamfer of the bar
step_cut = 2.8;           // material removed from the thin zone
stair1_x = 34;            // position of the first stair
stair2_x = 62;            // position of the second stair
mid_t = 6.6;              // thickness of the middle zone
depth_1 = 1.4;            // depth of cut 1 from the top face
depth_2 = 2.8;            // depth of cut 2 from the top face

profile = [[2.5, 0], [97.5, 0], [100, 2.5], [100, 43.5], [97.5, 46], [2.5, 46], [0, 43.5], [0, 2.5]];  // primary outline, 8 points, counter clockwise
void_1 = [[34, -1], [62, -1], [62, 47], [34, 47]];  // first stair, 4 points
void_2 = [[62, -1], [101, -1], [101, 47], [62, 47]];  // second stair, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
  translate([0, 0, plate_t - depth_2])
    linear_extrude(height = depth_2 + 1) polygon(points = void_2);
}
