$fn = 32;

// ----------------------------------------------------------------------
// Key bar: dovetail key, 10 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 10;      // points of the closed outline

profile = [[0, 0], [30, 0], [30, 4], [26, 7.5], [26, 14], [30, 18], [0, 18], [4, 14], [4, 7.5], [0, 4]];  // single closed polygon, 10 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
