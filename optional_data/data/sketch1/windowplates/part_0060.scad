$fn = 32;

// ----------------------------------------------------------------------
// Window plate: 70 x 35 mm, 2 open windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 16;      // points of the closed outline

profile = [[0, 3], [0.879, 0.879], [3, 0], [67, 0], [69.121, 0.879], [70, 3], [70, 35], [53.905, 35], [53.905, 9], [39.435, 9], [39.435, 35], [30.565, 35], [30.565, 9], [16.095, 9], [16.095, 35], [0, 35]];  // single closed polygon, 16 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
