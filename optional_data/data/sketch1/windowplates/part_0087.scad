$fn = 32;

// ----------------------------------------------------------------------
// Window plate: 70 x 65 mm, 3 open windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 20;      // points of the closed outline

profile = [[0, 3], [0.879, 0.879], [3, 0], [67, 0], [69.121, 0.879], [70, 3], [70, 65], [57.925, 65], [57.925, 35], [47.075, 35], [47.075, 65], [40.425, 65], [40.425, 35], [29.575, 35], [29.575, 65], [22.925, 65], [22.925, 35], [12.075, 35], [12.075, 65], [0, 65]];  // single closed polygon, 20 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
