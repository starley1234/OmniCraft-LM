$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: twostep, 100 x 46 x 8/4 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 100;              // bar length, X
bar_w = 46;               // bar width, Y
plate_t = 8;              // thickness of the thick zone, Z
thin_t = 4;               // thickness of the thin zone
corner_c = 3;             // corner chamfer of the bar
step_cut = 4;             // material removed from the thin zone
stair1_x = 39;            // position of the first stair
stair2_x = 68;            // position of the second stair
mid_t = 6;                // thickness of the middle zone
depth_1 = 2;              // depth of cut 1 from the top face
depth_2 = 4;              // depth of cut 2 from the top face

profile = [[3, 0], [97, 0], [100, 3], [100, 43], [97, 46], [3, 46], [0, 43], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[39, -1], [68, -1], [68, 47], [39, 47]];  // first stair, 4 points
void_2 = [[68, -1], [101, -1], [101, 47], [68, 47]];  // second stair, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
  translate([0, 0, plate_t - depth_2])
    linear_extrude(height = depth_2 + 1) polygon(points = void_2);
}
