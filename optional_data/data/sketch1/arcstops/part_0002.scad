$fn = 32;

// ----------------------------------------------------------------------
// Arc stop: segment, 10 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 17;      // points of the closed outline

profile = [[73.712, 0], [73.244, 6.68], [71.852, 13.231], [64.162, 11.025], [59.527, 21.366], [52.179, 29.991], [42.707, 36.21], [31.87, 39.523], [20.54, 39.664], [9.624, 36.622], [0, 30.642], [5.142, 24.513], [17.97, 31.049], [32.365, 31.301], [45.413, 25.216], [54.473, 14.028], [57.712, 0]];  // single closed polygon, 17 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
