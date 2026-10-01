$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: twostep, 100 x 40 x 10/6.8 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 100;              // bar length, X
bar_w = 40;               // bar width, Y
plate_t = 10;             // thickness of the thick zone, Z
thin_t = 6.8;             // thickness of the thin zone
corner_c = 2;             // corner chamfer of the bar
step_cut = 3.2;           // material removed from the thin zone
stair1_x = 30;            // position of the first stair
stair2_x = 68;            // position of the second stair
mid_t = 8.4;              // thickness of the middle zone
depth_1 = 1.6;            // depth of cut 1 from the top face
depth_2 = 3.2;            // depth of cut 2 from the top face
fit_tol = 0.1;            // declared fit tolerance (prompt contract)
free_tol = 0.5;           // declared free tolerance (prompt contract)

profile = [[2, 0], [98, 0], [100, 2], [100, 38], [98, 40], [2, 40], [0, 38], [0, 2]];  // primary outline, 8 points, counter clockwise
void_1 = [[30, -1], [68, -1], [68, 41], [30, 41]];  // first stair, 4 points
void_2 = [[68, -1], [101, -1], [101, 41], [68, 41]];  // second stair, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
  translate([0, 0, plate_t - depth_2])
    linear_extrude(height = depth_2 + 1) polygon(points = void_2);
}
