$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: endstep, 100 x 46 x 10/4.9 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 100;              // bar length, X
bar_w = 46;               // bar width, Y
plate_t = 10;             // thickness of the thick zone, Z
thin_t = 4.9;             // thickness of the thin zone
corner_c = 3;             // corner chamfer of the bar
step_cut = 5.1;           // material removed from the thin zone
step_x = 56;              // step position from the left end
depth_1 = 5.1;            // depth of cut 1 from the top face

profile = [[3, 0], [97, 0], [100, 3], [100, 43], [97, 46], [3, 46], [0, 43], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[56, -1], [101, -1], [101, 47], [56, 47]];  // thin zone beyond the step, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
}
