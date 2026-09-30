$fn = 32;

// ----------------------------------------------------------------------
// Eccentric disc: step, 10 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 14;      // points of the closed outline

profile = [[0, 16], [2.144, 8], [8, 2.144], [16, 0], [24, 2.144], [35.785, 9.106], [38.457, 12.922], [38.863, 17.563], [36.894, 21.785], [33.078, 24.457], [24, 29.856], [16, 32], [8, 29.856], [2.144, 24]];  // single closed polygon, 14 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
