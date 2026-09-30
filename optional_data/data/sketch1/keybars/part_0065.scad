$fn = 32;

// ----------------------------------------------------------------------
// Key bar: dovetail key, 6 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 10;      // points of the closed outline

profile = [[0, 0], [40, 0], [40, 4], [34, 7.5], [34, 14], [40, 18], [0, 18], [6, 14], [6, 7.5], [0, 4]];  // single closed polygon, 10 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
