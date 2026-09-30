$fn = 32;

// ----------------------------------------------------------------------
// Eccentric disc: step, 12 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 12;      // extrusion height
profile_points = 15;      // points of the closed outline

profile = [[0, 16], [2.144, 8], [8, 2.144], [16, 0], [24, 2.144], [31.91, 5.167], [37.071, 7.574], [40.337, 12.238], [40.833, 17.91], [38.426, 23.071], [33.762, 26.337], [24, 29.856], [16, 32], [8, 29.856], [2.144, 24]];  // single closed polygon, 15 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
