$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: centerstep, 90 x 52 x 10/5.6 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 90;               // bar length, X
bar_w = 52;               // bar width, Y
plate_t = 10;             // thickness of the thick zone, Z
thin_t = 5.6;             // thickness of the thin zone
corner_c = 2.5;           // corner chamfer of the bar
step_cut = 4.4;           // material removed from the thin zone
thick_from = 25.2;        // start of the thick middle zone
thick_to = 72;            // end of the thick middle zone
depth_1 = 4.4;            // depth of cut 1 from the top face
depth_2 = 4.4;            // depth of cut 2 from the top face

profile = [[2.5, 0], [87.5, 0], [90, 2.5], [90, 49.5], [87.5, 52], [2.5, 52], [0, 49.5], [0, 2.5]];  // primary outline, 8 points, counter clockwise
void_1 = [[-1, -1], [25.2, -1], [25.2, 53], [-1, 53]];  // thin left end, 4 points
void_2 = [[72, -1], [91, -1], [91, 53], [72, 53]];  // thin right end, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
  translate([0, 0, plate_t - depth_2])
    linear_extrude(height = depth_2 + 1) polygon(points = void_2);
}
