$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: endstep, 110 x 40 x 10/5.9 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 110;              // bar length, X
bar_w = 40;               // bar width, Y
plate_t = 10;             // thickness of the thick zone, Z
thin_t = 5.9;             // thickness of the thin zone
corner_c = 3;             // corner chamfer of the bar
step_cut = 4.1;           // material removed from the thin zone
step_x = 52.8;            // step position from the left end
depth_1 = 4.1;            // depth of cut 1 from the top face

profile = [[3, 0], [107, 0], [110, 3], [110, 37], [107, 40], [3, 40], [0, 37], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[52.8, -1], [111, -1], [111, 41], [52.8, 41]];  // thin zone beyond the step, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
}
