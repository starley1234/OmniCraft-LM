$fn = 32;

// ----------------------------------------------------------------------
// Window plate: 90 x 35 mm, 2 open windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 16;      // points of the closed outline

profile = [[0, 3], [0.879, 0.879], [3, 0], [87, 0], [89.121, 0.879], [90, 3], [90, 35], [69.3, 35], [69.3, 9], [50.7, 9], [50.7, 35], [39.3, 35], [39.3, 9], [20.7, 9], [20.7, 35], [0, 35]];  // single closed polygon, 16 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
