$fn = 32;

// ----------------------------------------------------------------------
// Eye lug: clevis, 8 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 2], [0.586, 0.586], [2, 0], [44, 0], [45.414, 0.586], [46, 2], [46, 38], [45.414, 39.414], [44, 40], [30, 40], [28.586, 39.414], [28, 38], [28, 14], [27.414, 12.586], [26, 12], [20, 12], [18.586, 12.586], [18, 14], [18, 38], [17.414, 39.414], [16, 40], [2, 40], [0.586, 39.414], [0, 38]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
