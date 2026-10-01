$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: endstep, 100 x 34 x 12/6.2 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 100;              // bar length, X
bar_w = 34;               // bar width, Y
plate_t = 12;             // thickness of the thick zone, Z
thin_t = 6.2;             // thickness of the thin zone
corner_c = 2;             // corner chamfer of the bar
step_cut = 5.8;           // material removed from the thin zone
step_x = 57;              // step position from the left end
depth_1 = 5.8;            // depth of cut 1 from the top face

profile = [[2, 0], [98, 0], [100, 2], [100, 32], [98, 34], [2, 34], [0, 32], [0, 2]];  // primary outline, 8 points, counter clockwise
void_1 = [[57, -1], [101, -1], [101, 35], [57, 35]];  // thin zone beyond the step, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
}
