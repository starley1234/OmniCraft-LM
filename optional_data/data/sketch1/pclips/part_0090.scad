$fn = 32;

// ----------------------------------------------------------------------
// Clip blank: staple clip, 6 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 2], [0.586, 0.586], [2, 0], [5, 0], [6.414, 0.586], [7, 2], [7, 14], [6.414, 15.414], [5, 16], [45, 16], [43.586, 15.414], [43, 14], [43, 2], [43.586, 0.586], [45, 0], [48, 0], [49.414, 0.586], [50, 2], [50, 22], [49.414, 23.414], [48, 24], [2, 24], [0.586, 23.414], [0, 22]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
