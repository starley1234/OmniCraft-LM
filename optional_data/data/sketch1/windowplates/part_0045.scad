$fn = 32;

// ----------------------------------------------------------------------
// Window plate: 130 x 55 mm, 2 open windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 12;      // extrusion height
profile_points = 16;      // points of the closed outline

profile = [[0, 3], [0.879, 0.879], [3, 0], [127, 0], [129.121, 0.879], [130, 3], [130, 55], [100.105, 55], [100.105, 25], [73.235, 25], [73.235, 55], [56.765, 55], [56.765, 25], [29.895, 25], [29.895, 55], [0, 55]];  // single closed polygon, 16 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
