$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: endstep, 90 x 40 x 8/3 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 90;               // bar length, X
bar_w = 40;               // bar width, Y
plate_t = 8;              // thickness of the thick zone, Z
thin_t = 3;               // thickness of the thin zone
corner_c = 2;             // corner chamfer of the bar
step_cut = 5;             // material removed from the thin zone
step_x = 31.5;            // step position from the left end
depth_1 = 5;              // depth of cut 1 from the top face

profile = [[2, 0], [88, 0], [90, 2], [90, 38], [88, 40], [2, 40], [0, 38], [0, 2]];  // primary outline, 8 points, counter clockwise
void_1 = [[31.5, -1], [91, -1], [91, 41], [31.5, 41]];  // thin zone beyond the step, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
}
