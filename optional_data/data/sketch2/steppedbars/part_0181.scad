$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: centerstep, 130 x 46 x 8/4.7 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 130;              // bar length, X
bar_w = 46;               // bar width, Y
plate_t = 8;              // thickness of the thick zone, Z
thin_t = 4.7;             // thickness of the thin zone
corner_c = 3;             // corner chamfer of the bar
step_cut = 3.3;           // material removed from the thin zone
thick_from = 35.1;        // start of the thick middle zone
thick_to = 85.8;          // end of the thick middle zone
depth_1 = 3.3;            // depth of cut 1 from the top face
depth_2 = 3.3;            // depth of cut 2 from the top face

profile = [[3, 0], [127, 0], [130, 3], [130, 43], [127, 46], [3, 46], [0, 43], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[-1, -1], [35.1, -1], [35.1, 47], [-1, 47]];  // thin left end, 4 points
void_2 = [[85.8, -1], [131, -1], [131, 47], [85.8, 47]];  // thin right end, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
  translate([0, 0, plate_t - depth_2])
    linear_extrude(height = depth_2 + 1) polygon(points = void_2);
}
