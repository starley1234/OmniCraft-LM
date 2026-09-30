$fn = 32;

// ----------------------------------------------------------------------
// Eccentric disc: step, 12 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 12;      // extrusion height
profile_points = 13;      // points of the closed outline

profile = [[0, 16], [2.144, 8], [8, 2.144], [16, 0], [30.257, 3.197], [36.356, 6.041], [40.216, 11.554], [40.803, 18.257], [37.959, 24.356], [32.446, 28.216], [16, 32], [8, 29.856], [2.144, 24]];  // single closed polygon, 13 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
