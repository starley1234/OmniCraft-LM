$fn = 32;

// ----------------------------------------------------------------------
// Clip blank: staple clip, 8 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 2], [0.586, 0.586], [2, 0], [4, 0], [5.414, 0.586], [6, 2], [6, 26], [5.414, 27.414], [4, 28], [26, 28], [24.586, 27.414], [24, 26], [24, 2], [24.586, 0.586], [26, 0], [28, 0], [29.414, 0.586], [30, 2], [30, 34], [29.414, 35.414], [28, 36], [2, 36], [0.586, 35.414], [0, 34]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
