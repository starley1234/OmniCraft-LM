$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: centerstep, 100 x 34 x 8/3.3 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 100;              // bar length, X
bar_w = 34;               // bar width, Y
plate_t = 8;              // thickness of the thick zone, Z
thin_t = 3.3;             // thickness of the thin zone
corner_c = 2.5;           // corner chamfer of the bar
step_cut = 4.7;           // material removed from the thin zone
thick_from = 25;          // start of the thick middle zone
thick_to = 77;            // end of the thick middle zone
depth_1 = 4.7;            // depth of cut 1 from the top face
depth_2 = 4.7;            // depth of cut 2 from the top face

profile = [[2.5, 0], [97.5, 0], [100, 2.5], [100, 31.5], [97.5, 34], [2.5, 34], [0, 31.5], [0, 2.5]];  // primary outline, 8 points, counter clockwise
void_1 = [[-1, -1], [25, -1], [25, 35], [-1, 35]];  // thin left end, 4 points
void_2 = [[77, -1], [101, -1], [101, 35], [77, 35]];  // thin right end, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
  translate([0, 0, plate_t - depth_2])
    linear_extrude(height = depth_2 + 1) polygon(points = void_2);
}
