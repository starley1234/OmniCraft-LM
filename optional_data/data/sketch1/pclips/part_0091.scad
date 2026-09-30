$fn = 32;

// ----------------------------------------------------------------------
// Clip blank: staple clip, 6 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 2], [0.586, 0.586], [2, 0], [4, 0], [5.414, 0.586], [6, 2], [6, 14], [5.414, 15.414], [4, 16], [36, 16], [34.586, 15.414], [34, 14], [34, 2], [34.586, 0.586], [36, 0], [38, 0], [39.414, 0.586], [40, 2], [40, 22], [39.414, 23.414], [38, 24], [2, 24], [0.586, 23.414], [0, 22]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
