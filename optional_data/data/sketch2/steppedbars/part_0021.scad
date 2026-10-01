$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: twostep, 130 x 46 x 12/3.7 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 130;              // bar length, X
bar_w = 46;               // bar width, Y
plate_t = 12;             // thickness of the thick zone, Z
thin_t = 3.7;             // thickness of the thin zone
corner_c = 2;             // corner chamfer of the bar
step_cut = 8.3;           // material removed from the thin zone
stair1_x = 41.6;          // position of the first stair
stair2_x = 91;            // position of the second stair
mid_t = 7.8;              // thickness of the middle zone
depth_1 = 4.2;            // depth of cut 1 from the top face
depth_2 = 8.3;            // depth of cut 2 from the top face
fit_tol = 0.1;            // declared fit tolerance (prompt contract)
free_tol = 0.3;           // declared free tolerance (prompt contract)

profile = [[2, 0], [128, 0], [130, 2], [130, 44], [128, 46], [2, 46], [0, 44], [0, 2]];  // primary outline, 8 points, counter clockwise
void_1 = [[41.6, -1], [91, -1], [91, 47], [41.6, 47]];  // first stair, 4 points
void_2 = [[91, -1], [131, -1], [131, 47], [91, 47]];  // second stair, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
  translate([0, 0, plate_t - depth_2])
    linear_extrude(height = depth_2 + 1) polygon(points = void_2);
}
