$fn = 32;

// ----------------------------------------------------------------------
// Window plate: 110 x 55 mm, 2 open windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 12;      // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 3], [0.879, 0.879], [3, 0], [107, 0], [109.121, 0.879], [110, 3], [110, 55], [78.33, 55], [78.33, 51], [84.695, 51], [84.695, 29], [61.965, 29], [61.965, 51], [68.33, 51], [68.33, 55], [41.67, 55], [41.67, 51], [48.035, 51], [48.035, 29], [25.305, 29], [25.305, 51], [31.67, 51], [31.67, 55], [0, 55]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
