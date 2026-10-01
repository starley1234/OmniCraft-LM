$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: centerstep, 110 x 34 x 12/6.1 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 110;              // bar length, X
bar_w = 34;               // bar width, Y
plate_t = 12;             // thickness of the thick zone, Z
thin_t = 6.1;             // thickness of the thin zone
corner_c = 3;             // corner chamfer of the bar
step_cut = 5.9;           // material removed from the thin zone
thick_from = 33;          // start of the thick middle zone
thick_to = 84.7;          // end of the thick middle zone
depth_1 = 5.9;            // depth of cut 1 from the top face
depth_2 = 5.9;            // depth of cut 2 from the top face

profile = [[3, 0], [107, 0], [110, 3], [110, 31], [107, 34], [3, 34], [0, 31], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[-1, -1], [33, -1], [33, 35], [-1, 35]];  // thin left end, 4 points
void_2 = [[84.7, -1], [111, -1], [111, 35], [84.7, 35]];  // thin right end, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
  translate([0, 0, plate_t - depth_2])
    linear_extrude(height = depth_2 + 1) polygon(points = void_2);
}
