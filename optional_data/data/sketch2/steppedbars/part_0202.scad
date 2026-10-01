$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: centerstep, 120 x 46 x 8/5.1 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 120;              // bar length, X
bar_w = 46;               // bar width, Y
plate_t = 8;              // thickness of the thick zone, Z
thin_t = 5.1;             // thickness of the thin zone
corner_c = 2.5;           // corner chamfer of the bar
step_cut = 2.9;           // material removed from the thin zone
thick_from = 42;          // start of the thick middle zone
thick_to = 88.8;          // end of the thick middle zone
depth_1 = 2.9;            // depth of cut 1 from the top face
depth_2 = 2.9;            // depth of cut 2 from the top face
fit_tol = 0.1;            // declared fit tolerance (prompt contract)
free_tol = 0.3;           // declared free tolerance (prompt contract)

profile = [[2.5, 0], [117.5, 0], [120, 2.5], [120, 43.5], [117.5, 46], [2.5, 46], [0, 43.5], [0, 2.5]];  // primary outline, 8 points, counter clockwise
void_1 = [[-1, -1], [42, -1], [42, 47], [-1, 47]];  // thin left end, 4 points
void_2 = [[88.8, -1], [121, -1], [121, 47], [88.8, 47]];  // thin right end, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
  translate([0, 0, plate_t - depth_2])
    linear_extrude(height = depth_2 + 1) polygon(points = void_2);
}
