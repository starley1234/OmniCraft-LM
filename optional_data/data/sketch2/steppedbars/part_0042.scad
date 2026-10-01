$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: endstep, 110 x 40 x 10/6.6 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 110;              // bar length, X
bar_w = 40;               // bar width, Y
plate_t = 10;             // thickness of the thick zone, Z
thin_t = 6.6;             // thickness of the thin zone
corner_c = 2;             // corner chamfer of the bar
step_cut = 3.4;           // material removed from the thin zone
step_x = 70.4;            // step position from the left end
depth_1 = 3.4;            // depth of cut 1 from the top face

profile = [[2, 0], [108, 0], [110, 2], [110, 38], [108, 40], [2, 40], [0, 38], [0, 2]];  // primary outline, 8 points, counter clockwise
void_1 = [[70.4, -1], [111, -1], [111, 41], [70.4, 41]];  // thin zone beyond the step, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
}
