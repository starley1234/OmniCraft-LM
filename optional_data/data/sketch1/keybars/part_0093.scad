$fn = 32;

// ----------------------------------------------------------------------
// Key bar: dovetail key, 10 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 10;      // points of the closed outline

profile = [[0, 0], [50, 0], [50, 4], [46, 8.9], [46, 18], [50, 22], [0, 22], [4, 18], [4, 8.9], [0, 4]];  // single closed polygon, 10 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
