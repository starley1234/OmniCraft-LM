$fn = 32;

// ----------------------------------------------------------------------
// Heat sink frame: 60 x 65 mm frame, 8 mm walls
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 12;      // points of the closed outline

profile = [[0, 4], [1.172, 1.172], [4, 0], [56, 0], [58.828, 1.172], [60, 4], [60, 65], [52, 65], [52, 12], [8, 12], [8, 65], [0, 65]];  // single closed polygon, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
