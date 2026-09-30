$fn = 32;

// ----------------------------------------------------------------------
// Clip blank: staple clip, 8 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 2], [0.586, 0.586], [2, 0], [4, 0], [5.414, 0.586], [6, 2], [6, 12], [5.414, 13.414], [4, 14], [56, 14], [54.586, 13.414], [54, 12], [54, 2], [54.586, 0.586], [56, 0], [58, 0], [59.414, 0.586], [60, 2], [60, 22], [59.414, 23.414], [58, 24], [2, 24], [0.586, 23.414], [0, 22]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
