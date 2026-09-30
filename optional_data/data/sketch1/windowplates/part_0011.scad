$fn = 32;

// ----------------------------------------------------------------------
// Window plate: 70 x 35 mm, 2 open windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 12;      // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 3], [0.879, 0.879], [3, 0], [67, 0], [69.121, 0.879], [70, 3], [70, 35], [50.67, 35], [50.67, 29], [53.905, 29], [53.905, 8], [39.435, 8], [39.435, 29], [42.67, 29], [42.67, 35], [27.33, 35], [27.33, 29], [30.565, 29], [30.565, 8], [16.095, 8], [16.095, 29], [19.33, 29], [19.33, 35], [0, 35]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
