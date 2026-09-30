$fn = 32;

// ----------------------------------------------------------------------
// Eye lug: clevis, 8 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 2], [0.586, 0.586], [2, 0], [32, 0], [33.414, 0.586], [34, 2], [34, 20], [33.414, 21.414], [32, 22], [24, 22], [22.586, 21.414], [22, 20], [22, 16], [21.414, 14.586], [20, 14], [14, 14], [12.586, 14.586], [12, 16], [12, 20], [11.414, 21.414], [10, 22], [2, 22], [0.586, 21.414], [0, 20]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
