$fn = 32;

// ----------------------------------------------------------------------
// Key bar: dovetail key, 12 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 12;      // extrusion height
profile_points = 10;      // points of the closed outline

profile = [[0, 0], [30, 0], [30, 4], [24, 6.1], [24, 10], [30, 14], [0, 14], [6, 10], [6, 6.1], [0, 4]];  // single closed polygon, 10 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
