$fn = 32;

// ----------------------------------------------------------------------
// Clip blank: staple clip, 8 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 2], [0.586, 0.586], [2, 0], [4, 0], [5.414, 0.586], [6, 2], [6, 22], [5.414, 23.414], [4, 24], [26, 24], [24.586, 23.414], [24, 22], [24, 2], [24.586, 0.586], [26, 0], [28, 0], [29.414, 0.586], [30, 2], [30, 28], [29.414, 29.414], [28, 30], [2, 30], [0.586, 29.414], [0, 28]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
