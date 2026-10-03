$fn = 32;
// ----------------------------------------------------------------------
// Clip blank: staple clip, 8 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 2], [0.586, 0.586], [2, 0], [4, 0], [5.414, 0.586], [6, 2], [6, 10], [5.414, 11.414], [4, 12], [56, 12], [54.586, 11.414], [54, 10], [54, 2], [54.586, 0.586], [56, 0], [58, 0], [59.414, 0.586], [60, 2], [60, 16], [59.414, 17.414], [58, 18], [2, 18], [0.586, 17.414], [0, 16]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
