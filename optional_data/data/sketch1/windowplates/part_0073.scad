$fn = 32;

// ----------------------------------------------------------------------
// Window plate: 110 x 35 mm, 2 open windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 3], [0.879, 0.879], [3, 0], [107, 0], [109.121, 0.879], [110, 3], [110, 35], [78.33, 35], [78.33, 31], [84.695, 31], [84.695, 8], [61.965, 8], [61.965, 31], [68.33, 31], [68.33, 35], [41.67, 35], [41.67, 31], [48.035, 31], [48.035, 8], [25.305, 8], [25.305, 31], [31.67, 31], [31.67, 35], [0, 35]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
