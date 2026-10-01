$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: endstep, 120 x 46 x 8/5.5 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 120;              // bar length, X
bar_w = 46;               // bar width, Y
plate_t = 8;              // thickness of the thick zone, Z
thin_t = 5.5;             // thickness of the thin zone
corner_c = 2;             // corner chamfer of the bar
step_cut = 2.5;           // material removed from the thin zone
step_x = 66;              // step position from the left end
depth_1 = 2.5;            // depth of cut 1 from the top face

profile = [[2, 0], [118, 0], [120, 2], [120, 44], [118, 46], [2, 46], [0, 44], [0, 2]];  // primary outline, 8 points, counter clockwise
void_1 = [[66, -1], [121, -1], [121, 47], [66, 47]];  // thin zone beyond the step, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
}
