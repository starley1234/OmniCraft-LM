$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: endstep, 110 x 46 x 10/4.7 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 110;              // bar length, X
bar_w = 46;               // bar width, Y
plate_t = 10;             // thickness of the thick zone, Z
thin_t = 4.7;             // thickness of the thin zone
corner_c = 3;             // corner chamfer of the bar
step_cut = 5.3;           // material removed from the thin zone
step_x = 70.4;            // step position from the left end
depth_1 = 5.3;            // depth of cut 1 from the top face

profile = [[3, 0], [107, 0], [110, 3], [110, 43], [107, 46], [3, 46], [0, 43], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[70.4, -1], [111, -1], [111, 47], [70.4, 47]];  // thin zone beyond the step, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
}
