$fn = 32;

// ----------------------------------------------------------------------
// Eccentric disc: step, 6 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 13;      // points of the closed outline

profile = [[0, 22], [2.947, 11], [11, 2.947], [22, 0], [33, 2.947], [41.053, 11], [44.216, 17.554], [44.803, 24.257], [41.053, 33], [33, 41.053], [22, 44], [11, 41.053], [2.947, 33]];  // single closed polygon, 13 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
