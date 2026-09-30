$fn = 32;

// ----------------------------------------------------------------------
// Window plate: 90 x 55 mm, 2 open windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 3], [0.879, 0.879], [3, 0], [87, 0], [89.121, 0.879], [90, 3], [90, 55], [66, 55], [66, 51], [69.3, 51], [69.3, 25], [50.7, 25], [50.7, 51], [54, 51], [54, 55], [36, 55], [36, 51], [39.3, 51], [39.3, 25], [20.7, 25], [20.7, 51], [24, 51], [24, 55], [0, 55]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
