$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: centerstep, 130 x 34 x 10/5.7 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 130;              // bar length, X
bar_w = 34;               // bar width, Y
plate_t = 10;             // thickness of the thick zone, Z
thin_t = 5.7;             // thickness of the thin zone
corner_c = 2;             // corner chamfer of the bar
step_cut = 4.3;           // material removed from the thin zone
thick_from = 41.6;        // start of the thick middle zone
thick_to = 84.5;          // end of the thick middle zone
depth_1 = 4.3;            // depth of cut 1 from the top face
depth_2 = 4.3;            // depth of cut 2 from the top face

profile = [[2, 0], [128, 0], [130, 2], [130, 32], [128, 34], [2, 34], [0, 32], [0, 2]];  // primary outline, 8 points, counter clockwise
void_1 = [[-1, -1], [41.6, -1], [41.6, 35], [-1, 35]];  // thin left end, 4 points
void_2 = [[84.5, -1], [131, -1], [131, 35], [84.5, 35]];  // thin right end, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
  translate([0, 0, plate_t - depth_2])
    linear_extrude(height = depth_2 + 1) polygon(points = void_2);
}
