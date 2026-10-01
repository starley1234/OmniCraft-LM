$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: endstep, 100 x 40 x 8/3.9 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 100;              // bar length, X
bar_w = 40;               // bar width, Y
plate_t = 8;              // thickness of the thick zone, Z
thin_t = 3.9;             // thickness of the thin zone
corner_c = 3;             // corner chamfer of the bar
step_cut = 4.1;           // material removed from the thin zone
step_x = 53;              // step position from the left end
depth_1 = 4.1;            // depth of cut 1 from the top face
fit_tol = 0.02;           // declared fit tolerance (prompt contract)
free_tol = 0.2;           // declared free tolerance (prompt contract)

profile = [[3, 0], [97, 0], [100, 3], [100, 37], [97, 40], [3, 40], [0, 37], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[53, -1], [101, -1], [101, 41], [53, 41]];  // thin zone beyond the step, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
}
