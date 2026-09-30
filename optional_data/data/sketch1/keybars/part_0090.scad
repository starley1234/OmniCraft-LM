$fn = 32;

// ----------------------------------------------------------------------
// Key bar: dovetail key, 12 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 12;      // extrusion height
profile_points = 10;      // points of the closed outline

profile = [[0, 0], [50, 0], [50, 4], [46, 7.5], [46, 14], [50, 18], [0, 18], [4, 14], [4, 7.5], [0, 4]];  // single closed polygon, 10 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
