$fn = 32;

// ----------------------------------------------------------------------
// Arc stop: segment, 12 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 12;      // extrusion height
profile_points = 17;      // points of the closed outline

profile = [[73.712, 0], [73.244, 6.68], [71.852, 13.231], [64.162, 11.025], [59.527, 21.366], [52.179, 29.991], [42.707, 36.21], [31.87, 39.523], [20.54, 39.664], [9.624, 36.622], [0, 30.642], [6.428, 22.981], [18.454, 29.109], [31.949, 29.344], [44.181, 23.64], [52.675, 13.151], [55.712, 0]];  // single closed polygon, 17 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
