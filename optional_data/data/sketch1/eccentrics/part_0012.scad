$fn = 32;

// ----------------------------------------------------------------------
// Eccentric disc: egg, 10 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 12;      // points of the closed outline

profile = [[0, 22], [2.947, 11], [11, 2.947], [22, 0], [33, 2.947], [41.053, 11], [44, 22], [41.053, 33], [33, 41.053], [22, 44], [11, 41.053], [2.947, 33]];  // single closed polygon, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
