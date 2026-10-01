$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: centerstep, 90 x 46 x 10/3.6 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 90;               // bar length, X
bar_w = 46;               // bar width, Y
plate_t = 10;             // thickness of the thick zone, Z
thin_t = 3.6;             // thickness of the thin zone
corner_c = 2.5;           // corner chamfer of the bar
step_cut = 6.4;           // material removed from the thin zone
thick_from = 27.9;        // start of the thick middle zone
thick_to = 65.7;          // end of the thick middle zone
depth_1 = 6.4;            // depth of cut 1 from the top face
depth_2 = 6.4;            // depth of cut 2 from the top face

profile = [[2.5, 0], [87.5, 0], [90, 2.5], [90, 43.5], [87.5, 46], [2.5, 46], [0, 43.5], [0, 2.5]];  // primary outline, 8 points, counter clockwise
void_1 = [[-1, -1], [27.9, -1], [27.9, 47], [-1, 47]];  // thin left end, 4 points
void_2 = [[65.7, -1], [91, -1], [91, 47], [65.7, 47]];  // thin right end, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
  translate([0, 0, plate_t - depth_2])
    linear_extrude(height = depth_2 + 1) polygon(points = void_2);
}
