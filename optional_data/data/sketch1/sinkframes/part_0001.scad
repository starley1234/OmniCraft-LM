$fn = 32;

// ----------------------------------------------------------------------
// Heat sink frame: 100 x 40 mm frame, 10 mm walls
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 18;      // extrusion height
profile_points = 12;      // points of the closed outline

profile = [[0, 4], [1.172, 1.172], [4, 0], [96, 0], [98.828, 1.172], [100, 4], [100, 40], [90, 40], [90, 10], [10, 10], [10, 40], [0, 40]];  // single closed polygon, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
