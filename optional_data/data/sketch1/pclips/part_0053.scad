$fn = 32;

// ----------------------------------------------------------------------
// Clip blank: staple clip, 10 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 2], [0.586, 0.586], [2, 0], [6, 0], [7.414, 0.586], [8, 2], [8, 26], [7.414, 27.414], [6, 28], [34, 28], [32.586, 27.414], [32, 26], [32, 2], [32.586, 0.586], [34, 0], [38, 0], [39.414, 0.586], [40, 2], [40, 34], [39.414, 35.414], [38, 36], [2, 36], [0.586, 35.414], [0, 34]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
