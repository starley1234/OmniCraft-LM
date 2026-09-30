$fn = 32;

// ----------------------------------------------------------------------
// Window plate: 130 x 55 mm, 2 open windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 3], [0.879, 0.879], [3, 0], [127, 0], [129.121, 0.879], [130, 3], [130, 55], [91.67, 55], [91.67, 49], [100.105, 49], [100.105, 37], [73.235, 37], [73.235, 49], [81.67, 49], [81.67, 55], [48.33, 55], [48.33, 49], [56.765, 49], [56.765, 37], [29.895, 37], [29.895, 49], [38.33, 49], [38.33, 55], [0, 55]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
