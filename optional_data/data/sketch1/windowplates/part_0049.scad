$fn = 32;

// ----------------------------------------------------------------------
// Window plate: 90 x 65 mm, 2 open windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 3], [0.879, 0.879], [3, 0], [87, 0], [89.121, 0.879], [90, 3], [90, 65], [65, 65], [65, 59], [69.3, 59], [69.3, 47], [50.7, 47], [50.7, 59], [55, 59], [55, 65], [35, 65], [35, 59], [39.3, 59], [39.3, 47], [20.7, 47], [20.7, 59], [25, 59], [25, 65], [0, 65]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
