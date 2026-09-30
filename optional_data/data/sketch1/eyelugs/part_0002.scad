$fn = 32;

// ----------------------------------------------------------------------
// Eye lug: clevis, 12 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 12;      // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 2], [0.586, 0.586], [2, 0], [38, 0], [39.414, 0.586], [40, 2], [40, 26], [39.414, 27.414], [38, 28], [29, 28], [27.586, 27.414], [27, 26], [27, 16], [26.414, 14.586], [25, 14], [15, 14], [13.586, 14.586], [13, 16], [13, 26], [12.414, 27.414], [11, 28], [2, 28], [0.586, 27.414], [0, 26]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
