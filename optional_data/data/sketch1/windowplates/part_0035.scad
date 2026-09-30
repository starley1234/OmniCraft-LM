$fn = 32;

// ----------------------------------------------------------------------
// Window plate: 130 x 35 mm, 3 open windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 20;      // points of the closed outline

profile = [[0, 3], [0.879, 0.879], [3, 0], [127, 0], [129.121, 0.879], [130, 3], [130, 35], [107.575, 35], [107.575, 9], [87.425, 9], [87.425, 35], [75.075, 35], [75.075, 9], [54.925, 9], [54.925, 35], [42.575, 35], [42.575, 9], [22.425, 9], [22.425, 35], [0, 35]];  // single closed polygon, 20 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
