$fn = 32;

// ----------------------------------------------------------------------
// Clip blank: staple clip, 8 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 2], [0.586, 0.586], [2, 0], [4, 0], [5.414, 0.586], [6, 2], [6, 20], [5.414, 21.414], [4, 22], [36, 22], [34.586, 21.414], [34, 20], [34, 2], [34.586, 0.586], [36, 0], [38, 0], [39.414, 0.586], [40, 2], [40, 28], [39.414, 29.414], [38, 30], [2, 30], [0.586, 29.414], [0, 28]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
