$fn = 32;

// ----------------------------------------------------------------------
// Clip blank: staple clip, 8 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 2], [0.586, 0.586], [2, 0], [4, 0], [5.414, 0.586], [6, 2], [6, 20], [5.414, 21.414], [4, 22], [56, 22], [54.586, 21.414], [54, 20], [54, 2], [54.586, 0.586], [56, 0], [58, 0], [59.414, 0.586], [60, 2], [60, 28], [59.414, 29.414], [58, 30], [2, 30], [0.586, 29.414], [0, 28]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
