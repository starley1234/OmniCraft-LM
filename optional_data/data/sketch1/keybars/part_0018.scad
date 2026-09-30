$fn = 32;

// ----------------------------------------------------------------------
// Key bar: dovetail key, 12 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 12;      // extrusion height
profile_points = 10;      // points of the closed outline

profile = [[0, 0], [30, 0], [30, 3], [24, 5.8], [24, 11], [30, 14], [0, 14], [6, 11], [6, 5.8], [0, 3]];  // single closed polygon, 10 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
