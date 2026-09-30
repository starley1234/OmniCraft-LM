$fn = 32;

// ----------------------------------------------------------------------
// Window plate: 130 x 35 mm, 2 open windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 12;      // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 3], [0.879, 0.879], [3, 0], [127, 0], [129.121, 0.879], [130, 3], [130, 35], [90.67, 35], [90.67, 29], [100.105, 29], [100.105, 9], [73.235, 9], [73.235, 29], [82.67, 29], [82.67, 35], [47.33, 35], [47.33, 29], [56.765, 29], [56.765, 9], [29.895, 9], [29.895, 29], [39.33, 29], [39.33, 35], [0, 35]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
