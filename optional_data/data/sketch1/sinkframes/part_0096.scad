$fn = 32;

// ----------------------------------------------------------------------
// Heat sink frame: 100 x 52 mm frame, 10 mm walls
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 14;      // extrusion height
profile_points = 12;      // points of the closed outline

profile = [[0, 4], [1.172, 1.172], [4, 0], [96, 0], [98.828, 1.172], [100, 4], [100, 52], [90, 52], [90, 15], [10, 15], [10, 52], [0, 52]];  // single closed polygon, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
