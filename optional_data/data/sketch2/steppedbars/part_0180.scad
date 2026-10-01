$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: twostep, 120 x 46 x 12/9.4 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 120;              // bar length, X
bar_w = 46;               // bar width, Y
plate_t = 12;             // thickness of the thick zone, Z
thin_t = 9.4;             // thickness of the thin zone
corner_c = 2.5;           // corner chamfer of the bar
step_cut = 2.6;           // material removed from the thin zone
stair1_x = 43.2;          // position of the first stair
stair2_x = 79.2;          // position of the second stair
mid_t = 10.7;             // thickness of the middle zone
depth_1 = 1.3;            // depth of cut 1 from the top face
depth_2 = 2.6;            // depth of cut 2 from the top face

profile = [[2.5, 0], [117.5, 0], [120, 2.5], [120, 43.5], [117.5, 46], [2.5, 46], [0, 43.5], [0, 2.5]];  // primary outline, 8 points, counter clockwise
void_1 = [[43.2, -1], [79.2, -1], [79.2, 47], [43.2, 47]];  // first stair, 4 points
void_2 = [[79.2, -1], [121, -1], [121, 47], [79.2, 47]];  // second stair, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
  translate([0, 0, plate_t - depth_2])
    linear_extrude(height = depth_2 + 1) polygon(points = void_2);
}
