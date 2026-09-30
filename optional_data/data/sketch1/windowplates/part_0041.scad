$fn = 32;

// ----------------------------------------------------------------------
// Window plate: 130 x 35 mm, 2 open windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 3], [0.879, 0.879], [3, 0], [127, 0], [129.121, 0.879], [130, 3], [130, 35], [90.67, 35], [90.67, 31], [100.105, 31], [100.105, 13], [73.235, 13], [73.235, 31], [82.67, 31], [82.67, 35], [47.33, 35], [47.33, 31], [56.765, 31], [56.765, 13], [29.895, 13], [29.895, 31], [39.33, 31], [39.33, 35], [0, 35]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
