$fn = 32;

// ----------------------------------------------------------------------
// Keyway shaft: d24 shaft, key 4 x 3 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
shaft_r = 12;             // shaft radius
key_w = 4;                // keyway width
key_d = 3;                // keyway depth below the surface line
plate_t = 60;             // shaft length, Z (extrusion height)

shaft_d = 2 * shaft_r;  // shaft diameter
circle_step = 15;  // polygon sampling step, degrees

profile = [[8.894, 23.591], [6, 22.392], [3.515, 20.485], [1.608, 18], [0.409, 15.106], [0, 12], [0.409, 8.894], [1.608, 6], [3.515, 3.515], [6, 1.608], [8.894, 0.409], [12, 0], [15.106, 0.409], [18, 1.608], [20.485, 3.515], [22.392, 6], [23.591, 8.894], [24, 12], [23.591, 15.106], [22.392, 18], [20.485, 20.485], [18, 22.392], [15.106, 23.591], [14, 23.832], [14, 20.832], [10, 20.832], [10, 23.832]];  // primary outline, 27 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
