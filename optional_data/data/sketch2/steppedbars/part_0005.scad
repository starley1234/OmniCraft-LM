$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: endstep, 120 x 34 x 8/4.9 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 120;              // bar length, X
bar_w = 34;               // bar width, Y
plate_t = 8;              // thickness of the thick zone, Z
thin_t = 4.9;             // thickness of the thin zone
corner_c = 3;             // corner chamfer of the bar
step_cut = 3.1;           // material removed from the thin zone
step_x = 69.6;            // step position from the left end
depth_1 = 3.1;            // depth of cut 1 from the top face

profile = [[3, 0], [117, 0], [120, 3], [120, 31], [117, 34], [3, 34], [0, 31], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[69.6, -1], [121, -1], [121, 35], [69.6, 35]];  // thin zone beyond the step, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
}
