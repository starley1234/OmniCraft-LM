$fn = 32;

// ----------------------------------------------------------------------
// Eccentric disc: egg, 12 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 12;      // extrusion height
profile_points = 14;      // points of the closed outline

profile = [[0, 16], [2.144, 8], [8, 2.144], [16, 0], [24, 2.144], [28.356, 6.041], [29.856, 8], [32.216, 11.554], [32.803, 18.257], [29.959, 24.356], [24, 29.856], [16, 32], [8, 29.856], [2.144, 24]];  // single closed polygon, 14 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
