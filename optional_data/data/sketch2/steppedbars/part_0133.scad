$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: endstep, 120 x 34 x 10/2.7 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 120;              // bar length, X
bar_w = 34;               // bar width, Y
plate_t = 10;             // thickness of the thick zone, Z
thin_t = 2.7;             // thickness of the thin zone
corner_c = 2.5;           // corner chamfer of the bar
step_cut = 7.3;           // material removed from the thin zone
step_x = 51.6;            // step position from the left end
depth_1 = 7.3;            // depth of cut 1 from the top face

profile = [[2.5, 0], [117.5, 0], [120, 2.5], [120, 31.5], [117.5, 34], [2.5, 34], [0, 31.5], [0, 2.5]];  // primary outline, 8 points, counter clockwise
void_1 = [[51.6, -1], [121, -1], [121, 35], [51.6, 35]];  // thin zone beyond the step, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
}
