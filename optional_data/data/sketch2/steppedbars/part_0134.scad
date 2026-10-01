$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: twostep, 130 x 40 x 12/5.8 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 130;              // bar length, X
bar_w = 40;               // bar width, Y
plate_t = 12;             // thickness of the thick zone, Z
thin_t = 5.8;             // thickness of the thin zone
corner_c = 3;             // corner chamfer of the bar
step_cut = 6.2;           // material removed from the thin zone
stair1_x = 40.3;          // position of the first stair
stair2_x = 89.7;          // position of the second stair
mid_t = 8.9;              // thickness of the middle zone
depth_1 = 3.1;            // depth of cut 1 from the top face
depth_2 = 6.2;            // depth of cut 2 from the top face
fit_tol = 0.1;            // declared fit tolerance (prompt contract)
free_tol = 0.5;           // declared free tolerance (prompt contract)

profile = [[3, 0], [127, 0], [130, 3], [130, 37], [127, 40], [3, 40], [0, 37], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[40.3, -1], [89.7, -1], [89.7, 41], [40.3, 41]];  // first stair, 4 points
void_2 = [[89.7, -1], [131, -1], [131, 41], [89.7, 41]];  // second stair, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
  translate([0, 0, plate_t - depth_2])
    linear_extrude(height = depth_2 + 1) polygon(points = void_2);
}
