$fn = 32;

// ----------------------------------------------------------------------
// Key bar: dovetail key, 8 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 10;      // points of the closed outline

profile = [[0, 0], [50, 0], [50, 3], [42, 5.8], [42, 11], [50, 14], [0, 14], [8, 11], [8, 5.8], [0, 3]];  // single closed polygon, 10 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
