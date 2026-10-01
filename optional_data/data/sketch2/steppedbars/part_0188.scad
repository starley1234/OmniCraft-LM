$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: endstep, 90 x 34 x 10/3 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 90;               // bar length, X
bar_w = 34;               // bar width, Y
plate_t = 10;             // thickness of the thick zone, Z
thin_t = 3;               // thickness of the thin zone
corner_c = 3;             // corner chamfer of the bar
step_cut = 7;             // material removed from the thin zone
step_x = 39.6;            // step position from the left end
depth_1 = 7;              // depth of cut 1 from the top face

profile = [[3, 0], [87, 0], [90, 3], [90, 31], [87, 34], [3, 34], [0, 31], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[39.6, -1], [91, -1], [91, 35], [39.6, 35]];  // thin zone beyond the step, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
}
