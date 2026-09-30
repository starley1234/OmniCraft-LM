$fn = 32;

// ----------------------------------------------------------------------
// Eccentric disc: step, 6 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 14;      // points of the closed outline

profile = [[0, 16], [2.144, 8], [8, 2.144], [16, 0], [24, 2.144], [33.071, 7.574], [36.337, 12.238], [36.833, 17.91], [34.426, 23.071], [29.762, 26.337], [24, 29.856], [16, 32], [8, 29.856], [2.144, 24]];  // single closed polygon, 14 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
