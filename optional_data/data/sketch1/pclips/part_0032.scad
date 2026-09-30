$fn = 32;

// ----------------------------------------------------------------------
// Clip blank: staple clip, 10 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 2], [0.586, 0.586], [2, 0], [4, 0], [5.414, 0.586], [6, 2], [6, 6], [5.414, 7.414], [4, 8], [26, 8], [24.586, 7.414], [24, 6], [24, 2], [24.586, 0.586], [26, 0], [28, 0], [29.414, 0.586], [30, 2], [30, 16], [29.414, 17.414], [28, 18], [2, 18], [0.586, 17.414], [0, 16]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
