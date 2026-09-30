$fn = 32;

// ----------------------------------------------------------------------
// Window plate: 90 x 35 mm, 2 open windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 3], [0.879, 0.879], [3, 0], [87, 0], [89.121, 0.879], [90, 3], [90, 35], [65, 35], [65, 31], [69.3, 31], [69.3, 17], [50.7, 17], [50.7, 31], [55, 31], [55, 35], [35, 35], [35, 31], [39.3, 31], [39.3, 17], [20.7, 17], [20.7, 31], [25, 31], [25, 35], [0, 35]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
