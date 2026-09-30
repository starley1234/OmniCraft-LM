$fn = 32;

// ----------------------------------------------------------------------
// Clip blank: staple clip, 10 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 2], [0.586, 0.586], [2, 0], [6, 0], [7.414, 0.586], [8, 2], [8, 24], [7.414, 25.414], [6, 26], [24, 26], [22.586, 25.414], [22, 24], [22, 2], [22.586, 0.586], [24, 0], [28, 0], [29.414, 0.586], [30, 2], [30, 34], [29.414, 35.414], [28, 36], [2, 36], [0.586, 35.414], [0, 34]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
