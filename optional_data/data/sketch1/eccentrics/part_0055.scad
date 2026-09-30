$fn = 32;

// ----------------------------------------------------------------------
// Eccentric disc: egg, 10 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 13;      // points of the closed outline

profile = [[0, 16], [2.144, 8], [8, 2.144], [16, 0], [24, 2.144], [31.071, 7.574], [34.337, 12.238], [34.833, 17.91], [32.426, 23.071], [24, 29.856], [16, 32], [8, 29.856], [2.144, 24]];  // single closed polygon, 13 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
