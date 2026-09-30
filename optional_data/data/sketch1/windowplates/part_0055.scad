$fn = 32;

// ----------------------------------------------------------------------
// Window plate: 90 x 55 mm, 2 open windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 3], [0.879, 0.879], [3, 0], [87, 0], [89.121, 0.879], [90, 3], [90, 55], [64, 55], [64, 49], [69.3, 49], [69.3, 25], [50.7, 25], [50.7, 49], [56, 49], [56, 55], [34, 55], [34, 49], [39.3, 49], [39.3, 25], [20.7, 25], [20.7, 49], [26, 49], [26, 55], [0, 55]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
