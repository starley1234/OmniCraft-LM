$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: twostep, 130 x 52 x 10/4 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 130;              // bar length, X
bar_w = 52;               // bar width, Y
plate_t = 10;             // thickness of the thick zone, Z
thin_t = 4;               // thickness of the thin zone
corner_c = 3;             // corner chamfer of the bar
step_cut = 6;             // material removed from the thin zone
stair1_x = 45.5;          // position of the first stair
stair2_x = 88.4;          // position of the second stair
mid_t = 7;                // thickness of the middle zone
depth_1 = 3;              // depth of cut 1 from the top face
depth_2 = 6;              // depth of cut 2 from the top face

profile = [[3, 0], [127, 0], [130, 3], [130, 49], [127, 52], [3, 52], [0, 49], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[45.5, -1], [88.4, -1], [88.4, 53], [45.5, 53]];  // first stair, 4 points
void_2 = [[88.4, -1], [131, -1], [131, 53], [88.4, 53]];  // second stair, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
  translate([0, 0, plate_t - depth_2])
    linear_extrude(height = depth_2 + 1) polygon(points = void_2);
}
