$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: twostep, 100 x 34 x 12/9 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 100;              // bar length, X
bar_w = 34;               // bar width, Y
plate_t = 12;             // thickness of the thick zone, Z
thin_t = 9;               // thickness of the thin zone
corner_c = 2;             // corner chamfer of the bar
step_cut = 3;             // material removed from the thin zone
stair1_x = 29;            // position of the first stair
stair2_x = 69;            // position of the second stair
mid_t = 10.5;             // thickness of the middle zone
depth_1 = 1.5;            // depth of cut 1 from the top face
depth_2 = 3;              // depth of cut 2 from the top face

profile = [[2, 0], [98, 0], [100, 2], [100, 32], [98, 34], [2, 34], [0, 32], [0, 2]];  // primary outline, 8 points, counter clockwise
void_1 = [[29, -1], [69, -1], [69, 35], [29, 35]];  // first stair, 4 points
void_2 = [[69, -1], [101, -1], [101, 35], [69, 35]];  // second stair, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
  translate([0, 0, plate_t - depth_2])
    linear_extrude(height = depth_2 + 1) polygon(points = void_2);
}
