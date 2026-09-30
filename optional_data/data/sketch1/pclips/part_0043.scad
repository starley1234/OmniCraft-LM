$fn = 32;

// ----------------------------------------------------------------------
// Clip blank: staple clip, 6 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 2], [0.586, 0.586], [2, 0], [5, 0], [6.414, 0.586], [7, 2], [7, 16], [6.414, 17.414], [5, 18], [35, 18], [33.586, 17.414], [33, 16], [33, 2], [33.586, 0.586], [35, 0], [38, 0], [39.414, 0.586], [40, 2], [40, 22], [39.414, 23.414], [38, 24], [2, 24], [0.586, 23.414], [0, 22]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
