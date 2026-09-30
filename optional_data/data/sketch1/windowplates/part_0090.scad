$fn = 32;

// ----------------------------------------------------------------------
// Window plate: 70 x 45 mm, 2 open windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 12;      // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 3], [0.879, 0.879], [3, 0], [67, 0], [69.121, 0.879], [70, 3], [70, 45], [51.905, 45], [51.905, 41], [53.905, 41], [53.905, 19], [39.435, 19], [39.435, 41], [41.435, 41], [41.435, 45], [28.565, 45], [28.565, 41], [30.565, 41], [30.565, 19], [16.095, 19], [16.095, 41], [18.095, 41], [18.095, 45], [0, 45]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
