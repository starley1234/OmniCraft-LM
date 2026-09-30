$fn = 32;

// ----------------------------------------------------------------------
// Key bar: dovetail key, 8 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 10;      // points of the closed outline

profile = [[0, 0], [40, 0], [40, 4], [32, 8.9], [32, 18], [40, 22], [0, 22], [8, 18], [8, 8.9], [0, 4]];  // single closed polygon, 10 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
