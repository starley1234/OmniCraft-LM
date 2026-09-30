$fn = 32;

// ----------------------------------------------------------------------
// Key bar: dovetail key, 10 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 10;      // points of the closed outline

profile = [[0, 0], [40, 0], [40, 4], [32, 6.1], [32, 10], [40, 14], [0, 14], [8, 10], [8, 6.1], [0, 4]];  // single closed polygon, 10 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
