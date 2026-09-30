$fn = 32;

// ----------------------------------------------------------------------
// Window plate: 90 x 45 mm, 2 open windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 3], [0.879, 0.879], [3, 0], [87, 0], [89.121, 0.879], [90, 3], [90, 45], [64, 45], [64, 39], [69.3, 39], [69.3, 27], [50.7, 27], [50.7, 39], [56, 39], [56, 45], [34, 45], [34, 39], [39.3, 39], [39.3, 27], [20.7, 27], [20.7, 39], [26, 39], [26, 45], [0, 45]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
