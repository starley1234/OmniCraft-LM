$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: twostep, 110 x 34 x 8/2.8 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 110;              // bar length, X
bar_w = 34;               // bar width, Y
plate_t = 8;              // thickness of the thick zone, Z
thin_t = 2.8;             // thickness of the thin zone
corner_c = 3;             // corner chamfer of the bar
step_cut = 5.2;           // material removed from the thin zone
stair1_x = 38.5;          // position of the first stair
stair2_x = 72.6;          // position of the second stair
mid_t = 5.4;              // thickness of the middle zone
depth_1 = 2.6;            // depth of cut 1 from the top face
depth_2 = 5.2;            // depth of cut 2 from the top face

profile = [[3, 0], [107, 0], [110, 3], [110, 31], [107, 34], [3, 34], [0, 31], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[38.5, -1], [72.6, -1], [72.6, 35], [38.5, 35]];  // first stair, 4 points
void_2 = [[72.6, -1], [111, -1], [111, 35], [72.6, 35]];  // second stair, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
  translate([0, 0, plate_t - depth_2])
    linear_extrude(height = depth_2 + 1) polygon(points = void_2);
}
