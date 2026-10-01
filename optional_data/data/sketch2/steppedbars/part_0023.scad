$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: endstep, 100 x 46 x 8/3.8 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 100;              // bar length, X
bar_w = 46;               // bar width, Y
plate_t = 8;              // thickness of the thick zone, Z
thin_t = 3.8;             // thickness of the thin zone
corner_c = 2;             // corner chamfer of the bar
step_cut = 4.2;           // material removed from the thin zone
step_x = 52;              // step position from the left end
depth_1 = 4.2;            // depth of cut 1 from the top face

profile = [[2, 0], [98, 0], [100, 2], [100, 44], [98, 46], [2, 46], [0, 44], [0, 2]];  // primary outline, 8 points, counter clockwise
void_1 = [[52, -1], [101, -1], [101, 47], [52, 47]];  // thin zone beyond the step, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
}
