$fn = 32;

// ----------------------------------------------------------------------
// Eye lug: clevis, 8 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 2], [0.586, 0.586], [2, 0], [26, 0], [27.414, 0.586], [28, 2], [28, 38], [27.414, 39.414], [26, 40], [22, 40], [20.586, 39.414], [20, 38], [20, 16], [19.414, 14.586], [18, 14], [10, 14], [8.586, 14.586], [8, 16], [8, 38], [7.414, 39.414], [6, 40], [2, 40], [0.586, 39.414], [0, 38]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
