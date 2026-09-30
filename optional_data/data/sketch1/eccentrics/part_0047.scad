$fn = 32;

// ----------------------------------------------------------------------
// Eccentric disc: egg, 8 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 12;      // points of the closed outline

profile = [[0, 16], [2.144, 8], [8, 2.144], [16, 0], [24, 2.144], [29.856, 8], [32, 16], [29.856, 24], [24, 29.856], [16, 32], [8, 29.856], [2.144, 24]];  // single closed polygon, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
