$fn = 32;

// ----------------------------------------------------------------------
// Eccentric disc: step, 10 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 13;      // points of the closed outline

profile = [[0, 22], [2.947, 11], [11, 2.947], [22, 0], [33, 2.947], [44.356, 12.041], [48.216, 17.554], [48.803, 24.257], [45.959, 30.356], [33, 41.053], [22, 44], [11, 41.053], [2.947, 33]];  // single closed polygon, 13 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
