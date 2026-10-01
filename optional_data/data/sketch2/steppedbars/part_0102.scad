$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: endstep, 90 x 46 x 12/8.9 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 90;               // bar length, X
bar_w = 46;               // bar width, Y
plate_t = 12;             // thickness of the thick zone, Z
thin_t = 8.9;             // thickness of the thin zone
corner_c = 2;             // corner chamfer of the bar
step_cut = 3.1;           // material removed from the thin zone
step_x = 43.2;            // step position from the left end
depth_1 = 3.1;            // depth of cut 1 from the top face
fit_tol = 0.1;            // declared fit tolerance (prompt contract)
free_tol = 0.5;           // declared free tolerance (prompt contract)

profile = [[2, 0], [88, 0], [90, 2], [90, 44], [88, 46], [2, 46], [0, 44], [0, 2]];  // primary outline, 8 points, counter clockwise
void_1 = [[43.2, -1], [91, -1], [91, 47], [43.2, 47]];  // thin zone beyond the step, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
}
