$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: endstep, 100 x 40 x 12/7.7 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 100;              // bar length, X
bar_w = 40;               // bar width, Y
plate_t = 12;             // thickness of the thick zone, Z
thin_t = 7.7;             // thickness of the thin zone
corner_c = 2.5;           // corner chamfer of the bar
step_cut = 4.3;           // material removed from the thin zone
step_x = 59;              // step position from the left end
depth_1 = 4.3;            // depth of cut 1 from the top face

profile = [[2.5, 0], [97.5, 0], [100, 2.5], [100, 37.5], [97.5, 40], [2.5, 40], [0, 37.5], [0, 2.5]];  // primary outline, 8 points, counter clockwise
void_1 = [[59, -1], [101, -1], [101, 41], [59, 41]];  // thin zone beyond the step, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
}
