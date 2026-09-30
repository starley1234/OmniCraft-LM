$fn = 32;

// ----------------------------------------------------------------------
// Key bar: dovetail key, 6 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 10;      // points of the closed outline

profile = [[0, 0], [50, 0], [50, 3], [44, 5.8], [44, 11], [50, 14], [0, 14], [6, 11], [6, 5.8], [0, 3]];  // single closed polygon, 10 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
