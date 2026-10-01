$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: endstep, 130 x 34 x 8/4.6 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 130;              // bar length, X
bar_w = 34;               // bar width, Y
plate_t = 8;              // thickness of the thick zone, Z
thin_t = 4.6;             // thickness of the thin zone
corner_c = 3;             // corner chamfer of the bar
step_cut = 3.4;           // material removed from the thin zone
step_x = 78;              // step position from the left end
depth_1 = 3.4;            // depth of cut 1 from the top face

profile = [[3, 0], [127, 0], [130, 3], [130, 31], [127, 34], [3, 34], [0, 31], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[78, -1], [131, -1], [131, 35], [78, 35]];  // thin zone beyond the step, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
}
