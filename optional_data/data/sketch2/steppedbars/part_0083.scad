$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: twostep, 110 x 46 x 12/8.6 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 110;              // bar length, X
bar_w = 46;               // bar width, Y
plate_t = 12;             // thickness of the thick zone, Z
thin_t = 8.6;             // thickness of the thin zone
corner_c = 3;             // corner chamfer of the bar
step_cut = 3.4;           // material removed from the thin zone
stair1_x = 39.6;          // position of the first stair
stair2_x = 73.7;          // position of the second stair
mid_t = 10.3;             // thickness of the middle zone
depth_1 = 1.7;            // depth of cut 1 from the top face
depth_2 = 3.4;            // depth of cut 2 from the top face

profile = [[3, 0], [107, 0], [110, 3], [110, 43], [107, 46], [3, 46], [0, 43], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[39.6, -1], [73.7, -1], [73.7, 47], [39.6, 47]];  // first stair, 4 points
void_2 = [[73.7, -1], [111, -1], [111, 47], [73.7, 47]];  // second stair, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
  translate([0, 0, plate_t - depth_2])
    linear_extrude(height = depth_2 + 1) polygon(points = void_2);
}
