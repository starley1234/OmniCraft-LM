$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: twostep, 110 x 46 x 10/6 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 110;              // bar length, X
bar_w = 46;               // bar width, Y
plate_t = 10;             // thickness of the thick zone, Z
thin_t = 6;               // thickness of the thin zone
corner_c = 2.5;           // corner chamfer of the bar
step_cut = 4;             // material removed from the thin zone
stair1_x = 38.5;          // position of the first stair
stair2_x = 81.4;          // position of the second stair
mid_t = 8;                // thickness of the middle zone
depth_1 = 2;              // depth of cut 1 from the top face
depth_2 = 4;              // depth of cut 2 from the top face

profile = [[2.5, 0], [107.5, 0], [110, 2.5], [110, 43.5], [107.5, 46], [2.5, 46], [0, 43.5], [0, 2.5]];  // primary outline, 8 points, counter clockwise
void_1 = [[38.5, -1], [81.4, -1], [81.4, 47], [38.5, 47]];  // first stair, 4 points
void_2 = [[81.4, -1], [111, -1], [111, 47], [81.4, 47]];  // second stair, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
  translate([0, 0, plate_t - depth_2])
    linear_extrude(height = depth_2 + 1) polygon(points = void_2);
}
