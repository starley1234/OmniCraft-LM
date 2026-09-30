$fn = 32;

// ----------------------------------------------------------------------
// Eye lug: clevis, 6 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 2], [0.586, 0.586], [2, 0], [38, 0], [39.414, 0.586], [40, 2], [40, 20], [39.414, 21.414], [38, 22], [28, 22], [26.586, 21.414], [26, 20], [26, 12], [25.414, 10.586], [24, 10], [16, 10], [14.586, 10.586], [14, 12], [14, 20], [13.414, 21.414], [12, 22], [2, 22], [0.586, 21.414], [0, 20]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
