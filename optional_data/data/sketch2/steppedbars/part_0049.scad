$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: twostep, 90 x 40 x 8/3.5 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 90;               // bar length, X
bar_w = 40;               // bar width, Y
plate_t = 8;              // thickness of the thick zone, Z
thin_t = 3.5;             // thickness of the thin zone
corner_c = 3;             // corner chamfer of the bar
step_cut = 4.5;           // material removed from the thin zone
stair1_x = 26.1;          // position of the first stair
stair2_x = 58.5;          // position of the second stair
mid_t = 5.8;              // thickness of the middle zone
depth_1 = 2.2;            // depth of cut 1 from the top face
depth_2 = 4.5;            // depth of cut 2 from the top face
fit_tol = 0.1;            // declared fit tolerance (prompt contract)
free_tol = 0.3;           // declared free tolerance (prompt contract)

profile = [[3, 0], [87, 0], [90, 3], [90, 37], [87, 40], [3, 40], [0, 37], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[26.1, -1], [58.5, -1], [58.5, 41], [26.1, 41]];  // first stair, 4 points
void_2 = [[58.5, -1], [91, -1], [91, 41], [58.5, 41]];  // second stair, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
  translate([0, 0, plate_t - depth_2])
    linear_extrude(height = depth_2 + 1) polygon(points = void_2);
}
