$fn = 32;

// ----------------------------------------------------------------------
// Heat sink frame: 100 x 50 mm frame, 6 mm walls
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 18;      // extrusion height
profile_points = 12;      // points of the closed outline

profile = [[0, 4], [1.172, 1.172], [4, 0], [96, 0], [98.828, 1.172], [100, 4], [100, 50], [94, 50], [94, 15], [6, 15], [6, 50], [0, 50]];  // single closed polygon, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
