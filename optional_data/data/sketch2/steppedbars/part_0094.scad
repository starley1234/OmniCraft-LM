$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: twostep, 120 x 40 x 12/3.7 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 120;              // bar length, X
bar_w = 40;               // bar width, Y
plate_t = 12;             // thickness of the thick zone, Z
thin_t = 3.7;             // thickness of the thin zone
corner_c = 2;             // corner chamfer of the bar
step_cut = 8.3;           // material removed from the thin zone
stair1_x = 34.8;          // position of the first stair
stair2_x = 82.8;          // position of the second stair
mid_t = 7.8;              // thickness of the middle zone
depth_1 = 4.2;            // depth of cut 1 from the top face
depth_2 = 8.3;            // depth of cut 2 from the top face

profile = [[2, 0], [118, 0], [120, 2], [120, 38], [118, 40], [2, 40], [0, 38], [0, 2]];  // primary outline, 8 points, counter clockwise
void_1 = [[34.8, -1], [82.8, -1], [82.8, 41], [34.8, 41]];  // first stair, 4 points
void_2 = [[82.8, -1], [121, -1], [121, 41], [82.8, 41]];  // second stair, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
  translate([0, 0, plate_t - depth_2])
    linear_extrude(height = depth_2 + 1) polygon(points = void_2);
}
