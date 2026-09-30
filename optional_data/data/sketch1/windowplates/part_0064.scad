$fn = 32;

// ----------------------------------------------------------------------
// Window plate: 110 x 55 mm, 2 open windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 3], [0.879, 0.879], [3, 0], [107, 0], [109.121, 0.879], [110, 3], [110, 55], [77.33, 55], [77.33, 49], [84.695, 49], [84.695, 33], [61.965, 33], [61.965, 49], [69.33, 49], [69.33, 55], [40.67, 55], [40.67, 49], [48.035, 49], [48.035, 33], [25.305, 33], [25.305, 49], [32.67, 49], [32.67, 55], [0, 55]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
