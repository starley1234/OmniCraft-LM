$fn = 32;

// ----------------------------------------------------------------------
// Window plate: 130 x 65 mm, 1 open windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 12;      // points of the closed outline

profile = [[0, 3], [0.879, 0.879], [3, 0], [127, 0], [129.121, 0.879], [130, 3], [130, 65], [85.15, 65], [85.15, 39], [44.85, 39], [44.85, 65], [0, 65]];  // single closed polygon, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
