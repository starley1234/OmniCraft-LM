$fn = 32;

// ----------------------------------------------------------------------
// Clip blank: staple clip, 8 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 2], [0.586, 0.586], [2, 0], [5, 0], [6.414, 0.586], [7, 2], [7, 18], [6.414, 19.414], [5, 20], [25, 20], [23.586, 19.414], [23, 18], [23, 2], [23.586, 0.586], [25, 0], [28, 0], [29.414, 0.586], [30, 2], [30, 28], [29.414, 29.414], [28, 30], [2, 30], [0.586, 29.414], [0, 28]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
