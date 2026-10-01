$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: centerstep, 120 x 46 x 10/6.3 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 120;              // bar length, X
bar_w = 46;               // bar width, Y
plate_t = 10;             // thickness of the thick zone, Z
thin_t = 6.3;             // thickness of the thin zone
corner_c = 3;             // corner chamfer of the bar
step_cut = 3.7;           // material removed from the thin zone
thick_from = 38.4;        // start of the thick middle zone
thick_to = 90;            // end of the thick middle zone
depth_1 = 3.7;            // depth of cut 1 from the top face
depth_2 = 3.7;            // depth of cut 2 from the top face

profile = [[3, 0], [117, 0], [120, 3], [120, 43], [117, 46], [3, 46], [0, 43], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[-1, -1], [38.4, -1], [38.4, 47], [-1, 47]];  // thin left end, 4 points
void_2 = [[90, -1], [121, -1], [121, 47], [90, 47]];  // thin right end, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
  translate([0, 0, plate_t - depth_2])
    linear_extrude(height = depth_2 + 1) polygon(points = void_2);
}
