$fn = 32;

// ----------------------------------------------------------------------
// Window plate: 110 x 65 mm, 2 open windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 3], [0.879, 0.879], [3, 0], [107, 0], [109.121, 0.879], [110, 3], [110, 65], [78.33, 65], [78.33, 59], [84.695, 59], [84.695, 43], [61.965, 43], [61.965, 59], [68.33, 59], [68.33, 65], [41.67, 65], [41.67, 59], [48.035, 59], [48.035, 43], [25.305, 43], [25.305, 59], [31.67, 59], [31.67, 65], [0, 65]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
