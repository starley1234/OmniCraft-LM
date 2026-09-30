$fn = 32;

// ----------------------------------------------------------------------
// Eye lug: clevis, 6 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 2], [0.586, 0.586], [2, 0], [44, 0], [45.414, 0.586], [46, 2], [46, 20], [45.414, 21.414], [44, 22], [29, 22], [27.586, 21.414], [27, 20], [27, 14], [26.414, 12.586], [25, 12], [21, 12], [19.586, 12.586], [19, 14], [19, 20], [18.414, 21.414], [17, 22], [2, 22], [0.586, 21.414], [0, 20]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
