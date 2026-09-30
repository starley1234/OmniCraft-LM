$fn = 32;

// ----------------------------------------------------------------------
// Window plate: 110 x 45 mm, 2 open windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 3], [0.879, 0.879], [3, 0], [107, 0], [109.121, 0.879], [110, 3], [110, 45], [77.33, 45], [77.33, 39], [84.695, 39], [84.695, 23], [61.965, 23], [61.965, 39], [69.33, 39], [69.33, 45], [40.67, 45], [40.67, 39], [48.035, 39], [48.035, 23], [25.305, 23], [25.305, 39], [32.67, 39], [32.67, 45], [0, 45]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
