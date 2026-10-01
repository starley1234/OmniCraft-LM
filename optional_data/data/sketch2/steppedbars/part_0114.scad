$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: twostep, 130 x 46 x 12/3.1 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 130;              // bar length, X
bar_w = 46;               // bar width, Y
plate_t = 12;             // thickness of the thick zone, Z
thin_t = 3.1;             // thickness of the thin zone
corner_c = 2;             // corner chamfer of the bar
step_cut = 8.9;           // material removed from the thin zone
stair1_x = 52;            // position of the first stair
stair2_x = 84.5;          // position of the second stair
mid_t = 7.5;              // thickness of the middle zone
depth_1 = 4.5;            // depth of cut 1 from the top face
depth_2 = 8.9;            // depth of cut 2 from the top face

profile = [[2, 0], [128, 0], [130, 2], [130, 44], [128, 46], [2, 46], [0, 44], [0, 2]];  // primary outline, 8 points, counter clockwise
void_1 = [[52, -1], [84.5, -1], [84.5, 47], [52, 47]];  // first stair, 4 points
void_2 = [[84.5, -1], [131, -1], [131, 47], [84.5, 47]];  // second stair, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
  translate([0, 0, plate_t - depth_2])
    linear_extrude(height = depth_2 + 1) polygon(points = void_2);
}
