$fn = 32;

// ----------------------------------------------------------------------
// Key bar: dovetail key, 6 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 10;      // points of the closed outline

profile = [[0, 0], [30, 0], [30, 4], [22, 7.5], [22, 14], [30, 18], [0, 18], [8, 14], [8, 7.5], [0, 4]];  // single closed polygon, 10 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
