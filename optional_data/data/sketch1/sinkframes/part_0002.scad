$fn = 32;

// ----------------------------------------------------------------------
// Heat sink frame: 80 x 40 mm frame, 8 mm walls
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 14;      // extrusion height
profile_points = 12;      // points of the closed outline

profile = [[0, 4], [1.172, 1.172], [4, 0], [76, 0], [78.828, 1.172], [80, 4], [80, 40], [72, 40], [72, 12], [8, 12], [8, 40], [0, 40]];  // single closed polygon, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
