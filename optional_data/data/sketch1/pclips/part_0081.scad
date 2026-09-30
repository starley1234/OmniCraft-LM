$fn = 32;

// ----------------------------------------------------------------------
// Clip blank: staple clip, 8 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 2], [0.586, 0.586], [2, 0], [4, 0], [5.414, 0.586], [6, 2], [6, 26], [5.414, 27.414], [4, 28], [56, 28], [54.586, 27.414], [54, 26], [54, 2], [54.586, 0.586], [56, 0], [58, 0], [59.414, 0.586], [60, 2], [60, 34], [59.414, 35.414], [58, 36], [2, 36], [0.586, 35.414], [0, 34]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
