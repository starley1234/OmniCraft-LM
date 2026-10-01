$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: centerstep, 90 x 40 x 12/4 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 90;               // bar length, X
bar_w = 40;               // bar width, Y
plate_t = 12;             // thickness of the thick zone, Z
thin_t = 4;               // thickness of the thin zone
corner_c = 3;             // corner chamfer of the bar
step_cut = 8;             // material removed from the thin zone
thick_from = 27.9;        // start of the thick middle zone
thick_to = 68.4;          // end of the thick middle zone
depth_1 = 8;              // depth of cut 1 from the top face
depth_2 = 8;              // depth of cut 2 from the top face

profile = [[3, 0], [87, 0], [90, 3], [90, 37], [87, 40], [3, 40], [0, 37], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[-1, -1], [27.9, -1], [27.9, 41], [-1, 41]];  // thin left end, 4 points
void_2 = [[68.4, -1], [91, -1], [91, 41], [68.4, 41]];  // thin right end, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
  translate([0, 0, plate_t - depth_2])
    linear_extrude(height = depth_2 + 1) polygon(points = void_2);
}
