$fn = 32;

// ----------------------------------------------------------------------
// Window plate: 130 x 45 mm, 2 open windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 3], [0.879, 0.879], [3, 0], [127, 0], [129.121, 0.879], [130, 3], [130, 45], [92.67, 45], [92.67, 41], [100.105, 41], [100.105, 19], [73.235, 19], [73.235, 41], [80.67, 41], [80.67, 45], [49.33, 45], [49.33, 41], [56.765, 41], [56.765, 19], [29.895, 19], [29.895, 41], [37.33, 41], [37.33, 45], [0, 45]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
