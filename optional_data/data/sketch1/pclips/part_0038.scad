$fn = 32;

// ----------------------------------------------------------------------
// Clip blank: staple clip, 10 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 2], [0.586, 0.586], [2, 0], [5, 0], [6.414, 0.586], [7, 2], [7, 16], [6.414, 17.414], [5, 18], [55, 18], [53.586, 17.414], [53, 16], [53, 2], [53.586, 0.586], [55, 0], [58, 0], [59.414, 0.586], [60, 2], [60, 22], [59.414, 23.414], [58, 24], [2, 24], [0.586, 23.414], [0, 22]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
