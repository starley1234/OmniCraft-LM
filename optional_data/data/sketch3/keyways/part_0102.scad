$fn = 32;

// ----------------------------------------------------------------------
// Keyway shaft: d40 shaft, key 6 x 3 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
shaft_r = 20;             // shaft radius
key_w = 6;                // keyway width
key_d = 3;                // keyway depth below the surface line
plate_t = 50;             // shaft length, Z (extrusion height)

shaft_d = 2 * shaft_r;  // shaft diameter
circle_step = 15;  // polygon sampling step, degrees

profile = [[14.824, 39.319], [10, 37.321], [5.858, 34.142], [2.679, 30], [0.681, 25.176], [0, 20], [0.681, 14.824], [2.679, 10], [5.858, 5.858], [10, 2.679], [14.824, 0.681], [20, 0], [25.176, 0.681], [30, 2.679], [34.142, 5.858], [37.321, 10], [39.319, 14.824], [40, 20], [39.319, 25.176], [37.321, 30], [34.142, 34.142], [30, 37.321], [25.176, 39.319], [23, 39.774], [23, 36.774], [17, 36.774], [17, 39.774]];  // primary outline, 27 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
