$fn = 32;

// ----------------------------------------------------------------------
// Window plate: 110 x 45 mm, 1 open windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 12;      // extrusion height
profile_points = 12;      // points of the closed outline

profile = [[0, 3], [0.879, 0.879], [3, 0], [107, 0], [109.121, 0.879], [110, 3], [110, 45], [72.05, 45], [72.05, 19], [37.95, 19], [37.95, 45], [0, 45]];  // single closed polygon, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
