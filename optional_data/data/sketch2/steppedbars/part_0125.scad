$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: endstep, 100 x 52 x 12/6.6 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 100;              // bar length, X
bar_w = 52;               // bar width, Y
plate_t = 12;             // thickness of the thick zone, Z
thin_t = 6.6;             // thickness of the thin zone
corner_c = 2.5;           // corner chamfer of the bar
step_cut = 5.4;           // material removed from the thin zone
step_x = 65;              // step position from the left end
depth_1 = 5.4;            // depth of cut 1 from the top face
fit_tol = 0.05;           // declared fit tolerance (prompt contract)
free_tol = 0.3;           // declared free tolerance (prompt contract)

profile = [[2.5, 0], [97.5, 0], [100, 2.5], [100, 49.5], [97.5, 52], [2.5, 52], [0, 49.5], [0, 2.5]];  // primary outline, 8 points, counter clockwise
void_1 = [[65, -1], [101, -1], [101, 53], [65, 53]];  // thin zone beyond the step, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
}
