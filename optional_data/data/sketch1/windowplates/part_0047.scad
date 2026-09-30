$fn = 32;

// ----------------------------------------------------------------------
// Window plate: 90 x 35 mm, 2 open windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 3], [0.879, 0.879], [3, 0], [87, 0], [89.121, 0.879], [90, 3], [90, 35], [66, 35], [66, 31], [69.3, 31], [69.3, 8], [50.7, 8], [50.7, 31], [54, 31], [54, 35], [36, 35], [36, 31], [39.3, 31], [39.3, 8], [20.7, 8], [20.7, 31], [24, 31], [24, 35], [0, 35]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
