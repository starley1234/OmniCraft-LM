$fn = 32;

// ----------------------------------------------------------------------
// Key bar: dovetail key, 10 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 10;      // points of the closed outline

profile = [[0, 0], [30, 0], [30, 4], [24, 8.9], [24, 18], [30, 22], [0, 22], [6, 18], [6, 8.9], [0, 4]];  // single closed polygon, 10 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
