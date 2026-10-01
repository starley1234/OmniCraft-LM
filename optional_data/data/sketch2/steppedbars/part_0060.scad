$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: twostep, 120 x 52 x 12/7.6 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 120;              // bar length, X
bar_w = 52;               // bar width, Y
plate_t = 12;             // thickness of the thick zone, Z
thin_t = 7.6;             // thickness of the thin zone
corner_c = 2.5;           // corner chamfer of the bar
step_cut = 4.4;           // material removed from the thin zone
stair1_x = 44.4;          // position of the first stair
stair2_x = 87.6;          // position of the second stair
mid_t = 9.8;              // thickness of the middle zone
depth_1 = 2.2;            // depth of cut 1 from the top face
depth_2 = 4.4;            // depth of cut 2 from the top face
fit_tol = 0.05;           // declared fit tolerance (prompt contract)
free_tol = 0.3;           // declared free tolerance (prompt contract)

profile = [[2.5, 0], [117.5, 0], [120, 2.5], [120, 49.5], [117.5, 52], [2.5, 52], [0, 49.5], [0, 2.5]];  // primary outline, 8 points, counter clockwise
void_1 = [[44.4, -1], [87.6, -1], [87.6, 53], [44.4, 53]];  // first stair, 4 points
void_2 = [[87.6, -1], [121, -1], [121, 53], [87.6, 53]];  // second stair, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
  translate([0, 0, plate_t - depth_2])
    linear_extrude(height = depth_2 + 1) polygon(points = void_2);
}
