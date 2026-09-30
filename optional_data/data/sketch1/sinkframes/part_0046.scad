$fn = 32;

// ----------------------------------------------------------------------
// Heat sink frame: 120 x 65 mm frame, 10 mm walls
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 18;      // extrusion height
profile_points = 12;      // points of the closed outline

profile = [[0, 4], [1.172, 1.172], [4, 0], [116, 0], [118.828, 1.172], [120, 4], [120, 65], [110, 65], [110, 12], [10, 12], [10, 65], [0, 65]];  // single closed polygon, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
