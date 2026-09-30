$fn = 32;

// ----------------------------------------------------------------------
// Window plate: 70 x 45 mm, 1 open windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 16;      // points of the closed outline

profile = [[0, 3], [0.879, 0.879], [3, 0], [67, 0], [69.121, 0.879], [70, 3], [70, 45], [39, 45], [39, 39], [45.85, 39], [45.85, 15], [24.15, 15], [24.15, 39], [31, 39], [31, 45], [0, 45]];  // single closed polygon, 16 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
