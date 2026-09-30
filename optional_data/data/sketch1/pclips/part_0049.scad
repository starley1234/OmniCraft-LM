$fn = 32;

// ----------------------------------------------------------------------
// Clip blank: staple clip, 8 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 2], [0.586, 0.586], [2, 0], [6, 0], [7.414, 0.586], [8, 2], [8, 28], [7.414, 29.414], [6, 30], [44, 30], [42.586, 29.414], [42, 28], [42, 2], [42.586, 0.586], [44, 0], [48, 0], [49.414, 0.586], [50, 2], [50, 34], [49.414, 35.414], [48, 36], [2, 36], [0.586, 35.414], [0, 34]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
