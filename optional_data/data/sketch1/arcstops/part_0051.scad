$fn = 32;

// ----------------------------------------------------------------------
// Arc stop: segment, 8 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 17;      // points of the closed outline

profile = [[71.712, 0], [71.264, 6.402], [69.93, 12.679], [64.162, 11.025], [59.527, 21.366], [52.179, 29.991], [42.707, 36.21], [31.87, 39.523], [20.54, 39.664], [9.624, 36.622], [0, 30.642], [7.713, 21.449], [18.938, 27.168], [31.533, 27.388], [42.95, 22.064], [50.878, 12.274], [53.712, 0]];  // single closed polygon, 17 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
