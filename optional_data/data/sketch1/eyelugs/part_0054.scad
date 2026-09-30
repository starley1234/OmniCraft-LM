$fn = 32;

// ----------------------------------------------------------------------
// Eye lug: clevis, 10 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 2], [0.586, 0.586], [2, 0], [32, 0], [33.414, 0.586], [34, 2], [34, 26], [33.414, 27.414], [32, 28], [23, 28], [21.586, 27.414], [21, 26], [21, 10], [20.414, 8.586], [19, 8], [15, 8], [13.586, 8.586], [13, 10], [13, 26], [12.414, 27.414], [11, 28], [2, 28], [0.586, 27.414], [0, 26]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
