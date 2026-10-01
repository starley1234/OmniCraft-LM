$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: endstep, 110 x 52 x 8/4.2 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 110;              // bar length, X
bar_w = 52;               // bar width, Y
plate_t = 8;              // thickness of the thick zone, Z
thin_t = 4.2;             // thickness of the thin zone
corner_c = 2.5;           // corner chamfer of the bar
step_cut = 3.8;           // material removed from the thin zone
step_x = 70.4;            // step position from the left end
depth_1 = 3.8;            // depth of cut 1 from the top face

profile = [[2.5, 0], [107.5, 0], [110, 2.5], [110, 49.5], [107.5, 52], [2.5, 52], [0, 49.5], [0, 2.5]];  // primary outline, 8 points, counter clockwise
void_1 = [[70.4, -1], [111, -1], [111, 53], [70.4, 53]];  // thin zone beyond the step, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
}
