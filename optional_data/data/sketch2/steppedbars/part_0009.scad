$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: endstep, 120 x 46 x 8/2.8 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 120;              // bar length, X
bar_w = 46;               // bar width, Y
plate_t = 8;              // thickness of the thick zone, Z
thin_t = 2.8;             // thickness of the thin zone
corner_c = 3;             // corner chamfer of the bar
step_cut = 5.2;           // material removed from the thin zone
step_x = 78;              // step position from the left end
depth_1 = 5.2;            // depth of cut 1 from the top face

profile = [[3, 0], [117, 0], [120, 3], [120, 43], [117, 46], [3, 46], [0, 43], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[78, -1], [121, -1], [121, 47], [78, 47]];  // thin zone beyond the step, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
}
