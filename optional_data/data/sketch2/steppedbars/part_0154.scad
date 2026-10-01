$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: twostep, 130 x 34 x 8/3.6 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 130;              // bar length, X
bar_w = 34;               // bar width, Y
plate_t = 8;              // thickness of the thick zone, Z
thin_t = 3.6;             // thickness of the thin zone
corner_c = 2.5;           // corner chamfer of the bar
step_cut = 4.4;           // material removed from the thin zone
stair1_x = 40.3;          // position of the first stair
stair2_x = 96.2;          // position of the second stair
mid_t = 5.8;              // thickness of the middle zone
depth_1 = 2.2;            // depth of cut 1 from the top face
depth_2 = 4.4;            // depth of cut 2 from the top face

profile = [[2.5, 0], [127.5, 0], [130, 2.5], [130, 31.5], [127.5, 34], [2.5, 34], [0, 31.5], [0, 2.5]];  // primary outline, 8 points, counter clockwise
void_1 = [[40.3, -1], [96.2, -1], [96.2, 35], [40.3, 35]];  // first stair, 4 points
void_2 = [[96.2, -1], [131, -1], [131, 35], [96.2, 35]];  // second stair, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
  translate([0, 0, plate_t - depth_2])
    linear_extrude(height = depth_2 + 1) polygon(points = void_2);
}
