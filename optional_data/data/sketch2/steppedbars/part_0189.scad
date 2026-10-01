$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: endstep, 120 x 34 x 12/6.4 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 120;              // bar length, X
bar_w = 34;               // bar width, Y
plate_t = 12;             // thickness of the thick zone, Z
thin_t = 6.4;             // thickness of the thin zone
corner_c = 2;             // corner chamfer of the bar
step_cut = 5.6;           // material removed from the thin zone
step_x = 74.4;            // step position from the left end
depth_1 = 5.6;            // depth of cut 1 from the top face
fit_tol = 0.1;            // declared fit tolerance (prompt contract)
free_tol = 0.3;           // declared free tolerance (prompt contract)

profile = [[2, 0], [118, 0], [120, 2], [120, 32], [118, 34], [2, 34], [0, 32], [0, 2]];  // primary outline, 8 points, counter clockwise
void_1 = [[74.4, -1], [121, -1], [121, 35], [74.4, 35]];  // thin zone beyond the step, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
}
