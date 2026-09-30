$fn = 32;

// ----------------------------------------------------------------------
// Window plate: 110 x 35 mm, 1 open windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 16;      // points of the closed outline

profile = [[0, 3], [0.879, 0.879], [3, 0], [107, 0], [109.121, 0.879], [110, 3], [110, 35], [59, 35], [59, 29], [72.05, 29], [72.05, 9], [37.95, 9], [37.95, 29], [51, 29], [51, 35], [0, 35]];  // single closed polygon, 16 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
