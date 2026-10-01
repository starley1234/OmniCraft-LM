$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: centerstep, 130 x 46 x 8/3.9 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 130;              // bar length, X
bar_w = 46;               // bar width, Y
plate_t = 8;              // thickness of the thick zone, Z
thin_t = 3.9;             // thickness of the thin zone
corner_c = 2;             // corner chamfer of the bar
step_cut = 4.1;           // material removed from the thin zone
thick_from = 40.3;        // start of the thick middle zone
thick_to = 96.2;          // end of the thick middle zone
depth_1 = 4.1;            // depth of cut 1 from the top face
depth_2 = 4.1;            // depth of cut 2 from the top face

profile = [[2, 0], [128, 0], [130, 2], [130, 44], [128, 46], [2, 46], [0, 44], [0, 2]];  // primary outline, 8 points, counter clockwise
void_1 = [[-1, -1], [40.3, -1], [40.3, 47], [-1, 47]];  // thin left end, 4 points
void_2 = [[96.2, -1], [131, -1], [131, 47], [96.2, 47]];  // thin right end, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
  translate([0, 0, plate_t - depth_2])
    linear_extrude(height = depth_2 + 1) polygon(points = void_2);
}
