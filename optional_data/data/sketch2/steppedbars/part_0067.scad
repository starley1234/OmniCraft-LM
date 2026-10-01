$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: endstep, 130 x 34 x 12/3.8 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 130;              // bar length, X
bar_w = 34;               // bar width, Y
plate_t = 12;             // thickness of the thick zone, Z
thin_t = 3.8;             // thickness of the thin zone
corner_c = 2.5;           // corner chamfer of the bar
step_cut = 8.2;           // material removed from the thin zone
step_x = 53.3;            // step position from the left end
depth_1 = 8.2;            // depth of cut 1 from the top face

profile = [[2.5, 0], [127.5, 0], [130, 2.5], [130, 31.5], [127.5, 34], [2.5, 34], [0, 31.5], [0, 2.5]];  // primary outline, 8 points, counter clockwise
void_1 = [[53.3, -1], [131, -1], [131, 35], [53.3, 35]];  // thin zone beyond the step, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
}
