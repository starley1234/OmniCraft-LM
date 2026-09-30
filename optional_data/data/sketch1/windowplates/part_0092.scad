$fn = 32;

// ----------------------------------------------------------------------
// Window plate: 110 x 65 mm, 2 open windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 3], [0.879, 0.879], [3, 0], [107, 0], [109.121, 0.879], [110, 3], [110, 65], [79.33, 65], [79.33, 61], [84.695, 61], [84.695, 35], [61.965, 35], [61.965, 61], [67.33, 61], [67.33, 65], [42.67, 65], [42.67, 61], [48.035, 61], [48.035, 35], [25.305, 35], [25.305, 61], [30.67, 61], [30.67, 65], [0, 65]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
