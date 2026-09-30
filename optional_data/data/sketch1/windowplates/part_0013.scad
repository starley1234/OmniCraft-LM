$fn = 32;

// ----------------------------------------------------------------------
// Window plate: 110 x 65 mm, 3 open windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 20;      // points of the closed outline

profile = [[0, 3], [0.879, 0.879], [3, 0], [107, 0], [109.121, 0.879], [110, 3], [110, 65], [91.025, 65], [91.025, 39], [73.975, 39], [73.975, 65], [63.525, 65], [63.525, 39], [46.475, 39], [46.475, 65], [36.025, 65], [36.025, 39], [18.975, 39], [18.975, 65], [0, 65]];  // single closed polygon, 20 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
