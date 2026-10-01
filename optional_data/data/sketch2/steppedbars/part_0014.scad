$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: endstep, 100 x 46 x 8/4.1 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 100;              // bar length, X
bar_w = 46;               // bar width, Y
plate_t = 8;              // thickness of the thick zone, Z
thin_t = 4.1;             // thickness of the thin zone
corner_c = 2.5;           // corner chamfer of the bar
step_cut = 3.9;           // material removed from the thin zone
step_x = 53;              // step position from the left end
depth_1 = 3.9;            // depth of cut 1 from the top face

profile = [[2.5, 0], [97.5, 0], [100, 2.5], [100, 43.5], [97.5, 46], [2.5, 46], [0, 43.5], [0, 2.5]];  // primary outline, 8 points, counter clockwise
void_1 = [[53, -1], [101, -1], [101, 47], [53, 47]];  // thin zone beyond the step, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
}
