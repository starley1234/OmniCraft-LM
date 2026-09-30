$fn = 32;

// ----------------------------------------------------------------------
// Window plate: 130 x 55 mm, 2 open windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 3], [0.879, 0.879], [3, 0], [127, 0], [129.121, 0.879], [130, 3], [130, 55], [92.67, 55], [92.67, 51], [100.105, 51], [100.105, 25], [73.235, 25], [73.235, 51], [80.67, 51], [80.67, 55], [49.33, 55], [49.33, 51], [56.765, 51], [56.765, 25], [29.895, 25], [29.895, 51], [37.33, 51], [37.33, 55], [0, 55]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
