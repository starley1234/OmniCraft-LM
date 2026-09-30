$fn = 32;

// ----------------------------------------------------------------------
// Eccentric disc: step, 8 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 14;      // points of the closed outline

profile = [[0, 16], [2.144, 8], [8, 2.144], [16, 0], [24, 2.144], [35.071, 7.574], [38.337, 12.238], [38.833, 17.91], [36.426, 23.071], [31.762, 26.337], [24, 29.856], [16, 32], [8, 29.856], [2.144, 24]];  // single closed polygon, 14 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
