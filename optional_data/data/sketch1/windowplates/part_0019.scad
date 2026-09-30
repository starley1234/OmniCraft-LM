$fn = 32;

// ----------------------------------------------------------------------
// Window plate: 70 x 65 mm, 2 open windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 3], [0.879, 0.879], [3, 0], [67, 0], [69.121, 0.879], [70, 3], [70, 65], [51.67, 65], [51.67, 59], [53.905, 59], [53.905, 35], [39.435, 35], [39.435, 59], [41.67, 59], [41.67, 65], [28.33, 65], [28.33, 59], [30.565, 59], [30.565, 35], [16.095, 35], [16.095, 59], [18.33, 59], [18.33, 65], [0, 65]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
