$fn = 32;

// ----------------------------------------------------------------------
// Clip blank: staple clip, 10 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 2], [0.586, 0.586], [2, 0], [6, 0], [7.414, 0.586], [8, 2], [8, 16], [7.414, 17.414], [6, 18], [24, 18], [22.586, 17.414], [22, 16], [22, 2], [22.586, 0.586], [24, 0], [28, 0], [29.414, 0.586], [30, 2], [30, 22], [29.414, 23.414], [28, 24], [2, 24], [0.586, 23.414], [0, 22]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
