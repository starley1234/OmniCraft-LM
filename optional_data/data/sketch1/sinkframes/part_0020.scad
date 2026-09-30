$fn = 32;

// ----------------------------------------------------------------------
// Heat sink frame: 120 x 78 mm frame, 8 mm walls
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 18;      // extrusion height
profile_points = 12;      // points of the closed outline

profile = [[0, 4], [1.172, 1.172], [4, 0], [116, 0], [118.828, 1.172], [120, 4], [120, 78], [112, 78], [112, 15], [8, 15], [8, 78], [0, 78]];  // single closed polygon, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
