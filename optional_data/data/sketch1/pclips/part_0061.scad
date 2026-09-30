$fn = 32;

// ----------------------------------------------------------------------
// Clip blank: staple clip, 6 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 2], [0.586, 0.586], [2, 0], [5, 0], [6.414, 0.586], [7, 2], [7, 8], [6.414, 9.414], [5, 10], [55, 10], [53.586, 9.414], [53, 8], [53, 2], [53.586, 0.586], [55, 0], [58, 0], [59.414, 0.586], [60, 2], [60, 16], [59.414, 17.414], [58, 18], [2, 18], [0.586, 17.414], [0, 16]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
