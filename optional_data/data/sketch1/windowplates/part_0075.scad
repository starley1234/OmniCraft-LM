$fn = 32;

// ----------------------------------------------------------------------
// Window plate: 70 x 35 mm, 1 open windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 12;      // extrusion height
profile_points = 16;      // points of the closed outline

profile = [[0, 3], [0.879, 0.879], [3, 0], [67, 0], [69.121, 0.879], [70, 3], [70, 35], [40, 35], [40, 29], [45.85, 29], [45.85, 9], [24.15, 9], [24.15, 29], [30, 29], [30, 35], [0, 35]];  // single closed polygon, 16 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
