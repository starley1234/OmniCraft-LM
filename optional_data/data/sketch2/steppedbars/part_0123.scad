$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: endstep, 120 x 34 x 10/5.6 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 120;              // bar length, X
bar_w = 34;               // bar width, Y
plate_t = 10;             // thickness of the thick zone, Z
thin_t = 5.6;             // thickness of the thin zone
corner_c = 3;             // corner chamfer of the bar
step_cut = 4.4;           // material removed from the thin zone
step_x = 64.8;            // step position from the left end
depth_1 = 4.4;            // depth of cut 1 from the top face

profile = [[3, 0], [117, 0], [120, 3], [120, 31], [117, 34], [3, 34], [0, 31], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[64.8, -1], [121, -1], [121, 35], [64.8, 35]];  // thin zone beyond the step, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
}
