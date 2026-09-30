$fn = 32;

// ----------------------------------------------------------------------
// Window plate: 110 x 35 mm, 2 open windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 3], [0.879, 0.879], [3, 0], [107, 0], [109.121, 0.879], [110, 3], [110, 35], [79.33, 35], [79.33, 29], [84.695, 29], [84.695, 13], [61.965, 13], [61.965, 29], [67.33, 29], [67.33, 35], [42.67, 35], [42.67, 29], [48.035, 29], [48.035, 13], [25.305, 13], [25.305, 29], [30.67, 29], [30.67, 35], [0, 35]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
