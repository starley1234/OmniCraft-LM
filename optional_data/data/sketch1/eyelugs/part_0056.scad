$fn = 32;

// ----------------------------------------------------------------------
// Eye lug: clevis, 12 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 12;      // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 2], [0.586, 0.586], [2, 0], [38, 0], [39.414, 0.586], [40, 2], [40, 38], [39.414, 39.414], [38, 40], [26, 40], [24.586, 39.414], [24, 38], [24, 14], [23.414, 12.586], [22, 12], [18, 12], [16.586, 12.586], [16, 14], [16, 38], [15.414, 39.414], [14, 40], [2, 40], [0.586, 39.414], [0, 38]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
