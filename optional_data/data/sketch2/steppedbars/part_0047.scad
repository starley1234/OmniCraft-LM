$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: twostep, 120 x 34 x 10/5.2 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 120;              // bar length, X
bar_w = 34;               // bar width, Y
plate_t = 10;             // thickness of the thick zone, Z
thin_t = 5.2;             // thickness of the thin zone
corner_c = 2.5;           // corner chamfer of the bar
step_cut = 4.8;           // material removed from the thin zone
stair1_x = 45.6;          // position of the first stair
stair2_x = 78;            // position of the second stair
mid_t = 7.6;              // thickness of the middle zone
depth_1 = 2.4;            // depth of cut 1 from the top face
depth_2 = 4.8;            // depth of cut 2 from the top face

profile = [[2.5, 0], [117.5, 0], [120, 2.5], [120, 31.5], [117.5, 34], [2.5, 34], [0, 31.5], [0, 2.5]];  // primary outline, 8 points, counter clockwise
void_1 = [[45.6, -1], [78, -1], [78, 35], [45.6, 35]];  // first stair, 4 points
void_2 = [[78, -1], [121, -1], [121, 35], [78, 35]];  // second stair, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
  translate([0, 0, plate_t - depth_2])
    linear_extrude(height = depth_2 + 1) polygon(points = void_2);
}
