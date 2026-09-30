$fn = 32;

// ----------------------------------------------------------------------
// Window plate: 110 x 35 mm, 2 open windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 12;      // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 3], [0.879, 0.879], [3, 0], [107, 0], [109.121, 0.879], [110, 3], [110, 35], [79.33, 35], [79.33, 31], [84.695, 31], [84.695, 13], [61.965, 13], [61.965, 31], [67.33, 31], [67.33, 35], [42.67, 35], [42.67, 31], [48.035, 31], [48.035, 13], [25.305, 13], [25.305, 31], [30.67, 31], [30.67, 35], [0, 35]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
