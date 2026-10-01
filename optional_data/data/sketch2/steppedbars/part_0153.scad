$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: endstep, 110 x 34 x 12/5.5 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 110;              // bar length, X
bar_w = 34;               // bar width, Y
plate_t = 12;             // thickness of the thick zone, Z
thin_t = 5.5;             // thickness of the thin zone
corner_c = 2.5;           // corner chamfer of the bar
step_cut = 6.5;           // material removed from the thin zone
step_x = 55;              // step position from the left end
depth_1 = 6.5;            // depth of cut 1 from the top face

profile = [[2.5, 0], [107.5, 0], [110, 2.5], [110, 31.5], [107.5, 34], [2.5, 34], [0, 31.5], [0, 2.5]];  // primary outline, 8 points, counter clockwise
void_1 = [[55, -1], [111, -1], [111, 35], [55, 35]];  // thin zone beyond the step, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
}
