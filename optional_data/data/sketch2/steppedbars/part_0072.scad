$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: twostep, 90 x 34 x 10/5.8 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 90;               // bar length, X
bar_w = 34;               // bar width, Y
plate_t = 10;             // thickness of the thick zone, Z
thin_t = 5.8;             // thickness of the thin zone
corner_c = 3;             // corner chamfer of the bar
step_cut = 4.2;           // material removed from the thin zone
stair1_x = 28.8;          // position of the first stair
stair2_x = 60.3;          // position of the second stair
mid_t = 7.9;              // thickness of the middle zone
depth_1 = 2.1;            // depth of cut 1 from the top face
depth_2 = 4.2;            // depth of cut 2 from the top face

profile = [[3, 0], [87, 0], [90, 3], [90, 31], [87, 34], [3, 34], [0, 31], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[28.8, -1], [60.3, -1], [60.3, 35], [28.8, 35]];  // first stair, 4 points
void_2 = [[60.3, -1], [91, -1], [91, 35], [60.3, 35]];  // second stair, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
  translate([0, 0, plate_t - depth_2])
    linear_extrude(height = depth_2 + 1) polygon(points = void_2);
}
