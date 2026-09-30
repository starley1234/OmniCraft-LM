$fn = 32;

// ----------------------------------------------------------------------
// Clip blank: staple clip, 6 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 2], [0.586, 0.586], [2, 0], [5, 0], [6.414, 0.586], [7, 2], [7, 22], [6.414, 23.414], [5, 24], [35, 24], [33.586, 23.414], [33, 22], [33, 2], [33.586, 0.586], [35, 0], [38, 0], [39.414, 0.586], [40, 2], [40, 28], [39.414, 29.414], [38, 30], [2, 30], [0.586, 29.414], [0, 28]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
