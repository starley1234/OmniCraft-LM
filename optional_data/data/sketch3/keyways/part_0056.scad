$fn = 32;

// ----------------------------------------------------------------------
// Keyway shaft: d36 shaft, key 8 x 3 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
shaft_r = 18;             // shaft radius
key_w = 8;                // keyway width
key_d = 3;                // keyway depth below the surface line
plate_t = 50;             // shaft length, Z (extrusion height)

shaft_d = 2 * shaft_r;  // shaft diameter
circle_step = 15;  // polygon sampling step, degrees

profile = [[13.341, 35.387], [9, 33.588], [5.272, 30.728], [2.412, 27], [0.613, 22.659], [0, 18], [0.613, 13.341], [2.412, 9], [5.272, 5.272], [9, 2.412], [13.341, 0.613], [18, 0], [22.659, 0.613], [27, 2.412], [30.728, 5.272], [33.588, 9], [35.387, 13.341], [36, 18], [35.387, 22.659], [33.588, 27], [30.728, 30.728], [27, 33.588], [22.659, 35.387], [22, 35.55], [22, 32.55], [14, 32.55], [14, 35.55]];  // primary outline, 27 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
