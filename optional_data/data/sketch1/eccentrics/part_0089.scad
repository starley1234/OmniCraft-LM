$fn = 32;

// ----------------------------------------------------------------------
// Eccentric disc: step, 8 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 13;      // points of the closed outline

profile = [[0, 16], [2.144, 8], [8, 2.144], [16, 0], [24, 2.144], [33.785, 9.106], [36.457, 12.922], [36.863, 17.563], [34.894, 21.785], [24, 29.856], [16, 32], [8, 29.856], [2.144, 24]];  // single closed polygon, 13 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
