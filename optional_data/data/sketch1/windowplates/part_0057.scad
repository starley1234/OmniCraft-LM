$fn = 32;

// ----------------------------------------------------------------------
// Window plate: 130 x 65 mm, 2 open windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 12;      // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 3], [0.879, 0.879], [3, 0], [127, 0], [129.121, 0.879], [130, 3], [130, 65], [90.67, 65], [90.67, 59], [100.105, 59], [100.105, 35], [73.235, 35], [73.235, 59], [82.67, 59], [82.67, 65], [47.33, 65], [47.33, 59], [56.765, 59], [56.765, 35], [29.895, 35], [29.895, 59], [39.33, 59], [39.33, 65], [0, 65]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
