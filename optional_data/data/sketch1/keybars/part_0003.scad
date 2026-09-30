$fn = 32;

// ----------------------------------------------------------------------
// Key bar: dovetail key, 10 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 10;      // points of the closed outline

profile = [[0, 0], [50, 0], [50, 4], [42, 6.1], [42, 10], [50, 14], [0, 14], [8, 10], [8, 6.1], [0, 4]];  // single closed polygon, 10 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
