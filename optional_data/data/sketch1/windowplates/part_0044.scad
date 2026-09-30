$fn = 32;

// ----------------------------------------------------------------------
// Window plate: 130 x 65 mm, 2 open windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 16;      // points of the closed outline

profile = [[0, 3], [0.879, 0.879], [3, 0], [127, 0], [129.121, 0.879], [130, 3], [130, 65], [100.105, 65], [100.105, 35], [73.235, 35], [73.235, 65], [56.765, 65], [56.765, 35], [29.895, 35], [29.895, 65], [0, 65]];  // single closed polygon, 16 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
