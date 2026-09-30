$fn = 32;

// ----------------------------------------------------------------------
// Eye lug: clevis, 8 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 2], [0.586, 0.586], [2, 0], [26, 0], [27.414, 0.586], [28, 2], [28, 20], [27.414, 21.414], [26, 22], [20, 22], [18.586, 21.414], [18, 20], [18, 10], [17.414, 8.586], [16, 8], [12, 8], [10.586, 8.586], [10, 10], [10, 20], [9.414, 21.414], [8, 22], [2, 22], [0.586, 21.414], [0, 20]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
