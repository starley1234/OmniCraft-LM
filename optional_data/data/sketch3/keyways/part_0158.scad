$fn = 32;

// ----------------------------------------------------------------------
// Keyway shaft: d28 shaft, key 4 x 4 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
shaft_r = 14;             // shaft radius
key_w = 4;                // keyway width
key_d = 4;                // keyway depth below the surface line
plate_t = 40;             // shaft length, Z (extrusion height)

shaft_d = 2 * shaft_r;  // shaft diameter
circle_step = 15;  // polygon sampling step, degrees

profile = [[10.377, 27.523], [7, 26.124], [4.101, 23.899], [1.876, 21], [0.477, 17.623], [0, 14], [0.477, 10.377], [1.876, 7], [4.101, 4.101], [7, 1.876], [10.377, 0.477], [14, 0], [17.623, 0.477], [21, 1.876], [23.899, 4.101], [26.124, 7], [27.523, 10.377], [28, 14], [27.523, 17.623], [26.124, 21], [23.899, 23.899], [21, 26.124], [17.623, 27.523], [16, 27.856], [16, 23.856], [12, 23.856], [12, 27.856]];  // primary outline, 27 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
