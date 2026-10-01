$fn = 32;

// ----------------------------------------------------------------------
// Stepped bar: centerstep, 90 x 46 x 10/3.9 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bar_l = 90;               // bar length, X
bar_w = 46;               // bar width, Y
plate_t = 10;             // thickness of the thick zone, Z
thin_t = 3.9;             // thickness of the thin zone
corner_c = 3;             // corner chamfer of the bar
step_cut = 6.1;           // material removed from the thin zone
thick_from = 23.4;        // start of the thick middle zone
thick_to = 66.6;          // end of the thick middle zone
depth_1 = 6.1;            // depth of cut 1 from the top face
depth_2 = 6.1;            // depth of cut 2 from the top face
fit_tol = 0.1;            // declared fit tolerance (prompt contract)
free_tol = 0.3;           // declared free tolerance (prompt contract)

profile = [[3, 0], [87, 0], [90, 3], [90, 43], [87, 46], [3, 46], [0, 43], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[-1, -1], [23.4, -1], [23.4, 47], [-1, 47]];  // thin left end, 4 points
void_2 = [[66.6, -1], [91, -1], [91, 47], [66.6, 47]];  // thin right end, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
  translate([0, 0, plate_t - depth_2])
    linear_extrude(height = depth_2 + 1) polygon(points = void_2);
}
