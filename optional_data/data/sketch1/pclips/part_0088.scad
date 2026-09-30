$fn = 32;

// ----------------------------------------------------------------------
// Clip blank: staple clip, 10 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 2], [0.586, 0.586], [2, 0], [6, 0], [7.414, 0.586], [8, 2], [8, 14], [7.414, 15.414], [6, 16], [44, 16], [42.586, 15.414], [42, 14], [42, 2], [42.586, 0.586], [44, 0], [48, 0], [49.414, 0.586], [50, 2], [50, 22], [49.414, 23.414], [48, 24], [2, 24], [0.586, 23.414], [0, 22]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
