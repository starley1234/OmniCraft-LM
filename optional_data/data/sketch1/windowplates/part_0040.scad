$fn = 32;

// ----------------------------------------------------------------------
// Window plate: 70 x 65 mm, 2 open windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 12;      // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 3], [0.879, 0.879], [3, 0], [67, 0], [69.121, 0.879], [70, 3], [70, 65], [50.67, 65], [50.67, 59], [53.905, 59], [53.905, 47], [39.435, 47], [39.435, 59], [42.67, 59], [42.67, 65], [27.33, 65], [27.33, 59], [30.565, 59], [30.565, 47], [16.095, 47], [16.095, 59], [19.33, 59], [19.33, 65], [0, 65]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
