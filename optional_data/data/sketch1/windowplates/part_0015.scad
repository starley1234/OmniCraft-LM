$fn = 32;

// ----------------------------------------------------------------------
// Window plate: 90 x 65 mm, 2 open windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 3], [0.879, 0.879], [3, 0], [87, 0], [89.121, 0.879], [90, 3], [90, 65], [66, 65], [66, 59], [69.3, 59], [69.3, 43], [50.7, 43], [50.7, 59], [54, 59], [54, 65], [36, 65], [36, 59], [39.3, 59], [39.3, 43], [20.7, 43], [20.7, 59], [24, 59], [24, 65], [0, 65]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
