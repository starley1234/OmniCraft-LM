$fn = 32;

// ----------------------------------------------------------------------
// Key bar: dovetail key, 12 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 12;      // extrusion height
profile_points = 10;      // points of the closed outline

profile = [[0, 0], [50, 0], [50, 3], [44, 8.6], [44, 19], [50, 22], [0, 22], [6, 19], [6, 8.6], [0, 3]];  // single closed polygon, 10 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
