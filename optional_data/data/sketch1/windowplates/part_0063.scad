$fn = 32;

// ----------------------------------------------------------------------
// Window plate: 70 x 55 mm, 2 open windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 3], [0.879, 0.879], [3, 0], [67, 0], [69.121, 0.879], [70, 3], [70, 55], [51.67, 55], [51.67, 51], [53.905, 51], [53.905, 37], [39.435, 37], [39.435, 51], [41.67, 51], [41.67, 55], [28.33, 55], [28.33, 51], [30.565, 51], [30.565, 37], [16.095, 37], [16.095, 51], [18.33, 51], [18.33, 55], [0, 55]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
