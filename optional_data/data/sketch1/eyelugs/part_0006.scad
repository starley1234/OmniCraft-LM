$fn = 32;

// ----------------------------------------------------------------------
// Eye lug: clevis, 6 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 2], [0.586, 0.586], [2, 0], [26, 0], [27.414, 0.586], [28, 2], [28, 20], [27.414, 21.414], [26, 22], [21, 22], [19.586, 21.414], [19, 20], [19, 16], [18.414, 14.586], [17, 14], [11, 14], [9.586, 14.586], [9, 16], [9, 20], [8.414, 21.414], [7, 22], [2, 22], [0.586, 21.414], [0, 20]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
