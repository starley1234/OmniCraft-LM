$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: centerstep, 90 x 52 x 8/4.5 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 90;               // bar length, X
bar_w = 52;               // bar width, Y
plate_t = 8;              // thickness of the thick zone, Z
thin_t = 4.5;             // thickness of the thin zone
corner_c = 2;             // corner chamfer of the bar
step_cut = 3.5;           // material removed from the thin zone
thick_from = 25.2;        // start of the thick middle zone
thick_to = 66.6;          // end of the thick middle zone
depth_1 = 3.5;            // depth of cut 1 from the top face
depth_2 = 3.5;            // depth of cut 2 from the top face

profile = [[2, 0], [88, 0], [90, 2], [90, 50], [88, 52], [2, 52], [0, 50], [0, 2]];  // primary outline, 8 points, counter clockwise
void_1 = [[-1, -1], [25.2, -1], [25.2, 53], [-1, 53]];  // thin left end, 4 points
void_2 = [[66.6, -1], [91, -1], [91, 53], [66.6, 53]];  // thin right end, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
  translate([0, 0, plate_t - depth_2])
    linear_extrude(height = depth_2 + 1) polygon(points = void_2);
}
