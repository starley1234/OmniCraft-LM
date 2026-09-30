$fn = 32;

// ----------------------------------------------------------------------
// Window plate: 110 x 55 mm, 2 open windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 16;      // points of the closed outline

profile = [[0, 3], [0.879, 0.879], [3, 0], [107, 0], [109.121, 0.879], [110, 3], [110, 55], [84.695, 55], [84.695, 29], [61.965, 29], [61.965, 55], [48.035, 55], [48.035, 29], [25.305, 29], [25.305, 55], [0, 55]];  // single closed polygon, 16 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
