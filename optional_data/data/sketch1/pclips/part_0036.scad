$fn = 32;

// ----------------------------------------------------------------------
// Clip blank: staple clip, 6 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 2], [0.586, 0.586], [2, 0], [6, 0], [7.414, 0.586], [8, 2], [8, 10], [7.414, 11.414], [6, 12], [44, 12], [42.586, 11.414], [42, 10], [42, 2], [42.586, 0.586], [44, 0], [48, 0], [49.414, 0.586], [50, 2], [50, 16], [49.414, 17.414], [48, 18], [2, 18], [0.586, 17.414], [0, 16]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
