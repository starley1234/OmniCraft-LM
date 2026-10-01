$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: endstep, 130 x 40 x 8/3.9 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 130;              // bar length, X
bar_w = 40;               // bar width, Y
plate_t = 8;              // thickness of the thick zone, Z
thin_t = 3.9;             // thickness of the thin zone
corner_c = 2.5;           // corner chamfer of the bar
step_cut = 4.1;           // material removed from the thin zone
step_x = 63.7;            // step position from the left end
depth_1 = 4.1;            // depth of cut 1 from the top face
fit_tol = 0.02;           // declared fit tolerance (prompt contract)
free_tol = 0.2;           // declared free tolerance (prompt contract)

profile = [[2.5, 0], [127.5, 0], [130, 2.5], [130, 37.5], [127.5, 40], [2.5, 40], [0, 37.5], [0, 2.5]];  // primary outline, 8 points, counter clockwise
void_1 = [[63.7, -1], [131, -1], [131, 41], [63.7, 41]];  // thin zone beyond the step, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
}
