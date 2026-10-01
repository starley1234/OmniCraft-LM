$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: endstep, 130 x 52 x 12/3 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 130;              // bar length, X
bar_w = 52;               // bar width, Y
plate_t = 12;             // thickness of the thick zone, Z
thin_t = 3;               // thickness of the thin zone
corner_c = 2.5;           // corner chamfer of the bar
step_cut = 9;             // material removed from the thin zone
step_x = 80.6;            // step position from the left end
depth_1 = 9;              // depth of cut 1 from the top face

profile = [[2.5, 0], [127.5, 0], [130, 2.5], [130, 49.5], [127.5, 52], [2.5, 52], [0, 49.5], [0, 2.5]];  // primary outline, 8 points, counter clockwise
void_1 = [[80.6, -1], [131, -1], [131, 53], [80.6, 53]];  // thin zone beyond the step, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
}
