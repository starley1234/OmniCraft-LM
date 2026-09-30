$fn = 32;

// ----------------------------------------------------------------------
// Key bar: dovetail key, 12 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 12;      // extrusion height
profile_points = 10;      // points of the closed outline

profile = [[0, 0], [30, 0], [30, 3], [22, 7.2], [22, 15], [30, 18], [0, 18], [8, 15], [8, 7.2], [0, 3]];  // single closed polygon, 10 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
