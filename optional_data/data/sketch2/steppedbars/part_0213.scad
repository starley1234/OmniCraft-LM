$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: endstep, 110 x 52 x 10/6.8 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 110;              // bar length, X
bar_w = 52;               // bar width, Y
plate_t = 10;             // thickness of the thick zone, Z
thin_t = 6.8;             // thickness of the thin zone
corner_c = 2;             // corner chamfer of the bar
step_cut = 3.2;           // material removed from the thin zone
step_x = 69.3;            // step position from the left end
depth_1 = 3.2;            // depth of cut 1 from the top face
fit_tol = 0.05;           // declared fit tolerance (prompt contract)
free_tol = 0.3;           // declared free tolerance (prompt contract)

profile = [[2, 0], [108, 0], [110, 2], [110, 50], [108, 52], [2, 52], [0, 50], [0, 2]];  // primary outline, 8 points, counter clockwise
void_1 = [[69.3, -1], [111, -1], [111, 53], [69.3, 53]];  // thin zone beyond the step, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
}
