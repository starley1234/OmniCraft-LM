$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: endstep, 90 x 34 x 10/3.5 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 90;               // bar length, X
bar_w = 34;               // bar width, Y
plate_t = 10;             // thickness of the thick zone, Z
thin_t = 3.5;             // thickness of the thin zone
corner_c = 2;             // corner chamfer of the bar
step_cut = 6.5;           // material removed from the thin zone
step_x = 51.3;            // step position from the left end
depth_1 = 6.5;            // depth of cut 1 from the top face

profile = [[2, 0], [88, 0], [90, 2], [90, 32], [88, 34], [2, 34], [0, 32], [0, 2]];  // primary outline, 8 points, counter clockwise
void_1 = [[51.3, -1], [91, -1], [91, 35], [51.3, 35]];  // thin zone beyond the step, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
}
