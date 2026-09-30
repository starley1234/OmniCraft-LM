$fn = 32;

// ----------------------------------------------------------------------
// Heat sink frame: 120 x 40 mm frame, 6 mm walls
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 12;      // points of the closed outline

profile = [[0, 4], [1.172, 1.172], [4, 0], [116, 0], [118.828, 1.172], [120, 4], [120, 40], [114, 40], [114, 12], [6, 12], [6, 40], [0, 40]];  // single closed polygon, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
