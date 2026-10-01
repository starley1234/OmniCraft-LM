$fn = 32;

// ----------------------------------------------------------------------
// Keyway shaft: d24 shaft, key 8 x 3 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
shaft_r = 12;             // shaft radius
key_w = 8;                // keyway width
key_d = 3;                // keyway depth below the surface line
plate_t = 50;             // shaft length, Z (extrusion height)
fit_tol = 0.1;            // declared fit tolerance (prompt contract)
free_tol = 0.5;           // declared free tolerance (prompt contract)

shaft_d = 2 * shaft_r;  // shaft diameter
circle_step = 15;  // polygon sampling step, degrees

profile = [[6, 22.392], [3.515, 20.485], [1.608, 18], [0.409, 15.106], [0, 12], [0.409, 8.894], [1.608, 6], [3.515, 3.515], [6, 1.608], [8.894, 0.409], [12, 0], [15.106, 0.409], [18, 1.608], [20.485, 3.515], [22.392, 6], [23.591, 8.894], [24, 12], [23.591, 15.106], [22.392, 18], [20.485, 20.485], [18, 22.392], [16, 23.314], [16, 20.314], [8, 20.314], [8, 23.314]];  // primary outline, 25 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
