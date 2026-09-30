$fn = 32;

// ----------------------------------------------------------------------
// Window plate: 90 x 45 mm, 2 open windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 12;      // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 3], [0.879, 0.879], [3, 0], [87, 0], [89.121, 0.879], [90, 3], [90, 45], [66, 45], [66, 41], [69.3, 41], [69.3, 19], [50.7, 19], [50.7, 41], [54, 41], [54, 45], [36, 45], [36, 41], [39.3, 41], [39.3, 19], [20.7, 19], [20.7, 41], [24, 41], [24, 45], [0, 45]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
