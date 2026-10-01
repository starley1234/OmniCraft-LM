$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: twostep, 130 x 34 x 12/3.1 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 130;              // bar length, X
bar_w = 34;               // bar width, Y
plate_t = 12;             // thickness of the thick zone, Z
thin_t = 3.1;             // thickness of the thin zone
corner_c = 2;             // corner chamfer of the bar
step_cut = 8.9;           // material removed from the thin zone
stair1_x = 46.8;          // position of the first stair
stair2_x = 89.7;          // position of the second stair
mid_t = 7.5;              // thickness of the middle zone
depth_1 = 4.5;            // depth of cut 1 from the top face
depth_2 = 8.9;            // depth of cut 2 from the top face

profile = [[2, 0], [128, 0], [130, 2], [130, 32], [128, 34], [2, 34], [0, 32], [0, 2]];  // primary outline, 8 points, counter clockwise
void_1 = [[46.8, -1], [89.7, -1], [89.7, 35], [46.8, 35]];  // first stair, 4 points
void_2 = [[89.7, -1], [131, -1], [131, 35], [89.7, 35]];  // second stair, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
  translate([0, 0, plate_t - depth_2])
    linear_extrude(height = depth_2 + 1) polygon(points = void_2);
}
